Return-Path: <linux-btrfs+bounces-304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB407F4E23
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B61C209E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7B5B5A9;
	Wed, 22 Nov 2023 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KmJaX3pn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22D83
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:19 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5cb8440a23cso23687337b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673498; x=1701278298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aAowW0B1vhc5svaJC1OJMk+SQsoJKCurL9XlqABdxg=;
        b=KmJaX3pnL6oiqbCqAPKOEEuzR6C3SfmHhtxQLN8ZFw4FCglkZhitK6CwX2ZicfwyOZ
         FxUhkx7NCbYS6El5ZFRMvFcGvAJRuXMetLGX8OT+xFTfMCWZdyboPUGexlsPbof55TPz
         SX0y3F4g73UHOvr7EgAveXWmDbR9RxQxlpyqz9dZq8HFeYOEOjnJR0lNfNUww5Vtnw5Q
         gJAUeX/OCasjS3U9FZu/4cZpkFcMLoqgC85yFSUvuYbbRk3fi83HnHuTLQEW8YyHDdKR
         HYSHkYlP7IWonSnu3lgBhh6iec/8l0GgmNp2GcK66aF0SxFWi08GzyZS9SwUUYPZl6k4
         SrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673498; x=1701278298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aAowW0B1vhc5svaJC1OJMk+SQsoJKCurL9XlqABdxg=;
        b=WOw+nf2c61VqQWYLuL946y0k28WcGlrqmYXCR6HtvfI9NcX8SXHQVz8i1IuqFyYheb
         8wJ2pMQubCDZ3PRqz1dLc3vP6X0f+9gtm3EeIqNQraXBNMQz4ayqcGg5cYxak8+uhxyU
         qN4AntcmKPyUL6eW19zOtPPjIjJkh28O2I/RQjnEjdaYs6rwgO3HewUex3SjJGwWN91o
         p+7E1EtIXoNGemgG8dybpjwtC1kq/36XYe1pTjV0EMJLKr2nAwBOtPALqqf1UwdmowpM
         zgcG4Z5W0clRkdNF0qckS2c/pytgOPRIJHqbKQC9LBDrkrzEpd2V0Fg7/1nTxx4uyC97
         FTxQ==
X-Gm-Message-State: AOJu0YzW/QG7Ua1A21mI9TnqTztl30kvl1gE1lJIANGyzc3+ytcPrNug
	Cr/htHUR2aSceiO2coBY49nB+W0kM0Uay0PMG5kW7WfI
X-Google-Smtp-Source: AGHT+IGC0Cbv0n/HR2mGWEj9MbZKVQB/pdZMl3RdYVEElESW0zW1NSSmWcylUqgcYDIb63WJw/5W8A==
X-Received: by 2002:a81:b726:0:b0:5cc:d0bc:fc24 with SMTP id v38-20020a81b726000000b005ccd0bcfc24mr1286959ywh.22.1700673498206;
        Wed, 22 Nov 2023 09:18:18 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m2-20020a819c02000000b0057a44e20fb8sm3798134ywa.73.2023.11.22.09.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 14/19] btrfs: switch to the new mount API
Date: Wed, 22 Nov 2023 12:17:50 -0500
Message-ID: <cb60cc0f2284c0f0608be74c400486df21c1f6b6.1700673401.git.josef@toxicpanda.com>
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

Now that we have all of the parts in place to use the new mount API,
switch our fs_type to use the new callbacks.

There are a few things that have to be done at the same time because of
the order of operations changes that come along with the new mount API.
These must be done in the same patch otherwise things will go wrong.

1. Export and use btrfs_check_options in open_ctree().  This is because
   the options are done ahead of time, and we need to check them once we
   have the feature flags loaded.
2. Update the free space cache settings.  Since we're coming in with the
   options already set we need to make sure we don't undo what the user
   has asked for.
3. Set our sb_flags at init_fs_context time, the fs_context stuff is
   trying to manage the sb_flagss itself, so move that into
   init_fs_context and out of the fill super part.

Additionally I've marked the unused functions with __maybe_unused and
will remove them in a future patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 11 ++++--
 fs/btrfs/super.c   | 88 ++++++++++++++++++++++++++--------------------
 fs/btrfs/super.h   |  2 ++
 3 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3c72bc1d09a3..6df8dbea3581 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3308,14 +3308,21 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	btrfs_set_free_space_cache_settings(fs_info);
 
-	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
-	if (ret)
+	if (!btrfs_check_options(fs_info, &fs_info->mount_opt, sb->s_flags)) {
+		ret = -EINVAL;
 		goto fail_alloc;
+	}
 
 	ret = btrfs_check_features(fs_info, !sb_rdonly(sb));
 	if (ret < 0)
 		goto fail_alloc;
 
