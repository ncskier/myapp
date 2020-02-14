const express = require('express')
const path = require('path')
const app = express()
const port = 3000

app.get('/', (_, res) => res.sendFile(path.join(__dirname, 'index.html')))

app.listen(port, () => console.log(`Listening on port ${port}...`))
