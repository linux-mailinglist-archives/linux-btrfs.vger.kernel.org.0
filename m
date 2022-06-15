Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50CA54C9D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiFONaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353695AbiFON3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFA40A19
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:29:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 787971F461;
        Wed, 15 Jun 2022 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655299772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SImnCfFkVGKqRDjV/zrVb094TsCNrH8wdRbwssf3IeA=;
        b=LeaL0t1SJYva6DY+RZfHOsCfOesZCsiIm1OdtG6Gm0JP86Lqm5/fTeanuIe0BGhBFVmNoc
        vMrK+DjkgGuRAZGfNqErymYyznHcQtJ4srRfJ7EtLbFKOx2fHLN4Y7FN6cdDTyP8bdQfYn
        wUzcd2HhBLy7SMtg/WJES1YiLYtHB1Y=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 717C62C141;
        Wed, 15 Jun 2022 13:29:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E2CCDA85E; Wed, 15 Jun 2022 15:25:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] btrfs: send: add new command FILEATTR for file attributes
Date:   Wed, 15 Jun 2022 15:25:00 +0200
Message-Id: <a26939dcdedb93d8b43d44d9c33d810d66aba995.1655299339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655299339.git.dsterba@suse.com>
References: <cover.1655299339.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are file attributes inherited from previous ext2 SETFLAGS/GETFLAGS
and later from XFLAGS interfaces, now commonly found under the
'fileattr' API. This corresponds to the individual inode bits and that's
part of the on-disk format, so this is suitable for the protocol. The
other interfaces contain a lot of cruft or bits that btrfs does not
support yet.

Currently the value is u64 and matches btrfs_inode_item. Not all the
bits can be set by ioctls (like NODATASUM or READONLY), but we can send
them over the protocol and leave it up to the receiving side what and
how to apply.

As some of the flags, eg. IMMUTABLE, can prevent any further changes,
the receiving side needs to understand that and apply the changes in the
right order, or possibly with some intermediate steps. This should be
easier, future proof and simpler on the protocol layer than implementing
in kernel.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 104 +++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/send.h |  10 ++++-
 2 files changed, 85 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 63f48a2aa3d4..ba87e1ba1f2a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -846,7 +846,7 @@ static int send_rmdir(struct send_ctx *sctx, struct fs_path *path)
  */
 static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
 			  u64 ino, u64 *size, u64 *gen, u64 *mode, u64 *uid,
-			  u64 *gid, u64 *rdev)
+			  u64 *gid, u64 *rdev, u64 *fileattr)
 {
 	int ret;
 	struct btrfs_inode_item *ii;
@@ -876,6 +876,12 @@ static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
 		*gid = btrfs_inode_gid(path->nodes[0], ii);
 	if (rdev)
 		*rdev = btrfs_inode_rdev(path->nodes[0], ii);
+	/*
+	 * Transfer the unchanged u64 value of btrfs_inode_item::flags, that's
+	 * otherwise logically split to 32/32 parts.
+	 */
+	if (fileattr)
+		*fileattr = btrfs_stack_inode_flags(ii);
 
 	return ret;
 }
@@ -883,7 +889,7 @@ static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
 static int get_inode_info(struct btrfs_root *root,
 			  u64 ino, u64 *size, u64 *gen,
 			  u64 *mode, u64 *uid, u64 *gid,
-			  u64 *rdev)
+			  u64 *rdev, u64 *fileattr)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -892,7 +898,7 @@ static int get_inode_info(struct btrfs_root *root,
 	if (!path)
 		return -ENOMEM;
 	ret = __get_inode_info(root, path, ino, size, gen, mode, uid, gid,
-			       rdev);
+			       rdev, fileattr);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -1638,7 +1644,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 	u64 right_gen;
 
 	ret = get_inode_info(sctx->send_root, ino, NULL, &left_gen, NULL, NULL,
-			NULL, NULL);
+			NULL, NULL, NULL);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
 	left_ret = ret;
