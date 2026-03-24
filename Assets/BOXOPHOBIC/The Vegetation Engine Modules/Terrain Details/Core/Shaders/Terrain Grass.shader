// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/TerrainEngine/Details/WavingDoublePass"
{
	Properties
	{
		[HideInInspector]_CameraPosition("_CameraPosition", Vector) = (0,0,0,0)
		[HideInInspector]_WaveAndDistance("_WaveAndDistance", Vector) = (0,0,0,0)
		_WavingTint("_WavingTint", Vector) = (0,0,0,0)
		[HideInInspector][NoScaleOffset]_MainTex("_MainTex", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "DisableBatching" = "True" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		//TVE Shader Type Defines
		#define TVE_IS_GRASS_SHADER
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
		#endif//ASE Sampling Macros

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float vertexToFrag11_g57804;
			float vertexToFrag762_g44441;
		};

		uniform half TVE_DetailInteractionAmplitude;
		uniform float4 _CameraPosition;
		uniform float4 _WaveAndDistance;
		uniform half4 TVE_MotionParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
		uniform half4 TVE_MotionCoords;
		uniform half TVE_DetailLayerMotion;
		SamplerState sampler_linear_clamp;
		uniform float TVE_MotionUsage[10];
		uniform float TVE_DetailMotionAmplitude_10;
		uniform sampler2D TVE_NoiseTex;
		uniform float TVE_DetailMotionScale_10;
		uniform half4 TVE_NoiseParams;
		uniform float TVE_DetailMotionSpeed_10;
		uniform float TVE_DetailMotionScale_32;
		uniform float TVE_DetailMotionSpeed_32;
		uniform half4 TVE_FlutterParams;
		uniform float TVE_DetailMotionAmplitude_32;
		uniform half TVE_MotionFadeEnd;
		uniform half TVE_MotionFadeStart;
		uniform half TVE_DetailPerspectivePush;
		uniform half TVE_DetailPerspectiveNoise;
		uniform half TVE_DetailPerspectiveAngle;
		uniform sampler2D _MainTex;
		uniform float3 _WavingTint;
		uniform half4 TVE_DetailMotionHighlightColor;
		uniform half4 TVE_ColorsParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
		uniform half4 TVE_ColorsCoords;
		uniform half TVE_DetailLayerColors;
		uniform float TVE_ColorsUsage[10];
		uniform half TVE_DetailGlobalColors;
		uniform half TVE_DetailColorsMaskMin;
		uniform half TVE_DetailColorsMaskMax;
		uniform half4 TVE_OverlayColor;
		uniform half4 TVE_ExtrasParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_ExtrasCoords;
		uniform half TVE_DetailLayerExtras;
		uniform float TVE_ExtrasUsage[10];
		uniform float TVE_DetailGlobalOverlay;
		uniform float TVE_DetailOverlayMaskMin;
		uniform float TVE_DetailOverlayMaskMax;
		uniform float TVE_Wetness;
		uniform half TVE_DetailGlobalWetness;
		uniform float TVE_DetailGlobalAlpha;
		uniform float TVE_DistanceFadeBias;
		uniform float TVE_DetailCutoff;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 temp_output_91_19_g57820 = TVE_MotionCoords;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 WorldPosition837_g44441 = ase_worldPos;
			half2 UV94_g57820 = ( (temp_output_91_19_g57820).zw + ( (temp_output_91_19_g57820).xy * (WorldPosition837_g44441).xz ) );
			float temp_output_84_0_g57820 = TVE_DetailLayerMotion;
			float4 lerpResult107_g57820 = lerp( TVE_MotionParams , saturate( SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_linear_clamp, float3(UV94_g57820,temp_output_84_0_g57820), 0.0 ) ) , TVE_MotionUsage[(int)temp_output_84_0_g57820]);
			float4 break322_g57829 = lerpResult107_g57820;
			float3 appendResult397_g57829 = (float3(break322_g57829.x , 0.0 , break322_g57829.y));
			float3 temp_output_398_0_g57829 = (appendResult397_g57829*2.0 + -1.0);
			half2 Motion_DirectionWS852_g44441 = (temp_output_398_0_g57829).xz;
			half Wind_Power369_g57829 = break322_g57829.z;
			half Wind_Power614_g44441 = Wind_Power369_g57829;
			half3 Input_Position419_g57824 = WorldPosition837_g44441;
			float Input_MotionScale287_g57824 = ( TVE_DetailMotionScale_10 + 1.0 );
			half Global_Scale448_g57824 = TVE_NoiseParams.x;
			float2 temp_output_597_0_g57824 = (( Input_Position419_g57824 * Input_MotionScale287_g57824 * Global_Scale448_g57824 * 0.0075 )).xz;
			half2 Input_DirectionWS423_g57824 = Motion_DirectionWS852_g44441;
			half Input_MotionSpeed62_g57824 = TVE_DetailMotionSpeed_10;
			half Global_Speed449_g57824 = TVE_NoiseParams.y;
			half Input_MotionVariation284_g57824 = 0.0;
			half Input_GlobalVariation569_g57824 = 0.0;
			float temp_output_630_0_g57824 = ( ( ( _Time.y * Input_MotionSpeed62_g57824 * Global_Speed449_g57824 ) + ( Input_MotionVariation284_g57824 * Input_GlobalVariation569_g57824 ) ) * 0.03 );
			float temp_output_607_0_g57824 = frac( temp_output_630_0_g57824 );
			float4 lerpResult590_g57824 = lerp( tex2Dlod( TVE_NoiseTex, float4( ( temp_output_597_0_g57824 + ( -Input_DirectionWS423_g57824 * temp_output_607_0_g57824 ) ), 0, 0.0) ) , tex2Dlod( TVE_NoiseTex, float4( ( temp_output_597_0_g57824 + ( -Input_DirectionWS423_g57824 * frac( ( temp_output_630_0_g57824 + 0.5 ) ) ) ), 0, 0.0) ) , ( abs( ( temp_output_607_0_g57824 - 0.5 ) ) / 0.5 ));
			half Input_GlobalWind327_g57824 = Wind_Power614_g44441;
			float lerpResult612_g57824 = lerp( 1.4 , 0.4 , Input_GlobalWind327_g57824);
			float3 temp_cast_3 = (lerpResult612_g57824).xxx;
			float3 break638_g57824 = (pow( ( abs( (lerpResult590_g57824).rgb ) + 0.2 ) , temp_cast_3 )*1.4 + -0.2);
			half Global_MotionNoise69_g44441 = break638_g57824.x;
			half Motion_Bending617_g44441 = ( TVE_DetailMotionAmplitude_10 * Wind_Power614_g44441 * Global_MotionNoise69_g44441 );
			half Interaction_Mask611_g44441 = ( break322_g57829.w * break322_g57829.w );
			float lerpResult234_g44441 = lerp( Motion_Bending617_g44441 , TVE_DetailInteractionAmplitude , saturate( ( TVE_DetailInteractionAmplitude * Interaction_Mask611_g44441 ) ));
			float2 break130_g44441 = ( Motion_DirectionWS852_g44441 * lerpResult234_g44441 * v.color.a );
			half Motion_X178_g44441 = break130_g44441.x;
			half Motion_Z175_g44441 = break130_g44441.y;
			float3 appendResult385_g44441 = (float3(Motion_X178_g44441 , 0.0 , Motion_Z175_g44441));
			half Input_MotionScale321_g57806 = TVE_DetailMotionScale_32;
			half Input_MotionVariation330_g57806 = 0.0;
			half Input_GlobalVariation372_g57806 = 0.0;
			half Input_MotionSpeed62_g57806 = TVE_DetailMotionSpeed_32;
			half Global_Speed350_g57806 = TVE_FlutterParams.y;
			float temp_output_7_0_g57814 = TVE_MotionFadeEnd;
			half Wind_FadeOut822_g44441 = saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g57814 ) / ( TVE_MotionFadeStart - temp_output_7_0_g57814 ) ) );
			half Input_MotionAmplitude58_g57806 = ( TVE_DetailMotionAmplitude_32 * Global_MotionNoise69_g44441 * Wind_Power614_g44441 * Wind_FadeOut822_g44441 * v.color.a );
			half Global_Power354_g57806 = TVE_FlutterParams.x;
			half Input_MeshMotion_30374_g57806 = 0.0;
			float3 ase_vertexNormal = v.normal.xyz;
			half Input_MotionNormal364_g57806 = 0.0;
			float3 lerpResult370_g57806 = lerp( float3( 1,1,1 ) , ase_vertexNormal , Input_MotionNormal364_g57806);
			half3 Motion_Flutter122_g44441 = ( ( sin( ( ( ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) * Input_MotionScale321_g57806 ) + ( Input_MotionVariation330_g57806 * Input_GlobalVariation372_g57806 ) + ( _Time.y * Input_MotionSpeed62_g57806 * Global_Speed350_g57806 ) ) ) * Input_MotionAmplitude58_g57806 * Global_Power354_g57806 * Input_MeshMotion_30374_g57806 * 0.4 ) * lerpResult370_g57806 );
			float3 normalizeResult701_g44441 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float3 break719_g44441 = cross( normalizeResult701_g44441 , half3(0,1,0) );
			float3 appendResult715_g44441 = (float3(-break719_g44441.z , 0.0 , break719_g44441.x));
			float3 appendResult702_g44441 = (float3(frac( ase_vertex3Pos.x ) , 0.5 , frac( ase_vertex3Pos.z )));
			float3 normalizeResult727_g44441 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float dotResult732_g44441 = dot( normalizeResult727_g44441 , float3(0,1,0) );
			half Mask_HView731_g44441 = abs( dotResult732_g44441 );
			float saferPower704_g44441 = abs( Mask_HView731_g44441 );
			half3 Perspective_Correction699_g44441 = ( ( ( appendResult715_g44441 * TVE_DetailPerspectivePush ) + ( (appendResult702_g44441*2.0 + -1.0) * TVE_DetailPerspectiveNoise ) ) * v.color.a * pow( saferPower704_g44441 , TVE_DetailPerspectiveAngle ) );
			v.vertex.xyz = ( ( ase_vertex3Pos + appendResult385_g44441 + Motion_Flutter122_g44441 ) + Perspective_Correction699_g44441 );
			v.vertex.w = 1;
			half Global_MotionHighlight868_g44441 = (lerpResult590_g57824).a;
			o.vertexToFrag11_g57804 = ( Global_MotionHighlight868_g44441 * Wind_Power614_g44441 * Wind_FadeOut822_g44441 * v.color.a );
			float3 TerrainData_CameraPos482_g44441 = (_CameraPosition).xyz;
			half3 Fade_Distance751_g44441 = ( ase_vertex3Pos - TerrainData_CameraPos482_g44441 );
			float temp_output_442_0_g44441 = length( Fade_Distance751_g44441 );
			float TerrainData_DetailDistance433_g44441 = _WaveAndDistance.w;
			float temp_output_7_0_g57803 = TerrainData_DetailDistance433_g44441;
			float temp_output_464_0_g44441 = saturate( ( ( ( ( temp_output_442_0_g44441 * temp_output_442_0_g44441 ) * ( 1.0 / TVE_DistanceFadeBias ) ) - temp_output_7_0_g57803 ) / ( 0.0 - temp_output_7_0_g57803 ) ) );
			half Fade_Mask667_g44441 = ( 1.0 - temp_output_464_0_g44441 );
			o.vertexToFrag762_g44441 = Fade_Mask667_g44441;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex413_g44441 = i.uv_texcoord;
			float4 tex2DNode413_g44441 = tex2D( _MainTex, uv_MainTex413_g44441 );
			half3 MainTex_RGB579_g44441 = (tex2DNode413_g44441).rgb;
			half3 Highlight_Tint685_g44441 = ( ( (TVE_DetailMotionHighlightColor).rgb * i.vertexToFrag11_g57804 ) + float3( 1,1,1 ) );
			float3 temp_output_412_0_g44441 = ( MainTex_RGB579_g44441 * (i.vertexColor).rgb * _WavingTint * Highlight_Tint685_g44441 );
			float dotResult797_g44441 = dot( temp_output_412_0_g44441 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_0 = (dotResult797_g44441).xxx;
			float4 temp_output_91_19_g57799 = TVE_ColorsCoords;
			float3 ase_worldPos = i.worldPos;
			float3 WorldPosition837_g44441 = ase_worldPos;
			half2 UV94_g57799 = ( (temp_output_91_19_g57799).zw + ( (temp_output_91_19_g57799).xy * (WorldPosition837_g44441).xz ) );
			float temp_output_82_0_g57799 = TVE_DetailLayerColors;
			float4 lerpResult108_g57799 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_linear_clamp, float3(UV94_g57799,temp_output_82_0_g57799), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g57799]);
			half Global_ColorsTex_A65_g44441 = saturate( (lerpResult108_g57799).a );
			half Global_Colors_Influence804_g44441 = Global_ColorsTex_A65_g44441;
			float3 lerpResult798_g44441 = lerp( temp_output_412_0_g44441 , temp_cast_0 , Global_Colors_Influence804_g44441);
			half3 Global_ColorsTex_RGB66_g44441 = (lerpResult108_g57799).rgb;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g57815 = 2.0;
			#else
				float staticSwitch1_g57815 = 4.594794;
			#endif
			half3 Global_Colors103_g44441 = ( Global_ColorsTex_RGB66_g44441 * staticSwitch1_g57815 );
			float temp_output_7_0_g57797 = TVE_DetailColorsMaskMin;
			half Global_Colors_Mask819_g44441 = saturate( ( ( ( 1.0 - i.vertexColor.a ) - temp_output_7_0_g57797 ) / ( TVE_DetailColorsMaskMax - temp_output_7_0_g57797 ) ) );
			float3 lerpResult801_g44441 = lerp( temp_output_412_0_g44441 , ( lerpResult798_g44441 * Global_Colors103_g44441 ) , ( TVE_DetailGlobalColors * Global_Colors_Mask819_g44441 ));
			half3 Global_OverlayColor87_g44441 = (TVE_OverlayColor).rgb;
			half MainTex_G786_g44441 = tex2DNode413_g44441.g;
			float4 temp_output_93_19_g57816 = TVE_ExtrasCoords;
			half2 UV96_g57816 = ( (temp_output_93_19_g57816).zw + ( (temp_output_93_19_g57816).xy * (WorldPosition837_g44441).xz ) );
			float temp_output_84_0_g57816 = TVE_DetailLayerExtras;
			float4 lerpResult109_g57816 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_linear_clamp, float3(UV96_g57816,temp_output_84_0_g57816), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g57816]);
			float4 break89_g57816 = lerpResult109_g57816;
			half Global_ExtrasTex_B97_g44441 = break89_g57816.b;
			float temp_output_7_0_g57811 = TVE_DetailOverlayMaskMin;
			float Overlay_Mask586_g44441 = saturate( ( ( ( ( i.vertexColor.a + MainTex_G786_g44441 ) * Global_ExtrasTex_B97_g44441 * TVE_DetailGlobalOverlay ) - temp_output_7_0_g57811 ) / ( TVE_DetailOverlayMaskMax - temp_output_7_0_g57811 ) ) );
			float3 lerpResult493_g44441 = lerp( lerpResult801_g44441 , Global_OverlayColor87_g44441 , Overlay_Mask586_g44441);
			o.Albedo = lerpResult493_g44441;
			half Global_ExtrasTex_G94_g44441 = break89_g57816.g;
			o.Smoothness = ( saturate( TVE_Wetness ) * Global_ExtrasTex_G94_g44441 * TVE_DetailGlobalWetness );
			o.Alpha = 1;
			half Global_ExtrasTex_A72_g44441 = saturate( break89_g57816.a );
			float lerpResult662_g44441 = lerp( 0.75 , 0.0 , Global_ExtrasTex_A72_g44441);
			float lerpResult802_g44441 = lerp( 0.0 , lerpResult662_g44441 , TVE_DetailGlobalAlpha);
			clip( saturate( ( ( ( tex2DNode413_g44441.a - lerpResult802_g44441 ) - i.vertexToFrag762_g44441 ) - TVE_DetailCutoff ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18935
1920;6;1920;1023;1256.63;248.4523;1;True;False
Node;AmplifyShaderEditor.FunctionNode;329;-512,-384;Inherit;False;Compile All Shaders;-1;;44315;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;330;-256,-384;Inherit;False;Compile Details;-1;;44316;8afbb733ecf2e844f811992b33b036ae;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;284;-512,640;Inherit;False;Define Shader Grass;-1;;44317;921559c53826c0142ba6e27dd03eaef2;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;331;-512,0;Inherit;False;Base Detail;0;;44441;3cf1ef10a81a8a341aef45911c04a700;5,756,0,696,0,588,0,626,0,570,0;0;4;FLOAT3;415;FLOAT;508;FLOAT;417;FLOAT3;331
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;;0;0;Standard;Hidden/TerrainEngine/Details/WavingDoublePass;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;AlphaTest;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;18;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;302;-512,-128;Inherit;False;770.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;303;-512,512;Inherit;False;769.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;328;-512,-512;Inherit;False;770.392;100;Internal;0;;1,0,0,1;0;0
WireConnection;0;0;331;415
WireConnection;0;4;331;508
WireConnection;0;10;331;417
WireConnection;0;11;331;331
ASEEND*/
//CHKSM=5A48A7EDA4BFD8A672C9FBCC033BFFCC159943A2