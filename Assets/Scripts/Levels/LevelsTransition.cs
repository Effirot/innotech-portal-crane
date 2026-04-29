using UnityEngine;
using System;
using System.Collections.Generic;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public class LevelsTransitions: MonoBehaviour
{
    [SerializeField]
    private List<Level> _levelsData = new ();
    [SerializeField] private LoadLevel _loadLevel;

    [SerializeField]
    private List<LevelsPoitsGroup> _levelsPoitsGroups = new ();

    [SerializeField, Range(0, 10)]
    private int _currentLevelIndex = 0;
    private int _pastLevelIndex = 0;

    private FinalDotTrigger _currentTrigger;

    
    [SerializeField]
    private CraneToolController _toolController;

    public event Action<LevelData> OnLevelChanged;
    
    [SerializeField]
    private UILevel _uiLevel;

    private void OnEnable()
    {
        if (_loadLevel != null) _loadLevel.OnLevelSelected += HandLevelSelected;
    }

    private void OnDisable()
    {
        if (_loadLevel != null) _loadLevel.OnLevelSelected -= HandLevelSelected;
    }

    private void Awake()
    {
        Initialize();
    }

    private void Start()
    {
        SoundManager.Instance?.PlayCraneEngine();
        SoundManager.Instance?.PlayOceanAmbience();
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

        _levelsPoitsGroups[_pastLevelIndex].SetActive(false);
        _pastLevelIndex = currentLevelIndex;
        _levelsPoitsGroups[currentLevelIndex].SetActive(true);

        var levelData = _levelsData[currentLevelIndex];

        if (_toolController != null)
        {
            _toolController.SetTool(levelData.ToolType);
        }

        _currentTrigger = _levelsPoitsGroups[currentLevelIndex].GetComponentInChildren<FinalDotTrigger>();

        if (_currentTrigger != null)
        {
            _currentTrigger.OnTriggered.AddListener(CompleteLevel);
        }

        //добавить активацию ui

        Debug.Log(_levelsData[currentLevelIndex].LevelName);
        _uiLevel.UpdateUILevel(levelData.LevelName, levelData.Description);
        Debug.Log(_levelsData[currentLevelIndex].Description);
    }

    private void CompleteLevel()
    {
        if (_currentTrigger != null)
        {
            _currentTrigger.OnTriggered.RemoveListener(CompleteLevel);
        }

        SoundManager.Instance?.StopCraneEngine();
        SoundManager.Instance?.StopCraneRotate();
        SoundManager.Instance?.StopCraneWinch();

        _levelsPoitsGroups[_currentLevelIndex].SetActive(false);        

        _currentLevelIndex++;

        if(_currentLevelIndex >= _levelsData.Count) return;

        SoundManager.Instance?.PlayLevelComplete();  // ← звук завершения

        _uiLevel.OpenCompeleMenu();        

        //ActivateLevel(_currentLevelIndex);        
    }

    private void HandLevelSelected(int index)
    {
        _currentLevelIndex = index;
        ActivateLevel(_currentLevelIndex);
    }
}