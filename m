Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA49776E46
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 05:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjHJDBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 23:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHJDBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 23:01:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448171704
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 20:01:09 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLs960yWVz1L9Nf;
        Thu, 10 Aug 2023 10:59:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 11:01:05 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] btrfs: Use LIST_HEAD() to initialize the list_head
Date:   Thu, 10 Aug 2023 11:00:22 +0800
Message-ID: <20230810030022.780950-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use LIST_HEAD() to initialize the list_head instead of open-coding it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v2:
- Add the remainig LIST_HEAD() conversions.
- Update the commit message.
---
 fs/btrfs/disk-io.c      | 12 +++---------
 fs/btrfs/file.c         |  3 +--
 fs/btrfs/inode.c        | 17 +++++------------
 fs/btrfs/ordered-data.c |  4 +---
 fs/btrfs/send.c         |  6 ++----
 fs/btrfs/tree-log.c     |  4 +---
 6 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index da51e5750443..89c18ad3f364 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4541,9 +4541,7 @@ static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
 static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct list_head splice;
-
-	INIT_LIST_HEAD(&splice);
+	LIST_HEAD(splice);
 
 	spin_lock(&fs_info->ordered_root_lock);
 	list_splice_init(&fs_info->ordered_roots, &splice);
@@ -4649,9 +4647,7 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 {
 	struct btrfs_inode *btrfs_inode;
-	struct list_head splice;
-
-	INIT_LIST_HEAD(&splice);
+	LIST_HEAD(splice);
 
 	spin_lock(&root->delalloc_lock);
 	list_splice_init(&root->delalloc_inodes, &splice);
@@ -4684,9 +4680,7 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 static void btrfs_destroy_all_delalloc_inodes(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct list_head splice;
-
-	INIT_LIST_HEAD(&splice);
+	LIST_HEAD(splice);
 
 	spin_lock(&fs_info->delalloc_root_lock);
 	list_splice_init(&fs_info->delalloc_roots, &splice);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3887a8e1c964..ca46a529d56b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2999,7 +2999,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	struct extent_changeset *data_reserved = NULL;
 	struct falloc_range *range;
 	struct falloc_range *tmp;
-	struct list_head reserve_list;
+	LIST_HEAD(reserve_list);
 	u64 cur_offset;
 	u64 last_byte;
 	u64 alloc_start;
@@ -3091,7 +3091,6 @@ static long btrfs_fallocate(struct file *file, int mode,
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), alloc_start, locked_end);
 
 	/* First, check if we exceed the qgroup limit */
-	INIT_LIST_HEAD(&reserve_list);
 	while (cur_offset < alloc_end) {
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
 				      alloc_end - cur_offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d4089e131a32..a1a6f9697ee2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5724,8 +5724,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	struct btrfs_key found_key;
 	struct btrfs_path *path;
 	void *addr;
-	struct list_head ins_list;
-	struct list_head del_list;
+	LIST_HEAD(ins_list);
+	LIST_HEAD(del_list);
 	int ret;
 	char *name_ptr;
 	int name_len;
@@ -5744,8 +5744,6 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	addr = private->filldir_buf;
 	path->reada = READA_FORWARD;
 
-	INIT_LIST_HEAD(&ins_list);
-	INIT_LIST_HEAD(&del_list);
 	put = btrfs_readdir_get_delayed_items(inode, &ins_list, &del_list);
 
 again:
@@ -9141,14 +9139,11 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 	struct btrfs_inode *binode;
 	struct inode *inode;
 	struct btrfs_delalloc_work *work, *next;
-	struct list_head works;
-	struct list_head splice;
+	LIST_HEAD(works);
+	LIST_HEAD(splice);
 	int ret = 0;
 	bool full_flush = wbc->nr_to_write == LONG_MAX;
 
-	INIT_LIST_HEAD(&works);
-	INIT_LIST_HEAD(&splice);
-
 	mutex_lock(&root->delalloc_mutex);
 	spin_lock(&root->delalloc_lock);
 	list_splice_init(&root->delalloc_inodes, &splice);
@@ -9236,14 +9231,12 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 		.range_end = LLONG_MAX,
 	};
 	struct btrfs_root *root;
-	struct list_head splice;
+	LIST_HEAD(splice);
 	int ret;
 
 	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
-	INIT_LIST_HEAD(&splice);
-
 	mutex_lock(&fs_info->delalloc_root_mutex);
 	spin_lock(&fs_info->delalloc_root_lock);
 	list_splice_init(&fs_info->delalloc_roots, &splice);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index caa5dbf48db5..09b274d9ba18 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -760,11 +760,9 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 			     const u64 range_start, const u64 range_len)
 {
 	struct btrfs_root *root;
-	struct list_head splice;
+	LIST_HEAD(splice);
 	u64 done;
 
-	INIT_LIST_HEAD(&splice);
-
 	mutex_lock(&fs_info->ordered_operations_mutex);
 	spin_lock(&fs_info->ordered_root_lock);
 	list_splice_init(&fs_info->ordered_roots, &splice);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8bfd44750efe..3a566150c531 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3685,7 +3685,7 @@ static void tail_append_pending_moves(struct send_ctx *sctx,
 static int apply_children_dir_moves(struct send_ctx *sctx)
 {
 	struct pending_dir_move *pm;
-	struct list_head stack;
+	LIST_HEAD(stack);
 	u64 parent_ino = sctx->cur_ino;
 	int ret = 0;
 
@@ -3693,7 +3693,6 @@ static int apply_children_dir_moves(struct send_ctx *sctx)
 	if (!pm)
 		return 0;
 
-	INIT_LIST_HEAD(&stack);
 	tail_append_pending_moves(sctx, pm, &stack);
 
 	while (!list_empty(&stack)) {
@@ -4165,7 +4164,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	int ret = 0;
 	struct recorded_ref *cur;
 	struct recorded_ref *cur2;
-	struct list_head check_dirs;
+	LIST_HEAD(check_dirs);
 	struct fs_path *valid_path = NULL;
 	u64 ow_inode = 0;
 	u64 ow_gen;
@@ -4184,7 +4183,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	 * which is always '..'
 	 */
 	BUG_ON(sctx->cur_ino <= BTRFS_FIRST_FREE_OBJECTID);
-	INIT_LIST_HEAD(&check_dirs);
 
 	valid_path = fs_path_alloc();
 	if (!valid_path) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3778014a0060..d1e46b839519 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4841,13 +4841,11 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_ordered_extent *tmp;
 	struct extent_map *em, *n;
-	struct list_head extents;
+	LIST_HEAD(extents);
 	struct extent_map_tree *tree = &inode->extent_tree;
 	int ret = 0;
 	int num = 0;
 
-	INIT_LIST_HEAD(&extents);
-
 	write_lock(&tree->lock);
 
 	list_for_each_entry_safe(em, n, &tree->modified_extents, list) {
-- 
2.34.1

