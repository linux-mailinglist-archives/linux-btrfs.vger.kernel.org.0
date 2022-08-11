Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1658FA76
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiHKKJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 06:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiHKKJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 06:09:30 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816B90C75;
        Thu, 11 Aug 2022 03:09:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id BCCA22C868498;
        Thu, 11 Aug 2022 18:09:26 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1660212566; bh=NlLH4gcwbWn1WqzYcqKyY79CAKssO+sDk1ZOyNCFY/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EgMkUAWr55BIvT5MKEi79DoRpVA7fGKdZmsVj2/gRJod0APwXzfLgs0AQrjiwTwKB
         NZYUFwvPga4waZrnrhH5j/AUK7KkMjFV5N22N/3D7Z02Ccdnnp7gquPgroQ+GCzbK6
         FMNPoeWIwDJm/ykTg1amVYZ3eGdPXpKd/Kz62jms=
From:   bingjingc <bingjingc@synology.com>
To:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH v2 1/2] btrfs: send: refactor get_inode_info()
Date:   Thu, 11 Aug 2022 18:09:11 +0800
Message-Id: <20220811100912.126447-2-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811100912.126447-1-bingjingc@synology.com>
References: <20220811100912.126447-1-bingjingc@synology.com>
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

Refactor get_inode_info() to populate all wanted fields on an output
structure. Besides, also introduce a helper function called
get_inode_gen(), which is majorly used.

Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/send.c | 154 +++++++++++++++++++++++++-----------------------
 1 file changed, 79 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e7671afcee4f..f8d77a33b9b7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -842,17 +842,31 @@ static int send_rmdir(struct send_ctx *sctx, struct fs_path *path)
 	return ret;
 }
 
+struct btrfs_inode_info {
+	u64 size;
+	u64 gen;
+	u64 mode;
+	u64 uid;
+	u64 gid;
+	u64 rdev;
+	u64 attr;
+};
+
 /*
  * Helper function to retrieve some fields from an inode item.
  */
-static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
-			  u64 ino, u64 *size, u64 *gen, u64 *mode, u64 *uid,
-			  u64 *gid, u64 *rdev, u64 *fileattr)
+static int get_inode_info(struct btrfs_root *root, u64 ino,
+			  struct btrfs_inode_info *info)
 {
 	int ret;
+	struct btrfs_path *path;
 	struct btrfs_inode_item *ii;
 	struct btrfs_key key;
 
+	path = alloc_path_for_send();
+	if (!path)
+		return -ENOMEM;
+
 	key.objectid = ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
@@ -860,47 +874,42 @@ static int __get_inode_info(struct btrfs_root *root, struct btrfs_path *path,
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		return ret;
+		goto out;
 	}
 
+	if (!info)
+		goto out;
+
 	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			struct btrfs_inode_item);
-	if (size)
-		*size = btrfs_inode_size(path->nodes[0], ii);
-	if (gen)
-		*gen = btrfs_inode_generation(path->nodes[0], ii);
-	if (mode)
-		*mode = btrfs_inode_mode(path->nodes[0], ii);
-	if (uid)
-		*uid = btrfs_inode_uid(path->nodes[0], ii);
-	if (gid)
-		*gid = btrfs_inode_gid(path->nodes[0], ii);
-	if (rdev)
-		*rdev = btrfs_inode_rdev(path->nodes[0], ii);
+	info->size = btrfs_inode_size(path->nodes[0], ii);
+	info->gen = btrfs_inode_generation(path->nodes[0], ii);
+	info->mode = btrfs_inode_mode(path->nodes[0], ii);
+	info->uid = btrfs_inode_uid(path->nodes[0], ii);
+	info->gid = btrfs_inode_gid(path->nodes[0], ii);
+	info->rdev = btrfs_inode_rdev(path->nodes[0], ii);
 	/*
 	 * Transfer the unchanged u64 value of btrfs_inode_item::flags, that's
 	 * otherwise logically split to 32/32 parts.
 	 */
-	if (fileattr)
-		*fileattr = btrfs_inode_flags(path->nodes[0], ii);
+	info->attr = btrfs_inode_flags(path->nodes[0], ii);
 
+out:
+	btrfs_free_path(path);
 	return ret;
 }
 
-static int get_inode_info(struct btrfs_root *root,
-			  u64 ino, u64 *size, u64 *gen,
-			  u64 *mode, u64 *uid, u64 *gid,
-			  u64 *rdev, u64 *fileattr)
+static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
 {
-	struct btrfs_path *path;
 	int ret;
+	struct btrfs_inode_info info;
 
-	path = alloc_path_for_send();
-	if (!path)
-		return -ENOMEM;
-	ret = __get_inode_info(root, path, ino, size, gen, mode, uid, gid,
-			       rdev, fileattr);
-	btrfs_free_path(path);
+	if (!gen)
+		return -EPERM;
+
+	ret = get_inode_info(root, ino, &info);
+	if (!ret)
+		*gen = info.gen;
 	return ret;
 }
 
