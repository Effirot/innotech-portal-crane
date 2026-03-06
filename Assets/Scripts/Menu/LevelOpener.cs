using UnityEngine;
using UnityEngine.UIElements;

public class LevelOpener : MonoBehaviour
{
    [SerializeField] private VEPtr<Label> levelNumberLabel;  // Путь к Label номера уровня
    [SerializeField] private VEPtr<Label> levelNameLabel;    // Путь к Label названия
    
    [SerializeField] private int currentLevel = 1;           // ← ЭТО ПОЛЯ ДЛЯ BINDING
    [SerializeField] private string levelName = "Уровень 1"; // ← ЭТО ПОЛЯ ДЛЯ BINDING
    [SerializeField] private bool isLevelUnlocked = true;
    
    private void Start()
    {
        var doc = GetComponent<UIDocument>();
        doc.rootVisualElement.dataSource = this;  // Привязываем этот скрипт как DataSource
    }
    
    public void SetLevel(int levelNum)
    {
        currentLevel = levelNum;
        levelName = $"Уровень {levelNum}";
        isLevelUnlocked = true;
        Debug.Log($"Установлен уровень {levelNum}");
    }
}
