Return-Path: <linux-btrfs+bounces-1727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4983AFAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E81628BD58
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD5E129A75;
	Wed, 24 Jan 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RjlNDdWH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D81292F7
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116808; cv=none; b=OU4whaIHm6TI1bkDsSnQNqyCjQF7/BlY8NAQuIx3NoN165U0V5ApZ21fye2ZblE2ePNqR2S43fFFu3kbr6XkcpIBfi1lEHnsLxAivTN3MhEOu4qMgphQ1gD18ORVy9AEghx7GtgLo/vaeGw2kAjCnWu0OWjWb+2JpQ9SMO789VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116808; c=relaxed/simple;
	bh=XeVoC5nsnwQ4owuS282EqW/XfwUhY0Yf+4iFPkccKWs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZ+h7FseFVvB3AaEEDv+ZSkXB5/Sb4s/aK2w8UGp7izT/uVrvY6dKdC6JXjYhghTuGc0f2Ic44NGRLhMhXzXbzNn3QkwZjBLH/wMZ4y91xE+MNLDMEUo0OveTKkaYsBcyjOOdWdCifPaKoN0vOHELDQfEzUiXnf3Q62dvKm1QgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RjlNDdWH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dafe04717baso4928126276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116805; x=1706721605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BumCDgLCn/TsRwLhoul9wJ1aTS67uM60k+te264emjM=;
        b=RjlNDdWH1GkfR4Kw1lQrWOLqylFsbslzfuRYvhDynvngEB1//vsAkabEp8Jk1bSg0v
         AtqK0Czke5J3oxHFYgb2QpaP3A+izV4sQr+CLf3Opvi4a3GFOeChAw/WP4fjY+bYwhLE
         4qZRXl8eKKgaLVAe1vzt1RsYcPlYlErKE8gg2Q1le+H7dUiNjtYqShT4UDcuZN2/SQ4f
         pbrF28DJa+nFDhY1m1q8ZkYRJjofvypgWOyKulwgmXqLD9owuF4iWFgn1mk5puiYyo23
         8WAqb7XA9ugZvsFTymG3q2MQc7a54goFQvQvtkeW6Bf4F1pq7szGV+iN7p92qEN/sEeM
         BR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116805; x=1706721605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BumCDgLCn/TsRwLhoul9wJ1aTS67uM60k+te264emjM=;
        b=w1tLPqZ926LJ72cY+IK8sD35fY3IUtnCQ299QzGazTA7gCmYKcPsYu0c4ve7fajET1
         t8yOC0jBnQHW4BlLjV+tclTaEx/6ib4XygjXBQL8d6PUgZc7bCEJ0Fotm9jfmjolkOtH
         uAwF6Pv3QAYIyiDnnRO9SC3hhOtzL6Hxz6EBxEUNnmU//IG2NQjhbouRjsjT3vfds4DL
         brVnh8XjtAPvzAf4IrdRq4DbFRrgvgD46GxkkYnShP3nNjvDS7Pjy5LOrLz6Yq6C6Noc
         lKsV5mZbDJt4Qh/QA3SdyrXFB9jwMgHMDyJkIBUWsztnA5ODCo3z2t/pkRVhOUPUAhde
         h0tw==
X-Gm-Message-State: AOJu0YyeishY0MbU6UURDxxdlNUEYRWikji3xHt0SG20zOSMgMFXa/PQ
	s3WQq5qJK0JiOI7pAsKRzkk3yVL2u/1naMklo79HPntm47T4uapzN5BGCOaIeHodEPmKpJvKA9r
	t
X-Google-Smtp-Source: AGHT+IG21sHEoRW0W8tmqQJWTnGw5rfYQQfu2AGD9JWTE/MLnwuS/E6vpQMPPuJ8I47OgBuIjne8xA==
X-Received: by 2002:a25:e90f:0:b0:dc2:2895:6c79 with SMTP id n15-20020a25e90f000000b00dc228956c79mr1046202ybd.23.1706116805518;
        Wed, 24 Jan 2024 09:20:05 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k12-20020a25b28c000000b00db39d501e8esm2945161ybj.61.2024.01.24.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:05 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 45/52] btrfs: deal with encrypted symlinks in send
Date: Wed, 24 Jan 2024 12:19:07 -0500
Message-ID: <4d97f35d6f85ff041b09bed33b63446a92b7a20c.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send needs to send the decrypted value of the symlinks, handle the case
where the inode is encrypted and decrypt the symlink name into a buffer
and copy this buffer into our fs_path struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 141ab89fb63e..747d7d192b19 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1732,9 +1732,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 	return ret;
 }
 
-static int read_symlink(struct btrfs_root *root,
-			u64 ino,
-			struct fs_path *dest)
+static int read_symlink_unencrypted(struct btrfs_root *root, u64 ino,
+				    struct fs_path *dest)
 {
 	int ret;
 	struct btrfs_path *path;
@@ -1800,6 +1799,48 @@ static int read_symlink(struct btrfs_root *root,
 	return ret;
 }
 
+static int read_symlink_encrypted(struct btrfs_root *root, u64 ino,
+				  struct fs_path *dest)
+{
+	DEFINE_DELAYED_CALL(done);
+	const char *buf;
+	struct page *page;
+	struct inode *inode;
+	int ret = 0;
+
+	inode = btrfs_iget(root->fs_info->sb, ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	page = read_mapping_page(inode->i_mapping, 0, NULL);
+	if (IS_ERR(page)) {
+		ret = PTR_ERR(page);
+		goto out;
+	}
+
+	buf = fscrypt_get_symlink(inode, page_address(page),
+				  BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info),
+				  &done);
+	if (IS_ERR(buf))
+		goto out_page;
+	ret = fs_path_add(dest, buf, strlen(buf));
+out_page:
+	put_page(page);
+	do_delayed_call(&done);
+out:
+	iput(inode);
+	return ret;
+}
+
+
+static int read_symlink(struct btrfs_root *root, u64 ino,
+			struct fs_path *dest)
+{
+	if (btrfs_fs_incompat(root->fs_info, ENCRYPT))
+		return read_symlink_encrypted(root, ino, dest);
+	return read_symlink_unencrypted(root, ino, dest);
+}
+
 /*
  * Helper function to generate a file name that is unique in the root of
  * send_root and parent_root. This is used to generate names for orphan inodes.
-- 
2.43.0


