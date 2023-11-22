Return-Path: <linux-btrfs+bounces-303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1C7F4E22
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A357EB215D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D05B5AD;
	Wed, 22 Nov 2023 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mNyyn5h2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FE191
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:16 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso20925276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673495; x=1701278295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cREJeCjECFMqWzZfrEI8pPE/PMHsOEuetZPUQgQFNuE=;
        b=mNyyn5h2xlX2NofWDkOy3r32rhB9MBbVwsp9Z+y/wlxeO1aQJ4DttRTaWvUrCvD5HL
         98ihaBRmBoTkdrxfR5otjBvRLPneHPNfq7m4qdbSnvEJMBK3OkXzOSSG9/VRnSuTVvTg
         kXgs2UGkEqn2gHyXxLWBZ4G5xwDtD+SgiBLyZktSjK4/J29c7Xy4NF5X5CHxDR8peq8G
         d36ir+WodDXJ3bxrE3hRUaKAxHI7UXv7wvmCkaprzAr5Nzu1ix9++YRkDtUnaU4CmSPW
         +ECjAS/jFC/Ocv9iZsUj+MJqWj0K3rJeq87JFmFoFN6gjIkGQhRJ3fhlVALbsUGwSvrO
         Oi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673495; x=1701278295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cREJeCjECFMqWzZfrEI8pPE/PMHsOEuetZPUQgQFNuE=;
        b=WEuxVeQqnc6Tf5nfIb5Ngg4nusFX9Zg3Q/ZQjDZWj7UDRljNxPh1qmcOvCfpQquOnO
         GjklyOOuwBM1wGElKaL7Vak5Dm4uFDB9IHI1MMTOZjmpjd7OpRwtwJI8oYKNH4zHaHH/
         fb2q95NWscEyD0QeOGhNjgjvIfsInkdZ1Ja1PDM62DGmHL+Yoj4Ok+NjPFGJTtDqxsLm
         B+16UcQvj1EwwmHU92GqrJE/zqQUV+C1vjyVGT7C/3bJ677v8upw/qeQGREnOklys5o3
         EjOLWQIc42nb+Hjr5rrmGPCbUk88asizNy7TcNJS6PazEMKTOSefVkC5GTcjWGDNtrTP
         MPjw==
X-Gm-Message-State: AOJu0Yz1etAghNaEwI0WOx7GK/iRxW9cg7cJxjIySh6QCHyK55U45cp0
	bKV0kDycNEL4fhp27A6BU+DqjU68gjNzx32AMyYX6S+Z
X-Google-Smtp-Source: AGHT+IFq9B0CTNTwSmHroxx8G42ElNuTKjkgelv851qX9/xRiwnO1hYCln14+nfZ/2NLm8wyHEFDeg==
X-Received: by 2002:a25:aa2f:0:b0:daf:6882:6f0a with SMTP id s44-20020a25aa2f000000b00daf68826f0amr3138155ybi.4.1700673495027;
        Wed, 22 Nov 2023 09:18:15 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cf27-20020a056902181b00b00d7360e0b240sm1442645ybb.31.2023.11.22.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 11/19] btrfs: add reconfigure callback for fs_context
Date: Wed, 22 Nov 2023 12:17:47 -0500
Message-ID: <ce862ac805ddbb697a69664fad543b16a0160786.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is what is used to remount the file system with the new mount API.
Because the mount options are parsed separately and one at a time I've
added a helper to emit the mount options after the fact once the mount
is configured, this matches the dmesg output for what happens with the
old mount API.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 210 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/zoned.c |  16 ++--
 fs/btrfs/zoned.h |   6 +-
 3 files changed, 203 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ef7de1e6d242..63f17dd21d4e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -729,10 +729,11 @@ static int btrfs_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
+static bool check_ro_option(struct btrfs_fs_info *fs_info,
+			    unsigned long mount_opt, unsigned long opt,
 			    const char *opt_name)
 {
-	if (fs_info->mount_opt & opt) {
+	if (mount_opt & opt) {
 		btrfs_err(fs_info, "%s must be used with ro mount option",
 			  opt_name);
 		return true;
@@ -740,35 +741,36 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
-static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
+static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			  unsigned long flags)
 {
 	bool ret = true;
 
 	if (!(flags & SB_RDONLY) &&
-	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
 		ret = false;
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
+	    !btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE) &&
+	    !btrfs_raw_test_opt(*mount_opt, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		ret = false;
 	}
 	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+	     !btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE)) {
 		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
 		ret = false;
 	}
 
-	if (btrfs_check_mountopts_zoned(info))
+	if (btrfs_check_mountopts_zoned(info, mount_opt))
 		ret = false;
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
-		if (btrfs_test_opt(info, SPACE_CACHE))
+		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
 			btrfs_info(info, "disk space caching is enabled");
-		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
 			btrfs_info(info, "using free space tree");
 	}
 
@@ -1346,7 +1348,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 out:
-	if (!ret && !check_options(info, new_flags))
+	if (!ret && !check_options(info, &info->mount_opt, new_flags))
 		ret = -EINVAL;
 	return ret;
 }
