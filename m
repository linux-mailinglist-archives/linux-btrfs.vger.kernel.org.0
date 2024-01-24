Return-Path: <linux-btrfs+bounces-1730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1483AFB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A7528C1D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73912A141;
	Wed, 24 Jan 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JOpRqqSR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79653129A86
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116811; cv=none; b=SqkuRlWruPoFFEQkAdWYzOampBEMv4dJhnIQCYDRRGHXradhJjUsgnSk8CGaEz2MMtC+uyXUdnTdnz5L34RLys9/CC+aTxHjcMQRFdJOFfRiOp97621Kf+kkVa21g3phlebnRJyKc8zXLtTSftzFoJQX8wEf7rxtwrz3wjf/HDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116811; c=relaxed/simple;
	bh=WXuAmQhaMi56eBTouz0y363VQBw96z8iVCRjuSGhPF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx0lZBAfEN6RHvwX3uF576z/6d37ABYsRzDYfJRYT+RU5MFX9ejdQF+Hb4HNRTqEpc661XDEahRZMoAl5qZMsQWkV92RvNFEuXkbmQbZIk3TvWHItK81RzqSlgnF+5BhmrkgzY78MavLDG5vmunjNs4Z7zYocY2qPgMrIR6q/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JOpRqqSR; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso6093211276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116809; x=1706721609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+/TAgHG9naW19s9kVzbjZ2d2N6UEzYNeBVJBGHfbGY=;
        b=JOpRqqSRLa7dC22QXqdAnWqDRwhXvN2zsVf8JF5y0fibe/37W6i+Ll8SCiXLEXUZhr
         O35dY+ZxWbSx/WyDe+UoCO+aN1fKP2nQMfnt2IIgC4DzRIcLhwPa9sMiC/2+7ITmS+gv
         ysr7KZaVLXfiZgySubcVknLuQFhfa5XXjObzR2mtwFsYcJVYW0XnFF/A7nd2aev1Zn5j
         w9SEBtj6mUJVU8RIoSLJIbl/Bjq4XMwtOH2FktV0VsmPpP0KvrAP1WNOBb4GZQVRXZ7i
         0fmA738jV1KI6zg+CenyuB7eKnFMh/wqkHEGEp5Jl6m9KR9xG420+mxZ09+TtDztkpUN
         FzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116809; x=1706721609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+/TAgHG9naW19s9kVzbjZ2d2N6UEzYNeBVJBGHfbGY=;
        b=rFw+BpZacfIMS0xvc+ubWQR4bFwk1YRV4YMsQ5dqxeSmpVUm1+/YbS0zdEvLEcBJdN
         WjiqJ0BtzeiBbs0U8CLrD8Z/lzGMe+PHKc5yIOt7WK3oeG1JtUqBbNq0F6e52Kf2X7BY
         h4W9yg4PMxAXH+8o5PDzqXT0E0HMr9vSUqDxDGDsv7Q30BFpIFOIAwUtybojmAix4rDw
         yGbQqwqS9WEJjJhnxPeDtJRBB1nH203/9okWwarwpWZuOpyiQ/GLTUcfC2Ev651vBEvm
         bQPJ+oLNTxK1zv9hggYl912PFBfh0zUWoVuTc4po6ErYjd36eQF2Bf5HznNorc56Lugq
         8vEQ==
X-Gm-Message-State: AOJu0Yw3WuuIwxjNAx8eCkABugoLkjpx3I1LhKnqkm+91p6rayBbLW0y
	xn4OLuQLYlsSm9+SNAUb9QbyW9aOQz1HnS5ql7mXNWHP7x1l6X9e19pTFTKrLuZvP2OnGCyAqha
	z
X-Google-Smtp-Source: AGHT+IGjfqxo5m294lLlj00WzARgqh27zpNqDAvAIllMTGs5TWgsKE/r6HpyQZqHqrC9UeaTX/JPfg==
X-Received: by 2002:a25:640f:0:b0:dbe:ac3a:9d07 with SMTP id y15-20020a25640f000000b00dbeac3a9d07mr986207ybb.1.1706116808563;
        Wed, 24 Jan 2024 09:20:08 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 63-20020a251342000000b00dc608353fb3sm532252ybt.39.2024.01.24.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 48/52] btrfs: set the appropriate free space settings in reconfigure
