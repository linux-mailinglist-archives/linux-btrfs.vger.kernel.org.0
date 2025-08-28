Return-Path: <linux-btrfs+bounces-16505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F411CB3AD0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2677B8778
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684E2D0621;
	Thu, 28 Aug 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="clwO+Shs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="clwO+Shs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C42C2347
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418050; cv=none; b=LQwLEBsrigyUfoK01RxGor5OQ83C4nq5f9w+4/ygMyowsVTcOSMraqi9qftUGYPUe8M8+G/CbBURaenUuOohO5uRav/MjRRy6vhCEWUk/BvpTTKiRWsEvRrd9DGNGs+9r4lZtQy64CJZg5fxE+pUDGBmm0HGkRXOQ/l8Q2tVSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418050; c=relaxed/simple;
	bh=HFCjwI4n2GgEUh1U9R3i07FR5GoPm5uc0wvkBCXlR+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2cqknnkQENL6aIjKzDgVyuTZSXv708noBD8ZFSA07cSQREDfLBo8p7Z6FPgRXUerksfZv37LwIJQCxeaDvGCLwBjC2EIkYffsq/7YtxCRB5YPkzY4rQVYeFSkD270b1ZRsnDqgLIx5nf5qimB4+Cu7h3JkInnrm0u0l/jL8nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=clwO+Shs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=clwO+Shs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9ACA9339A2;
	Thu, 28 Aug 2025 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756418045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0YLOJpCGaUBmXtuW59C+Z+o9tGtpFbeSNT1zSYQ85M=;
	b=clwO+ShsOIY0oEmxJszUaL6tfTu8EvgUId01THJyslmV6WYTw4pVAsY+KuRQiWOZ7y9HKq
	MPkCQK1YpcXqnOI2efDJY9Dq2FOmUZkFkClW3WQQfKRTbWY7orE2+EV7cOsNy8qjEnbwmq
	TcqmqPlHx5QLDrqZADU3yv34vANk404=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756418045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0YLOJpCGaUBmXtuW59C+Z+o9tGtpFbeSNT1zSYQ85M=;
	b=clwO+ShsOIY0oEmxJszUaL6tfTu8EvgUId01THJyslmV6WYTw4pVAsY+KuRQiWOZ7y9HKq
	MPkCQK1YpcXqnOI2efDJY9Dq2FOmUZkFkClW3WQQfKRTbWY7orE2+EV7cOsNy8qjEnbwmq
	TcqmqPlHx5QLDrqZADU3yv34vANk404=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92E8D1368B;
	Thu, 28 Aug 2025 21:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id smjcI/3PsGhLLwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 28 Aug 2025 21:54:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
Date: Thu, 28 Aug 2025 23:53:54 +0200
Message-ID: <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756417687.git.dsterba@suse.com>
References: <cover.1756417687.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -6.80

This is preparatory work to use cache folio address in the extent buffer
to avoid reading folio_address() all the time (this is hidden in the
accessors).

However this is not as straightforward as just adding the array, the
extent buffers are of variable size depending on the node size and
adding 16*8=128 bytes would bloat the whole structure too much.

We already waste 3/4 of the folios array on x86_64 and default node size
16K so we need to make the arrays variable size. This is allowed only
for one such array and it must be at the end of the structure. And we
need two.

With one indirection this is possible. For N folios in a node the
variable sized array will be 2N:

	faddr     ----+
	folios[]      |
	[0]           |
	[1]           |
	...           |
	[N]       <---+
	[N+1]
	...

There are 5 node sizes supported in total, but not all of them are used.
Create slabs only for 2 sizes where 16K is for the default size on
x86_64 and 64K. The one that contains the node size will be used,
possibly with some slack space.

In case of 16K node size we'll gain a few more objects per slab:

Before this change:

  sizeof (struct extent_buffer) = 240
  objects in 8K slab = 34

After, the base size of extent buffer is 120 bytes:

For 16K:

  size = 120 + 2 * 4 * 8 = 184
  objects in 8K slab = 44

For 64K:

  size = 120 + 2 * 16 * 8 = 376
  objects in 8K slab = 21

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 71 +++++++++++++++++++++++++++++++++-----------
 fs/btrfs/extent_io.h | 20 +++++++++----
 2 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca7174fa024056..4c906e5ea8ac70 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -35,7 +35,21 @@
 #include "super.h"
 #include "transaction.h"
 
-static struct kmem_cache *extent_buffer_cache;
+static struct kmem_cache *extent_buffer_cache_16k;
+static struct kmem_cache *extent_buffer_cache_64k;
+
+static void free_eb(struct extent_buffer *eb)
+{
+	if (!eb)
+		return;
+
+	if (test_bit(EXTENT_BUFFER_16K, &eb->bflags))
+		kmem_cache_free(extent_buffer_cache_16k, eb);
+	else if (test_bit(EXTENT_BUFFER_64K, &eb->bflags))
+		kmem_cache_free(extent_buffer_cache_64k, eb);
+	else
+		DEBUG_WARN("eb size mismatch");
+}
 
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
@@ -81,7 +95,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
 		WARN_ON_ONCE(1);
