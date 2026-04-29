using UnityEngine;

public enum CraneToolType
{
    Spereder,
    Magnet
}

[CreateAssetMenu(fileName = "Level", menuName = "Scriptable Objects/Level")]
public class Level : ScriptableObject
{
    [SerializeField, TextArea]
    private string _levelName;//������� 1
    [SerializeField, TextArea(3, 20)]
    private string _description;//��������� 1 ����, ����� ��� ��������� ������ ��������� 2 ���� � ��
    [SerializeField]
    private Sprite _image;

    [SerializeField]
    private CraneToolType _toolType;

    public string LevelName => _levelName;
    public string Description => _description;
    public Sprite Image => _image;

    public CraneToolType ToolType => _toolType;
}