@@ -1647,7 +1653,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 		right_ret = -ENOENT;
 	} else {
 		ret = get_inode_info(sctx->parent_root, ino, NULL, &right_gen,
-				NULL, NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL, NULL);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 		right_ret = ret;
@@ -1810,7 +1816,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 
 	if (dir_gen) {
 		ret = get_inode_info(root, parent_dir, NULL, dir_gen, NULL,
-				     NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL);
 		if (ret < 0)
 			goto out;
 	}
@@ -1882,7 +1888,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	 */
 	if (sctx->parent_root && dir != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = get_inode_info(sctx->parent_root, dir, NULL, &gen, NULL,
-				     NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 		if (ret) {
@@ -1910,7 +1916,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	if (other_inode > sctx->send_progress ||
 	    is_waiting_for_move(sctx, other_inode)) {
 		ret = get_inode_info(sctx->parent_root, other_inode, NULL,
-				who_gen, who_mode, NULL, NULL, NULL);
+				who_gen, who_mode, NULL, NULL, NULL, NULL);
 		if (ret < 0)
 			goto out;
 
@@ -1949,7 +1955,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 
 	if (dir != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = get_inode_info(sctx->send_root, dir, NULL, &gen, NULL,
-				     NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 		if (ret) {
@@ -1972,7 +1978,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 	}
 
 	ret = get_inode_info(sctx->send_root, ow_inode, NULL, &gen, NULL, NULL,
-			NULL, NULL);
+			NULL, NULL, NULL);
 	if (ret < 0)
 		goto out;
 
@@ -2501,6 +2507,39 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 	return ret;
 }
 
+static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
+{
+	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
+	int ret = 0;
+	struct fs_path *p;
+
+	if (sctx->proto < 2)
+		return 0;
+
+	btrfs_debug(fs_info, "send_fileattr %llu fileattr=%llu", ino, fileattr);
+
+	p = fs_path_alloc();
+	if (!p)
+		return -ENOMEM;
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_FILEATTR);
+	if (ret < 0)
+		goto out;
+
+	ret = get_cur_path(sctx, ino, gen, p);
+	if (ret < 0)
+		goto out;
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILEATTR, fileattr);
+
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	return ret;
+}
+
 static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 {
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
@@ -2615,7 +2654,7 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 
 	if (ino != sctx->cur_ino) {
 		ret = get_inode_info(sctx->send_root, ino, NULL, &gen, &mode,
-				     NULL, NULL, &rdev);
+				     NULL, NULL, &rdev, NULL);
 		if (ret < 0)
 			goto out;
 	} else {
@@ -3318,7 +3357,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 		 * The parent inode might have been deleted in the send snapshot
 		 */
 		ret = get_inode_info(sctx->send_root, cur->dir, NULL,
-				     NULL, NULL, NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL, NULL, NULL);
 		if (ret == -ENOENT) {
 			ret = 0;
 			continue;
@@ -3493,11 +3532,11 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 	}
 
 	ret = get_inode_info(sctx->parent_root, di_key.objectid, NULL,
-			     &left_gen, NULL, NULL, NULL, NULL);
+			     &left_gen, NULL, NULL, NULL, NULL, NULL);
 	if (ret < 0)
 		goto out;
 	ret = get_inode_info(sctx->send_root, di_key.objectid, NULL,
-			     &right_gen, NULL, NULL, NULL, NULL);
+			     &right_gen, NULL, NULL, NULL, NULL, NULL);
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			ret = 0;
@@ -3628,7 +3667,7 @@ static int is_ancestor(struct btrfs_root *root,
 			}
 
 			ret = get_inode_info(root, parent, NULL, &parent_gen,
-					     NULL, NULL, NULL, NULL);
+					     NULL, NULL, NULL, NULL, NULL);
 			if (ret < 0)
 				goto out;
 			ret = check_ino_in_path(root, ino1, ino1_gen,
@@ -3720,7 +3759,7 @@ static int wait_for_parent_move(struct send_ctx *sctx,
 
 			ret = get_inode_info(sctx->parent_root, ino, NULL,
 					     &parent_ino_gen, NULL, NULL, NULL,
-					     NULL);
+					     NULL, NULL);
 			if (ret < 0)
 				goto out;
 			if (ino_gen == parent_ino_gen) {
@@ -4326,8 +4365,7 @@ static int record_ref(struct btrfs_root *root, u64 dir, struct fs_path *name,
 	if (!p)
 		return -ENOMEM;
 
-	ret = get_inode_info(root, dir, NULL, &gen, NULL, NULL,
-			NULL, NULL);
+	ret = get_inode_info(root, dir, NULL, &gen, NULL, NULL, NULL, NULL, NULL);
 	if (ret < 0)
 		goto out;
 
@@ -4415,7 +4453,7 @@ static int __find_iref(int num, u64 dir, int index,
 		 * else matches.
 		 */
 		ret = get_inode_info(ctx->root, dir, NULL, &dir_gen, NULL,
-				     NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL);
 		if (ret)
 			return ret;
 		if (dir_gen != ctx->dir_gen)
@@ -4459,7 +4497,7 @@ static int __record_changed_new_ref(int num, u64 dir, int index,
 	struct send_ctx *sctx = ctx;
 
 	ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL);
+			     NULL, NULL, NULL, NULL);
 	if (ret)
 		return ret;
 
@@ -4482,7 +4520,7 @@ static int __record_changed_deleted_ref(int num, u64 dir, int index,
 	struct send_ctx *sctx = ctx;
 
 	ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL);
+			     NULL, NULL, NULL, NULL);
 	if (ret)
 		return ret;
 
@@ -5031,7 +5069,7 @@ static int send_clone(struct send_ctx *sctx,
 
 	if (clone_root->root == sctx->send_root) {
 		ret = get_inode_info(sctx->send_root, clone_root->ino, NULL,
-				&gen, NULL, NULL, NULL, NULL);
+				&gen, NULL, NULL, NULL, NULL, NULL);
 		if (ret < 0)
 			goto out;
 		ret = get_cur_path(sctx, clone_root->ino, gen, p);
@@ -5540,7 +5578,8 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	 * accept clones from these extents.
 	 */
 	ret = __get_inode_info(clone_root->root, path, clone_root->ino,
-			       &clone_src_i_size, NULL, NULL, NULL, NULL, NULL);
+			       &clone_src_i_size, NULL, NULL, NULL, NULL, NULL,
+			       NULL);
 	btrfs_release_path(path);
 	if (ret < 0)
 		goto out;
@@ -6235,11 +6274,14 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 	u64 left_mode;
 	u64 left_uid;
 	u64 left_gid;
+	u64 left_fileattr;
 	u64 right_mode;
 	u64 right_uid;
 	u64 right_gid;
+	u64 right_fileattr;
 	int need_chmod = 0;
 	int need_chown = 0;
+	bool need_fileattr = false;
 	int need_truncate = 1;
 	int pending_move = 0;
 	int refs_processed = 0;
@@ -6273,7 +6315,7 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 		goto out;
 
 	ret = get_inode_info(sctx->send_root, sctx->cur_ino, NULL, NULL,
-			&left_mode, &left_uid, &left_gid, NULL);
+			&left_mode, &left_uid, &left_gid, NULL, &left_fileattr);
 	if (ret < 0)
 		goto out;
 
@@ -6288,7 +6330,7 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 
 		ret = get_inode_info(sctx->parent_root, sctx->cur_ino,
 				&old_size, NULL, &right_mode, &right_uid,
-				&right_gid, NULL);
+				&right_gid, NULL, &right_fileattr);
 		if (ret < 0)
 			goto out;
 
