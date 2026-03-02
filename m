Return-Path: <linux-btrfs+bounces-22136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHv9DZlEpWkg7AUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22136-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 09:04:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3951D458F
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 09:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9218305A4B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0738759B;
	Mon,  2 Mar 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N2qqVXpR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N2qqVXpR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B763876B5
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438459; cv=none; b=O83qRA6mICjNRuHEnRS5ruLuD/ZEUIawFke2GfTeY9B88xvw9TYyrXRoo2rAswX0ak6vquT+tDEOoxVWE56dsqALCbI0hd0CDBTKNK3Iku/L7M4+UJMkY/1wX44Hh7jTgd9jBxN7z94Sj8rUL2w8R1yeStTaRKziY152xGfvmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438459; c=relaxed/simple;
	bh=5Xbqk6/Fdj4fywqokHQGxR33PF305JuQJNKZOOQw24U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WRi+tN3i7GM4NaoVO/t4+xiXYeO7u3XPmIk3MY+mG9coN9kVAp6At9hOAEdMELOdNQQlKoLbzEGCvuN9FcmDzJq8Ai0lH6K3dH57uoisl/xCJ5/TOG9bl81y0+M+gJ3UuW+MjFOsglzc6Qp7o4th8CuXerpq0ydFQqEcoqtp9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N2qqVXpR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N2qqVXpR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64F6D3F773
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772438453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1tiqFayGWmFXUDslnsDY+laBi62w2T1Ve+bn+iFbaNA=;
	b=N2qqVXpRng5jOBnnyRXt5XAlbMjKulF2GWkqmNg4aKknDtaiosWNMcHm75sOczTv1glOcg
	gMxeWsNFfqWypXoJDrX6YKq8Sl5Pgx0PTL7YRxu+HoVkJjp1vG1F2j0DJ7oeiYuiE6Ok6x
	mFwfWjis1hGkkv2yE1t65TSdtFDnE0A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772438453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1tiqFayGWmFXUDslnsDY+laBi62w2T1Ve+bn+iFbaNA=;
	b=N2qqVXpRng5jOBnnyRXt5XAlbMjKulF2GWkqmNg4aKknDtaiosWNMcHm75sOczTv1glOcg
	gMxeWsNFfqWypXoJDrX6YKq8Sl5Pgx0PTL7YRxu+HoVkJjp1vG1F2j0DJ7oeiYuiE6Ok6x
	mFwfWjis1hGkkv2yE1t65TSdtFDnE0A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C7E3EA69
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 08:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mrS5GLRDpWn1FgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 08:00:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
Date: Mon,  2 Mar 2026 18:30:30 +1030
Message-ID: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22136-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC3951D458F
X-Rspamd-Action: no action

[GLOBAL POOL]
Btrfs has maintained a global (per-module) pool of folios for compressed
read/writes.

That pool is maintained by a LRU list of cached folios, with a shrinker
to free all cached folios when needed.

The function btrfs_alloc_compr_folio() will try to grab any existing
folio from that LRU list first, and go regular folio allocation if that
list is empty.

And btrfs_free_compr_folio() will try to put the folio into the LRU list
if the current cache level is below the threshold (256 pages).

[EXISTING LIMITS]
Since the global pool is per-module, we have no way to support different
folio sizes. This limit is already affecting bs > ps support, so that bs
> ps cases just by-pass that global pool completely.

Another limit is for bs < ps cases, which is more common.
In that case we always allocate a full page (can be as large as 64K) for
the compressed bio, this can be very wasteful if the on-disk extent is
pretty small.

[POTENTIAL BUGS]
Recently David is reporting bugs related to compression:

- List corruption on that LRU list

- Folio ref count reaching zero at btrfs_free_compr_folio

Although I haven't yet found a concrete chain of how this happened, I'm
suspecting the usage of folio->lru is different from page->lru.
Under most cases a lot of folio members are 1:1 mapped to page members,
but I have not seen any driver/fs using folio->lru for their internal
usage. (There are users of page->lru though)

