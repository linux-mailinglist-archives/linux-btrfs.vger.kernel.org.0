Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF9568924
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiGFNPl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiGFNPj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 09:15:39 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E720633F;
        Wed,  6 Jul 2022 06:15:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id D32C01BA236A1;
        Wed,  6 Jul 2022 21:10:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1657113016; bh=0G7uwJeQuZxjjdbQ7Zu6xg97czVc98t1T2osYbl93Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bLq+M3nieBZ3NvT0ePCfQNm00zqofjfwMTa9hzN3UIy6vlG6Cjr/yjwqAzLrQ+agK
         wJHp8T2GXcAwAnmijKlFxbtknaq0Nwqna79gr1PANsI/5TfmENyp1alcV016fUAV3A
         +FdP7hHqzQnpJu5qESKYkb6DPlSCZEiULZ76aLnk=
From:   bingjingc <bingjingc@synology.com>
To:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH 2/2] btrfs: send: fix a bug that sending a link command on existing file path
Date:   Wed,  6 Jul 2022 21:09:03 +0800
Message-Id: <20220706130903.1661-3-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220706130903.1661-1-bingjingc@synology.com>
References: <20220706130903.1661-1-bingjingc@synology.com>
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

btrfs_ioctl_send processes recorded btrfs_keys in a defined order. (First,
we process a btrfs_key with a samller objectid. If btrfs_keys have the same
objectid, then we compare their types and offsets accordingly.) However,
reference paths for an inode can be stored in either BTRFS_INODE_REF_KEY
btrfs_keys or BTRFS_INODE_EXTREF_KEY btrfs_keys. And due to the limitation
of the helper function - iterate_inode_ref, we can only iterate the entries
of ONE btrfs_inode_ref or btrfs_inode_extref. That is, there must be a bug
in processing the same reference paths, which are stored in different ways.

Here is an exmple that btrfs_ioctl_send will send a link command on an
existing file path:

  $ btrfs subvolume create test

  # create a file and 2000 hard links to the same inode
  $ dd if=/dev/zero of=test/1M bs=1M count=1
  $ for i in {1..2000}; do link test/1M test/$i ; done

  # take a snapshot for parent snapshot
  $ btrfs sub snap -r test snap1

  # remove 2000 hard links and re-create the last 1000 links
  $ for i in {1..2000}; do rm test/$i; done;
  $ for i in {1001..2000}; do link test/1M test/$i; done

  # take another one for sned snapshot
  $ btrfs sub snap -r test snap2

  $ mkdir tmp
  $ btrfs send -e snap2 -p snap1 | btrfs receive tmp/
  At subvol snap2
  link 1238 -> 1M
  ERROR: link 1238 -> 1M failed: File exists

In the parent snapshot snap1, reference paths 1 - 1237 are stored in a
INODE_REF item and the rest ones are stored in other INODE_EXTREF items.
But in the send snapshot snap2, all reference paths can be stored within a
INODE_REF item. During the send process, btrfs_ioctl_send will process the
INODE_REF item first. Then it found that reference paths 1 - 1000 were
gone in the send snapshot, so it recorded them in sctx->deleted_refs for
unlink. And it found that reference paths 1238 - 2000 were new paths in
the send snapshot, so it recorded them in sctx->new_refs for link. Since
we do not load all contents of its INODE_EXTREF items to make comparison,
afterwards, btrfs_ioctl_send may make a mistake sending a link command on
an existing file path.

To fix the bug, we can either remove the duplicated items both in
sctx->new_refs and sctx->deleted_refs before generating link/unlink
commands or prevent them from being added into list. Both of them require
efficient data structures like C++ sets to look up duplicated items. And
we also need to take two scenarios into consideration. One is the most
common case that one inode has only one reference path. The other is the
worst case that there are ten thousands of hard links of an inode.
(BTRFS_LINK_MAX is 65536) So we'd like to introduce rbtree to store the
computing references. (The tree depth of the worst cases is just 16. And
it takes less memory to store few entries than hash sets.) And in order
not to occupy too much moemory, we also introduce
__record_new_ref_if_needed() and __record_deleted_ref_if_needed() for
changed_ref() to check and remove the duplications early.

Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/send.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 420a86720aa2..23ae631ef23b 100644
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
@@ -4373,12 +4381,152 @@ static int __record_deleted_ref(int num, u64 dir, int index,
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
+static int record_ref2(struct rb_root *root, struct list_head *refs,
+			     struct fs_path *name, u64 dir, u64 dir_gen,
+			     struct send_ctx *sctx)
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
+		ret = record_ref2(&sctx->rbtree_new_refs, &sctx->new_refs,
+				  name, dir, dir_gen, sctx);
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
+		ret = record_ref2(&sctx->rbtree_deleted_refs,
+				  &sctx->deleted_refs, name, dir, dir_gen,
+				  sctx);
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
@@ -4392,7 +4540,8 @@ static int record_deleted_ref(struct send_ctx *sctx)
 	int ret;
 
 	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
-				sctx->cmp_key, 0, __record_deleted_ref, sctx);
+				sctx->cmp_key, 0,
+				__record_deleted_ref_if_needed, sctx);
 	if (ret < 0)
 		goto out;
 	ret = 0;
@@ -4475,7 +4624,7 @@ static int __record_changed_new_ref(int num, u64 dir, int index,
 	ret = find_iref(sctx->parent_root, sctx->right_path,
 			sctx->cmp_key, dir, dir_gen, name);
 	if (ret == -ENOENT)
-		ret = __record_new_ref(num, dir, index, name, sctx);
+		ret = __record_new_ref_if_needed(num, dir, index, name, sctx);
 	else if (ret > 0)
 		ret = 0;
 
@@ -4498,7 +4647,8 @@ static int __record_changed_deleted_ref(int num, u64 dir, int index,
 	ret = find_iref(sctx->send_root, sctx->left_path, sctx->cmp_key,
 			dir, dir_gen, name);
 	if (ret == -ENOENT)
-		ret = __record_deleted_ref(num, dir, index, name, sctx);
+		ret = __record_deleted_ref_if_needed(num, dir, index, name,
+						     sctx);
 	else if (ret > 0)
 		ret = 0;
 
@@ -7576,6 +7726,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
 	sctx->orphan_dirs = RB_ROOT;
+	sctx->rbtree_new_refs = RB_ROOT;
+	sctx->rbtree_deleted_refs = RB_ROOT;
 
 	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
 				     arg->clone_sources_count + 1,
-- 
2.37.0

