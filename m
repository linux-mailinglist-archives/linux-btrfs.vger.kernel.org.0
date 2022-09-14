Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53AD5B8102
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 07:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiINFdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 01:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiINFdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 01:33:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96BB6BD7C
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 22:33:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 838BD5CBE5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663133590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jt1lOq9p2/wyg8Hp86edR6W+V1Yr46K5OqsoyyZOTDY=;
        b=Io+eIMiQ8CP9JjTfWTD+eG8zIreg1L4Pr4WXIsxmgdwmlrH1i3KFDQF4AV+772E8cqobKD
        oHXS8xoCrxh+DkFyYKbQZuJNwdQTEQ1mxUH1fdSU911rhktapOJDW19ebNeNS4MXlF5eoo
        bBmuODVcAkGj3vS1OcpJUb9qc3ZSs2Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D576913486
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2FvgJ5VnIWO6RQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: concentrate all tree block parentness check parameters into one structure
Date:   Wed, 14 Sep 2022 13:32:50 +0800
Message-Id: <5776cd5a337d786e57d9e6dbea3e371cc74c14e3.1663133223.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663133223.git.wqu@suse.com>
References: <cover.1663133223.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several different tree block parentness check parameters used
across several helpers:

- level
  Mandatory

- transid
  Under most cases it's mandatory, but there are several backref cases
  which skips this check.

- owner_root
- first_key
  Utilized by most top-down tree search routine. Otherwise can be
  skipped.

Those four members are not always mandatory checks, and some of them are
the same u64, which means if some arguments got swapped compiler will
not catch it.

Furthermore if we're going to further expand the parentness check, we
need to modify quite some helpers just to add one more parameter.

This patch will concentrate all these members into a structure called
btrfs_tree_parent_check, and pass that structure for the following
helpers:

