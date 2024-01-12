package model.symptome;

import model.maladie.Maladie;
import model.parametre.Parametre;
import model.sante.EtatSante;

public class Symptome extends Parametre {

    Maladie maladie;
    int min;
    int max;

    public Maladie getMaladie() {
        return maladie;
    }

    public void setMaladie(Maladie maladie) {
        this.maladie = maladie;
    }

    public int getMin() {
        return min;
    }

    public void setMin(int min) {
        this.min = min;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public Symptome() throws Exception {
        super();
    }

    public boolean verifier(EtatSante sante) {
        return this.check(sante) && (this.getMin() <= sante.getEtat() && sante.getEtat() <= this.getMax());
    }

}
