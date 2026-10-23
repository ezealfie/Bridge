namespace Bridge.Models;

public class EjercicioAdulto
{
    public int id_ejercicioAdulto { get; set; }
    public int id_adultoMayor { get; set; }
    public int id_ejercicio { get; set; }
    public bool hecho { get; set; }
    public double? puntaje { get; set; }
    public DateTime? fechaRealizacion { get; set; }
}
