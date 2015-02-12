#!/bin/sh
# Copies Unity XML Documentation to the appropriate application directories.

echo "Copying UnityEngine.xml"
cp UnityEngine.xml /Applications/Unity/Unity.app/Contents/Frameworks/Managed
echo "Copying UnityEditor.xml"
cp UnityEditor.xml /Applications/Unity/Unity.app/Contents/Frameworks/Managed

# GUISystem/ should contain a single directory for the current version of Unity (ex, 4.6.1)
for f in /Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/GUISystem/*/ ; do
	if ( echo "$f" | grep '4\.6\.[0-9]/$' > /dev/null ) ; then
		# only works for Unity 4.6.X
		editor="${f}Editor"
		echo "Copying UnityEngine.UI.xml"
		cp UnityEngine.UI.xml $f
		echo "Copying UnityEditor.UI.xml"
		cp UnityEditor.UI.xml $editor
	fi
done

echo "DONE!"