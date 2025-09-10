const request = require('supertest');

// Use environment variable or default to localhost for testing
const baseURL = process.env.TEST_BASE_URL || 'http://localhost:3000';

describe('API Tests', () => {
  it('should return Hello World from GET /', async () => {
    const res = await request(baseURL).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe('Hello Students!');
  });

  it('should respond within reasonable time', async () => {
    const start = Date.now();
    const res = await request(baseURL).get('/');
    const duration = Date.now() - start;
    
    expect(res.statusCode).toBe(200);
    expect(duration).toBeLessThan(1000); // Should respond within 1 second
  });

  it('should handle multiple concurrent requests', async () => {
    const requests = Array(5).fill().map(() => request(baseURL).get('/'));
    const responses = await Promise.all(requests);
    
    responses.forEach(res => {
      expect(res.statusCode).toBe(200);
      expect(res.text).toBe('Hello Students!');
    });
  });
});
