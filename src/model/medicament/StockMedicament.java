package model.medicament;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import agregation.Liste;
import connection.BddObject;
import model.ordonnance.Prescription;
import model.parametre.Parametre;
import model.patient.Patient;
import model.sante.EtatSante;

public class StockMedicament {

    Medicament[] medicaments;

    public Medicament[] getMedicaments() {
        return medicaments;
    }

    public void setMedicaments(Medicament[] medicaments) {
        this.medicaments = medicaments;
    }

    public StockMedicament getEtaStockMedicament(Connection connection) throws Exception {
        boolean connect = false;
        try {
            if (connection == null) {
                connection = BddObject.getOracle();
                connect = true;
            }

            Medicament medicament = new Medicament();
            medicament.setTable("V_MEDICAMENT");
            this.setMedicaments((Medicament[]) medicament.findAll(connection, "ID_PARAMETRE"));
        
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return this;
    }

    public Medicament[] getMedicaments(Parametre parametre) {
        List<Medicament> results = new ArrayList<>();
        for (Medicament medicament : this.getMedicaments()) {
            if (medicament.getParametre().check(parametre))
                results.add(medicament);
        }
        return results.toArray(new Medicament[0]);
    }

    public Prescription[] prescrire(EtatSante sante) throws Exception {
        Medicament[] medicaments = this.getMedicaments(sante);
        Prescription[] prescriptions = new Prescription[medicaments.length];
        for (int i = 0; i < prescriptions.length; i++) {
            prescriptions[i] = new Prescription(medicaments[i].getNom(), medicaments[i].getPrix(), sante, medicaments[i].getEffet(), medicaments[i].getRation(sante));
            prescriptions[i].setId(medicaments[i].getId());
        }
        return prescriptions;
    }

    public Prescription[] prescrire(Patient patient) throws Exception {
        EtatSante[] santes = patient.getSantes();
        List<Prescription> results = new ArrayList<>();
        for (EtatSante etatSante : santes) {
            if (etatSante.getEtat() != 0)
                results.add(this.prescrirMin(etatSante));
        }
        return results.toArray(new Prescription[0]);
    }
    
    public Prescription prescrirMin(EtatSante sante) throws Exception {
        return (Prescription) Liste.min(this.prescrire(sante), "getPrixTotal");
    }

}