-		kmem_cache_free(extent_buffer_cache, eb);
+		free_eb(eb);
 	}
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
@@ -221,11 +235,24 @@ static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
 
 int __init extent_buffer_init_cachep(void)
 {
-	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-						sizeof(struct extent_buffer), 0, 0,
-						NULL);
-	if (!extent_buffer_cache)
+	size_t size;
+
+	size  = sizeof(struct extent_buffer);
+	size += (SZ_16K >> PAGE_SHIFT) * sizeof(struct folio *);
+	size += (SZ_16K >> PAGE_SHIFT) * sizeof(void *);
+	extent_buffer_cache_16k = kmem_cache_create("btrfs_extent_buffer_16k",
+						    size, 0, 0, NULL);
+
+	size  = sizeof(struct extent_buffer);
+	size += (SZ_64K >> PAGE_SHIFT) * sizeof(struct folio *);
+	size += (SZ_64K >> PAGE_SHIFT) * sizeof(void *);
+	extent_buffer_cache_64k = kmem_cache_create("btrfs_extent_buffer_64k",
+						    size, 0, 0, NULL);
+
+	if (!extent_buffer_cache_16k || !extent_buffer_cache_64k) {
+		extent_buffer_free_cachep();
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -237,7 +264,8 @@ void __cold extent_buffer_free_cachep(void)
 	 * destroy caches.
 	 */
 	rcu_barrier();
-	kmem_cache_destroy(extent_buffer_cache);
+	kmem_cache_destroy(extent_buffer_cache_16k);
+	kmem_cache_destroy(extent_buffer_cache_64k);
 }
 
 static void process_one_folio(struct btrfs_fs_info *fs_info,
@@ -692,8 +720,10 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
 	if (ret < 0)
 		return ret;
 
-	for (int i = 0; i < num_pages; i++)
+	for (int i = 0; i < num_pages; i++) {
 		eb->folios[i] = page_folio(page_array[i]);
+		eb->faddr[i] = folio_address(eb->folios[i]);
+	}
 	eb->folio_size = PAGE_SIZE;
 	eb->folio_shift = PAGE_SHIFT;
 	return 0;
@@ -2192,7 +2222,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 
 	prepare_eb_write(eb);
 
-	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+	bbio = btrfs_bio_alloc(num_extent_folios(eb),
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
 			       eb->fs_info, end_bbio_meta_write, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
@@ -2929,7 +2959,7 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 {
 	ASSERT(!extent_buffer_under_io(eb));
 
-	for (int i = 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 
 		if (!folio)
@@ -2946,7 +2976,7 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 {
 	btrfs_release_extent_buffer_folios(eb);
 	btrfs_leak_debug_del_eb(eb);
-	kmem_cache_free(extent_buffer_cache, eb);
+	free_eb(eb);
 }
 
 static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info,
@@ -2954,7 +2984,16 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 {
 	struct extent_buffer *eb = NULL;
 
-	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
+	ASSERT(fs_info->nodesize <= BTRFS_MAX_METADATA_BLOCKSIZE);
+	if (fs_info->nodesize <= SZ_16K) {
+		eb = kmem_cache_zalloc(extent_buffer_cache_16k, GFP_NOFS | __GFP_NOFAIL);
+		__set_bit(EXTENT_BUFFER_16K, &eb->bflags);
+		eb->faddr = (void **)(eb->folios + (SZ_16K >> PAGE_SHIFT));
+	} else {
+		eb = kmem_cache_zalloc(extent_buffer_cache_64k, GFP_NOFS | __GFP_NOFAIL);
+		__set_bit(EXTENT_BUFFER_64K, &eb->bflags);
+		eb->faddr = (void **)(eb->folios + (SZ_64K >> PAGE_SHIFT));
+	}
 	eb->start = start;
 	eb->len = fs_info->nodesize;
 	eb->fs_info = fs_info;
@@ -2965,8 +3004,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	spin_lock_init(&eb->refs_lock);
 	refcount_set(&eb->refs, 1);
 
-	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
-
 	return eb;
 }
 
@@ -3550,7 +3587,7 @@ static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
 	struct extent_buffer *eb =
 			container_of(head, struct extent_buffer, rcu_head);
 
-	kmem_cache_free(extent_buffer_cache, eb);
+	free_eb(eb);
 }
 
 static int release_extent_buffer(struct extent_buffer *eb)
@@ -3586,7 +3623,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 		btrfs_release_extent_buffer_folios(eb);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
-			kmem_cache_free(extent_buffer_cache, eb);
+			free_eb(eb);
 			return 1;
 		}
 #endif
@@ -3837,7 +3874,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	check_buffer_tree_ref(eb);
 	refcount_inc(&eb->refs);
 
-	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
+	bbio = btrfs_bio_alloc(num_extent_folios(eb),
 			       REQ_OP_READ | REQ_META, eb->fs_info,
 			       end_bbio_meta_read, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 61130786b9a3ad..3903913924f02c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -48,6 +48,9 @@ enum {
 	EXTENT_BUFFER_ZONED_ZEROOUT,
 	/* Indicate that extent buffer pages a being read */
 	EXTENT_BUFFER_READING,
+	/* Size of slab derived from fs_info->nodesize. */
+	EXTENT_BUFFER_16K,
+	EXTENT_BUFFER_64K,
 };
 
 /* these are flags for __process_pages_contig */
@@ -107,16 +110,21 @@ struct extent_buffer {
 
 	struct rw_semaphore lock;
 
-	/*
-	 * Pointers to all the folios of the extent buffer.
-	 *
-	 * For now the folio is always order 0 (aka, a single page).
-	 */
-	struct folio *folios[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 	pid_t lock_owner;
 #endif
+	/*
+	 * Pointers to all folios of the extent buffer.
+	 *
+	 * For now the folio is always order 0 (a single page).
+	 *
+	 * Extent buffer size is determined at runtime, and allocated from the
+	 * right slab depending on "nodesize <= 16K". Cached folio address array
+	 * is stored after folios, @faddr is set up at allocation time.
+	 */
+	void **faddr;
+	struct folio *folios[];
 };
 
 struct btrfs_eb_write_context {
-- 
2.51.0


