Return-Path: <linux-btrfs+bounces-14040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD1AB8A39
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23691BC6CB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929ED214A8B;
	Thu, 15 May 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a7LFOl8t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a7LFOl8t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAD13E41A
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321415; cv=none; b=MMNrkYizXZv2+WEQqXj3qkkcFrdNF13DhqmjTpD5jz76HjlRYnxPzd4MODlJ/qQZvmDI7iybqN0wfZ2TwEZ63cn/Nw9RaGcQwjX8In7lPdur8ypOV/YpzR1xv/iXCaq8vQxHjLJlNvLZAjhvgDiUNBUOZ+fwJ+NfMTJk8VuQy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321415; c=relaxed/simple;
	bh=ctMhpt1TH8KnFb8jlxnDIFnYxgAZFysWqeSjRVsq9rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwAJn1LHXH6r7kJzKi3ybV9xbSsq6ancAznNptvatSNkTY9acp9ZI8IPdLI0yUH1FsBzp/nMD18KnU+0t1JABlqbgddxoxLV90J/StRskEJVPjzKYP9CUfl1Pwn4Z1qjIdhQSf83C4DBpi4KEb6TSzu5OtI21PY8rNpYxQMarQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a7LFOl8t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a7LFOl8t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 950E22123F;
	Thu, 15 May 2025 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747321411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t4PVS4QmzY1fSFU9o7r7n3DZ7Auc+BBtPQ+fUMk7CiM=;
	b=a7LFOl8t7mRQbC9EYQ6WQIAcYerMXaoMcxOEMqoddcZv6f8wtJNgeS0CsLzawJYUfuP+uZ
	ojg8izYXd4WF21mxoSdTsJTrc6m2LIaJfSS4OUpStypk/d8iC5lqB871hgvCPUz1vAsCF/
	2Zn7szD66lXpqw0zFcO/wI5QEYBCYG4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747321411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t4PVS4QmzY1fSFU9o7r7n3DZ7Auc+BBtPQ+fUMk7CiM=;
	b=a7LFOl8t7mRQbC9EYQ6WQIAcYerMXaoMcxOEMqoddcZv6f8wtJNgeS0CsLzawJYUfuP+uZ
	ojg8izYXd4WF21mxoSdTsJTrc6m2LIaJfSS4OUpStypk/d8iC5lqB871hgvCPUz1vAsCF/
	2Zn7szD66lXpqw0zFcO/wI5QEYBCYG4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87E4B139D0;
	Thu, 15 May 2025 15:03:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l2khIUMCJmg8PgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 15 May 2025 15:03:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: constify even more pointer parameters
Date: Thu, 15 May 2025 17:03:24 +0200
Message-ID: <20250515150324.2213624-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]

Another batch of pointer parameter constifications. This is for clarity
and minor addition to type safety. There are no observable effects in the
assembly code and .ko measured on release config.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c         | 14 +++++------
 fs/btrfs/ctree.c       | 20 ++++++++--------
 fs/btrfs/ctree.h       |  8 +++----
 fs/btrfs/delayed-ref.h |  6 ++---
 fs/btrfs/extent-tree.c | 54 +++++++++++++++++++++---------------------
 fs/btrfs/extent-tree.h |  2 +-
 fs/btrfs/ref-verify.c  |  2 +-
 fs/btrfs/ref-verify.h  |  4 ++--
 fs/btrfs/volumes.h     |  2 +-
 9 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f7d8958b732792..e7d436c6aec2b3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -27,12 +27,12 @@ struct btrfs_failed_bio {
 };
 
 /* Is this a data path I/O that needs storage layer checksum and repair? */
-static inline bool is_data_bbio(struct btrfs_bio *bbio)
+static inline bool is_data_bbio(const struct btrfs_bio *bbio)
 {
 	return bbio->inode && is_data_inode(bbio->inode);
 }
 
-static bool bbio_has_ordered_extent(struct btrfs_bio *bbio)
+static bool bbio_has_ordered_extent(const struct btrfs_bio *bbio)
 {
 	return is_data_bbio(bbio) && btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE;
 }
@@ -134,14 +134,14 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	}
 }
 
-static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
+static int next_repair_mirror(const struct btrfs_failed_bio *fbio, int cur_mirror)
 {
 	if (cur_mirror == fbio->num_copies)
 		return cur_mirror + 1 - fbio->num_copies;
 	return cur_mirror + 1;
 }
 
