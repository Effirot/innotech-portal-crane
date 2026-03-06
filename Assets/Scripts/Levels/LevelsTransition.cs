using UnityEngine;
using System;
using System.Collections.Generic;
using UnityEngine.Events;

public class LevelsTransitions: MonoBehaviour
{
    [SerializeField]
    private List<Level> _levelsData = new ();

    [SerializeField]
    private List<LevelsPoitsGroup> _levelsPoitsGroups = new ();

    [SerializeField, Range(0, 10)]
    private int _currentLevelIndex = 0;

    private FinalDotTrigger _currentTrigger;

    public event Action<LevelData> OnLevelChanged;

    private void Awake()
    {
        Initialize();
    }

    /// <summary>
    /// отключение всех групп точек
    /// влючение уровня с определением по индексу
    /// </summary>
    private void Initialize()
    {
        foreach(var group in _levelsPoitsGroups)
        {
            group.SetActive(false);
        }

        ActivateLevel(_currentLevelIndex);
    }

    private void ActivateLevel(int currentLevelIndex)
    {
        if(currentLevelIndex >= _levelsPoitsGroups.Count || currentLevelIndex >= _levelsData.Count) return;

        _levelsPoitsGroups[currentLevelIndex].SetActive(true);

        _currentTrigger = _levelsPoitsGroups[currentLevelIndex].GetComponentInChildren<FinalDotTrigger>();

        if (_currentTrigger != null)
        {
            _currentTrigger.OnTriggered.AddListener(CompleteLevel);
        }

        //добавить активацию ui

        Debug.Log(_levelsData[currentLevelIndex].LevelName);
        Debug.Log(_levelsData[currentLevelIndex].Description);
    }

    private void CompleteLevel()
    {
        if (_currentTrigger != null)
        {
            _currentTrigger.OnTriggered.RemoveListener(CompleteLevel);
        }

        _levelsPoitsGroups[_currentLevelIndex].SetActive(false);        

        _currentLevelIndex++;

        if(_currentLevelIndex >= _levelsData.Count) return;

        ActivateLevel(_currentLevelIndex);        
    }
}