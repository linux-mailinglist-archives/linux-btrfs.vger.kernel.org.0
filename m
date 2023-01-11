Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBC665A6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjAKLj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjAKLjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17442DD6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70067B81BAD
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D5DC433F0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436987;
        bh=Uo09xMCyOJh/2doMSBpr/i4lt/vMQMvo0rkwF5RDtS8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P5a5j/Bb5zCJew5IrlLIPsR3FV+cuVvODrqGfsvZlQvwOy7/1YHOZjOTVKKsioe97
         1mA4XKhDl9u/ZylnbTcBC+I5gC6uISr8GJyAaEOmA4E+4ilH+6OXqEgH4lVUDSBmGT
         IdQMRFwp4YSQk00cTtroxBkDguLVANY3VeVEsyrovFvNIXFFimBrJvCcY+ENXD1W8n
         QvWXGRnTGi/p4S5VAghjIJGqszy/rUBmh7zO3ZaoqQ6PmmmITHivBh6LhPwlhEDhxR
         fwxfLrJnEQqlr09mx7Z00o2nd+2sdAcKGucpTg1M9QIL8GTPMEYCA4ioBLB67jda3i
         KhzfxSdykgyAA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/19] btrfs: send: avoid extra b+tree searches when checking reference overrides
Date:   Wed, 11 Jan 2023 11:36:05 +0000
Message-Id: <9c5cf707a0db0c0de55809fe56446cf7613ab042.1673436276.git.fdmanana@suse.com>
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

During an incremental send, when processing the new references of an inode
(either it's a new inode or an existing one renamed/moved), he will search
the b+tree of the send or parent roots in order to find out the inode item
of the parent directory and extract its generation. However we are doing
that search twice, once with is_inode_existent() -> get_cur_inode_state()
and then again at did_overwrite_ref() or will_overwrite_ref().

So avoid that and get the generation at get_cur_inode_state() and then
propagate it up to did_overwrite_ref() and will_overwrite_ref().

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
 fs/btrfs/send.c | 61 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9be3d7db85d6..6332add4865c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1884,7 +1884,8 @@ enum inode_state {
 	inode_state_did_delete,
 };
 
-static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
+static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
+			       u64 *send_gen, u64 *parent_gen)
 {
 	int ret;
 	int left_ret;
@@ -1898,6 +1899,8 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 		goto out;
 	left_ret = (info.nlink == 0) ? -ENOENT : ret;
 	left_gen = info.gen;
+	if (send_gen)
+		*send_gen = (left_ret == -ENOENT) ? 0 : info.gen;
 
 	if (!sctx->parent_root) {
 		right_ret = -ENOENT;
@@ -1907,6 +1910,8 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 			goto out;
 		right_ret = (info.nlink == 0) ? -ENOENT : ret;
 		right_gen = info.gen;
+		if (parent_gen)
+			*parent_gen = (right_ret == -ENOENT) ? 0 : info.gen;
 	}
 
 	if (!left_ret && !right_ret) {
@@ -1951,14 +1956,15 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 	return ret;
 }
 
-static int is_inode_existent(struct send_ctx *sctx, u64 ino, u64 gen)
+static int is_inode_existent(struct send_ctx *sctx, u64 ino, u64 gen,
+			     u64 *send_gen, u64 *parent_gen)
 {
 	int ret;
 
 	if (ino == BTRFS_FIRST_FREE_OBJECTID)
 		return 1;
 
-	ret = get_cur_inode_state(sctx, ino, gen);
+	ret = get_cur_inode_state(sctx, ino, gen, send_gen, parent_gen);
 	if (ret < 0)
 		goto out;
 
@@ -2120,14 +2126,14 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			      u64 *who_ino, u64 *who_gen, u64 *who_mode)
 {
 	int ret;
-	u64 gen;
+	u64 parent_root_dir_gen;
 	u64 other_inode = 0;
 	struct btrfs_inode_info info;
 
 	if (!sctx->parent_root)
 		return 0;
 
-	ret = is_inode_existent(sctx, dir, dir_gen);
+	ret = is_inode_existent(sctx, dir, dir_gen, NULL, &parent_root_dir_gen);
 	if (ret <= 0)
 		return 0;
 
@@ -2135,17 +2141,13 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	 * If we have a parent root we need to verify that the parent dir was
 	 * not deleted and then re-created, if it was then we have no overwrite
 	 * and we can just unlink this entry.
+	 *
+	 * @parent_root_dir_gen was set to 0 if the inode does not exists in the
+	 * parent root.
 	 */
-	if (sctx->parent_root && dir != BTRFS_FIRST_FREE_OBJECTID) {
-		ret = get_inode_gen(sctx->parent_root, dir, &gen);
-		if (ret == -ENOENT)
-			return 0;
-		else if (ret < 0)
-			return ret;
-
-		if (gen != dir_gen)
-			return 0;
-	}
+	if (sctx->parent_root && dir != BTRFS_FIRST_FREE_OBJECTID &&
+	    parent_root_dir_gen != dir_gen)
+		return 0;
 
 	ret = lookup_dir_item_inode(sctx->parent_root, dir, name, name_len,
 				    &other_inode);
@@ -2189,26 +2191,21 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 	int ret;
 	u64 ow_inode;
 	u64 ow_gen = 0;
+	u64 send_root_dir_gen;
 
 	if (!sctx->parent_root)
 		return 0;
 
-	ret = is_inode_existent(sctx, dir, dir_gen);
+	ret = is_inode_existent(sctx, dir, dir_gen, &send_root_dir_gen, NULL);
 	if (ret <= 0)
 		return ret;
 
-	if (dir != BTRFS_FIRST_FREE_OBJECTID) {
-		u64 gen;
-
-		ret = get_inode_gen(sctx->send_root, dir, &gen);
-		if (ret == -ENOENT)
-			return 0;
-		else if (ret < 0)
-			return ret;
-
-		if (gen != dir_gen)
-			return 0;
-	}
+	/*
+	 * @send_root_dir_gen was set to 0 if the inode does not exists in the
+	 * send root.
+	 */
+	if (dir != BTRFS_FIRST_FREE_OBJECTID && send_root_dir_gen != dir_gen)
+		return 0;
 
 	/* check if the ref was overwritten by another ref */
 	ret = lookup_dir_item_inode(sctx->send_root, dir, name, name_len,
@@ -2444,7 +2441,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	 * This should only happen for the parent dir that we determine in
 	 * record_new_ref_if_needed().
 	 */
-	ret = is_inode_existent(sctx, ino, gen);
+	ret = is_inode_existent(sctx, ino, gen, NULL, NULL);
 	if (ret < 0)
 		goto out;
 
@@ -4240,7 +4237,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	 * "testdir_2".
 	 */
 	list_for_each_entry(cur, &sctx->new_refs, list) {
-		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen);
+		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen, NULL, NULL);
 		if (ret < 0)
 			goto out;
 		if (ret == inode_state_will_create)
@@ -4356,7 +4353,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * parent directory out of order. But we need to check if this
 		 * did already happen before due to other refs in the same dir.
 		 */
-		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen);
+		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen, NULL, NULL);
 		if (ret < 0)
 			goto out;
 		if (ret == inode_state_will_create) {
@@ -4562,7 +4559,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		if (cur->dir > sctx->cur_ino)
 			continue;
 
-		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen);
+		ret = get_cur_inode_state(sctx, cur->dir, cur->dir_gen, NULL, NULL);
 		if (ret < 0)
 			goto out;
 
-- 
2.35.1

