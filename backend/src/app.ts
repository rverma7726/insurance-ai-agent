import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import Anthropic from '@anthropic-ai/sdk';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;
const client = new Anthropic();

app.use(cors());
app.use(express.json());

// Health check
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    service: 'Insurance AI Agent Backend'
  });
});

// Analyze user
app.post('/api/analyze/user', async (req, res) => {
  try {
    const { userId, lifeEvents } = req.body;
    const response = await client.messages.create({
      model: 'claude-3-5-sonnet-20241022',
      max_tokens: 16000,
      thinking: { type: 'enabled', budget_tokens: 10000 },
      messages: [{
        role: 'user',
        content: `Analyze customer ${userId} with events: ${JSON.stringify(lifeEvents)}`
      }]
    });
    res.json({ userId, analysis: response.content });
  } catch (error) {
    res.status(500).json({ error: 'Analysis failed' });
  }
});

// Get recommendations
app.get('/api/recommendations/:userId', (req, res) => {
  res.json({
    userId: req.params.userId,
    recommendations: [
      { coverage: 'International Travel Coverage', cost: 49.99, priority: 'HIGH' },
      { coverage: 'Enhanced Roadside Assistance', cost: 25.0, priority: 'MEDIUM' }
    ]
  });
});

// Get offers
app.get('/api/offers/:userId', (req, res) => {
  res.json({
    userId: req.params.userId,
    offers: [
      {
        offerId: `OFFER_${req.params.userId}_${Date.now()}`,
        type: 'loyalty_discount',
        description: '15% loyalty discount on renewal',
        value: 15,
        vouchers: [
          { code: 'TRAVEL2024-001', description: '$50 Starbucks Gift Card' }
        ]
      }
    ]
  });
});

app.listen(PORT, () => {
  console.log(`✅ Backend running on http://localhost:${PORT}`);
  console.log(`📊 API Base: http://localhost:${PORT}/api`);
});

export default app;
