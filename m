Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EC571D67
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiGLOzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 10:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiGLOyx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 10:54:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13675B7D53
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 07:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1CED8CE1BBD
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85898C3411C;
        Tue, 12 Jul 2022 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657637688;
        bh=YVyFM4aomFyWlLNOrkMa602SW+h9y1SbnqxiLDuGUI0=;
        h=From:To:Cc:Subject:Date:From;
        b=emg5UGMtqC9Ul5AsPs+qUSpDaIEqNGjcIw3WqUDFsC3v/GGgOfFTsUmgYtqIzGVhJ
         igyGX7bygTTJQnWDXDc0MxARf6DvpiPEbHY59VUigG8fRUREJeeKqK8ut8hEyqlTCB
         vvT3dg73NVAz+uOFerh7BnhfV/CzyfK+wd8LnmSEgz2d/pKmudL872wBQh1dTLeWa+
         gSgB0WXah64WmUKuwdXICECsqRyaY5J0zoJLVhYBxEi0+iX5D7YaerWDAWaMeNQcGL
         0Ao6Yps7YjBBNZuqPkY9vL0ob/EbRn3GpX+nSzIZV1SkslpgoFQDKfYFs0ObBeYD/l
         stUn7925n26AA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     bingjingc@synology.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: send: always use the rbtree based inode ref management infrastructure
Date:   Tue, 12 Jul 2022 15:54:39 +0100
Message-Id: <7ceaa34df153e9aada0a093407542fa81355c83c.1657637387.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the patch "btrfs: send: fix sending link commands for existing file
paths", we now have two infrastructures to detect and eliminate duplicated
inode references (due to names that got removed and re-added between the
send and parent snapshots):

1) One that works on a single inode ref/extref item;

2) A new one that works acrosss all ref/extref items for an inode, and
   it's also more efficient because even in the single ref/extref item
   case, it does not do a linear search for all the names encoded in the
   ref/extref item, it uses red black trees to speedup up the search.

There's no good reason to keep both infrastructures, we can use the new
one everywhere, and it's always more efficient.

So remove the old infrastructure and change all sites that are using it
to use the new one.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

This applies on top of the patchset at:

https://lore.kernel.org/linux-btrfs/20220712013632.7042-1-bingjingc@synology.com/

 fs/btrfs/send.c | 187 ++++--------------------------------------------
 1 file changed, 12 insertions(+), 175 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 480189257e1a..2e013c9e3ba9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2189,7 +2189,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	/*
 	 * If the inode is not existent yet, add the orphan name and return 1.
 	 * This should only happen for the parent dir that we determine in
-	 * __record_new_ref
+	 * __record_new_ref_if_needed().
 	 */
 	ret = is_inode_existent(sctx, ino, gen);
 	if (ret < 0)
@@ -2790,27 +2790,6 @@ static void set_ref_path(struct recorded_ref *ref, struct fs_path *path)
 	ref->name_len = ref->full_path->end - ref->name;
 }
 
-/*
- * We need to process new refs before deleted refs, but compare_tree gives us
- * everything mixed. So we first record all refs and later process them.
- * This function is a helper to record one ref.
- */
-static int __record_ref(struct list_head *head, u64 dir,
-		      u64 dir_gen, struct fs_path *path)
-{
-	struct recorded_ref *ref;
-
-	ref = recorded_ref_alloc();
-	if (!ref)
-		return -ENOMEM;
-
-	ref->dir = dir;
-	ref->dir_gen = dir_gen;
-	set_ref_path(ref, path);
-	list_add_tail(&ref->list, head);
-	return 0;
-}
-
 static int dup_ref(struct recorded_ref *ref, struct list_head *list)
 {
 	struct recorded_ref *new;
@@ -4337,56 +4316,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	return ret;
 }
 
