//    uniCenta oPOS  - Touch Friendly Point Of Sale
//    Copyright (c) 2009-2012 uniCenta
//    http://www.unicenta.net/unicentaopos
//
//    This file is part of uniCenta oPOS
//
//    uniCenta oPOS is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//   uniCenta oPOS is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with uniCenta oPOS.  If not, see <http://www.gnu.org/licenses/>.

package com.openbravo.pos.reports;

import com.openbravo.basic.BasicException;
import com.openbravo.data.gui.ComboBoxValModel;
import com.openbravo.data.loader.Datas;
import com.openbravo.data.loader.QBFCompareEnum;
import com.openbravo.data.loader.SerializerWrite;
import com.openbravo.data.loader.SerializerWriteBasic;
import com.openbravo.pos.forms.AppLocal;
import com.openbravo.pos.forms.AppView;
import com.openbravo.pos.inventory.MovementReason;
import java.awt.Component;

public class JParamsReason extends javax.swing.JPanel implements ReportEditorCreator {
    
    private ComboBoxValModel m_ReasonModel;
    
    /** Creates new form JParamsReason */
    public JParamsReason() {
        initComponents();
        
        m_ReasonModel = new ComboBoxValModel();
        m_ReasonModel.add(null);
        m_ReasonModel.add(MovementReason.IN_PURCHASE);
        m_ReasonModel.add(MovementReason.IN_REFUND);
        m_ReasonModel.add(MovementReason.IN_MOVEMENT);
        m_ReasonModel.add(MovementReason.OUT_SALE);
        m_ReasonModel.add(MovementReason.OUT_REFUND);
        m_ReasonModel.add(MovementReason.OUT_BREAK);
        m_ReasonModel.add(MovementReason.OUT_MOVEMENT);
        
        m_jreason.setModel(m_ReasonModel);
        // m_jreason.setSelectedItem(null);
    }
    
    @Override
    public void init(AppView app) {
    }

    @Override
    public void activate() throws BasicException {
    }

    @Override
    public SerializerWrite getSerializerWrite() {
        return new SerializerWriteBasic(new Datas[] {Datas.OBJECT, Datas.INT});
    }

    @Override
    public Component getComponent() {
        return this;
    }
    
    @Override
    public Object createValue() throws BasicException {
        
        return new Object[] {
            m_ReasonModel.getSelectedItem() == null ? QBFCompareEnum.COMP_NONE : QBFCompareEnum.COMP_EQUALS, m_ReasonModel.getSelectedKey()
        };
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel2 = new javax.swing.JLabel();
        m_jreason = new javax.swing.JComboBox();

        setBorder(javax.swing.BorderFactory.createTitledBorder(AppLocal.getIntString("label.byreason"))); // NOI18N
        setPreferredSize(new java.awt.Dimension(400, 60));
        setLayout(null);

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        jLabel2.setText(AppLocal.getIntString("label.stockreason")); // NOI18N
        add(jLabel2);
        jLabel2.setBounds(20, 20, 100, 25);

        m_jreason.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        add(m_jreason);
        m_jreason.setBounds(150, 20, 220, 25);
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel2;
    private javax.swing.JComboBox m_jreason;
    // End of variables declaration//GEN-END:variables
    
}
