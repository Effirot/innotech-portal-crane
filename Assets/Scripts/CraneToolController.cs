using UnityEngine;

public class CraneToolController : MonoBehaviour
{
    [SerializeField] private GameObject spereder;
    [SerializeField] private GameObject magnet;

    public void SetTool(CraneToolType type)
    {
        spereder.SetActive(type == CraneToolType.Spereder);
        magnet.SetActive(type == CraneToolType.Magnet);
    }
}