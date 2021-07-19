Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FF3CCC18
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 04:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhGSCHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 22:07:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55800 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGSCHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 22:07:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72555201B1;
        Mon, 19 Jul 2021 02:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626660246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Telc0DcphOZwyHxdeQxUYRZy91GoniGh/6AzPnmSe8c=;
        b=BT1p5BCfKIGJSaVs9KT5gfpaEbDXmTp+AQtYofuLfxkg9irMUriMpQmIVC1BP+P5hFYlqy
        qp6jwrPQmrXiwehjf1Yg3rjvS5S8nEtUOGOzJ+rvIR+hECHF3YQDd51PDNqCtyC3ge1Gev
        zY3xrqjXUP2s8zi/HbCaVCfT6givXvU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 20F161332A;
        Mon, 19 Jul 2021 02:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id NxbKM5Td9GBZQAAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 19 Jul 2021 02:04:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Joshua <joshua@mailmag.net>
Subject: [PATCH] btrfs-progs: check: speed up v1 space cache clearing by batching more space cache inode deletion in one trans
Date:   Mon, 19 Jul 2021 10:04:02 +0800
Message-Id: <20210719020402.98081-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently v1 space cache clearing will delete one cache inode just in
one transaction, and then start a new transaction to delete the next
inode.

This is far from efficient and can make the already slow v1 space cache
deleting even slower, as large fs has tons of cache inodes to delete.

This patch will speed up the process by batching up to 16 inode deletion
into one transaction.

A quick benchmark of deleting 702 v1 space cache inodes would look like
this:

Unpatched:		4.898s
Patched:		0.087s

Which is obviously a big win.

Reported-by: Joshua <joshua@mailmag.net>
Link: https://lore.kernel.org/linux-btrfs/0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                     | 53 ++++++++++++++++++++++++++------
 kernel-shared/free-space-cache.c | 10 ++----
 kernel-shared/free-space-cache.h |  2 +-
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/check/main.c b/check/main.c
index df2303939ffe..f9615b4ebef3 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9893,33 +9893,66 @@ out:
 	return bad_roots;
 }
 
+/*
+ * Number of free space cache inodes to delete in one transaction.
+ *
+ * This is to speedup the v1 space cache deletion for large fs.
+ */
+#define NR_BLOCK_GROUP_CLUSTER		(16)
+
 static int clear_free_space_cache(void)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *bg_cache;
+	int nr_handled = 0;
 	u64 current = 0;
 	int ret = 0;
 
+	trans = btrfs_start_transaction(gfs_info->tree_root, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start a transaction: %m");
+		return ret;
+	}
+
 	/* Clear all free space cache inodes and its extent data */
 	while (1) {
 		bg_cache = btrfs_lookup_first_block_group(gfs_info, current);
 		if (!bg_cache)
 			break;
-		ret = btrfs_clear_free_space_cache(gfs_info, bg_cache);
-		if (ret < 0)
+		ret = btrfs_clear_free_space_cache(trans, bg_cache);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
 			return ret;
+		}
+		nr_handled++;
+
+		if (nr_handled == NR_BLOCK_GROUP_CLUSTER) {
+			ret = btrfs_commit_transaction(trans,
+						       gfs_info->tree_root);
+			if (ret < 0) {
+				errno = -ret;
+				error("failed to start a transaction: %m");
+				return ret;
+			}
+			trans = btrfs_start_transaction(gfs_info->tree_root, 0);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				errno = -ret;
+				error("failed to start a transaction: %m");
+				return ret;
+			}
+		}
 		current = bg_cache->start + bg_cache->length;
 	}
 
-	/* Don't forget to set cache_generation to -1 */
-	trans = btrfs_start_transaction(gfs_info->tree_root, 0);
-	if (IS_ERR(trans)) {
-		error("failed to update super block cache generation");
-		return PTR_ERR(trans);
-	}
 	btrfs_set_super_cache_generation(gfs_info->super_copy, (u64)-1);
-	btrfs_commit_transaction(trans, gfs_info->tree_root);
-
+	ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to start a transaction: %m");
+	}
 	return ret;
 }
 
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index 802f39450515..10c7c148c259 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -895,10 +895,10 @@ next:
 	}
 }
 
-int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
+int btrfs_clear_free_space_cache(struct btrfs_trans_handle *trans,
 				 struct btrfs_block_group *bg)
 {
-	struct btrfs_trans_handle *trans;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_path path;
 	struct btrfs_key key;
@@ -909,10 +909,6 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 	int slot;
 	int ret;
 
-	trans = btrfs_start_transaction(tree_root, 1);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
 	btrfs_init_path(&path);
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
@@ -1016,7 +1012,5 @@ int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 	}
 out:
 	btrfs_release_path(&path);
-	if (!ret)
-		btrfs_commit_transaction(trans, tree_root);
 	return ret;
 }
diff --git a/kernel-shared/free-space-cache.h b/kernel-shared/free-space-cache.h
index 5274e822cf94..d4a44b04337d 100644
--- a/kernel-shared/free-space-cache.h
+++ b/kernel-shared/free-space-cache.h
@@ -57,6 +57,6 @@ void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		       struct btrfs_free_space *info);
 int btrfs_add_free_space(struct btrfs_free_space_ctl *ctl, u64 offset,
 			 u64 bytes);
-int btrfs_clear_free_space_cache(struct btrfs_fs_info *fs_info,
+int btrfs_clear_free_space_cache(struct btrfs_trans_handle *trans,
 				 struct btrfs_block_group *bg);
 #endif
-- 
2.32.0

