Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639F4570F99
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiGLBhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 21:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiGLBhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 21:37:13 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800A25E30A;
        Mon, 11 Jul 2022 18:37:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 522DF1E6BB65D;
        Tue, 12 Jul 2022 09:37:09 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1657589829; bh=EmGwHmmw0Y5RLIK/O0zjD2WPEwZTA7sEw27N3F4zAEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jEmKYW0rR57bli3uUECj2kAor675PXmwM3O928h3xvQXkJA6k/5pJIO5VVpFSYnPH
         JGdBac9clauSOeC7K2D5XCSmeihQDN3x97+o5ZXFK1vZNzkzDp0RgEQbvSLGxtAskn
         9btQertS3zENtRP608876Nfzd+lpENmNN9nG3wMQ=
From:   bingjingc <bingjingc@synology.com>
To:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     fdmanana@kernel.org, bingjingc@synology.com, robbieko@synology.com,
        bxxxjxxg@gmail.com
Subject: [PATCH v2 2/2] btrfs: send: fix sending link commands for existing file paths
Date:   Tue, 12 Jul 2022 09:36:32 +0800
Message-Id: <20220712013632.7042-3-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712013632.7042-1-bingjingc@synology.com>
References: <20220712013632.7042-1-bingjingc@synology.com>
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

There is a bug sending link commands for existing file paths. When we're
processing an inode, we go over all references. All the new file paths are
added to the "new_refs" list. And all the deleted file paths are added to
the "deleted_refs" list. In the end, when we finish processing the inode,
we iterate over all the items in the "new_refs" list and send link commands
for those file paths. After that, we go over all the items in the
"deleted_refs" list and send unlink commands for them. If there are
duplicated file paths in both lists, we will try to create them before we
remove them. Then the receiver gets an -EEXIST error when trying the link
operations.

Example for having duplicated file paths in both list:

  $ btrfs subvolume create vol

  # create a file and 2000 hard links to the same inode
  $ touch vol/foo
  $ for i in {1..2000}; do link vol/foo vol/$i ; done

  # take a snapshot for a parent snapshot
  $ btrfs subvolume snapshot -r vol snap1

  # remove 2000 hard links and re-create the last 1000 links
  $ for i in {1..2000}; do rm vol/$i; done;
  $ for i in {1001..2000}; do link vol/foo vol/$i; done

  # take another one for a send snapshot
  $ btrfs subvolume snapshot -r vol snap2

  $ mkdir receive_dir
  $ btrfs send snap2 -p snap1 | btrfs receive receive_dir/
  At subvol snap2
  link 1238 -> foo
  ERROR: link 1238 -> foo failed: File exists

In this case, we will have the same file paths added to both lists. In the
parent snapshot, reference paths {1..1237} are stored in inode references,
but reference paths {1238..2000} are stored in inode extended references.
In the send snapshot, all reference paths {1001..2000} are stored in inode
references. During the incremental send, we process their inode references
first. In record_changed_ref(), we iterate all its inode references in the
send/parent snapshot. For every inode reference, we also use find_iref() to
check whether the same file path also appears in the parent/send snapshot
or not. Inode references {1238..2000} which appear in the send snapshot but
not in the parent snapshot are added to the "new_refs" list. On the other
hand, Inode references {1..1000} which appear in the parent snapshot but
not in the send snapshot are added to the "deleted_refs" list. Next, when
we process their inode extended references, reference paths {1238..2000}
are added to the "deleted_refs" list because all of them only appear in the
parent snapshot. Now two lists contain items as below:
"new_refs" list: {1238..2000}
"deleted_refs" list: {1..1000}, {1238..2000}

Reference paths {1238..2000} appear in both lists. And as the processing
order talked about before, the receiver gets an -EEXIST error when trying
the link operations.

