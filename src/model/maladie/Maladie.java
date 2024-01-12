package model.maladie;

import model.patient.Patient;
import model.symptome.Symptome;
import connection.BddObject;

public class Maladie extends BddObject {

    String nom;
    Symptome[] symptomes;

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Symptome[] getSymptomes() {
        return symptomes;
    }

    public void setSymptomes(Symptome[] symptomes) {
        this.symptomes = symptomes;
    }

    public Maladie() throws Exception {
        super();
        this.setTable("maladie");
        this.setConnection("Oracle");
        this.setPrimaryKeyName("id_maladie");
    }

    public boolean verifier(Patient patient) {
        if (patient.getSantes().length < this.getSymptomes().length)
            throw new IllegalArgumentException("Sante du patient est insufficant");
        
        if (patient.getSantes().length > this.getSymptomes().length)
            throw new IllegalArgumentException("Symptome de la maladie est insufficant");

        for (int i = 0; i < symptomes.length; i++) {
            if (!symptomes[i].verifier(patient.getSantes()[i])) {
                return false;
            }
        }
        return true;
    }
    
}