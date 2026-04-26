-- Sample Users
INSERT INTO users (id, name, email, phone, segment, tenure_years, satisfaction_score, churn_risk_score)
VALUES
  ('550e8400-e29b-41d4-a716-446655440001'::uuid, 'Sarah Johnson', 'sarah@email.com', '555-0101', 'premium', 12, 4.8, 0.15),
  ('550e8400-e29b-41d4-a716-446655440002'::uuid, 'Michael Chen', 'michael@email.com', '555-0102', 'standard', 5, 4.2, 0.45),
  ('550e8400-e29b-41d4-a716-446655440003'::uuid, 'Jennifer Martinez', 'jennifer@email.com', '555-0103', 'budget', 2, 3.1, 0.72),
  ('550e8400-e29b-41d4-a716-446655440004'::uuid, 'David Thompson', 'david@email.com', '555-0104', 'standard', 8, 4.5, 0.25),
  ('550e8400-e29b-41d4-a716-446655440005'::uuid, 'Emily Rodriguez', 'emily@email.com', '555-0105', 'premium', 15, 4.9, 0.08);

-- Sample Policies
INSERT INTO policies (id, user_id, type, policy_number, premium, renewal_date)
VALUES
  ('650e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'auto', 'AUTO-001', 1200.00, NOW() + INTERVAL '45 days'),
  ('650e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'home', 'HOME-001', 1800.00, NOW() + INTERVAL '90 days'),
  ('650e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'auto', 'AUTO-002', 980.00, NOW() + INTERVAL '120 days');

-- Sample Recommendations
INSERT INTO recommendations (id, user_id, coverage_type, reason, estimated_cost, priority)
VALUES
  ('850e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'International Travel Coverage', 'Traveling to Thailand', 49.99, 'HIGH'),
  ('850e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440004'::uuid, 'Comprehensive & Collision', 'New vehicle protection', 85.00, 'HIGH');

-- Sample Offers
INSERT INTO offers (id, user_id, offer_type, description, discount_percent, expires_at)
VALUES
  ('950e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'travel_bundle', 'Travel protection bundle', 15, NOW() + INTERVAL '30 days'),
  ('950e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, 'retention_loyalty', 'Customer retention offer', 30, NOW() + INTERVAL '14 days');
