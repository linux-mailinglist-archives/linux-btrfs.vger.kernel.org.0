Return-Path: <linux-btrfs+bounces-11886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC7A47591
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5031888395
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE3215183;
	Thu, 27 Feb 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="scAg6+cq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="scAg6+cq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD151C5D6E
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635711; cv=none; b=OgTOt90aT56JJeTLdh1pFH67ZzyMyNLFSvwlp114+y7K+eIpUiDm4/iHdFDbaraWk5ZDXC5kY/gGKLcs15fVoRlFfZIs9NQ5L1z4DuLwEdbU6ffBVS+aSqKY3rDIhE7GzrA1Va03zgjAuUyCZaHENNXShOY3DeeUTUGsNjjBmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635711; c=relaxed/simple;
	bh=/04BNbArBbapAXCCktBtlwQ4Kh5BK7ZEGHU5cKZhsqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwdukFDS5Bg+FLtlbQ4jsU7S5p7KFs8Irm9YpQlu+nuxqQqH9MiRNzghNBIwsj6XaklgAb8uRwN8mKJSpTEx+mBGEseC9yUFSzpfBF4DC2zKMId4ZOvrChwkFuaaEUO6vs8kBbpwy3qNE+uaqxC1BNcdOD4MBtXYEN9mDgJBHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=scAg6+cq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=scAg6+cq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9E7F211A1;
	Thu, 27 Feb 2025 05:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9VXx+8Z0Gr4C5gvS+pAsmKOliEMdagUu53c2fSkmO4=;
	b=scAg6+cqFCfj9gIz43IohoiYNCQ+gqi2hEP5nOA9RWX1bu3PWoGHcqTmYWs49Rz+U8og2Y
	kERCatRIhQt2sNZX8MGDwGxX5nDdQ4RHOvaH6ppbJ7du3I4u8+ieasfuccFoTObhetiZFG
	+p4vWd3z2X9QmJgTuWh+HYRtDR3u9fA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=scAg6+cq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9VXx+8Z0Gr4C5gvS+pAsmKOliEMdagUu53c2fSkmO4=;
	b=scAg6+cqFCfj9gIz43IohoiYNCQ+gqi2hEP5nOA9RWX1bu3PWoGHcqTmYWs49Rz+U8og2Y
	kERCatRIhQt2sNZX8MGDwGxX5nDdQ4RHOvaH6ppbJ7du3I4u8+ieasfuccFoTObhetiZFG
	+p4vWd3z2X9QmJgTuWh+HYRtDR3u9fA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9BC81376A;
	Thu, 27 Feb 2025 05:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FuqIjn+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Feb 2025 05:55:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/8] btrfs: prevent inline data extents read from touching blocks beyond its range
Date: Thu, 27 Feb 2025 16:24:39 +1030
Message-ID: <da8a69b82144d6de4ca8c1ee99c33d2290480b78.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
References: <cover.1740635497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9E7F211A1
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently reading an inline data extent will zero out all the remaining
range in the page.

This is not yet causing problems even for block size < page size
(subpage) cases because:

1) An inline data extent always starts at file offset 0
   Meaning at page read, we always read the inline extent first, before
   any other blocks in the page. Then later blocks are properly read out
   and re-fill the zeroed out ranges.

2) Currently btrfs will read out the whole page if a buffered write is
   not page aligned
   So a page is either fully uptodate at buffered write time (covers the
   whole page), or we will read out the whole page first.
   Meaning there is nothing to lose for such an inline extent read.

But it's still not ideal:

- We're zeroing out the page twice
  One done by read_inline_extent()/uncompress_inline(), one done by
  btrfs_do_readpage() for ranges beyond i_size.

- We're touching blocks that doesn't belong to the inline extent
  In the incoming patches, we can have a partial uptodate folio, that
  some dirty blocks can exist while the page is not fully uptodate:

  The page size is 16K and block size is 4K:

  0         4K        8K        12K        16K
  |         |         |/////////|          |

  And range [8K, 12K) is dirtied by a buffered write, the remaining
  blocks are not uptodate.

  If range [0, 4K) contains an inline data extent, and we try to read
  the whole page, the current behavior will overwrite range [8K, 12K)
  with zero and cause data loss.

So to make the behavior more consistent and in preparation for future
changes, limit the inline data extents read to only zero out the range
inside the first block, not the whole page.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c432ccfba56e..f06b1c78c399 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6788,6 +6788,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 {
 	int ret;
 	struct extent_buffer *leaf = path->nodes[0];
+	const u32 sectorsize = leaf->fs_info->sectorsize;
 	char *tmp;
 	size_t max_size;
 	unsigned long inline_size;
@@ -6804,7 +6805,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
-	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
+	max_size = min_t(unsigned long, sectorsize, max_size);
 	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
 			       max_size);
 
@@ -6816,14 +6817,15 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size < PAGE_SIZE)
-		folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
+	if (max_size < sectorsize)
+		folio_zero_range(folio, max_size, sectorsize - max_size);
 	kfree(tmp);
 	return ret;
 }
 
 static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 {
+	const u32 sectorsize = path->nodes[0]->fs_info->sectorsize;
 	struct btrfs_file_extent_item *fi;
 	void *kaddr;
 	size_t copy_size;
@@ -6838,14 +6840,14 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
 		return uncompress_inline(path, folio, fi);
 
-	copy_size = min_t(u64, PAGE_SIZE,
+	copy_size = min_t(u64, sectorsize,
 			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
 	kaddr = kmap_local_folio(folio, 0);
 	read_extent_buffer(path->nodes[0], kaddr,
 			   btrfs_file_extent_inline_start(fi), copy_size);
 	kunmap_local(kaddr);
-	if (copy_size < PAGE_SIZE)
-		folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size);
+	if (copy_size < sectorsize)
+		folio_zero_range(folio, copy_size, sectorsize - copy_size);
 	return 0;
 }
 
-- 
2.48.1


