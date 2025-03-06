// app/javascript/components/Invoicing.jsx
import React, { useState, useEffect } from 'react';

const Invoicing = () => {
  const [invoices, setInvoices] = useState([]);

  useEffect(() => {
    fetch('/invoices.json')
      .then(response => response.json())
      .then(data => setInvoices(data));
  }, []);

  return (
    <div>
      <h1>Lista de Faturas</h1>
      <ul>
        {invoices.map((invoice) => (
          <li key={invoice.id}>
            <strong>Fatura #{invoice.id}</strong>: {invoice.amount}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Invoicing;
