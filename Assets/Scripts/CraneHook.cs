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

    // Смещение позиции (вектор от пивота до якоря в локальных координатах пивота)
    private Vector3 initialOffsetPos;
    
    // Разница во вращении между объектом и пивотом в момент захвата
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
        if (hookedObject)
        {
            var pivotTransform = this.pivot ? this.pivot : transform;

            // 1. Расчет позиции
            // Позиция пивота + (смещение, повернутое на текущий угол пивота)
            // Это гарантирует, что точка захвата (anchor) всегда находится точно под/на крюке
            Vector3 targetPosition = pivotTransform.position + (pivotTransform.rotation * initialOffsetPos);
            hookedObject.transform.position = targetPosition;

            // 2. Расчет вращения
            // Текущее вращение пивота * разницу, сохраненную при захвате
            // Это заставляет объект вращаться синхронно с крюком
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
            hookedObject = selectedHookedObject;
            if (hookedObject != null)
            {
                var pivotTransform = this.pivot ? this.pivot : transform;
                
                // --- РАСЧЕТ ПОЗИЦИИ ---
                // Нам нужно знать вектор от Пивота (крюка) до Якоря (точки на контейнере) в момент захвата.
                Vector3 anchorWorldPosition = hookedObject.anchor ? hookedObject.anchor.position : hookedObject.transform.position;
                Vector3 worldOffset = anchorWorldPosition - pivotTransform.position;
                
                // Переводим этот вектор в локальную систему координат пивота.
                // Теперь, когда пивот будет вращаться, мы сможем повернуть этот локальный вектор обратно в мировой,
                // и он всегда будет указывать на правильное место относительно крюка.
                initialOffsetPos = Quaternion.Inverse(pivotTransform.rotation) * worldOffset;

                // --- РАСЧЕТ ВРАЩЕНИЯ ---
                // Сохраняем "разницу" между вращением объекта и вращением пивота.
                // Формула: RotationObject = RotationPivot * Difference
                // Следовательно: Difference = Inverse(RotationPivot) * RotationObject
                rotationDifference = Quaternion.Inverse(pivotTransform.rotation) * hookedObject.transform.rotation;
            }

            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();
        }
        else
        {
            if (SoundManager.Instance != null)
                SoundManager.Instance.PlayHookAttach();
            
            // Сброс скоростей при отпускании
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