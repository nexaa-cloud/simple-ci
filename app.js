const express = require('express');
const logger = require('./logger');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello Students!');
});

app.listen(PORT, () => {
  logger.info(`Server running on port ${PORT}`);
});
