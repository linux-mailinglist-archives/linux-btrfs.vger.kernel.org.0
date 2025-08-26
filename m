Return-Path: <linux-btrfs+bounces-16360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A6B359A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE72A27C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E863218C9;
	Tue, 26 Aug 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AfdVQYNM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AfdVQYNM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528213126DB
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202212; cv=none; b=hM/PXawBaeThpnJhh8kWkJrluyNbzvS6kzow1kI1TaA3xdG3ko7qLxgJ+jbKDzSfYWi5wAtkIg813/NYEhnBDa9+MpdOIUrX9oJWGiq7v7kPO2N1Uh2Xt0V38gV4GeO76zUAAvFvw1i6I89w5inPETRn51kr0e+ArlE3nD4nJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202212; c=relaxed/simple;
	bh=02NqAMAaSutU9KVGBKRA2KGY49FqccMxwaA83EWHPqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVGzK+3EuJja8yx5KL42xuEcGYgixzE/vkb1M3lP2SGjXq3If7lEnOHX+vPpc00ziMcVM2CKLdj/U9lF6C/odIEvcf5vZZQKNv2hbNl2N5WXnoMcnEXzktRqrNAQ9h0nDlQGSbwxF0W82srIdfSOygz/2ouH5E0hJzAnQRLEQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AfdVQYNM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AfdVQYNM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91A7B1F787;
	Tue, 26 Aug 2025 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756202207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6OjCwIwTkP+bbcKpTQAaqEsSVOsQYYhubmtwj8g2KrM=;
	b=AfdVQYNM+Ctar9A9/JHLdU2CXEkBV2oHmy2Y2xQqbI4PSwkq8Ibm+boKVbZk85XQ7x1nzi
	QcQVS31WccEoJCYNabPPgpcnSwK/4TMARkPbUMD//lq86lRuXA3Yldb3tttONlSAHFPJPd
	OqZuqvML2EidlekxfgWgMs6xMg7rHBY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756202207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6OjCwIwTkP+bbcKpTQAaqEsSVOsQYYhubmtwj8g2KrM=;
	b=AfdVQYNM+Ctar9A9/JHLdU2CXEkBV2oHmy2Y2xQqbI4PSwkq8Ibm+boKVbZk85XQ7x1nzi
	QcQVS31WccEoJCYNabPPgpcnSwK/4TMARkPbUMD//lq86lRuXA3Yldb3tttONlSAHFPJPd
	OqZuqvML2EidlekxfgWgMs6xMg7rHBY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9353F13479;
	Tue, 26 Aug 2025 09:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QQaEFd6ErWhtagAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 26 Aug 2025 09:56:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] btrfs: do more strict compressed read merge check
Date: Tue, 26 Aug 2025 19:26:28 +0930
Message-ID: <635dc58dd4c7ae44264e488bb9b2ef7bd9dd5e21.1756201932.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BUG]
With 64K page size (aarch64 with 64K page size config) and 4K btrfs
block size, the following workload can easily lead to a corrupted read:

        mkfs.btrfs -f -s 4k $dev > /dev/null
        mount -o compress=zstd $dev $mnt
        xfs_io -f -c "pwrite -S 0xff 0 64k" -c sync $mnt/base > /dev/null
	echo "correct result:"
        od -Ax -x $mnt/base
        xfs_io -f -c "reflink $mnt/base 32k 0 32k" \
		  -c "reflink $mnt/base 0 32k 32k" \
		  -c "pwrite -S 0xff 60k 4k" $mnt/new > /dev/null
	echo "incorrect result:"
        od -Ax -x $mnt/new
        umount $mnt

This shows the following result:

  correct result:
  000000 ffff ffff ffff ffff ffff ffff ffff ffff
  *
  010000
  incorrect result:
  000000 ffff ffff ffff ffff ffff ffff ffff ffff
  *
  008000 0000 0000 0000 0000 0000 0000 0000 0000
  *
  00f000 ffff ffff ffff ffff ffff ffff ffff ffff
  *
  010000

Notice the zero in the range [0x8000, 0xf000), which is incorrect.

[CAUSE]
With extra trace printk, it shows the following events during od:
(some unrelated info removed like CPU and context)

 od-3457   btrfs_do_readpage: enter r/i=5/258 folio=0(65536) prev_em_start=0000000000000000

The "r/i" is indicating the root and inode number. In our case the file
"new" is using ino 258 from fs tree (root 5).

Here notice the @prev_em_start pointer is NULL. This means the
btrfs_do_readpage() is called from btrfs_read_folio(), not from
btrfs_readahead().

 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=0 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=4096 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=8192 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=12288 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=16384 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=20480 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=24576 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=28672 got em start=0 len=32768

These above 32K blocks will be read from the the first half of the
compressed data extent.

 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=32768 got em start=32768 len=32768

Note here there is no btrfs_submit_compressed_read() call. Which is
incorrect now.
As both extent maps at 0 and 32K are pointing to the same compressed
data, their offset are different thus can not be merged into the same
read.

So this means the compressed data read merge check is doing something
wrong.

 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=36864 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=40960 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=45056 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=49152 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=53248 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=57344 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=61440 skip uptodate
 od-3457   btrfs_submit_compressed_read: cb orig_bio: file off=0 len=61440

The function btrfs_submit_compressed_read() is only called at the end of
folio read. The compressed bio will only have a extent map of range [0,
32K), but the original bio passed in are for the whole 64K folio.

