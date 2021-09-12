using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;
using System.Collections.Generic;



public class DespawnOnHeight :  MonoBehaviour {
    
    
    public GameObject FPSController;
    void Start () {

    }

    void Update() {

        
        if (FPSController.transform.position.y < -20) {
            SceneManager.LoadScene("GameOver");
            LevelGenerator.currentLevel = 1;
            Destroy(GameObject.Find("WhisperSource"));
            
        }

    }
}