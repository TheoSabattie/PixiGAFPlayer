package com.github.haxePixiGAF.data.config;

import com.github.haxePixiGAF.data.textures.TextureAtlas;
import com.github.haxePixiGAF.display.GAFScale9Texture;
import com.github.haxePixiGAF.display.GAFTexture;
import com.github.haxePixiGAF.display.IGAFTexture;
import pixi.core.math.Matrix;
import pixi.core.textures.Texture;

/**
 * TODO
 * @author Mathieu Anthoine
 * @private
 */
class CTextureAtlas
{
	//--------------------------------------------------------------------------
	//
	//  PUBLIC VARIABLES
	//
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//
	//  PRIVATE VARIABLES
	//
	//--------------------------------------------------------------------------

	private var _textureAtlasesDictionary:Map<String,Dynamic/*TODO: TextureAtlas*/>;
	private var _textureAtlasConfig:CTextureAtlasCSF;

	//--------------------------------------------------------------------------
	//
	//  CONSTRUCTOR
	//
	//--------------------------------------------------------------------------

	public function new(textureAtlasesDictionary:Dynamic, textureAtlasConfig:CTextureAtlasCSF)
	{
		_textureAtlasesDictionary=textureAtlasesDictionary;
		_textureAtlasConfig=textureAtlasConfig;
	}

	//--------------------------------------------------------------------------
	//
	//  PUBLIC METHODS
	//
	//--------------------------------------------------------------------------

	public static function createFromTextures(texturesDictionary:Dynamic,textureAtlasConfig:CTextureAtlasCSF):CTextureAtlas
	{
		var atlasesDictionary:Dynamic=new Map<String,Dynamic/*TODO: TextureAtlas*/>();

		//var atlas:TextureAtlas;
//
		//for(element in textureAtlasConfig.elements.elementsVector)
		//{
			//if(!atlasesDictionary[element.atlasID])
			//{
				//atlasesDictionary[element.atlasID]=new TextureAtlas(texturesDictionary[element.atlasID]);
			//}
//
			//atlas=atlasesDictionary[element.atlasID];
//
			//atlas.addRegion(element.id, element.region, null, element.rotated);
		//}

		return new CTextureAtlas(atlasesDictionary, textureAtlasConfig);
	}

	public function dispose():Void
	{
		for(textureAtlas in _textureAtlasesDictionary)
		{
			textureAtlas.dispose();
		}
	}

	public function getTexture(id:String):IGAFTexture
	{
		var textureAtlasElement:CTextureAtlasElement=_textureAtlasConfig.elements.getElement(id);
		if(textureAtlasElement!=null)
		{
			//var texture:Texture=gaf_internal::getTextureByIDAndAtlasID(id, textureAtlasElement.atlasID);
			var texture:Texture=getTextureByIDAndAtlasID(id, textureAtlasElement.atlasID);

			var pivotMatrix:Matrix;

			if(_textureAtlasConfig.elements.getElement(id)!=null)
			{
				pivotMatrix=_textureAtlasConfig.elements.getElement(id).pivotMatrix;
			}
			else
			{
				pivotMatrix=new Matrix();
			}

			if(textureAtlasElement.scale9Grid !=null)
			{
				return new GAFScale9Texture(id, texture, pivotMatrix, textureAtlasElement.scale9Grid);
			}
			else
			{
				return new GAFTexture(id, texture, pivotMatrix);
			}
		}

		return null;
	}

	//--------------------------------------------------------------------------
	//
	//  PRIVATE METHODS
	//
	//--------------------------------------------------------------------------

	//TODO: 
	/*gaf _private*/ public function getTextureByIDAndAtlasID(id:String, atlasID:String):Texture
	{
		var textureAtlas:TextureAtlas=_textureAtlasesDictionary[atlasID];

		return textureAtlas.getTexture(id);
	}

	//--------------------------------------------------------------------------
	//
	// OVERRIDDEN METHODS
	//
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//
	//  EVENT HANDLERS
	//
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//
	//  GETTERS AND SETTERS
	//
	//--------------------------------------------------------------------------
}