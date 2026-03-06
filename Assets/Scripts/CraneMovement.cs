using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Splines;

public class CraneMovement : MonoBehaviour
{
    [SerializeField]
    private InputActionProperty movementAction;
    
    [Space]
    [SerializeField]
    private SplineContainer spline;
    [SerializeField]
    private Transform torquePoint;
    [SerializeField, Range(0, 1)]
    private float blend = 0.5f;
    [SerializeField, Range(-180, 180)]
    private float angle;

    [Space]
    [Space]
    [SerializeField, Range(0, 0.3f)]
    private float positionBlendingSpeed = 0.01f;
    [SerializeField, Range(0, 100)]
    private float positionBlendingDamping = 10;

    [Space]
    [SerializeField, Range(0, 0.3f)]
    private float rotationBlendingSpeed = 0.01f;
    [SerializeField, Range(0, 100)]
    private float rotationBlendingDamping = 10;


    private float movementSpeedBleending;
    private float torqueSpeedBleending;

    private void Awake()
    {
        movementAction.action.Enable();
    }

    private void FixedUpdate()
    {
        var movementAxis = movementAction.action.ReadValue<Vector2>();
        movementAxis.y /= spline[0].GetLength();

        torqueSpeedBleending = Mathf.Lerp(torqueSpeedBleending, movementAxis.x * rotationBlendingSpeed, rotationBlendingDamping * Time.fixedDeltaTime);
        angle += torqueSpeedBleending;

        movementSpeedBleending = Mathf.Lerp(movementSpeedBleending, movementAxis.y * positionBlendingSpeed, Time.fixedDeltaTime * positionBlendingDamping);
        blend = Mathf.Clamp01(blend + movementSpeedBleending);
    }
    private void Update()
    {
        spline[0].Evaluate(blend, 
            out var position, 
            out var tangent, 
            out var up);

        position = spline.transform.TransformPoint(position);
        tangent = spline.transform.TransformDirection(tangent);
        up = spline.transform.TransformDirection(up);

        transform.position = position;
        transform.rotation = Quaternion.LookRotation(tangent, up);

        torquePoint.localEulerAngles = new (0, angle, 0);
    }
    private void OnValidate()
    {
        if (spline)
        {
            Update();
        }
    }
}
