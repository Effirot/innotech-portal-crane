using System;
using UnityEngine;
using UnityEngine.InputSystem;

public class HookController : MonoBehaviour
{    
    [SerializeField]
    private Transform _hook;
    [SerializeField, Range(-10f, 10f)]
    private float _distanceCargo = 5f;

    [Space(10)]
    [SerializeField]
    private InputActionReference _interactAction;
    [SerializeField]
    private InputActionReference _dropAction;

    private float _hookMass;
    private float _cargoMass;
    
    private Transform _cargo;
    private Transform _availableCargo;

    private bool _isAttached = false;

    private void OnEnable()
    {
        if (_interactAction != null)
        {
            _interactAction.action.Enable();
            _interactAction.action.performed += OnInteractPerformed;
        }
        if (_dropAction != null)
        {
            _dropAction.action.Enable();
            _dropAction.action.performed += OnDropPerformed;
        }
    }

    private void OnDisable()
    {
        if (_interactAction != null)
        {
            _interactAction.action.performed -= OnInteractPerformed;
            _interactAction.action.Disable();
        }
        if (_dropAction != null)
        {
            _dropAction.action.performed -= OnDropPerformed;
            _dropAction.action.Disable();
        }
    }

    private void OnInteractPerformed(InputAction.CallbackContext ctx)
    {
        if (!_isAttached && _availableCargo != null)
        {
            AttachCargo(_availableCargo, _hook);
        }
    }

    private void OnDropPerformed(InputAction.CallbackContext ctx)
    {        
        if (_isAttached)
        {
            DetachCargo(_cargo, _hook);
        }
    }    

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == "Cargo" && !_isAttached)
        {
            Debug.Log("Press E to pick up cargo");
            _availableCargo = other.transform;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Cargo" && other.transform == _availableCargo)
        {
            Debug.Log("Out of range");
            _availableCargo = null;
        }
    }

    //исправить смещение объекта Cargo,
    //когда прикреплен к крюку, Cargo проходит через объект пола. как исправить:
    //варинты расчет размера объекта, но это странно

    private void AttachCargo(Transform cargo, Transform hook)
    {
        _isAttached = true;
        _cargo = cargo;
        _availableCargo = null;

        Debug.Log("Attach Cargo: " + _cargo.name);
        
        var cargoLayer = cargo.gameObject.layer;
        cargo.gameObject.layer = LayerMask.NameToLayer("Ignore Raycast");

        cargo.SetParent(hook);
        Debug.Log(hook.name);
        cargo.localPosition = Vector3.zero + new Vector3(0, -_distanceCargo, 0);
        cargo.localRotation = Quaternion.identity;
        
        Rigidbody hookRb = hook.GetComponent<Rigidbody>();
        Rigidbody cargoRb = cargo.GetComponent<Rigidbody>();

        Collider cargoCollider = cargo.GetComponent<Collider>();
        if (cargoRb != null && cargoCollider != null)
        {
            cargoRb.constraints = RigidbodyConstraints.FreezeRotation;
            _hookMass = hookRb.mass;
            _cargoMass = cargoRb.mass;
            hookRb.mass = cargoRb.mass;
            cargoRb.mass = 0;
            cargoRb.isKinematic = true;            
        }        

        Debug.Log("Cargo attached: " + cargo.name);
    }

    private void DetachCargo(Transform cargo, Transform hook)
    {
        if (cargo == null) return;

        cargo.SetParent(null);
        Rigidbody hookRb = hook.GetComponent<Rigidbody>();
        Rigidbody cargoRb = cargo.GetComponent<Rigidbody>();

        Collider cargoCollider = cargo.GetComponent<Collider>();
        if (cargoRb != null)
        {
            cargoRb.constraints = RigidbodyConstraints.None;
            hookRb.mass = _hookMass;            
            cargoRb.mass = _cargoMass;
            cargoRb.isKinematic = false;            
        }

        _isAttached = false;
        _cargo = null;
        Debug.Log("Cargo detached: " + cargo.name);
    }
}
