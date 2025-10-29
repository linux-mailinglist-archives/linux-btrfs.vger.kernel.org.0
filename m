Return-Path: <linux-btrfs+bounces-18392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60EC18502
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2B3B4013
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27C2F9DA4;
	Wed, 29 Oct 2025 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fsgD+ZY3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fsgD+ZY3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC22FFFB1
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716106; cv=none; b=jUw8nxnO5RQCTrE4xLBaiuq/j0FPLwG6QclfJtKNrMkRwoBKqWc/bA9FDxHjB+ODAjx8I+lGyV6D6ytLWKxLLfhOkMwNIJk6HaB/N7ytMcAnoYToq7ICPE4cajaa49+ZdNSz1KS904AhL+ksLGP3hZ+l81xkAXjAUKCOHYfhf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716106; c=relaxed/simple;
	bh=1JgI9DG811nijY0FPyMobO0WkQsoRW9OQoPv6CTopMc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA4/2TBqavzQ4bLX9Gv5KRDJOeAeNo9BKOlGuIiTQdjr9CKZutQmZTOXd0q4dvhuUh92uuRWo0qPd1JGcyKMZp3LV8pF72kbhMP1g3ZpEcq/OWhIw5M92AxUF4g1oL2UKYaZAlY1YxDAnAmNDY0SPqLBsW+5cgHK6dFGbxKfSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fsgD+ZY3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fsgD+ZY3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CFA31FD94
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdQcQ6Mcz6dGj1ny1hXst4PVcWxV2GpvCHUzhSSQUXE=;
	b=fsgD+ZY3lQIhA8Qx2xa8LWIXFL+LxCBWYO6nA/LA4532IbKuwAg3KItvt9E9fbZVD4r+in
	r1vXwbaE0WJc+nxqwsLhYY4Nt5zt3SRIkiAwc0OwpEnqdU/Pv4TxcbpzDK9BNWxlHvclqE
	TqqxsdjdiKoaI9mNogBSMLV52VbdtP8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fsgD+ZY3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdQcQ6Mcz6dGj1ny1hXst4PVcWxV2GpvCHUzhSSQUXE=;
	b=fsgD+ZY3lQIhA8Qx2xa8LWIXFL+LxCBWYO6nA/LA4532IbKuwAg3KItvt9E9fbZVD4r+in
	r1vXwbaE0WJc+nxqwsLhYY4Nt5zt3SRIkiAwc0OwpEnqdU/Pv4TxcbpzDK9BNWxlHvclqE
	TqqxsdjdiKoaI9mNogBSMLV52VbdtP8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7588B13886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAnJDXOnAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/7] btrfs: relax btrfs_inode::ordered_tree_lock
Date: Wed, 29 Oct 2025 16:04:16 +1030
Message-ID: <8f490f2debf503fd4a936324f03eca264e0e2373.1761715650.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761715649.git.wqu@suse.com>
References: <cover.1761715649.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CFA31FD94
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

We used IRQ version of spinlock for ordered_tree_lock, as
btrfs_finish_ordered_extent() can be called in end_bbio_data_write()
which was in IRQ context.

