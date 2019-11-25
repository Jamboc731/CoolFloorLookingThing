using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickToChangeShader : MonoBehaviour
{
    [SerializeField] Material mat;
    [SerializeField] Shader newShader;
    [SerializeField] Shader startShader;
    bool doTime;

    private void Start()
    {
        mat.shader = startShader;
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            mat.SetFloat("_T", 0);
            mat.SetVector("_RVec", new Vector4(Random.Range(0f, 1f), 0, Random.Range(0f, 1f), 0));
            doTime = true;
            mat.shader = newShader;
        }
        if (Input.GetMouseButtonDown(1))
        {
            doTime = false;
            mat.shader = startShader;
        }
        if (doTime) mat.SetFloat("_T", mat.GetFloat("_T") + Time.deltaTime);
    }

    private void OnDestroy()
    {
        mat.shader = startShader;
    }
}
