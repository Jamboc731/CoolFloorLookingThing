Shader "Unlit/WaveOverTime"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "blue" {}
		_Color ("Colour", Color) = (1, 1, 1, 1)
		_LocalTime("Local Time", float) = 0
		_Speed ("Speed", float) = 5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			float4 _Color;
			float _LocalTime;
			float _Speed;

            v2f vert (appdata v)
            {
                v2f o;

                //o.vertex = UnityObjectToClipPos(v.vertex);
				
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);

				//v.vertex.y = sin(v.vertex.x * _Time.w);
				v.vertex.y =  v.vertex.x + 0.5f * _LocalTime * _Speed;

				//This bit
				o.vertex.y = v.vertex.y;

                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);

				col = _Color;
                return col;
            }
            ENDCG
        }
    }
}
