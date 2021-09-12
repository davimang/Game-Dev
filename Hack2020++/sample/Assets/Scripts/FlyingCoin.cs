using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlyingCoin : MonoBehaviour
{
    public GameObject coinPrefab;
    public float respawnTime = 5;
    private Vector2 screenBounds;
    
    // Use this for initialization
    void Start()
    {
        screenBounds = Camera.main.ScreenToWorldPoint(new Vector3(Screen.width, Screen.height, Camera.main.transform.position.z));
        StartCoroutine(coinSpawn());
    }
    private void spawnCoin()
    {
        GameObject a = Instantiate(coinPrefab) as GameObject;
        a.transform.position = new Vector2(screenBounds.x * -2, Random.Range(-2, 6));
    }
    IEnumerator coinSpawn()
    {
        while (true)
        {
            yield return new WaitForSeconds(respawnTime);
            spawnCoin();
            respawnTime = Random.Range(2, 10);
            
        }
    }


}
