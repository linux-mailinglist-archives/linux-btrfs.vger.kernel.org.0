Return-Path: <linux-btrfs+bounces-20657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A14D392E6
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 06:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED8B3014AF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017517B425;
	Sun, 18 Jan 2026 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="twKkn6Bc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nj2PiuJP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCA500962
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768714229; cv=none; b=R3IorRJmfo5zaZKOps1BvOmdQhVGuQRSW4HCDU+Wl8/SesvAdnXXvu+EL1srh/SE5SI8eWdEAO6vR5VVIepm4qzyM0GZdMwFs658fY4tFmkcy9mEdQ7Kc2EfDy+RxK2KKJE8ZiE0haHy297aWbK8+N0xgJyOSe5lXqrRCLsvZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768714229; c=relaxed/simple;
	bh=vwBC6Ui5df1etxohZpokaqEEPedqrot/2mbvtVwVD1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwVpG3K7lmU8D62o2+RV9xRr3s8OS52tD2AhEWstVbRhZnkh2nuUQi1y6x/i963V4mPQmxr6J9qV4uYHlkxx7MR1iKWL87Pod/iUOL4UBtkPqbBIeS3a3pavcSpNUbMRTRrvKtnibIbZZ4Ga38iPMjej+7yTMka8OHABk+STMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=twKkn6Bc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nj2PiuJP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FA3233682
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=770V+1DEYHIvtGixc8HfEZS22GKcwwaoEEjJqe4JRzg=;
	b=twKkn6BcyQjgqo0qDmGuLGZBsiRWm/n9Sl9bMYWDBMM3EasZj7dDh+2HMTgcw8kdbEeS7M
	34e2bEOyg+/Ut+8157hsLHRdSmnZUwFCBopMO8prVmm+N0KAvCxSVvnExM9wk3KsdDXSVU
	fyKGBzoN2pFKYyzd7jZRJHoOe6sB4/M=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nj2PiuJP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=770V+1DEYHIvtGixc8HfEZS22GKcwwaoEEjJqe4JRzg=;
	b=nj2PiuJPU9xO10DIDLBkIH+3XvJI7GmIjjiYsN4cDQBfwV0LzBnG6/dTvMHuKxiLf/AmkF
	zdDiFcCmHLzUX3Hw8+75ZbpPHC5qB/JFyGonFKrxZy1XYifgrcV3+2cb8hsgGC8FMZTJll
	/i0e17xGP/Qz/QdZ1HbB2eDtKYBiVIY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87C623EA63
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOc0DfBvbGnScQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: tests: remove invalid file extent map tests
Date: Sun, 18 Jan 2026 15:59:58 +1030
Message-ID: <86b8394ca75b3e8ac35b08e8ee8b4617d5f44331.1768714131.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768714131.git.wqu@suse.com>
References: <cover.1768714131.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 8FA3233682
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

In the inode self tests, there are several problems:

- Several invalid cases that will be rejected by tree-checkers
  E.g. hole range [4K, 4K + 4) is completely invalid.

  Only inlined extent maps can have an unaligned ram_bytes, and even for
  that case, the generaeted extent map will use sectorsize as em->len.

- Manually inserted hole after an inlined extent map
  The kernel never does this by itself, the current btrfs_get_extent()
  will only return a single inlined extent map that covers the first
  block.

- Completely incorrect numbers in the comment
  E.g. 12291 no matter if you add or dec 1, is not aligned to 4K.
  The properly number for 12K is 12288, I don't know why there is even a
  diff of 3, and this completely doesn't match the extent map we
  inserted later.

- Super hard to modify sequence in setup_file_extents()
  If some unfortunate person, just like me, needs to modify
  setup_file_extents(), good luck not screwing up the file offset.

Fix them by:

- Remove invalid unaligned extent maps
  This mostly means remove the [4K, 4K + 4) hole case.
  The remaining ones are already properly aligned.

  This slightly changes the on-disk data extent allocation, with that
  removed, the regular extents at [4K, 8K) and [8K , 12K) can be merged.

  So also add a 4K gap between those two data extents to prevent em
  merge.

- Remove the manual insert of the implied hole after an inlined extent
  Just like what the kernel is doning for inlined extents in the real
  world.

- Update the commit using proper numbers with Kilo suffix
  Since there is no unaligned range except the first inlined one, we can
  always use numbers with 'K' suffix, which is way more easier to read,
  and will always be aligned to 1024 at least.

