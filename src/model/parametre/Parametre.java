package model.parametre;

import connection.BddObject;

public class Parametre extends BddObject {

    String nom;

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        if (nom.isEmpty())
            throw new IllegalArgumentException("Nom est vide");
        this.nom = nom;
    }

    public Parametre() throws Exception {
        super();
        this.setTable("parametre");
        this.setConnection("Oracle");
        this.setPrimaryKeyName("id_parametre");
    }

    public boolean check(Parametre parametre) {
        return this.getId().equals(parametre.getId()) && this.getNom().equals(parametre.getNom());
    }
    
}