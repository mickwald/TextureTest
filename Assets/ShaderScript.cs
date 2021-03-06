using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEditor;

public class ShaderScript : MonoBehaviour
{

    public Shader shader;
    public Material mat;
    private const int NUMBER_OF_LAYERS = 32;

    public int currentLayer=0;

    //Global settings

    //Texture arrays
    public Texture2D[] textures = new Texture2D[NUMBER_OF_LAYERS];
    public Texture2DArray textureArray;


    //Layer settings
    public Color[] color = new Color[NUMBER_OF_LAYERS];
    public Vector2[] scrollDirection = new Vector2[NUMBER_OF_LAYERS];
    public float[] layerWeight = new float[NUMBER_OF_LAYERS];
    public float[] loopTime = new float[NUMBER_OF_LAYERS];
    public float[] displacementID = new float[NUMBER_OF_LAYERS];
    public float[] textureScale = new float[NUMBER_OF_LAYERS];



    private void OnDrawGizmos()
    {
        if (shader == null || mat == null) return;
        float[] temp = new float[NUMBER_OF_LAYERS];
        for(int i=0; i < NUMBER_OF_LAYERS; i++)
        {
            //loopTime[i] = (float)GCD(scrollDirection[i].x, scrollDirection[i].y);
            if (loopTime[i] != 0)
            {
                temp[i] = 1 / loopTime[i];
                temp[i] = Time.realtimeSinceStartup % (temp[i]/textureScale[i]);
            }
            else
            {
                temp[i] = 0;
            }
        }
        mat.SetFloatArray("_scrollTimer", temp);
        //mat.SetFloatArray("_scrollTimer", Time.realtimeSinceStartup % (1 / loopTime[0]));        //TODO: Update to proper layer usage
    }
    
    private void OnValidate()
    {
        if (mat == null || shader == null) return;
        mat.shader = shader;
        //Upload new texture?
        //SetCurrentTexture(currentLayer);
        if (textures == null) return;
        if (textures[0] != null)
        {
            textureArray = new Texture2DArray(textures[0].width, textures[0].height, NUMBER_OF_LAYERS, TextureFormat.RGBA32, true, true);
            textureArray.hideFlags = HideFlags.DontSave;
            //color = new Color[NUMBER_OF_LAYERS];
        }
        //mat.SetFloat("_scrollTimer", Time.realtimeSinceStartup);

        float[] scrollDir = new float[2];
        scrollDir[0] = scrollDirection[0].x;        //TODO: Update to proper layer usage
        scrollDir[1] = scrollDirection[0].y;       //TODO: Update to proper layer usage
        mat.SetFloatArray("_scrollDirection", scrollDir);
        mat.SetTexture("_textureArray", textureArray);
        ReloadShader();
    }

    public int GetNumberOfLayers()
    {
        return NUMBER_OF_LAYERS;
    }

    private void Start()
    {
        ReloadShader();
    }
    private void Update()
    {
        if (shader == null || mat == null) return;
        float[] temp = new float[NUMBER_OF_LAYERS];
        for (int i = 0; i < NUMBER_OF_LAYERS; i++)
        {
            loopTime[i] = (float)GCD(scrollDirection[i].x, scrollDirection[i].y);
            if (loopTime[i] != 0)
            {
                temp[i] = 1 / loopTime[i];
            }
            temp[i] = Time.time % (temp[i]/textureScale[i]);
        }
        mat.SetFloatArray("_scrollTimer", temp);
    }

    public void ReloadShader()
    {
        if (textureArray == null)
        {
            if (textures[0] != null)
            {
                //Debug.Log("Allocated Texture Array");
                textureArray = new Texture2DArray(textures[0].width, textures[0].height, NUMBER_OF_LAYERS, TextureFormat.RGBA32, true, true);
                textureArray.hideFlags = HideFlags.DontSave;
            }
            else
            {
                Debug.Log("Assign texture to layer 1");
                return;
            }
        }
        Color[] colors = new Color[textureArray.width * textureArray.height];
        for (int i = 0; i < textures.Length; i++)
        {
            if (textures[i] != null)
            {
                colors = textures[i].GetPixels();
                textureArray.SetPixels(colors, i);
            }

        }
        //Debug.Log("Button Pressed");
        textureArray.Apply();
        mat.SetTexture("_textureArray", textureArray);

        float[] scrollDirX = new float[NUMBER_OF_LAYERS];
        float[] scrollDirY = new float[NUMBER_OF_LAYERS];

        for (int i = 0; i < NUMBER_OF_LAYERS; i++)
        {
            scrollDirX[i] = scrollDirection[i].x;
            scrollDirY[i] = scrollDirection[i].y;
        }
        mat.SetColorArray("_color", color);
        mat.SetFloatArray("_textureScale", textureScale);
        mat.SetFloatArray("_scrollDirectionX", scrollDirX);
        mat.SetFloatArray("_scrollDirectionY", scrollDirY);
        mat.SetFloatArray("_displacementIndex", displacementID);
        float totalWeight = 0f;
        for (int i = 0; i < NUMBER_OF_LAYERS; i++)
        {
            totalWeight += layerWeight[i];
        }
        mat.SetFloat("_totalWeight", totalWeight);
        mat.SetFloatArray("_layerWeight", layerWeight);
        //mat.SetFloatArray("_scrollDirection", scrollDir);

    }

    private void Reset()
    { 
        color = new Color[NUMBER_OF_LAYERS];
        textureArray = null;
        scrollDirection = new Vector2[NUMBER_OF_LAYERS];
        layerWeight = new float[NUMBER_OF_LAYERS];
        loopTime = new float[NUMBER_OF_LAYERS];
        
    }

    public void SetCurrentTexture(int layer)
    {
        if (textures == null || textures[layer] == null) return;
        Color[] colors = new Color[textureArray.width * textureArray.height];
        colors = textures[layer].GetPixels();
        textureArray.SetPixels(colors, layer);
        textureArray.Apply();
        mat.SetTexture("_textureArray", textureArray);
    }
    public void GetCurrentTexture(int layer)
    {
        Debug.Log("Getting");
        if (textureArray == null) return;
        Debug.Log("TexArr not null");
        Color[] colors = new Color[textureArray.width * textureArray.height];
        //Color[] colors = textures.GetPixels(layer);
        colors = textureArray.GetPixels(layer);
        textures[layer].SetPixels(colors);
        
        //currentTexture.SetPixels(colors);
    }


    public float GCD(float aIn, float bIn)
    {
        aIn += (aIn > 0) ? 0.00002f : -0.00002f;
        bIn += (bIn > 0) ? 0.00002f : -0.00002f;
        int a = Math.Abs((int)(aIn * 10000f));
        int b = Math.Abs((int)(bIn * 10000f));
        int Remainder;
        //Debug.Log("A: " + a + ", B: " + b + "Input: a=" + aIn + ", b=" + bIn);
        while (b != 0)
        {
            Remainder = a % b;
            a = b;
            b = Remainder;
        }
        return a/10000f;


    }

    public void ApplyMaterial()
    {
        if (shader != null)
        {
            mat.shader = shader;
        }
        this.GetComponent<Renderer>().material = this.mat;
    }
}
