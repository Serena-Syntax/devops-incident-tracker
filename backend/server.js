const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Beispieldaten für Störungen (Dummy Data)
let incidents = [
{ id: 1, title: 'Hohe Datenbank-CPU-Auslastung', status: 'OPEN', severity: 'HIGH' },
{ id: 2, title: 'API-Gateway Zeitüberschreitung', status: 'RESOLVED', severity: 'MEDIUM' }
];

// Health-Check Endpunkt für Statusüberprüfung
app.get('/api/health', (req, res) => {
res.json({ status: 'OK', message: 'Backend-Dienst läuft erfolgreich!' });
});

// GET: Alle Vorfälle abrufen
app.get('/api/incidents', (req, res) => {
res.json(incidents);
});

// POST: Einen neuen Vorfall erstellen
app.post('/api/incidents', (req, res) => {
const { title, severity } = req.body;
const newIncident = {
id: incidents.length + 1,
title,
severity: severity || 'LOW',
status: 'OPEN'
};
incidents.push(newIncident);
res.status(201).json(newIncident);
});

app.listen(PORT, () => {
console.log(`Server läuft auf Port ${PORT}`);
});
