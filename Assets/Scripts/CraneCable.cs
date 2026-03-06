using Unity.Cinemachine;
using UnityEngine;
using UnityEngine.InputSystem;

[RequireComponent(typeof(ConfigurableJoint))]
public class CraneCable : MonoBehaviour
{
    [SerializeField]
    private InputActionProperty action;

    [Space]
    [SerializeField, Vector2AsRange]
    private Vector2 minMaxDistance; 
    [SerializeField]
    private float speed = 0.1f; 

    private ConfigurableJoint joint;

    private void Awake()
    {
        joint = GetComponent<ConfigurableJoint>();
    }
    private void FixedUpdate()
    {
        var input = action.action.ReadValue<float>() * speed * Time.fixedDeltaTime;

        var limitValue = joint.linearLimit;
        limitValue.limit = Mathf.Clamp(limitValue.limit + input, minMaxDistance.x, minMaxDistance.y);
        joint.linearLimit = limitValue;
    }
}