-static int prev_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
+static int prev_repair_mirror(const struct btrfs_failed_bio *fbio, int cur_mirror)
 {
 	if (cur_mirror == 1)
 		return fbio->num_copies;
@@ -301,7 +301,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 }
 
-static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
+static void btrfs_log_dev_io_error(const struct bio *bio, struct btrfs_device *dev)
 {
 	if (!dev || !dev->bdev)
 		return;
@@ -316,8 +316,8 @@ static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
 }
 
-static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_info,
-						struct bio *bio)
+static struct workqueue_struct *btrfs_end_io_wq(const struct btrfs_fs_info *fs_info,
+						const struct bio *bio)
 {
 	if (bio->bi_opf & REQ_META)
 		return fs_info->endio_meta_workers;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2e7979372ccd8..85213444dc41b4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -303,9 +303,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 /*
  * check if the tree block can be shared by multiple trees
  */
-bool btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct extent_buffer *buf)
+bool btrfs_block_can_be_shared(const struct btrfs_trans_handle *trans,
+			       const struct btrfs_root *root,
+			       const struct extent_buffer *buf)
 {
 	const u64 buf_gen = btrfs_header_generation(buf);
 
@@ -602,9 +602,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static inline int should_cow_block(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *root,
-				   struct extent_buffer *buf)
+static inline int should_cow_block(const struct btrfs_trans_handle *trans,
+				   const struct btrfs_root *root,
+				   const struct extent_buffer *buf)
 {
 	if (btrfs_is_testing(root->fs_info))
 		return 0;
@@ -724,7 +724,7 @@ int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_ke
  * Slot may point to the total number of items (i.e. one position beyond the last
  * key) if the key is bigger than the last key in the extent buffer.
  */
-int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 		     const struct btrfs_key *key, int *slot)
 {
 	unsigned long p;
@@ -1268,7 +1268,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
  * to the block in 'slot', and triggering ra on them.
  */
 static void reada_for_search(struct btrfs_fs_info *fs_info,
-			     struct btrfs_path *path,
+			     const struct btrfs_path *path,
 			     int level, int slot, u64 objectid)
 {
 	struct extent_buffer *node;
@@ -1350,7 +1350,7 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static noinline void reada_for_balance(struct btrfs_path *path, int level)
+static noinline void reada_for_balance(const struct btrfs_path *path, int level)
 {
 	struct extent_buffer *parent;
 	int slot;
@@ -1794,7 +1794,7 @@ static int finish_need_commit_sem_search(struct btrfs_path *path)
 	return 0;
 }
 
-static inline int search_for_key_slot(struct extent_buffer *eb,
+static inline int search_for_key_slot(const struct extent_buffer *eb,
 				      int search_low_slot,
 				      const struct btrfs_key *key,
 				      int prev_cmp,
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 075a06db43a1c6..1273f108dcf201 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -508,7 +508,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 int __init btrfs_ctree_init(void);
 void __cold btrfs_ctree_exit(void);
 
-int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 		     const struct btrfs_key *key, int *slot);
 
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
@@ -576,9 +576,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-bool btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct extent_buffer *buf);
+bool btrfs_block_can_be_shared(const struct btrfs_trans_handle *trans,
+			       const struct btrfs_root *root,
+			       const struct extent_buffer *buf);
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
 void btrfs_extend_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 78cc2383761057..552ec4fa645d4b 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -420,7 +420,7 @@ bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
 				 u64 root, u64 parent);
 void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans);
 
-static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
+static inline u64 btrfs_delayed_ref_owner(const struct btrfs_delayed_ref_node *node)
 {
 	if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
 	    node->type == BTRFS_SHARED_DATA_REF_KEY)
@@ -428,7 +428,7 @@ static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
 	return node->tree_ref.level;
 }
 
-static inline u64 btrfs_delayed_ref_offset(struct btrfs_delayed_ref_node *node)
+static inline u64 btrfs_delayed_ref_offset(const struct btrfs_delayed_ref_node *node)
 {
 	if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
 	    node->type == BTRFS_SHARED_DATA_REF_KEY)
@@ -436,7 +436,7 @@ static inline u64 btrfs_delayed_ref_offset(struct btrfs_delayed_ref_node *node)
 	return 0;
 }
 
