Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57151665A5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbjAKLja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjAKLjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C7B499
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0605B81AD3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3997FC433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436990;
        bh=mHo2nKykopTDW30Yps48wkFh0uy4OHLuGV6DkaDKO+8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e7g5GEi87u+2sMvT2be1mZgQFjXWsDiqLQVGk5Y5wSfhozDxatOdnNoE+lh2Ouedd
         x8NOHZKkgK3o4RNO4DyIlSbHhiyr0HC2XYeZ31mfUgHPVtebz1t6ZfwsuEsveMMQpN
         tdAbQiOkQNOIP/mnUIccYz3O9jsoprR8cKTqe/j3bqyrXn8q7sPCDk8mdX41SphGaF
         P89nhMRJN9C+dYm51oH29ncqEmYmy5ukqX8qF0Ue3dLRPDkuem0cto/Yz1Mblx7vqe
         QI5P3avM80Gq9ZatLva2UqFwOg76Tc00ZSPndBihI6mWLFiJjxN1WU9pePUEv5qTdO
         th4bOFxQ3JFJA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/19] btrfs: send: reduce searches on parent root when checking if dir can be removed
Date:   Wed, 11 Jan 2023 11:36:09 +0000
Message-Id: <506db9ca6dafe05827d4e466b36558b563faa933.1673436276.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673436276.git.fdmanana@suse.com>
References: <cover.1673436276.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During an incremental send, every time we remove a reference (dentry) for
an inode and the parent directory does not exists anymore in the send
root, we go check if we can remove the directory by making a call to
can_rmdir(). This helper can only return true (value 1) if all dentries
were already removed, and for that it always does a search on the parent
root for dir index keys - if it finds any dentry referring to an inode
with a number higher then the inode currently being processed, then the
directory can not be removed and it must return false (value 0).

However that means if a directory that was deleted had 1000 dentries, and
each one pointed to an inode with a number higher then the number of the
directory's inode, we end up doing 1000 searches on the parent root.
Typically files are created in a directory after the directory was created
and therefore they get an higher inode number than the directory. It's
also common to have the each dentry pointing to an inode with a higher
number then the inodes the previous dentries point to, for example when
creating a series of files inside a directory, a very common pattern.

So improve on that by having the first call to can_rmdir() for a directory
to check the number of the inode that the last dentry points to and cache
that inode number in the orphan dir structure. Then every subsequent call
to can_rmdir() can avoid doing a search on the parent root if the number
of the inode currently being processed is smaller than cached inode number
at the directory's orphan dir structure.

This patch is part of a larger patchset and the changelog of the last
patch in the series contains a sample performance test and results.
The patches that comprise the patchset are the following:

  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bc57fa8a6bde..cd4aa0eae66c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -321,6 +321,7 @@ struct orphan_dir_info {
 	u64 ino;
 	u64 gen;
 	u64 last_dir_index_offset;
+	u64 dir_high_seq_ino;
 };
 
 struct name_cache_entry {
@@ -3161,6 +3162,7 @@ static struct orphan_dir_info *add_orphan_dir_info(struct send_ctx *sctx,
 	odi->ino = dir_ino;
 	odi->gen = dir_gen;
 	odi->last_dir_index_offset = 0;
+	odi->dir_high_seq_ino = 0;
 
 	rb_link_node(&odi->node, parent, p);
 	rb_insert_color(&odi->node, &sctx->orphan_dirs);
@@ -3221,6 +3223,8 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 	struct btrfs_key loc;
 	struct btrfs_dir_item *di;
 	struct orphan_dir_info *odi = NULL;
+	u64 dir_high_seq_ino = 0;
+	u64 last_dir_index_offset = 0;
 
 	/*
 	 * Don't try to rmdir the top/root subvolume dir.
@@ -3228,17 +3232,62 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 	if (dir == BTRFS_FIRST_FREE_OBJECTID)
 		return 0;
 
+	odi = get_orphan_dir_info(sctx, dir, dir_gen);
+	if (odi && sctx->cur_ino < odi->dir_high_seq_ino)
+		return 0;
+
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
 
+	if (!odi) {
+		/*
+		 * Find the inode number associated with the last dir index
+		 * entry. This is very likely the inode with the highest number
+		 * of all inodes that have an entry in the directory. We can
+		 * then use it to avoid future calls to can_rmdir(), when
+		 * processing inodes with a lower number, from having to search
+		 * the parent root b+tree for dir index keys.
+		 */
+		key.objectid = dir;
+		key.type = BTRFS_DIR_INDEX_KEY;
+		key.offset = (u64)-1;
+
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		if (ret < 0) {
+			goto out;
+		} else if (ret > 0) {
+			/* Can't happen, the root is never empty. */
+			ASSERT(path->slots[0] > 0);
+			if (WARN_ON(path->slots[0] == 0)) {
+				ret = -EUCLEAN;
+				goto out;
+			}
+			path->slots[0]--;
+		}
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		if (key.objectid != dir || key.type != BTRFS_DIR_INDEX_KEY) {
+			/* No index keys, dir can be removed. */
+			ret = 1;
+			goto out;
+		}
+
+		di = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				    struct btrfs_dir_item);
+		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &loc);
+		dir_high_seq_ino = loc.objectid;
+		if (sctx->cur_ino < dir_high_seq_ino) {
+			ret = 0;
+			goto out;
+		}
+
+		btrfs_release_path(path);
+	}
+
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = 0;
-
-	odi = get_orphan_dir_info(sctx, dir, dir_gen);
-	if (odi)
-		key.offset = odi->last_dir_index_offset;
+	key.offset = odi ? odi->last_dir_index_offset : 0;
 
 	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct waiting_dir_move *dm;
@@ -3251,6 +3300,9 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 				struct btrfs_dir_item);
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &loc);
 
+		dir_high_seq_ino = max(dir_high_seq_ino, loc.objectid);
+		last_dir_index_offset = found_key.offset;
+
 		dm = get_waiting_dir_move(sctx, loc.objectid);
 		if (dm) {
 			dm->rmdir_ino = dir;
@@ -3286,7 +3338,8 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 		odi->gen = dir_gen;
 	}
 
-	odi->last_dir_index_offset = found_key.offset;
+	odi->last_dir_index_offset = last_dir_index_offset;
+	odi->dir_high_seq_ino = max(odi->dir_high_seq_ino, dir_high_seq_ino);
 
 	return 0;
 }
-- 
2.35.1

