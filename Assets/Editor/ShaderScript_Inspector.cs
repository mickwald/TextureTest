using UnityEditor;
using UnityEngine;
using System.Collections;

[CustomEditor(typeof(ShaderScript))]
public class ShaderScript_Inspector : Editor
{
    int currentLayer = 1;

    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();
        EditorGUILayout.Space();
        EditorGUILayout.LabelField("--------------------------------------------------------------------------");
        EditorGUILayout.Space();

        //Shader and material inputs:
        ShaderScript ssScript = (ShaderScript)target;
        if (ssScript.shader == null) { EditorGUILayout.HelpBox("Please assign the Texture Shader to the field below.", MessageType.Warning, true); }
        EditorGUI.BeginChangeCheck();
        Shader shader = (Shader)EditorGUILayout.ObjectField("Texture Shader", ssScript.shader, typeof(Shader), false);
        if (EditorGUI.EndChangeCheck())
        {
            ssScript.shader = shader;
        }
        if (ssScript.mat == null) { EditorGUILayout.HelpBox("Please assign a dedicated material to the field below.", MessageType.Warning, true); }
        EditorGUI.BeginChangeCheck();
        Material mat = (Material)EditorGUILayout.ObjectField("Material", ssScript.mat, typeof(Material), false);
        if (EditorGUI.EndChangeCheck())
        {
            ssScript.mat = mat;
        }

        //Script settings:
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField("Color");
        ssScript.color = EditorGUILayout.ColorField(ssScript.color);
        EditorGUILayout.EndHorizontal();

        //Layer selection and Texture input
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField("Current layer:");
        currentLayer = EditorGUILayout.IntSlider(currentLayer, 1, (ssScript.GetNumberOfLayers()));
        ssScript.currentLayer = currentLayer;
        EditorGUILayout.EndHorizontal();
        EditorGUI.BeginChangeCheck();
        Texture2D texture = null;
        if (ssScript.textures != null)
        {
            texture = (Texture2D)EditorGUILayout.ObjectField("Texture", ssScript.textures[currentLayer-1], typeof(Texture2D), true);
        }
        if (EditorGUI.EndChangeCheck())
        {
            ssScript.textures[currentLayer - 1] = texture;
            ssScript.ReloadShader();
        }

        //Texture Settings
        //Displacement
        if(ssScript.displacementID[currentLayer-1] == 0)
        {
            bool temp = false;
            temp = EditorGUILayout.Toggle("Should this texture be displaced?", temp);
            if (temp) { ssScript.displacementID[currentLayer - 1] = 1; }
        }
        if(ssScript.displacementID[currentLayer-1] != 0)
        {
            bool temp = true;
            temp = EditorGUILayout.Toggle("Should this texture be displaced?", temp);
            EditorGUI.BeginChangeCheck();
            int displaceID = EditorGUILayout.IntSlider("Displace by what layer?", ssScript.displacementID[currentLayer - 1], 1, ssScript.GetNumberOfLayers());
            if (EditorGUI.EndChangeCheck())
            {
                ssScript.displacementID[currentLayer - 1] = displaceID;
                EditorUtility.SetDirty(ssScript);
            }
            if (!temp)
            {
                ssScript.displacementID[currentLayer - 1] = 0;
                EditorUtility.SetDirty(ssScript);
            }
        }
        EditorGUI.BeginChangeCheck();
        Vector2 scrollDirection = (Vector2)EditorGUILayout.Vector2Field("Scroll Direction", ssScript.scrollDirection[currentLayer - 1]);
        if (EditorGUI.EndChangeCheck())
        {
            ssScript.scrollDirection[currentLayer - 1] = scrollDirection;
            ssScript.ReloadShader();
            EditorUtility.SetDirty(ssScript);
        }
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField("Loop time: ");
        EditorGUILayout.LabelField((1/ssScript.loopTime[currentLayer - 1]).ToString());
        EditorGUILayout.EndHorizontal();
        EditorGUI.BeginChangeCheck();
        float weight = EditorGUILayout.FloatField("Layer Weight", ssScript.layerWeight[currentLayer - 1]);
        if (EditorGUI.EndChangeCheck())
        {
            ssScript.layerWeight[currentLayer - 1] = weight;
            EditorUtility.SetDirty(ssScript);
        }
        EditorGUILayout.Space();
        if (GUILayout.Button("Refresh shader"))
        {
            ssScript.ReloadShader();
        }
    }

}