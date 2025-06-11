Return-Path: <linux-btrfs+bounces-14599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1489FAD50CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1E1889662
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CB220F33;
	Wed, 11 Jun 2025 10:03:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188C219FC
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636202; cv=none; b=JUc0UUcBTjwJixiAEYmX0vjOBXBoDK56ghkiNC6s5gjjkB01AFMS13eAhD6Cw1K3+Q0Gegmm48qdL3/GlxJKWXqMvYta6VwLpjgc6XCxDAcND4Kw8z5sblDobV4OzM1/7YRLzDA9pIm1uRNM12wWln+MuOVeldc9/bVmNAkCIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636202; c=relaxed/simple;
	bh=atTkZXf8x5vj7KfY/odJSKHthsR2lqLB3DuQfX/Cet0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz2vG0kYzAqMRDjjb5GrQiiwhrrfcwzcReMOr77d16pyCaM2yMcauvMGWuQcOhtoEqDEmBIHaQG4YLYjboz28frtCmTrQlFDt3W3Y8i3WtDYVQegWGy7wFfNu3/Tf2jfTvSOqotVf0RnPyd3oxiW4h/4yehE+hWT1x5Fb5g7uKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a51481a598so3729632f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 03:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636199; x=1750240999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3DJDA8kQvuZCmWmwJaXPpkEthqkvmBCg45o/ZsvVxE=;
        b=xRAr7yqd1PVr6mxnxVTnNvOufJwTgewQxw204/q1v11iDSBE55+GDpetI5md+FIuhW
         ctPGIVnCD7cZqERNV5FsukzuWwmXfKFGerGbhPNxP+ThSH+Lx1g9KtFrYV3mST1vGWTQ
         F/OQBf3bgbtc83KEBup2QfFTMJfC/6jHk2ymJ6Akb5C17iNSplJCFb1OR8Ao7TbiOr1I
         TRG8dfZCQHrlG/R9Oo4V3MJ1uXRVEX7addtqJ4kMAYkNWOMAVTBl653mHYACeVdLdl+6
         OWhJ0VjXp4IMWr9eNZnPeorIZY2weQvK5b4VKt4Nea7L+MNPpK/nJ3r7h9NTwZcMboJf
         Dj8g==
X-Gm-Message-State: AOJu0YzM1qXeychwLRdDUD9AKjiZ3eVcat18Y4076/zG1eZNdUch3ABd
	BebMyLTVGzY5t2vvZ8nHx4HeXSbuo5OT6b7zST3as3YN5tfDZW2cKro39iNDNA==
X-Gm-Gg: ASbGnctWSWoKEKOHNBxBzlMAlqdzvqhet2PpjaCSTT8Ivizd2EzuQ7MVN9pQbF2AijU
	89YoIFfgLPoSt4t9wKLpor933fnYPFSRSM0BJlD4tSpRc5J7bTFbGLGFRjJyflH6C4+3Ayc1nvb
	LfJUQSHaNsaBHbfAhc+rWHA3x9rTrktPaWb3SbuaYyoRORRTF9hvRs6N02fogohP2D9yEQ07dsU
	X/gDnEMMb2OeBJl2FparBeO+ykPP2gR0DyC8Mlqt+vu4J/YXKKHRoIbZpvyS1Nlk1EvQns2SliF
	PxXGz9pquz7TKjcNQtCgGBhDSMWr0Hq7q3pag2K7DleGMkJrwmeP8KSr8whUIuRpeqYq7NYxFXF
	N3anMv9QFTMWbBmay2+tiM1Ela9A8JWDJV47RWXj0DL2rub6d6g==
X-Google-Smtp-Source: AGHT+IGgEb+ZTze0iJcQAOe2F5uSBBo6mR6CYN9WWRLmhK4THH1ebWzM9rMQpZQn5aV0dQnVg96Dcw==
X-Received: by 2002:a05:6000:1788:b0:3a5:39e9:928d with SMTP id ffacd0b85a97d-3a5586866femr2089062f8f.0.1749636199021;
        Wed, 11 Jun 2025 03:03:19 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm14654274f8f.83.2025.06.11.03.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/5] btrfs: call btrfs_close_devices from ->kill_sb
Date: Wed, 11 Jun 2025 12:03:00 +0200
Message-ID: <20250611100303.110311-3-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100303.110311-1-jth@kernel.org>
References: <20250611100303.110311-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex once call backs from block devices to
the file system using the holder ops are supported.  Move the call
to btrfs_close_devices into btrfs_free_fs_info so that it is closed
from ->kill_sb (which is also called from the mount failure handling
path unlike ->put_super) as well as when an fs_info is freed because
an existing superblock already exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   | 29 ++++++++++++++++-------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0d6ad7512f21..6360d44acaa9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1247,6 +1247,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;
 
 	percpu_counter_destroy(&fs_info->stats_read_blocks);
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -3681,7 +3683,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
@@ -4428,7 +4429,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	iput(fs_info->btree_inode);
 
 	btrfs_mapping_tree_free(fs_info);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b9e08a59da4e..eaecf1525078 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1869,10 +1869,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	if (ret)
 		return ret;
 
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		ret = -EACCES;
-		goto error;
-	}
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
+		return -EACCES;
 
 	bdev = fs_devices->latest_dev->bdev;
 
@@ -1886,21 +1884,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * otherwise it's tied to the lifetime of the super_block.
 	 */
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		ret = PTR_ERR(sb);
-		goto error;
-	}
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
 
 	set_device_specific_options(fs_info);
 
 	if (sb->s_root) {
-		btrfs_close_devices(fs_devices);
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
 		 * mismatch and reconfigure with sb->s_umount rwsem held if
 		 * needed.
 		 */
+		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
+			ret = -EBUSY;
 	} else {
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
@@ -1916,10 +1913,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	fc->root = dget(sb->s_root);
 	return 0;
-
-error:
-	btrfs_close_devices(fs_devices);
-	return ret;
 }
 
 /*
@@ -1997,8 +1990,18 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  */
 static int btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	int ret = 0;
 
+	/*
+	 * We got a reference to our fs_devices, so we need to close it here to
+	 * make sure we don't leak our reference on the fs_devices.
+	 */
+	if (fs_info->fs_devices) {
+		btrfs_close_devices(fs_info->fs_devices);
+		fs_info->fs_devices = NULL;
+	}
+
 	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
 		ret = btrfs_reconfigure(fc);
 
-- 
2.49.0


