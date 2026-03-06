using UnityEngine;

[CreateAssetMenu(fileName = "Level", menuName = "Scriptable Objects/Level")]
public class Levels : ScriptableObject
{

    [SerializeField, TextArea]
    private string _name;//Уровень 1
    [SerializeField, TextArea]
    private string _description;//доставить 1 груз, далее для слудущего уровня доставить 2 груз и тд
    [SerializeField]
    private Sprite _image;    
}

[System.Serializable]
    public class LevelData
{
    public string Name;//Уровень 1
    public string Description;//доставить 1 груз, далее для слудущего уровня доставить 2 груз и тд
    public Sprite Image;
}