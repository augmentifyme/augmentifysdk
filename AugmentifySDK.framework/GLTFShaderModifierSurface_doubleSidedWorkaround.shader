//
//  GLTFShaderModifierSurface_doubleSidedWorkaround.shader
//  GLTFSceneKit
//
//  Created by magicien on 2017/08/29.
//  Copyright © 2017 DarkHorse. All rights reserved.
//

#pragma arguments

float baseColorFactorR;
float baseColorFactorG;
float baseColorFactorB;
float baseColorFactorA;
float metallicFactor;
float roughnessFactor;
float3 emissiveFactor;

#pragma body

_surface.diffuse *= float4(baseColorFactorR, baseColorFactorG, baseColorFactorB, baseColorFactorA);
_surface.metalness *= metallicFactor;
_surface.roughness *= roughnessFactor;
_surface.emission.rgb *= emissiveFactor;

if(_surface.normal.z < 0){
    _surface.normal *= -1.0;
}
