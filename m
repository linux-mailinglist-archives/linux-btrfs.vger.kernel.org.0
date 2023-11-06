Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F07E2F87
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjKFWI7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjKFWIy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:54 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F010A
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:51 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6711dd6595fso27845866d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308531; x=1699913331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADddi46ALDimV8M4top5nURYkZGqEm0y0qUDMKyt84M=;
        b=t+tspPFiKtl115Z8kPo3rIzEdl3/picB/NZBVYM8govrbcfqh3P/qhKc7K/6fnEosx
         hyLdNviLU2fKeIP6NLp+Nab8xzXIVW22HD1eF82I17KLSbfGQ8QukwHBsA7twN4z/HxM
         +/CCcQQh+zBQ/w+gM7iItVuUfqwS9jx9hpcXV3tpD+GfkdtV5oaVXSwWlaCojnWHHLOC
         O1KyFLAl5VgQex7krLJdiKL2EFU70VY77dvyvz73E8q3t/k/keFJrlOOP3v0WismrtUY
         r0iGjfPiVPSP6iR8GnEsPvFgW/K8EzGUsoZ8yHuTgNumMYLaRMFqxpJHYwrw8N2wj5Mz
         XB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308531; x=1699913331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADddi46ALDimV8M4top5nURYkZGqEm0y0qUDMKyt84M=;
        b=sz6naq7P4i9AenIjEEh8E6K6Mxb7wGUOk0NRebk56zvY1lYgf1oAHewC4AzP1urd4b
         s2x7bE4/1F0yrsPey7Wi8DMRCXKM7r9MQGmKBVC1aE2juCiG4dOlD332WHV4uuH0pLbS
         EDdJavHZ7kZatTrUTqIw41rXYBnSq5dE+os/jFA01pgSJOmp7pgcDSNJ9w4+0iZDUNuL
         +qKdmq/nkTM3q9/S7KA3c4RZjXunr7IF5WTVeZ8rLJO0UTgCUTOO9oPhQTEDbvYbvecM
         9fGHx7/+VQv73R1ZmX4nhKHBxP77+sVpTJwMxkuUPLb+ZytynspzjrEjFAahYrH2CORn
         jRiQ==
X-Gm-Message-State: AOJu0YyAE73LgxCh3rHFV7Fj1IybhRWwhQPJgu8BvGnY6NDOQaXgolfy
        19ptmS0iabcDB1Ww0VyQ3OOKH14+YEx90b4y9pEQIw==
X-Google-Smtp-Source: AGHT+IG0WF2Jny6ZWJmZQrbhjeHmT5dWJZVKvAqfbUfYdtflUwesXPXxQcoOgSBzCaN3QeBcNxC23g==
X-Received: by 2002:ad4:5b83:0:b0:66d:169a:d41c with SMTP id 3-20020ad45b83000000b0066d169ad41cmr32381398qvp.19.1699308530828;
        Mon, 06 Nov 2023 14:08:50 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t2-20020a0cef02000000b0064f53943626sm3799820qvr.89.2023.11.06.14.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 14/18] btrfs: switch to the new mount API
Date:   Mon,  6 Nov 2023 17:08:22 -0500
Message-ID: <2a6839a7f8a7769e13d03f39064f96180fba7432.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
 fs/btrfs/disk-io.c |  5 +--
 fs/btrfs/super.c   | 88 ++++++++++++++++++++++++++--------------------
 fs/btrfs/super.h   |  2 ++
 3 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c70e507a28d0..ce861f4baf47 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3295,9 +3295,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e2ac0801211d..a99af94a7409 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -304,7 +304,7 @@ static const struct constant_table btrfs_parameter_fragment[] = {
 };
 #endif
 
-static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
+static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("acl", Opt_acl),
 	fsparam_flag("clear_cache", Opt_clear_cache),
 	fsparam_u32("commit", Opt_commit_interval),
@@ -747,8 +747,8 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
-			  unsigned long flags)
+bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			 unsigned long flags)
 {
 	if (!(flags & SB_RDONLY) &&
 	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
@@ -783,18 +783,6 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 
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
@@ -804,6 +792,35 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
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
@@ -1340,7 +1357,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 out:
-	if (!ret && !check_options(info, &info->mount_opt, new_flags))
+	if (!ret && !btrfs_check_options(info, &info->mount_opt, new_flags))
 		ret = -EINVAL;
 	return ret;
 }
@@ -1641,10 +1658,6 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-	sb->s_flags |= SB_POSIXACL;
-#endif
-	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	err = super_setup_bdi(sb);
@@ -1924,7 +1937,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
  * Note: This is based on mount_bdev from fs/super.c with a few additions
  *       for multiple device setup.  Make sure to keep it in sync.
  */
-static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
+static __maybe_unused struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		int flags, const char *device_name, void *data)
 {
 	struct block_device *bdev = NULL;
@@ -2057,7 +2070,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
  *   3. Call mount_subvol() to get the dentry of subvolume. Since there is
  *      "btrfs subvolume set-default", mount_subvol() is called always.
  */
-static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
+static __maybe_unused struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 		const char *device_name, void *data)
 {
 	struct vfsmount *mnt_root;
@@ -2521,7 +2534,7 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	if (!mount_reconfigure &&
-	    !check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
@@ -3189,7 +3202,7 @@ static const struct fs_context_operations btrfs_fs_context_ops = {
 	.free		= btrfs_free_fs_context,
 };
 
-static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
+static int btrfs_init_fs_context(struct fs_context *fc)
 {
 	struct btrfs_fs_context *ctx;
 
@@ -3210,24 +3223,22 @@ static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
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
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+ };
 
 MODULE_ALIAS_FS("btrfs");
 
@@ -3440,7 +3451,6 @@ static const struct super_operations btrfs_super_ops = {
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

