-- ============================================================
--  恋爱小窝 V3 数据库迁移
--  新增: settings 表 + music 存储桶
-- ============================================================

-- 1. 配置表（存储音乐链接等设置）
CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_access" ON settings FOR ALL USING (true) WITH CHECK (true);
ALTER PUBLICATION supabase_realtime ADD TABLE settings;

-- 2. 音乐文件存储桶（50MB 单文件限制）
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('music', 'music', true, 52428800, '{audio/wav,audio/mpeg,audio/mp3,audio/mpeg3,audio/x-mpeg-3,audio/ogg,audio/flac,audio/x-flac,audio/aac}')
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "public_music_access" ON storage.objects
FOR ALL USING (bucket_id = 'music') WITH CHECK (bucket_id = 'music');
