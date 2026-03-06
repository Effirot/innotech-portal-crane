using UnityEngine;
using UnityEngine.Events;

public class OnTriggerEvents : MonoBehaviour
{
    [SerializeField]
    private string requireTag;

    [SerializeField]
    private UnityEvent<Collider> onTriggerEnter = new();
    [SerializeField]
    private UnityEvent<Collider> onTriggerExit = new();

    private void OnTriggerEnter(Collider collider)
    {
        if (requireTag == collider.tag || requireTag == collider.attachedRigidbody.tag || string.IsNullOrWhiteSpace(requireTag))
            onTriggerEnter.Invoke(collider);
    }
    private void OnTriggerExit(Collider collider)
    {
        if (requireTag == collider.tag || requireTag == collider.attachedRigidbody.tag || string.IsNullOrWhiteSpace(requireTag))
            onTriggerExit.Invoke(collider);
    }
}
