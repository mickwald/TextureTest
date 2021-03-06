Shader "Custom/TextureShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _LayerWeight("Layer Weight", Int) = 1
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _textureArray("Texture Array", 2DArray) = "white" {}
    }
        SubShader
        {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        // Require 2D Array
        #pragma require 2darray

       
            

        UNITY_DECLARE_TEX2DARRAY(_textureArray);

        struct Input
        {
            float2 uv_textureArray;
        };
        static const int NUMBER_OF_LAYERS = 32;

        half _Glossiness;
        half _Metallic;
        fixed4 _color[NUMBER_OF_LAYERS];
        float _totalWeight;
        half _layerWeight[NUMBER_OF_LAYERS];
		float _scrollTimer[NUMBER_OF_LAYERS];
        float _textureScale[NUMBER_OF_LAYERS];
        //Displace layer [index] with data from index. 0 for no displacement layer, 1-32 for displacement from layer (1-32)-1)
        float _displacementIndex[NUMBER_OF_LAYERS];
        bool _displacementLayer[NUMBER_OF_LAYERS];
        //float _scrollDirection[2];
        fixed _scrollDirectionX[NUMBER_OF_LAYERS];
        fixed _scrollDirectionY[NUMBER_OF_LAYERS];
        fixed4 t[NUMBER_OF_LAYERS];
        fixed displace[NUMBER_OF_LAYERS];

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Calculate displacement
            int currentLayer = 0;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 1;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 2;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 3;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 4;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 5;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 6;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 7;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 8;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 9;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 10;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 11;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 12;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 13;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 14;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 15;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 16;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 17;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 18;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 19;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 20;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 21;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 22;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 23;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 24;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 25;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 26;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 27;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 28;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 29;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 30;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            currentLayer = 31;
            t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]))*_textureScale[currentLayer], (IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])) * _textureScale[currentLayer], currentLayer));
            displace[currentLayer] = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            displace[currentLayer] -= 0.5;
            /*currentLayer = 1;
            fixed d_t = (t[currentLayer].r + t[currentLayer].g + t[currentLayer].b) / 3;
            //fixed4 d = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + (_scrollDirection[0] * _scrollTimer[0])), (IN.uv_textureArray.y + (_scrollDirection[1] * _scrollTimer[0])), 1));
            //fixed displacement = (d.r + d.g + d.b) / 3;
            fixed displacement = d_t;
            displacement -= 0.5;
            //displacement = 0;*/
            currentLayer = 0;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 1;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 2;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 3;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 4;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 5;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 6;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 7;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 8;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 9;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 10;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 11;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 12;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 13;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 14;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 15;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 16;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 17;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 18;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 19;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 20;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 21;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 22;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 23;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 24;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 25;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 26;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 27;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 28;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 29;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 30;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            currentLayer = 31;
            if (_displacementIndex[currentLayer] != 0) {
                t[currentLayer] = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(((IN.uv_textureArray.x + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), ((IN.uv_textureArray.y + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer]) + displace[_displacementIndex[currentLayer] - 1]) * _textureScale[currentLayer]), currentLayer));
            }
            //fixed4 c = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3((IN.uv_textureArray.x + displacement + (_scrollDirectionX[currentLayer] * _scrollTimer[currentLayer])), (IN.uv_textureArray.y + displacement + (_scrollDirectionY[currentLayer] * _scrollTimer[currentLayer])), currentLayer)) * _Color;
            //fixed4 c = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(IN.uv_textureArray.x + displacement, IN.uv_textureArray.y + displacement, currentLayer)) * _Color;

            //o.Albedo = c.rgb;
            //o.Albedo = t[0].rgb;
            //o.Albedo = (c.rgb + t[1].rgb) / 2;
            //o.Albedo = (t[0] + c) / 2;
            //o.Albedo = (t[0] + t[1]) / 2;
            // Metallic and smoothness come from slider variables
            o.Albedo = (t[0].rgb * _color[0] * _layerWeight[0] + t[1].rgb * _color[1]  * _layerWeight[1] + t[2].rgb * _color[2]  * _layerWeight[2] + t[3].rgb * _color[3]  * _layerWeight[3] + t[4].rgb * _color[4]  * _layerWeight[4] + t[5].rgb * _color[5]  * _layerWeight[5] + t[6].rgb * _color[6]  * _layerWeight[6] + t[7].rgb * _color[7]  * _layerWeight[7] + t[8].rgb * _color[8]  * _layerWeight[8] + t[9].rgb * _color[9]  * _layerWeight[9] + t[10].rgb * _color[10]  * _layerWeight[10] + t[11].rgb * _color[11]  * _layerWeight[11] + t[12].rgb * _color[12]  * _layerWeight[12] + t[13].rgb * _color[13]  * _layerWeight[13] + t[14].rgb * _color[14]  * _layerWeight[14] + t[15].rgb * _color[15]  * _layerWeight[15] + t[16].rgb * _color[16]  * _layerWeight[16] + t[17].rgb * _color[17]  * _layerWeight[17] + t[18].rgb * _color[18]  * _layerWeight[18] + t[19].rgb * _color[19]  * _layerWeight[19] + t[20].rgb * _color[20]  * _layerWeight[20] + t[21].rgb * _color[21]  * _layerWeight[21] + t[22].rgb * _color[22]  * _layerWeight[22] + t[23].rgb * _color[23]  * _layerWeight[23] + t[24].rgb * _color[24]  * _layerWeight[24] + t[25].rgb * _color[25]  * _layerWeight[25] + t[26].rgb * _color[26]  * _layerWeight[26] + t[27].rgb * _color[27]  * _layerWeight[27] + t[28].rgb * _color[28]  * _layerWeight[28] + t[29].rgb * _color[29]  * _layerWeight[29] + t[30].rgb * _color[30]  * _layerWeight[30] + t[31].rgb * _color[31]  * _layerWeight[31]) / _totalWeight;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = (t[0].a * _layerWeight[0] + t[1].a * _layerWeight[1] + t[2].a * _layerWeight[2] + t[3].a * _layerWeight[3] + t[4].a * _layerWeight[4] + t[5].a * _layerWeight[5] + t[6].a * _layerWeight[6] + t[7].a * _layerWeight[7] + t[8].a * _layerWeight[8] + t[9].a * _layerWeight[9] + t[10].a * _layerWeight[10] + t[11].a * _layerWeight[11] + t[12].a * _layerWeight[12] + t[13].a * _layerWeight[13] + t[14].a * _layerWeight[14] + t[15].a * _layerWeight[15] + t[16].a * _layerWeight[16] + t[17].a * _layerWeight[17] + t[18].a * _layerWeight[18] + t[19].a * _layerWeight[19] + t[20].a * _layerWeight[20] + t[21].a * _layerWeight[21] + t[22].a * _layerWeight[22] + t[23].a * _layerWeight[23] + t[24].a * _layerWeight[24] + t[25].a * _layerWeight[25] + t[26].a * _layerWeight[26] + t[27].a * _layerWeight[27] + t[28].a * _layerWeight[28] + t[29].a * _layerWeight[29] + t[30].a * _layerWeight[30] + t[31].a * _layerWeight[31]) / _totalWeight;
            
            

        }
        ENDCG
    }
    FallBack "Diffuse"
}
