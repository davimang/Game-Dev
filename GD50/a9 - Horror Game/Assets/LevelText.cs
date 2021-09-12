using UnityEngine;
using UnityEngine.UI;
using System.Collections;

[RequireComponent(typeof(Text))]
public class LevelText : MonoBehaviour {

	
	private Text text;
	private int Level;

	// Use this for initialization
	void Start () {
		text = GetComponent<Text>();
	}

	// Update is called once per frame
	void Update () {
		
		Level = LevelGenerator.currentLevel;
		
		text.text = "Level:" + Level;
	}
}
