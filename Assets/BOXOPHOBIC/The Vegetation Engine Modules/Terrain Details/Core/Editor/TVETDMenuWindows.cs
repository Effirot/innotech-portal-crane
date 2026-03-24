using UnityEditor;
using UnityEngine;

namespace TheVegetationEngineDetails
{
    public static class TVETDMenuWindows
    {
        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Details/Discord Server", false, 8000)]
        public static void Discord()
        {
            Application.OpenURL("https://discord.com/invite/znxuXET");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Details/Publisher Page", false, 8001)]
        public static void AssetStore()
        {
            Application.OpenURL("https://assetstore.unity.com/publishers/20529");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Details/Documentation", false, 8002)]
        public static void Documentation()
        {
            Application.OpenURL("https://docs.google.com/document/d/1wx2nLltPmkyZBl5qOGPfn9t5IMyOJ_aUHZqN1dIRJAU/edit?usp=sharing");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Details/Changelog", false, 8003)]
        public static void Chnagelog()
        {
            Application.OpenURL("https://docs.google.com/document/d/1wx2nLltPmkyZBl5qOGPfn9t5IMyOJ_aUHZqN1dIRJAU/edit#heading=h.1rbujejuzjce");
        }

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine | Terrain Details/Write A Review", false, 9999)]
        public static void WriteAReview()
        {
            Application.OpenURL("https://assetstore.unity.com/packages/vfx/shaders/the-vegetation-engine-terrain-details-add-on-beta-178485#reviews");
        }
    }
}


