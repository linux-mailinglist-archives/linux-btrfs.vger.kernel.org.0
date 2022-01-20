Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1832B494C5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiATLAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:00:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38758 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiATLAQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393E461524
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2776FC340E5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676415;
        bh=09MUbw+tFr9CDe9G50kWP7BT7J9XtvAMfMJCOKqTrVE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FuzrsdGNM/PUUwdvW5BjIZzhNlzzSv2xgVP0GiaX7yiFtLopZ5heViiQvoUbD8SCd
         1PS3fqgCc4Ok31OAxsEWo99j3vRTjUb6Zoe3rWdm3wJHWUTMPo6qB1hRhyDoH3xdiC
         WjZB30M2dAilSqbhKLp440EbPJzwtuB7Rt/4pMs/YWR1+rJGnIhMSv3f+txKDai5XB
         F6/b5GznqUtj93B7V82OY67BvpYn7HX+0IwNcdBQGGk+IBN+36kkaIMa+4cTB8ZCKk
         1jR+pwhvSi7Zl3+DohiHtqW1qFSyn6rDktPJWKIa5BaeHBQaB4IMGjPlfusKEid3fE
         PgvOfU3TmmVLA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: add helper to delete a dir entry from a log tree
Date:   Thu, 20 Jan 2022 11:00:06 +0000
Message-Id: <1f5a887dfbf3399087d15f079cd9f7e6ab70d7a7.1642676248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642676248.git.fdmanana@suse.com>
References: <cover.1642676248.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Move the code that finds and deletes a logged dir entry out of
btrfs_del_dir_entries_in_log() into a helper function. This new helper
function will be used by another patch in the same series, and serves
to avoid having duplicated logic.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 68 ++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 97ce445fd434..fc0da7ee4e23 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3490,6 +3490,39 @@ static bool inode_logged(struct btrfs_trans_handle *trans,
 	return false;
 }
 
+/*
+ * Delete a directory entry from the log if it exists.
+ * Returns < 0 on error, 1 if the entry does not exists and 0 if the entry
+ * existed and was successfully deleted.
+ */
+static int del_logged_dentry(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *log,
+			     struct btrfs_path *path,
+			     u64 dir_ino,
+			     const char *name, int name_len,
+			     u64 index)
+{
+	struct btrfs_dir_item *di;
+
+	/*
+	 * We only log dir index items of a directory, so we don't need to look
+	 * for dir item keys.
+	 */
+	di = btrfs_lookup_dir_index_item(trans, log, path, dir_ino,
+					 index, name, name_len, -1);
+	if (IS_ERR(di))
+		return PTR_ERR(di);
+	else if (!di)
+		return 1;
+
+	/*
+	 * We do not need to update the size field of the directory's
+	 * inode item because on log replay we update the field to reflect
+	 * all existing entries in the directory (see overwrite_item()).
+	 */
+	return btrfs_delete_one_dir_name(trans, log, path, di);
+}
+
 /*
  * If both a file and directory are logged, and unlinks or renames are
  * mixed in, we have a few interesting corners:
@@ -3516,12 +3549,8 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 				  const char *name, int name_len,
 				  struct btrfs_inode *dir, u64 index)
 {
-	struct btrfs_root *log;
-	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	int ret;
-	int err = 0;
-	u64 dir_ino = btrfs_ino(dir);
 
 	if (!inode_logged(trans, dir))
 		return;
@@ -3532,41 +3561,18 @@ void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 
 	mutex_lock(&dir->log_mutex);
 
-	log = root->log_root;
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out_unlock;
 	}
 
-	/*
-	 * We only log dir index items of a directory, so we don't need to look
-	 * for dir item keys.
-	 */
-	di = btrfs_lookup_dir_index_item(trans, log, path, dir_ino,
-					 index, name, name_len, -1);
-	if (IS_ERR(di)) {
-		err = PTR_ERR(di);
-		goto fail;
-	}
-	if (di) {
-		ret = btrfs_delete_one_dir_name(trans, log, path, di);
-		if (ret) {
-			err = ret;
-			goto fail;
-		}
-	}
-
-	/*
-	 * We do not need to update the size field of the directory's inode item
-	 * because on log replay we update the field to reflect all existing
-	 * entries in the directory (see overwrite_item()).
-	 */
-fail:
+	ret = del_logged_dentry(trans, root->log_root, path, btrfs_ino(dir),
+				name, name_len, index);
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&dir->log_mutex);
-	if (err < 0)
+	if (ret < 0)
 		btrfs_set_log_full_commit(trans);
 	btrfs_end_log_trans(root);
 }
-- 
2.33.0

