sce-cgc -quiet -profile sce_vp_rsx -entry VertexShader -o BinkPS3_VertexShader.bin BinkPS3_Shaders.cg
sce-cgc -quiet -profile sce_fp_rsx -entry YCrCbToRGB -o BinkPS3_YCrCbToRGB.bin BinkPS3_Shaders.cg
sce-cgc -quiet -profile sce_fp_rsx -entry YCrCbAToRGBA -o BinkPS3_YCrCbAToRGBA.bin BinkPS3_Shaders.cg
pause
