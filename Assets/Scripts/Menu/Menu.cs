using UnityEngine;
using UnityEngine.SceneManagement;

public class Menu : MonoBehaviour
{
    public void ExitProgram()
    {
        Application.Quit();
    }

    public void OpenSceneByName(string sceneName)
    {
        SceneManager.LoadScene(sceneName);
    }
}
