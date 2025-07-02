Return-Path: <linux-btrfs+bounces-15214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D0AF6414
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 23:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54A97B0107
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21923C516;
	Wed,  2 Jul 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kCpcJXZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4pcaiJp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D892DE705
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492184; cv=none; b=uwLXcj4SR7Ak16I3eFSz3gKbq7tQUzwc9ZF+L+hObk3RozVO9HBtJXT7ZJrywiBlpVflpjs5iqdA8J/cMgC9i0iRuExtVyTeZTWKRN5nVyzhXXqnwUs0DjAH/XoWYgvm+UDRFpxuE9UsiTF0cJJDdqgYg9gdbPbOdbiIkvqKaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492184; c=relaxed/simple;
	bh=5NrSDzRtakP3lG3UPUr73NpNVcYjLHNsth+4I0GoPZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPJCloiyXI4j6h2IS9JziRiHbdeklog75fx8//rkFvoLxbqfKZ5Xv2oYHjVJpsNHxId/MfUKDSr2DgSoTm8BXxGziAbznONUVy/3qfDjFECvynGmNO2rYYfIs+Ltlcp+jBU+qHLGqJNP3sEul/NlaNJmCzK12l/IfPAWts1db/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kCpcJXZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4pcaiJp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A18A14001CA;
	Wed,  2 Jul 2025 17:36:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 02 Jul 2025 17:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1751492181; x=1751578581; bh=IPFoMLlWVU2HrUQgk4vmo
	7l8O4bgPPGOVhLLPmeciXc=; b=kCpcJXZmMs2kYhkuD+1z/jZR+38qUyDM5mX6J
	nSbutLlmTRWQvENHc2ukt2LIKCVLKz7A44wZwva2lUi7nx5eojGjRwBqYrcEei4W
	xfG3Xsk2yj7ZpvF3FyXCx1fXZg3ll6fjJZqs9dEd1dV783NADpLlimw8wqpCQvGT
	vYYaoGE/G8a2uoxRx6+2aHlE8ocFeX2PBWOoUhwixEKjCwCQGbh8aPM9atXsF/O1
	ieHIsDlfmOBR03e7BMG6B2hAxN/TAkwCIo1o8wK9Rh7On6Y4Rw0hRiKZxU4QlAHO
	shJlEKOwn202MRskP3EKdERJz5bvA45jOKgTYBcKsDAH5EUsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751492181; x=1751578581; bh=IPFoMLlWVU2HrUQgk4vmo7l8O4bgPPGOVhL
	LPmeciXc=; b=J4pcaiJpIstPYUj9Yb3sq9F2k2kEzvFUy9PJZJkFG1SgeSJzn2r
	28+/1saCIhAdk8I3YR5RmfQnAhfEG6MOrobCjlOApKkNO8mGt6jTf1cMp+Q5oIpk
	ml3rGK/fvFBJ937I2oUNstj5YyR9qzvTzD5UT5kAsv5yw09HAPWESD/TzWwDMHst
	37/u8Vl/QhgmFiNGonEnHF556A58r0BhDppZjMYPIONmL7xNXNr7A/X5c/nZEhBm
	NZqzpAJB8w0USBCo5PIkmN28oYayqzon5dnTyo/Anw9YcnP7NgfGAPHY0n9Mw1JY
	4kUrVPgoBUG/CxmrwikXjCBgQUyzJ4PS+RA==
X-ME-Sender: <xms:VKZlaPzvpvNNeD4lktwdAFkSpeRg4LeD2q3vu2HmOuWw4gQ5BmxNjA>
    <xme:VKZlaHSy9sVwdb2w6ChcX9OThP7HRhj_oi27Jz-2zHdeg4mCdxgt7VfcO6wJ9bNe9
    DhH5nZchTifxEwQAQQ>
X-ME-Received: <xmr:VKZlaJWLrgDG9SuBCo3V94KfeIcONUMBMlMgqCQsyn1kvgsuiaEFMupd6xP7vsHmh9gA4c_EbzzWKMyLIH_bs11a2os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeeigeelheejleefieefieeuhfefgfevgfektdejhfeivdevte
    fgudeljeehieffgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrih
    hopdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehl
    ihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:VKZlaJi4-EMsHg6aKHlPOVAZdKSfcrENmGpFoJHgAn5jZJTizbRyNQ>
    <xmx:VKZlaBDtIp_Gz6ccm2h5-FFjxNRHAPDtmn0PcPS3o7LazXLbuc0lfQ>
    <xmx:VKZlaCLsgQ4118nOyKoqgoI7-CUVXmpEGgXo_KOyZYIHzBB9ijJZjw>
    <xmx:VKZlaACobYUiplvVG8-MFCnwrRsM04gVerkQP7wz5yllgGohEC14qQ>
    <xmx:VaZlaJ5GL9yXQOKoyZ6EVPxLhDYoKelwCLtM3ICC2XkET2WsVO025ups>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 17:36:20 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: willy@infradead.org,
	dhowells@redhat.com,
	hch@infradead.org
Subject: [PATCH v2] btrfs: use readahead_expand on compressed extents
Date: Wed,  2 Jul 2025 14:37:49 -0700
Message-ID: <656838ec1232314a2657716e59f4f15a8eadba64.1751492111.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently received a report of poor performance doing sequential
buffered reads of a file with compressed extents. With bs=128k, a naive
sequential dd ran as fast on a compressed file as on an uncompressed
(1.2GB/s on my reproducing system) while with bs<32k, this performance
tanked down to ~300MB/s.

i.e.,
slow:
dd if=some-compressed-file of=/dev/null bs=4k count=X
vs
fast:
dd if=some-compressed-file of=/dev/null bs=128k count=Y

