package model.ordonnance;

import java.sql.Connection;
import connection.BddObject;
import model.maladie.Maladie;
import model.patient.Patient;

public class Ordonnance {

    Maladie[] maladies;
    Prescription[] prescriptions;

    public Maladie[] getMaladies() {
        return maladies;
    }

    public void setMaladies(Maladie[] maladies) {
        this.maladies = maladies;
    }

    public Prescription[] getPrescriptions() {
        return prescriptions;
    }

    public void setPrescriptions(Prescription[] prescriptions) {
        this.prescriptions = prescriptions;
    }
    
    public Ordonnance getSituationSanitaire(String[] params, String idPatient, Connection connection) throws Exception {
        boolean connect = false;
        Ordonnance ordonnance = null;
        try {
            if (connection == null) {
                connection = BddObject.getOracle();
                connect = true;
            }
            
            Patient patient = new Patient();
            patient.setId(idPatient);
            patient.ajouterParametre(params, connection);
            ordonnance = patient.getOrdonnance(connection);
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return ordonnance;
    }

}