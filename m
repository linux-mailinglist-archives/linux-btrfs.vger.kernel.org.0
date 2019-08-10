Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8536E88B6C
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfHJMlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 08:41:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33376 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 08:41:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so7878208wme.0
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2019 05:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vp2FQNrb/05rKIMMeAtPtEXspgF/MgsZg0nzqIynk9g=;
        b=KzGMrvCij18FyTYOIhkG266sXtUVno4OT4w9iEVYD/xIx9eLi/yMFbgzgtUu3vnniM
         QdoF5lbmVoxDODeeiYLiBvjIktdPr3dWLWYukGyTGDh4S2wWNOl5YJH8krUugAfMRnUQ
         7UoTWIQxvOyWMH9fWVGR7GtwCoSmixEESGkTWK104xowrx+AVSwyUaBzZ0w4WG0DoKXj
         eMPn0YBfQfb6t0f2U0/WhDPM422KVxSedDeJUqJTBStTsBxDnGgH/lIfE3iZukflxMwk
         kiMh6OgLNeJzujH/0G9VtrLZd5qRshBxAAra9PIvUR0cg/KXdwNb5NzUiEY7Q7iHCnUH
         D1bQ==
X-Gm-Message-State: APjAAAUVSNz6R/gSQdm8DBh9j0TCkKzqKsJWXQ2OzyaiRtytW6VuzTyv
        MoPpYCWgId4aVBTO8L0rT8HlCWjlEiQ=
X-Google-Smtp-Source: APXvYqx3Ymr/P6/aPN80zhxhtEdSgleCrnCUXMXFt1Ql/yXR3e6aoS+7FgNcGrXPyelF6/kp+4BiCw==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr2632494wml.134.1565440881496;
        Sat, 10 Aug 2019 05:41:21 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id p13sm32060364wrw.90.2019.08.10.05.41.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:41:20 -0700 (PDT)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH 1/1] btrfs: Add global_reserve_size mount option
Date:   Sat, 10 Aug 2019 12:41:01 +0000
Message-Id: <20190810124101.15440-2-git@thecybershadow.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190810124101.15440-1-git@thecybershadow.net>
References: <20190810124101.15440-1-git@thecybershadow.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In some circumstances (filesystems with many extents and backrefs),
the global reserve gets overrun causing balance and device deletion
operations to fail with -ENOSPC. Providing a way for users to increase
the global reserve size can allow them to complete the operation.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 fs/btrfs/block-rsv.c |  2 +-
 fs/btrfs/ctree.h     |  3 +++
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/super.c     | 17 ++++++++++++++++-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 698470b9f32d..5e5f5521de0e 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -272,7 +272,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	spin_lock(&sinfo->lock);
 	spin_lock(&block_rsv->lock);
 
-	block_rsv->size = min_t(u64, num_bytes, SZ_512M);
+	block_rsv->size = min_t(u64, num_bytes, fs_info->global_reserve_size);
 
 	if (block_rsv->reserved < block_rsv->size) {
 		num_bytes = btrfs_space_info_used(sinfo, true);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 299e11e6c554..d975d4f5723c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -775,6 +775,8 @@ struct btrfs_fs_info {
 	 */
 	u64 max_inline;
 
+	u64 global_reserve_size;
+
 	struct btrfs_transaction *running_transaction;
 	wait_queue_head_t transaction_throttle;
 	wait_queue_head_t transaction_wait;
@@ -1359,6 +1361,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
+#define BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE (SZ_512M)
 
 #define btrfs_clear_opt(o, opt)		((o) &= ~BTRFS_MOUNT_##opt)
 #define btrfs_set_opt(o, opt)		((o) |= BTRFS_MOUNT_##opt)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5f7ee70b3d1a..06f835a44b8a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2723,6 +2723,7 @@ int open_ctree(struct super_block *sb,
 	atomic64_set(&fs_info->tree_mod_seq, 0);
 	fs_info->sb = sb;
 	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
+	fs_info->global_reserve_size = BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE;
 	fs_info->metadata_ratio = 0;
 	fs_info->defrag_inodes = RB_ROOT;
 	atomic64_set(&fs_info->free_chunk_space, 0);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 78de9d5d80c6..f44223a44cb8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -327,6 +327,7 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
+	Opt_global_reserve_size,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -394,6 +395,7 @@ static const match_table_t tokens = {
 	{Opt_notreelog, "notreelog"},
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_global_reserve_size, "global_reserve_size=%s"},
 
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
@@ -426,7 +428,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags)
 {
 	substring_t args[MAX_OPT_ARGS];
-	char *p, *num;
+	char *p, *num, *retptr;
 	u64 cache_gen;
 	int intarg;
 	int ret = 0;
@@ -746,6 +748,15 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_user_subvol_rm_allowed:
 			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
 			break;
+		case Opt_global_reserve_size:
+			info->global_reserve_size = memparse(args[0].from, &retptr);
+			if (retptr != args[0].to || info->global_reserve_size == 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+			btrfs_info(info, "global_reserve_size at %llu",
+				   info->global_reserve_size);
+			break;
 		case Opt_enospc_debug:
 			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
 			break;
@@ -1336,6 +1347,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",clear_cache");
 	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
 		seq_puts(seq, ",user_subvol_rm_allowed");
+	if (info->global_reserve_size != BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE)
+		seq_printf(seq, ",global_reserve_size=%llu", info->global_reserve_size);
 	if (btrfs_test_opt(info, ENOSPC_DEBUG))
 		seq_puts(seq, ",enospc_debug");
 	if (btrfs_test_opt(info, AUTO_DEFRAG))
@@ -1725,6 +1738,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	u64 old_max_inline = fs_info->max_inline;
 	u32 old_thread_pool_size = fs_info->thread_pool_size;
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
+	u64 old_global_reserve_size = fs_info->global_reserve_size;
 	int ret;
 
 	sync_filesystem(sb);
@@ -1859,6 +1873,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		old_thread_pool_size, fs_info->thread_pool_size);
 	fs_info->metadata_ratio = old_metadata_ratio;
+	fs_info->global_reserve_size = old_global_reserve_size;
 	btrfs_remount_cleanup(fs_info, old_opts);
 	return ret;
 }
-- 
2.22.0

