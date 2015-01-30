# Unity IntelliSense Documentation
XML Documentation that enables IntelliSense code hints for the Unity game engine libraries.

<h3>Instructions</h3>
<P>Copy the XML files into your Unity program folder in the following locations:</P>
<P>
UnityEngine.xml and UnityEditor.xml → C:\Program Files (x86)\Unity\Editor\Data\Managed<br/>
UnityEngine.UI.xml → C:\Program Files (x86)\Unity\Editor\Data\UnityExtensions\Unity\GUISystem\4.6.1<br/>
UnityEditor.UI.xml → C:\Program Files (x86)\Unity\Editor\Data\UnityExtensions\Unity\GUISystem\4.6.1\Editor<br/>
</P>
<P>OR</P>
<P>Run the appropriate script file (mac_copyall.sh for Mac users, win_copyall.bat for Windows users) to copy the files from the current directory to the appropriate Unity application directories for you.</P>
<h3>Note for use with VSTU / UnityVS</h3>
<P>If you are using Visual Studio Tools for Unity (formerly UnityVS) then you’ll also need to copy all XML files into the project’s Library/UnityAssemblies subfolder. You’ll need to do this for each project with UnityVS after generating the Visual Studio project files.</P>
<P>You can use the Unity editor script provided in Editor/ImportXmlDocsForUnityVS.cs to make that process a little easier. Copy the Editor folder (containing the script file) into your project's Assets folder and an "XML Docs" menu item will appear. Note that because it is an editor script, it must be located in an Editor subfolder within your Unity project. Click the "XML Docs → Import XML Docs for UnityVS" menu item and it will copy the files from the Unity application directories into the Library/UnityAssemblies subfolder for you.</P>