- btrfs_read_extent_buffer()
- read_tree_block()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c      | 15 ++++++++---
 fs/btrfs/ctree.c        | 28 +++++++++++--------
 fs/btrfs/disk-io.c      | 59 ++++++++++++++++++++++++-----------------
 fs/btrfs/disk-io.h      | 36 ++++++++++++++++++++++---
 fs/btrfs/extent-tree.c  | 12 ++++++---
 fs/btrfs/print-tree.c   | 13 +++++----
 fs/btrfs/qgroup.c       | 18 ++++++++++---
 fs/btrfs/relocation.c   | 11 +++++---
 fs/btrfs/tree-log.c     | 25 ++++++++++++-----
 fs/btrfs/tree-mod-log.c |  9 +++++--
 10 files changed, 158 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9d06f8c18b15..abaed23edc7c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -777,6 +777,8 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 	struct rb_node *node;
 
 	while ((node = rb_first_cached(&tree->root))) {
+		struct btrfs_tree_parent_check check = {0};
+
 		ref = rb_entry(node, struct prelim_ref, rbnode);
 		rb_erase_cached(node, &tree->root);
 
@@ -784,8 +786,10 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 		BUG_ON(ref->key_for_search.type);
 		BUG_ON(!ref->wanted_disk_byte);
 
-		eb = read_tree_block(fs_info, ref->wanted_disk_byte,
-				     ref->root_id, 0, ref->level - 1, NULL);
+		check.level = ref->level - 1;
+		check.owner_root = ref->root_id;
+
+		eb = read_tree_block(fs_info, ref->wanted_disk_byte, &check);
 		if (IS_ERR(eb)) {
 			free_pref(ref);
 			return PTR_ERR(eb);
@@ -1330,10 +1334,13 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		if (ref->count && ref->parent) {
 			if (extent_item_pos && !ref->inode_list &&
 			    ref->level == 0) {
+				struct btrfs_tree_parent_check check = {0};
 				struct extent_buffer *eb;
 
-				eb = read_tree_block(fs_info, ref->parent, 0,
-						     0, ref->level, NULL);
+				check.level = ref->level;
+
+				eb = read_tree_block(fs_info, ref->parent,
+						     &check);
 				if (IS_ERR(eb)) {
 					ret = PTR_ERR(eb);
 					goto out;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ebfa35fe1c38..44dd9ed3fe63 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -834,19 +834,22 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 					   int slot)
 {
 	int level = btrfs_header_level(parent);
+	struct btrfs_tree_parent_check check = {0};
 	struct extent_buffer *eb;
-	struct btrfs_key first_key;
 
 	if (slot < 0 || slot >= btrfs_header_nritems(parent))
 		return ERR_PTR(-ENOENT);
 
 	BUG_ON(level == 0);
 
-	btrfs_node_key_to_cpu(parent, &first_key, slot);
+	check.level = level - 1;
+	check.transid = btrfs_node_ptr_generation(parent, slot);
+	check.owner_root = btrfs_header_owner(parent);
+	check.has_first_key = true;
+	btrfs_node_key_to_cpu(parent, &check.first_key, slot);
+
 	eb = read_tree_block(parent->fs_info, btrfs_node_blockptr(parent, slot),
-			     btrfs_header_owner(parent),
-			     btrfs_node_ptr_generation(parent, slot),
-			     level - 1, &first_key);
+			     &check);
 	if (IS_ERR(eb))
 		return eb;
 	if (!extent_buffer_uptodate(eb)) {
@@ -1405,10 +1408,10 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		      const struct btrfs_key *key)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_tree_parent_check check = {0};
 	u64 blocknr;
 	u64 gen;
 	struct extent_buffer *tmp;
-	struct btrfs_key first_key;
 	int ret;
 	int parent_level;
 	bool unlock_up;
@@ -1417,7 +1420,11 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
 	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
-	btrfs_node_key_to_cpu(*eb_ret, &first_key, slot);
+	btrfs_node_key_to_cpu(*eb_ret, &check.first_key, slot);
+	check.has_first_key = true;
+	check.level = parent_level - 1;
+	check.transid = gen;
+	check.owner_root = root->root_key.objectid;
 
 	/*
 	 * If we need to read an extent buffer from disk and we are holding locks
@@ -1439,7 +1446,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			 * parents (shared tree blocks).
 			 */
 			if (btrfs_verify_level_key(tmp,
-					parent_level - 1, &first_key, gen)) {
+					parent_level - 1, &check.first_key, gen)) {
 				free_extent_buffer(tmp);
 				return -EUCLEAN;
 			}
@@ -1451,7 +1458,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			btrfs_unlock_up_safe(p, level + 1);
 
 		/* now we're allowed to do a blocking uptodate check */
-		ret = btrfs_read_extent_buffer(tmp, gen, parent_level - 1, &first_key);
+		ret = btrfs_read_extent_buffer(tmp, &check);
 		if (ret) {
 			free_extent_buffer(tmp);
 			btrfs_release_path(p);
@@ -1479,8 +1486,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
 
-	tmp = read_tree_block(fs_info, blocknr, root->root_key.objectid,
-			      gen, parent_level - 1, &first_key);
+	tmp = read_tree_block(fs_info, blocknr, &check);
 	if (IS_ERR(tmp)) {
 		btrfs_release_path(p);
 		return PTR_ERR(tmp);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 54b5784a59e5..80aa0ba4ac55 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -253,13 +253,11 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
  * helper to read a given tree block, doing retries as required when
  * the checksums don't match and we have alternate mirrors to try.
  *
- * @parent_transid:	expected transid, skip check if 0
- * @level:		expected level, mandatory check
- * @first_key:		expected key of first slot, skip check if NULL
+ * @check:		expected tree parentness check, see the comments of the
+ *			structure for details.
  */
 int btrfs_read_extent_buffer(struct extent_buffer *eb,
-			     u64 parent_transid, int level,
-			     struct btrfs_key *first_key)
+			     struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
@@ -269,16 +267,20 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 	int mirror_num = 0;
 	int failed_mirror = 0;
 
+	ASSERT(check);
+
 	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 	while (1) {
 		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret = read_extent_buffer_pages(eb, WAIT_COMPLETE, mirror_num);
 		if (!ret) {
 			if (verify_parent_transid(io_tree, eb,
-						   parent_transid, 0))
+						  check->transid, 0))
 				ret = -EIO;
-			else if (btrfs_verify_level_key(eb, level,
-						first_key, parent_transid))
+			else if (btrfs_verify_level_key(eb, check->level,
+						check->has_first_key ?
+						&check->first_key : NULL,
+						check->transid))
 				ret = -EUCLEAN;
 			else
 				break;
@@ -922,28 +924,28 @@ struct extent_buffer *btrfs_find_create_tree_block(
  * Read tree block at logical address @bytenr and do variant basic but critical
  * verification.
  *
- * @owner_root:		the objectid of the root owner for this block.
- * @parent_transid:	expected transid of this tree block, skip check if 0
- * @level:		expected level, mandatory check
- * @first_key:		expected key in slot 0, skip check if NULL
+ * @check:		expected tree parentness check, see comments of the
+ *			structure for details.
  */
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 owner_root, u64 parent_transid,
-				      int level, struct btrfs_key *first_key)
+				      struct btrfs_tree_parent_check *check)
 {
 	struct extent_buffer *buf = NULL;
 	int ret;
 
-	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
+	ASSERT(check);
+
+	buf = btrfs_find_create_tree_block(fs_info, bytenr, check->owner_root,
+					   check->level);
 	if (IS_ERR(buf))
 		return buf;
 
-	ret = btrfs_read_extent_buffer(buf, parent_transid, level, first_key);
+	ret = btrfs_read_extent_buffer(buf, check);
 	if (ret) {
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(ret);
 	}
-	if (btrfs_check_eb_owner(buf, owner_root)) {
+	if (btrfs_check_eb_owner(buf, check->owner_root)) {
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(-EUCLEAN);
 	}
@@ -1355,6 +1357,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 					      struct btrfs_key *key)
 {
 	struct btrfs_root *root;
+	struct btrfs_tree_parent_check check = {0};
 	struct btrfs_fs_info *fs_info = tree_root->fs_info;
 	u64 generation;
 	int ret;
@@ -1374,9 +1377,12 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 
 	generation = btrfs_root_generation(&root->root_item);
 	level = btrfs_root_level(&root->root_item);
+	check.level = level;
+	check.transid = generation;
+	check.owner_root = key->objectid;
 	root->node = read_tree_block(fs_info,
 				     btrfs_root_bytenr(&root->root_item),
-				     key->objectid, generation, level, NULL);
+				     &check);
 	if (IS_ERR(root->node)) {
 		ret = PTR_ERR(root->node);
 		root->node = NULL;
@@ -2351,6 +2357,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 			    struct btrfs_fs_devices *fs_devices)
 {
 	int ret;
+	struct btrfs_tree_parent_check check = {0};
 	struct btrfs_root *log_tree_root;
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
 	u64 bytenr = btrfs_super_log_root(disk_super);
@@ -2366,10 +2373,10 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 	if (!log_tree_root)
 		return -ENOMEM;
 
-	log_tree_root->node = read_tree_block(fs_info, bytenr,
-					      BTRFS_TREE_LOG_OBJECTID,
-					      fs_info->generation + 1, level,
-					      NULL);
+	check.level = level;
+	check.transid = fs_info->generation + 1;
+	check.owner_root = BTRFS_TREE_LOG_OBJECTID;
+	log_tree_root->node = read_tree_block(fs_info, bytenr, &check);
 	if (IS_ERR(log_tree_root->node)) {
 		btrfs_warn(fs_info, "failed to read log tree");
 		ret = PTR_ERR(log_tree_root->node);
@@ -2845,10 +2852,14 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 
 static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen, int level)
 {
+	struct btrfs_tree_parent_check check = {0};
 	int ret = 0;
 
-	root->node = read_tree_block(root->fs_info, bytenr,
-				     root->root_key.objectid, gen, level, NULL);
+	check.level = level;
+	check.transid = gen;
+	check.owner_root = root->root_key.objectid;
+
+	root->node = read_tree_block(root->fs_info, bytenr, &check);
 	if (IS_ERR(root->node)) {
 		ret = PTR_ERR(root->node);
 		root->node = NULL;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7e545ec09a10..e415d44a6948 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -25,6 +25,35 @@ static inline u64 btrfs_sb_offset(int mirror)
 	return BTRFS_SUPER_INFO_OFFSET;
 }
 
+/* All the extra info needed to verify the parentness of a tree block. */
+struct btrfs_tree_parent_check {
+	/*
+	 * The owner check against the tree block.
+	 *
+	 * Can be 0 to skip the owner check.
+	 */
+	u64 owner_root;
+
+	/*
+	 * Expected transid, can be 0 to skip the check, but such skip
+	 * should only be utlized for backref walk related code.
+	 */
+	u64 transid;
+
+	/*
+	 * The expected first key.
+	 *
+	 * This check can be skipped if @has_first_key is false, such skip
+	 * can happen for case where we don't have the parent node key,
+	 * e.g. reading the tree root, doing backref walk.
+	 */
+	struct btrfs_key first_key;
+	bool has_first_key;
+
+	/* The expected level. Should always be set. */
+	u8 level;
+};
+
 struct btrfs_device;
 struct btrfs_fs_devices;
 
@@ -33,8 +62,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 			   struct btrfs_key *first_key, u64 parent_transid);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 owner_root, u64 parent_transid,
-				      int level, struct btrfs_key *first_key);
+				      struct btrfs_tree_parent_check *check);
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
@@ -114,8 +142,8 @@ void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
-int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
-			     int level, struct btrfs_key *first_key);
+int btrfs_read_extent_buffer(struct extent_buffer *buf,
+			     struct btrfs_tree_parent_check *check);
 bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset,
 			 extent_submit_bio_start_t *submit_bio_start);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9818285dface..fe2157e1bdf4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5245,8 +5245,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 bytenr;
 	u64 generation;
 	u64 parent;
+	struct btrfs_tree_parent_check check = {0};
 	struct btrfs_key key;
-	struct btrfs_key first_key;
 	struct btrfs_ref ref = { 0 };
 	struct extent_buffer *next;
 	int level = wc->level;
@@ -5268,7 +5268,12 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 
 	bytenr = btrfs_node_blockptr(path->nodes[level], path->slots[level]);
-	btrfs_node_key_to_cpu(path->nodes[level], &first_key,
+
+	check.level = level - 1;
+	check.transid = generation;
+	check.owner_root = root->root_key.objectid;
+	check.has_first_key = true;
+	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
 			      path->slots[level]);
 
 	next = find_extent_buffer(fs_info, bytenr);
@@ -5330,8 +5335,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	if (!next) {
 		if (reada && level == 1)
 			reada_walk_down(trans, root, wc, path);
-		next = read_tree_block(fs_info, bytenr, root->root_key.objectid,
-				       generation, level - 1, &first_key);
+		next = read_tree_block(fs_info, bytenr, &check);
 		if (IS_ERR(next)) {
 			return PTR_ERR(next);
 		} else if (!extent_buffer_uptodate(next)) {
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..9a2d1ec5d3fe 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -384,14 +384,17 @@ void btrfs_print_tree(struct extent_buffer *c, bool follow)
 	if (!follow)
 		return;
 	for (i = 0; i < nr; i++) {
-		struct btrfs_key first_key;
+		struct btrfs_tree_parent_check check = {0};
 		struct extent_buffer *next;
 
-		btrfs_node_key_to_cpu(c, &first_key, i);
+		check.level = level - 1;
+		check.transid = btrfs_node_ptr_generation(c, i);
+		check.owner_root = btrfs_header_owner(c);
+		check.has_first_key = true;
+		btrfs_node_key_to_cpu(c, &check.first_key, i);
+
 		next = read_tree_block(fs_info, btrfs_node_blockptr(c, i),
-				       btrfs_header_owner(c),
-				       btrfs_node_ptr_generation(c, i),
-				       level - 1, &first_key);
+				       &check);
 		if (IS_ERR(next))
 			continue;
 		if (!extent_buffer_uptodate(next)) {
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ba323dcb0a0b..ef74706ed670 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2305,7 +2305,13 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 		return 0;
 
 	if (!extent_buffer_uptodate(root_eb)) {
-		ret = btrfs_read_extent_buffer(root_eb, root_gen, root_level, NULL);
+		struct btrfs_tree_parent_check check = {0};
+
+		check.has_first_key = false;
+		check.transid = root_gen;
+		check.level = root_level;
+
+		ret = btrfs_read_extent_buffer(root_eb, &check);
 		if (ret)
 			goto out;
 	}
@@ -4262,6 +4268,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 					 struct extent_buffer *subvol_eb)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_tree_parent_check check = {0};
 	struct btrfs_qgroup_swapped_blocks *blocks = &root->swapped_blocks;
 	struct btrfs_qgroup_swapped_block *block;
 	struct extent_buffer *reloc_eb = NULL;
@@ -4310,10 +4317,13 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	blocks->swapped = swapped;
 	spin_unlock(&blocks->lock);
 
+	check.level = block->level;
+	check.transid = block->reloc_generation;
+	check.has_first_key = true;
+	memcpy(&check.first_key, &block->first_key, sizeof(check.first_key));
+
 	/* Read out reloc subtree root */
-	reloc_eb = read_tree_block(fs_info, block->reloc_bytenr, 0,
-				   block->reloc_generation, block->level,
-				   &block->first_key);
+	reloc_eb = read_tree_block(fs_info, block->reloc_bytenr, &check);
 	if (IS_ERR(reloc_eb)) {
 		ret = PTR_ERR(reloc_eb);
 		reloc_eb = NULL;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 45c02aba2492..231284c15224 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2597,10 +2597,14 @@ static int tree_block_processed(u64 bytenr, struct reloc_control *rc)
 static int get_tree_block_key(struct btrfs_fs_info *fs_info,
 			      struct tree_block *block)
 {
+	struct btrfs_tree_parent_check check = {0};
 	struct extent_buffer *eb;
 
-	eb = read_tree_block(fs_info, block->bytenr, block->owner,
-			     block->key.offset, block->level, NULL);
+	check.level = block->level;
+	check.owner_root = block->owner;
+	check.transid = block->key.offset;
+
+	eb = read_tree_block(fs_info, block->bytenr, &check);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
 	if (!extent_buffer_uptodate(eb)) {
@@ -3411,9 +3415,10 @@ int add_data_references(struct reloc_control *rc,
 
 	ULIST_ITER_INIT(&leaf_uiter);
 	while ((ref_node = ulist_next(leaves, &leaf_uiter))) {
+		struct btrfs_tree_parent_check check = {0};
 		struct extent_buffer *eb;
 
-		eb = read_tree_block(fs_info, ref_node->val, 0, 0, 0, NULL);
+		eb = read_tree_block(fs_info, ref_node->val, &check);
 		if (IS_ERR(eb)) {
 			ret = PTR_ERR(eb);
 			break;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 020e01ea44bc..9749397273c2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -333,7 +333,12 @@ static int process_one_buffer(struct btrfs_root *log,
 	 * pin down any logged extents, so we have to read the block.
 	 */
 	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
-		ret = btrfs_read_extent_buffer(eb, gen, level, NULL);
+		struct btrfs_tree_parent_check check = {0};
+
+		check.level = level;
+		check.transid = gen;
+
+		ret = btrfs_read_extent_buffer(eb, &check);
 		if (ret)
 			return ret;
 	}
@@ -2430,13 +2435,17 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			     struct walk_control *wc, u64 gen, int level)
 {
 	int nritems;
+	struct btrfs_tree_parent_check check = {0};
 	struct btrfs_path *path;
 	struct btrfs_root *root = wc->replay_dest;
 	struct btrfs_key key;
 	int i;
 	int ret;
 
-	ret = btrfs_read_extent_buffer(eb, gen, level, NULL);
+	check.transid = gen;
+	check.level = level;
+
+	ret = btrfs_read_extent_buffer(eb, &check);
 	if (ret)
 		return ret;
 
@@ -2616,7 +2625,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	while (*level > 0) {
-		struct btrfs_key first_key;
+		struct btrfs_tree_parent_check check = {0};
 
 		cur = path->nodes[*level];
 
@@ -2628,7 +2637,10 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 		bytenr = btrfs_node_blockptr(cur, path->slots[*level]);
 		ptr_gen = btrfs_node_ptr_generation(cur, path->slots[*level]);
-		btrfs_node_key_to_cpu(cur, &first_key, path->slots[*level]);
+		check.transid = ptr_gen;
+		check.level = *level - 1;
+		check.has_first_key = true;
+		btrfs_node_key_to_cpu(cur, &check.first_key, path->slots[*level]);
 		blocksize = fs_info->nodesize;
 
 		next = btrfs_find_create_tree_block(fs_info, bytenr,
@@ -2647,8 +2659,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 			path->slots[*level]++;
 			if (wc->free) {
-				ret = btrfs_read_extent_buffer(next, ptr_gen,
-							*level - 1, &first_key);
+				ret = btrfs_read_extent_buffer(next, &check);
 				if (ret) {
 					free_extent_buffer(next);
 					return ret;
@@ -2676,7 +2687,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 			free_extent_buffer(next);
 			continue;
 		}
-		ret = btrfs_read_extent_buffer(next, ptr_gen, *level - 1, &first_key);
+		ret = btrfs_read_extent_buffer(next, &check);
 		if (ret) {
 			free_extent_buffer(next);
 			return ret;
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 8a3a14686d3e..a2ee149b9cf2 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -819,10 +819,15 @@ struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq)
 
 	tm = tree_mod_log_search(fs_info, logical, time_seq);
 	if (old_root && tm && tm->op != BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
+		struct btrfs_tree_parent_check check = {0};
+
 		btrfs_tree_read_unlock(eb_root);
 		free_extent_buffer(eb_root);
-		old = read_tree_block(fs_info, logical, root->root_key.objectid,
-				      0, level, NULL);
+
+		check.level = level;
+		check.owner_root = root->root_key.objectid;
+
+		old = read_tree_block(fs_info, logical, &check);
 		if (WARN_ON(IS_ERR(old) || !extent_buffer_uptodate(old))) {
 			if (!IS_ERR(old))
 				free_extent_buffer(old);
-- 
2.37.3

