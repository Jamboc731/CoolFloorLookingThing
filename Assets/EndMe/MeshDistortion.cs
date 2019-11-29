using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshDistortion : MonoBehaviour
{
    public int arrayLength = 10;
    Vector4[] thing = new Vector4[10];

    public Material mat;


    void Start()
    {
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        thing = mat.GetVectorArray("_VertPos");


        mesh.vertices = V4toV3(thing);

    }

    private Vector3[] V4toV3(Vector4[] a)
    {
        List<Vector3> b = new List<Vector3>();
        foreach (var i in a)
        {
            b.Add(i);
        }
        return b.ToArray();
    }

}
