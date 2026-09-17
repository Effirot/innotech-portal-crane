using System.Collections;
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

    [SerializeField] private float alignSpeed = 2f;     
    [SerializeField] private float attachAngle = 2f;    

    private bool isAligning = false;

    private HookableObject hookedObject;
    private HookableObject selectedHookedObject;

    private Vector3 initialOffsetPos;
    
    private Quaternion rotationDifference;

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
        if (isAligning) return;

        if (hookedObject)
        {
            var pivotTransform = this.pivot ? this.pivot : transform;

            Vector3 targetPosition = pivotTransform.position + (pivotTransform.rotation * initialOffsetPos);
            hookedObject.transform.position = targetPosition;

            hookedObject.transform.rotation = pivotTransform.rotation * rotationDifference;
        }
    }

    private void OnValidate()
    {
        var collider = GetComponent<Collider>();
        if (collider != null)
            collider.isTrigger = true;
    }

   private void OnClicked_Input(CallbackContext context)
    {
        if (hookedObject == null)
        {
            if (selectedHookedObject == null) return;

            hookedObject = selectedHookedObject;
            StartCoroutine(AlignAndAttach(hookedObject));
        }
        else
        {
            var rb = hookedObject.GetComponent<Rigidbody>();
            if (rb != null)
            {
                rb.linearVelocity = Vector3.zero;
                rb.angularVelocity = Vector3.zero;
            }

            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();

            hookedObject = null;
        }
    }
    private IEnumerator AlignAndAttach(HookableObject target)
    {
        isAligning = true;

        var pivotTransform = this.pivot ? this.pivot : transform;

        while (true)
        {
            if (target == null) yield break;

            float currentY = pivotTransform.eulerAngles.y;
            float targetY = target.transform.eulerAngles.y;

            float newY = Mathf.MoveTowardsAngle(
                currentY,
                targetY,
                alignSpeed * 100f * Time.deltaTime);

            pivotTransform.rotation = Quaternion.Euler(0f, newY, 0f);

            float delta = Mathf.Abs(Mathf.DeltaAngle(newY, targetY));

            if (delta < attachAngle)
                break;

            yield return null;
        }

        Vector3 anchorWorldPosition = target.anchor 
            ? target.anchor.position 
            : target.transform.position;

        Vector3 worldOffset = anchorWorldPosition - pivotTransform.position;
        initialOffsetPos = Quaternion.Inverse(pivotTransform.rotation) * worldOffset;

        rotationDifference =
            Quaternion.Inverse(pivotTransform.rotation) * target.transform.rotation;

        isAligning = false;

        if (SoundManager.Instance != null)
            SoundManager.Instance.PlayHookAttach();
    }
}