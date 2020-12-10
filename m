Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028EF2D5A0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 13:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbgLJMJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 07:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732663AbgLJMJr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 07:09:47 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send, fix wrong file path when there is an inode with a pending rmdir
Date:   Thu, 10 Dec 2020 12:09:02 +0000
Message-Id: <e3057ad7ddc549dc204593c01adad90545994617.1607601701.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an incremental send, if we have a new inode that happens to
have the same number that an old directory inode had in the base snapshot
and that old directory has a pending rmdir operation, we end up computing
a wrong path for the new inode, causing the receiver to fail.

Example reproducer:

  $ cat test-send-rmdir.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV >/dev/null
  mount $DEV $MNT

  mkdir $MNT/dir
  touch $MNT/dir/file1
  touch $MNT/dir/file2
  touch $MNT/dir/file3

  # Filesystem looks like:
  #
  # .                                     (ino 256)
  # |----- dir/                           (ino 257)
  #         |----- file1                  (ino 258)
  #         |----- file2                  (ino 259)
  #         |----- file3                  (ino 260)
  #

  btrfs subvolume snapshot -r $MNT $MNT/snap1
  btrfs send -f /tmp/snap1.send $MNT/snap1

  # Now remove our directory and all its files.
  rm -fr $MNT/dir

  # Unmount the filesystem and mount it again. This is to ensure that
  # the next inode that is created ends up with the same inode number
  # that our directory "dir" had, 257, which is the first free "objectid"
  # available after mounting again the filesystem.
  umount $MNT
  mount $DEV $MNT

  # Now create a new file (it could be a directory as well).
  touch $MNT/newfile

  # Filesystem now looks like:
  #
  # .                                     (ino 256)
  # |----- newfile                        (ino 257)
  #

  btrfs subvolume snapshot -r $MNT $MNT/snap2
  btrfs send -f /tmp/snap2.send -p $MNT/snap1 $MNT/snap2

  # Now unmount the filesystem, create a new one, mount it and try to apply
  # both send streams to recreate both snapshots.
  umount $DEV

  mkfs.btrfs -f $DEV >/dev/null

  mount $DEV $MNT

  btrfs receive -f /tmp/snap1.send $MNT
  btrfs receive -f /tmp/snap2.send $MNT

  umount $MNT

When running the test, the receive operation for the incremental stream
fails:

  $ ./test-send-rmdir.sh
  Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap1'
  At subvol /mnt/sdi/snap1
  Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap2'
  At subvol /mnt/sdi/snap2
  At subvol snap1
  At snapshot snap2
  ERROR: chown o257-9-0 failed: No such file or directory

So fix this by tracking directories that have a pending rmdir by inode
number and generation number, instead of only inode number.

A test case for fstests follows soon.

Reported-by: Massimo B. <massimo.b@gmx.net>
Tested-by: Massimo B. <massimo.b@gmx.net>
Link: https://lore.kernel.org/linux-btrfs/6ae34776e85912960a253a8327068a892998e685.camel@gmx.net/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d719a2755a40..1eaa004d97cd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -236,6 +236,7 @@ struct waiting_dir_move {
 	 * after this directory is moved, we can try to rmdir the ino rmdir_ino.
 	 */
 	u64 rmdir_ino;
+	u64 rmdir_gen;
 	bool orphanized;
 };
 
@@ -316,7 +317,7 @@ static int is_waiting_for_move(struct send_ctx *sctx, u64 ino);
 static struct waiting_dir_move *
 get_waiting_dir_move(struct send_ctx *sctx, u64 ino);
 
-static int is_waiting_for_rm(struct send_ctx *sctx, u64 dir_ino);
+static int is_waiting_for_rm(struct send_ctx *sctx, u64 dir_ino, u64 gen);
 
 static int need_send_hole(struct send_ctx *sctx)
 {
@@ -2299,7 +2300,7 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 
 		fs_path_reset(name);
 
-		if (is_waiting_for_rm(sctx, ino)) {
+		if (is_waiting_for_rm(sctx, ino, gen)) {
 			ret = gen_unique_name(sctx, ino, gen, name);
 			if (ret < 0)
 				goto out;
@@ -2859,7 +2860,7 @@ static int orphanize_inode(struct send_ctx *sctx, u64 ino, u64 gen,
 }
 
 static struct orphan_dir_info *
-add_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino)
+add_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino, u64 dir_gen)
 {
 	struct rb_node **p = &sctx->orphan_dirs.rb_node;
 	struct rb_node *parent = NULL;
@@ -2868,20 +2869,23 @@ add_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino)
 	while (*p) {
 		parent = *p;
 		entry = rb_entry(parent, struct orphan_dir_info, node);
-		if (dir_ino < entry->ino) {
+		if (dir_ino < entry->ino)
 			p = &(*p)->rb_left;
-		} else if (dir_ino > entry->ino) {
+		else if (dir_ino > entry->ino)
 			p = &(*p)->rb_right;
-		} else {
+		else if (dir_gen < entry->gen)
+			p = &(*p)->rb_left;
+		else if (dir_gen > entry->gen)
+			p = &(*p)->rb_right;
+		else
 			return entry;
-		}
 	}
 
 	odi = kmalloc(sizeof(*odi), GFP_KERNEL);
 	if (!odi)
 		return ERR_PTR(-ENOMEM);
 	odi->ino = dir_ino;
-	odi->gen = 0;
+	odi->gen = dir_gen;
 	odi->last_dir_index_offset = 0;
 
 	rb_link_node(&odi->node, parent, p);
@@ -2890,7 +2894,7 @@ add_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino)
 }
 
 static struct orphan_dir_info *
