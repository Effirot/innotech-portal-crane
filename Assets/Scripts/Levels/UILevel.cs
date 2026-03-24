using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using UnityEngine.UIElements;

public class UILevel : MonoBehaviour
{
    [SerializeField]
    private UIDocument _document;
    [SerializeField]
    private UIDocument _documentCompleteMenu;

    private void Awake()
    {
        Time.timeScale = 0;

        _documentCompleteMenu.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.None;

        var nextButton = _documentCompleteMenu.rootVisualElement.Q<Button>("ToggleButton");
        if (nextButton != null)
        {
            nextButton.clicked += () => {
                Time.timeScale = 1;
                SceneManager.LoadScene(SceneManager.GetActiveScene().name);
            };
        }
    }

    public void UpdateUILevel(string name, string description)
    {
        var root = _document.rootVisualElement;

        var a = root.Q<Label>("LabelName");
        a.text = name;
        var b = root.Q<Label>("LabelDesc");
        b.text = description;

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
        }

        //_documentCompleteMenu.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.Flex;
    }
}
