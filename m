Return-Path: <linux-btrfs+bounces-3898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD6897C70
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 01:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD65C1F23642
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 23:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143CE159569;
	Wed,  3 Apr 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BIe/L3Ez"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DC1591EF
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187739; cv=none; b=lhEk72Xq1JhdDuPMjvXCz4XPhKsD8X7xnTX+J6GIKpcF2SKrh0wra6luOY1wNqtnup54krw3XX07xvB7ihFgImo6LMrLtZUDbgrDn6KEjw9PIjgOYn9RwUR6VJmJmgdqBfl+Ou06F8+1gwcZApNffIenC93lfvrBuKWntmOmbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187739; c=relaxed/simple;
	bh=1Qmqwj+XCMn48BUcFkBatE6EgwrJC7GJSRAne4exY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6kCA3yD6rc/gbxHAB2vDWCE7/BygO/Qc0IRcVkauc7x4X9EtdnTO8lzyNuPANvF9VUflQIuF3XQyuWhMi7UWNfFRQmmmHDWGDamzo13t28QqBZBezyyHoqf/ewZCDQPuvri0voH78PnSCFPU+hP4Xb55eenPL89hX4KUgVdtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BIe/L3Ez; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19CB33761C;
	Wed,  3 Apr 2024 23:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712187735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=to/OwWoMzQbrhNdmCsFDL120MMtQIZ3GO7WXpEVfm3A=;
	b=BIe/L3EzPchflQTwEizW4Bqwe7qy327dPYZgYpbU16nNB6/Zlb7NGjLIWRk7SVuwwe66WW
	7AH6FqVfho+iQUfnQx8ujp+MtkPNQ1hocXe+7z0mrIl1hnMXahI+qgywCTFue8Er+EU40M
	hfstzkntATHiXxuKygKwHaRA0WqbiA8=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BCC511331E;
	Wed,  3 Apr 2024 23:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yNqhH1XpDWalfQAAn2gu4w
	(envelope-from <wqu@suse.com>); Wed, 03 Apr 2024 23:42:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/4] btrfs: remove not needed mod_start and mod_len from struct extent_map
Date: Thu,  4 Apr 2024 10:11:58 +1030
Message-ID: <03bec7e0f57c902714e2c947fc6720d92c43e995.1712187452.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712187452.git.wqu@suse.com>
References: <cover.1712187452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO

From: Filipe Manana <fdmanana@suse.com>

The mod_start and mod_len fields of struct extent_map were introduced by
commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that we
want") in order to avoid too low performance when fsyncing a file that
keeps getting extent maps merge, because it resulted in each fsync logging
again csum ranges that were already merged before.

We don't need this anymore as extent maps in the list of modified extents
are never merged with other extent maps and once we log an extent map we
remove it from the list of modified extent maps, so it's never logged
twice.

So remove the mod_start and mod_len fields from struct extent_map and use
instead the start and len fields when logging checksums in the fast fsync
path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.

Running the reproducer from the commit mentioned before, with a larger
number of extents and against a null block device, so that IO is fast
and we can better see any impact from searching checksums items and
logging them, gave the following results from dd:

Before this change:

   409600000 bytes (410 MB, 391 MiB) copied, 22.948 s, 17.8 MB/s

After this change:

   409600000 bytes (410 MB, 391 MiB) copied, 22.9997 s, 17.8 MB/s

So no changes in throughput.
The test was done in a release kernel (non-debug, Debian's default kernel
config) and its steps are the following:

   $ mkfs.btrfs -f /dev/nullb0
   $ mount /dev/sdb /mnt
   $ dd if=/dev/zero of=/mnt/foobar bs=4k count=100000 oflag=sync
   $ umount /mnt

This also reduces the size of struct extent_map from 128 bytes down to 112
bytes, so now we can have 36 extents maps per 4K page instead of 32.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c        | 18 ------------------
 fs/btrfs/extent_map.h        |  4 ----
 fs/btrfs/inode.c             |  4 +---
 fs/btrfs/tree-log.c          |  4 ++--
 include/trace/events/btrfs.h |  3 +--
 5 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 445f7716f1e2..471654cb65b0 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -252,8 +252,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 			em->len += merge->len;
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
-			em->mod_len = (em->mod_len + em->mod_start) - merge->mod_start;
-			em->mod_start = merge->mod_start;
 			em->generation = max(em->generation, merge->generation);
 			em->flags |= EXTENT_FLAG_MERGED;
 
