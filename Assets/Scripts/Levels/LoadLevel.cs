using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class LoadLevel : MonoBehaviour
{
    [SerializeField]
    private UIDocument _document;

    private int _indexLevel;
    public int IndexLevel => _indexLevel;
    private List<Button> _levelButtons;

    public event Action<int> OnLevelSelected;

    private void OnEnable()
    {
        var root = _document.rootVisualElement;
        _levelButtons = root.Query<Button>("ButtonLevel").ToList();

        for (int i=0; i<_levelButtons.Count; i++)
        {
            int index = i;
            _levelButtons[i].clicked += () => SelectLevel(index);
        }
    }

    private void SelectLevel(int index)
    {
        Time.timeScale = 1;

        _indexLevel = index;
        Debug.Log("Level chooce");
        _document.rootVisualElement.Q<VisualElement>("description-list").style.display = DisplayStyle.None;

        OnLevelSelected?.Invoke(index);
    }

    private void OnDisable()
    {
        _levelButtons?.Clear();
    }
}
