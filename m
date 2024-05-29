Return-Path: <linux-btrfs+bounces-5348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19298D2E4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7959D289288
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE9216728D;
	Wed, 29 May 2024 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fuUq7r2u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fuUq7r2u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144021E86E
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968051; cv=none; b=aW31TAmyGhcwUY8Tm/5XVv86Hzm1/5EFo8QWF5LZ2p4e4EAXN+/Ibx+RRsanB0/iwmrh4DxJXwIpf60zE6nAPKwocpTHGysJQn/U4RSs9/Qnrtbnq8M/SEG+X48tDjgLVkpsW88RwQBJDa2T99nUc4bvZoIbrEnEtj1FNoANVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968051; c=relaxed/simple;
	bh=GJUQBgq1ofEmdP5KaAasfFYji40GxJi0T8KzRL6ooD8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pLg1iFqSc7ze7JyXBuQJ5DQx7cGmrLBcRBNWZAdBKTUAKjmCbQtvynAEHhHIpRsYkH3rXkhmwB7RTvNJ/PT+8prBrxCOkIVA0sU3AKsDRIGwHCqvKLtqYx7uORhKsi/G6qgA/27NKUJV1kxc2K+B9fPGfADmojajDA8M2jA5c0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fuUq7r2u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fuUq7r2u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DD3D226BC
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716968046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bd2j4UOq2GFB7ZyD1Jt0SMLZSCV+0SK21hDdO2zbcgQ=;
	b=fuUq7r2u0N+7QxxIzfGjSjiK23seIU6ZfmHBH4NlxXe9cKY/fF5qPMSl+AOqgx5+XilNwD
	PWeMb0wUJbNzfq9tUWTnTgpCnnpFogzPYqxvVGMltxmfRoy+SIjirsiHH5SXvyB9oztqks
	rtpaKsxLcO6nf2uJYvcEiaLBLSKvaME=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716968046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Bd2j4UOq2GFB7ZyD1Jt0SMLZSCV+0SK21hDdO2zbcgQ=;
	b=fuUq7r2u0N+7QxxIzfGjSjiK23seIU6ZfmHBH4NlxXe9cKY/fF5qPMSl+AOqgx5+XilNwD
	PWeMb0wUJbNzfq9tUWTnTgpCnnpFogzPYqxvVGMltxmfRoy+SIjirsiHH5SXvyB9oztqks
	rtpaKsxLcO6nf2uJYvcEiaLBLSKvaME=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63D9613A6B
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MSYxCG3aVmb2UQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:34:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make compression path to be subpage compatible
Date: Wed, 29 May 2024 17:03:47 +0930
Message-ID: <a7b314bce317235918c3604e3a8def34122bd4e6.1716960005.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently btrfs compression path is not really subpage compatible, every
thing is still done in page unit.

That's fine for regular sector size and subpage routine. As even for
subpage routine compression is only enabled if the whole range is page
aligned, so reading the page cache in page unit is totally fine.

However in preparation for the future subpage perfect compression
support, we need to change the compression routine to properly handle a
subpage range.

This patch would prepare both zlib and zstd to only read the subpage
range for compression.
Lzo is already doing subpage aware read, as lzo's on-disk format is
already sectorsize dependent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.h |  8 ++++++++
 fs/btrfs/zlib.c        | 20 +++++++++++++++++---
 fs/btrfs/zstd.c        | 19 +++++++++++++------
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index c20c1a1b09d5..2787935b153b 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -82,6 +82,14 @@ static inline unsigned int btrfs_compress_level(unsigned int type_level)
 	return ((type_level & 0xF0) >> 4);
 }
 
+/* @range_end must be exclusive. */
+static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
+{
+	u64 page_end = round_down(cur, PAGE_SIZE) + PAGE_SIZE;
+
+	return min(range_end, page_end) - cur;
+}
+
 int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d9e5c88a0f85..0542872b1c1d 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -19,6 +19,9 @@
 #include <linux/bio.h>
 #include <linux/refcount.h>
 #include "compression.h"
+#include "btrfs_inode.h"
+#include "fs.h"
+#include "subpage.h"
 
 /* workspace buffer size for s390 zlib hardware support */
 #define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
@@ -107,6 +110,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
 	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
+	const u64 orig_end = start + len;
 
 	*out_folios = 0;
 	*total_out = 0;
@@ -147,6 +151,10 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 			if (in_buf_folios > 1) {
 				int i;
 
+				/* S390 hardware acceleration path, not subpage. */
+				ASSERT(!btrfs_is_subpage(
+						inode_to_fs_info(mapping->host),
+						mapping));
 				for (i = 0; i < in_buf_folios; i++) {
 					if (data_in) {
 						kunmap_local(data_in);
@@ -161,9 +169,14 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 					copy_page(workspace->buf + i * PAGE_SIZE,
 						  data_in);
 					start += PAGE_SIZE;
+					workspace->strm.avail_in =
+						in_buf_folios << PAGE_SHIFT;
 				}
 				workspace->strm.next_in = workspace->buf;
 			} else {
+				unsigned int pg_off;
+				unsigned int cur_len;
+
 				if (data_in) {
 					kunmap_local(data_in);
 					folio_put(in_folio);
@@ -173,12 +186,13 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 						start, &in_folio);
 				if (ret < 0)
 					goto out;
-				data_in = kmap_local_folio(in_folio, 0);
+				pg_off = offset_in_page(start);
+				cur_len = btrfs_calc_input_length(orig_end, start);
+				data_in = kmap_local_folio(in_folio, pg_off);
 				start += PAGE_SIZE;
 				workspace->strm.next_in = data_in;
+				workspace->strm.avail_in = cur_len;
 			}
-			workspace->strm.avail_in = min(bytes_left,
-						       (unsigned long) workspace->buf_size);
 		}
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 2b232b82c3a8..b1547ce8dad7 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -388,7 +388,10 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	unsigned long tot_out = 0;
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_folios = *out_folios;
+	const u64 orig_end = start + len;
 	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
+	unsigned int pg_off;
+	unsigned int cur_len;
 	zstd_parameters params = zstd_get_btrfs_parameters(workspace->req_level,
 							   len);
 
@@ -409,9 +412,11 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 	if (ret < 0)
 		goto out;
-	workspace->in_buf.src = kmap_local_folio(in_folio, 0);
+	pg_off = offset_in_page(start);
+	cur_len = btrfs_calc_input_length(orig_end, start);
+	workspace->in_buf.src = kmap_local_folio(in_folio, pg_off);
 	workspace->in_buf.pos = 0;
-	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
+	workspace->in_buf.size = cur_len;
 
 	/* Allocate and map in the output buffer */
 	out_folio = btrfs_alloc_compr_folio();
@@ -483,14 +488,16 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 			kunmap_local(workspace->in_buf.src);
 			workspace->in_buf.src = NULL;
 			folio_put(in_folio);
-			start += PAGE_SIZE;
-			len -= PAGE_SIZE;
+			start += cur_len;
+			len -= cur_len;
 			ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 			if (ret < 0)
 				goto out;
-			workspace->in_buf.src = kmap_local_folio(in_folio, 0);
+			pg_off = offset_in_page(start);
+			cur_len = btrfs_calc_input_length(orig_end, start);
+			workspace->in_buf.src = kmap_local_folio(in_folio, pg_off);
 			workspace->in_buf.pos = 0;
-			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
+			workspace->in_buf.size = cur_len;
 		}
 	}
 	while (1) {
-- 
2.45.1