- Add extra ASSERT()s and comments in setup_file_extents()
  The ASSERT()s are used to indicate the current file offset.
  The extra comments are for the basic info of the file extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/inode-tests.c | 111 ++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index a4c2b7748b95..58b75bdfed9e 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -81,17 +81,20 @@ static void insert_inode_item_key(struct btrfs_root *root)
  * diagram of how the extents will look though this may not be possible we still
  * want to make sure everything acts normally (the last number is not inclusive)
  *
- * [0  - 6][     6 - 4096     ][ 4096 - 4100][4100 - 8195][8195  -  12291]
- * [inline][hole but no extent][    hole    ][   regular ][regular1 split]
+ * The numbers are using 4K fs block size as an example, the real test will scale
+ * all the extent maps (except the inlined one) according to the block size.
  *
- * [12291 - 16387][16387 - 24579][24579 - 28675][ 28675 - 32771][32771 - 36867 ]
- * [    hole    ][regular1 split][   prealloc ][   prealloc1  ][prealloc1 written]
+ * [ 0  - 6 ][ 6 - 4K       ][ 4K - 8K ][ 8K -  12K      ]
+ * [ inline ][ implied hole ][ regular ][ regular1 split ]
  *
- * [36867 - 45059][45059 - 53251][53251 - 57347][57347 - 61443][61443- 69635]
- * [  prealloc1  ][ compressed  ][ compressed1 ][    regular  ][ compressed1]
+ * [ 12K - 16K ][ 16K - 24K      ][ 24K - 28K ][ 28K - 32K ][ 32K - 36K         ]
+ * [ hole      ][ regular1 split ][ prealloc  ][ prealloc1 ][ prealloc1 written ]
  *
