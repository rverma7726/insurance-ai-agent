/**
 * MCP Server for Insurance AI Agent
 * Exposes 7 specialized tools for Claude
 */

const tools = [
  {
    name: 'analyze_policy_renewal',
    description: 'Analyze when policy renewal is due and provide recommendations'
  },
  {
    name: 'predict_churn_risk',
    description: 'Predict likelihood of customer leaving for competitor'
  },
  {
    name: 'recommend_coverages',
    description: 'Recommend additional insurance coverages based on life events'
  },
  {
    name: 'generate_retention_offer',
    description: 'Generate personalized retention offer with vouchers'
  },
  {
    name: 'analyze_life_events',
    description: 'Analyze life events and their impact on insurance needs'
  },
  {
    name: 'get_travel_coverage_needs',
    description: 'Get travel insurance coverage recommendations'
  },
  {
    name: 'query_knowledge_base',
    description: 'Query the insurance knowledge base'
  }
];

console.log('✅ MCP Server initialized with 7 tools');
console.log('📍 Tools:', tools.map((t) => t.name).join(', '));

export { tools };
