// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/TerrainEngine/Details/Vertexlit"
{
	Properties
	{
		[HideInInspector]_CameraPosition("_CameraPosition", Vector) = (0,0,0,0)
		[HideInInspector]_WaveAndDistance("_WaveAndDistance", Vector) = (0,0,0,0)
		_WavingTint("_WavingTint", Vector) = (0,0,0,0)
		[HideInInspector][NoScaleOffset]_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		//TVE Shader Type Defines
		#define TVE_IS_OBJECT_SHADER
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
		#endif//ASE Sampling Macros

		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldNormal;
			float3 worldPos;
		};

		uniform half TVE_DetailInteractionAmplitude;
		uniform float4 _CameraPosition;
		uniform float4 _WaveAndDistance;
		uniform float TVE_DistanceFadeBias;
		uniform sampler2D _MainTex;
		uniform float3 _WavingTint;
		uniform half4 TVE_OverlayColor;
		uniform half4 TVE_ExtrasParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_ExtrasCoords;
		uniform half TVE_DetailLayerExtras;
		SamplerState sampler_linear_clamp;
		uniform float TVE_ExtrasUsage[10];
		uniform float TVE_DetailGlobalOverlay;
		uniform float TVE_DetailOverlayMaskMin;
		uniform float TVE_DetailOverlayMaskMax;
		uniform float TVE_Wetness;
		uniform half TVE_DetailGlobalWetness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 TerrainData_CameraPos482_g32509 = (_CameraPosition).xyz;
			half3 Fade_Distance751_g32509 = ( ase_vertex3Pos - TerrainData_CameraPos482_g32509 );
			float temp_output_442_0_g32509 = length( Fade_Distance751_g32509 );
			float TerrainData_DetailDistance433_g32509 = _WaveAndDistance.w;
			float temp_output_7_0_g57803 = TerrainData_DetailDistance433_g32509;
			float temp_output_464_0_g32509 = saturate( ( ( ( ( temp_output_442_0_g32509 * temp_output_442_0_g32509 ) * ( 1.0 / TVE_DistanceFadeBias ) ) - temp_output_7_0_g57803 ) / ( 0.0 - temp_output_7_0_g57803 ) ) );
			half Fade_Mask667_g32509 = ( 1.0 - temp_output_464_0_g32509 );
			float3 appendResult768_g32509 = (float3(0.0 , Fade_Mask667_g32509 , 0.0));
			v.vertex.xyz = ( ase_vertex3Pos - appendResult768_g32509 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex413_g32509 = i.uv_texcoord;
			float4 tex2DNode413_g32509 = tex2D( _MainTex, uv_MainTex413_g32509 );
			half3 MainTex_RGB579_g32509 = (tex2DNode413_g32509).rgb;
			half3 Highlight_Tint685_g32509 = half3(1,1,1);
			float3 temp_output_412_0_g32509 = ( MainTex_RGB579_g32509 * (i.vertexColor).rgb * _WavingTint * Highlight_Tint685_g32509 );
			half3 Global_OverlayColor87_g32509 = (TVE_OverlayColor).rgb;
			float3 ase_worldNormal = i.worldNormal;
			half MainTex_G786_g32509 = tex2DNode413_g32509.g;
			float4 temp_output_93_19_g57816 = TVE_ExtrasCoords;
			float3 ase_worldPos = i.worldPos;
			float3 WorldPosition837_g32509 = ase_worldPos;
			half2 UV96_g57816 = ( (temp_output_93_19_g57816).zw + ( (temp_output_93_19_g57816).xy * (WorldPosition837_g32509).xz ) );
			float temp_output_84_0_g57816 = TVE_DetailLayerExtras;
			float4 lerpResult109_g57816 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_linear_clamp, float3(UV96_g57816,temp_output_84_0_g57816), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g57816]);
			float4 break89_g57816 = lerpResult109_g57816;
			half Global_ExtrasTex_B97_g32509 = break89_g57816.b;
			float temp_output_7_0_g57811 = TVE_DetailOverlayMaskMin;
			float Overlay_Mask586_g32509 = saturate( ( ( ( ( saturate( ase_worldNormal.y ) + MainTex_G786_g32509 ) * Global_ExtrasTex_B97_g32509 * TVE_DetailGlobalOverlay ) - temp_output_7_0_g57811 ) / ( TVE_DetailOverlayMaskMax - temp_output_7_0_g57811 ) ) );
			float3 lerpResult493_g32509 = lerp( temp_output_412_0_g32509 , Global_OverlayColor87_g32509 , Overlay_Mask586_g32509);
			o.Albedo = lerpResult493_g32509;
			half Global_ExtrasTex_G94_g32509 = break89_g57816.g;
			o.Smoothness = ( saturate( TVE_Wetness ) * Global_ExtrasTex_G94_g32509 * TVE_DetailGlobalWetness );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18935
1920;6;1920;1023;1290.613;454.3854;1;True;False
Node;AmplifyShaderEditor.FunctionNode;115;-512,0;Inherit;False;Base Detail;0;;32509;3cf1ef10a81a8a341aef45911c04a700;5,756,1,696,1,588,1,626,1,570,1;0;4;FLOAT3;415;FLOAT;508;FLOAT;417;FLOAT3;331
Node;AmplifyShaderEditor.FunctionNode;117;-512,-384;Inherit;False;Compile All Shaders;-1;;57830;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;118;-256,-384;Inherit;False;Compile Details;-1;;57831;8afbb733ecf2e844f811992b33b036ae;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;81;-512,640;Inherit;False;Define Shader Object;-1;;57832;1237b3cc9fbfe714d8343c91216dc9b4;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;32,0;Float;False;True;-1;2;;0;0;Standard;Hidden/TerrainEngine/Details/Vertexlit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;86;-512,512;Inherit;False;769.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;85;-512,-128;Inherit;False;770.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;116;-512,-512;Inherit;False;770.392;100;Internal;0;;1,0,0,1;0;0
WireConnection;0;0;115;415
WireConnection;0;4;115;508
WireConnection;0;11;115;331
ASEEND*/
//CHKSM=475D6D66D89BEABC303DEF155E94D94EA99FDA8E