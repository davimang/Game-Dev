using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlyingBird : MonoBehaviour
{
    public GameObject birdPrefab;
    public float respawnTime = 5.0f;
    private Vector2 screenBounds;
    public int count = 0;
    // Use this for initialization
    void Start()
    {
        screenBounds = Camera.main.ScreenToWorldPoint(new Vector3(Screen.width, Screen.height, Camera.main.transform.position.z));
        StartCoroutine(birdSpawn());
    }
    private void spawnEnemy()
    {
        GameObject a = Instantiate(birdPrefab) as GameObject;
        a.transform.position = new Vector2(screenBounds.x * -2, Random.Range(-2, 6));
    }
    IEnumerator birdSpawn()
    {
        while (true)
        {
            yield return new WaitForSeconds(respawnTime);
            spawnEnemy();
            count++;
            if (count > 3 && respawnTime != 1) {
                respawnTime -= 1;
                count = 0;


            }
        }
    }

    
}
