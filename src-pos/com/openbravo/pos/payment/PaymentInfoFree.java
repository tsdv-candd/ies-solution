//    uniCenta oPOS  - Touch Friendly Point Of Sale
//    Copyright (C) 2008-2009 Openbravo, S.L.
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

public class PaymentInfoFree extends PaymentInfo {
    
    private double m_dTotal;
    private double m_dTendered;
    private String m_dCardName =null;
   
    /** Creates a new instance of PaymentInfoFree */
    public PaymentInfoFree(double dTotal) {
        m_dTotal = dTotal;
    }

    @Override
    public PaymentInfo copyPayment(){
        return new PaymentInfoFree(m_dTotal);
    }    
    @Override
    public String getTransactionID(){
        return "no ID";
    }

    @Override
    public String getName() {
        return "free";
    }   
    @Override
    public double getTotal() {
        return m_dTotal;
    }
    @Override
    public double getPaid() {
        return (0.0); 
    }
    
    @Override
    public double getChange(){
       return (0.00);
   }
    
    @Override
    public double getTendered() {
       return m_dTendered;
   } 
    
    @Override
    public String getCardName() {
       return m_dCardName;
   } 

}
