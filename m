Return-Path: <linux-btrfs+bounces-3826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B68959E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE55283658
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0615A490;
	Tue,  2 Apr 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJAi7L2r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88415A489
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076034; cv=none; b=ItRsokbmGaoeeXC0xTj0cKi2ozcPIsDjcPS7ruQiXFK5qfJZ2bZP1oVF8BhngSOL22ie+mK91KuuxJEkEkVOwDUGHKcWV8sOj9npnEMPnNEB7JhsjPoUkN1gik4/cInvaUwMt97hyeNsboz1/lYJSwyAcYZ+gKawz+s+SA5eI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076034; c=relaxed/simple;
	bh=Klug/fqTi65g9B0ymumrV7RRu1OFinBK5SW7OGAaXww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0QcJuAzPymd+WfQ1zZzoQig9hBit7KtW/L0zgJfORxE98T0iWqmUfKLft4tKyfK41O6+gTBJ198s9NQtPgxYr59oFz5XPdGq2dcg9zFIZTyRUm2oLpStXZsWg4782RI4uMoJ53K79ethI4y75uGUo1NEkPYDX2p429yn/BaX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJAi7L2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B387C43390;
	Tue,  2 Apr 2024 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712076034;
	bh=Klug/fqTi65g9B0ymumrV7RRu1OFinBK5SW7OGAaXww=;
	h=From:To:Cc:Subject:Date:From;
	b=WJAi7L2rZ9GNdt/rywr3ThTvnwzxK6iwHbyeCJiZ6yvI4N1cwodUnqBQpTR62yzQH
	 mexRuE3qhMebF2qWd72vhn8Y7JrY5nePohxFInA3zYJJrqBG0/xhcbwUik+3os7j2F
	 nJ0lY4nQCTCyY9TFw5RTQ5uCtOA6zuQVB5mblSBVQSP2zwJinAwR+ga/F6BB0eQSqP
	 XVu152v6zjHSOThMMcAOJNcm0Fg3OgZJa+lVESuz+vQuaISLe/mmRjoLOZgX4aXslf
	 fnBalpGSN23CTYecGsUtXnynSie9r5CgfBTH41iuo40E6N1iNUqigGy5gPH+b7giUn
	 X9tilDsxiLsdQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: remove not needed mod_start and mod_len from struct extent_map
Date: Tue,  2 Apr 2024 17:40:09 +0100
Message-Id: <2b5929e96bbede278f63c68a149cb50645b094d6.1712074768.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The mod_start and mod_len fields of struct extent_map were introduced by
commit 4e2f84e63dc1 ("Btrfs: improve fsync by filtering extents that we
want") in order to avoid too low performance when fsyncing a file that
keeps getting extent maps merge, because it resulted in each fsync logging
again csum ranges that were already merged before.

We don't need this anymore as extent maps in the modified list of extents
that get merged with other extents and once we log an extent map we remove
it from the list of modified extent maps.

So remove the mod_start and mod_len fields from struct extent_map and use
instead the start and len fields when logging checksums in the fast fsync
path. This also makes EXTENT_FLAG_FILLING unused so remove it as well.

Running the reproducer from the commit mentioned before, with a larger
number of extents and against a null block device, so that IO is fast
and we can better see any impact from searching checkums items and logging
them, gave the following results from dd:

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

This also reduce the size of struct extent_map from 128 bytes down to 112
bytes, so now we can have 36 extents maps per 4K page instead of 32.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
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
2.43.0


