Return-Path: <linux-btrfs+bounces-16168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C26B2D3AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 07:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7A1682F2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 05:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59C29E0FF;
	Wed, 20 Aug 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fKOhj2dy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fKOhj2dy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530DF29ACFC
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668295; cv=none; b=itXvl29zrCEOXZDjimeL0Vw9VT1byaS4r88jY3fDPh88BlEuGU79x4EK9QmZdlHwXFadgQifMysEXPRynse/exszeb0pzyTdCoBQfnHY6EjIgTCVv9//d+yF8ahn66Hk7e2vItyIReOMYhBJeKjSvLiSuW6PrKHWEIxm+YVatys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668295; c=relaxed/simple;
	bh=vefMlG5mtavPcz86Ykny1PxLPWujEXZcusuFNcixVjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s6EBHIJyoGXbmfx2uS0wog0CPgaRoIk64tFPfEK6mvSecN+4sFBusRZ9/Z/15x+vYCXppLntfDPSQb3Ot8bwGjPNpMcfRuHutdWWgS0GCvW2Gp33JTiP0ml4DyTppGO4pQlknhVW7/YxP8ztN39pT7ne8PT3ygjCJ+inYx768/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fKOhj2dy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fKOhj2dy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F4182126F
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 05:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755668291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v+IRlg5I/Wv3wKD9p/Xng17q77HoaJPN6DN9G56aO70=;
	b=fKOhj2dy744vUnupoGjCsR+MJulfBCYEJsoYBJJWCE28QPr3cLhXhFdPEN0xWGCjNUu072
	IBus19l4bXzoX3jMSH9NOkM0EjKFd2FEV/e0NhRnH1zsE4T54JDaN5mMDCAgLxFu/85pZm
	N4Y2ZEi1fsoF8N4bG3J/bGK0qCu36tc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fKOhj2dy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755668291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v+IRlg5I/Wv3wKD9p/Xng17q77HoaJPN6DN9G56aO70=;
	b=fKOhj2dy744vUnupoGjCsR+MJulfBCYEJsoYBJJWCE28QPr3cLhXhFdPEN0xWGCjNUu072
	IBus19l4bXzoX3jMSH9NOkM0EjKFd2FEV/e0NhRnH1zsE4T54JDaN5mMDCAgLxFu/85pZm
	N4Y2ZEi1fsoF8N4bG3J/bGK0qCu36tc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B286F1378C
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 05:38:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L5Y+HEJfpWgXOAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 05:38:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: extract the compressed folio padding into a helper
Date: Wed, 20 Aug 2025 15:07:44 +0930
Message-ID: <e8da4be87bbe97624e9f025b92e7a5265073b519.1755668227.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7F4182126F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

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

- Exit early if the compressed data already reaches the original size

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
 fs/btrfs/compression.c | 50 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/inode.c       |  8 -------
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3291d1ff2722..96af260533cd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1024,6 +1024,50 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 	return 0;
 }
 
+/*
+ * Fill the range between (total_out, round_up(total_out, blocksize)) with zero.
+ *
+ * If bs > ps, also allocate extra folios to ensure the compressed folios are aligned
+ * to block size.
+ */
+static int pad_compressed_folios(struct btrfs_fs_info *fs_info, struct folio **folios,
+				 unsigned long max_folios,  unsigned long *out_folios,
+				 unsigned long *total_out)
+{
+	const unsigned long aligned_nr_folios = round_up(*total_out, fs_info->sectorsize) >>
+						PAGE_SHIFT;
+
+	ASSERT(aligned_nr_folios <= BTRFS_MAX_COMPRESSED_PAGES);
+	ASSERT(*out_folios == DIV_ROUND_UP_POW2(*total_out, PAGE_SIZE),
+	       "out_folios=%lu total_out=%lu", *out_folios, *total_out);
+
+	/*
+	 * Already reached the max compressed size. This saves no on-disk space,
+	 * Fallback to non-compressed write.
+	 */
+	if (aligned_nr_folios == max_folios)
+		return -E2BIG;
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
@@ -1033,7 +1077,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
  * - compression algo are 0-3
  * - the level are bits 4-7
  *
- * @out_pages is an in/out parameter, holds maximum number of pages to allocate
+ * @out_folios is an in/out parameter, holds maximum number of pages to allocate
  * and returns number of actually allocated pages
  *
  * @total_in is used to return the number of bytes actually read.  It
@@ -1051,6 +1095,7 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const unsigned long orig_len = *total_out;
 	struct list_head *workspace;
+	unsigned long orig_nr_folios = *out_folios;
 	int ret;
 
 	level = btrfs_compress_set_level(type, level);
@@ -1060,6 +1105,9 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
 	/* The total read-in bytes should be no larger than the input. */
 	ASSERT(*total_in <= orig_len);
 	put_workspace(fs_info, type, workspace);
+	if (ret < 0)
+		return ret;
+	ret = pad_compressed_folios(fs_info, folios, orig_nr_folios, out_folios, total_out);
 	return ret;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0161e1aee96f..66b7323ba0db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -964,14 +964,6 @@ static void compress_file_range(struct btrfs_work *work)
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


