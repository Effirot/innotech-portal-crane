using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UIElements;

public class LevelTransition : MonoBehaviour
{
    [SerializeField] 
    private VEPtr<Button> level1Button;  
    [SerializeField]
    private VEPtr<Button> level2Button; 
    [SerializeField]
    private VEPtr<Button> level3Button; 
    [SerializeField]
    private VEPtr<Button> level4Button; 
    [SerializeField]
    private VEPtr<Button> level5Button; 
    [SerializeField]
    private VEPtr<Button> level6Button; 
    [SerializeField]
    private VEPtr<Button> level7Button; 
    [SerializeField]
    private VEPtr<Button> level8Button; 


    private void Start()
    {
        if (level1Button.element != null)
            level1Button.element.clicked += () => LoadLevel(1);
        if (level2Button.element != null)
            level2Button.element.clicked += () => LoadLevel(2);
        if (level3Button.element != null)
            level3Button.element.clicked += () => LoadLevel(3);
        if (level4Button.element != null)
            level4Button.element.clicked += () => LoadLevel(4);
        if (level5Button.element != null)
            level5Button.element.clicked += () => LoadLevel(5);
        if (level6Button.element != null)
            level6Button.element.clicked += () => LoadLevel(6);
        if (level7Button.element != null)
            level7Button.element.clicked += () => LoadLevel(7);
        if (level8Button.element != null)
            level8Button.element.clicked += () => LoadLevel(8);
    }

    private void LoadLevel(int levelNumber)
    {
        Debug.Log($"Загружаем уровень {levelNumber}");
        SceneManager.LoadScene($"Level_{levelNumber}");  
    }
}