+	/*
+	 * At this point our mount options are validated, if we set ->max_inline
+	 * to something non-standard make sure we truncate it to sectorsize.
+	 */
+	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
+
 	if (sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c2b42f0e6a07..3bb77fb72f03 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -307,7 +307,7 @@ static const struct constant_table btrfs_parameter_fragment[] = {
 };
 #endif
 
-static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
+static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("acl", Opt_acl),
 	fsparam_flag("clear_cache", Opt_clear_cache),
 	fsparam_u32("commit", Opt_commit_interval),
@@ -742,8 +742,8 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
-			  unsigned long flags)
+bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			 unsigned long flags)
 {
 	bool ret = true;
 
@@ -792,18 +792,6 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
  */
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 {
-	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-	else if (btrfs_free_space_cache_v1_active(fs_info)) {
-		if (btrfs_is_zoned(fs_info)) {
-			btrfs_info(fs_info,
-			"zoned: clearing existing space cache");
-			btrfs_set_super_cache_generation(fs_info->super_copy, 0);
-		} else {
-			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
-		}
-	}
-
 	if (fs_info->sectorsize < PAGE_SIZE) {
 		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
 		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
@@ -813,6 +801,35 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
 		}
 	}
+
+	/*
+	 * At this point our mount options are populated, so we only mess with
+	 * these settings if we don't have any settings already.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		return;
+
+	if (btrfs_is_zoned(fs_info) &&
+	    btrfs_free_space_cache_v1_active(fs_info)) {
+		btrfs_info(fs_info, "zoned: clearing existing space cache");
+		btrfs_set_super_cache_generation(fs_info->super_copy, 0);
+		return;
+	}
+
+	if (btrfs_test_opt(fs_info, SPACE_CACHE))
+		return;
+
+	if (btrfs_test_opt(fs_info, NOSPACECACHE))
+		return;
+
+	/*
+	 * At this point we don't have explicit options set by the user, set
+	 * them ourselves based on the state of the file system.
+	 */
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+	else if (btrfs_free_space_cache_v1_active(fs_info))
+		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
 }
 
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
@@ -1349,7 +1366,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 out:
-	if (!ret && !check_options(info, &info->mount_opt, new_flags))
+	if (!ret && !btrfs_check_options(info, &info->mount_opt, new_flags))
 		ret = -EINVAL;
 	return ret;
 }
@@ -1650,10 +1667,6 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-	sb->s_flags |= SB_POSIXACL;
-#endif
-	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	err = super_setup_bdi(sb);
@@ -1933,7 +1946,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
  * Note: This is based on mount_bdev from fs/super.c with a few additions
  *       for multiple device setup.  Make sure to keep it in sync.
  */
-static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
+static __maybe_unused struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		int flags, const char *device_name, void *data)
 {
 	struct block_device *bdev = NULL;
@@ -2066,7 +2079,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
  *   3. Call mount_subvol() to get the dentry of subvolume. Since there is
  *      "btrfs subvolume set-default", mount_subvol() is called always.
  */
-static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
+static __maybe_unused struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 		const char *device_name, void *data)
 {
 	struct vfsmount *mnt_root;
@@ -2497,7 +2510,7 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	if (!mount_reconfigure &&
-	    !check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
@@ -3165,7 +3178,7 @@ static const struct fs_context_operations btrfs_fs_context_ops = {
 	.free		= btrfs_free_fs_context,
 };
 
-static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
+static int btrfs_init_fs_context(struct fs_context *fc)
 {
 	struct btrfs_fs_context *ctx;
 
@@ -3186,24 +3199,22 @@ static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
 		ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 	}
 
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+	fc->sb_flags |= SB_POSIXACL;
+#endif
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
 static struct file_system_type btrfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.mount		= btrfs_mount,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
-};
-
-static struct file_system_type btrfs_root_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.mount		= btrfs_mount_root,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
-};
+	.owner			= THIS_MODULE,
+	.name			= "btrfs",
+	.init_fs_context	= btrfs_init_fs_context,
+	.parameters		= btrfs_fs_parameters,
+	.kill_sb		= btrfs_kill_super,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+ };
 
 MODULE_ALIAS_FS("btrfs");
 
@@ -3416,7 +3427,6 @@ static const struct super_operations btrfs_super_ops = {
 	.destroy_inode	= btrfs_destroy_inode,
 	.free_inode	= btrfs_free_inode,
 	.statfs		= btrfs_statfs,
-	.remount_fs	= btrfs_remount,
 	.freeze_fs	= btrfs_freeze,
 	.unfreeze_fs	= btrfs_unfreeze,
 };
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 7c1cd7527e76..7f6577d69902 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
+bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			 unsigned long flags);
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
-- 
2.41.0


