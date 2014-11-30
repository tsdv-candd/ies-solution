//    uniCenta oPOS  - Touch Friendly Point Of Sale
//    Copyright (c) 2009-2013 uniCenta
//    http://www.unicenta.com
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

package com.openbravo.pos.payment;
import com.openbravo.data.gui.MessageInf;
import com.openbravo.format.Formats;
import com.openbravo.pos.customers.CustomerInfoExt;
import com.openbravo.pos.forms.AppConfig;
import com.openbravo.pos.forms.AppLocal;
import com.openbravo.pos.forms.DataLogicSystem;
import com.openbravo.pos.scripting.ScriptEngine;
import com.openbravo.pos.scripting.ScriptException;
import com.openbravo.pos.scripting.ScriptFactory;
import com.openbravo.pos.util.RoundUtils;
import com.openbravo.pos.util.ThumbNailBuilder;
import java.awt.Component;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.io.File;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.SwingConstants;

/**
 *
 * @author adrianromero
 */
public class JPaymentCashPosPart extends javax.swing.JPanel implements JPaymentInterface {
    
    private JPaymentNotifier m_notifier;

    private double m_dPaid;
    private double m_dTotal;  
    private Boolean priceWith00;
    //CanDD Add current debt
    private CustomerInfoExt customerext;
    
    /** Creates new form JPaymentCash */
    public JPaymentCashPosPart(JPaymentNotifier notifier, DataLogicSystem dlSystem) {
        
        m_notifier = notifier;
        
        initComponents();  
        
        m_jTendered.addPropertyChangeListener("Edition", new RecalculateState());
        m_jTendered.addEditorKeys(m_jKeys);
        
// added JDL 11.05.13        
        AppConfig m_config =  new AppConfig(new File((System.getProperty("user.home")), AppLocal.APP_ID + ".properties"));        
        m_config.load();        
        priceWith00 =("true".equals(m_config.getProperty("till.pricewith00")));
        if (priceWith00) {
            // use '00' instead of '.'
            m_jKeys.dotIs00(true);
        }
//        m_config=null;
       
        String code = dlSystem.getResourceAsXML("payment.cashpart");
        if (code != null) {
            try {
                ScriptEngine script = ScriptFactory.getScriptEngine(ScriptFactory.BEANSHELL);
                script.put("payment", new ScriptPaymentCash(dlSystem));    
                script.eval(code);
            } catch (ScriptException e) {
                MessageInf msg = new MessageInf(MessageInf.SGN_NOTICE, AppLocal.getIntString("message.cannotexecute"), e);
                msg.show(this);
            }
        }
        
    }
    
    @Override
    public void activate(CustomerInfoExt customerext, double dTotal, String transID) {
               
        this.customerext = customerext;       
        m_dTotal = dTotal;
        
        m_jTendered.reset();
        m_jTendered.activate();
        
        printState();        
    }
    @Override
    public PaymentInfo executePayment() {
        if (m_dTotal - m_dPaid >= 0.0) {
            // pago completo
            return new PaymentInfoCashPart_original(m_dTotal, m_dPaid);
        } else {
            // pago parcial
            //CanDD return new PaymentInfoCashPart_original(m_dPaid, m_dPaid);
            return null;
        }        
    }
    @Override
    public Component getComponent() {
        return this;
    }
    