[REMOVAL]
Personally I'm not a huge fan of maintaining a local folio list just for
compression.

I believe MM has seen much more pressure and can still properly give us
folios/pages.
I do not think we are doing it better than MM, so let's just use regular
folio allocation instead.

And hopefully this will address David's recent crash (as usual I'm not
able to reproduce locally).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

Firstly I can not reproduce the problem hit by David, although all call
traces point to compr_pool, there is no concrete explanation.

Secondly this change itself may cause performance changes depending on
the memory pressure of the system, and there are quite some space for
extra fine tuning.

E.g. for compressed write path, if we failed to allocate a folio we can
always fall back to uncompressed write.
Thus in that case we can use GFP_NOWARN or even GFP_NORETRY for that
case.
---
 fs/btrfs/compression.c | 132 +----------------------------------------
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/inode.c       |   2 +-
 fs/btrfs/lzo.c         |   8 +--
 fs/btrfs/zlib.c        |  10 ++--
 fs/btrfs/zstd.c        |   8 +--
 6 files changed, 18 insertions(+), 147 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 192f133d9eb5..a96e4dc6624e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -126,107 +126,6 @@ static int compression_decompress(int type, struct list_head *ws,
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
-/*
- * Global cache of last unused pages for compression/decompression.
- */
-static struct btrfs_compr_pool {
-	struct shrinker *shrinker;
-	spinlock_t lock;
-	struct list_head list;
-	int count;
-	int thresh;
-} compr_pool;
-
-static unsigned long btrfs_compr_pool_count(struct shrinker *sh, struct shrink_control *sc)
-{
-	int ret;
-
-	/*
-	 * We must not read the values more than once if 'ret' gets expanded in
-	 * the return statement so we don't accidentally return a negative
-	 * number, even if the first condition finds it positive.
-	 */
-	ret = READ_ONCE(compr_pool.count) - READ_ONCE(compr_pool.thresh);
-
-	return ret > 0 ? ret : 0;
-}
-
-static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_control *sc)
-{
-	LIST_HEAD(remove);
-	struct list_head *tmp, *next;
-	int freed;
-
-	if (compr_pool.count == 0)
-		return SHRINK_STOP;
-
-	/* For now, just simply drain the whole list. */
-	spin_lock(&compr_pool.lock);
-	list_splice_init(&compr_pool.list, &remove);
-	freed = compr_pool.count;
-	compr_pool.count = 0;
-	spin_unlock(&compr_pool.lock);
-
-	list_for_each_safe(tmp, next, &remove) {
-		struct page *page = list_entry(tmp, struct page, lru);
-
-		ASSERT(page_ref_count(page) == 1);
-		put_page(page);
-	}
-
-	return freed;
-}
-
-/*
- * Common wrappers for page allocation from compression wrappers
- */
-struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info)
-{
-	struct folio *folio = NULL;
-
-	/* For bs > ps cases, no cached folio pool for now. */
-	if (fs_info->block_min_order)
-		goto alloc;
-
-	spin_lock(&compr_pool.lock);
-	if (compr_pool.count > 0) {
-		folio = list_first_entry(&compr_pool.list, struct folio, lru);
-		list_del_init(&folio->lru);
-		compr_pool.count--;
-	}
-	spin_unlock(&compr_pool.lock);
-
-	if (folio)
-		return folio;
-
-alloc:
-	return folio_alloc(GFP_NOFS, fs_info->block_min_order);
-}
-
-void btrfs_free_compr_folio(struct folio *folio)
-{
-	bool do_free = false;
-
-	/* The folio is from bs > ps fs, no cached pool for now. */
-	if (folio_order(folio))
-		goto free;
-
-	spin_lock(&compr_pool.lock);
-	if (compr_pool.count > compr_pool.thresh) {
-		do_free = true;
-	} else {
-		list_add(&folio->lru, &compr_pool.list);
-		compr_pool.count++;
-	}
-	spin_unlock(&compr_pool.lock);
-
-	if (!do_free)
-		return;
-
-free:
-	folio_put(folio);
-}
-
 static void end_bbio_compressed_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