@@ -271,7 +269,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		em->block_len += merge->block_len;
 		rb_erase_cached(&merge->rb_node, &tree->map);
 		RB_CLEAR_NODE(&merge->rb_node);
-		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
 		free_extent_map(merge);
@@ -300,7 +297,6 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 	struct extent_map_tree *tree = &inode->extent_tree;
 	int ret = 0;
 	struct extent_map *em;
-	bool prealloc = false;
 
 	write_lock(&tree->lock);
 	em = lookup_extent_mapping(tree, start, len);
@@ -325,21 +321,9 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 	em->generation = gen;
 	em->flags &= ~EXTENT_FLAG_PINNED;
-	em->mod_start = em->start;
-	em->mod_len = em->len;
-
-	if (em->flags & EXTENT_FLAG_FILLING) {
-		prealloc = true;
-		em->flags &= ~EXTENT_FLAG_FILLING;
-	}
 
 	try_merge_map(tree, em);
 
-	if (prealloc) {
-		em->mod_start = em->start;
-		em->mod_len = em->len;
-	}
-
 out:
 	write_unlock(&tree->lock);
 	free_extent_map(em);
@@ -361,8 +345,6 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 					int modified)
 {
 	refcount_inc(&em->refs);
-	em->mod_start = em->start;
-	em->mod_len = em->len;
 
 	ASSERT(list_empty(&em->list));
 
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index c5a098c99cc6..10e9491865c9 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -30,8 +30,6 @@ enum {
 	ENUM_BIT(EXTENT_FLAG_PREALLOC),
 	/* Logging this extent */
 	ENUM_BIT(EXTENT_FLAG_LOGGING),
-	/* Filling in a preallocated extent */
-	ENUM_BIT(EXTENT_FLAG_FILLING),
 	/* This em is merged from two or more physically adjacent ems */
 	ENUM_BIT(EXTENT_FLAG_MERGED),
 };
@@ -46,8 +44,6 @@ struct extent_map {
 	/* all of these are in bytes */
 	u64 start;
 	u64 len;
-	u64 mod_start;
-	u64 mod_len;
 	u64 orig_start;
 	u64 orig_block_len;
 	u64 ram_bytes;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3442dedff53d..c6f2b5d1dee1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7338,9 +7338,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
 	em->flags |= EXTENT_FLAG_PINNED;
-	if (type == BTRFS_ORDERED_PREALLOC)
-		em->flags |= EXTENT_FLAG_FILLING;
-	else if (type == BTRFS_ORDERED_COMPRESSED)
+	if (type == BTRFS_ORDERED_COMPRESSED)
 		extent_map_set_compression(em, compress_type);
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 472918a5bc73..d9777649e170 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4574,8 +4574,8 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	struct btrfs_root *csum_root;
 	u64 csum_offset;
 	u64 csum_len;
-	u64 mod_start = em->mod_start;
-	u64 mod_len = em->mod_len;
+	u64 mod_start = em->start;
+	u64 mod_len = em->len;
 	LIST_HEAD(ordered_sums);
 	int ret = 0;
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 90b0222390e5..766cfd48386c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -277,8 +277,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
 		{ EXTENT_FLAG_COMPRESS_LZO,	"COMPRESS_LZO"	},\
 		{ EXTENT_FLAG_COMPRESS_ZSTD,	"COMPRESS_ZSTD"	},\
 		{ EXTENT_FLAG_PREALLOC,		"PREALLOC"	},\
-		{ EXTENT_FLAG_LOGGING,		"LOGGING"	},\
-		{ EXTENT_FLAG_FILLING,		"FILLING"	})
+		{ EXTENT_FLAG_LOGGING,		"LOGGING"	})
 
 TRACE_EVENT_CONDITION(btrfs_get_extent,
 
-- 
2.44.0


