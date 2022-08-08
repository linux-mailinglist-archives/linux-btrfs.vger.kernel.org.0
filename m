Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70C958C65F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbiHHK1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 06:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiHHK1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 06:27:50 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBB2708;
        Mon,  8 Aug 2022 03:27:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 6FE022B08A927;
        Mon,  8 Aug 2022 18:27:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1659954466; bh=mGsrWY8o3v/i0UOapxA+RBR5gnJx0IJUHNrLon2doik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=s7CGBe1GdhxnAAbvbFU7TiQsmAAra2ppbX9q/SyO6+Mwd8B9ps3D75+CYD83wvD7k
         VeX7N0UQQ+4gJfxp90j6Bkk3En4pFluYufwNsmHn0+2MErTKkF7zs5+XxcZ2uGh6rK
         Znd/7eH+03SxtEA0M7uslxNRNszJjyWjlPCNA2zE=
From:   bingjingc <bingjingc@synology.com>
To:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH 2/2] btrfs: send: fix a bug that sending unlink commands for directories
Date:   Mon,  8 Aug 2022 18:27:35 +0800
Message-Id: <20220808102735.4556-3-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808102735.4556-1-bingjingc@synology.com>
References: <20220808102735.4556-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

There is a bug sending unlink commands for directories. In
commit 46b2f4590aab ("Btrfs: fix send failure when root has deleted files
still open")', orphan inode issue was addressed. There're no reference
paths for these orphan inodes, so the send operation fails with an ENOENT
error. Therefore, in that patch, sctx->ignore_cur_inode was introduced to
be set if the current inode has a link count of zero for bypassing some
unnecessary steps. And a helper function btrfs_unlink_all_paths() was
introduced and called to clean up old reference paths found in the parent
snapshot. However, not only regular files but also directories can be
orphan inodes. So if it meets an orphan directory, a wrong unlink command
for this directory will be issued. Soon the unlink command fails with an
EISDIR error.

Similar example but making an orphan dir for an incremental send:

  $ btrfs subvolume create vol
  $ mkdir vol/dir
  $ touch vol/dir/foo

  $ btrfs subvolume snapshot -r vol snap1
  $ btrfs subvolume snapshot -r vol snap2

  # Turn the second snapshot to RW mode and delete the whole dir while
  # holding an open file descriptor on it.
  $ btrfs property set snap2 ro false
  $ exec 73<snap2/dir
  $ rm -rf snap2/dir

  # Set the second snapshot back to RO mode and do an incremental send.
  $ btrfs property set snap2 ro true
  $ mkdir receive_dir
  $ btrfs send snap2 -p snap1 | btrfs receive receive_dir/
  At subvol snap2
  ERROR: unlink dir failed. Is a directory

Actually, orphan inodes are more common use cases in cascading backups.
(Please see the illustration below.) In a cascading backup, a user wants
to replicate a couple of snapshots from Machine A to Machine B and from
Machine B to Machine C. Machine B doesn't take any RO snapshots for
sending. All a receiver does is clone an RW subvolume from its parent
snapshot, replay the changes and turn it into RO mode at the end. After
all reference paths of some inodes are deleted in applying changes,
there's no guarantee that orphan inodes will be cleaned up after subvolumes
are turned into RO mode. Moreover, orphan inodes can occur not only in send
snapshots but also in parent snapshots because Machine B may do a batch
replication of a couple of snapshots.

An illustration for cascading backups:
Machine A (snapshot {1..n}) --> Machine B --> Machine C

The intuition to solve the problem is to do orphan cleanups before using
these snapshots for sending. The more reasonable timing is doing orphan
cleanups during the ioctl of turning an RW subvolume into an RO snapshot.
And it's also because an RO snapshot is regarded that the fs tree has
already frozen and will never be adjusted anymore. However, that would make
the work of property changes more complicated than expected. And the
btrfs_orphan_cleanup() is also not promised to remove all orphans
successfully. So we try to extend the original patch to handle orphans in
send/parent snapshots. Here are several cases that need to be considered:

Case 1: BTRFS_COMPARE_TREE_NEW
       |  send snapshot  | action
 --------------------------------
 nlink |        0        | ignore

In case 1, when we get a BTRFS_COMPARE_TREE_NEW tree comparison result,
it means that a new inode is found in the send snapshot and it doesn't
appear in the parent snapshot. Since this inode has a link count of zero
(It's an orphan and there're no reference paths.), we can leverage
sctx->ignore_cur_inode in the original patch to prevent it from being
created.

Case 2: BTRFS_COMPARE_TREE_DELETED
       | parent snapshot | action
 ----------------------------------
 nlink |        0        | as usual

In case 2, when we get a BTRFS_COMPARE_TREE_DELETED tree comparison
result, it means that the inode only appears in the parent snapshot.
As usual, the send operation will try to delete all its reference paths.
However, this inode has a link count of zero, so no reference paths will
be found. No deletion operations will be issued. We don't need to change
any logics.

Case 3: BTRFS_COMPARE_TREE_CHANGED
           |       | parent snapshot | send snapshot | action
 -----------------------------------------------------------------------
 subcase 1 | nlink |        0        |       0       | ignore
 subcase 2 | nlink |       >0        |       0       | new_gen(deletion)
 subcase 3 | nlink |        0        |      >0       | new_gen(creation)

In case 3, when we get a BTRFS_COMPARE_TREE_CHANGED tree comparison result,
it means that the inode appears in both snapshots. Here're three subcases.

First, if the inode has link counts of zero in both snapshots. Since there
are no reference paths for this inode in (source/destination) parent
snapshots and we don't care about whether there is also an orphan inode in
destination or not, we can set sctx->ignore_cur_inode on to prevent it
from being created.

For the second and the third subcases, if there're reference paths in one
snapshot and there're no reference paths in the other snapshot. We can
treat this inode as a new generation. We can also leverage the logic
handling a new generation of an inode with small adjustments. Then it will
delete all old reference paths and create a new inode with new attributes
and paths only when there's a positive link count in the send snapshot.
Unlike regular files, which just require unlink operations for deleting
their old reference paths, a directory may require more operations to
remove its old reference paths. For a non-empty directory, the send
operation will rename it first and finally issue a rmdir operation to
remove it after the last item under this directory has been deleted.
Therefore, we also need to modify the existence definition of inodes to
exclude orphan inodes in get_cur_inode_state(), which is used in
process_recorded_refs(). Then it can properly issue the rmdir operation
after the last item in the directory has been removed.

Note that subcase 3 is not a common case. That's because it's easy to
reduce the hard links of an inode, but once all valid paths are removed,
there're no valid paths for creating other hard links. The only way to do
that is trying to send a older snapshot after a newer snapshot has been
sent.

Fixes: 46b2f4590aab ("Btrfs: fix send failure when root has deleted files still open")
Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/send.c | 218 ++++++++++++++++++++----------------------------
 1 file changed, 89 insertions(+), 129 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 84b09d428ca3..351fb7cdec4c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -850,6 +850,7 @@ enum inode_field {
 	INODE_GID = 0x1 << 4,
 	INODE_RDEV = 0x1 << 5,
 	INODE_ATTR = 0x1 << 6,
+	INODE_NLINK = 0x1 << 7,
 };
 
 struct inode_info {
@@ -860,6 +861,7 @@ struct inode_info {
 	u64 gid;
 	u64 rdev;
 	u64 attr;
+	u64 nlink;
 };
 
 /*
@@ -904,6 +906,8 @@ static int get_inode_info(struct btrfs_root *root, u64 ino, unsigned int flags,
 		info->gid = btrfs_inode_gid(path->nodes[0], ii);
 	if (flags & INODE_RDEV)
 		info->rdev = btrfs_inode_rdev(path->nodes[0], ii);
+	if (flags & INODE_NLINK)
+		info->nlink = btrfs_inode_nlink(path->nodes[0], ii);
 	/*
 	 * Transfer the unchanged u64 value of btrfs_inode_item::flags, that's
 	 * otherwise logically split to 32/32 parts.
@@ -1669,19 +1673,24 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 	int right_ret;
 	u64 left_gen;
 	u64 right_gen;
+	struct inode_info info;
 
-	ret = get_inode_gen(sctx->send_root, ino, &left_gen);
+	ret = get_inode_info(sctx->send_root, ino, INODE_GEN|INODE_NLINK,
+			     &info);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
-	left_ret = ret;
+	left_ret = (info.nlink == 0) ? -ENOENT : ret;
+	left_gen = info.gen;
 
 	if (!sctx->parent_root) {
 		right_ret = -ENOENT;
 	} else {
-		ret = get_inode_gen(sctx->parent_root, ino, &right_gen);
+		ret = get_inode_info(sctx->parent_root, ino,
+				     INODE_GEN|INODE_NLINK, &info);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
-		right_ret = ret;
+		right_ret = (info.nlink == 0) ? -ENOENT : ret;
+		right_gen = info.gen;
 	}
 
 	if (!left_ret && !right_ret) {
@@ -6437,86 +6446,6 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 	return ret;
 }
 
-struct parent_paths_ctx {
-	struct list_head *refs;
-	struct send_ctx *sctx;
-};
-
-static int record_parent_ref(int num, u64 dir, int index, struct fs_path *name,
-			     void *ctx)
-{
-	struct parent_paths_ctx *ppctx = ctx;
-
-	/*
-	 * Pass 0 as the generation for the directory, we don't care about it
-	 * here as we have no new references to add, we just want to delete all
-	 * references for an inode.
-	 */
-	return record_ref_in_tree(&ppctx->sctx->rbtree_deleted_refs, ppctx->refs,
-				  name, dir, 0, ppctx->sctx);
-}
-
-/*
- * Issue unlink operations for all paths of the current inode found in the
- * parent snapshot.
- */
-static int btrfs_unlink_all_paths(struct send_ctx *sctx)
-{
-	LIST_HEAD(deleted_refs);
-	struct btrfs_path *path;
-	struct btrfs_root *root = sctx->parent_root;
-	struct btrfs_key key;
-	struct btrfs_key found_key;
-	struct parent_paths_ctx ctx;
-	int iter_ret = 0;
-	int ret;
-
-	path = alloc_path_for_send();
-	if (!path)
-		return -ENOMEM;
-
-	key.objectid = sctx->cur_ino;
-	key.type = BTRFS_INODE_REF_KEY;
-	key.offset = 0;
-
-	ctx.refs = &deleted_refs;
-	ctx.sctx = sctx;
-
-	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
-		if (found_key.objectid != key.objectid)
-			break;
-		if (found_key.type != key.type &&
-		    found_key.type != BTRFS_INODE_EXTREF_KEY)
-			break;
-
-		ret = iterate_inode_ref(root, path, &found_key, 1,
-					record_parent_ref, &ctx);
-		if (ret < 0)
-			goto out;
-	}
-	/* Catch error found during iteration */
-	if (iter_ret < 0) {
-		ret = iter_ret;
-		goto out;
-	}
-
-	while (!list_empty(&deleted_refs)) {
-		struct recorded_ref *ref;
-
-		ref = list_first_entry(&deleted_refs, struct recorded_ref, list);
-		ret = send_unlink(sctx, ref->full_path);
-		if (ret < 0)
-			goto out;
-		recorded_ref_free(ref);
-	}
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	if (ret)
-		__free_recorded_refs(&deleted_refs);
-	return ret;
-}
-
 static void close_current_inode(struct send_ctx *sctx)
 {
 	u64 i_size;
@@ -6607,25 +6536,37 @@ static int changed_inode(struct send_ctx *sctx,
 	 * file descriptor against it or turning a RO snapshot into RW mode,
 	 * keep an open file descriptor against a file, delete it and then
 	 * turn the snapshot back to RO mode before using it for a send
-	 * operation. So if we find such cases, ignore the inode and all its
-	 * items completely if it's a new inode, or if it's a changed inode
-	 * make sure all its previous paths (from the parent snapshot) are all
-	 * unlinked and all other the inode items are ignored.
+	 * operation. The former is what the receiver operation does.
+	 * Therefore, if we want to send these snapshots soon after they're
+	 * received, we need to handle orphan inodes as well. Moreover,
+	 * orphans can appear not only in the send snapshot but also in the
+	 * parent snapshot. Here are several cases:
+	 *
+	 * Case 1: BTRFS_COMPARE_TREE_NEW
+	 *       |  send snapshot  | action
+	 * --------------------------------
+	 * nlink |        0        | ignore
+	 *
+	 * Case 2: BTRFS_COMPARE_TREE_DELETED
+	 *       | parent snapshot | action
+	 * ----------------------------------
+	 * nlink |        0        | as usual
+	 * Note: No unlinks will be sent bacause there're no reference paths.
+	 *
+	 * Case 3: BTRFS_COMPARE_TREE_CHANGED
+	 *           |       | parent snapshot | send snapshot | action
+	 * -----------------------------------------------------------------------
+	 * subcase 1 | nlink |        0        |       0       | ignore
+	 * subcase 2 | nlink |       >0        |       0       | new_gen(deletion)
+	 * subcase 3 | nlink |        0        |      >0       | new_gen(creation)
+	 *
 	 */
-	if (result == BTRFS_COMPARE_TREE_NEW ||
-	    result == BTRFS_COMPARE_TREE_CHANGED) {
-		u32 nlinks;
-
-		nlinks = btrfs_inode_nlink(sctx->left_path->nodes[0], left_ii);
-		if (nlinks == 0) {
+	if (result == BTRFS_COMPARE_TREE_NEW) {
+		if (btrfs_inode_nlink(sctx->left_path->nodes[0], left_ii) ==
+				      0) {
 			sctx->ignore_cur_inode = true;
-			if (result == BTRFS_COMPARE_TREE_CHANGED)
-				ret = btrfs_unlink_all_paths(sctx);
 			goto out;
 		}
-	}
-
-	if (result == BTRFS_COMPARE_TREE_NEW) {
 		sctx->cur_inode_gen = left_gen;
 		sctx->cur_inode_new = true;
 		sctx->cur_inode_deleted = false;
@@ -6646,6 +6587,18 @@ static int changed_inode(struct send_ctx *sctx,
 		sctx->cur_inode_mode = btrfs_inode_mode(
 				sctx->right_path->nodes[0], right_ii);
 	} else if (result == BTRFS_COMPARE_TREE_CHANGED) {
+		u32 new_nlinks, old_nlinks;
+
+		new_nlinks = btrfs_inode_nlink(sctx->left_path->nodes[0],
+					       left_ii);
+		old_nlinks = btrfs_inode_nlink(sctx->right_path->nodes[0],
+					       right_ii);
+		if (new_nlinks == 0 && old_nlinks == 0) {
+			sctx->ignore_cur_inode = true;
+			goto out;
+		} else if (new_nlinks == 0 || old_nlinks == 0) {
+			sctx->cur_inode_new_gen = 1;
+		}
 		/*
 		 * We need to do some special handling in case the inode was
 		 * reported as changed with a changed generation number. This
@@ -6672,38 +6625,45 @@ static int changed_inode(struct send_ctx *sctx,
 			/*
 			 * Now process the inode as if it was new.
 			 */
-			sctx->cur_inode_gen = left_gen;
-			sctx->cur_inode_new = true;
-			sctx->cur_inode_deleted = false;
-			sctx->cur_inode_size = btrfs_inode_size(
-					sctx->left_path->nodes[0], left_ii);
-			sctx->cur_inode_mode = btrfs_inode_mode(
-					sctx->left_path->nodes[0], left_ii);
-			sctx->cur_inode_rdev = btrfs_inode_rdev(
-					sctx->left_path->nodes[0], left_ii);
-			ret = send_create_inode_if_needed(sctx);
-			if (ret < 0)
-				goto out;
+			if (new_nlinks > 0) {
+				sctx->cur_inode_gen = left_gen;
+				sctx->cur_inode_new = true;
+				sctx->cur_inode_deleted = false;
+				sctx->cur_inode_size = btrfs_inode_size(
+						sctx->left_path->nodes[0],
+						left_ii);
+				sctx->cur_inode_mode = btrfs_inode_mode(
+						sctx->left_path->nodes[0],
+						left_ii);
+				sctx->cur_inode_rdev = btrfs_inode_rdev(
+						sctx->left_path->nodes[0],
+						left_ii);
+				ret = send_create_inode_if_needed(sctx);
+				if (ret < 0)
+					goto out;
 
-			ret = process_all_refs(sctx, BTRFS_COMPARE_TREE_NEW);
-			if (ret < 0)
-				goto out;
-			/*
-			 * Advance send_progress now as we did not get into
-			 * process_recorded_refs_if_needed in the new_gen case.
-			 */
-			sctx->send_progress = sctx->cur_ino + 1;
+				ret = process_all_refs(sctx,
+						BTRFS_COMPARE_TREE_NEW);
+				if (ret < 0)
+					goto out;
+				/*
+				 * Advance send_progress now as we did not get
+				 * into process_recorded_refs_if_needed in the
+				 * new_gen case.
+				 */
+				sctx->send_progress = sctx->cur_ino + 1;
 
-			/*
-			 * Now process all extents and xattrs of the inode as if
-			 * they were all new.
-			 */
-			ret = process_all_extents(sctx);
-			if (ret < 0)
-				goto out;
-			ret = process_all_new_xattrs(sctx);
-			if (ret < 0)
-				goto out;
+				/*
+				 * Now process all extents and xattrs of the
+				 * inode as if they were all new.
+				 */
+				ret = process_all_extents(sctx);
+				if (ret < 0)
+					goto out;
+				ret = process_all_new_xattrs(sctx);
+				if (ret < 0)
+					goto out;
+			}
 		} else {
 			sctx->cur_inode_gen = left_gen;
 			sctx->cur_inode_new = false;
-- 
2.37.1