-static int record_ref(struct btrfs_root *root, u64 dir, struct fs_path *name,
-		      void *ctx, struct list_head *refs)
-{
-	int ret = 0;
-	struct send_ctx *sctx = ctx;
-	struct fs_path *p;
-	u64 gen;
-
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
-	ret = get_inode_info(root, dir, NULL, &gen, NULL, NULL,
-			NULL, NULL);
-	if (ret < 0)
-		goto out;
-
-	ret = get_cur_path(sctx, dir, gen, p);
-	if (ret < 0)
-		goto out;
-	ret = fs_path_add_path(p, name);
-	if (ret < 0)
-		goto out;
-
-	ret = __record_ref(refs, dir, gen, p);
-
-out:
-	if (ret)
-		fs_path_free(p);
-	return ret;
-}
-
-static int __record_new_ref(int num, u64 dir, int index,
-			    struct fs_path *name,
-			    void *ctx)
-{
-	struct send_ctx *sctx = ctx;
-	return record_ref(sctx->send_root, dir, name, ctx, &sctx->new_refs);
-}
-
-
-static int __record_deleted_ref(int num, u64 dir, int index,
-				struct fs_path *name,
-				void *ctx)
-{
-	struct send_ctx *sctx = ctx;
-	return record_ref(sctx->parent_root, dir, name, ctx,
-			  &sctx->deleted_refs);
-}
-
 static int rbtree_ref_comp(const void *k, const struct rb_node *node)
 {
 	const struct recorded_ref *data = k;
@@ -4565,113 +4494,16 @@ struct find_ref_ctx {
 	int found_idx;
 };
 
-static int __find_iref(int num, u64 dir, int index,
-		       struct fs_path *name,
-		       void *ctx_)
-{
-	struct find_ref_ctx *ctx = ctx_;
-	u64 dir_gen;
-	int ret;
-
-	if (dir == ctx->dir && fs_path_len(name) == fs_path_len(ctx->name) &&
-	    strncmp(name->start, ctx->name->start, fs_path_len(name)) == 0) {
-		/*
-		 * To avoid doing extra lookups we'll only do this if everything
-		 * else matches.
-		 */
-		ret = get_inode_info(ctx->root, dir, NULL, &dir_gen, NULL,
-				     NULL, NULL, NULL);
-		if (ret)
-			return ret;
-		if (dir_gen != ctx->dir_gen)
-			return 0;
-		ctx->found_idx = num;
-		return 1;
-	}
-	return 0;
-}
-
-static int find_iref(struct btrfs_root *root,
-		     struct btrfs_path *path,
-		     struct btrfs_key *key,
-		     u64 dir, u64 dir_gen, struct fs_path *name)
-{
-	int ret;
-	struct find_ref_ctx ctx;
-
-	ctx.dir = dir;
-	ctx.name = name;
-	ctx.dir_gen = dir_gen;
-	ctx.found_idx = -1;
-	ctx.root = root;
-
-	ret = iterate_inode_ref(root, path, key, 0, __find_iref, &ctx);
-	if (ret < 0)
-		return ret;
-
-	if (ctx.found_idx == -1)
-		return -ENOENT;
-
-	return ctx.found_idx;
-}
-
-static int __record_changed_new_ref(int num, u64 dir, int index,
-				    struct fs_path *name,
-				    void *ctx)
-{
-	u64 dir_gen;
-	int ret;
-	struct send_ctx *sctx = ctx;
-
-	ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL);
-	if (ret)
-		return ret;
-
-	ret = find_iref(sctx->parent_root, sctx->right_path,
-			sctx->cmp_key, dir, dir_gen, name);
-	if (ret == -ENOENT)
-		ret = __record_new_ref_if_needed(num, dir, index, name, sctx);
-	else if (ret > 0)
-		ret = 0;
-
-	return ret;
-}
-
-static int __record_changed_deleted_ref(int num, u64 dir, int index,
-					struct fs_path *name,
-					void *ctx)
-{
-	u64 dir_gen;
-	int ret;
-	struct send_ctx *sctx = ctx;
-
-	ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
-			     NULL, NULL, NULL);
-	if (ret)
-		return ret;
-
-	ret = find_iref(sctx->send_root, sctx->left_path, sctx->cmp_key,
-			dir, dir_gen, name);
-	if (ret == -ENOENT)
-		ret = __record_deleted_ref_if_needed(num, dir, index, name,
-						     sctx);
-	else if (ret > 0)
-		ret = 0;
-
-	return ret;
-}
-
 static int record_changed_ref(struct send_ctx *sctx)
 {
 	int ret = 0;
 
 	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
-			sctx->cmp_key, 0, __record_changed_new_ref, sctx);
+			sctx->cmp_key, 0, __record_new_ref_if_needed, sctx);
 	if (ret < 0)
 		goto out;
 	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
-			sctx->cmp_key, 0, __record_changed_deleted_ref, sctx);
+			sctx->cmp_key, 0, __record_deleted_ref_if_needed, sctx);
 	if (ret < 0)
 		goto out;
 	ret = 0;
@@ -4702,10 +4534,10 @@ static int process_all_refs(struct send_ctx *sctx,
 
 	if (cmd == BTRFS_COMPARE_TREE_NEW) {
 		root = sctx->send_root;
-		cb = __record_new_ref;
+		cb = __record_new_ref_if_needed;
 	} else if (cmd == BTRFS_COMPARE_TREE_DELETED) {
 		root = sctx->parent_root;
-		cb = __record_deleted_ref;
+		cb = __record_deleted_ref_if_needed;
 	} else {
 		btrfs_err(sctx->send_root->fs_info,
 				"Wrong command %d in process_all_refs", cmd);
@@ -6545,8 +6377,13 @@ static int record_parent_ref(int num, u64 dir, int index, struct fs_path *name,
 {
 	struct parent_paths_ctx *ppctx = ctx;
 
-	return record_ref(ppctx->sctx->parent_root, dir, name, ppctx->sctx,
-			  ppctx->refs);
+	/*
+	 * Pass 0 as the generation for the directory, we don't care about it
+	 * here as we have no new references to add, we just want to delete all
+	 * references for an inode.
+	 */
+	return record_ref_in_tree(&ppctx->sctx->rbtree_deleted_refs, ppctx->refs,
+				  name, dir, 0, ppctx->sctx);
 }
 
 /*
-- 
2.35.1

