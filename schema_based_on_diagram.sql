CREATE TABLE invoices (
  id SERIAL,
  total_amount decimal not null,
  generated_at timestamp not null,
  payed_at timestamp,
  medical_history_id integer not null,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id SERIAL,
  admitted_at timestamp not null,
  patient_id integer not null,
  status varchar(255) not null,
  PRIMARY KEY (id)
);

CREATE TABLE patients (
  id SERIAL,
  name varchar(255) not null,
  PRIMARY KEY (id)
);

CREATE TABLE treatments (
  id SERIAL,
  type varchar(255) not null,
  name varchar(255) not null,
  PRIMARY KEY (id)
);

CREATE TABLE invoice_items (
  id SERIAL,
  unit_price decimal not null,
  quantity integer not null,
  total_price decimal not null,
  invoice_id integer not null,
  treatment_id integer not null,
  PRIMARY KEY (id)
);



-- Reference to medical_histories.id from invoices.medical_history_id
ALTER TABLE invoices 
ADD CONSTRAINT medical_pkey 
FOREIGN KEY (medical_history_id) 
REFERENCES medical_histories (id);

-- Reference to patients.id from medical_histories.patient_id
ALTER TABLE medical_histories
ADD CONSTRAINT patient_pkey
FOREIGN KEY (patient_id)
REFERENCES patients (id);

-- Reference to invoices.id from invoice_items.invoice_id
ALTER TABLE invoice_items
ADD CONSTRAINT invoice_id_pkey
FOREIGN KEY (invoice_id)
REFERENCES invoices (id);

-- Reference to treatments.id from invoice_items.treatment_id
ALTER TABLE invoice_items
ADD CONSTRAINT treatment_id_pkey
FOREIGN KEY (treatment_id)
REFERENCES treatments (id);


