using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UIElements;

public class CloseMenu : MonoBehaviour
{
    [SerializeField]
    private UIDocument _document;
    [SerializeField]
    private GameObject _documentObj;

    private Button _closeButton;

    private void OnEnable()
    {
        var root = _document.rootVisualElement;

        _closeButton = root.Q<Button>("ToggleButton");

        if(_closeButton != null)
        {
            _closeButton.clicked += ToggleMenuClose;
        }
    }    


    private void OnDisable()
    {
        if (_closeButton != null)
        {
            _closeButton.clicked -= ToggleMenuClose;
        }
    }

    private void ToggleMenuClose()
    {        
        if(_document.rootVisualElement.Q<VisualElement>("description-list").style.display == DisplayStyle.None)
        {
            _document.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.Flex;
            Time.timeScale = 0;
        }
        else
        {
            _document.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.None;
            Time.timeScale = 1;
        }

        

    }
}
