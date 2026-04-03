using UnityEngine;
using UnityEngine.UIElements;
using UnityEngine.SceneManagement;

public class MenuController : MonoBehaviour
{
    [SerializeField] private int sceneIndex = 1; // индекс сцены для загрузки

    private void OnEnable()
    {
        var root = GetComponent<UIDocument>().rootVisualElement;

        // Кнопка "Продолжить" (Level Complete)
        var continueBtn = root.Q<Button>("ToggleButton");
        if (continueBtn != null)
        {
            continueBtn.clicked += LoadScene;
        }

        // Кнопка "Start"
        var startBtn = root.Q<Button>("btn-start");
        if (startBtn != null)
        {
            startBtn.clicked += LoadScene;
        }

        // Кнопка "Quit"
        var quitBtn = root.Q<Button>("btn-quit");
        if (quitBtn != null)
        {
            quitBtn.clicked += QuitGame;
        }
    }

    private void LoadScene()
    {
        SceneManager.LoadScene(sceneIndex);
    }

    private void QuitGame()
    {
        Debug.Log("Выход из игры");

        Application.Quit();

#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
#endif
    }
}