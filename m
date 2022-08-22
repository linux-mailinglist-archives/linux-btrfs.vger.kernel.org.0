Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1906A59BDE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiHVKwG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiHVKwD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4D31235
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19D460FFD
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7619C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165521;
        bh=rVW89q5X2SO9ZTLTOPhpkD204k/lCf1NNo/8aIU8Z9E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nNsf31WCCjN9C5LDRw1SkfRkIRRTPSUVxm40h3NiY6IEIOHUACuRucOA8Fc2kssXF
         FT8mCaFsBp8du5FXZmMnfBc85JYXOcC56RI9DC2M8+ebAIXAQ83779EfuFxvAB8+FI
         PzoShsjBq6YnHRsO130O0und6aV/9PJ9/X+TeFeW+qkZ/cOpzTnmN08lK9NAZ0n0GW
         8p4YbMy+fZkaf9ew7m4E5CnNk5abVvyR2Ap2pzZF+ZFdBCIfP4ln0TWvFLae6NPLzi
         7GgVIA3bVyZ1J+DQIkCc9r9/m7XCOUZSb9I/nj036DVv5NGpy7QHNUTh61mNG1ozp4
         w1LwfBhbF6QYA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/15] btrfs: skip logging parent dir when conflicting inode is not a dir
Date:   Mon, 22 Aug 2022 11:51:43 +0100
Message-Id: <9c7aee375e478950b23238a26a2a6a719c4a3db7.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we find a conflicting inode (an inode that had the same name and
parent directory as the inode we are logging now) that was deleted in the
current transaction, we always end up logging its parent directory.

This is to deal with the case where the conflicting inode corresponds to
a deleted subvolume/snapshot or a directory that had subvolumes/snapshots
(or some subdirectory inside it had subvolumes/snapshots, etc), because
we can't deal with dropping subvolumes/snapshots during log replay. So
if we log the parent directory, and if we are dealing with these special
cases, then we fallback to a transaction commit when logging the parent,
because its last_unlink_trans will match the current transaction (which
gets set and propagated when a subvolume/snapshot is deleted).

This change skips the logging of the parent directory when the conflicting
inode is not a directory (or a subvolume/snapshot). This is ok because in
this case logging the current inode is enough to trigger an unlink of the
conflicting inode during log replay.

So for a case like this:

  $ mkdir /mnt/dir
  $ echo -n "first foo data" > /mnt/dir/foo

  $ sync

  $ rm -f /mnt/dir/foo
  $ echo -n "second foo data" > /mnt/dir/foo
  $ xfs_io -c "fsync" /mnt/dir/foo

We avoid logging parent directory "dir" when logging the new file "foo".
In other cases it avoids falling back to a transaction commit, when the
parent directory has a last_unlink_trans value that matches the current
transaction, due to moving a file from it to some other directory.

This is a case that happens frequently with dbench for example, where a
new file that has the name/parent of another file that was deleted in the
current transaction, is fsynced.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 72 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 72e7c9e559cc..1d4c285bb26c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5504,8 +5504,46 @@ static void free_conflicting_inodes(struct btrfs_log_ctx *ctx)
 	}
 }
 
+static int conflicting_inode_is_dir(struct btrfs_root *root, u64 ino,
+				    struct btrfs_path *path)
+{
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (WARN_ON_ONCE(ret > 0)) {
+		/*
+		 * We have previously found the inode through the commit root
+		 * so this should not happen. If it does, just error out and
+		 * fallback to a transaction commit.
+		 */
+		ret = -ENOENT;
+	} else if (ret == 0) {
+		struct btrfs_inode_item *item;
+
+		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				      struct btrfs_inode_item);
+		if (S_ISDIR(btrfs_inode_mode(path->nodes[0], item)))
+			ret = 1;
+	}
+
+	btrfs_release_path(path);
+	path->search_commit_root = 0;
+	path->skip_locking = 0;
+
+	return ret;
+}
+
 static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root,
+				 struct btrfs_path *path,
 				 u64 ino, u64 parent,
 				 struct btrfs_log_ctx *ctx)
 {
@@ -5525,15 +5563,23 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	inode = btrfs_iget(root->fs_info->sb, ino, root);
 	/*
 	 * If the other inode that had a conflicting dir entry was deleted in
-	 * the current transaction, we need to log its parent directory.
-	 * We can't simply ignore it and let the current inode's reference cause
-	 * an unlink of the conflicting inode when replaying the log - because
-	 * the conflicting inode may be a deleted subvolume/snapshot or it may
-	 * be a directory that had subvolumes/snapshots inside it (or had one
-	 * or more subdirectories with subvolumes/snapshots, etc). If that's the
-	 * case, then when logging the parent directory we will fallback to a
-	 * transaction commit because the parent directory will have a
-	 * last_unlink_trans that matches the current transaction.
+	 * the current transaction then we either:
+	 *
+	 * 1) Log the parent directory (later after adding it to the list) if
+	 *    the inode is a directory. This is because it may be a deleted
+	 *    subvolume/snapshot or it may be a regular directory that had
+	 *    deleted subvolumes/snapshots (or subdirectories that had them),
+	 *    and at the moment we can't deal with dropping subvolumes/snapshots
+	 *    during log replay. So we just log the parent, which will result in
+	 *    a fallback to a transaction commit if we are dealing with those
+	 *    cases (last_unlink_trans will match the current transaction);
+	 *
+	 * 2) Do nothing if it's not a directory. During log replay we simply
+	 *    unlink the conflicting dentry from the parent directory and then
+	 *    add the dentry for our inode. Like this we can avoid logging the
+	 *    parent directory (and maybe fallback to a transaction commit in
+	 *    case it has a last_unlink_trans == trans->transid, due to moving
+	 *    some inode from it to some other directory).
 	 */
 	if (IS_ERR(inode)) {
 		int ret = PTR_ERR(inode);
@@ -5541,6 +5587,12 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 		if (ret != -ENOENT)
 			return ret;
 
+		ret = conflicting_inode_is_dir(root, ino, path);
+		/* Not a directory or we got an error. */
+		if (ret <= 0)
+			return ret;
+
+		/* Conflicting inode is a directory, so we'll log its parent. */
 		ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
 		if (!ino_elem)
 			return -ENOMEM;
@@ -5779,7 +5831,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				ins_nr = 0;
 
 				btrfs_release_path(path);
-				ret = add_conflicting_inode(trans, root,
+				ret = add_conflicting_inode(trans, root, path,
 							    other_ino,
 							    other_parent, ctx);
 				if (ret)
-- 
2.35.1

