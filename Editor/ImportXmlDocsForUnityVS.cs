using UnityEngine;
using UnityEditor;
using System.Collections;
using System;
using System.IO;
using System.Text.RegularExpressions;

/// <summary>
/// Adds an XML Docs menu item in Unity with a menu item to copy XML docs from the Unity application folder to the current project to enable IntelliSense for UnityVS
/// </summary>
public static class ImportXmlDocsForUnityVS
{
    [MenuItem("XML Docs/Import XML Docs for UnityVS")]
    public static void ImportXmlDocs()
    {
        string baseSourcePath = EditorApplication.applicationContentsPath;    // ex C:/Program Files (x86)/Unity/Editor/Data
        string appDataPath = Application.dataPath;
        string baseDestPath = null;
        string unityVersion = getBaseUnityVersion();

        if (!checkUnityVersion(unityVersion))
            return;

        if (!appDataPath.EndsWith("Assets"))
        {
            Debug.LogError("Application.dataPath did not return the expected Assets path. Copy failed.");
            return;
        }

        baseDestPath = Path.Combine(appDataPath.Substring(0, appDataPath.Length - "Assets".Length), @"Library/UnityAssemblies");
        if (!Directory.Exists(baseDestPath))
        {
            Debug.LogError("UnityAssemblies path not found. Are you sure UnityVS has been added to this project?");
            return;
        }
        Debug.Log("Destination folder will be: " + baseDestPath);

#if UNITY_EDITOR_OSX
		string managedPath = Path.Combine(baseSourcePath, "Frameworks/Managed");
#else
		string managedPath = Path.Combine(baseSourcePath, "Managed");
#endif
		copyFile(managedPath, @"UnityEngine.xml", baseDestPath);
		copyFile(managedPath, @"UnityEditor.xml", baseDestPath);

        string guiBaseFolder = Path.Combine(baseSourcePath, @"UnityExtensions/Unity/GUISystem");
        string versionedGuiBaseFolder = Path.Combine(guiBaseFolder, unityVersion);

        if (Directory.Exists(versionedGuiBaseFolder)) // Unity 4.6.X
        {
            copyFile(versionedGuiBaseFolder, @"UnityEngine.UI.xml", baseDestPath);
            copyFile(versionedGuiBaseFolder, @"Editor/UnityEditor.UI.xml", baseDestPath);
        }
        else if (Directory.Exists(guiBaseFolder) && unityVersion.StartsWith("5.")) // Unity 5 (beta) uses the base folder instead of a version number folder
        {
            copyFile(guiBaseFolder, @"UnityEngine.UI.xml", baseDestPath);
            copyFile(guiBaseFolder, @"Editor/UnityEditor.UI.xml", baseDestPath);
        }
        else
            Debug.LogWarning("No GUI library folder found");
    }

    private static void copyFile(string sourceBaseFolder, string sourceFile, string destinationFolder)
    {
        string sourceFilePath = Path.Combine(sourceBaseFolder, sourceFile);
        string justFilename = Path.GetFileName(sourceFilePath);
        string destFilePath = Path.Combine(destinationFolder, justFilename);
        Debug.Log("Copying " + sourceFilePath);
        File.Copy(sourceFilePath, destFilePath, overwrite: true);
    }

    /// <summary>
    /// Return true if Unity version is 4.6 or higher, otherwise returns false.
    /// </summary>
    /// <param name="unityVersion"></param>
    /// <returns></returns>
    private static bool checkUnityVersion(string unityVersion)
    {
        Version unityVerionStruct = new Version(unityVersion);
        if (unityVerionStruct.Major < 4)
        {
            Debug.LogError("Only Unity 4.6+ is supported");
            return false;
        }
        else if (unityVerionStruct.Major == 4)
        {
            if (unityVerionStruct.Minor < 6)
            {
                Debug.LogError("Only Unity 4.6+ is supported");
                return false;
            }
        }
        return true;
    }

    /// <summary>
    /// Gets the base verison of Unity. For example if Application.unityVersion return 4.6.1p5 this will strip it down to just 4.6.1.
    /// </summary>
    /// <returns>The base version of unity</returns>
    private static string getBaseUnityVersion()
    {
        string fullVersion = Application.unityVersion;
        var re = new Regex(@"^[0-9\.]+");
        var m = re.Match(fullVersion);
        if (m.Success)
            return m.ToString();
        else
            throw new InvalidOperationException("Failed to parse version number: " + Application.unityVersion);
    }
}