-get_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino)
+get_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino, u64 gen)
 {
 	struct rb_node *n = sctx->orphan_dirs.rb_node;
 	struct orphan_dir_info *entry;
@@ -2901,15 +2905,19 @@ get_orphan_dir_info(struct send_ctx *sctx, u64 dir_ino)
 			n = n->rb_left;
 		else if (dir_ino > entry->ino)
 			n = n->rb_right;
+		else if (gen < entry->gen)
+			n = n->rb_left;
+		else if (gen > entry->gen)
+			n = n->rb_right;
 		else
 			return entry;
 	}
 	return NULL;
 }
 
-static int is_waiting_for_rm(struct send_ctx *sctx, u64 dir_ino)
+static int is_waiting_for_rm(struct send_ctx *sctx, u64 dir_ino, u64 gen)
 {
-	struct orphan_dir_info *odi = get_orphan_dir_info(sctx, dir_ino);
+	struct orphan_dir_info *odi = get_orphan_dir_info(sctx, dir_ino, gen);
 
 	return odi != NULL;
 }
@@ -2954,7 +2962,7 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = 0;
 
-	odi = get_orphan_dir_info(sctx, dir);
+	odi = get_orphan_dir_info(sctx, dir, dir_gen);
 	if (odi)
 		key.offset = odi->last_dir_index_offset;
 
@@ -2985,7 +2993,7 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 
 		dm = get_waiting_dir_move(sctx, loc.objectid);
 		if (dm) {
-			odi = add_orphan_dir_info(sctx, dir);
+			odi = add_orphan_dir_info(sctx, dir, dir_gen);
 			if (IS_ERR(odi)) {
 				ret = PTR_ERR(odi);
 				goto out;
@@ -2993,12 +3001,13 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			odi->gen = dir_gen;
 			odi->last_dir_index_offset = found_key.offset;
 			dm->rmdir_ino = dir;
+			dm->rmdir_gen = dir_gen;
 			ret = 0;
 			goto out;
 		}
 
 		if (loc.objectid > send_progress) {
-			odi = add_orphan_dir_info(sctx, dir);
+			odi = add_orphan_dir_info(sctx, dir, dir_gen);
 			if (IS_ERR(odi)) {
 				ret = PTR_ERR(odi);
 				goto out;
@@ -3038,6 +3047,7 @@ static int add_waiting_dir_move(struct send_ctx *sctx, u64 ino, bool orphanized)
 		return -ENOMEM;
 	dm->ino = ino;
 	dm->rmdir_ino = 0;
+	dm->rmdir_gen = 0;
 	dm->orphanized = orphanized;
 
 	while (*p) {
@@ -3183,7 +3193,7 @@ static int path_loop(struct send_ctx *sctx, struct fs_path *name,
 	while (ino != BTRFS_FIRST_FREE_OBJECTID) {
 		fs_path_reset(name);
 
-		if (is_waiting_for_rm(sctx, ino))
+		if (is_waiting_for_rm(sctx, ino, gen))
 			break;
 		if (is_waiting_for_move(sctx, ino)) {
 			if (*ancestor_ino == 0)
@@ -3223,6 +3233,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 	u64 parent_ino, parent_gen;
 	struct waiting_dir_move *dm = NULL;
 	u64 rmdir_ino = 0;
+	u64 rmdir_gen;
 	u64 ancestor;
 	bool is_orphan;
 	int ret;
@@ -3237,6 +3248,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 	dm = get_waiting_dir_move(sctx, pm->ino);
 	ASSERT(dm);
 	rmdir_ino = dm->rmdir_ino;
+	rmdir_gen = dm->rmdir_gen;
 	is_orphan = dm->orphanized;
 	free_waiting_dir_move(sctx, dm);
 
@@ -3273,6 +3285,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 			dm = get_waiting_dir_move(sctx, pm->ino);
 			ASSERT(dm);
 			dm->rmdir_ino = rmdir_ino;
+			dm->rmdir_gen = rmdir_gen;
 		}
 		goto out;
 	}
@@ -3291,7 +3304,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 		struct orphan_dir_info *odi;
 		u64 gen;
 
-		odi = get_orphan_dir_info(sctx, rmdir_ino);
+		odi = get_orphan_dir_info(sctx, rmdir_ino, rmdir_gen);
 		if (!odi) {
 			/* already deleted */
 			goto finish;
-- 
2.28.0