The cause of this slowness is overhead to do with looking up extent_maps
to enable readahead pre-caching on compressed extents
(add_ra_bio_pages()), as well as some overhead in the generic VFS
readahead code we hit more in the slow case. Notably, the main
difference between the two read sizes is that in the large sized request
case, we call btrfs_readahead() relatively rarely while in the smaller
request we call it for every compressed extent. So the fast case stays
in the btrfs readahead loop:

while ((folio = readahead_folio(rac)) != NULL)
        btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);

where the slower one breaks out of that loop every time. This results in
calling add_ra_bio_pages a lot, doing lots of extent_map lookups,
extent_map locking, etc.

This happens because although add_ra_bio_pages() does add the
appropriate un-compressed file pages to the cache, it does not
communicate back to the ractl in any way. To solve this, we should be
using readahead_expand() to signal to readahead to expand the readahead
window.

This change passes the readahead_control into the btrfs_bio_ctrl and in
the case of compressed reads sets the expansion to the size of the
extent_map we already looked up anyway. It skips the subpage case as
that one already doesn't do add_ra_bio_pages().

With this change, whether we use bs=4k or bs=128k, btrfs expands the
readahead window up to the largest compressed extent we have seen so far
(in the trivial example: 128k) and the call stacks of the two modes look
identical. Notably, we barely call add_ra_bio_pages at all. And the
performance becomes identical as well. So this change certainly "fixes"
this performance problem.

Of course, it does seem to beg a few questions:
1. Will this waste too much page cache with a too large ra window?
2. Will this somehow cause bugs prevented by the more thoughtful
   checking in add_ra_bio_pages?
3. Should we delete add_ra_bio_pages?

My stabs at some answers:
1. Hard to say. See attempts at generic performance testing below. Is
   there a "readahead_shrink" we should be using? Should we expand more
   slowly, by half the remaining em size each time?
2. I don't think so. Since the new behavior is indistiguishable from
   reading the file with a larger read size passed in, I don't see why
   one would be safe but not the other.
3. Probably! I tested that and it was fine in fstests, and it seems like
   the pages would get re-used just as well in the readahead case.
   However, it is possible some reads that use page cache but not
   btrfs_readahead() could suffer. I will investigate this further as a
   follow up.

I tested the performance implications of this change in 3 ways (using
compress-force=zstd:3 for compression):

Directly test the affected workload of small sequential reads on a
compressed file (improved from ~250MB/s to ~1.2GB/s)

==========for-next==========
dd /mnt/lol/non-cmpr 4k
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.02983 s, 712 MB/s
dd /mnt/lol/non-cmpr 128k
32768+0 records in
32768+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 5.92403 s, 725 MB/s
dd /mnt/lol/cmpr 4k
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.8832 s, 240 MB/s
dd /mnt/lol/cmpr 128k
32768+0 records in
32768+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.71001 s, 1.2 GB/s

==========ra-expand==========
dd /mnt/lol/non-cmpr 4k
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.09001 s, 705 MB/s
dd /mnt/lol/non-cmpr 128k
32768+0 records in
32768+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.07664 s, 707 MB/s
dd /mnt/lol/cmpr 4k
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.79531 s, 1.1 GB/s
dd /mnt/lol/cmpr 128k
32768+0 records in
32768+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.69533 s, 1.2 GB/s

Built the linux kernel from clean (no change)

Ran fsperf. Mostly neutral results with some improvements and
regressions here and there.

Reported-by: Dimitrios Apostolou <jimis@gmx.net>
Link: https://lore.kernel.org/linux-btrfs/34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net/
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- added a comment about skipping non-compressed and subpage for now.
- fixed stray whitespace.
- fixed const on a few parameters and removed unhelpful extra parameters.
- used btrfs_is_subpage() and got rid of extra temporary variables.
- tested non-compressed extents; fixed a bug in btrfs_readahead_extent
  from those, but did not add any reasonable clamping, as we are still
  not calling it on non-compressed extents.

 fs/btrfs/extent_io.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b551e0641b0c..7ad4f10bb55a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -110,6 +110,7 @@ struct btrfs_bio_ctrl {
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
 	unsigned long submit_bitmap;
+	struct readahead_control *ractl;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -881,6 +882,25 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 
 	return em;
 }
+
+static void btrfs_readahead_expand(struct readahead_control *ractl,
+				   const struct extent_map *em)
+{
+	const u64 ra_pos = readahead_pos(ractl);
+	const u64 ra_end = ra_pos + readahead_length(ractl);
+	const u64 em_end = em->start + em->ram_bytes;
+
+	/* No expansion for holes and inline extents. */
+	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
+		return;
+
+	ASSERT(em_end >= ra_pos,
+	       "extent_map %llu %llu ends before current readahead position %llu",
+	       em->start, em->len, ra_pos);
+	if (em_end > ra_end)
+		readahead_expand(ractl, ra_pos, em_end - ra_pos);
+}
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
@@ -944,6 +964,16 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		compress_type = btrfs_extent_map_compression(em);
 
+		/*
+		 * Only expand readahead for extents which are already creating
+		 * the pages anyway in add_ra_bio_pages, which is compressed
+		 * extents in the non subpage case.
+		 */
+		if (bio_ctrl->ractl &&
+		    !btrfs_is_subpage(fs_info, folio) &&
+		    compress_type != BTRFS_COMPRESS_NONE)
+			btrfs_readahead_expand(bio_ctrl->ractl, em);
+
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -2540,7 +2570,10 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 
 void btrfs_readahead(struct readahead_control *rac)
 {
-	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ | REQ_RAHEAD,
+		.ractl = rac
+	};
 	struct folio *folio;
 	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
 	const u64 start = readahead_pos(rac);
-- 
2.49.0


