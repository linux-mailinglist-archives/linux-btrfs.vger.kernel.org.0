Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3733FC9C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhHaObo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237465AbhHaObm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 498A061041
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420247;
        bh=+wm3HApJ4O+wwkDXa7rNb210YBEZATxvZj4/DKfi9RA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RMgEpbI85aCj/vH2hz0bkIisP4Dem6mbPLs1rdEa39kfICtke8trIdl6ZAnqaqMll
         wv7dO1kD++PKDqrvCUkmPkfFCQReHl3eMdm2eovs+l+IwKuD8Wgc32eA88JJQQbcDj
         onovh2yqPueT56w5kCYnPVdKDgna7PFZlF2uDrBO1pAqEFG6+o/yJiWdapZ3mzmey1
         9zcc9C41oUYUQJGbN+A2nm8oGu5gibcI/d2pAncro5E/S+zZ1ojidzRX9Zma1yUBPT
         yag9BTB/eMG4u+LD4148JisX+M1OKeZi1/0TsaYiWWRIoqRUMh00M/+BKy62UW7a2s
         n/pFxVdguPZRA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: avoid expensive search when dropping inode items from log
Date:   Tue, 31 Aug 2021 15:30:35 +0100
Message-Id: <9177e3f2a808435d2fd1c97c6024a61aa1fa82f1.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Whenever we are logging a directory inode, logging that an inode exists or
logging an inode that has changes in its references or xattrs, we attempt
to delete items of this inode we may have previously logged (through calls
to drop_objectid_items()).

That attempt does a btree search for deletion, which is expensive because
it always acquires write locks for extent buffers at levels 2, 1 and 0,
and it balances any node that is less than half full. Acquiring the write
locks can block the task if the extent buffers are already locked or block
other tasks attempting to lock them, which is specially bad in case of log
trees since they are small due to their short life, with a root node at a
level typically not greater than level 2.

If we know that we are logging the inode for the first time in the current
transaction, we can skip the search. This change does that.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 5/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9ca2d99b293b..d4f04b2d74ba 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3864,17 +3864,21 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
  * This cannot be run for file data extents because it does not
  * free the extents they point to.
  */
-static int drop_objectid_items(struct btrfs_trans_handle *trans,
+static int drop_inode_items(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *log,
 				  struct btrfs_path *path,
-				  u64 objectid, int max_key_type)
+				  struct btrfs_inode *inode,
+				  int max_key_type)
 {
 	int ret;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	int start_slot;
 
-	key.objectid = objectid;
+	if (!inode_logged(trans, inode))
+		return 0;
+
+	key.objectid = btrfs_ino(inode);
 	key.type = max_key_type;
 	key.offset = (u64)-1;
 
@@ -3891,7 +3895,7 @@ static int drop_objectid_items(struct btrfs_trans_handle *trans,
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 				      path->slots[0]);
 
-		if (found_key.objectid != objectid)
+		if (found_key.objectid != key.objectid)
 			break;
 
 		found_key.offset = 0;
@@ -5425,7 +5429,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		clear_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
 		if (inode_only == LOG_INODE_EXISTS)
 			max_key_type = BTRFS_XATTR_ITEM_KEY;
-		ret = drop_objectid_items(trans, log, path, ino, max_key_type);
+		ret = drop_inode_items(trans, log, path, inode, max_key_type);
 	} else {
 		if (inode_only == LOG_INODE_EXISTS) {
 			/*
@@ -5449,8 +5453,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			     &inode->runtime_flags)) {
 			if (inode_only == LOG_INODE_EXISTS) {
 				max_key.type = BTRFS_XATTR_ITEM_KEY;
-				ret = drop_objectid_items(trans, log, path, ino,
-							  max_key.type);
+				ret = drop_inode_items(trans, log, path, inode,
+						       max_key.type);
 			} else {
 				clear_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 					  &inode->runtime_flags);
@@ -5469,8 +5473,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			if (inode_only == LOG_INODE_ALL)
 				fast_search = true;
 			max_key.type = BTRFS_XATTR_ITEM_KEY;
-			ret = drop_objectid_items(trans, log, path, ino,
-						  max_key.type);
+			ret = drop_inode_items(trans, log, path, inode,
+					       max_key.type);
 		} else {
 			if (inode_only == LOG_INODE_ALL)
 				fast_search = true;
-- 
2.28.0