@@ -238,7 +137,7 @@ static void end_bbio_compressed_read(struct btrfs_bio *bbio)
 
 	btrfs_bio_end_io(cb->orig_bbio, status);
 	bio_for_each_folio_all(fi, &bbio->bio)
-		btrfs_free_compr_folio(fi.folio);
+		folio_put(fi.folio);
 	bio_put(&bbio->bio);
 }
 
@@ -298,7 +197,7 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 		end_compressed_writeback(cb);
 	/* Note, our inode could be gone now. */
 	bio_for_each_folio_all(fi, &bbio->bio)
-		btrfs_free_compr_folio(fi.folio);
+		folio_put(fi.folio);
 	bio_put(&cb->bbio.bio);
 }
 
@@ -568,7 +467,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		struct folio *folio;
 		u32 cur_len = min(compressed_len - i * min_folio_size, min_folio_size);
 
-		folio = btrfs_alloc_compr_folio(fs_info);
+		folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 		if (!folio) {
 			ret = -ENOMEM;
 			goto out_free_bio;
@@ -996,11 +895,6 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
  * @cb->bbio.bio.bi_iter.bi_size will indicate the compressed data size.
  * The bi_size may not be sectorsize aligned, thus the caller still need
  * to do the round up before submission.
- *
- * This function will allocate compressed folios with btrfs_alloc_compr_folio(),
- * thus callers must make sure the endio function and error handling are using
- * btrfs_free_compr_folio() to release those folios.
- * This is already done in end_bbio_compressed_write() and cleanup_compressed_bio().
  */
 struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
 					  u64 start, u32 len, unsigned int type,
@@ -1133,31 +1027,11 @@ int __init btrfs_init_compress(void)
 			offsetof(struct compressed_bio, bbio.bio),
 			BIOSET_NEED_BVECS))
 		return -ENOMEM;
-
-	compr_pool.shrinker = shrinker_alloc(SHRINKER_NONSLAB, "btrfs-compr-pages");
-	if (!compr_pool.shrinker)
-		return -ENOMEM;
-
-	spin_lock_init(&compr_pool.lock);
-	INIT_LIST_HEAD(&compr_pool.list);
-	compr_pool.count = 0;
-	/* 128K / 4K = 32, for 8 threads is 256 pages. */
-	compr_pool.thresh = BTRFS_MAX_COMPRESSED / PAGE_SIZE * 8;
-	compr_pool.shrinker->count_objects = btrfs_compr_pool_count;
-	compr_pool.shrinker->scan_objects = btrfs_compr_pool_scan;
-	compr_pool.shrinker->batch = 32;
-	compr_pool.shrinker->seeks = DEFAULT_SEEKS;
-	shrinker_register(compr_pool.shrinker);
-
 	return 0;
 }
 
 void __cold btrfs_exit_compress(void)
 {
-	/* For now scan drains all pages and does not touch the parameters. */
-	btrfs_compr_pool_scan(NULL, NULL);
-	shrinker_free(compr_pool.shrinker);
-
 	bioset_exit(&btrfs_compressed_bioset);
 }
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 84600b284e1e..f3bb565ede6a 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -95,9 +95,6 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 int btrfs_compress_str2level(unsigned int type, const char *str, int *level_ret);
 
-struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info);
-void btrfs_free_compr_folio(struct folio *folio);
-
 struct workspace_manager {
 	struct list_head idle_ws;
 	spinlock_t ws_lock;
@@ -144,7 +141,7 @@ static inline void cleanup_compressed_bio(struct compressed_bio *cb)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio)
-		btrfs_free_compr_folio(fi.folio);
+		folio_put(fi.folio);
 	bio_put(bio);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ea3746c14760..c9c58e192a56 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9980,7 +9980,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		size_t bytes = min(min_folio_size, iov_iter_count(from));
 		char *kaddr;
 
