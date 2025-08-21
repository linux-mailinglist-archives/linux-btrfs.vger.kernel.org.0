Return-Path: <linux-btrfs+bounces-16186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE312B2ED9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 07:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89BD7B20CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEB221540;
	Thu, 21 Aug 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VRGOVpEh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VRGOVpEh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CD17BA3
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754287; cv=none; b=c6tVzSqR15kk6/Vw78zV4Hy9u/UrcKCVvvhyhatCYbucvlFkoyX/y44iSaskgagZHBU4hhOIVCXQ9Whm+v9+mklwoTwK51BhSWQFXj9lAxRtXrD83IiFr1nKh0+/Al30P9ei+SpbY41DKSzhTCO17td/bFzSsyn+rRX5wOwKg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754287; c=relaxed/simple;
	bh=G0TgvKvsJg/KBwQd2k+V+DCCAdNsKtINo2k/YDc/m00=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=shNAVGPxdUe9ngY8e8Rm+fIrNMK88rycMVDJt2WOnpPory2v2W4z4v3lP+9TI0iuq/0jQ8xjG/nAEOb8MhdYtStleHpuMVj9Q81xkCfb21i5/JF684N/a26U48sMMOhYLSVkaa5llzbn5U8P/8zbQ0Wo83K0laGeyTJpgLPzm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VRGOVpEh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VRGOVpEh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF49C222A7
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755754276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mT0J4XQcq7E+1uDa2goS3QzE+4Y53954umSXHG5km4o=;
	b=VRGOVpEh2GiCrMdHuLgTLmgbt0t/RtbnfRMSjP3zCmJi+DERmw/TaqLVwRkCuFRFwRnJ+o
	c3sNzoXbRFXE3kf0BDDnV/yj2z3zVrUsVrW62jwRTPcnghtnBYL2buSZUzyYONyeCliRYa
	vYqQR7/uyeFp7btt2GsafYWIQ5NPIQw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755754276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mT0J4XQcq7E+1uDa2goS3QzE+4Y53954umSXHG5km4o=;
	b=VRGOVpEh2GiCrMdHuLgTLmgbt0t/RtbnfRMSjP3zCmJi+DERmw/TaqLVwRkCuFRFwRnJ+o
	c3sNzoXbRFXE3kf0BDDnV/yj2z3zVrUsVrW62jwRTPcnghtnBYL2buSZUzyYONyeCliRYa
	vYqQR7/uyeFp7btt2GsafYWIQ5NPIQw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0727313867
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 05:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p47ULiOvpmjuZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 05:31:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v3] btrfs: extract the compressed folio padding into a helper
Date: Thu, 21 Aug 2025 15:00:54 +0930
Message-ID: <81ac4ae4bab2538df93f045ac1094d3568ff8e9e.1755754005.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Currently after btrfs_compress_folios(), we zero the tail folio at
compress_file_range() after the btrfs_compress_folios() call.

However there are several problems with the incoming block size > page
size support:

- We may need extra padding folios for the compressed data
  Or we will submit a write smaller than the block size.

- The current folio tail zeroing is not covering extra padding folios

Solve this problem by introducing a dedicated helper,
pad_compressed_folios(), which will:

- Do extra basic sanity checks
  Focusing on the @out_folios and @total_out values.

- Zero the tailing folio
  Now we don't need to tail zeroing inside compress_file_range()
  anymore.

- Add extra padding zero folios
  So that for bs > ps cases, the compressed data will always be bs
  aligned.

  This also implies we won't allocate dedicated large folios for
  compressed data.

Finally since we're here, update the stale comments about
btrfs_compress_folios().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
RFC v2->RFC v3:
- Fix a failure related to inline compressed data (btrfs/246 failure)
  The check on whether the resulted compressed data should not happen
  until we're sure no inlined extent is going to be created.

RFC v1->RFC v2:
- Fix a check causes more strict condition for subpage cases
  Instead comparing the resulted compressed folios number, compare the
  resulted blocks number instead.
  For 64K page sized system with 4K block size, it will result any
  compressed data larger than 64K to be rejected.
  Even if the compression caused a pretty good result, e.g. 128K ->68K.

- Remove an unused local variable

Reason for RFC:

Although this seems to be a preparation patch for bs > ps support, this
one will determine the path we go for compressed folios.

There are 2 methods I can come up with:

