using UnityEngine;

[CreateAssetMenu(fileName = "Level", menuName = "Scriptable Objects/Level")]
public class Level : ScriptableObject
{
    [SerializeField, TextArea]
    private string _levelName;//Уровень 1
    [SerializeField, TextArea(3, 20)]
    private string _description;//доставить 1 груз, далее для слудущего уровня доставить 2 груз и тд
    [SerializeField]
    private Sprite _image;

    public string LevelName => _levelName;
    public string Description => _description;
    public Sprite Image => _image;
}