@@ -2386,6 +2388,170 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	return ret;
 }
 
+static void btrfs_ctx_to_info(struct btrfs_fs_info *fs_info,
+			      struct btrfs_fs_context *ctx)
+{
+	fs_info->max_inline = ctx->max_inline;
+	fs_info->commit_interval = ctx->commit_interval;
+	fs_info->metadata_ratio = ctx->metadata_ratio;
+	fs_info->thread_pool_size = ctx->thread_pool_size;
+	fs_info->mount_opt = ctx->mount_opt;
+	fs_info->compress_type = ctx->compress_type;
+	fs_info->compress_level = ctx->compress_level;
+}
+
+static void btrfs_info_to_ctx(struct btrfs_fs_info *fs_info,
+			      struct btrfs_fs_context *ctx)
+{
+	ctx->max_inline = fs_info->max_inline;
+	ctx->commit_interval = fs_info->commit_interval;
+	ctx->metadata_ratio = fs_info->metadata_ratio;
+	ctx->thread_pool_size = fs_info->thread_pool_size;
+	ctx->mount_opt = fs_info->mount_opt;
+	ctx->compress_type = fs_info->compress_type;
+	ctx->compress_level = fs_info->compress_level;
+}
+
+#define btrfs_info_if_set(fs_info, old_ctx, opt, fmt, args...)			\
+do {										\
+	if ((!old_ctx || !btrfs_raw_test_opt(old_ctx->mount_opt, opt)) &&	\
+	    btrfs_raw_test_opt(fs_info->mount_opt, opt))			\
+		btrfs_info(fs_info, fmt, ##args);				\
+} while (0)
+
+#define btrfs_info_if_unset(fs_info, old_ctx, opt, fmt, args...)	\
+do {									\
+	if ((old_ctx && btrfs_raw_test_opt(old_ctx->mount_opt, opt)) &&	\
+	    !btrfs_raw_test_opt(fs_info->mount_opt, opt))		\
+		btrfs_info(fs_info, fmt, ##args);			\
+} while (0)
+
+static void btrfs_emit_options(struct btrfs_fs_info *info,
+			       struct btrfs_fs_context *old)
+{
+	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
+	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
+	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
+	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
+	btrfs_info_if_set(info, old, NOTREELOG, "disabling tree log");
+	btrfs_info_if_set(info, old, NOLOGREPLAY, "disabling log replay at mount time");
+	btrfs_info_if_set(info, old, FLUSHONCOMMIT, "turning on flush-on-commit");
+	btrfs_info_if_set(info, old, DISCARD_SYNC, "turning on sync discard");
+	btrfs_info_if_set(info, old, DISCARD_ASYNC, "turning on async discard");
+	btrfs_info_if_set(info, old, FREE_SPACE_TREE, "enabling free space tree");
+	btrfs_info_if_set(info, old, SPACE_CACHE, "enabling disk space caching");
+	btrfs_info_if_set(info, old, CLEAR_CACHE, "force clearing of disk cache");
+	btrfs_info_if_set(info, old, AUTO_DEFRAG, "enabling auto defrag");
+	btrfs_info_if_set(info, old, FRAGMENT_DATA, "fragmenting data");
+	btrfs_info_if_set(info, old, FRAGMENT_METADATA, "fragmenting metadata");
+	btrfs_info_if_set(info, old, REF_VERIFY, "doing ref verification");
+	btrfs_info_if_set(info, old, USEBACKUPROOT, "trying to use backup root at mount time");
+	btrfs_info_if_set(info, old, IGNOREBADROOTS, "ignoring bad roots");
+	btrfs_info_if_set(info, old, IGNOREDATACSUMS, "ignoring data csums");
+
+	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
+	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
+	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allocation scheme");
+	btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
+	btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
+	btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space caching");
+	btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space tree");
+	btrfs_info_if_unset(info, old, AUTO_DEFRAG, "disabling auto defrag");
+	btrfs_info_if_unset(info, old, COMPRESS, "use no compression");
+
+	/* Did the compression settings change? */
+	if (btrfs_test_opt(info, COMPRESS) &&
+	    (!old ||
+	     old->compress_type != info->compress_type ||
+	     old->compress_level != info->compress_level ||
+	     (!btrfs_raw_test_opt(old->mount_opt, FORCE_COMPRESS) &&
+	      btrfs_raw_test_opt(info->mount_opt, FORCE_COMPRESS)))) {
+		const char *compress_type =
+			btrfs_compress_type2str(info->compress_type);
+
+		btrfs_info(info, "%s %s compression, level %d",
+			   btrfs_test_opt(info, FORCE_COMPRESS) ? "force" : "use",
+			   compress_type, info->compress_level);
+	}
+
+	if (info->max_inline != BTRFS_DEFAULT_MAX_INLINE)
+		btrfs_info(info, "max_inline at %llu",
+			   info->max_inline);
+}
+
+static int btrfs_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_context old_ctx;
+	int ret = 0;
+
+	btrfs_info_to_ctx(fs_info, &old_ctx);
+
+	sync_filesystem(sb);
+	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	if (!check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+		return -EINVAL;
+
+	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
+	if (ret < 0)
+		return ret;
+
+	btrfs_ctx_to_info(fs_info, ctx);
+	btrfs_remount_begin(fs_info, old_ctx.mount_opt, fc->sb_flags);
+	btrfs_resize_thread_pool(fs_info, fs_info->thread_pool_size,
+				 old_ctx.thread_pool_size);
+
+	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    (!sb_rdonly(sb) || (fc->sb_flags & SB_RDONLY))) {
+		btrfs_warn(fs_info,
+		"remount supports changing free space tree only from ro to rw");
+		/* Make sure free space cache options match the state on disk */
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+		if (btrfs_free_space_cache_v1_active(fs_info)) {
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
+	ret = 0;
+	if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY))
+		ret = btrfs_remount_ro(fs_info);
+	else if (sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY))
+		ret = btrfs_remount_rw(fs_info);
+	if (ret)
+		goto restore;
+
+	/*
+	 * If we set the mask during the parameter parsing vfs would reject the
+	 * remount.  Here we can set the mask and the value will be updated
+	 * appropriately.
+	 */
+	if ((fc->sb_flags & SB_POSIXACL) != (sb->s_flags & SB_POSIXACL))
+		fc->sb_flags_mask |= SB_POSIXACL;
+
+	btrfs_emit_options(fs_info, &old_ctx);
+	wake_up_process(fs_info->transaction_kthread);
+	btrfs_remount_cleanup(fs_info, old_ctx.mount_opt);
+	btrfs_clear_oneshot_options(fs_info);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	return 0;
+restore:
+	btrfs_ctx_to_info(fs_info, &old_ctx);
+	btrfs_remount_cleanup(fs_info, old_ctx.mount_opt);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+	return ret;
+}
+
 /* Used to sort the devices by max_avail(descending sort) */
 static int btrfs_cmp_device_free_bytes(const void *a, const void *b)
 {
@@ -2663,6 +2829,7 @@ static void btrfs_free_fs_context(struct fs_context *fc)
 
 static const struct fs_context_operations btrfs_fs_context_ops = {
 	.parse_param	= btrfs_parse_param,
+	.reconfigure	= btrfs_reconfigure,
 	.free		= btrfs_free_fs_context,
 };
 
@@ -2674,17 +2841,18 @@ static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->thread_pool_size = min_t(unsigned long, num_online_cpus() + 2, 8);
-	ctx->max_inline = BTRFS_DEFAULT_MAX_INLINE;
-	ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
-	ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
-#ifndef CONFIG_BTRFS_FS_POSIX_ACL
-	ctx->noacl = true;
-#endif
-
 	fc->fs_private = ctx;
 	fc->ops = &btrfs_fs_context_ops;
 
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		btrfs_info_to_ctx(btrfs_sb(fc->root->d_sb), ctx);
+	} else {
+		ctx->thread_pool_size =
+			min_t(unsigned long, num_online_cpus() + 2, 8);
+		ctx->max_inline = BTRFS_DEFAULT_MAX_INLINE;
+		ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+	}
+
 	return 0;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 830f0b6ec89e..25aea5102cf1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -781,7 +781,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	 * Check mount options here, because we might change fs_info->zoned
 	 * from fs_info->zone_size.
 	 */
