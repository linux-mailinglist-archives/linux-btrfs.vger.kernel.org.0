Return-Path: <linux-btrfs+bounces-20880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE5NA59ccWnLGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20880-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:09:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F455F4FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9A4943136
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057DF44CAF0;
	Wed, 21 Jan 2026 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rk851hBB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rk851hBB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CC3AE714
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036906; cv=none; b=L+KtXoIgSX80SeBE+d/zqhIy70/PjdVPcG1nfk7VPGdbvD3cKDQcL/XWmzMI4MvMtdn5RL63VLbZlO9UQchVzpbTFmuC0WNrqOpfM1XK4jlhTwvO//P6E2dN1JhguI3BrZ2TIiYH3QEdpftnqCZqoK63jkieLe0UaKP+YD9sni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036906; c=relaxed/simple;
	bh=fYf+KvdJfF4FDS9JkfWVAt80kTigr6wNxr2SWaOvoPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjHGOpzAklosL9ZoeVKnonXn9+vHWzb260XLdV0ixOW4wEf/1qT0vragPf0ITczTWErGgxF6pJOH3EMdXieH9iHGM/xLyDR9QdngCdUarPDYc5m91yuT43/ams+RLuciDxMmEWCXVJETpqUAz6oEH1bqLoVtZRL/ovOMjY1QHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rk851hBB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rk851hBB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 313B9336B5
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769036902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZV2aNIF2J4wk7Dqx18YVKtx7fdgTjGoqfB8Fa08PNc=;
	b=Rk851hBBU1nNu8XrO1N4jgjVFD5BaExGDKGTwWidguEX716RXRDaK8R35m7XY6XSZZbcwF
	fdP5ZDvhGt5E7CPLWA2zou0nL5WtnZdCLK0nj1Om5d5l/h5J1Kx+NcCVpH6Hp10Tm9z+2V
	ffk9tVBbMc0LNiX7W3bsviaa5T5eKys=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Rk851hBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769036902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZV2aNIF2J4wk7Dqx18YVKtx7fdgTjGoqfB8Fa08PNc=;
	b=Rk851hBBU1nNu8XrO1N4jgjVFD5BaExGDKGTwWidguEX716RXRDaK8R35m7XY6XSZZbcwF
	fdP5ZDvhGt5E7CPLWA2zou0nL5WtnZdCLK0nj1Om5d5l/h5J1Kx+NcCVpH6Hp10Tm9z+2V
	ffk9tVBbMc0LNiX7W3bsviaa5T5eKys=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2185F3EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wA78L2RccWkiXgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:08:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: tests: remove invalid file extent map tests
Date: Thu, 22 Jan 2026 09:37:58 +1030
Message-ID: <dccd74165d466dded99bff5e1eddc9286032e94b.1769036831.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769036831.git.wqu@suse.com>
References: <cover.1769036831.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20880-lists,linux-btrfs=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_ONE(0.00)[1];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 69F455F4FE
X-Rspamd-Action: no action

In the inode self tests, there are several problems:

- Invalid file extents

  E.g. hole range [4K, 4K + 4) is completely invalid.

  Only inlined extent maps can have an unaligned ram_bytes, and even for
  that case, the generated extent map will use sectorsize as em->len.

- Unaligned hole after inlined extent

  The kernel never does this by itself, the current btrfs_get_extent()
  will only return a single inlined extent map that covers the first
  block.

- Incorrect numbers in the comment

  E.g. 12291 no matter if you add or dec 1, is not aligned to 4K.
  The properly number for 12K is 12288, I don't know why there is even a
  diff of 3, and this completely doesn't match the extent map we
  inserted later.

- Hard-to-modify sequence in setup_file_extents()

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

- Remove the implied hole after an inlined extent

  Just like what the kernel is doing for inlined extents in the real
  world.

- Update the commit using proper numbers with 'K' suffixes

  Since there is no unaligned range except the first inlined one, we can
  always use numbers with 'K' suffixes, which is way more easier to read,
  and will always be aligned to 1024 at least.

