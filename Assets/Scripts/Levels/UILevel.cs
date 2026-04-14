using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using UnityEngine.UIElements;

#if UNITY_EDITOR
using UnityEditor;
#endif

public class UILevel : MonoBehaviour
{
    [SerializeField]
    private UIDocument _document;
    [SerializeField]
    private UIDocument _documentCompleteMenu;

    private bool _isMenuOpen = false;
/*#if UNITY_EDITOR
    [SerializeField]
    private SceneAsset SceneAsset;
#endif

    [SerializeField, HideInInspector]
    private string _sceneName;*/

    private void Awake()
    {
        Time.timeScale = 0;

        _documentCompleteMenu.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.None;

        var nextButton = _documentCompleteMenu.rootVisualElement.Q<Button>("ToggleButton");
        if (nextButton != null)
        {
            
            nextButton.clicked += () => {
                Time.timeScale = 1;

                if (SoundManager.Instance != null)
                    SoundManager.Instance.ResumeAllCraneSounds();

                Debug.Log("LoadScene");
                SceneManager.LoadScene(SceneManager.GetActiveScene().name);
            };
        }
    }

/*#if UNITY_EDITOR
    private void OnValidate()
    {
        _sceneName = SceneAsset.name;
    }
#endif*/

    public void UpdateUILevel(string name, string description)
    {
        var root = _document.rootVisualElement;

        var b = root.Q<Label>("LabelDesc");
        b.text = name;

    }

    public void OpenCompeleMenu()
    {
        var root = _documentCompleteMenu.rootVisualElement;
        Debug.Log(_documentCompleteMenu.rootVisualElement.name);
        var menuElement = root.Q<VisualElement>("description-list");
        if (menuElement != null)
        {
            Debug.Log(menuElement.name);

            menuElement.style.display = DisplayStyle.Flex;
            Time.timeScale = 0;

            if (SoundManager.Instance != null)
            {
                SoundManager.Instance.PauseAllCraneSounds();
                SoundManager.Instance?.PlayLevelComplete();
            }
        }

        //_documentCompleteMenu.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.Flex;
    }
}
