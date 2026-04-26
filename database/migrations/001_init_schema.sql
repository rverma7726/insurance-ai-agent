-- Users table
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20),
  segment VARCHAR(20) CHECK (segment IN ('premium', 'standard', 'budget')),
  tenure_years INT,
  satisfaction_score FLOAT,
  churn_risk_score FLOAT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Policies table
CREATE TABLE IF NOT EXISTS policies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  type VARCHAR(50) CHECK (type IN ('auto', 'home', 'property')),
  policy_number VARCHAR(100) UNIQUE,
  premium DECIMAL(10, 2),
  coverage_limits JSONB,
  renewal_date DATE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Life events table
CREATE TABLE IF NOT EXISTS life_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  event_type VARCHAR(100),
  event_details JSONB,
  coverage_impact_score FLOAT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Recommendations table
CREATE TABLE IF NOT EXISTS recommendations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  coverage_type VARCHAR(100),
  reason TEXT,
  estimated_cost DECIMAL(10, 2),
  priority VARCHAR(20),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Offers table
CREATE TABLE IF NOT EXISTS offers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  offer_type VARCHAR(100),
  description TEXT,
  discount_percent FLOAT,
  created_at TIMESTAMP DEFAULT NOW(),
  expires_at TIMESTAMP,
  accepted_at TIMESTAMP
);

-- Vouchers table
CREATE TABLE IF NOT EXISTS vouchers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  offer_id UUID NOT NULL REFERENCES offers(id),
  code VARCHAR(50) UNIQUE,
  voucher_type VARCHAR(100),
  description TEXT,
  value DECIMAL(10, 2),
  expires_at TIMESTAMP
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_users_segment ON users(segment);
CREATE INDEX IF NOT EXISTS idx_policies_user_id ON policies(user_id);
CREATE INDEX IF NOT EXISTS idx_life_events_user_id ON life_events(user_id);
CREATE INDEX IF NOT EXISTS idx_recommendations_user_id ON recommendations(user_id);
CREATE INDEX IF NOT EXISTS idx_offers_user_id ON offers(user_id);
CREATE INDEX IF NOT EXISTS idx_vouchers_offer_id ON vouchers(offer_id);
