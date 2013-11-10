--    uniCenta oPOS - Touch Friendly Point Of Sale
--    Copyright (C) 2009-2013 uniCenta
--    http://sourceforge.net/projects/unicentaopos
--
--    This file is part of uniCenta oPOS.
--
--    uniCenta oPOS is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    uniCenta oPOS is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with uniCenta oPOS.  If not, see <http://www.gnu.org/licenses/>.

-- Database create script for ORACLE
-- Copyright (c) 2009-2013 uniCenta
-- v3.50

CREATE TABLE APPLICATIONS (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    VERSION VARCHAR2(1024) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE ROLES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    PERMISSIONS BLOB,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX ROLES_NAME_INX ON ROLES(NAME);
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('0', 'Administrator role', $FILE{/com/openbravo/pos/templates/Role.Administrator.xml} );
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('1', 'Manager role', $FILE{/com/openbravo/pos/templates/Role.Manager.xml} );
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('2', 'Employee role', $FILE{/com/openbravo/pos/templates/Role.Employee.xml} );
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('3', 'Guest role', $FILE{/com/openbravo/pos/templates/Role.Guest.xml} );

CREATE TABLE PEOPLE (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    APPPASSWORD VARCHAR2(1024),
    CARD VARCHAR2(1024),
    ROLE VARCHAR2(256) NOT NULL,
    VISIBLE NUMERIC(1) NOT NULL,
    IMAGE BLOB,
    PRIMARY KEY (ID),
    CONSTRAINT PEOPLE_FK_1 FOREIGN KEY (ROLE) REFERENCES ROLES(ID)
);
CREATE UNIQUE INDEX PEOPLE_NAME_INX ON PEOPLE(NAME);
CREATE INDEX PEOPLE_CARD_INX ON PEOPLE(CARD);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('0', 'Administrator', NULL, '0', 1, NULL);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('1', 'Manager', NULL, '1', 1, NULL);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('2', 'Employee', NULL, '2', 1, NULL);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('3', 'Guest', NULL, '3', 1, NULL);


CREATE TABLE RESOURCES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    RESTYPE INTEGER NOT NULL,
    CONTENT BLOB,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX RESOURCES_NAME_INX ON RESOURCES(NAME);

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('0', 'Menu.Root', 0, $FILE{/com/openbravo/pos/templates/Menu.Root.txt});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('1', 'coin.2', 1, $FILE{/com/openbravo/pos/templates/coin.2.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('2', 'coin.1', 1, $FILE{/com/openbravo/pos/templates/coin.1.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('3', 'coin.50', 1, $FILE{/com/openbravo/pos/templates/coin.50.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('4', 'coin.20', 1, $FILE{/com/openbravo/pos/templates/coin.20.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('5', 'coin.10', 1, $FILE{/com/openbravo/pos/templates/coin.10.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('6', 'coin.05', 1, $FILE{/com/openbravo/pos/templates/coin.05.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('7', 'coin.02', 1, $FILE{/com/openbravo/pos/templates/coin.02.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('8', 'coin.01', 1, $FILE{/com/openbravo/pos/templates/coin.01.png});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('9', 'img.cash', 1, $FILE{/com/openbravo/pos/templates/img.cash.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('10', 'img.cashdrawer', 1, $FILE{/com/openbravo/pos/templates/img.cashdrawer.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('11', 'img.discount', 1, $FILE{/com/openbravo/pos/templates/img.discount.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('12', 'img.empty', 1, $FILE{/com/openbravo/pos/templates/img.empty.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('13', 'img.heart', 1, $FILE{/com/openbravo/pos/templates/img.heart.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('14', 'img.no_photo', 1, $FILE{/com/openbravo/pos/templates/img.no_photo.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('15', 'img.kit_print', 1, $FILE{/com/openbravo/pos/templates/img.kit_print.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('16', 'img.refundit', 1, $FILE{/com/openbravo/pos/templates/img.refundit.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('17', 'img.run_script', 1, $FILE{/com/openbravo/pos/templates/img.run_script.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('18', 'img.ticket_print', 1, $FILE{/com/openbravo/pos/templates/img.ticket_print.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('19', 'img.user', 1, $FILE{/com/openbravo/pos/templates/img.user.png});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('20', 'note.50', 1, $FILE{/com/openbravo/pos/templates/note.50.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('21', 'note.20', 1, $FILE{/com/openbravo/pos/templates/note.20.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('22', 'note.10', 1, $FILE{/com/openbravo/pos/templates/note.10.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('23', 'note.5', 1, $FILE{/com/openbravo/pos/templates/note.5.png});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('24', 'payment.cash', 0, $FILE{/com/openbravo/pos/templates/payment.cash.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('25', 'Printer.CloseCash', 0, $FILE{/com/openbravo/pos/templates/Printer.CloseCash.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('26', 'Printer.CustomerPaid', 0, $FILE{/com/openbravo/pos/templates/Printer.CustomerPaid.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('27', 'Printer.CustomerPaid2', 0, $FILE{/com/openbravo/pos/templates/Printer.CustomerPaid2.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('28', 'Printer.FiscalTicket', 0, $FILE{/com/openbravo/pos/templates/Printer.FiscalTicket.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('29', 'Printer.Inventory', 0, $FILE{/com/openbravo/pos/templates/Printer.Inventory.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('30', 'Printer.OpenDrawer', 0, $FILE{/com/openbravo/pos/templates/Printer.OpenDrawer.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('31', 'Printer.PartialCash', 0, $FILE{/com/openbravo/pos/templates/Printer.PartialCash.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('32', 'Printer.Product', 0, $FILE{/com/openbravo/pos/templates/Printer.Product.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('33', 'Printer.Start', 0, $FILE{/com/openbravo/pos/templates/Printer.Start.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('34', 'Printer.Ticket', 0, $FILE{/com/openbravo/pos/templates/Printer.Ticket.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('35', 'Printer.Ticket2', 0, $FILE{/com/openbravo/pos/templates/Printer.Ticket2.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('36', 'Printer.TicketClose', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketClose.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('37', 'Printer.TicketKitchen', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketKitchen.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('38', 'Printer.TicketLine', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketLine.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('39', 'Printer.TicketNew', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketLine.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('40', 'Printer.TicketPreview', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketPreview.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('41', 'Printer.TicketTotal', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketTotal.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('42', 'Printer.Ticket.Logo', 1, $FILE{/com/openbravo/pos/templates/Printer.Ticket.Logo.png});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('43', 'script.AddLineNote', 0, $FILE{/com/openbravo/pos/templates/script.AddLineNote.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('44', 'script.Event.Total', 0, $FILE{/com/openbravo/pos/templates/script.Event.Total.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('45', 'script.linediscount', 0, $FILE{/com/openbravo/pos/templates/script.linediscount.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('46', 'script.ReceiptConsolidate', 0, $FILE{/com/openbravo/pos/templates/script.ReceiptConsolidate.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('47', 'script.Refundit', 0, $FILE{/com/openbravo/pos/templates/script.Refundit.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('48', 'script.SendOrder', 0, $FILE{/com/openbravo/pos/templates/script.SendOrder.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('49', 'script.ServiceCharge', 0, $FILE{/com/openbravo/pos/templates/script.script.ServiceCharge.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('50', 'script.SetPerson', 0, $FILE{/com/openbravo/pos/templates/script.SetPerson.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('51', 'script.StockCurrentAdd', 0, $FILE{/com/openbravo/pos/templates/script.StockCurrentAdd.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('52', 'script.StockCurrentSet', 0, $FILE{/com/openbravo/pos/templates/script.StockCurrentSet.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('53', 'script.totaldiscount', 0, $FILE{/com/openbravo/pos/templates/script.totaldiscount.txt});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('54', 'Ticket.Buttons', 0, $FILE{/com/openbravo/pos/templates/Ticket.Buttons.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('55', 'Ticket.Close', 0, $FILE{/com/openbravo/pos/templates/Ticket.Close.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('56', 'Ticket.Discount', 0, $FILE{/com/openbravo/pos/templates/Ticket.Discount.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('57', 'Ticket.Line', 0, $FILE{/com/openbravo/pos/templates/Ticket.Line.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('58', 'Ticket.TicketLineTaxesIncluded', 0, $FILE{/com/openbravo/pos/templates/Ticket.TicketLineTaxesIncluded.xml});

INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('59', 'Window.Logo', 1, $FILE{/com/openbravo/pos/templates/Window.Logo.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('60', 'Window.Title', 0, $FILE{/com/openbravo/pos/templates/Window.Title.txt});

CREATE TABLE TAXCUSTCATEGORIES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX TAXCUSTCAT_NAME_INX ON TAXCUSTCATEGORIES(NAME);

CREATE TABLE CUSTOMERS (
    ID VARCHAR2(256) NOT NULL,
    SEARCHKEY VARCHAR2(1024) NOT NULL,
    TAXID VARCHAR2(1024),
    NAME VARCHAR2(1024) NOT NULL,
    TAXCATEGORY VARCHAR2(256),
    CARD VARCHAR2(1024),
    MAXDEBT DOUBLE PRECISION DEFAULT 0 NOT NULL,
    ADDRESS VARCHAR2(1024),
    ADDRESS2 VARCHAR2(1024),
    POSTAL VARCHAR2(1024),
    CITY VARCHAR2(1024),
    REGION VARCHAR2(1024),
    COUNTRY VARCHAR2(1024),
    FIRSTNAME VARCHAR2(1024),
    LASTNAME VARCHAR2(1024),
    EMAIL VARCHAR2(1024),
    PHONE VARCHAR2(1024),
    PHONE2 VARCHAR2(1024),
    FAX VARCHAR2(1024),
    NOTES VARCHAR2(1024),
    VISIBLE NUMERIC(1) DEFAULT 1 NOT NULL,
    CURDATE TIMESTAMP,
    CURDEBT DOUBLE PRECISION DEFAULT 0 NOT NULL,
    IMAGE BLOB,
    PRIMARY KEY (ID),
    CONSTRAINT CUSTOMERS_TAXCAT FOREIGN KEY (TAXCATEGORY) REFERENCES TAXCUSTCATEGORIES(ID)
);
CREATE UNIQUE INDEX CUSTOMERS_SKEY_INX ON CUSTOMERS(SEARCHKEY);
CREATE INDEX CUSTOMERS_TAXID_INX ON CUSTOMERS(TAXID);
CREATE INDEX CUSTOMERS_NAME_INX ON CUSTOMERS(NAME);
CREATE INDEX CUSTOMERS_CARD_INX ON CUSTOMERS(CARD);

CREATE TABLE CATEGORIES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    PARENTID VARCHAR2(256),
    IMAGE BLOB,
    TEXTTIP VARCHAR(256) DEFAULT '',
    CATSHOWNAME NUMERIC(1) DEFAULT 1 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT CATEGORIES_FK_1 FOREIGN KEY (PARENTID) REFERENCES CATEGORIES(ID)
);
CREATE UNIQUE INDEX CATEGORIES_NAME_INX ON CATEGORIES(NAME);
INSERT INTO CATEGORIES(ID, NAME) VALUES ('000', 'Category Standard');

CREATE TABLE TAXCATEGORIES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX TAXCAT_NAME_INX ON TAXCATEGORIES(NAME);
INSERT INTO TAXCATEGORIES(ID, NAME) VALUES ('000', 'Tax Exempt');
INSERT INTO TAXCATEGORIES(ID, NAME) VALUES ('001', 'Tax Standard');

CREATE TABLE TAXES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    CATEGORY VARCHAR2(256) NOT NULL,
    CUSTCATEGORY VARCHAR2(256),
    PARENTID VARCHAR2(256),
    RATE DOUBLE PRECISION DEFAULT 0 NOT NULL,
    RATECASCADE NUMERIC(1) DEFAULT 0 NOT NULL,
    RATEORDER INTEGER,
    PRIMARY KEY (ID),
    CONSTRAINT TAXES_CAT_FK FOREIGN KEY (CATEGORY) REFERENCES TAXCATEGORIES(ID),
    CONSTRAINT TAXES_CUSTCAT_FK FOREIGN KEY (CUSTCATEGORY) REFERENCES TAXCUSTCATEGORIES(ID),
    CONSTRAINT TAXES_TAXES_FK FOREIGN KEY (PARENTID) REFERENCES TAXES(ID)
);
CREATE UNIQUE INDEX TAXES_NAME_INX ON TAXES(NAME);
INSERT INTO TAXES(ID, NAME, CATEGORY, CUSTCATEGORY, PARENTID, RATE, RATECASCADE, RATEORDER) VALUES ('000', 'Tax Exempt', '000', NULL, NULL, 0, 0, NULL);
INSERT INTO TAXES(ID, NAME, CATEGORY, CUSTCATEGORY, PARENTID, RATE, RATECASCADE, RATEORDER) VALUES ('001', 'Tax Standard', '001', NULL, NULL, 0.10, 0, NULL);

CREATE TABLE ATTRIBUTE (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE ATTRIBUTEVALUE (
    ID VARCHAR2(256) NOT NULL,
    ATTRIBUTE_ID VARCHAR2(256) NOT NULL,
    VALUE VARCHAR2(1024),
    PRIMARY KEY (ID),
    CONSTRAINT ATTVAL_ATT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE(ID) ON DELETE CASCADE
);

CREATE TABLE ATTRIBUTESET (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE ATTRIBUTEUSE (
    ID VARCHAR2(256) NOT NULL,
    ATTRIBUTESET_ID VARCHAR2(256) NOT NULL,
    ATTRIBUTE_ID VARCHAR2(256) NOT NULL,
    LINENO INTEGER,
    PRIMARY KEY (ID),
    CONSTRAINT ATTUSE_SET FOREIGN KEY (ATTRIBUTESET_ID) REFERENCES ATTRIBUTESET(ID) ON DELETE CASCADE,
    CONSTRAINT ATTUSE_ATT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE(ID)
);
CREATE UNIQUE INDEX ATTUSE_LINE ON ATTRIBUTEUSE(ATTRIBUTESET_ID, LINENO);

CREATE TABLE ATTRIBUTESETINSTANCE (
    ID VARCHAR2(256) NOT NULL,
    ATTRIBUTESET_ID VARCHAR2(256) NOT NULL,
    DESCRIPTION VARCHAR2(1024),
    PRIMARY KEY (ID),
    CONSTRAINT ATTSETINST_SET FOREIGN KEY (ATTRIBUTESET_ID) REFERENCES ATTRIBUTESET(ID) ON DELETE CASCADE
);

CREATE TABLE ATTRIBUTEINSTANCE (
    ID VARCHAR2(256) NOT NULL,
    ATTRIBUTESETINSTANCE_ID VARCHAR2(256) NOT NULL,
    ATTRIBUTE_ID VARCHAR2(256) NOT NULL,
    VALUE VARCHAR2(1024),
    PRIMARY KEY (ID),
    CONSTRAINT ATTINST_SET FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID) ON DELETE CASCADE,
    CONSTRAINT ATTINST_ATT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE(ID)
);

CREATE TABLE PRODUCTS (
    ID VARCHAR2(256) NOT NULL,
    REFERENCE VARCHAR2(1024) NOT NULL,
    CODE VARCHAR2(1024) NOT NULL,
    CODETYPE VARCHAR2(1024),
    NAME VARCHAR2(1024) NOT NULL,
    PRICEBUY DOUBLE PRECISION DEFAULT 0 NOT NULL,
    PRICESELL DOUBLE PRECISION DEFAULT 0 NOT NULL,
    CATEGORY VARCHAR2(256) NOT NULL,
    TAXCAT VARCHAR2(256) NOT NULL,
    ATTRIBUTESET_ID VARCHAR2(256),
    STOCKCOST DOUBLE PRECISION DEFAULT 0 NOT NULL,
    STOCKVOLUME DOUBLE PRECISION DEFAULT 0 NOT NULL,
    IMAGE BLOB,
    ISCOM  NUMERIC(1) DEFAULT 0 NOT NULL,
    ISSCALE  NUMERIC(1) DEFAULT 0 NOT NULL,
    ISKITCHEN  NUMERIC(1) DEFAULT 0 NOT NULL,
    PRINTKB  NUMERIC(1) DEFAULT 0 NOT NULL,
    SENDSTATUS  NUMERIC(1) DEFAULT 0 NOT NULL,
    ISSERVICE  NUMERIC(1) DEFAULT 0 NOT NULL,
    ATTRIBUTES BLOB,
    DISPLAY VARCHAR2(1024),
    ISVPRICE  NUMERIC(1) DEFAULT 0 NOT NULL,
    ISVERPATRIB  NUMERIC(1) DEFAULT 0 NOT NULL,
    TEXTTIP VARCHAR(256) DEFAULT '',
    WARRANTY  NUMERIC(1) DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PRODUCTS_FK_1 FOREIGN KEY (CATEGORY) REFERENCES CATEGORIES(ID),
    CONSTRAINT PRODUCTS_TAXCAT_FK FOREIGN KEY (TAXCAT) REFERENCES TAXCATEGORIES(ID),
    CONSTRAINT PRODUCTS_ATTRSET_FK FOREIGN KEY (ATTRIBUTESET_ID) REFERENCES ATTRIBUTESET(ID)
);
CREATE UNIQUE INDEX PRODUCTS_INX_0 ON PRODUCTS(REFERENCE);
CREATE UNIQUE INDEX PRODUCTS_INX_1 ON PRODUCTS(CODE);
CREATE UNIQUE INDEX PRODUCTS_NAME_INX ON PRODUCTS(NAME);

CREATE TABLE PRODUCTS_CAT (
    PRODUCT VARCHAR2(256) NOT NULL,
    CATORDER INTEGER,
    PRIMARY KEY (PRODUCT),
    CONSTRAINT PRODUCTS_CAT_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID)
);
CREATE INDEX PRODUCTS_CAT_INX_1 ON PRODUCTS_CAT(CATORDER);

CREATE TABLE PRODUCTS_COM (
    ID VARCHAR2(256) NOT NULL,
    PRODUCT VARCHAR2(256) NOT NULL,
    PRODUCT2 VARCHAR2(256) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PRODUCTS_COM_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT PRODUCTS_COM_FK_2 FOREIGN KEY (PRODUCT2) REFERENCES PRODUCTS(ID)
);
CREATE UNIQUE INDEX PCOM_INX_PROD ON PRODUCTS_COM(PRODUCT, PRODUCT2);

CREATE TABLE LOCATIONS (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    ADDRESS VARCHAR2(1024),
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX LOCATIONS_NAME_INX ON LOCATIONS(NAME);
INSERT INTO LOCATIONS(ID, NAME,ADDRESS) VALUES('0', 'General', NULL);

CREATE TABLE STOCKDIARY (
    ID VARCHAR2(256) NOT NULL,
    DATENEW TIMESTAMP NOT NULL,
    REASON INTEGER NOT NULL,
    LOCATION VARCHAR2(256) NOT NULL,
    PRODUCT VARCHAR2(256) NOT NULL,
    ATTRIBUTESETINSTANCE_ID VARCHAR2(256),
    UNITS DOUBLE PRECISION DEFAULT 0 NOT NULL,
    PRICE DOUBLE PRECISION DEFAULT 0 NOT NULL,
    APPUSER VARCHAR(256),
    PRIMARY KEY (ID),
    CONSTRAINT STOCKDIARY_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT STOCKDIARY_ATTSETINST FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID),
    CONSTRAINT STOCKDIARY_FK_2 FOREIGN KEY (LOCATION) REFERENCES LOCATIONS(ID)
);
CREATE INDEX STOCKDIARY_INX_1 ON STOCKDIARY(DATENEW);

CREATE TABLE STOCKLEVEL (
    ID VARCHAR2(256) NOT NULL,
    LOCATION VARCHAR2(256) NOT NULL,
    PRODUCT VARCHAR2(256) NOT NULL,
    STOCKSECURITY DOUBLE PRECISION DEFAULT 0 NOT NULL,
    STOCKMAXIMUM DOUBLE PRECISION DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT STOCKLEVEL_PRODUCT FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT STOCKLEVEL_LOCATION FOREIGN KEY (LOCATION) REFERENCES LOCATIONS(ID)
);

CREATE TABLE STOCKCURRENT (
    LOCATION VARCHAR2(256) NOT NULL,
    PRODUCT VARCHAR2(256) NOT NULL,
    ATTRIBUTESETINSTANCE_ID VARCHAR2(256),
    UNITS DOUBLE PRECISION DEFAULT 0 NOT NULL,
    CONSTRAINT STOCKCURRENT_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT STOCKCURRENT_ATTSETINST FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID),
    CONSTRAINT STOCKCURRENT_FK_2 FOREIGN KEY (LOCATION) REFERENCES LOCATIONS(ID)
);
CREATE UNIQUE INDEX STOCKCURRENT_INX ON STOCKCURRENT(LOCATION, PRODUCT, ATTRIBUTESETINSTANCE_ID);

CREATE TABLE CLOSEDCASH (
    MONEY VARCHAR2(256) NOT NULL,
    HOST VARCHAR2(1024) NOT NULL,
    HOSTSEQUENCE INTEGER NOT NULL,
    DATESTART TIMESTAMP NOT NULL,
    DATEEND TIMESTAMP,
    NOSALES INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY(MONEY)
);
CREATE INDEX CLOSEDCASH_INX_1 ON CLOSEDCASH(DATESTART);
CREATE UNIQUE INDEX CLOSEDCASH_INX_SEQ ON CLOSEDCASH(HOST, HOSTSEQUENCE);

CREATE TABLE RECEIPTS (
    ID VARCHAR2(256) NOT NULL,
    MONEY VARCHAR2(256) NOT NULL,
    DATENEW TIMESTAMP NOT NULL,
    ATTRIBUTES BLOB,
    PERSON VARCHAR(256),
    PRIMARY KEY (ID),
    CONSTRAINT RECEIPTS_FK_MONEY FOREIGN KEY (MONEY) REFERENCES CLOSEDCASH(MONEY)
);
CREATE INDEX RECEIPTS_INX_1 ON RECEIPTS(DATENEW);

CREATE TABLE TICKETS (
    ID VARCHAR2(256) NOT NULL,
    TICKETTYPE INTEGER DEFAULT 0 NOT NULL,
    TICKETID INTEGER NOT NULL,
    PERSON VARCHAR2(256) NOT NULL,
    CUSTOMER VARCHAR2(256),
    STATUS INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT TICKETS_FK_ID FOREIGN KEY (ID) REFERENCES RECEIPTS(ID),
    CONSTRAINT TICKETS_FK_2 FOREIGN KEY (PERSON) REFERENCES PEOPLE(ID),
    CONSTRAINT TICKETS_CUSTOMERS_FK FOREIGN KEY (CUSTOMER) REFERENCES CUSTOMERS(ID)
);
CREATE INDEX TICKETS_TICKETID ON TICKETS(TICKETTYPE, TICKETID);

CREATE TABLE TICKETSNUM (
    ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1)
);
INSERT INTO TICKETSNUM VALUES (DEFAULT);
CREATE SEQUENCE TICKETSNUM START WITH 1;

CREATE TABLE TICKETSNUM_REFUND (
    ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1)
);
INSERT INTO TICKETSNUM_REFUND VALUES (DEFAULT);
CREATE SEQUENCE TICKETSNUM_REFUND START WITH 1;

CREATE TABLE TICKETSNUM_PAYMENT (
    ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1)
);
INSERT INTO TICKETSNUM_PAYMENT VALUES (DEFAULT);
CREATE SEQUENCE TICKETSNUM_PAYMENT START WITH 1;

CREATE TABLE TICKETLINES (
    TICKET VARCHAR2(256) NOT NULL,
    LINE INTEGER NOT NULL,
    PRODUCT VARCHAR2(256),
    ATTRIBUTESETINSTANCE_ID VARCHAR2(256),
    UNITS DOUBLE PRECISION DEFAULT 0 NOT NULL,
    PRICE DOUBLE PRECISION DEFAULT 0 NOT NULL,
    TAXID VARCHAR2(256) NOT NULL,
    ATTRIBUTES BLOB,
    PRIMARY KEY (TICKET, LINE),
    CONSTRAINT TICKETLINES_FK_TICKET FOREIGN KEY (TICKET) REFERENCES TICKETS(ID),
    CONSTRAINT TICKETLINES_FK_2 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT TICKETLINES_ATTSETINST FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID),
    CONSTRAINT TICKETLINES_FK_3 FOREIGN KEY (TAXID) REFERENCES TAXES(ID)
);

CREATE TABLE PAYMENTS (
    ID VARCHAR2(256) NOT NULL,
    RECEIPT VARCHAR2(256) NOT NULL,
    PAYMENT VARCHAR2(1024) NOT NULL,
    TOTAL DOUBLE PRECISION DEFAULT 0 NOT NULL,
    TRANSID VARCHAR2(1024),
    RETURNMSG BLOB,
    NOTES VARCHAR2(256) NOT NULL,
    TENDERED DOUBLE PRECISION DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PAYMENTS_FK_RECEIPT FOREIGN KEY (RECEIPT) REFERENCES RECEIPTS(ID)
);
CREATE INDEX PAYMENTS_INX_1 ON PAYMENTS(PAYMENT);

CREATE TABLE TAXLINES (
    ID VARCHAR2(256) NOT NULL,
    RECEIPT VARCHAR2(256) NOT NULL,
    TAXID VARCHAR2(256) NOT NULL, 
    BASE DOUBLE PRECISION DEFAULT 0 NOT NULL, 
    AMOUNT DOUBLE PRECISION DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT TAXLINES_TAX FOREIGN KEY (TAXID) REFERENCES TAXES(ID),
    CONSTRAINT TAXLINES_RECEIPT FOREIGN KEY (RECEIPT) REFERENCES RECEIPTS(ID)
);

CREATE TABLE FLOORS (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    IMAGE BLOB,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX FLOORS_NAME_INX ON FLOORS(NAME);
INSERT INTO FLOORS(ID, NAME, IMAGE) VALUES ('0', 'Restaurant floor', $FILE{/com/openbravo/pos/templates/restaurant_floor.png});

CREATE TABLE PLACES (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    X INTEGER NOT NULL,
    Y INTEGER NOT NULL,
    FLOOR VARCHAR2(256) NOT NULL,
    CUSTOMER VARCHAR2(256),
    WAITER VARCHAR2(256),
    TICKETID VARCHAR2(256),
    TABLEMOVED  NUMERIC(1) DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PLACES_FK_1 FOREIGN KEY (FLOOR) REFERENCES FLOORS(ID)
);
CREATE UNIQUE INDEX PLACES_NAME_INX ON PLACES(NAME);
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('1', 'Table 1', 80, 70, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('2', 'Table 2', 250, 75, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('3', 'Table 3', 400, 75, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('4', 'Table 4', 80, 200, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('5', 'Table 5', 260, 210, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('6', 'Table 6', 430, 210, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('7', 'Table 7', 80, 330, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('8', 'Table 8', 190, 350, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('9', 'Table 9', 295, 350, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('10', 'Table 10', 430, 345, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('11', 'Table 11', 550, 135, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('12', 'Table 12', 550, 290, '0');

CREATE TABLE RESERVATIONS (
    ID VARCHAR2(256) NOT NULL,
    CREATED TIMESTAMP NOT NULL,
    DATENEW TIMESTAMP DEFAULT TO_DATE('2013-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') NOT NULL,
    TITLE VARCHAR2(1024) NOT NULL,
    CHAIRS INTEGER NOT NULL,
    ISDONE NUMERIC(1) NOT NULL,
    DESCRIPTION VARCHAR2(1024),
    PRIMARY KEY (ID)
);
CREATE INDEX RESERVATIONS_INX_1 ON RESERVATIONS(DATENEW);

CREATE TABLE RESERVATION_CUSTOMERS (
    ID VARCHAR2(256) NOT NULL,
    CUSTOMER VARCHAR2(256) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT RES_CUST_FK_1 FOREIGN KEY (ID) REFERENCES RESERVATIONS(ID),
    CONSTRAINT RES_CUST_FK_2 FOREIGN KEY (CUSTOMER) REFERENCES CUSTOMERS(ID)
);

CREATE TABLE THIRDPARTIES (
    ID VARCHAR2(256) NOT NULL,
    CIF VARCHAR2(1024) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    ADDRESS VARCHAR2(1024),
    CONTACTCOMM VARCHAR2(1024),
    CONTACTFACT VARCHAR2(1024),
    PAYRULE VARCHAR2(1024),
    FAXNUMBER VARCHAR2(1024),
    PHONENUMBER VARCHAR2(1024),
    MOBILENUMBER VARCHAR2(1024),
    EMAIL VARCHAR2(1024),
    WEBPAGE VARCHAR2(1024),
    NOTES VARCHAR2(1024),
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX THIRDPARTIES_CIF_INX ON THIRDPARTIES(CIF);
CREATE UNIQUE INDEX THIRDPARTIES_NAME_INX ON THIRDPARTIES(NAME);

CREATE TABLE SHAREDTICKETS (
    ID VARCHAR2(256) NOT NULL,
    NAME VARCHAR2(1024) NOT NULL,
    CONTENT BLOB,
    APPUSER VARCHAR(256),
    PICKUPID SMALLINT DEFAULT 0 NOT NULL,
    PRIMARY KEY (ID)
);

-- Added for Employee Presence Management
CREATE TABLE SHIFTS (
  ID VARCHAR2(256) NOT NULL,
  STARTSHIFT TIMESTAMP NOT NULL,
  ENDSHIFT TIMESTAMP,
  PPLID VARCHAR2(256) NOT NULL,
  PRIMARY KEY (ID)
);

INSERT INTO SHIFTS(ID, STARTSHIFT, ENDSHIFT, PPLID) VALUES ('0', '2013-09-01 00:00:00.001', '2013-09-01 00:00:00.002','0');

CREATE TABLE LEAVES (
  ID VARCHAR2(256) NOT NULL,
  PPLID VARCHAR2(256) NOT NULL,
  NAME VARCHAR2(1024) NOT NULL,
  STARTDATE TIMESTAMP NOT NULL,
  ENDDATE TIMESTAMP NOT NULL,
  NOTES VARCHAR2(1024),
  PRIMARY KEY (ID),
  CONSTRAINT lEAVES_PPLID FOREIGN KEY (PPLID) REFERENCES PEOPLE(ID)
);

CREATE TABLE BREAKS (
  ID VARCHAR2(256) NOT NULL,
  NAME VARCHAR2(1024) NOT NULL,
  NOTES VARCHAR2(1024),
  VISIBLE BOOLEAN NOT NULL,
  PRIMARY KEY (ID)
);

INSERT INTO BREAKS(ID, NAME, VISIBLE, NOTES) VALUES ('0', 'Lunch Break', 1, NULL);
INSERT INTO BREAKS(ID, NAME, VISIBLE, NOTES) VALUES ('1', 'Tea Break', 1, NULL);
INSERT INTO BREAKS(ID, NAME, VISIBLE, NOTES) VALUES ('2', 'Mid Break', 1, NULL);

CREATE TABLE SHIFT_BREAKS (
  ID VARCHAR2(256) NOT NULL,
  SHIFTID VARCHAR2(256) NOT NULL,
  BREAKID VARCHAR2(256) NOT NULL,
  STARTTIME TIMESTAMP NOT NULL,
  ENDTIME TIMESTAMP,
  PRIMARY KEY (ID),
  CONSTRAINT SHIFT_BREAKS_BREAKID FOREIGN KEY (BREAKID) REFERENCES BREAKS(ID),
  CONSTRAINT SHIFT_BREAKS_SHIFTID FOREIGN KEY (SHIFTID) REFERENCES SHIFTS(ID)
);

INSERT INTO SHIFT_BREAKS(ID, SHIFTID, BREAKID, STARTTIME, ENDTIME) VALUES ('0', '0', '0', '2013-09-01 00:00:00.003', '2013-09-01 00:00:00.004');

CREATE TABLE MOORERS (
  VESSELNAME VARCHAR2(256),
  SIZE INTEGER,
  DAYS INTEGER,
  POWER NUMERIC(1) DEFAULT 0 NOT NULL
  );

CREATE TABLE CSVIMPORT(
  ID VARCHAR2(256) NOT NULL,
  ROWNUMBER VARCHAR2(256),
  CSVERROR VARCHAR2(1024),
  REFERENCE VARCHAR2(1024),
  CODE VARCHAR2(1024),
  NAME VARCHAR2(1024),
  PRICEBUY double precision DEFAULT 0 NOT NULL,
  PRICESELL double precision DEFAULT 0 NOT NULL,
  PREVIOUSBUY double precision DEFAULT 0 NOT NULL,
  PREVIOUSSELL double precision DEFAULT 0 NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE PICKUP_NUMBER (
  ID INTEGER NOT NULL
);
INSERT INTO PICKUP_NUMBER VALUES(1);

CREATE TABLE DRAWEROPENED (
  OPENDATE TIMESTAMP DEFAULT NOW(),
  NAME VARCHAR2(256),
  TICKETID VARCHAR2(256)
);

INSERT INTO APPLICATIONS(ID, NAME, VERSION) VALUES($APP_ID{}, $APP_NAME{}, $APP_VERSION{});