// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs"
Rails.start();


// app/javascript/application.js
import React from 'react';
import ReactDOM from 'react-dom';
import Invoicing from './components/Invoicing';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Invoicing />,
    document.getElementById('invoicing')
  );
});
