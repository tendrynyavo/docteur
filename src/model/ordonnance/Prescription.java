package model.ordonnance;

import model.medicament.Medicament;
import model.parametre.Parametre;

public class Prescription extends Medicament {

    double nombre;
    
    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
    }

    public double getPrixTotal() {
        return this.getNombre() * this.getPrix();
    }

    public Prescription() throws Exception {
        super();
    }

    public Prescription(String nom, double prix, Parametre parametre, double effet, double nombre) throws Exception {
        super(nom, prix, parametre, effet);
        this.nombre = nombre;
    }

}