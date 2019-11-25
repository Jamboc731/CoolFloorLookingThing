Shader "Custom/OneTimeAnimate"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Speed ("Speed", float) = 1
		_T ("Time", float) = 0
		_Mask ("Mask", 2D) = "white" {}
		_RVec ("Random Vector", Vector) = (0, 0, 0)
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

		float _T;
		float _Speed;
		float3 _RVec;
		sampler2D _Mask;

		void vert(inout appdata_full v)
		{

			float2 adjustedTexCoords = v.texcoord.xy * abs(/*_SinTime.y*/1);
			float4 MaskVals = tex2Dlod(_Mask, float4(adjustedTexCoords, 0, 0));

			float3 norm = v.normal;

			v.vertex.xyz = norm.xyz * clamp(_T * _Speed * MaskVals.a, 0, 1);
			
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
