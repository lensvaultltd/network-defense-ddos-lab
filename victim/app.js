const express = require('express');
const promClient = require('prom-client');

const app = express();
const port = 3000;

// Prometheus metrics setup
const collectDefaultMetrics = promClient.collectDefaultMetrics;
collectDefaultMetrics();

const httpRequestDurationMicroseconds = new promClient.Histogram({
  name: 'http_request_duration_ms',
  help: 'Duration of HTTP requests in ms',
  labelNames: ['method', 'route', 'code'],
  buckets: [10, 50, 100, 250, 500, 1000, 5000]
});

// Simulate CPU intensive task to show resource utilization spikes
function simulateWorkload(iterations) {
    let result = 0;
    for (let i = 0; i < iterations; i++) {
        result += Math.random() * Math.random();
    }
    return result;
}

app.get('/api/data', (req, res) => {
    const end = httpRequestDurationMicroseconds.startTimer();
    
    // Simulate normal workload
    simulateWorkload(100000);
    
    res.json({ status: "success", message: "Cloud service operating normally." });
    end({ route: req.route.path, code: res.statusCode, method: req.method });
});

app.get('/metrics', async (req, res) => {
    res.set('Content-Type', promClient.register.contentType);
    res.send(await promClient.register.metrics());
});

app.listen(port, () => {
    console.log(`Cloud service listening on port ${port}`);
});