However since we're moving all the btrfs_bio::end_io() calls into task
context, there is no more need to support IRQ context thus we can relax
to regular spin_lock()/spin_unlock() for btrfs_inode::ordered_tree_lock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c    |  5 ++--
 fs/btrfs/inode.c        |  4 +--
 fs/btrfs/ordered-data.c | 57 ++++++++++++++++++-----------------------
 fs/btrfs/tree-log.c     |  4 +--
 4 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b25a2b45047e..2d32dfc34ae3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1726,7 +1726,6 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 
 		if (cur >= i_size) {
 			struct btrfs_ordered_extent *ordered;
-			unsigned long flags;
 
 			ordered = btrfs_lookup_first_ordered_range(inode, cur,
 								   folio_end - cur);
@@ -1735,11 +1734,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * there must be an ordered extent.
 			 */
 			ASSERT(ordered != NULL);
-			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+			spin_lock(&inode->ordered_tree_lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 			ordered->truncated_len = min(ordered->truncated_len,
 						     cur - ordered->file_offset);
-			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+			spin_unlock(&inode->ordered_tree_lock);
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bfcac2c68474..6ac8eceaeddd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7589,11 +7589,11 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					       EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					       EXTENT_DEFRAG, &cached_state);
 
-		spin_lock_irq(&inode->ordered_tree_lock);
+		spin_lock(&inode->ordered_tree_lock);
 		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 		ordered->truncated_len = min(ordered->truncated_len,
 					     cur - ordered->file_offset);
-		spin_unlock_irq(&inode->ordered_tree_lock);
+		spin_unlock(&inode->ordered_tree_lock);
 
 		/*
 		 * If the ordered extent has finished, we're safe to delete all
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index dfda952dcf7b..a421f7db9eec 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -237,14 +237,14 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 	/* One ref for the tree. */
 	refcount_inc(&entry->refs);
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	spin_lock(&inode->ordered_tree_lock);
 	node = tree_insert(&inode->ordered_tree, entry->file_offset,
 			   &entry->rb_node);
 	if (unlikely(node))
 		btrfs_panic(fs_info, -EEXIST,
 				"inconsistency in ordered tree at offset %llu",
 				entry->file_offset);
-	spin_unlock_irq(&inode->ordered_tree_lock);
+	spin_unlock(&inode->ordered_tree_lock);
 
 	spin_lock(&root->ordered_extent_lock);
 	list_add_tail(&entry->root_extent_list,
@@ -328,9 +328,9 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 {
 	struct btrfs_inode *inode = entry->inode;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	spin_lock(&inode->ordered_tree_lock);
 	list_add_tail(&sum->list, &entry->list);
-	spin_unlock_irq(&inode->ordered_tree_lock);
+	spin_unlock(&inode->ordered_tree_lock);
 }
 
 void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered)
@@ -417,15 +417,14 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
-	unsigned long flags;
 	bool ret;
 
 	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
 
-	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	spin_lock(&inode->ordered_tree_lock);
 	ret = can_finish_ordered_extent(ordered, folio, file_offset, len,
 					uptodate);
-	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+	spin_unlock(&inode->ordered_tree_lock);
 
 	/*
 	 * If this is a COW write it means we created new extent maps for the
@@ -481,13 +480,12 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 {
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 	u64 cur = file_offset;
 	const u64 end = file_offset + num_bytes;
 
 	trace_btrfs_writepage_end_io_hook(inode, file_offset, end - 1, uptodate);
 
-	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	spin_lock(&inode->ordered_tree_lock);
 	while (cur < end) {
 		u64 entry_end;
 		u64 this_end;
@@ -539,13 +537,13 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		ASSERT(len < U32_MAX);
 
 		if (can_finish_ordered_extent(entry, folio, cur, len, uptodate)) {
-			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+			spin_unlock(&inode->ordered_tree_lock);
 			btrfs_queue_ordered_fn(entry);
-			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+			spin_lock(&inode->ordered_tree_lock);
 		}
 		cur += len;
 	}
-	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+	spin_unlock(&inode->ordered_tree_lock);
 }
 
 /*
@@ -571,10 +569,9 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 {
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 	bool finished = false;
 
-	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	spin_lock(&inode->ordered_tree_lock);
 	if (cached && *cached) {
 		entry = *cached;
 		goto have_entry;
@@ -611,7 +608,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
 	}
-	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+	spin_unlock(&inode->ordered_tree_lock);
 	return finished;
 }
 
@@ -676,7 +673,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
 				 fs_info->delalloc_batch);
 
-	spin_lock_irq(&btrfs_inode->ordered_tree_lock);
+	spin_lock(&btrfs_inode->ordered_tree_lock);
 	node = &entry->rb_node;
 	rb_erase(node, &btrfs_inode->ordered_tree);
 	RB_CLEAR_NODE(node);
@@ -684,7 +681,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 		btrfs_inode->ordered_tree_last = NULL;
 	set_bit(BTRFS_ORDERED_COMPLETE, &entry->flags);
 	pending = test_and_clear_bit(BTRFS_ORDERED_PENDING, &entry->flags);
-	spin_unlock_irq(&btrfs_inode->ordered_tree_lock);
+	spin_unlock(&btrfs_inode->ordered_tree_lock);
 
 	/*
 	 * The current running transaction is waiting on us, we need to let it
@@ -969,9 +966,8 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 {
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	spin_lock(&inode->ordered_tree_lock);
 	node = ordered_tree_search(inode, file_offset);
 	if (!node)
 		goto out;
@@ -984,7 +980,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 		trace_btrfs_ordered_extent_lookup(inode, entry);
 	}
 out:
-	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+	spin_unlock(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -997,7 +993,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	spin_lock(&inode->ordered_tree_lock);
 	node = ordered_tree_search(inode, file_offset);
 	if (!node) {
 		node = ordered_tree_search(inode, file_offset + len);
@@ -1024,7 +1020,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_lookup_range(inode, entry);
 	}
-	spin_unlock_irq(&inode->ordered_tree_lock);
+	spin_unlock(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -1039,7 +1035,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 
 	btrfs_assert_inode_locked(inode);
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	spin_lock(&inode->ordered_tree_lock);
 	for (n = rb_first(&inode->ordered_tree); n; n = rb_next(n)) {
 		struct btrfs_ordered_extent *ordered;
 
@@ -1053,7 +1049,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 		refcount_inc(&ordered->refs);
 		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
 	}
-	spin_unlock_irq(&inode->ordered_tree_lock);
+	spin_unlock(&inode->ordered_tree_lock);
 }
 
 /*
@@ -1066,7 +1062,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	spin_lock(&inode->ordered_tree_lock);
 	node = ordered_tree_search(inode, file_offset);
 	if (!node)
 		goto out;
@@ -1075,7 +1071,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	refcount_inc(&entry->refs);
 	trace_btrfs_ordered_extent_lookup_first(inode, entry);
 out:
-	spin_unlock_irq(&inode->ordered_tree_lock);
+	spin_unlock(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -1096,9 +1092,8 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	struct rb_node *prev;
 	struct rb_node *next;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	spin_lock(&inode->ordered_tree_lock);
 	node = inode->ordered_tree.rb_node;
 	/*
 	 * Here we don't want to use tree_search() which will use tree->last
@@ -1153,7 +1148,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
 	}
 
-	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
+	spin_unlock(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -1285,9 +1280,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	/*
 	 * Take the root's ordered_extent_lock to avoid a race with
 	 * btrfs_wait_ordered_extents() when updating the disk_bytenr and
-	 * disk_num_bytes fields of the ordered extent below. And we disable
-	 * IRQs because the inode's ordered_tree_lock is used in IRQ context
-	 * elsewhere.
+	 * disk_num_bytes fields of the ordered extent below.
 	 *
 	 * There's no concern about a previous caller of
 	 * btrfs_wait_ordered_extents() getting the trimmed ordered extent
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index afaf96a76e3f..a9436be5e142 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5410,12 +5410,12 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		set_bit(BTRFS_ORDERED_LOGGED, &ordered->flags);
 
 		if (!test_bit(BTRFS_ORDERED_COMPLETE, &ordered->flags)) {
-			spin_lock_irq(&inode->ordered_tree_lock);
+			spin_lock(&inode->ordered_tree_lock);
 			if (!test_bit(BTRFS_ORDERED_COMPLETE, &ordered->flags)) {
 				set_bit(BTRFS_ORDERED_PENDING, &ordered->flags);
 				atomic_inc(&trans->transaction->pending_ordered);
 			}
-			spin_unlock_irq(&inode->ordered_tree_lock);
+			spin_unlock(&inode->ordered_tree_lock);
 		}
 		btrfs_put_ordered_extent(ordered);
 	}
-- 
2.51.0


