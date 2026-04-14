using UnityEngine;
using UnityEngine.UIElements.Experimental;

public class SoundManager : MonoBehaviour
{
    public static SoundManager Instance { get; private set; }

    [SerializeField] private AudioSource uiSource;      // UI клики
    [SerializeField] private AudioSource uiCompleteSource;      // UI клики

    [SerializeField] private AudioSource craneSource;      // двигатель
    [SerializeField] private AudioSource craneRotateSource;      // поворот
    [SerializeField] private AudioSource craneWinchSource;      // поднять
    [SerializeField] private AudioSource craneAttachSource;      // взять опустить

    [SerializeField] private AudioSource ambienceSource;   // море

    [Header("UI")]
    public AudioClip _buttonClickClip;
    public AudioClip _levelCompleteClip;

    [Header("Crane")]
    public AudioClip _craneEngineClip;          // постоянно
    public AudioClip _craneRotateClip;         // поворот / скрип металла
    public AudioClip _craneWinchClip;          // подъём/опускание троса
    public AudioClip _hookAttachClip;          // зацепление/отцепление груза

    [Header("Ambience")]
    public AudioClip _oceanAmbienceClip;       // море

    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
            return;
        }

        Instance = this;
        DontDestroyOnLoad(gameObject);

        if (uiSource == null)
            uiSource = gameObject.AddComponent<AudioSource>();

        if(uiCompleteSource == null)
            uiCompleteSource = gameObject.AddComponent<AudioSource>();

        if (craneSource == null)
            craneSource = gameObject.AddComponent<AudioSource>();

        if (uiSource == null)
            uiSource = gameObject.AddComponent<AudioSource>();

        if (craneRotateSource == null)
            craneRotateSource = gameObject.AddComponent<AudioSource>();

        if (craneWinchSource == null)
            craneWinchSource = gameObject.AddComponent<AudioSource>();

        if(craneAttachSource == null)
            craneAttachSource = gameObject.AddComponent<AudioSource>();

        if (ambienceSource == null)
        {
            ambienceSource = gameObject.AddComponent<AudioSource>();
            ambienceSource.loop = true;   // для фонового шума/моря
        }
    }

    public void PlayButtonClick() => PlayClip(uiSource, _buttonClickClip);
    public void PlayLevelComplete() => PlayClip(uiCompleteSource, _levelCompleteClip);
    
    public void PlayCraneEngine() => PlayClip(craneSource, _craneEngineClip, true, volume: 0.3f);
    public void StopCraneEngine() => craneSource.Stop();

    public void PlayCraneRotate() => PlayClip(craneRotateSource, _craneRotateClip, volume: 0.3f);
    public void PlayCraneWinch() => PlayClip(craneWinchSource, _craneWinchClip);
    public void PlayHookAttach() => PlayClip(craneAttachSource, _hookAttachClip, volume: 0.5f);

    public void PlayOceanAmbience() => PlayClip(ambienceSource, _oceanAmbienceClip, loop: true, volume: 0.1f);

    public void StopCraneRotate() => craneRotateSource.Stop();
    public void StopCraneWinch() => craneWinchSource.Stop();
    public void StopOceanAmbience()  => ambienceSource.Stop();

    public void PauseAllCraneSounds()
    {
        craneSource.Pause();
        craneRotateSource.Pause();
        craneWinchSource.Pause();
    }

    public void ResumeAllCraneSounds()
    {
        craneSource.UnPause();
        craneRotateSource.UnPause();
        craneWinchSource.UnPause();
    }

    private void PlayClip(AudioSource src, AudioClip clip, bool loop = false, float volume = 1f)
    {
        if (clip == null || src == null) return;

        src.clip = clip;
        src.loop = loop;
        src.volume = volume;

        src.Play();
    }
}