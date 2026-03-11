/* ==========================================
   INDEXES
   ========================================== */

-- For fraud analysis by time
CREATE INDEX idx_transactions_time
ON transactions(transaction_time);

-- For fraud analysis by user
CREATE INDEX idx_transactions_user
ON transactions(user_id);

-- For fraud segmentation
CREATE INDEX idx_transactions_chargeback
ON transactions(is_chargeback);

-- For cross-border analysis
CREATE INDEX idx_transactions_country
ON transactions(ip_country);

-- For velocity detection
CREATE INDEX idx_transactions_user_time
ON transactions(user_id, transaction_time);
