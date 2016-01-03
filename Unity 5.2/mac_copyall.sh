#!/bin/sh
# Copies Unity XML Documentation to the appropriate application directories.

echo "Copying UnityEngine.xml"
cp UnityEngine.xml /Applications/Unity/Unity.app/Contents/Frameworks/Managed
echo "Copying UnityEditor.xml"
cp UnityEditor.xml /Applications/Unity/Unity.app/Contents/Frameworks/Managed
echo "Copying UnityEngine.UI.xml"
cp UnityEngine.UI.xml /Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/GUISystem
echo "Copying UnityEditor.UI.xml"
cp UnityEditor.UI.xml /Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/GUISystem/Editor
echo "Copying UnityEngine.Advertisements.xml"
cp UnityEngine.Advertisements.xml /Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/Advertisements
echo "Copying UnityEngine.Analytics.xml"
cp UnityEngine.Analytics.xml /Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnityAnalytics
echo "Copying UnityEngine.Networking.xml"
cp UnityEngine.Networking.xml /Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/Networking

echo "DONE!"