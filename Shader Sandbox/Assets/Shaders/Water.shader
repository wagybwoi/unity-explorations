﻿Shader "CookbookShaders/GrabPass"
{
	Properties
	{
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_Colour ("Colour", Color) = (1,1,1,1)

		_Period ("Period", Range(0,50)) = 1
		_Magnitude ("Magnitude", Range(0,0.5)) = 0.05
		_Scale ("Scale", Range(0,10)) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		GrabPass { }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			 
			sampler2D _NoiseTex;
			sampler2D _GrabTexture;
			fixed4 _Colour;

			float _Period;
			float _Magnitude;
			float _Scale;

			struct vertInput
			{
				float4 vertex : POSITION;
//				float4 color : COLOR;
//				float2 texcoord : TEXCOORD0;
//
//				float4 worldPos : TEXCOORD1;
//				float4 uvgrab : TEXCOORD2;
			};

			struct vertOutput
			{
				float4 vertex : POSITION;
				float4 uvgrab : TEXCOORD1;
			};

			vertOutput vert (vertInput v) {
				vertOutput o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uvgrab = ComputeGrabScreenPos(o.vertex);
				return o;
			}
			
			half4 frag (vertOutput i) : COLOR
			{
//				float sinT = sin(_Time.w / _Period);
//				float2 distortion = float2(
//					tex2D(_NoiseTex, i.worldPos.xy / _Scale + float2(sinT, 0)).r - 0.5,
//					tex2D(_NoiseTex, i.worldPos.xy / _Scale + float2(0, sinT)).r - 0.5
//				);
//				i.uvgrab.xy += distortion * _Magnitude;

//				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				return col + half4(0.5,0,0,0);
			}
			ENDCG
		}
	}
}
