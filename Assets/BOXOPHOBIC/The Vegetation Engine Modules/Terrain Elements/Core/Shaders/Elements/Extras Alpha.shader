// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Terrain/Extras Alpha"
{
	Properties
	{
		[StyledBanner(Terrain Leaves Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Leaves elements to reduce the leaves amount or the alpha treshold. Useful to create winter sceneries or dead forests and dissolve effects. Make sure the element size matches your terrain., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_RenderCat("[ Render Cat ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Element Layer Message", Float) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Element Layer Warning", Float) = 0
		[Enum(Multiplicative Blending,0,Additive Blending,1)]_ElementBlendA("Render Effect", Float) = 0
		[StyledCategory(Splat Settings)]_SplatCat("[ Splat Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_ControlTex1("Splat 01", 2D) = "black" {}
		[HDR][Gamma][NoScaleOffset][StyledTextureSingleLine]_ControlTex2("Splat 02", 2D) = "black" {}
		[HDR][Gamma][NoScaleOffset][StyledTextureSingleLine]_ControlTex3("Splat 03", 2D) = "black" {}
		[HDR][Gamma][NoScaleOffset][StyledTextureSingleLine]_ControlTex4("Splat 04", 2D) = "black" {}
		[Space(10)][StyledRemapSlider(_ControlMinValue, _ControlMaxValue, 0, 1)]_SplatMaskRemap("Splat Mask", Vector) = (0,0,0,0)
		[HideInInspector]_ControlMinValue("Splat Min", Range( 0 , 1)) = 0
		[HideInInspector]_ControlMaxValue("Splat Max", Range( 0 , 1)) = 1
		[StyledCategory(Layer Settings)]_LayersCat("[ Layers Cat ]", Float) = 0
		_LayerValue1("Layer 01", Range( 0 , 1)) = 1
		_LayerValue2("Layer 02", Range( 0 , 1)) = 1
		_LayerValue3("Layer 03", Range( 0 , 1)) = 1
		_LayerValue4("Layer 04", Range( 0 , 1)) = 1
		[Space(10)]_LayerValue5("Layer 05", Range( 0 , 1)) = 1
		_LayerValue6("Layer 06", Range( 0 , 1)) = 1
		_LayerValue7("Layer 07", Range( 0 , 1)) = 1
		_LayerValue8("Layer 08", Range( 0 , 1)) = 1
		[Space(10)]_LayerValue9("Layer 09", Range( 0 , 1)) = 1
		_LayerValue10("Layer 10", Range( 0 , 1)) = 1
		_LayerValue11("Layer 11", Range( 0 , 1)) = 1
		_LayerValue12("Layer 12", Range( 0 , 1)) = 1
		[Space(10)]_LayerValue13("Layer 13", Range( 0 , 1)) = 1
		_LayerValue14("Layer 14", Range( 0 , 1)) = 1
		_LayerValue15("Layer 15", Range( 0 , 1)) = 1
		_LayerValue16("Layer 16", Range( 0 , 1)) = 1
		[StyledCategory(Element Settings)]_ElementCat("[ Element Cat ]", Float) = 0
		_AdditionalValue1("Winter Value", Range( 0 , 1)) = 1
		_AdditionalValue2("Spring Value", Range( 0 , 1)) = 1
		_AdditionalValue3("Summer Value", Range( 0 , 1)) = 1
		_AdditionalValue4("Autumn Value", Range( 0 , 1)) = 1
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
		[HideInInspector]_IsExtrasElement("_IsExtrasElement", Float) = 1
		[HideInInspector]_render_src("_render_src", Float) = 2
		[HideInInspector]_render_dst("_render_dst", Float) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 2.0
		ENDCG
		Blend One Zero, [_render_src] [_render_dst]
		AlphaToMask Off
		Cull Off
		ColorMask A
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
			#define TVE_IS_EXTRAS_ELEMENT


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
			uniform half _IsExtrasElement;
			uniform half _Banner;
			uniform half _Message;
			uniform half _render_src;
			uniform half _render_dst;
			uniform half4 TVE_SeasonOptions;
			uniform sampler2D _ControlTex1;
			uniform half _ControlMinValue;
			uniform half _ControlMaxValue;
			uniform half _LayerValue1;
			uniform half _LayerValue2;
			uniform half _LayerValue3;
			uniform half _LayerValue4;
			uniform sampler2D _ControlTex2;
			uniform half _LayerValue5;
			uniform half _LayerValue6;
			uniform half _LayerValue7;
			uniform half _LayerValue8;
			uniform sampler2D _ControlTex3;
			uniform half _LayerValue9;
			uniform half _LayerValue10;
			uniform half _LayerValue11;
			uniform half _LayerValue12;
			uniform sampler2D _ControlTex4;
			uniform half _LayerValue13;
			uniform half _LayerValue14;
			uniform half _LayerValue15;
			uniform half _LayerValue16;
			uniform half _AdditionalValue1;
			uniform half _InfluenceValue1;
			uniform half _AdditionalValue2;
			uniform half _InfluenceValue2;
			uniform half TVE_SeasonLerp;
			uniform half _AdditionalValue3;
			uniform half _InfluenceValue3;
			uniform half _AdditionalValue4;
			uniform half _InfluenceValue4;
			uniform half _ElementIntensity;
			uniform half4 TVE_ColorsCoord;
			uniform half4 TVE_ExtrasCoord;
			uniform half4 TVE_MotionCoord;
			uniform half4 TVE_ReactCoord;
			uniform half TVE_ElementsFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _ElementBlendA;
			half GammaToLinearFloatFast( half sRGB )
			{
				return sRGB * (sRGB * (sRGB * 0.305306011h + 0.682171111h) + 0.012522878h);
			}
			
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
				half TVE_SeasonOptions_X66_g18629 = TVE_SeasonOptions.x;
				half Control_Min296_g18629 = _ControlMinValue;
				half temp_output_7_0_g19396 = Control_Min296_g18629;
				half4 temp_cast_0 = (temp_output_7_0_g19396).xxxx;
				half Control_Max299_g18629 = _ControlMaxValue;
				half4 ControlTex_1123_g18629 = saturate( ( ( tex2D( _ControlTex1, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_0 ) / ( Control_Max299_g18629 - temp_output_7_0_g19396 ) ) );
				half4 weightedBlendVar138_g18629 = ControlTex_1123_g18629;
				half weightedBlend138_g18629 = ( weightedBlendVar138_g18629.x*_LayerValue1 + weightedBlendVar138_g18629.y*_LayerValue2 + weightedBlendVar138_g18629.z*_LayerValue3 + weightedBlendVar138_g18629.w*_LayerValue4 );
				half Terrain_Values_1141_g18629 = weightedBlend138_g18629;
				half temp_output_7_0_g19398 = Control_Min296_g18629;
				half4 temp_cast_1 = (temp_output_7_0_g19398).xxxx;
				half4 ControlTex_2124_g18629 = saturate( ( ( tex2D( _ControlTex2, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_1 ) / ( Control_Max299_g18629 - temp_output_7_0_g19398 ) ) );
				half4 weightedBlendVar147_g18629 = ControlTex_2124_g18629;
				half weightedBlend147_g18629 = ( weightedBlendVar147_g18629.x*_LayerValue5 + weightedBlendVar147_g18629.y*_LayerValue6 + weightedBlendVar147_g18629.z*_LayerValue7 + weightedBlendVar147_g18629.w*_LayerValue8 );
				half Terrain_Values_2148_g18629 = weightedBlend147_g18629;
				half temp_output_7_0_g19401 = Control_Min296_g18629;
				half4 temp_cast_2 = (temp_output_7_0_g19401).xxxx;
				half4 ControlTex_3307_g18629 = saturate( ( ( tex2D( _ControlTex3, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_2 ) / ( Control_Max299_g18629 - temp_output_7_0_g19401 ) ) );
				half4 weightedBlendVar366_g18629 = ControlTex_3307_g18629;
				half weightedBlend366_g18629 = ( weightedBlendVar366_g18629.x*_LayerValue9 + weightedBlendVar366_g18629.y*_LayerValue10 + weightedBlendVar366_g18629.z*_LayerValue11 + weightedBlendVar366_g18629.w*_LayerValue12 );
				half Terrain_Values_3365_g18629 = weightedBlend366_g18629;
				half temp_output_7_0_g19399 = Control_Min296_g18629;
				half4 temp_cast_3 = (temp_output_7_0_g19399).xxxx;
				half4 ControlTex_4322_g18629 = saturate( ( ( tex2D( _ControlTex4, ( 1.0 - i.ase_texcoord1.xy ) ) - temp_cast_3 ) / ( Control_Max299_g18629 - temp_output_7_0_g19399 ) ) );
				half4 weightedBlendVar367_g18629 = ControlTex_4322_g18629;
				half weightedBlend367_g18629 = ( weightedBlendVar367_g18629.x*_LayerValue13 + weightedBlendVar367_g18629.y*_LayerValue14 + weightedBlendVar367_g18629.z*_LayerValue15 + weightedBlendVar367_g18629.w*_LayerValue16 );
				half Terrain_Values_4368_g18629 = weightedBlend367_g18629;
				half Terrain_Values153_g18629 = saturate( ( Terrain_Values_1141_g18629 + Terrain_Values_2148_g18629 + Terrain_Values_3365_g18629 + Terrain_Values_4368_g18629 ) );
				half Additional_Value_Winter90_g18629 = _AdditionalValue1;
				half Influence_Winter127_g18629 = _InfluenceValue1;
				half lerpResult166_g18629 = lerp( Terrain_Values153_g18629 , Additional_Value_Winter90_g18629 , Influence_Winter127_g18629);
				half Final_Values_Winter175_g18629 = lerpResult166_g18629;
				half Additional_Value_Spring88_g18629 = _AdditionalValue2;
				half Influence_Spring128_g18629 = _InfluenceValue2;
				half lerpResult169_g18629 = lerp( Terrain_Values153_g18629 , Additional_Value_Spring88_g18629 , Influence_Spring128_g18629);
				half Final_Values_Spring176_g18629 = lerpResult169_g18629;
				half TVE_SeasonLerp57_g18629 = TVE_SeasonLerp;
				half lerpResult195_g18629 = lerp( Final_Values_Winter175_g18629 , Final_Values_Spring176_g18629 , TVE_SeasonLerp57_g18629);
				half TVE_SeasonOptions_Y64_g18629 = TVE_SeasonOptions.y;
				half Additional_Value_Summer80_g18629 = _AdditionalValue3;
				half Influence_Summer129_g18629 = _InfluenceValue3;
				half lerpResult171_g18629 = lerp( Terrain_Values153_g18629 , Additional_Value_Summer80_g18629 , Influence_Summer129_g18629);
				half Final_Values_Summer177_g18629 = lerpResult171_g18629;
				half lerpResult197_g18629 = lerp( Final_Values_Spring176_g18629 , Final_Values_Summer177_g18629 , TVE_SeasonLerp57_g18629);
				half TVE_SeasonOptions_Z61_g18629 = TVE_SeasonOptions.z;
				half Additional_Value_Autumn101_g18629 = _AdditionalValue4;
				half Influence_Autumn130_g18629 = _InfluenceValue4;
				half lerpResult172_g18629 = lerp( Terrain_Values153_g18629 , Additional_Value_Autumn101_g18629 , Influence_Autumn130_g18629);
				half Final_Values_Autumn178_g18629 = lerpResult172_g18629;
				half lerpResult192_g18629 = lerp( Final_Values_Summer177_g18629 , Final_Values_Autumn178_g18629 , TVE_SeasonLerp57_g18629);
				half TVE_SeasonOptions_W62_g18629 = TVE_SeasonOptions.w;
				half lerpResult205_g18629 = lerp( Final_Values_Autumn178_g18629 , Final_Values_Winter175_g18629 , TVE_SeasonLerp57_g18629);
				half temp_output_208_0_g18629 = ( ( TVE_SeasonOptions_X66_g18629 * lerpResult195_g18629 ) + ( TVE_SeasonOptions_Y64_g18629 * lerpResult197_g18629 ) + ( TVE_SeasonOptions_Z61_g18629 * lerpResult192_g18629 ) + ( TVE_SeasonOptions_W62_g18629 * lerpResult205_g18629 ) );
				half temp_output_9_0_g19400 = temp_output_208_0_g18629;
				half sRGB8_g19400 = temp_output_9_0_g19400;
				half localGammaToLinearFloatFast8_g19400 = GammaToLinearFloatFast( sRGB8_g19400 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g19400 = temp_output_9_0_g19400;
				#else
				float staticSwitch1_g19400 = localGammaToLinearFloatFast8_g19400;
				#endif
				half Element_Values_Linear270_g18629 = staticSwitch1_g19400;
				half4 Colors37_g19403 = TVE_ColorsCoord;
				half4 Extras37_g19403 = TVE_ExtrasCoord;
				half4 Motion37_g19403 = TVE_MotionCoord;
				half4 Vertex37_g19403 = TVE_ReactCoord;
				half4 localIS_ELEMENT37_g19403 = IS_ELEMENT( Colors37_g19403 , Extras37_g19403 , Motion37_g19403 , Vertex37_g19403 );
				half4 temp_output_35_0_g19402 = localIS_ELEMENT37_g19403;
				half temp_output_7_0_g19397 = TVE_ElementsFadeValue;
				half2 temp_cast_4 = (temp_output_7_0_g19397).xx;
				half2 temp_output_244_0_g18629 = saturate( ( ( abs( (( (temp_output_35_0_g19402).zw + ( (temp_output_35_0_g19402).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_4 ) / ( 1.0 - temp_output_7_0_g19397 ) ) );
				half2 break247_g18629 = ( temp_output_244_0_g18629 * temp_output_244_0_g18629 );
				half Enable_Fade_Support111_g18629 = _ElementVolumeFadeMode;
				half lerpResult245_g18629 = lerp( 1.0 , ( 1.0 - saturate( ( break247_g18629.x + break247_g18629.y ) ) ) , Enable_Fade_Support111_g18629);
				half FadeOut_Mask254_g18629 = lerpResult245_g18629;
				half Element_Intensity235_g18629 = ( _ElementIntensity * FadeOut_Mask254_g18629 );
				half lerpResult285_g18629 = lerp( 1.0 , Element_Values_Linear270_g18629 , Element_Intensity235_g18629);
				half Element_BlendA433_g18629 = _ElementBlendA;
				half lerpResult444_g18629 = lerp( lerpResult285_g18629 , ( Element_Values_Linear270_g18629 * Element_Intensity235_g18629 ) , Element_BlendA433_g18629);
				half4 appendResult287_g18629 = (half4(0.0 , 0.0 , 0.0 , lerpResult444_g18629));
				
				
				finalColor = appendResult287_g18629;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TVEShaderElementGUI"
	
	
}
/*ASEBEGIN
Version=18934
1920;5;1920;1024;1076.946;1912.64;1;True;False
Node;AmplifyShaderEditor.FunctionNode;112;-640,-1152;Inherit;False;Base Terrain Elements;2;;18629;a84c2b02263ac4b42be9eb75f696cb74;3,222,1,413,0,225,3;0;1;FLOAT4;230
Node;AmplifyShaderEditor.FunctionNode;106;-640,-1408;Inherit;False;Define Element Extras;73;;19404;adca672cb6779794dba5f669b4c5f8e3;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-384,-1408;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Terrain Leaves Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-256,-1408;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Leaves elements to reduce the leaves amount or the alpha treshold. Useful to create winter sceneries or dead forests and dissolve effects. Make sure the element size matches your terrain., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;0,-1408;Inherit;False;Property;_render_src;_render_src;75;1;[HideInInspector];Create;True;0;0;0;True;0;False;2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;160,-1408;Inherit;False;Property;_render_dst;_render_dst;76;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-1152;Half;False;True;-1;2;TVEShaderElementGUI;0;1;BOXOPHOBIC/The Vegetation Engine/Elements/Terrain/Extras Alpha;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;0;5;False;-1;10;False;-1;1;0;True;113;0;True;114;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;2;False;-1;True;True;False;False;False;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;PreviewType=Plane;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;0;0;112;230
ASEEND*/
//CHKSM=877C54658C6CD4786000DB08E3CB83ABD72F58D0