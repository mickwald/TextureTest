Shader "Custom/TextureShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main texture", 2D) = "white" {}
        //_LayerTex ("Layer Texture", 2D) = "white" {}
        _MainWeight("Main Weight", Int) = 1
        _LayerWeight("Layer Weight", Int) = 1
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _totalWeight("Tot Weight", Int) = 1
        _textureArray("Texture Array", 2DArray) = "white" {}
        _scrollTimer("Scroll Timer", Float) = 0.0
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

       
            
        sampler2D _MainTex;
        sampler2D _LayerTex;

        UNITY_DECLARE_TEX2DARRAY(_textureArray);

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _myColor;
        half _MainWeight;
        half _textureWeight[32];
        half _totalWeight;
        half _LayerWeight;
		half _scrollTimer;
        float _scrollDirection[2];
        fixed _scrollDirectionX;
        fixed _scrollDirectionY;
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            _totalWeight = _MainWeight + _LayerWeight;
            // Albedo comes from a texture tinted by color
			//fixed4 c = tex2D(_textureArray[1], IN.uv_MainTex);
			//fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            //fixed4 c = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(IN.uv_MainTex.x + _scrollDirectionX, IN.uv_MainTex.y + _scrollDirectionY, 0)) * _Color;
            fixed4 c = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(IN.uv_MainTex.x + (_scrollDirection[0] * _scrollTimer), IN.uv_MainTex.y + (_scrollDirection[1] * _scrollTimer), 0)) * _Color;
            fixed4 a = UNITY_SAMPLE_TEX2DARRAY(_textureArray, float3(IN.uv_MainTex.x + (_scrollDirection[0] * _scrollTimer), IN.uv_MainTex.y, 1)) * _Color;
			//fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color * _MainWeight / _totalWeight + tex2D(_textureArray[0], IN.uv_MainTex) * _Color * _LayerWeight / _totalWeight;
            o.Albedo = (c.rgb + a.rgb) /2;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = (c.a + a.a)/2;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
