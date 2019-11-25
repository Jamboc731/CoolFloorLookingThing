using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlockScript : MonoBehaviour
{

    [SerializeField] float heightChange;
    Vector3 lowHeight;
    Vector3 highHeight;
    [SerializeField] float maxDist;
    [SerializeField] float minDist;
    GameObject player;
    float distFromPlayer;
    float range;

    private void Start ()
    {
        range = maxDist - minDist;
        player = GameObject.Find ("Player");
        highHeight = transform.position;
    }

    private void Update ()
    {
        lowHeight = highHeight - new Vector3 (0, heightChange, 0);
        heightChange = player.transform.position.y;
        distFromPlayer = Vector3.Distance (highHeight, player.transform.position);

        distFromPlayer -= minDist;
        distFromPlayer = Mathf.Clamp (distFromPlayer, 0, Mathf.Infinity);

        transform.position = Vector3.Lerp (highHeight, lowHeight, Mathf.Clamp (distFromPlayer / range, 0, range));

    }
}
