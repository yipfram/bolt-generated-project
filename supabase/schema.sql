-- Create notifications table
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  source TEXT NOT NULL,
  content TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  category TEXT,
  priority INT
);

-- Create daily_summaries table
CREATE TABLE daily_summaries (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  date DATE NOT NULL,
  summary_content TEXT,
  metrics JSONB
);

-- Create user_preferences table
CREATE TABLE user_preferences (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  notification_settings JSONB,
  categories TEXT[]
);

-- Enable row-level security
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_summaries ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_preferences ENABLE ROW LEVEL SECURITY;

-- Example RLS policy
CREATE POLICY "Allow users to access their notifications" ON notifications
  FOR SELECT USING (auth.uid() = user_id);
