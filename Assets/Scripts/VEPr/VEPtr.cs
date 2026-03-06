

using System;
using UnityEngine.UIElements;

[Serializable]
public struct VEPtr<T> where T : VisualElement
{
    public const string emptyPath = "<none>";
    public const string rootPath = "<root>";

    public UIDocument document;
    public string path;

    public T element
    {
        get {
            if (document == null || !document.isActiveAndEnabled)
                return null;
            if (path == emptyPath)
                return null;
            // if (path = rootPath)
            //     return document.rootVisualElement;

            return Q();
        }
    }
    
    private T Q()
    {
        var currentElement = document.rootVisualElement;
        var split = path.Split('\\');

        if (path == rootPath)
            return currentElement as T;

        for (var i = 1; i < split.Length; i++)
        {
            currentElement = currentElement.Q(split[i]);

            if (currentElement == null)
                return null;
        }

        return currentElement as T;
    }
}
[Serializable]
public struct VEPtr
{
    public const string emptyPath = "<none>";
    public const string rootPath = "<root>";

    public UIDocument document;
    public string path;

    public VisualElement element
    {
        get {
            if (document == null)
                return null;
            if (path == emptyPath)
                return null;

            return Q();
        }
    }
    
    private VisualElement Q()
    {
        var currentElement = document.rootVisualElement;
        var split = path.Split('\\');

        if (path == rootPath)
            return currentElement;

        for (var i = 1; i < split.Length; i++)
        {
            currentElement = currentElement.Q(split[i]);

            if (currentElement == null)
                return null;
        }

        return currentElement;
    }
}
