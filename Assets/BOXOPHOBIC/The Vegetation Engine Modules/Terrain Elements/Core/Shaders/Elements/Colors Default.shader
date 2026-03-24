// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Terrain/Colors Default"
{
	Properties
	{
		[StyledBanner(Terrain Colors Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Colors Tint elements to add color tinting to the vegetation assets. Make sure the element size matches your terrain., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_RenderCat("[ Render Cat ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Element Layer Message", Float) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Element Layer Warning", Float) = 0
		[Enum(Multiply Material Colors,0,Replace Material Colors,1)]_ElementEffect("Render Effect", Float) = 0
		[StyledCategory(Splat Settings)]_SplatCat("[ Splat Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_ControlTex1("Splat 01", 2D) = "black" {}
		[HDR][Gamma][NoScaleOffset][StyledTextureSingleLine]_ControlTex2("Splat 02", 2D) = "black" {}
		[HDR][Gamma][NoScaleOffset][StyledTextureSingleLine]_ControlTex3("Splat 03", 2D) = "black" {}
		[HDR][Gamma][NoScaleOffset][StyledTextureSingleLine]_ControlTex4("Splat 04", 2D) = "black" {}
		[Space(10)][StyledRemapSlider(_ControlMinValue, _ControlMaxValue, 0, 1)]_SplatMaskRemap("Splat Mask", Vector) = (0,0,0,0)
		[HideInInspector]_ControlMinValue("Splat Min", Range( 0 , 1)) = 0
		[HideInInspector]_ControlMaxValue("Splat Max", Range( 0 , 1)) = 1
		[StyledCategory(Layer Settings)]_LayersCat("[ Layers Cat ]", Float) = 0
		[HDR][Gamma]_LayerColor1("Layer 01", Color) = (0.5,0.5,0.5,1)
		[HDR][Gamma]_LayerColor2("Layer 02", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor3("Layer 03", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor4("Layer 04", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma][Space(10)]_LayerColor5("Layer 05", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor6("Layer 06", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor7("Layer 07", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor8("Layer 08", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma][Space(10)]_LayerColor9("Layer 09", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor10("Layer 10", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor11("Layer 11", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor12("Layer 12", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma][Space(10)]_LayerColor13("Layer 13", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor14("Layer 14", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor15("Layer 15", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_LayerColor16("Layer 16", Color) = (0.5019608,0.5019608,0.5019608,1)
		[StyledCategory(Element Settings)]_ElementCat("[ Element Cat ]", Float) = 0
		[HDR][Gamma]_AdditionalColor1("Winter Color", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor2("Spring Color", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor3("Summer Color", Color) = (0.5019608,0.5019608,0.5019608,1)
		[HDR][Gamma]_AdditionalColor4("Autumn Color", Color) = (0.5019608,0.5019608,0.5019608,1)
		[Space(10)]_InfluenceValue1("Winter Influence", Range( 0 , 1)) = 0
		_InfluenceValue2("Spring Influence", Range( 0 , 1)) = 0
		_InfluenceValue3("Summer Influence", Range( 0 , 1)) = 0
		_InfluenceValue4("Autumn Influence", Range( 0 , 1)) = 0
		[StyledCategory(Fading Settings)]_FadingCat("[ Fading Cat ]", Float) = 0
		[StyledToggle]_ElementVolumeFadeMode("Enable Volume Edge Fading", Float) = 0
		[ASEEnd][StyledCategory(Advanced Settings)]_AdvancedCat("[ Advanced Cat ]", Float) = 0
		[HideInInspector][StyledEnum(Default _Layer 1 _Layer 2 _Layer 3 _Layer 4 _Layer 5 _Layer 6 _Layer 7 _Layer 8)]_ElementLayerValue("Legacy Render Layer", Float) = -1
		[HideInInspector]_ElementFadeSupport("Legacy Edge Fading", Float) = 0
		[HideInInspector]_IsElementShader("_IsElementShader", Float) = 0
		[HideInInspector]_IsColorsElement("_IsColorsElement", Float) = 1
		[HideInInspector]_render_colormask("_render_colormask", Float) = 14

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 2.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask [_render_colormask]
		ZWrite Off
		ZTest LEqual
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			// Element Type Define
			#define TVE_IS_COLORS_ELEMENT


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _render_colormask;
			uniform half _LayersCat;
			uniform half4 _SplatMaskRemap;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerValue;
			uniform half _FadingCat;
			uniform half _ElementLayerMask;
			uniform half _AdvancedCat;
			uniform half _SplatCat;
			uniform half _ElementCat;
			uniform half _RenderCat;
			uniform half _IsElementShader;
			uniform half _ElementLayerWarning;
			uniform float _ElementFadeSupport;
			uniform half _IsColorsElement;
			uniform half _Banner;
			uniform half _Message;
			uniform half _ElementEffect;
			uniform half4 TVE_SeasonOptions;
			uniform sampler2D _ControlTex1;
			uniform half _ControlMinValue;
			uniform half _ControlMaxValue;
			uniform half4 _LayerColor1;
			uniform half4 _LayerColor2;
			uniform half4 _LayerColor3;
			uniform half4 _LayerColor4;
			uniform sampler2D _ControlTex2;
			uniform half4 _LayerColor5;
			uniform half4 _LayerColor6;
			uniform half4 _LayerColor7;
			uniform half4 _LayerColor8;
			uniform sampler2D _ControlTex3;
			uniform half4 _LayerColor9;
			uniform half4 _LayerColor10;
			uniform half4 _LayerColor11;
			uniform half4 _LayerColor12;
			uniform sampler2D _ControlTex4;
			uniform half4 _LayerColor13;
			uniform half4 _LayerColor14;
			uniform half4 _LayerColor15;
			uniform half4 _LayerColor16;
			uniform half4 _AdditionalColor1;
			uniform half _InfluenceValue1;
			uniform half4 _AdditionalColor2;
			uniform half _InfluenceValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _AdditionalColor3;
			uniform half _InfluenceValue3;
			uniform half4 _AdditionalColor4;
			uniform half _InfluenceValue4;
			uniform half _ElementIntensity;
			uniform half4 TVE_ColorsCoord;
			uniform half4 TVE_ExtrasCoord;
			uniform half4 TVE_MotionCoord;
			uniform half4 TVE_ReactCoord;
			uniform half TVE_ElementsFadeValue;
			uniform half _ElementVolumeFadeMode;
			half4 IS_ELEMENT( half4 Colors, half4 Extras, half4 Motion, half4 Vertex )
			{
				#if defined (TVE_IS_COLORS_ELEMENT)
				return Colors;
				#elif defined (TVE_IS_EXTRAS_ELEMENT)
				return Extras;
				#elif defined (TVE_IS_MOTION_ELEMENT)
				return Motion;
				#elif defined (TVE_IS_VERTEX_ELEMENT)
				return Vertex;
				#else
				return Colors;
				#endif
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half Element_Effect435_g19200 = _ElementEffect;
				half TVE_SeasonOptions_X66_g19200 = TVE_SeasonOptions.x;
				half Control_Min296_g19200 = _ControlMinValue;
				half temp_output_7_0_g19396 = Control_Min296_g19200;
				half4 temp_cast_0 = (temp_output_7_0_g19396).xxxx;
				half Control_Max299_g19200 = _ControlMaxValue;
				half4 ControlTex_1123_g19200 = saturate( ( ( tex2D( _ControlTex1, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_0 ) / ( Control_Max299_g19200 - temp_output_7_0_g19396 ) ) );
				half4 weightedBlendVar16_g19200 = ControlTex_1123_g19200;
				half4 weightedBlend16_g19200 = ( weightedBlendVar16_g19200.x*_LayerColor1 + weightedBlendVar16_g19200.y*_LayerColor2 + weightedBlendVar16_g19200.z*_LayerColor3 + weightedBlendVar16_g19200.w*_LayerColor4 );
				half4 Terrain_Colors_118_g19200 = weightedBlend16_g19200;
				half temp_output_7_0_g19398 = Control_Min296_g19200;
				half4 temp_cast_1 = (temp_output_7_0_g19398).xxxx;
				half4 ControlTex_2124_g19200 = saturate( ( ( tex2D( _ControlTex2, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_1 ) / ( Control_Max299_g19200 - temp_output_7_0_g19398 ) ) );
				half4 weightedBlendVar15_g19200 = ControlTex_2124_g19200;
				half4 weightedBlend15_g19200 = ( weightedBlendVar15_g19200.x*_LayerColor5 + weightedBlendVar15_g19200.y*_LayerColor6 + weightedBlendVar15_g19200.z*_LayerColor7 + weightedBlendVar15_g19200.w*_LayerColor8 );
				half4 Terrain_Colors_217_g19200 = weightedBlend15_g19200;
				half temp_output_7_0_g19401 = Control_Min296_g19200;
				half4 temp_cast_2 = (temp_output_7_0_g19401).xxxx;
				half4 ControlTex_3307_g19200 = saturate( ( ( tex2D( _ControlTex3, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_2 ) / ( Control_Max299_g19200 - temp_output_7_0_g19401 ) ) );
				half4 weightedBlendVar339_g19200 = ControlTex_3307_g19200;
				half4 weightedBlend339_g19200 = ( weightedBlendVar339_g19200.x*_LayerColor9 + weightedBlendVar339_g19200.y*_LayerColor10 + weightedBlendVar339_g19200.z*_LayerColor11 + weightedBlendVar339_g19200.w*_LayerColor12 );
				half4 Terrain_Colors_3340_g19200 = weightedBlend339_g19200;
				half temp_output_7_0_g19399 = Control_Min296_g19200;
				half4 temp_cast_3 = (temp_output_7_0_g19399).xxxx;
				half4 ControlTex_4322_g19200 = saturate( ( ( tex2D( _ControlTex4, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_3 ) / ( Control_Max299_g19200 - temp_output_7_0_g19399 ) ) );
				half4 weightedBlendVar344_g19200 = ControlTex_4322_g19200;
				half4 weightedBlend344_g19200 = ( weightedBlendVar344_g19200.x*_LayerColor13 + weightedBlendVar344_g19200.y*_LayerColor14 + weightedBlendVar344_g19200.z*_LayerColor15 + weightedBlendVar344_g19200.w*_LayerColor16 );
				half4 Terrain_Colors_4350_g19200 = weightedBlend344_g19200;
				half4 temp_output_21_0_g19200 = ( Terrain_Colors_118_g19200 + Terrain_Colors_217_g19200 + Terrain_Colors_3340_g19200 + Terrain_Colors_4350_g19200 );
				half4 Terrain_Colors32_g19200 = temp_output_21_0_g19200;
				half4 Additional_Color_Winter36_g19200 = _AdditionalColor1;
				half Influence_Winter127_g19200 = _InfluenceValue1;
				half4 lerpResult53_g19200 = lerp( Terrain_Colors32_g19200 , Additional_Color_Winter36_g19200 , Influence_Winter127_g19200);
				half4 Final_Color_Winter55_g19200 = lerpResult53_g19200;
				half4 Additional_Color_Spring35_g19200 = _AdditionalColor2;
				half Influence_Spring128_g19200 = _InfluenceValue2;
				half4 lerpResult52_g19200 = lerp( Terrain_Colors32_g19200 , Additional_Color_Spring35_g19200 , Influence_Spring128_g19200);
				half4 Final_Color_Spring56_g19200 = lerpResult52_g19200;
				half TVE_SeasonLerp57_g19200 = TVE_SeasonLerp;
				half4 lerpResult69_g19200 = lerp( Final_Color_Winter55_g19200 , Final_Color_Spring56_g19200 , TVE_SeasonLerp57_g19200);
				half TVE_SeasonOptions_Y64_g19200 = TVE_SeasonOptions.y;
				half4 Additional_Color_Summer34_g19200 = _AdditionalColor3;
				half Influence_Summer129_g19200 = _InfluenceValue3;
				half4 lerpResult51_g19200 = lerp( Terrain_Colors32_g19200 , Additional_Color_Summer34_g19200 , Influence_Summer129_g19200);
				half4 Final_Color_Summer58_g19200 = lerpResult51_g19200;
				half4 lerpResult68_g19200 = lerp( Final_Color_Spring56_g19200 , Final_Color_Summer58_g19200 , TVE_SeasonLerp57_g19200);
				half TVE_SeasonOptions_Z61_g19200 = TVE_SeasonOptions.z;
				half4 Additional_Color_Autumn33_g19200 = _AdditionalColor4;
				half Influence_Autumn130_g19200 = _InfluenceValue4;
				half4 lerpResult49_g19200 = lerp( Terrain_Colors32_g19200 , Additional_Color_Autumn33_g19200 , Influence_Autumn130_g19200);
				half4 Final_Color_Autumn54_g19200 = lerpResult49_g19200;
				half4 lerpResult72_g19200 = lerp( Final_Color_Summer58_g19200 , Final_Color_Autumn54_g19200 , TVE_SeasonLerp57_g19200);
				half TVE_SeasonOptions_W62_g19200 = TVE_SeasonOptions.w;
				half4 lerpResult70_g19200 = lerp( Final_Color_Autumn54_g19200 , Final_Color_Winter55_g19200 , TVE_SeasonLerp57_g19200);
				half4 Element_Colors211_g19200 = ( ( TVE_SeasonOptions_X66_g19200 * lerpResult69_g19200 ) + ( TVE_SeasonOptions_Y64_g19200 * lerpResult68_g19200 ) + ( TVE_SeasonOptions_Z61_g19200 * lerpResult72_g19200 ) + ( TVE_SeasonOptions_W62_g19200 * lerpResult70_g19200 ) );
				half4 Colors37_g19403 = TVE_ColorsCoord;
				half4 Extras37_g19403 = TVE_ExtrasCoord;
				half4 Motion37_g19403 = TVE_MotionCoord;
				half4 Vertex37_g19403 = TVE_ReactCoord;
				half4 localIS_ELEMENT37_g19403 = IS_ELEMENT( Colors37_g19403 , Extras37_g19403 , Motion37_g19403 , Vertex37_g19403 );
				half4 temp_output_35_0_g19402 = localIS_ELEMENT37_g19403;
				half temp_output_7_0_g19397 = TVE_ElementsFadeValue;
				half2 temp_cast_4 = (temp_output_7_0_g19397).xx;
				half2 temp_output_244_0_g19200 = saturate( ( ( abs( (( (temp_output_35_0_g19402).zw + ( (temp_output_35_0_g19402).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_4 ) / ( 1.0 - temp_output_7_0_g19397 ) ) );
				half2 break247_g19200 = ( temp_output_244_0_g19200 * temp_output_244_0_g19200 );
				half Enable_Fade_Support111_g19200 = _ElementVolumeFadeMode;
				half lerpResult245_g19200 = lerp( 1.0 , ( 1.0 - saturate( ( break247_g19200.x + break247_g19200.y ) ) ) , Enable_Fade_Support111_g19200);
				half FadeOut_Mask254_g19200 = lerpResult245_g19200;
				half Element_Intensity235_g19200 = ( _ElementIntensity * FadeOut_Mask254_g19200 );
				half4 appendResult410_g19200 = (half4((Element_Colors211_g19200).rgb , ( Element_Colors211_g19200.a * Element_Intensity235_g19200 )));
				
				
				finalColor = ( ( Element_Effect435_g19200 * 0.0 ) + appendResult410_g19200 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TVEShaderElementGUI"
	
	
}
/*ASEBEGIN
Version=18934
1920;5;1920;1024;1444.263;1132.058;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;161;-640,-640;Half;False;Property;_render_colormask;_render_colormask;75;1;[HideInInspector];Create;True;0;0;0;True;0;False;14;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;196;-640,-512;Inherit;False;Base Terrain Elements;2;;19200;a84c2b02263ac4b42be9eb75f696cb74;3,222,0,413,0,225,0;0;1;FLOAT4;230
Node;AmplifyShaderEditor.FunctionNode;108;-640,-768;Inherit;False;Define Element Colors;73;;19404;378049ebac362e14aae08c2daa8ed737;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-384,-768;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Terrain Colors Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-256,-768;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Colors Tint elements to add color tinting to the vegetation assets. Make sure the element size matches your terrain., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-512;Half;False;True;-1;2;TVEShaderElementGUI;0;1;BOXOPHOBIC/The Vegetation Engine/Elements/Terrain/Colors Default;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;2;False;-1;True;True;True;True;True;False;0;True;161;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;0;0;196;230
ASEEND*/
//CHKSM=86D63679F293B4EBDEA53C60BA5D0AFE362E1022