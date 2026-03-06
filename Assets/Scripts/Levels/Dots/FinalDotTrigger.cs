using UnityEngine;
using System;
using UnityEngine.Events;


[RequireComponent(typeof(Collider))]
public class FinalDotTrigger: MonoBehaviour
{
    [SerializeField]
    private string _tagObject = "Cargo";

    public UnityEvent OnTriggered;

    private void OnTriggerEnter(Collider other)
    {
        if(!other.CompareTag(_tagObject)) return;

        OnTriggered?.Invoke();
    }
}