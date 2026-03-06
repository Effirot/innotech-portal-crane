using UnityEngine;

public class HookableObject : MonoBehaviour
{
    public Transform anchor;

    public void GetAnchoredLocalPosition(out Vector3 position, out Quaternion rotation)
    {
        if (this.anchor)
        {
            position = this.anchor.localPosition;
            rotation = this.anchor.localRotation;
        }
        else
        {
            position = Vector3.zero; 
            rotation = Quaternion.identity; 
        }
    }

    private void OnValidate()
    {
        if (anchor && anchor.parent != this)
        {
            anchor.SetParent(transform, true);
        }
    } 
}
