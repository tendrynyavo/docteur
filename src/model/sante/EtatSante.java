package model.sante;

import model.parametre.Parametre;
import model.patient.Patient;

public class EtatSante extends Parametre {

    Patient patient;
    double etat;

    public double getEtat() {
        return etat;
    }

    public void setEtat(double etat) {
        if (etat < 0) 
            throw new IllegalArgumentException("Etat est negative");
        this.etat = etat;
    }

    public void setEtat(String etat) {
        if (etat.isEmpty())
            throw new IllegalArgumentException("Etat est vide");
        this.setEtat(Double.parseDouble(etat));
    }

    public Patient getPatient() {
        return patient;
    }
    
    public void setPatient(Patient patient) {
        this.patient = patient;
    }
    
    public EtatSante() throws Exception {
        super();
    }
    
}