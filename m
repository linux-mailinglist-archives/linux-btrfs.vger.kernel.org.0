Return-Path: <linux-btrfs+bounces-5932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A8915392
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918CC286B95
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297FE19E831;
	Mon, 24 Jun 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qv09d9YM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qv09d9YM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39A19FA80
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246201; cv=none; b=FlQiqpQmmvZP8a6wqP9Nz9wsRAYgJUyNnoP/QNtCku3FfJVkXNzVyYvq30jS+PowxIOFPDsO4sA4H8jxDcanM3/Wr6B8kIjmjFIxl5aKI9XmXUEEPiZZ3TbBxxKkjlKGUO75dCED7DEZ3hVmDOrdc3wwC+Cq4suP69mqv9YX7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246201; c=relaxed/simple;
	bh=cBzStMiJTRyogJL4aOzBcYqjiBYgB3jAgAycLSHH1M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhxiBbsFZ0LiBwAAUXnhDJ7We0IhH4X4I+028hgM1POlyPsrgpr4Y5uxO0MNN+bnX4HVMu9VemEd5QX6dzDjL0+1/kmlzY0dJayogk4dsfVijNRo8MvgvvXR3IbcujBt+CHjUspMj1TWg3Tl2FZQ4sxkccALOtocCMOjuY7H5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qv09d9YM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qv09d9YM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD3061F7DC;
	Mon, 24 Jun 2024 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJLA5gkHAfuyviDEMXGeOZcAsvTCT0eNYMrRdtwm4i4=;
	b=qv09d9YMJUZXVBZiRJB1kcOAgdwbe88CFwuuJOl14ruAgmG/jUMsXyQlN7kfDScc6O4XhM
	XYx5hvFxzc1MKRDT7xHM+wL+9ogefT/t3MO4eZrAdmsHqFxR/NNy4Zk+VCgSbxlkluIjGj
	kyyvGaL7mE3I9y72rJjFJjGyPKwh+Eo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJLA5gkHAfuyviDEMXGeOZcAsvTCT0eNYMrRdtwm4i4=;
	b=qv09d9YMJUZXVBZiRJB1kcOAgdwbe88CFwuuJOl14ruAgmG/jUMsXyQlN7kfDScc6O4XhM
	XYx5hvFxzc1MKRDT7xHM+wL+9ogefT/t3MO4eZrAdmsHqFxR/NNy4Zk+VCgSbxlkluIjGj
	kyyvGaL7mE3I9y72rJjFJjGyPKwh+Eo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCE871384C;
	Mon, 24 Jun 2024 16:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANMcLnWdeWbuLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/11] btrfs: switch btrfs_ordered_extent::inode to struct btrfs_inode
Date: Mon, 24 Jun 2024 18:23:17 +0200
Message-ID: <52a78b5e5bd6ac496f513323d610e55c3d4f6750.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
References: <cover.1719246104.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

The structure is internal so we should use struct btrfs_inode for that,
allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c  |  2 +-
 fs/btrfs/inode.c        |  6 +++---
 fs/btrfs/ordered-data.c | 22 +++++++++++-----------
 fs/btrfs/ordered-data.h |  2 +-
 fs/btrfs/relocation.c   |  2 +-
 fs/btrfs/zoned.c        |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 07b31d1c0926..de136ef3a2f8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -374,7 +374,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 				   blk_opf_t write_flags,
 				   bool writeback)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct compressed_bio *cb;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cd3f1a9415c1..a6c460675a2d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3037,7 +3037,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 			     test_bit(BTRFS_ORDERED_ENCODED, &oe->flags) ||
 			     test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags);
 