    private void printState() {

        jlblMessage.setText(null);
        Double value = m_jTendered.getDoubleValue();
        if (value == null || value == 0.0) {
            //CanDD modify default of Debt
            //m_dPaid = m_dTotal;
            m_dPaid = 0.0;
        } else {
            m_dPaid = value;
        }
        m_jMoneyEuros.setText(Formats.CURRENCY.formatValue(new Double(m_dPaid)));
//                m_jRemainingDebt.setText(iCompare > 0
//                        //                CanDD change ? Formats.CURRENCY.formatValue(new Double(m_dPaid - m_dTotal))
//                        ? Formats.CURRENCY.formatValue(new Double(m_dTotal - m_dPaid))
//                        : null);
        m_jRemainingDebt.setText(Formats.CURRENCY.formatValue(new Double(m_dTotal - m_dPaid)));
        //CanDD Add for checking status of the current debt
        if (customerext == null) {
            m_jMoneyEuros.setText(null);
            jlblMessage.setText(AppLocal.getIntString("message.nocustomernodebt"));
            m_notifier.setStatus(false, false);
        } else {
            //if (RoundUtils.compare(RoundUtils.getValue(customerext.getCurdebt()) + m_dPaid, RoundUtils.getValue(customerext.getMaxdebt())) >= 0) {
            if (RoundUtils.compare(RoundUtils.getValue(m_dTotal - m_dPaid), RoundUtils.getValue(customerext.getMaxdebt())) >= 0) {
                // maximum debt exceded
                jlblMessage.setText(AppLocal.getIntString("message.customerdebtexceded"));
                m_notifier.setStatus(false, false);
            } else {
                //CanDD modify int iCompare = RoundUtils.compare(m_dPaid, m_dTotal);
                int iCompare = RoundUtils.compare(m_dPaid, m_dTotal);
                m_notifier.setStatus(m_dPaid > 0.0, iCompare <= 0);
                if (iCompare >= 0) {
                    jlblMessage.setText(AppLocal.getIntString("message.customerdebtnegative"));
                }
            }
        }
    }
    
    private class RecalculateState implements PropertyChangeListener {
        @Override
        public void propertyChange(PropertyChangeEvent evt) {
            printState();
        }
    }    
    
    public class ScriptPaymentCash {
        
        private DataLogicSystem dlSystem;
        private ThumbNailBuilder tnbbutton;
        private AppConfig m_config;
        
        public ScriptPaymentCash(DataLogicSystem dlSystem) {
//added 19.04.13 JDL        
            AppConfig m_config =  new AppConfig(new File((System.getProperty("user.home")), AppLocal.APP_ID + ".properties"));        
            m_config.load();
            this.m_config = m_config;
        
            this.dlSystem = dlSystem;
            tnbbutton = new ThumbNailBuilder(64, 50, "com/openbravo/images/cash.png");
        }
        
        public void addButton(String image, double amount) {
            JButton btn = new JButton();
//added 19.04.13 JDL removal of text on payment buttons if required.   
            try {
            if ((m_config.getProperty("payments.textoverlay")).equals("true")){
                     btn.setIcon(new ImageIcon(tnbbutton.getThumbNailText(dlSystem.getResourceAsImage(image),"")));  
            } else {
                     btn.setIcon(new ImageIcon(tnbbutton.getThumbNailText(dlSystem.getResourceAsImage(image), Formats.CURRENCY.formatValue(amount)))); 
            }
            } catch (Exception e){
                    btn.setIcon(new ImageIcon(tnbbutton.getThumbNailText(dlSystem.getResourceAsImage(image), Formats.CURRENCY.formatValue(amount))));        
            }   
            
            btn.setFocusPainted(false);
            btn.setFocusable(false);
            btn.setRequestFocusEnabled(false);
            btn.setHorizontalTextPosition(SwingConstants.CENTER);
            btn.setVerticalTextPosition(SwingConstants.BOTTOM);
            btn.setMargin(new Insets(2, 2, 2, 2));
            btn.addActionListener(new AddAmount(amount));
            jPanel6.add(btn);  
        }
    }
    
    
    
    private class AddAmount implements ActionListener {        
        private double amount;
        public AddAmount(double amount) {
            this.amount = amount;
        }
        @Override
        public void actionPerformed(ActionEvent e) {
            Double tendered = m_jTendered.getDoubleValue();
 
            if (tendered == null) {
                 m_jTendered.setDoubleValue(amount);
            } else {
              m_jTendered.setDoubleValue(tendered + amount);    
              
            }

            printState();
        }
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel5 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        m_jRemainingDebt = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        m_jMoneyEuros = new javax.swing.JLabel();
        jPanel6 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jPanel1 = new javax.swing.JPanel();
        m_jKeys = new com.openbravo.editor.JEditorKeys();
        jPanel3 = new javax.swing.JPanel();
        m_jTendered = new com.openbravo.editor.JEditorCurrencyPositive();
        jPanel7 = new javax.swing.JPanel();
        jlblMessage = new javax.swing.JTextArea();

        setLayout(new java.awt.BorderLayout());

        jPanel5.setLayout(new java.awt.BorderLayout());