To fix the bug, the intuition is to process the "deleted_refs" list before
the "new_refs" list. However, it's not easy to reshuffle the processing
order. For one reason, if we do so, we may unlink all the existing paths
first, there's no valid path anymore for links. And it's inefficient
because we do a bunch of unlinks followed by links for the same paths.
Moreover, it makes less sense to have duplications in both lists. A
reference path cannot not only be regarded as new but also has been seen in
the past, or we won't call it a new path. However, it's also not a good
idea to make find_iref() to check a reference against all inode references
and all inode extended references because it may result in large disk
reads. So we introduce two rbtrees to make the references easier for
lookups. And we also introduce __record_new_ref_if_needed() and
__record_deleted_ref_if_needed() for changed_ref() to check and remove
duplicated references early.

Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/send.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 420a86720aa2..bff9313bd236 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -234,6 +234,9 @@ struct send_ctx {
 	 * Indexed by the inode number of the directory to be deleted.
 	 */
 	struct rb_root orphan_dirs;
+
+	struct rb_root rbtree_new_refs;
+	struct rb_root rbtree_deleted_refs;
 };
 
 struct pending_dir_move {
@@ -2747,6 +2750,8 @@ struct recorded_ref {
 	u64 dir;
 	u64 dir_gen;
 	int name_len;
+	struct rb_node node;
+	struct rb_root *root;
 };
 
 static struct recorded_ref *recorded_ref_alloc(void)
@@ -2756,6 +2761,7 @@ static struct recorded_ref *recorded_ref_alloc(void)
 	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
 	if (!ref)
 		return NULL;
+	RB_CLEAR_NODE(&ref->node);
 	INIT_LIST_HEAD(&ref->list);
 	return ref;
 }
@@ -2764,6 +2770,8 @@ static void recorded_ref_free(struct recorded_ref *ref)
 {
 	if (!ref)
 		return;
+	if (!RB_EMPTY_NODE(&ref->node))
+		rb_erase(&ref->node, ref->root);
 	list_del(&ref->list);
 	fs_path_free(ref->full_path);
 	kfree(ref);
@@ -4373,12 +4381,153 @@ static int __record_deleted_ref(int num, u64 dir, int index,
 			  &sctx->deleted_refs);
 }
 