-static inline u8 btrfs_ref_type(struct btrfs_ref *ref)
+static inline u8 btrfs_ref_type(const struct btrfs_ref *ref)
 {
 	ASSERT(ref->type == BTRFS_REF_DATA || ref->type == BTRFS_REF_METADATA);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cb6128778a8360..a547994df43392 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -46,7 +46,7 @@
 
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_head *href,
-			       struct btrfs_delayed_ref_node *node,
+			       const struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extra_op);
 static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 				    struct extent_buffer *leaf,
@@ -56,12 +56,12 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 flags, u64 owner, u64 offset,
 				      struct btrfs_key *ins, int ref_mod, u64 oref_root);
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
-				     struct btrfs_delayed_ref_node *node,
+				     const struct btrfs_delayed_ref_node *node,
 				     struct btrfs_delayed_extent_op *extent_op);
-static int find_next_key(struct btrfs_path *path, int level,
+static int find_next_key(const struct btrfs_path *path, int level,
 			 struct btrfs_key *key);
 
-static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
+static int block_group_bits(const struct btrfs_block_group *cache, u64 bits)
 {
 	return (cache->flags & bits) == bits;
 }
@@ -329,7 +329,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
  * is_data == BTRFS_REF_TYPE_ANY, either type is OK.
  */
 int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
-				     struct btrfs_extent_inline_ref *iref,
+				     const struct btrfs_extent_inline_ref *iref,
 				     enum btrfs_inline_ref_type is_data)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -401,16 +401,16 @@ u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
 	return ((u64)high_crc << 31) ^ (u64)low_crc;
 }
 
-static u64 hash_extent_data_ref_item(struct extent_buffer *leaf,
-				     struct btrfs_extent_data_ref *ref)
+static u64 hash_extent_data_ref_item(const struct extent_buffer *leaf,
+				     const struct btrfs_extent_data_ref *ref)
 {
 	return hash_extent_data_ref(btrfs_extent_data_ref_root(leaf, ref),
 				    btrfs_extent_data_ref_objectid(leaf, ref),
 				    btrfs_extent_data_ref_offset(leaf, ref));
 }
 
