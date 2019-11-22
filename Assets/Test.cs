using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour
{

    Ray ray;
    RaycastHit hit;
    Camera cam;

    [SerializeField] Material mat;

    private void Start()
    {
        cam = GetComponent<Camera>();
    }

    private void Update()
    {
        ray = cam.ScreenPointToRay(Input.mousePosition);
        Physics.Raycast(ray, out hit, Mathf.Infinity);

        mat.SetVector("_Pos", hit.point);

    }

}