@@ -1644,8 +1653,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 	u64 left_gen;
 	u64 right_gen;
 
-	ret = get_inode_info(sctx->send_root, ino, NULL, &left_gen, NULL, NULL,
-			NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->send_root, ino, &left_gen);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
 	left_ret = ret;
@@ -1653,8 +1661,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
 	if (!sctx->parent_root) {
 		right_ret = -ENOENT;
 	} else {
-		ret = get_inode_info(sctx->parent_root, ino, NULL, &right_gen,
-				NULL, NULL, NULL, NULL, NULL);
+		ret = get_inode_gen(sctx->parent_root, ino, &right_gen);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 		right_ret = ret;
@@ -1816,8 +1823,7 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 	btrfs_release_path(path);
 
 	if (dir_gen) {
-		ret = get_inode_info(root, parent_dir, NULL, dir_gen, NULL,
-				     NULL, NULL, NULL, NULL);
+		ret = get_inode_gen(root, parent_dir, dir_gen);
 		if (ret < 0)
 			goto out;
 	}
@@ -1874,6 +1880,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	int ret = 0;
 	u64 gen;
 	u64 other_inode = 0;
+	struct btrfs_inode_info info;
 
 	if (!sctx->parent_root)
 		goto out;
@@ -1888,8 +1895,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	 * and we can just unlink this entry.
 	 */
 	if (sctx->parent_root && dir != BTRFS_FIRST_FREE_OBJECTID) {
-		ret = get_inode_info(sctx->parent_root, dir, NULL, &gen, NULL,
-				     NULL, NULL, NULL, NULL);
+		ret = get_inode_gen(sctx->parent_root, dir, &gen);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 		if (ret) {
@@ -1916,13 +1922,14 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	 */
 	if (other_inode > sctx->send_progress ||
 	    is_waiting_for_move(sctx, other_inode)) {
-		ret = get_inode_info(sctx->parent_root, other_inode, NULL,
-				who_gen, who_mode, NULL, NULL, NULL, NULL);
+		ret = get_inode_info(sctx->parent_root, other_inode, &info);
 		if (ret < 0)
 			goto out;
 
 		ret = 1;
 		*who_ino = other_inode;
+		*who_gen = info.gen;
+		*who_mode = info.mode;
 	} else {
 		ret = 0;
 	}
@@ -1955,8 +1962,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 		goto out;
 
 	if (dir != BTRFS_FIRST_FREE_OBJECTID) {
-		ret = get_inode_info(sctx->send_root, dir, NULL, &gen, NULL,
-				     NULL, NULL, NULL, NULL);
+		ret = get_inode_gen(sctx->send_root, dir, &gen);
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 		if (ret) {
@@ -1978,8 +1984,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 		goto out;
 	}
 
-	ret = get_inode_info(sctx->send_root, ow_inode, NULL, &gen, NULL, NULL,
-			NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->send_root, ow_inode, &gen);
 	if (ret < 0)
 		goto out;
 
@@ -2645,6 +2650,7 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 	int ret = 0;
 	struct fs_path *p;
 	int cmd;
+	struct btrfs_inode_info info;
 	u64 gen;
 	u64 mode;
 	u64 rdev;
@@ -2656,10 +2662,12 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 		return -ENOMEM;
 
 	if (ino != sctx->cur_ino) {
-		ret = get_inode_info(sctx->send_root, ino, NULL, &gen, &mode,
-				     NULL, NULL, &rdev, NULL);
+		ret = get_inode_info(sctx->send_root, ino, &info);
 		if (ret < 0)
 			goto out;
+		gen = info.gen;
+		mode = info.mode;
+		rdev = info.rdev;
 	} else {
 		gen = sctx->cur_inode_gen;
 		mode = sctx->cur_inode_mode;
@@ -3359,8 +3367,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 		/*
 		 * The parent inode might have been deleted in the send snapshot
 		 */
-		ret = get_inode_info(sctx->send_root, cur->dir, NULL,
-				     NULL, NULL, NULL, NULL, NULL, NULL);
+		ret = get_inode_info(sctx->send_root, cur->dir, NULL);
 		if (ret == -ENOENT) {
 			ret = 0;
 			continue;
@@ -3534,12 +3541,10 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 		goto out;
 	}
 
-	ret = get_inode_info(sctx->parent_root, di_key.objectid, NULL,
-			     &left_gen, NULL, NULL, NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->parent_root, di_key.objectid, &left_gen);
 	if (ret < 0)
 		goto out;
-	ret = get_inode_info(sctx->send_root, di_key.objectid, NULL,
-			     &right_gen, NULL, NULL, NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->send_root, di_key.objectid, &right_gen);
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			ret = 0;
@@ -3669,8 +3674,7 @@ static int is_ancestor(struct btrfs_root *root,
 				cur_offset = item_size;
 			}
 
-			ret = get_inode_info(root, parent, NULL, &parent_gen,
-					     NULL, NULL, NULL, NULL, NULL);
+			ret = get_inode_gen(root, parent, &parent_gen);
 			if (ret < 0)
 				goto out;
 			ret = check_ino_in_path(root, ino1, ino1_gen,
@@ -3760,9 +3764,8 @@ static int wait_for_parent_move(struct send_ctx *sctx,
 		     memcmp(path_before->start, path_after->start, len1))) {
 			u64 parent_ino_gen;
 
-			ret = get_inode_info(sctx->parent_root, ino, NULL,
-					     &parent_ino_gen, NULL, NULL, NULL,
-					     NULL, NULL);
+			ret = get_inode_gen(sctx->parent_root, ino,
+					    &parent_ino_gen);
 			if (ret < 0)
 				goto out;
 			if (ino_gen == parent_ino_gen) {
@@ -4441,8 +4444,7 @@ static int record_new_ref_if_needed(int num, u64 dir, int index,
 	struct recorded_ref *ref;
 	u64 dir_gen;
 
-	ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->send_root, dir, &dir_gen);
 	if (ret < 0)
 		goto out;
 
@@ -4472,8 +4474,7 @@ static int record_deleted_ref_if_needed(int num, u64 dir, int index,
 	struct recorded_ref *ref;
 	u64 dir_gen;
 
-	ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->parent_root, dir, &dir_gen);
 	if (ret < 0)
 		goto out;
 
@@ -5056,8 +5057,7 @@ static int send_clone(struct send_ctx *sctx,
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 
 	if (clone_root->root == sctx->send_root) {
-		ret = get_inode_info(sctx->send_root, clone_root->ino, NULL,
-				&gen, NULL, NULL, NULL, NULL, NULL);
+		ret = get_inode_gen(sctx->send_root, clone_root->ino, &gen);
 		if (ret < 0)
 			goto out;
 		ret = get_cur_path(sctx, clone_root->ino, gen, p);
@@ -5536,6 +5536,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	int ret;
+	struct btrfs_inode_info info;
 	u64 clone_src_i_size = 0;
 
 	/*
@@ -5565,12 +5566,11 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	 * There are inodes that have extents that lie behind its i_size. Don't
 	 * accept clones from these extents.
 	 */
-	ret = __get_inode_info(clone_root->root, path, clone_root->ino,
-			       &clone_src_i_size, NULL, NULL, NULL, NULL, NULL,
-			       NULL);
+	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
 	btrfs_release_path(path);
 	if (ret < 0)
 		goto out;
+	clone_src_i_size = info.size;
 
 	/*
 	 * We can't send a clone operation for the entire range if we find
@@ -6259,6 +6259,7 @@ static int process_recorded_refs_if_needed(struct send_ctx *sctx, int at_end,
 static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 {
 	int ret = 0;
+	struct btrfs_inode_info info;
 	u64 left_mode;
 	u64 left_uid;
 	u64 left_gid;
@@ -6301,11 +6302,13 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 		goto out;
 	if (!at_end && sctx->cmp_key->objectid == sctx->cur_ino)
 		goto out;
-
-	ret = get_inode_info(sctx->send_root, sctx->cur_ino, NULL, NULL,
-			&left_mode, &left_uid, &left_gid, NULL, &left_fileattr);
+	ret = get_inode_info(sctx->send_root, sctx->cur_ino, &info);
 	if (ret < 0)
 		goto out;
+	left_mode = info.mode;
+	left_uid = info.uid;
+	left_gid = info.gid;
+	left_fileattr = info.attr;
 
 	if (!sctx->parent_root || sctx->cur_inode_new) {
 		need_chown = 1;
@@ -6316,11 +6319,14 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 	} else {
 		u64 old_size;
 
-		ret = get_inode_info(sctx->parent_root, sctx->cur_ino,
-				&old_size, NULL, &right_mode, &right_uid,
-				&right_gid, NULL, &right_fileattr);
+		ret = get_inode_info(sctx->parent_root, sctx->cur_ino, &info);
 		if (ret < 0)
 			goto out;
+		old_size = info.size;
+		right_mode = info.mode;
+		right_uid = info.uid;
+		right_gid = info.gid;
+		right_fileattr = info.attr;
 
 		if (left_uid != right_uid || left_gid != right_gid)
 			need_chown = 1;
@@ -6790,13 +6796,11 @@ static int dir_changed(struct send_ctx *sctx, u64 dir)
 	u64 orig_gen, new_gen;
 	int ret;
 
-	ret = get_inode_info(sctx->send_root, dir, NULL, &new_gen, NULL, NULL,
-			     NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->send_root, dir, &new_gen);
 	if (ret)
 		return ret;
 
-	ret = get_inode_info(sctx->parent_root, dir, NULL, &orig_gen, NULL,
-			     NULL, NULL, NULL, NULL);
+	ret = get_inode_gen(sctx->parent_root, dir, &orig_gen);
 	if (ret)
 		return ret;
 
-- 
2.37.1

