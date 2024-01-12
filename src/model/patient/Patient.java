package model.patient;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.maladie.Maladie;
import model.medicament.StockMedicament;
import model.ordonnance.Ordonnance;
import model.ordonnance.Prescription;
import model.sante.EtatSante;
import model.symptome.Symptome;

public class Patient extends BddObject {
    
    String nom;
    @ColumnName("date_naissance")
    Date dateNaissance;
    EtatSante[] santes;

    public EtatSante[] getSantes() {
        return santes;
    }

    public void setSantes(EtatSante[] santes) {
        this.santes = santes;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        if (nom.isEmpty())
            throw new IllegalArgumentException("Nom est vide");
        this.nom = nom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public int getAge() {
        LocalDate now = new Date(System.currentTimeMillis()).toLocalDate();
        return calculateAge(this.getDateNaissance().toLocalDate(), now);
    }

    public static int calculateAge(LocalDate birthDate, LocalDate currentDate) {
        if ((birthDate != null) && (currentDate != null)) {
            return Period.between(birthDate, currentDate).getYears();
        } else {
            return 0;
        }
    }

    public void setDateNaissance(Date dateNaissance) {
        if (dateNaissance.after(new Date(System.currentTimeMillis())))
            throw new IllegalArgumentException("Date est invalide");
        this.dateNaissance = dateNaissance;
    }

    public void setDateNaissance(String dateNaissance) {
        if (dateNaissance.isEmpty())
            throw new IllegalArgumentException("Date de naissance est vide");
        this.setDateNaissance(Date.valueOf(dateNaissance));
    }

    public Patient() throws Exception {
        super();
        this.setTable("patient");
        this.setPrimaryKeyName("id_patient");
        this.setConnection("Oracle");
    }

    public void ajouterParametre(String[] params, Connection connection) throws Exception {
        boolean connect = false;
        EtatSante[] santes = null;
        try {
            
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }

            santes = (EtatSante[]) new EtatSante().findAll(connection, null);
            
            if (santes.length != params.length) 
                throw new IllegalArgumentException("Valeur n'est pas suffisant");
            
            for (int i = 0; i < santes.length; i++) {
                santes[i].setPatient(this);
                santes[i].setEtat(params[i]);
            }

        } finally {
            if (connect) {
                connection.close();
            }
        }
        this.setSantes(santes);
    }

    public Maladie[] getSusceptibleMaladies(Connection connection) throws Exception {
        String tmp = "";
        String sql = "SELECT * FROM V_MALADIE WHERE DEBUT <= %s AND %s <= FIN ORDER BY ID_PARAMETRE";
        List<Maladie> maladies = new ArrayList<>();
        Statement statement = null;
        ResultSet resultSet = null;
        boolean connect = false;
        try {
            if (connection == null) {
                connection = this.getConnection();
                connect = true;
            }
            statement = connection.createStatement();
            String age = Integer.toString(this.getAge());
            resultSet = statement.executeQuery(String.format(sql, age, age));
            List<Symptome> symptomes = new ArrayList<>();
            Maladie maladie = null;
            while (resultSet.next()) {
                if (!tmp.equals(resultSet.getString(1))) {
                    if (maladie != null) {
                        maladie.setSymptomes(symptomes.toArray(new Symptome[0]));
                        symptomes.clear();
                    }
                    maladie = new Maladie();
                    maladie.setId(resultSet.getString(1));
                    maladie.setNom(resultSet.getString(2));
                    maladies.add(maladie);
                    tmp = maladie.getId();
                }
                Symptome symptome = new Symptome();
                symptome.setId(resultSet.getString(5));
                symptome.setNom(resultSet.getString(6));
                symptome.setMin(resultSet.getInt(7));
                symptome.setMax(resultSet.getInt(8));
                symptomes.add(symptome);
                if (maladie != null)
                    maladie.setSymptomes(symptomes.toArray(new Symptome[0]));
            }
        } finally {
            if (resultSet != null)
                resultSet.close();
            if (statement != null) 
                statement.close();
            if (connect)
                connection.close();
        }
        return maladies.toArray(new Maladie[0]);
    }

    public Maladie[] predir(Connection connection) throws Exception {
        List<Maladie> results = new ArrayList<>();
        Maladie[] maladies = this.getSusceptibleMaladies(connection);
        for (Maladie maladie : maladies) {
            if (maladie.verifier(this)) {
                results.add(maladie);
            }
        }
        return results.toArray(new Maladie[0]);
    }

    public Prescription[] prescrire(Connection connection) throws Exception {
        StockMedicament stock = new StockMedicament().getEtaStockMedicament(connection);
        return stock.prescrire(this);
    }

    public Ordonnance getOrdonnance(Connection connection) throws Exception {
        boolean connect = false;
        Ordonnance ordonnance = new Ordonnance();
        try {
            if (connection == null) {
                connection = BddObject.getOracle();
                connect = true;
            }

            Patient patient = (Patient) new Patient().setId(this.getId()).getById(connection);
            if (patient == null)
                throw new IllegalArgumentException(String.format("Le patient %s n'existe pas", this.getId()));
            
            ordonnance.setMaladies(patient.predir(connection));
            ordonnance.setPrescriptions(patient.prescrire(connection));
        
        } finally {
            if (connect) {
                connection.close();
            }
        }
        return ordonnance;
    }

}