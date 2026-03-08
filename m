Return-Path: <linux-btrfs+bounces-22279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3cCaGkUArmnF+gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22279-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129C232990
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D191A3014122
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC033B6D8;
	Sun,  8 Mar 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqhlfvJV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqhlfvJV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022BE55A
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011004; cv=none; b=faKKP+XrVuqWRXTsYeyCII3myzD+JWO6mfaBjROtg8Yd1ujmLryX9GDzmdYBI8InK3kf1r/L7RNofijDcGxFzXAG5gp8JJAzyJD+2eeZNTCD+TiIAv2O+ykBrzBah9xg/B7k+BiBpQD6kkFKkT0fWxvCCVtud+vdSpo3fhxIRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011004; c=relaxed/simple;
	bh=zisTFRnuTajfCNPq+sMe8gY2eyf8snGNUIZKfE1flHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uImP/gO4DbbGhVTCwVkPSAtE7RfPLwYfF/SRSmmjYJ6nIu3umRdJgnaABG9zRbJRSVKb5KWOYpLaLPe1OW83D6JBQH1NdhkQboKHVBBE6eQaSdZ2B9XxXj99VSO96UQFLYYOukXdlILwUZmrXcsWMUSJhIXGTWeiIOcsMaGnq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqhlfvJV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqhlfvJV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA1424D1D7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773011000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHCoOCEX3Do0zFVo2MMLH1/jYFtQ+SRGTTm+pvqbbhE=;
	b=qqhlfvJV2WR94yfjyJtW9tNKp1veqlfRwgmG9zB6CAaSFAgsweHw7E1Ync4RyNqUjyhCCM
	oyo27MDn34X9oOlAhMJwvVEIZ8tYvBe51yktCacPW/5xdGivQKwQ0zmWBW7gid2OuvtcJe
	MwYGUKasxLbVruPslAl48/b8u79P/To=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773011000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHCoOCEX3Do0zFVo2MMLH1/jYFtQ+SRGTTm+pvqbbhE=;
	b=qqhlfvJV2WR94yfjyJtW9tNKp1veqlfRwgmG9zB6CAaSFAgsweHw7E1Ync4RyNqUjyhCCM
	oyo27MDn34X9oOlAhMJwvVEIZ8tYvBe51yktCacPW/5xdGivQKwQ0zmWBW7gid2OuvtcJe
	MwYGUKasxLbVruPslAl48/b8u79P/To=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D753EBA8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGiCMTcArmkNbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 23:03:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 2/6] btrfs: add delayed ordered extent support
Date: Mon,  9 Mar 2026 09:32:51 +1030
Message-ID: <a51572ec3227b356f5808bcfcfdfd0ede065932e.1773009120.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773009120.git.wqu@suse.com>
References: <cover.1773009120.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0129C232990
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22279-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

A delayed ordered extent acts as a place holder ordered extent, thus its
disk_bytenr/disk_num_bytes will all be zero.

A real OE inside the delayed OE will be added to the child list of the
delayed OE.

When the parent delayed OE finished, child OEs will be finished and have
their valid file extents inserted.

And if some range has no child OE, e.g. beyond i_size, the range without
child OE will be manually released.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c        | 66 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 73 ++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/ordered-data.h | 14 ++++++++
 3 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0551b8e755ed..4876c136f819 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3162,6 +3162,69 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
 
