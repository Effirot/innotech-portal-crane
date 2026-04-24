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

    // Поля для хранения начального смещения относительно крюка
    private Vector3 initialOffsetPos;
    private Quaternion initialOffsetRot;

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
            var pivotTransform = this.pivot ? this.pivot : transform;

            // Используем зафиксированные начальные значения для расчета позиции
            // Это предотвращает дрожание, так как мы не зависим от текущего вращения объекта
            hookedObject.transform.position = pivotTransform.position - (initialOffsetRot * initialOffsetPos);
            
            // Если нужно, чтобы объект вообще не вращался относительно крюка:
            hookedObject.transform.rotation = pivotTransform.rotation * initialOffsetRot;
            
            // Если нужно "слегка" вращение (физика), можно закомментировать строку выше, 
            // но тогда позиция все равно должна считаться по фиксированным данным, 
            // либо использовать Joint (см. Вариант 2).
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
            hookedObject = selectedHookedObject;
            if (hookedObject != null)
            {
                var pivotTransform = this.pivot ? this.pivot : transform;
                
                // Запоминаем начальное смещение в момент захвата
                hookedObject.GetAnchoredLocalPosition(out initialOffsetPos, out initialOffsetRot);
            }

            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();
        }
        else
        {
            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();
            
            // Сброс скоростей при отпускании, чтобы объект не "улетал"
            var rb = hookedObject.GetComponent<Rigidbody>();
            if (rb != null)
            {
                rb.linearVelocity = Vector3.zero;
                rb.angularVelocity = Vector3.zero;
            }

            hookedObject = null;
        }
    }
}