-		folio = btrfs_alloc_compr_folio(fs_info);
+		folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 		if (!folio) {
 			ret = -ENOMEM;
 			goto out_cb;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 0c9093770739..4cf54de274c9 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -218,7 +218,7 @@ static int copy_compressed_data_to_bio(struct btrfs_fs_info *fs_info,
 	ASSERT((old_size >> sectorsize_bits) == (old_size + LZO_LEN - 1) >> sectorsize_bits);
 
 	if (!*out_folio) {
-		*out_folio = btrfs_alloc_compr_folio(fs_info);
+		*out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 		if (!*out_folio)
 			return -ENOMEM;
 	}
@@ -245,7 +245,7 @@ static int copy_compressed_data_to_bio(struct btrfs_fs_info *fs_info,
 			return -E2BIG;
 
 		if (!*out_folio) {
-			*out_folio = btrfs_alloc_compr_folio(fs_info);
+			*out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 			if (!*out_folio)
 				return -ENOMEM;
 		}
@@ -296,7 +296,7 @@ int lzo_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	ASSERT(bio->bi_iter.bi_size == 0);
 	ASSERT(len);
 
-	folio_out = btrfs_alloc_compr_folio(fs_info);
+	folio_out = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 	if (!folio_out)
 		return -ENOMEM;
 
@@ -372,7 +372,7 @@ int lzo_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	 * the endio function of bio.
 	 */
 	if (folio_out && IS_ALIGNED(total_out, min_folio_size)) {
-		btrfs_free_compr_folio(folio_out);
+		folio_put(folio_out);
 		folio_out = NULL;
 	}
 	if (folio_in)
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 1a5093525e32..09957bf5ad23 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -175,7 +175,7 @@ int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_folio = btrfs_alloc_compr_folio(fs_info);
+	out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -258,7 +258,7 @@ int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 				goto out;
 			}
 
-			out_folio = btrfs_alloc_compr_folio(fs_info);
+			out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -296,7 +296,7 @@ int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 				goto out;
 			}
 			/* Get another folio for the stream end. */
-			out_folio = btrfs_alloc_compr_folio(fs_info);
+			out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -316,7 +316,7 @@ int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 	} else {
 		/* The last folio hasn't' been utilized. */
-		btrfs_free_compr_folio(out_folio);
+		folio_put(out_folio);
 	}
 	out_folio = NULL;
 	ASSERT(bio->bi_iter.bi_size == workspace->strm.total_out);
@@ -330,7 +330,7 @@ int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	ret = 0;
 out:
 	if (out_folio)
-		btrfs_free_compr_folio(out_folio);
+		folio_put(out_folio);
 	if (data_in) {
 		kunmap_local(data_in);
 		folio_put(in_folio);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 41547ff187f6..cb19d2ad24ea 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -439,7 +439,7 @@ int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	workspace->in_buf.size = btrfs_calc_input_length(in_folio, end, start);
 
 	/* Allocate and map in the output buffer. */
-	out_folio = btrfs_alloc_compr_folio(fs_info);
+	out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -482,7 +482,7 @@ int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 				goto out;
 			}
 
-			out_folio = btrfs_alloc_compr_folio(fs_info);
+			out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -555,7 +555,7 @@ int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 			ret = -E2BIG;
 			goto out;
 		}
-		out_folio = btrfs_alloc_compr_folio(fs_info);
+		out_folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
 		if (out_folio == NULL) {
 			ret = -ENOMEM;
 			goto out;
@@ -574,7 +574,7 @@ int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
 	ASSERT(tot_out == bio->bi_iter.bi_size);
 out:
 	if (out_folio)
-		btrfs_free_compr_folio(out_folio);
+		folio_put(out_folio);
 	if (workspace->in_buf.src) {
 		kunmap_local(workspace->in_buf.src);
 		folio_put(in_folio);
-- 
2.53.0


