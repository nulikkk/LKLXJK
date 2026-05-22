-- ============================================================
--  恋爱小窝 - Supabase 数据库初始化
--  在 Supabase SQL Editor 中运行此文件
-- ============================================================

-- 1. 创建表
CREATE TABLE IF NOT EXISTS timeline (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  title TEXT NOT NULL,
  description TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS diary (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  content TEXT NOT NULL,
  mood TEXT DEFAULT '😊',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS photos (
  id BIGSERIAL PRIMARY KEY,
  title TEXT DEFAULT '甜蜜瞬间',
  src TEXT NOT NULL,
  date DATE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS notes (
  id BIGSERIAL PRIMARY KEY,
  content TEXT NOT NULL,
  color_idx INTEGER DEFAULT 0,
  date DATE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 启用实时同步（Supabase Realtime）
ALTER PUBLICATION supabase_realtime ADD TABLE timeline;
ALTER PUBLICATION supabase_realtime ADD TABLE diary;
ALTER PUBLICATION supabase_realtime ADD TABLE photos;
ALTER PUBLICATION supabase_realtime ADD TABLE notes;

-- 3. 开启 RLS 并允许公开访问（无需登录）
ALTER TABLE timeline ENABLE ROW LEVEL SECURITY;
ALTER TABLE diary ENABLE ROW LEVEL SECURITY;
ALTER TABLE photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_access" ON timeline FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_access" ON diary FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_access" ON photos FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_access" ON notes FOR ALL USING (true) WITH CHECK (true);

-- 4. 种子数据：你们的恋爱时间线
INSERT INTO timeline (date, title, description) VALUES
  ('2026-04-01', '💬 初次相识', '茫茫人海中遇见了特别的你，故事从这里开始'),
  ('2026-05-04', '🎉 第一次见面', '常州·红梅公园→天宁禅寺→东坡园→青果巷，带着小零食和礼物奔赴彼此'),
  ('2026-05-12', '💞 第二次见面', '无锡·牵手、拥抱、嬉笑打闹，心跳声大到怕你听见'),
  ('2026-05-16', '🤝 交换情侣手链', '她买了情侣手链，一人一条，默许了彼此的专属身份'),
  ('2026-05-18', '🏖️ 沙滩上的名字', '她在沙滩写下他的名字，海浪冲不掉，风也吹不走'),
  ('2026-05-19', '💗 丹阳见面', '聊原生家庭、姥爷的故事，她把最脆弱的伤口摊开给他看，那是比拥抱更亲密的信任'),
  ('2026-05-20', '💕 正式在一起', '5月20号，终于说出那句藏了很久的话——"做我女朋友吧"');