+static int rbtree_ref_comp(const void *k, const struct rb_node *node)
+{
+	const struct recorded_ref *data = k;
+	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
+	int result;
+
+	if (data->dir > ref->dir)
+		return 1;
+	if (data->dir < ref->dir)
+		return -1;
+	if (data->dir_gen > ref->dir_gen)
+		return 1;
+	if (data->dir_gen < ref->dir_gen)
+		return -1;
+	if (data->name_len > ref->name_len)
+		return 1;
+	if (data->name_len < ref->name_len)
+		return -1;
+	result = strcmp(data->name, ref->name);
+	if (result > 0)
+		return 1;
+	if (result < 0)
+		return -1;
+	return 0;
+}
+
+static bool rbtree_ref_less(struct rb_node *node, const struct rb_node *parent)
+{
+	const struct recorded_ref *entry = rb_entry(node,
+						    struct recorded_ref,
+						    node);
+
+	return rbtree_ref_comp(entry, parent) < 0;
+}
+
+static int record_ref_in_tree(struct rb_root *root, struct list_head *refs,
+			      struct fs_path *name, u64 dir, u64 dir_gen,
+			      struct send_ctx *sctx)
+{
+	int ret = 0;
+	struct fs_path *path = NULL;
+	struct recorded_ref *ref = NULL;
+
+	path = fs_path_alloc();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ref = recorded_ref_alloc();
+	if (!ref) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = get_cur_path(sctx, dir, dir_gen, path);
+	if (ret < 0)
+		goto out;
+	ret = fs_path_add_path(path, name);
+	if (ret < 0)
+		goto out;
+
+	ref->dir = dir;
+	ref->dir_gen = dir_gen;
+	set_ref_path(ref, path);
+	list_add_tail(&ref->list, refs);
+	rb_add(&ref->node, root, rbtree_ref_less);
+	ref->root = root;
+out:
+	if (ret) {
+		if (path && (!ref || !ref->full_path))
+			fs_path_free(path);
+		recorded_ref_free(ref);
+	}
+	return ret;
+}
+
+static int __record_new_ref_if_needed(int num, u64 dir, int index,
+				      struct fs_path *name, void *ctx)
+{
+	int ret = 0;
+	struct send_ctx *sctx = ctx;
+	struct rb_node *node = NULL;
+	struct recorded_ref data;
+	struct recorded_ref *ref;
+	u64 dir_gen;
+
+	ret = get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL,
+			     NULL, NULL, NULL);
+	if (ret < 0)
+		goto out;
+
+	data.dir = dir;
+	data.dir_gen = dir_gen;
+	set_ref_path(&data, name);
+	node = rb_find(&data, &sctx->rbtree_deleted_refs, rbtree_ref_comp);
+	if (node) {
+		ref = rb_entry(node, struct recorded_ref, node);
+		recorded_ref_free(ref);
+	} else {
+		ret = record_ref_in_tree(&sctx->rbtree_new_refs,
+					 &sctx->new_refs, name, dir, dir_gen,
+					 sctx);
+	}
+out:
+	return ret;
+}
+
+static int __record_deleted_ref_if_needed(int num, u64 dir, int index,
+			    struct fs_path *name,
+			    void *ctx)
+{
+	int ret = 0;
+	struct send_ctx *sctx = ctx;
+	struct rb_node *node = NULL;
+	struct recorded_ref data;
+	struct recorded_ref *ref;
+	u64 dir_gen;
+
+	ret = get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NULL,
+			     NULL, NULL, NULL);
+	if (ret < 0)
+		goto out;
+
+	data.dir = dir;
+	data.dir_gen = dir_gen;
+	set_ref_path(&data, name);
+	node = rb_find(&data, &sctx->rbtree_new_refs, rbtree_ref_comp);
+	if (node) {
+		ref = rb_entry(node, struct recorded_ref, node);
+		recorded_ref_free(ref);
+	} else {
+		ret = record_ref_in_tree(&sctx->rbtree_deleted_refs,
+					 &sctx->deleted_refs, name, dir,
+					 dir_gen, sctx);
+	}
+out:
+	return ret;
+}
+
 static int record_new_ref(struct send_ctx *sctx)
 {
 	int ret;
 
 	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
-				sctx->cmp_key, 0, __record_new_ref, sctx);
+				sctx->cmp_key, 0, __record_new_ref_if_needed,
+				sctx);
 	if (ret < 0)
 		goto out;
 	ret = 0;
@@ -4392,7 +4541,8 @@ static int record_deleted_ref(struct send_ctx *sctx)
 	int ret;
 
 	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
-				sctx->cmp_key, 0, __record_deleted_ref, sctx);
+				sctx->cmp_key, 0,
+				__record_deleted_ref_if_needed, sctx);
 	if (ret < 0)
 		goto out;
 	ret = 0;
@@ -4475,7 +4625,7 @@ static int __record_changed_new_ref(int num, u64 dir, int index,
 	ret = find_iref(sctx->parent_root, sctx->right_path,
 			sctx->cmp_key, dir, dir_gen, name);
 	if (ret == -ENOENT)
-		ret = __record_new_ref(num, dir, index, name, sctx);
+		ret = __record_new_ref_if_needed(num, dir, index, name, sctx);
 	else if (ret > 0)
 		ret = 0;
 
@@ -4498,7 +4648,8 @@ static int __record_changed_deleted_ref(int num, u64 dir, int index,
 	ret = find_iref(sctx->send_root, sctx->left_path, sctx->cmp_key,
 			dir, dir_gen, name);
 	if (ret == -ENOENT)
-		ret = __record_deleted_ref(num, dir, index, name, sctx);
+		ret = __record_deleted_ref_if_needed(num, dir, index, name,
+						     sctx);
 	else if (ret > 0)
 		ret = 0;
 
@@ -7576,6 +7727,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
 	sctx->orphan_dirs = RB_ROOT;
+	sctx->rbtree_new_refs = RB_ROOT;
+	sctx->rbtree_deleted_refs = RB_ROOT;
 
 	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
 				     arg->clone_sources_count + 1,
-- 
2.37.0

