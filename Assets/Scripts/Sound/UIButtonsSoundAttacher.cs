using UnityEngine;
using UnityEngine.UIElements;

public class UIButtonsSoundAttacher : MonoBehaviour
{
    private UIDocument _uiDocument;    
    [SerializeField] private string _buttonTag = "Button"; // тег, если используешь

    private void OnEnable()
    {
        _uiDocument = GetComponent<UIDocument>();        

        VisualElement root = null;

        if (_uiDocument != null)
        {
            root = _uiDocument.rootVisualElement;
        }
        else
        {
            // ищем первый UIDocument на этом объекте
            var doc = GetComponent<UIDocument>();
            if (doc != null)
                root = doc.rootVisualElement;
        }

        if (root == null)
        {
            Debug.LogWarning($"[{nameof(UIButtonsSoundAttacher)}] Не найден VisualElement для обработки кнопок.");
            return;
        }

        // Находим все Button
        foreach (var button in root.Query<Button>().ToList())
        {
            button.clicked += OnButtonClicked;
        }

        Debug.Log($"[{nameof(UIButtonsSoundAttacher)}] Назначены звуки на {root.Query<Button>().ToList().Count} кнопок.");
    }

    private void OnButtonClicked()
    {
        SoundManager.Instance?.PlayButtonClick();
    }

    private void OnDisable()
    {
        VisualElement root = null;

        if (_uiDocument != null)
            root = _uiDocument.rootVisualElement;
        else
            root = GetComponent<UIDocument>()?.rootVisualElement;

        if (root == null) return;

        // Отвязываем события со всех кнопок
        foreach (var button in root.Query<Button>().ToList())
        {
            button.clicked -= OnButtonClicked;
        }
    }
}