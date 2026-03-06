#if UNITY_EDITOR

using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;


namespace Utilities
{
    [CustomPropertyDrawer(typeof(VEPtr))]
    [CustomPropertyDrawer(typeof(VEPtr<>))]
    public class VEPtr_Drawer : PropertyDrawer
    {
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            EditorGUI.BeginProperty(position, label, property);

            var documentProperty = property.FindPropertyRelative("document");
            var pathProperty = property.FindPropertyRelative("path");

            var type = property.boxedValue.GetType().GetGenericArguments().FirstOrDefault();
            var labelGUI = new GUIContent(label);
            if (type == null)
            {
                type = typeof(VisualElement);
            }
            else
            {
                labelGUI.text += "<" + type.Name + ">";
            }

            EditorGUI.LabelField(position, labelGUI);

            var documentFieldRect = position;
            documentFieldRect.width /= 3;
            documentFieldRect.x += documentFieldRect.width;
            documentProperty.objectReferenceValue =
                EditorGUI.ObjectField(documentFieldRect, documentProperty.objectReferenceValue, typeof(UIDocument), true);

            var popupFieldRect = position;
            popupFieldRect.width /= 3;
            popupFieldRect.x += popupFieldRect.width * 2;


            if (documentProperty.objectReferenceValue == null)
            {
                var options = new string[] { "Document not selected" };
                EditorGUI.Popup(popupFieldRect, 0, options);
            }
            else
            {
                var document = documentProperty.objectReferenceValue as UIDocument;

                if (document.rootVisualElement == null)
                {
                    EditorGUI.EndProperty();
                    return;
                }

                var elements = EnumerateChildrens(document, type);
                var options = elements.ToArray();

                var index = Array.IndexOf(options, pathProperty.stringValue);
                var style = GUIStyle.none;

                index = EditorGUI.Popup(popupFieldRect, Mathf.Max(index, 0), options, EditorStyles.popup);

                pathProperty.stringValue = options[index];
            }

            EditorGUI.EndProperty();
        } 

        private IEnumerable<string> EnumerateChildrens(UIDocument document, Type type)
        {
            yield return VEPtr<VisualElement>.emptyPath;
            
            var t = document.rootVisualElement.GetType();
            if (t.IsSubclassOf(type) || t == type)
                yield return "<root>";

            foreach (var element in EnumerateWithOffset(document.rootVisualElement, ""))
                yield return element;

            IEnumerable<string> EnumerateWithOffset(VisualElement element, string offset)
            {
                for (var a = 0; a < element.childCount; a++)
                {
                    var child = element.ElementAt(a);
                    var t = child.GetType();

                    var fixedName = string.IsNullOrWhiteSpace(child.name) ? t.Name : child.name;

                    if (t.IsSubclassOf(type) || t == type)
                        yield return offset + "\\" + fixedName;

                    foreach (var enumerated in EnumerateWithOffset(child, offset + "\\" + fixedName))
                    {
                        yield return enumerated;
                    }
                }
            }
        }
    }
}
#endif