-	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
+	return insert_reserved_file_extent(trans, oe->inode,
 					   oe->file_offset, &stack_fi,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
@@ -3049,7 +3049,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
  */
 int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
+	struct btrfs_inode *inode = ordered_extent->inode;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans = NULL;
@@ -3283,7 +3283,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 {
-	if (btrfs_is_zoned(inode_to_fs_info(ordered->inode)) &&
+	if (btrfs_is_zoned(ordered->inode->root->fs_info) &&
 	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags) &&
 	    list_empty(&ordered->bioc_list))
 		btrfs_finish_ordered_zoned(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a3343656e0a7..82a68394a89c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -180,7 +180,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->disk_num_bytes = disk_num_bytes;
 	entry->offset = offset;
 	entry->bytes_left = num_bytes;
-	entry->inode = igrab(&inode->vfs_inode);
+	entry->inode = BTRFS_I(igrab(&inode->vfs_inode));
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = qgroup_rsv;
@@ -208,7 +208,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 
 static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 {
-	struct btrfs_inode *inode = BTRFS_I(entry->inode);
+	struct btrfs_inode *inode = entry->inode;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *node;
@@ -310,7 +310,7 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum)
 {
-	struct btrfs_inode *inode = BTRFS_I(entry->inode);
+	struct btrfs_inode *inode = entry->inode;
 
 	spin_lock_irq(&inode->ordered_tree_lock);
 	list_add_tail(&sum->list, &entry->list);
@@ -320,7 +320,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered)
 {
 	if (!test_and_set_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
-		mapping_set_error(ordered->inode->i_mapping, -EIO);
+		mapping_set_error(ordered->inode->vfs_inode.i_mapping, -EIO);
 }
 
 static void finish_ordered_fn(struct btrfs_work *work)
@@ -335,7 +335,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				      struct page *page, u64 file_offset,
 				      u64 len, bool uptodate)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	lockdep_assert_held(&inode->ordered_tree_lock);
@@ -388,7 +388,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 
 static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_workqueue *wq = btrfs_is_free_space_inode(inode) ?
 		fs_info->endio_freespace_worker : fs_info->endio_write_workers;
@@ -401,7 +401,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 struct page *page, u64 file_offset, u64 len,
 				 bool uptodate)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	unsigned long flags;
 	bool ret;
 
@@ -610,14 +610,14 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 	struct list_head *cur;
 	struct btrfs_ordered_sum *sum;
 
-	trace_btrfs_ordered_extent_put(BTRFS_I(entry->inode), entry);
+	trace_btrfs_ordered_extent_put(entry->inode, entry);
 
 	if (refcount_dec_and_test(&entry->refs)) {
 		ASSERT(list_empty(&entry->root_extent_list));
 		ASSERT(list_empty(&entry->log_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
 		if (entry->inode)
-			btrfs_add_delayed_iput(BTRFS_I(entry->inode));
+			btrfs_add_delayed_iput(entry->inode);
 		while (!list_empty(&entry->list)) {
 			cur = entry->list.next;
 			sum = list_entry(cur, struct btrfs_ordered_sum, list);
@@ -849,7 +849,7 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
 {
 	u64 start = entry->file_offset;
 	u64 end = start + entry->num_bytes - 1;
-	struct btrfs_inode *inode = BTRFS_I(entry->inode);
+	struct btrfs_inode *inode = entry->inode;
 	bool freespace_inode;
 
 	trace_btrfs_ordered_extent_start(inode, entry);
@@ -1208,7 +1208,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 			struct btrfs_ordered_extent *ordered, u64 len)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 file_offset = ordered->file_offset;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4aabdff409fa..51b9e81726e2 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -130,7 +130,7 @@ struct btrfs_ordered_extent {
 	refcount_t refs;
 
 	/* the inode we belong to */
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6ea407255a30..1a28ec054991 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4388,7 +4388,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
  */
 int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 disk_bytenr = ordered->file_offset + inode->reloc_block_group_start;
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, disk_bytenr);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8a99f5187e30..58e724c80a06 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1765,7 +1765,7 @@ void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
 					u64 logical)
 {
-	struct extent_map_tree *em_tree = &BTRFS_I(ordered->inode)->extent_tree;
+	struct extent_map_tree *em_tree = &ordered->inode->extent_tree;
 	struct extent_map *em;
 
 	ordered->disk_bytenr = logical;
@@ -1786,7 +1786,7 @@ static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
 	struct btrfs_ordered_extent *new;
 
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags) &&
-	    split_extent_map(BTRFS_I(ordered->inode), ordered->file_offset,
+	    split_extent_map(ordered->inode, ordered->file_offset,
 			     ordered->num_bytes, len, logical))
 		return false;
 
@@ -1800,7 +1800,7 @@ static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
 
 void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 {
-	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_sum *sum;
 	u64 logical, len;
-- 
2.45.0


