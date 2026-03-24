// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using Boxophobic.Utils;
using System.IO;

namespace TheVegetationEngineElements
{
    public class TVETEHub : EditorWindow
    {
        string assetFolder = "Assets/BOXOPHOBIC/The Vegetation Engine Modules/Terrain Elements";

        int assetVersion;
        string bannerVersion;

        Color bannerColor;
        string bannerText;
        static TVETEHub window;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Elements/Hub", false, 1009)]
        public static void ShowWindow()
        {
            window = GetWindow<TVETEHub>(false, "Terrain Elements Module", true);
            window.minSize = new Vector2(300, 200);
        }

        void OnEnable()
        {
            //Safer search, there might be many user folders
            string[] searchFolders;

            searchFolders = AssetDatabase.FindAssets("Terrain Elements");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("Terrain Elements.pdf"))
                {
                    assetFolder = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                    assetFolder = assetFolder.Replace("/Terrain Elements.pdf", "");
                }
            }

            assetVersion = SettingsUtils.LoadSettingsData(assetFolder + "/Core/Editor/Version.asset", -99);
            bannerVersion = assetVersion.ToString();
            bannerVersion = bannerVersion.Insert(1, ".");
            bannerVersion = bannerVersion.Insert(3, ".");

            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Terrain Elements Module " + bannerVersion;
        }

        void OnGUI()
        {
            DrawToolbar();

            StyledGUI.DrawWindowBanner(bannerColor, bannerText);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            if (File.Exists(assetFolder + "/Core/Editor/TVETEHubAutoRun.cs"))
            {
                EditorGUILayout.HelpBox("Welcome to the Terrain Elements Module for the Vegetation Engine! Press Install to set up the asset!", MessageType.Info, true);

                GUILayout.Space(15);

                if (GUILayout.Button("Install", GUILayout.Height(24)))
                {
                    InstallAsset();
                }
            }
            else
            {
                EditorGUILayout.HelpBox("The included element shaders are compatible by default with all render pipelines!", MessageType.Info, true);

                GUILayout.Space(15);

                if (GUILayout.Button("Select Demo Scene", GUILayout.Height(24)))
                {
                    EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<Object>(assetFolder + "/Demo/Demo Elements.unity"));
                }
            }

            GUILayout.EndVertical();

            GUILayout.Space(13);
            GUILayout.EndHorizontal();
        }

        void DrawToolbar()
        {
            var GUI_TOOLBAR_EDITOR_WIDTH = this.position.width / 4.0f + 1;

            var styledToolbar = new GUIStyle(EditorStyles.toolbarButton)
            {
                alignment = TextAnchor.MiddleCenter,
                fontStyle = FontStyle.Normal,
                fontSize = 11,
            };

            GUILayout.Space(1);
            GUILayout.BeginHorizontal();

            if (GUILayout.Button("Discord Server", styledToolbar, GUILayout.Width(GUI_TOOLBAR_EDITOR_WIDTH)))
            {
                Application.OpenURL("https://discord.com/invite/znxuXET");
            }
            GUILayout.Space(-1);

            if (GUILayout.Button("Documentation", styledToolbar, GUILayout.Width(GUI_TOOLBAR_EDITOR_WIDTH)))
            {
                Application.OpenURL("https://docs.google.com/document/d/1pL8HNBUT3pKV4qkMF5bqh192Oi7xR-fSkvoj_AUj5FM/edit#");
            }
            GUILayout.Space(-1);

            if (GUILayout.Button("Changelog", styledToolbar, GUILayout.Width(GUI_TOOLBAR_EDITOR_WIDTH)))
            {
                Application.OpenURL("https://docs.google.com/document/d/1pL8HNBUT3pKV4qkMF5bqh192Oi7xR-fSkvoj_AUj5FM/edit#heading=h.1rbujejuzjce");
            }
            GUILayout.Space(-1);

            if (GUILayout.Button("Write A Review", styledToolbar, GUILayout.Width(GUI_TOOLBAR_EDITOR_WIDTH)))
            {
                Application.OpenURL("https://assetstore.unity.com/packages/vfx/shaders/the-vegetation-engine-terrain-elements-module-181731#reviews");
            }
            GUILayout.Space(-1);

            GUILayout.EndHorizontal();
            GUILayout.Space(4);
        }

        void InstallAsset()
        {
            FileUtil.DeleteFileOrDirectory(assetFolder + "/Core/Editor/TVETEHubAutorun.cs");

            if (File.Exists(assetFolder + "/Core/Editor/TVETEHubAutoRun.cs.meta"))
            {
                FileUtil.DeleteFileOrDirectory(assetFolder + "/Core/Editor/TVETEHubAutorun.cs.meta");
            }

            AssetDatabase.Refresh();

            SetDefineSymbols();

            GUIUtility.ExitGUI();
        }

        void SetDefineSymbols()
        {
            var defineSymbols = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);

            if (!defineSymbols.Contains("THE_VEGETATION_ENGINE_ELEMENTS"))
            {
                defineSymbols += ";THE_VEGETATION_ENGINE_ELEMENTS;";
            }

            PlayerSettings.SetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup, defineSymbols);
        }
    }
}


