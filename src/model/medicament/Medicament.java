package model.medicament;

import connection.BddObject;
import model.parametre.Parametre;
import model.sante.EtatSante;

public class Medicament extends BddObject {

    String nom;
    double prix;
    Parametre parametre;
    double effet;

    public Parametre getParametre() {
        return parametre;
    }

    public void setParametre(Parametre parametre) {
        this.parametre = parametre;
    }

    public double getEffet() {
        return effet;
    }

    public void setEffet(double effet) {
        this.effet = effet;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public double getRation(EtatSante sante) {
        return Math.ceil(sante.getEtat() / this.getEffet());
    }

    public Medicament(String nom, double prix, Parametre parametre, double effet) throws Exception {
        this();
        this.setNom(nom);
        this.setPrix(prix);
        this.setParametre(parametre);
        this.setEffet(effet);
    }

    public Medicament() throws Exception {
        super();
        this.setTable("medicament");
        this.setPrimaryKeyName("id_medicament");
        this.setConnection("Oracle");
    }
    
}