        jPanel4.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        jPanel4.setPreferredSize(new java.awt.Dimension(0, 70));
        jPanel4.setLayout(null);

        m_jRemainingDebt.setBackground(new java.awt.Color(255, 255, 255));
        m_jRemainingDebt.setFont(new java.awt.Font("Arial", 0, 18)); // NOI18N
        m_jRemainingDebt.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        m_jRemainingDebt.setBorder(javax.swing.BorderFactory.createCompoundBorder(javax.swing.BorderFactory.createLineBorder(javax.swing.UIManager.getDefaults().getColor("Button.darkShadow")), javax.swing.BorderFactory.createEmptyBorder(1, 4, 1, 4)));
        m_jRemainingDebt.setOpaque(true);
        m_jRemainingDebt.setPreferredSize(new java.awt.Dimension(180, 30));
        jPanel4.add(m_jRemainingDebt);
        m_jRemainingDebt.setBounds(120, 36, 180, 30);

        jLabel6.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel6.setText(AppLocal.getIntString("Label.RemainingDebt")); // NOI18N
        jLabel6.setPreferredSize(new java.awt.Dimension(100, 30));
        jPanel4.add(jLabel6);
        jLabel6.setBounds(10, 36, 100, 30);

        jLabel8.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        jLabel8.setText(AppLocal.getIntString("Label.InputCash")); // NOI18N
        jLabel8.setPreferredSize(new java.awt.Dimension(100, 30));
        jPanel4.add(jLabel8);
        jLabel8.setBounds(10, 4, 100, 30);

        m_jMoneyEuros.setBackground(new java.awt.Color(204, 255, 51));
        m_jMoneyEuros.setFont(new java.awt.Font("Arial", 1, 18)); // NOI18N
        m_jMoneyEuros.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        m_jMoneyEuros.setBorder(javax.swing.BorderFactory.createCompoundBorder(javax.swing.BorderFactory.createLineBorder(javax.swing.UIManager.getDefaults().getColor("Button.darkShadow")), javax.swing.BorderFactory.createEmptyBorder(1, 4, 1, 4)));
        m_jMoneyEuros.setOpaque(true);
        m_jMoneyEuros.setPreferredSize(new java.awt.Dimension(180, 30));
        jPanel4.add(m_jMoneyEuros);
        m_jMoneyEuros.setBounds(120, 4, 180, 30);

        jPanel5.add(jPanel4, java.awt.BorderLayout.NORTH);
        jPanel5.add(jPanel6, java.awt.BorderLayout.CENTER);

        add(jPanel5, java.awt.BorderLayout.CENTER);

        jPanel2.setLayout(new java.awt.BorderLayout());

        jPanel1.setLayout(new javax.swing.BoxLayout(jPanel1, javax.swing.BoxLayout.Y_AXIS));
        jPanel1.add(m_jKeys);

        jPanel3.setBorder(javax.swing.BorderFactory.createEmptyBorder(5, 5, 5, 5));
        jPanel3.setLayout(new java.awt.BorderLayout());

        m_jTendered.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        jPanel3.add(m_jTendered, java.awt.BorderLayout.CENTER);

        jPanel1.add(jPanel3);

        jPanel2.add(jPanel1, java.awt.BorderLayout.NORTH);

        jlblMessage.setEditable(false);
        jlblMessage.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        jlblMessage.setForeground(new java.awt.Color(255, 0, 51));
        jlblMessage.setLineWrap(true);
        jlblMessage.setWrapStyleWord(true);
        jlblMessage.setBorder(javax.swing.BorderFactory.createEtchedBorder());
        jlblMessage.setFocusable(false);
        jlblMessage.setPreferredSize(new java.awt.Dimension(198, 86));
        jlblMessage.setRequestFocusEnabled(false);
        jPanel7.add(jlblMessage);

        jPanel2.add(jPanel7, java.awt.BorderLayout.CENTER);

        add(jPanel2, java.awt.BorderLayout.LINE_END);
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JTextArea jlblMessage;
    private com.openbravo.editor.JEditorKeys m_jKeys;
    private javax.swing.JLabel m_jMoneyEuros;
    private javax.swing.JLabel m_jRemainingDebt;
    private com.openbravo.editor.JEditorCurrencyPositive m_jTendered;
    // End of variables declaration//GEN-END:variables
    
}