+static int finish_delayed_ordered(struct btrfs_ordered_extent *oe)
+{
+	struct btrfs_inode *inode = oe->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_ordered_extent *child;
+	struct btrfs_ordered_extent *tmp;
+	const u32 nr_bits = oe->num_bytes >> fs_info->sectorsize_bits;
+	bool io_error = test_bit(BTRFS_ORDERED_IOERR, &oe->flags);
+	u64 cur = oe->file_offset;
+	int ret = 0;
+	int saved_ret = 0;
+
+	/* Finish each child OE. */
+	list_for_each_entry_safe(child, tmp, &oe->child_list, child_list) {
+		list_del_init(&child->child_list);
+		refcount_inc(&child->refs);
+
+		/* The range should have been marked in the bitmap. */
+		ASSERT(bitmap_test_range_all_set(oe->child_bitmap,
+			(child->file_offset - oe->file_offset) >> fs_info->sectorsize_bits,
+			child->num_bytes >> fs_info->sectorsize_bits));
+
+		if (io_error)
+			set_bit(BTRFS_ORDERED_IOERR, &child->flags);
+
+		ret = btrfs_finish_one_ordered(child);
+		if (ret && !saved_ret)
+			saved_ret = ret;
+	}
+
+	/* For ranges that doesn't have a child OE, manually clean them up. */
+	while (cur < oe->file_offset + oe->num_bytes) {
+		const u32 cur_bit = (cur - oe->file_offset) >> fs_info->sectorsize_bits;
+		u32 first_zero;
+		u32 next_set;
+		u64 range_start;
+		u64 range_end;
+		u32 range_len;
+
+		first_zero = find_next_zero_bit(oe->child_bitmap, nr_bits, cur_bit);
+		if (first_zero >= nr_bits)
+			break;
+		next_set = find_next_bit(oe->child_bitmap, nr_bits, first_zero);
+		ASSERT(next_set > first_zero);
+
+		range_start = oe->file_offset + (first_zero << fs_info->sectorsize_bits);
+		range_len = (next_set - first_zero) << fs_info->sectorsize_bits;
+		range_end = range_start + range_len - 1;
+
+		/*
+		 * The range has no real OE created, thus its reserved data/meta space
+		 * needs to be manually released by EXTENT_DO_ACCOUNTING.
+		 */
+		btrfs_clear_extent_bit(&inode->io_tree, range_start, range_end,
+				EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING, NULL);
+		cur = range_end + 1;
+	}
+	btrfs_remove_ordered_extent(oe);
+	btrfs_put_ordered_extent(oe);
+	btrfs_put_ordered_extent(oe);
+	return saved_ret;
+}
+
 /*
  * As ordered data IO finishes, this gets called so we can finish
  * an ordered extent if the range of bytes in the file it covers are
@@ -3184,6 +3247,9 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits = EXTENT_DEFRAG;
 
+	if (test_bit(BTRFS_ORDERED_DELAYED, &ordered_extent->flags))
+		return finish_delayed_ordered(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index bc88b904d024..f28f8779ad85 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -169,6 +169,17 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	if (test_bit(BTRFS_ORDERED_ENCODED, &flags))
 		ASSERT(test_bit(BTRFS_ORDERED_COMPRESSED, &flags));
 
+	/*
+	 * DELAYED can only be set with REGULAR, no DIRECT/ENCODED, and should
+	 * not exceed BTRFS_MAX_COMPRESSED size.
+	 */
+	if (test_bit(BTRFS_ORDERED_DELAYED, &flags)) {
+		ASSERT(test_bit(BTRFS_ORDERED_REGULAR, &flags));
+		ASSERT(!test_bit(BTRFS_ORDERED_DIRECT, &flags));
+		ASSERT(!test_bit(BTRFS_ORDERED_ENCODED, &flags));
+		ASSERT(num_bytes <= BTRFS_MAX_COMPRESSED);
+	}
+
 	/*
 	 * For a NOCOW write we can free the qgroup reserve right now. For a COW
 	 * one we transfer the reserved space from the inode's iotree into the
@@ -215,6 +226,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	INIT_LIST_HEAD(&entry->root_extent_list);
 	INIT_LIST_HEAD(&entry->work_list);
 	INIT_LIST_HEAD(&entry->bioc_list);
+	INIT_LIST_HEAD(&entry->child_list);
 	init_completion(&entry->completion);
 
 	/*
@@ -235,12 +247,43 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	return entry;
 }
 
+static void add_child_oe(struct btrfs_ordered_extent *parent,
+			 struct btrfs_ordered_extent *child)
+{
+	struct btrfs_inode *inode = parent->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 start_bit = (child->file_offset - parent->file_offset) >>
+			      fs_info->sectorsize_bits;
+	const u32 nr_bits = child->num_bytes >> fs_info->sectorsize_bits;
+
+	lockdep_assert_held(&inode->ordered_tree_lock);
+	/* Basic flags check for parent and child. */
+	ASSERT(test_bit(BTRFS_ORDERED_DELAYED, &parent->flags));
+	ASSERT(!test_bit(BTRFS_ORDERED_DELAYED, &child->flags));
+
+	/* Child should not belong to any parent yet. */
+	ASSERT(list_empty(&child->child_list));
+
+	/* Child should be fully inside parent's range. */
+	ASSERT(child->file_offset >= parent->file_offset);
+	ASSERT(child->file_offset + child->num_bytes <=
+	       parent->file_offset + parent->num_bytes);
+
+	/* There should be no existing child in the range. */
+	ASSERT(bitmap_test_range_all_zero(parent->child_bitmap, start_bit, nr_bits));
+
+	list_add_tail(&parent->child_list, &child->child_list);
+
+	bitmap_set(parent->child_bitmap, start_bit, nr_bits);
+}
+
 static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 {
 	struct btrfs_inode *inode = entry->inode;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *node;
+	bool is_child = false;
 
 	trace_btrfs_ordered_extent_add(inode, entry);
 
@@ -253,17 +296,25 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 	spin_lock(&inode->ordered_tree_lock);
 	node = tree_insert(&inode->ordered_tree, entry->file_offset,
 			   &entry->rb_node);
-	if (unlikely(node)) {
+	if (node) {
 		struct btrfs_ordered_extent *exist =
 			rb_entry(node, struct btrfs_ordered_extent, rb_node);
 
-		btrfs_panic(fs_info, -EEXIST,
+		if (test_bit(BTRFS_ORDERED_DELAYED, &exist->flags)) {
+			add_child_oe(exist, entry);
+			is_child = true;
+		} else {
+			btrfs_panic(fs_info, -EEXIST,
 "existing oe file_offset=%llu num_bytes=%llu flags=0x%lx new oe file_offset=%llu num_bytes=%llu flags=0x%lx",
-			    exist->file_offset, exist->num_bytes, exist->flags,
-			    entry->file_offset, entry->num_bytes, entry->flags);
+				    exist->file_offset, exist->num_bytes, exist->flags,
+				    entry->file_offset, entry->num_bytes, entry->flags);
+		}
 	}
 	spin_unlock(&inode->ordered_tree_lock);
 
+	/* Child OE shouldn't be added to per-root oe list. */
+	if (is_child)
+		return;
 	spin_lock(&root->ordered_extent_lock);
 	list_add_tail(&entry->root_extent_list,
 		      &root->ordered_extents);
@@ -336,6 +387,20 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 	return entry;
 }
 
+struct btrfs_ordered_extent *btrfs_alloc_delayed_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset, u32 length)
+{
+	struct btrfs_ordered_extent *entry;
+
+	entry = alloc_ordered_extent(inode, file_offset, length, length, 0, 0, 0,
+				     (1UL << BTRFS_ORDERED_REGULAR) |
+				     (1UL << BTRFS_ORDERED_DELAYED),
+				     BTRFS_COMPRESS_NONE);
+	if (!IS_ERR(entry))
+		insert_ordered_extent(entry);
+	return entry;
+}
+
 /*
  * Add a struct btrfs_ordered_sum into the list of checksums to be inserted
  * when an ordered extent is finished.  If the list covers more than one
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 2664ea455229..8a1800f109e8 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/wait.h>
 #include "async-thread.h"
+#include "compression.h"
 
 struct inode;
 struct page;
@@ -87,6 +88,12 @@ enum {
 	 */
 	BTRFS_ORDERED_DIRECT,
 
+	/*
+	 * Extra bit for delayed OE, can only be set for REGULAR.
+	 * Can not be set with COMPRESSED/ENCODED/DIRECT.
+	 */
+	BTRFS_ORDERED_DELAYED,
+
 	BTRFS_ORDERED_NR_FLAGS,
 };
 static_assert(BTRFS_ORDERED_NR_FLAGS <= BITS_PER_LONG);
@@ -155,6 +162,11 @@ struct btrfs_ordered_extent {
 	/* a per root list of all the pending ordered extents */
 	struct list_head root_extent_list;
 
+	/* Child ordered extent list for delayed OE. */
+	struct list_head child_list;
+
+	unsigned long child_bitmap[BITS_TO_LONGS(BTRFS_MAX_COMPRESSED / BTRFS_MIN_BLOCKSIZE)];
+
 	struct btrfs_work work;
 
 	struct completion completion;
@@ -192,6 +204,8 @@ struct btrfs_file_extent {
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			struct btrfs_inode *inode, u64 file_offset,
 			const struct btrfs_file_extent *file_extent, unsigned long flags);
+struct btrfs_ordered_extent *btrfs_alloc_delayed_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset, u32 length);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.53.0


