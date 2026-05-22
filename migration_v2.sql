-- ============================================================
--  恋爱小窝 V2 数据库迁移
--  在 Supabase SQL Editor 中运行
--  新增: 时间线照片 + 照片墙标签
-- ============================================================

ALTER TABLE timeline ADD COLUMN IF NOT EXISTS image TEXT;
ALTER TABLE photos ADD COLUMN IF NOT EXISTS tags TEXT DEFAULT '';
