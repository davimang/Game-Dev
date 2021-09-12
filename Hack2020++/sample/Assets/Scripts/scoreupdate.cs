using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class scoreupdate : MonoBehaviour
{
    // Start is called before the first frame update
    public static int score = 0;
    Text currentScore;
    void Start()
    {
      currentScore =  GetComponent<Text> ();

    }

    // Update is called once per frame
    void Update()
    {
        currentScore.text = "Score: " + score;
    }
}
