using Godot;
using System;

public class player : Node2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	private Vector2 playerPosition = (0,0);

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}
	
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }

	public Vector2 PlayerGetPosition()
	{
		return playerPosition;
	}

	public void PlayerSetPosition(Vector2 pos)
	{
		playerPosition = pos;
	}
}
