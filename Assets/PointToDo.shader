﻿Shader "PointToDo"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_Pos("Position", Vector) = (0,0,0,0)
		_Radius ("Radius", Range(0, 5)) = 1
		_Amount ("Amount", Range(0, 5)) = 1
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		float4 _Pos;
		float _Radius;
		float _Amount;

		void vert(inout appdata_full v)
		{

			float4 hitPointLocal = mul(unity_WorldToObject,_Pos);

			float3 lengthVector = hitPointLocal.xyz - v.vertex.xyz;
			float d = length(lengthVector);

			v.vertex.y += clamp(1 * (1 / (_Radius)), 0, 0.3);

		}

		struct Input
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex; 
		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o)
		{
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
    FallBack "Diffuse"
}
