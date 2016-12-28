package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_50_50_RidePlatforms extends ActorScript
{
	public var _OnPlatform:Bool;
	public var _HitPlatform:Bool;
	public var _PlatformActorGroup:Group;
	public var _PlatformActor:Actor;
	public var _LeftKey:String;
	public var _RightKey:String;
	public var _JumpKey:String;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("On Platform?", "_OnPlatform");
		_OnPlatform = false;
		nameMap.set("Hit Platform?", "_HitPlatform");
		_HitPlatform = false;
		nameMap.set("Platform Actor Group", "_PlatformActorGroup");
		nameMap.set("Platform Actor", "_PlatformActor");
		nameMap.set("Left Key", "_LeftKey");
		nameMap.set("Right Key", "_RightKey");
		nameMap.set("Jump Key", "_JumpKey");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_OnPlatform = _HitPlatform;
				propertyChanged("_OnPlatform", _OnPlatform);
				_HitPlatform = false;
				propertyChanged("_HitPlatform", _HitPlatform);
				if(!(_OnPlatform))
				{
					return;
				}
				if((!(isKeyDown(_RightKey)) && (!(isKeyDown(_LeftKey)) && !(isKeyDown(_JumpKey)))))
				{
					if(((hasValue(_PlatformActor)) && _PlatformActor.isAlive()))
					{
						actor.setXVelocity(_PlatformActor.getXVelocity());
						actor.setYVelocity(_PlatformActor.getYVelocity());
					}
				}
			}
		});
		
		/* ======================== Something Else ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(event.thisFromBottom)
				{
					if((internalGetGroup(event.otherActor, event.otherShape, event) == _PlatformActorGroup))
					{
						_HitPlatform = true;
						propertyChanged("_HitPlatform", _HitPlatform);
						_PlatformActor = actor.getLastCollidedActor();
						propertyChanged("_PlatformActor", _PlatformActor);
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}