-	ret = btrfs_check_mountopts_zoned(fs_info);
+	ret = btrfs_check_mountopts_zoned(fs_info, &fs_info->mount_opt);
 	if (ret)
 		return ret;
 
@@ -789,7 +789,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
+				unsigned long *mount_opt)
 {
 	if (!btrfs_is_zoned(info))
 		return 0;
@@ -798,18 +799,21 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 	 * Space cache writing is not COWed. Disable that to avoid write errors
 	 * in sequential zones.
 	 */
-	if (btrfs_test_opt(info, SPACE_CACHE)) {
+	if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
 		btrfs_err(info, "zoned: space cache v1 is not supported");
 		return -EINVAL;
 	}
 
-	if (btrfs_test_opt(info, NODATACOW)) {
+	if (btrfs_raw_test_opt(*mount_opt, NODATACOW)) {
 		btrfs_err(info, "zoned: NODATACOW not supported");
 		return -EINVAL;
 	}
 
-	btrfs_clear_and_info(info, DISCARD_ASYNC,
-			"zoned: async discard ignored and disabled for zoned mode");
+	if (btrfs_raw_test_opt(*mount_opt, DISCARD_ASYNC)) {
+		btrfs_info(info,
+			   "zoned: async discard ignored and disabled for zoned mode");
+		btrfs_clear_opt(*mount_opt, DISCARD_ASYNC);
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index b9cec523b778..a5ed2b147f21 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -45,7 +45,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
-int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
+				unsigned long *mount_opt);
 int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -123,7 +124,8 @@ static inline int btrfs_check_zoned_mode(const struct btrfs_fs_info *fs_info)
 	return -EOPNOTSUPP;
 }
 
-static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
+					      unsigned long *mount_opt)
 {
 	return 0;
 }
-- 
2.41.0