- Add comments in setup_file_extents()

  So that we're clear about the file offset for each test file extent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/inode-tests.c | 96 ++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index a4c2b7748b95..077501b93215 100644
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
@@ -100,6 +103,8 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	u64 offset = 0;
 
 	/*
+	 * Start 0, length 6, inlined.
+	 *
 	 * Tree-checker has strict limits on inline extents that they can only
 	 * exist at file offset 0, thus we can only have one inline file extent
 	 * at most.
@@ -109,20 +114,18 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	slot++;
 	offset = sectorsize;
 
-	/* Now another hole */
-	insert_extent(root, offset, 4, 4, 0, 0, 0, BTRFS_FILE_EXTENT_REG, 0,
-		      slot);
+	/* Start 1 * blocksize, length 1 * blocksize, regular. */
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
+	/* We don't want the regular em merged with the next one. */
+	disk_bytenr += 2 * sectorsize;
+	offset += sectorsize;
 
 	/*
+	 * Start 2 * blocksize, length 1 * blocksize, regular.
+	 *
 	 * Now for 3 extents that were split from a hole punch so we test
 	 * offsets properly.
 	 */
@@ -130,10 +133,14 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 		      4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 3 * blocksize, length 1 * blocksize, regular, explicit hole. */
 	insert_extent(root, offset, sectorsize, sectorsize, 0, 0, 0,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 4 * blocksize, length 2 * blocksize, regular. */
 	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
 		      2 * sectorsize, disk_bytenr, 4 * sectorsize,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
@@ -141,7 +148,7 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 2 * sectorsize;
 	disk_bytenr += 4 * sectorsize;
 
-	/* Now for a unwritten prealloc extent */
+	/* Start 6 * blocksize, length 1 * blocksize, preallocated. */
 	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
 		sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
@@ -154,6 +161,8 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	disk_bytenr += 2 * sectorsize;
 
 	/*
+	 * Start 7 * blocksize, length 1 * blocksize, prealloc.
+	 *
 	 * Now for a partially written prealloc extent, basically the same as
 	 * the hole punch example above.  Ram_bytes never changes when you mark
 	 * extents written btw.
@@ -162,11 +171,15 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 		      4 * sectorsize, BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 8 * blocksize, length 1 * blocksize, regular. */
 	insert_extent(root, offset, sectorsize, 4 * sectorsize, sectorsize,
 		      disk_bytenr, 4 * sectorsize, BTRFS_FILE_EXTENT_REG, 0,
 		      slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 9 * blocksize, length 2 * blocksize, prealloc. */
 	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
 		      2 * sectorsize, disk_bytenr, 4 * sectorsize,
 		      BTRFS_FILE_EXTENT_PREALLOC, 0, slot);
@@ -174,7 +187,7 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 2 * sectorsize;
 	disk_bytenr += 4 * sectorsize;
 
-	/* Now a normal compressed extent */
+	/* Start 11 * blocksize, length 2 * blocksize, regular. */
 	insert_extent(root, offset, 2 * sectorsize, 2 * sectorsize, 0,
 		      disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG,
 		      BTRFS_COMPRESS_ZLIB, slot);
@@ -183,17 +196,21 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	/* No merges */
 	disk_bytenr += 2 * sectorsize;
 
-	/* Now a split compressed extent */
+	/* Start 13 * blocksize, length 1 * blocksize, regular. */
 	insert_extent(root, offset, sectorsize, 4 * sectorsize, 0, disk_bytenr,
 		      sectorsize, BTRFS_FILE_EXTENT_REG,
 		      BTRFS_COMPRESS_ZLIB, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 14 * blocksize, length 1 * blocksize, regular. */
 	insert_extent(root, offset, sectorsize, sectorsize, 0,
 		      disk_bytenr + sectorsize, sectorsize,
 		      BTRFS_FILE_EXTENT_REG, 0, slot);
 	slot++;
 	offset += sectorsize;
+
+	/* Start 15 * blocksize, length 2 * blocksize, regular. */
 	insert_extent(root, offset, 2 * sectorsize, 4 * sectorsize,
 		      2 * sectorsize, disk_bytenr, sectorsize,
 		      BTRFS_FILE_EXTENT_REG, BTRFS_COMPRESS_ZLIB, slot);
@@ -201,12 +218,19 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 	offset += 2 * sectorsize;
 	disk_bytenr += 2 * sectorsize;
 
-	/* Now extents that have a hole but no hole extent */
+	/* Start 17 * blocksize, length 1 * blocksize, regular. */
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
 	insert_extent(root, offset, sectorsize, sectorsize, 0, disk_bytenr,
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 }
@@ -316,28 +340,6 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
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
@@ -348,10 +350,10 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
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