@@ -6296,6 +6338,8 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 			need_chown = 1;
 		if (!S_ISLNK(sctx->cur_inode_mode) && left_mode != right_mode)
 			need_chmod = 1;
+		if (!S_ISLNK(sctx->cur_inode_mode) && left_fileattr != right_fileattr)
+			need_fileattr = true;
 		if ((old_size == sctx->cur_inode_size) ||
 		    (sctx->cur_inode_size > old_size &&
 		     sctx->cur_inode_next_write_offset == sctx->cur_inode_size))
@@ -6339,6 +6383,12 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 		if (ret < 0)
 			goto out;
 	}
+	if (need_fileattr) {
+		ret = send_fileattr(sctx, sctx->cur_ino, sctx->cur_inode_gen,
+				    left_fileattr);
+		if (ret < 0)
+			goto out;
+	}
 
 	ret = send_capabilities(sctx);
 	if (ret < 0)
@@ -6750,12 +6800,12 @@ static int dir_changed(struct send_ctx *sctx, u64 dir)
 	int ret;
 
 	ret = get_inode_info(sctx->send_root, dir, NULL, &new_gen, NULL, NULL,
-			     NULL, NULL);
+			     NULL, NULL, NULL);
 	if (ret)
 		return ret;
 
 	ret = get_inode_info(sctx->parent_root, dir, NULL, &orig_gen, NULL,
-			     NULL, NULL, NULL);
+			     NULL, NULL, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index b0dc07567d09..f954ce6f17d8 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -85,7 +85,7 @@ enum btrfs_send_cmd {
 
 	/* Version 2 */
 	BTRFS_SEND_C_FALLOCATE		= 23,
-	BTRFS_SEND_C_SETFLAGS		= 24,
+	BTRFS_SEND_C_FILEATTR		= 24,
 	BTRFS_SEND_C_ENCODED_WRITE	= 25,
 	BTRFS_SEND_C_MAX_V2		= 25,
 
@@ -138,7 +138,13 @@ enum {
 	/* Version 2 */
 	BTRFS_SEND_A_FALLOCATE_MODE	= 25,
 
-	BTRFS_SEND_A_SETFLAGS_FLAGS	= 26,
+	/*
+	 * File attributes from the FS_*_FL namespace (i_flags, xflags),
+	 * translated to BTRFS_INODE_* bits (BTRFS_INODE_FLAG_MASK) and stored
+	 * in btrfs_inode_item::flags (represented by btrfs_inode::flags and
+	 * btrfs_inode::ro_flags).
+	 */
+	BTRFS_SEND_A_FILEATTR		= 26,
 
 	BTRFS_SEND_A_UNENCODED_FILE_LEN	= 27,
 	BTRFS_SEND_A_UNENCODED_LEN	= 28,
-- 
2.36.1

