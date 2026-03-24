using UnityEditor;
using UnityEngine;

namespace TheVegetationEngineElements
{
    public static class TVETEMenuWindows
    {
        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Elements/Discord Server", false, 8000)]
        public static void Discord()
        {
            Application.OpenURL("https://discord.com/invite/znxuXET");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Elements/Publisher Page", false, 8001)]
        public static void AssetStore()
        {
            Application.OpenURL("https://assetstore.unity.com/publishers/20529");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Elements/Documentation", false, 8002)]
        public static void Documentation()
        {
            Application.OpenURL("https://docs.google.com/document/d/1pL8HNBUT3pKV4qkMF5bqh192Oi7xR-fSkvoj_AUj5FM/edit#");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Elements/Changelog", false, 8003)]
        public static void Chnagelog()
        {
            Application.OpenURL("https://docs.google.com/document/d/1pL8HNBUT3pKV4qkMF5bqh192Oi7xR-fSkvoj_AUj5FM/edit#heading=h.1rbujejuzjce");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Elements/Write A Review", false, 9999)]
        public static void WriteAReview()
        {
            Application.OpenURL("https://assetstore.unity.com/packages/vfx/shaders/the-vegetation-engine-terrain-elements-module-181731#reviews");
        }
    }
}