- * [69635-73731][   73731 - 86019   ][86019-90115]
- * [  regular  ][ hole but no extent][  regular  ]
+ * [ 36K - 44K ][ 44K - 52K  ][ 52K - 56K   ][ 56K - 60K ][ 60K - 68 K  ]
+ * [ prealloc1 ][ compressed ][ compressed1 ][ regular   ][ compressed1 ]
+ *
+ * [ 68K - 72K ][ 72K - 84K          ][ 84K - 88K ]
+ * [  regular  ][ hole but no extent ][ regular   ]
  */
 static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 {
@@ -100,40 +103,49 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	u64 offset = 0;
 
 	/*
+	 * Start 0, length 6, inlined.
+	 *
 	 * Tree-checker has strict limits on inline extents that they can only
 	 * exist at file offset 0, thus we can only have one inline file extent
 	 * at most.
 	 */
+	ASSERT(offset == 0);
 	insert_extent(root, offset, 6, 6, 0, 0, 0, BTRFS_FILE_EXTENT_INLINE, 0,
 		      slot);
 	slot++;
 	offset = sectorsize;
 
-	/* Now another hole */
-	insert_extent(root, offset, 4, 4, 0, 0, 0, BTRFS_FILE_EXTENT_REG, 0,
-		      slot);
+	/* Start 1 * blocksize, length 1 * blocksize, regular */
+	ASSERT(offset == 1 * sectorsize);
+	insert_extent(root, offset, sectorsize, sectorsize, 0,
+		      disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
-	offset += 4;
 
-	/* Now for a regular extent */
-	insert_extent(root, offset, sectorsize - 1, sectorsize - 1, 0,
-		      disk_bytenr, sectorsize - 1, BTRFS_FILE_EXTENT_REG, 0, slot);
-	slot++;
-	disk_bytenr += sectorsize;
-	offset += sectorsize - 1;
+	/* We don't want the regular em got merged with the next one. */
+	disk_bytenr += 2 * sectorsize;
+	offset += sectorsize;
 
 	/*
+	 * Start 2 * blocksize, length 1 * blocksize, regular.
+	 *
 	 * Now for 3 extents that were split from a hole punch so we test
 	 * offsets properly.
 	 */
+	ASSERT(offset == 2 * sectorsize);
 	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
 		      4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 3 * blocksize, length 1 * blocksize, regular, explicit hole. */
+	ASSERT(offset == 3 * sectorsize);
 	insert_extent(root, offset, sectorsize, sectorsize, 0, 0, 0,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 4 * blocksize, length 2 * blocksize, regular. */
+	ASSERT(offset == 4 * sectorsize);
 	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
 		      2 * sectorsize, disk_bytenr, 4 * sectorsize,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
@@ -141,7 +153,8 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 2 * sectorsize;
 	disk_bytenr += 4 * sectorsize;
 
-	/* Now for a unwritten prealloc extent */
+	/* Start 6 * blocksize, length 1 * blocksize, preallocated. */
+	ASSERT(offset == 6 * sectorsize);
 	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
 		sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
@@ -154,19 +167,28 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	disk_bytenr += 2 * sectorsize;
 
 	/*
+	 * Start 7 * blocksize, length 1 * blocksize, prealloc.
+	 *
 	 * Now for a partially written prealloc extent, basically the same as
 	 * the hole punch example above.  Ram_bytes never changes when you mark
 	 * extents written btw.
 	 */
+	ASSERT(offset == 7 * sectorsize);
 	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
 		      4 * sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 8 * blocksize, length 1 * blocksize, regular. */
+	ASSERT(offset == 8 * sectorsize);
 	insert_extent(root, offset, sectorsize, 4 * sectorsize, sectorsize,
 		      disk_bytenr, 4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0,
 		      slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 9 * blocksize, length 2 * blocksize, prealloc. */
+	ASSERT(offset == 9 * sectorsize);
 	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
 		      2 * sectorsize, disk_bytenr, 4 * sectorsize,
 		      BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
@@ -174,7 +196,8 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 2 * sectorsize;
 	disk_bytenr += 4 * sectorsize;
 
-	/* Now a normal compressed extent */
+	/* Start 11 * blocksize, length 2 * blocksize, regular . */
+	ASSERT(offset == 11 * sectorsize);
 	insert_extent(root, offset, 2 * sectorsize, 2 * sectorsize, 0,
 		      disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG,
 		      BTRFS_COMPRESS_ZLIB, slot);
@@ -183,17 +206,24 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	/* No merges */
 	disk_bytenr += 2 * sectorsize;
 
-	/* Now a split compressed extent */
+	/* Start 13 * blocksize, length 1 * blocksize, regular. */
+	ASSERT(offset == 13 * sectorsize);
 	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
 		      sectorsize, BTRFS_FILE_EXTENT_REG,
 		      BTRFS_COMPRESS_ZLIB, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 14 * blocksize, length 1 * blocksize, regular. */
+	ASSERT(offset == 14 * sectorsize);
 	insert_extent(root, offset, sectorsize, sectorsize, 0,
 		      disk_bytenr + sectorsize, sectorsize,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 15 * blocksize, length 2 * blocksize, regular. */
+	ASSERT(offset == 15 * sectorsize);
 	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
 		      2 * sectorsize, disk_bytenr, sectorsize,
 		      BTRFS_FILE_EXTENT_REG, BTRFS_COMPRESS_ZLIB, slot);
@@ -201,12 +231,21 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 2 * sectorsize;
 	disk_bytenr += 2 * sectorsize;
 
-	/* Now extents that have a hole but no hole extent */
+	/* Start 17 * blocksize, length 1 * blocksize, regular. */
+	ASSERT(offset == 17 * sectorsize);
 	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += 4 * sectorsize;
 	disk_bytenr += sectorsize;
+
+	/*
+	 * Start 18 * blocksize, length 3 * blocksize, implied hole (aka no
+	 * file extent item).
+	 *
+	 * Start 21 * blocksize, length 1 * blocksize, regular.
+	 */
+	ASSERT(offset == 21 * sectorsize);
 	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 }
@@ -316,28 +355,6 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	btrfs_free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
-	if (IS_ERR(em)) {
-		test_err("got an error when we shouldn't have");
-		goto out;
-	}
-	if (em->disk_bytenr != EXTENT_MAP_HOLE) {
-		test_err("expected a hole, got %llu", em->disk_bytenr);
-		goto out;
-	}
-	if (em->start != offset || em->len != 4) {
-		test_err(
-	"unexpected extent wanted start %llu len 4, got start %llu len %llu",
-			offset, em->start, em->len);
-		goto out;
-	}
-	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %u", em->flags);
-		goto out;
-	}
-	offset = em->start + em->len;
-	btrfs_free_extent_map(em);
-
 	/* Regular extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -348,10 +365,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a real extent, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	if (em->start != offset || em->len != sectorsize - 1) {
+	if (em->start != offset || em->len != sectorsize) {
 		test_err(
-	"unexpected extent wanted start %llu len 4095, got start %llu len %llu",
-			offset, em->start, em->len);
+	"unexpected extent wanted start %llu len %u, got start %llu len %llu",
+			offset, sectorsize, em->start, em->len);
 		goto out;
 	}
 	if (em->flags != 0) {
-- 
2.52.0