-static bool match_extent_data_ref(struct extent_buffer *leaf,
-				  struct btrfs_extent_data_ref *ref,
+static bool match_extent_data_ref(const struct extent_buffer *leaf,
+				  const struct btrfs_extent_data_ref *ref,
 				  u64 root_objectid, u64 owner, u64 offset)
 {
 	if (btrfs_extent_data_ref_root(leaf, ref) != root_objectid ||
@@ -497,7 +497,7 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 
 static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 					   struct btrfs_path *path,
-					   struct btrfs_delayed_ref_node *node,
+					   const struct btrfs_delayed_ref_node *node,
 					   u64 bytenr)
 {
 	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
@@ -617,13 +617,13 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline u32 extent_data_ref_count(struct btrfs_path *path,
-					  struct btrfs_extent_inline_ref *iref)
+static noinline u32 extent_data_ref_count(const struct btrfs_path *path,
+					  const struct btrfs_extent_inline_ref *iref)
 {
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_extent_data_ref *ref1;
-	struct btrfs_shared_data_ref *ref2;
+	const struct btrfs_extent_data_ref *ref1;
+	const struct btrfs_shared_data_ref *ref2;
 	u32 num_refs = 0;
 	int type;
 
@@ -638,10 +638,10 @@ static noinline u32 extent_data_ref_count(struct btrfs_path *path,
 		type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 		ASSERT(type != BTRFS_REF_TYPE_INVALID);
 		if (type == BTRFS_EXTENT_DATA_REF_KEY) {
-			ref1 = (struct btrfs_extent_data_ref *)(&iref->offset);
+			ref1 = (const struct btrfs_extent_data_ref *)(&iref->offset);
 			num_refs = btrfs_extent_data_ref_count(leaf, ref1);
 		} else {
-			ref2 = (struct btrfs_shared_data_ref *)(iref + 1);
+			ref2 = (const struct btrfs_shared_data_ref *)(iref + 1);
 			num_refs = btrfs_shared_data_ref_count(leaf, ref2);
 		}
 	} else if (key.type == BTRFS_EXTENT_DATA_REF_KEY) {
@@ -684,7 +684,7 @@ static noinline int lookup_tree_block_ref(struct btrfs_trans_handle *trans,
 
 static noinline int insert_tree_block_ref(struct btrfs_trans_handle *trans,
 					  struct btrfs_path *path,
-					  struct btrfs_delayed_ref_node *node,
+					  const struct btrfs_delayed_ref_node *node,
 					  u64 bytenr)
 {
 	struct btrfs_root *root = btrfs_extent_root(trans->fs_info, bytenr);
@@ -722,7 +722,7 @@ static inline int extent_ref_type(u64 parent, u64 owner)
 	return type;
 }
 
-static int find_next_key(struct btrfs_path *path, int level,
+static int find_next_key(const struct btrfs_path *path, int level,
 			 struct btrfs_key *key)
 
 {
@@ -1480,7 +1480,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
  *
  */
 static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
-				  struct btrfs_delayed_ref_node *node,
+				  const struct btrfs_delayed_ref_node *node,
 				  struct btrfs_delayed_extent_op *extent_op)
 {
 	BTRFS_PATH_AUTO_FREE(path);
@@ -1534,7 +1534,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 }
 
 static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
-				     struct btrfs_delayed_ref_head *href)
+				     const struct btrfs_delayed_ref_head *href)
 {
 	u64 root = href->owning_root;
 
@@ -1552,7 +1552,7 @@ static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
 
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_head *href,
-				struct btrfs_delayed_ref_node *node,
+				const struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				bool insert_reserved)
 {
@@ -1620,7 +1620,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 }
 
 static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
-				 struct btrfs_delayed_ref_head *head,
+				 const struct btrfs_delayed_ref_head *head,
 				 struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1707,7 +1707,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 
 static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_head *href,
-				struct btrfs_delayed_ref_node *node,
+				const struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
 				bool insert_reserved)
 {
@@ -1754,7 +1754,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 /* helper function to actually process a single delayed ref entry */
 static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_head *href,
-			       struct btrfs_delayed_ref_node *node,
+			       const struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
 {
@@ -3079,7 +3079,7 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
  */
 static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_head *href,
-			       struct btrfs_delayed_ref_node *node,
+			       const struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
@@ -4873,7 +4873,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 }
 
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
-				     struct btrfs_delayed_ref_node *node,
+				     const struct btrfs_delayed_ref_node *node,
 				     struct btrfs_delayed_extent_op *extent_op)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -4983,7 +4983,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
-	struct btrfs_squota_delta delta = {
+	const struct btrfs_squota_delta delta = {
 		.root = root_objectid,
 		.num_bytes = ins->offset,
 		.generation = trans->transid,
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 72914074c30462..82d3a82dc712a4 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -97,7 +97,7 @@ enum btrfs_inline_ref_type {
 };
 
 int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
-				     struct btrfs_extent_inline_ref *iref,
+				     const struct btrfs_extent_inline_ref *iref,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 2928abf7eb8271..2032bc3b5bceb2 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -668,7 +668,7 @@ static void dump_block_entry(struct btrfs_fs_info *fs_info,
  * our sanity checks pass as they are no longer needed.
  */
 int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
-		       struct btrfs_ref *generic_ref)
+		       const struct btrfs_ref *generic_ref)
 {
 	struct ref_entry *ref = NULL, *exist;
 	struct ref_action *ra = NULL;
diff --git a/fs/btrfs/ref-verify.h b/fs/btrfs/ref-verify.h
index 3511e1a5c96ba9..559bd25a2b7ab1 100644
--- a/fs/btrfs/ref-verify.h
+++ b/fs/btrfs/ref-verify.h
@@ -19,7 +19,7 @@ struct btrfs_ref;
 int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info);
 void btrfs_free_ref_cache(struct btrfs_fs_info *fs_info);
 int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
-		       struct btrfs_ref *generic_ref);
+		       const struct btrfs_ref *generic_ref);
 void btrfs_free_ref_tree_range(struct btrfs_fs_info *fs_info, u64 start,
 			       u64 len);
 
@@ -39,7 +39,7 @@ static inline void btrfs_free_ref_cache(struct btrfs_fs_info *fs_info)
 }
 
 static inline int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
-		       struct btrfs_ref *generic_ref)
+				     const struct btrfs_ref *generic_ref)
 {
 	return 0;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 137cc232f58e4a..6d8b1f38e3ee87 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -667,7 +667,7 @@ enum btrfs_map_op {
 	BTRFS_MAP_GET_READ_MIRRORS,
 };
 
-static inline enum btrfs_map_op btrfs_op(struct bio *bio)
+static inline enum btrfs_map_op btrfs_op(const struct bio *bio)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_WRITE:
-- 
2.49.0


