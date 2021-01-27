Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4381030589E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhA0KiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235757AbhA0Kfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:35:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E15920731
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611743704;
        bh=MzfNKbKofZLjvsMlU8rraxLE9WJAm1eSa48pkb07htM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mtf+DjzjCQwQqbipMKC6fKyqFfkV01m3f22idE43An1+6Er0cN+dFfq8eakJyR4yb
         +bul/ZLcGoXl/oYecCzYhHwczLJo9htnwihf1hMy6hg7TiXkJnCAKBoWyx/s60AMMo
         NnjTsnd0bsZjzLDkI9/LhIZm/i3r/TWw4Vt1Ihxmy9fogPFAxhcvnC/bBydRF/1t0L
         PdazD0D+0tnrKdlri/57AMcz4bKMlYxNvlo3dMMcn+3n9E0+lAwnPvg09zZn+pIFmp
         fSLWCoDM5wFGfKYcSzFnlaN4YiRGut0O0AkeV3ipM2qkgWNlO3HAy5o88fTmd2ZYPx
         ZBOu1ENHL+ZMQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: remove unnecessary directory inode item update when deleting dir entry
Date:   Wed, 27 Jan 2021 10:34:54 +0000
Message-Id: <1d84cf958b2d37fdaac8583dff6ee68ec49251b3.1611742865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
References: <cover.1611742865.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we remove a directory entry, as part of an unlink operation, if the
directory was logged before we must remove the directory index items from
the log. We are also updating the inode item of the directory to update
its i_size, but that is not necessary because during log replay we do not
need it and we correctly adjust the i_size in the inode item of the
subvolume as we process directory index items and replay deletes.

This is not needed since commit d555438b6e1dad ("Btrfs: drop dir i_size
when adding new names on replay"), where we explicitly ignore the i_size
of directory inode items on log replay. Before that we used it but it
was buggy as mentioned in that commit's change log (i_size got a larger
value then it should have).

So stop updating the i_size of the directory inode item in the log, as
that is a waste of time, adds more log contention to the log tree and
often results in COWing more extent buffers for the log tree.

This code path is triggered often during dbench workloads for example.
This patch is part of a patchset comprised of the following patches:

  btrfs: remove unnecessary directory inode item update when deleting dir entry
  btrfs: stop setting nbytes when filling inode item for logging
  btrfs: avoid logging new ancestor inodes when logging new inode
  btrfs: skip logging directories already logged when logging all parents
  btrfs: skip logging inodes already logged when logging new entries
  btrfs: remove unnecessary check_parent_dirs_for_sync()
  btrfs: make concurrent fsyncs wait less when waiting for a transaction commit

Performance results, after applying all patches, are mentioned in the
change log of the last patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ee0700a980f..5d87afc6058a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3379,7 +3379,6 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	int ret;
 	int err = 0;
-	int bytes_del = 0;
 	u64 dir_ino = btrfs_ino(dir);
 
 	if (!inode_logged(trans, dir))
@@ -3406,7 +3405,6 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	}
 	if (di) {
 		ret = btrfs_delete_one_dir_name(trans, log, path, di);
-		bytes_del += name_len;
 		if (ret) {
 			err = ret;
 			goto fail;
@@ -3421,46 +3419,17 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	}
 	if (di) {
 		ret = btrfs_delete_one_dir_name(trans, log, path, di);
-		bytes_del += name_len;
 		if (ret) {
 			err = ret;
 			goto fail;
 		}
 	}
 
-	/* update the directory size in the log to reflect the names
-	 * we have removed
+	/*
+	 * We do not need to update the size field of the directory's inode item
+	 * because on log replay we update the field to reflect all existing
+	 * entries in the directory (see overwrite_item()).
 	 */
-	if (bytes_del) {
-		struct btrfs_key key;
-
-		key.objectid = dir_ino;
-		key.offset = 0;
-		key.type = BTRFS_INODE_ITEM_KEY;
-		btrfs_release_path(path);
-
-		ret = btrfs_search_slot(trans, log, &key, path, 0, 1);
-		if (ret < 0) {
-			err = ret;
-			goto fail;
-		}
-		if (ret == 0) {
-			struct btrfs_inode_item *item;
-			u64 i_size;
-
-			item = btrfs_item_ptr(path->nodes[0], path->slots[0],
-					      struct btrfs_inode_item);
-			i_size = btrfs_inode_size(path->nodes[0], item);
-			if (i_size > bytes_del)
-				i_size -= bytes_del;
-			else
-				i_size = 0;
-			btrfs_set_inode_size(path->nodes[0], item, i_size);
-			btrfs_mark_buffer_dirty(path->nodes[0]);
-		} else
-			ret = 0;
-		btrfs_release_path(path);
-	}
 fail:
 	btrfs_free_path(path);
 out_unlock:
-- 
2.28.0