This will cause the decompression part to only fill the first 32K,
leaving the rest untouched (aka, filled with zero).

This incorrect compressed read merge leads to the above data corruption.

There are similar problems happened in the past, commit 808f80b46790
("Btrfs: update fix for read corruption of compressed and shared
extents") is doing pretty much the same fix for readahead.

But that's back to 2015, where btrfs still only supports bs (block size)
== ps (page size) cases.
This means btrfs_do_readpage() only needs to handle a folio which
contains exactly one block.

Only btrfs_readahead() can lead to a read covering multiple blocks.
Thus only btrfs_readahead() passes a non-NULL @prev_em_start pointer.

With the v5.15 btrfs introduced bs < ps support. This breaks the above
assumption that a folio can only contain one block.

Now btrfs_read_folio() can also read multiple blocks in one go.
But btrfs_read_folio() doesn't pass a @prev_em_start pointer, thus the
existing bio force submission check will never be triggered.

In theory, this can also happen for btrfs with large folios, but since
large folio is still experimental, we don't need to bother it, thus only
bs < ps support is affected for now.

[FIX]
Instead of passing @prev_em_start to do the proper compressed extent
check, introduce one new member, btrfs_bio_ctrl::last_em_start, so that
the existing bio force submission logic will always be triggered.

CC: stable@vger.kernel.org #5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Use a single btrfs_bio_ctrl::last_em_start
  Since the existing prev_em_start is using U64_MAX as the initial value
  to indicate no em hit yet, we can use the same logic, which saves
  another 8 bytes from btrfs_bio_ctrl.

- Update the reproducer
  Previously I failed to reproduce using a minimal workload.
  As regular read from od/md5sum always trigger readahead thus not
  hitting the @prev_em_start == NULL path.

  Will send out a fstest case for it using the minimal reproducer.
  But it will still need a 16K/64K page sized system to reproduce.

  Fix the problem by doing an block aligned write into the folio, so
  that the folio will be partially dirty and not go through the
  readahead path.

- Update the analyze
  This includes the trace events of the minimal reproducer, and
  mentioning of previous similar fixes and why they do not work for
  subpage cases.

- Update the CC tag
  Since it's only affecting bs < ps cases (for non-experimental builds),
  only need to fix kernels with subpage btrfs supports.

v2:
- Only save extent_map::start/len to save memory for btrfs_bio_ctrl
  It's using on-stack memory which is very limited inside the kernel.

- Remove the commit message mentioning of clearing last saved em
  Since we're using em::start/len, there is no need to clear them.
  Either we hit the same em::start/len, meaning hitting the same extent
  map, or we hit a different em, which will have a different start/len.
---
 fs/btrfs/extent_io.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c12fd64a1f3..b219dbaaedc8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -131,6 +131,24 @@ struct btrfs_bio_ctrl {
 	 */
 	unsigned long submit_bitmap;
 	struct readahead_control *ractl;
+
+	/*
+	 * The start file offset of the last hit extent map.
+	 *
+	 * This is for proper compressed read merge.
+	 * U64_MAX means no extent map hit yet.
+	 *
+	 * The current btrfs_bio_is_contig() only uses disk_bytenr as
+	 * the condition to check if the read can be merged with previous
+	 * bio, which is not correct. E.g. two file extents pointing to the
+	 * same extent but with different offset.
+	 *
+	 * So here we need to do extra check to only merge reads that are
+	 * covered by the same extent map.
+	 * Just extent_map::start will be enough, as they are unique
+	 * inside the same inode.
+	 */
+	u64 last_em_start;
 };
 
 /*
@@ -965,7 +983,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
  * return 0 on success, otherwise return error
  */
 static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
-		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
+			     struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -1076,12 +1094,11 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		 * non-optimal behavior (submitting 2 bios for the same extent).
 		 */
 		if (compress_type != BTRFS_COMPRESS_NONE &&
-		    prev_em_start && *prev_em_start != (u64)-1 &&
-		    *prev_em_start != em->start)
+		    bio_ctrl->last_em_start != U64_MAX &&
+		    bio_ctrl->last_em_start != em->start)
 			force_bio_submit = true;
 
-		if (prev_em_start)
-			*prev_em_start = em->start;
+		bio_ctrl->last_em_start = em->start;
 
 		em_gen = em->generation;
 		btrfs_free_extent_map(em);
@@ -1296,12 +1313,15 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	const u64 start = folio_pos(folio);
 	const u64 end = start + folio_size(folio) - 1;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ,
+		.last_em_start = U64_MAX,
+	};
 	struct extent_map *em_cached = NULL;
 	int ret;
 
 	lock_extents_for_read(inode, start, end, &cached_state);
-	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	btrfs_free_extent_map(em_cached);
@@ -2641,7 +2661,8 @@ void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_READ | REQ_RAHEAD,
-		.ractl = rac
+		.ractl = rac,
+		.last_em_start = U64_MAX,
 	};
 	struct folio *folio;
 	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
@@ -2649,12 +2670,11 @@ void btrfs_readahead(struct readahead_control *rac)
 	const u64 end = start + readahead_length(rac) - 1;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em_cached = NULL;
-	u64 prev_em_start = (u64)-1;
 
 	lock_extents_for_read(inode, start, end, &cached_state);
 
 	while ((folio = readahead_folio(rac)) != NULL)
-		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
+		btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 
 	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
-- 
2.50.1


