const request = require('supertest');
const express = require('express');

// Create app instance for testing
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World!');
});

describe('GET /', () => {
  it('should return Hello World', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe('Hello World!');
  });
});
