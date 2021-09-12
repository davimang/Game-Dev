using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;


public class LoadSceneOnGameOver : MonoBehaviour { 
    void Start() {

    }

    void Update () {
        if (Input.GetAxis("Submit") == 1) {
			SceneManager.LoadScene("Title");
        }
    }
}