Date: Wed, 24 Jan 2024 12:19:10 -0500
Message-ID: <325598eeb1d23f9ae04f675b4ee218f7e98e3ff0.1706116485.git.josef@toxicpanda.com>
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

btrfs/330 uncovered a problem where we were accidentally turning off the
free space tree when we do the transition from ro->rw.  This happens
because we don't update

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/super.c   | 29 ++++++++++++++++-------------
 fs/btrfs/super.h   |  3 ++-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70e33df8f975..c9c61ffc78ee 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3311,7 +3311,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * Handle the space caching options appropriately now that we have the
 	 * super block loaded and validated.
 	 */
-	btrfs_set_free_space_cache_settings(fs_info);
+	btrfs_set_free_space_cache_settings(fs_info, &fs_info->mount_opt);
 
 	if (!btrfs_check_options(fs_info, &fs_info->mount_opt, sb->s_flags)) {
 		ret = -EINVAL;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 861fbf48456a..f5bbaa70b09c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -696,10 +696,11 @@ bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 }
 
 /*
- * This is subtle, we only call this during open_ctree().  We need to pre-load
- * the mount options with the on-disk settings.  Before the new mount API took
- * effect we would do this on mount and remount.  With the new mount API we'll
- * only do this on the initial mount.
+ * Because we have an odd set of behavior with turning on and off the space
+ * cache and free space tree we have to call this before we start the mount
+ * operation after we load the super, or before we start remount.  This is to
+ * make sure we have the proper free space settings in place if the user didn't
+ * specify any.
  *
  * This isn't a change in behavior, because we're using the current state of the
  * file system to set the current mount options.  If you mounted with special
@@ -707,15 +708,16 @@ bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
  * settings, because mounting without these features cleared the on-disk
  * settings, so this being called on re-mount is not needed.
  */
-void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info,
+					 unsigned long *mount_opt)
 {
 	if (fs_info->sectorsize < PAGE_SIZE) {
-		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+		btrfs_clear_opt(*mount_opt, SPACE_CACHE);
+		if (!btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE)) {
 			btrfs_info(fs_info,
 				   "forcing free space tree for sector size %u with page size %lu",
 				   fs_info->sectorsize, PAGE_SIZE);
-			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(*mount_opt, FREE_SPACE_TREE);
 		}
 	}
 
@@ -723,7 +725,7 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 	 * At this point our mount options are populated, so we only mess with
 	 * these settings if we don't have any settings already.
 	 */
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+	if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
 		return;
 
 	if (btrfs_is_zoned(fs_info) &&
@@ -733,10 +735,10 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 		return;
 	}
 
-	if (btrfs_test_opt(fs_info, SPACE_CACHE))
+	if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
 		return;
 
-	if (btrfs_test_opt(fs_info, NOSPACECACHE))
+	if (btrfs_raw_test_opt(*mount_opt, NOSPACECACHE))
 		return;
 
 	/*
@@ -744,9 +746,9 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 	 * them ourselves based on the state of the file system.
 	 */
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+		btrfs_set_opt(*mount_opt, FREE_SPACE_TREE);
 	else if (btrfs_free_space_cache_v1_active(fs_info))
-		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		btrfs_set_opt(*mount_opt, SPACE_CACHE);
 }
 
 static void set_device_specific_options(struct btrfs_fs_info *fs_info)
@@ -1528,6 +1530,7 @@ static int btrfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+	btrfs_set_free_space_cache_settings(fs_info, &ctx->mount_opt);
 
 	if (!mount_reconfigure &&
 	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index f18253ca280d..8c823f3b904e 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -8,7 +8,8 @@ bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
-void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info);
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info,
+					 unsigned long *mount_opt);
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 {
-- 
2.43.0


