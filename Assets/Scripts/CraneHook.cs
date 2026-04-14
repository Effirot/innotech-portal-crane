using UnityEngine;
using UnityEngine.InputSystem;
using static UnityEngine.InputSystem.InputAction;

[RequireComponent(typeof(Collider))]
public class CraneHook : MonoBehaviour
{
    [SerializeField]
    private InputActionProperty hookAction;

    [Space]
    [SerializeField]
    private Transform pivot;

    private HookableObject hookedObject;
    private HookableObject selectedHookedObject;

    private void OnEnable()
    {
        hookAction.action.performed += OnClicked_Input;
    }
    private void OnDisable()
    {
        hookAction.action.performed -= OnClicked_Input;
    }
    private void OnTriggerEnter(Collider collider)
    {
        if (collider.TryGetComponent<HookableObject>(out var hookableObject))
        {
            selectedHookedObject = hookableObject; 
        }
    }
    private void OnTriggerExit(Collider collider)
    {
        if (collider.TryGetComponent<HookableObject>(out var hookableObject) && selectedHookedObject == hookableObject)
        {
            selectedHookedObject = null;
        }
    }

    private void LateUpdate()
    {
        if (hookedObject)
        {
            var pivot = this.pivot ? this.pivot : transform;

            hookedObject.GetAnchoredLocalPosition(out var pos, out var rot);
            hookedObject.transform.position = pivot.transform.position - (rot * pos);
            hookedObject.transform.rotation = pivot.transform.rotation * rot;
        }
    }

    private void OnValidate()
    {
        var collider = GetComponent<Collider>();
        collider.isTrigger = true;
    }


    private void OnClicked_Input(CallbackContext context)
    {
        if (hookedObject == null)
        {
            hookedObject = selectedHookedObject;
            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();
        }
        else
        {
            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();
            hookedObject = null;
        }
    }
}