- Allocate dedicated large folios following min_order for compressed
  folios
  This is the more common method, used by filemap and will be the method
  for page cache.

  The problem is, we will no longer share the compr_pool across all
  btrfs filesystems, and the dedicated per-fs pool will have a much
  harder time to fill its pool when memory is fragmented or
  under-pressure.

  The benefit is obvious, we will have the insurance that every folio
  will contain at least one block for bs > ps cases.

- Allocate page sized folios but add extra padding folios for compressed
  folios
  The method I take in this patchset.

  The benefit is we can still use the shared compr folios pool, meaning
  a better latency filling the pool.

  The problem is we must manually pad the compressed folios.
  Thankfully the compressed folios are not filemap ones, we don't need
  to bother about the folio flags at all.

  Another problem is, we will have different handling for filemap and
  compressed folios.
  Filemap folios will have the min_order insurance, but not for
  compressed folios.
  I believe the inconsistency is still manageable, at least for now.

Thus I leave this one as RFC, any feedback will be appreciated.
---
 fs/btrfs/compression.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/inode.c       |  9 ---------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3291d1ff2722..9cd9182684f3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1024,6 +1024,43 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 	return 0;
 }
 
+/*
+ * Fill the range between (total_out, round_up(total_out, blocksize)) with zero.
+ *
+ * If bs > ps, also allocate extra folios to ensure the compressed folios are aligned
+ * to block size.
+ */
+static int pad_compressed_folios(struct btrfs_fs_info *fs_info, struct folio **folios,
+				 unsigned long orig_len,  unsigned long *out_folios,
+				 unsigned long *total_out)
+{
+	const unsigned long aligned_len = round_up(*total_out, fs_info->sectorsize);
+	const unsigned long aligned_nr_folios = aligned_len >> PAGE_SHIFT;
+
+	ASSERT(aligned_nr_folios <= BTRFS_MAX_COMPRESSED_PAGES);
+	ASSERT(*out_folios == DIV_ROUND_UP_POW2(*total_out, PAGE_SIZE),
+	       "out_folios=%lu total_out=%lu", *out_folios, *total_out);
+
+	/* Zero the tailing part of the compressed folio. */
+	if (!IS_ALIGNED(*total_out, PAGE_SIZE))
+		folio_zero_range(folios[*total_out >> PAGE_SHIFT], offset_in_page(*total_out),
+				PAGE_SIZE - offset_in_page(*total_out));
+
+	/* Padding the compressed folios to blocksize. */
+	for (unsigned long cur = *out_folios; cur < aligned_nr_folios; cur++) {
+		struct folio *folio;
+
+		ASSERT(folios[cur] == NULL);
+		folio = btrfs_alloc_compr_folio();
+		if (!folio)
+			return -ENOMEM;
+		folios[cur] = folio;
+		folio_zero_range(folio, 0, PAGE_SIZE);
+		(*out_folios)++;
+	}
+	return 0;
+}
+
 /*
  * Given an address space and start and length, compress the bytes into @pages
  * that are allocated on demand.
@@ -1033,7 +1070,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
  * - compression algo are 0-3
  * - the level are bits 4-7
  *
- * @out_pages is an in/out parameter, holds maximum number of pages to allocate
+ * @out_folios is an in/out parameter, holds maximum number of pages to allocate
  * and returns number of actually allocated pages
  *
  * @total_in is used to return the number of bytes actually read.  It
@@ -1060,6 +1097,9 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
 	/* The total read-in bytes should be no larger than the input. */
 	ASSERT(*total_in <= orig_len);
 	put_workspace(fs_info, type, workspace);
+	if (ret < 0)
+		return ret;
+	ret = pad_compressed_folios(fs_info, folios, orig_len, out_folios, total_out);
 	return ret;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0161e1aee96f..b04f48af721a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -864,7 +864,6 @@ static void compress_file_range(struct btrfs_work *work)
 	unsigned long nr_folios;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
-	unsigned int poff;
 	int i;
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
@@ -964,14 +963,6 @@ static void compress_file_range(struct btrfs_work *work)
 	if (ret)
 		goto mark_incompressible;
 
-	/*
-	 * Zero the tail end of the last page, as we might be sending it down
-	 * to disk.
-	 */
-	poff = offset_in_page(total_compressed);
-	if (poff)
-		folio_zero_range(folios[nr_folios - 1], poff, PAGE_SIZE - poff);
-
 	/*
 	 * Try to create an inline extent.
 	 *
-- 
2.50.1


