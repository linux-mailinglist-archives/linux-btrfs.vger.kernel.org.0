Return-Path: <linux-btrfs+bounces-11965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C211A4B977
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73297A7893
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2A1EDA09;
	Mon,  3 Mar 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aZVtpv1w";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aZVtpv1w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857E1EC011
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990959; cv=none; b=eHCmwuQL/ldT6iytCBBu7lRgZKZ+lmdhKsL1Rq8kIE4oVbcGNnVyTJG/RCqiHJRo4eSeNM4KHxTNbRfAEIWFolvg9eeFuW35nLoz6vrNxLVAaeosQ0JGrE5DDK/4A8KxzSY7sYqKF5hmIkjeT4KP+O+g4L6NJCM9Tag+ZQPn/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990959; c=relaxed/simple;
	bh=8bV2lqIXiPv0EEs2Zt4quK7AhPmww+vYsUbUAzMnxO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATEsCa2U1m5cnEkLqzMteblNflOX+pwA125yXPPWo2+dvnN3coj0mZm+Dv5nQCRg5Wx2TZTWVNPLL70IG3EjawoYbNMCr0qOnv8DnZAUctfSh7JX96JN37c3rPs/Yr471Nslx4vOcimmHt3CVXCpNA46GrYIj2/dBF/vZWyH5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aZVtpv1w; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aZVtpv1w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0FF81F443;
	Mon,  3 Mar 2025 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dpc9Q9J+Dw5x1lxYSi5q5HxjUJnIWTQCouuvCgRk5A=;
	b=aZVtpv1w2XjfWhP4w8mTFuJ+iFWlQPcB92EpgJCzKP3UtyKpmY8kwGX42cMaAi51kSqPR7
	rglliDkbEbsPV7fK+xvdexFQH+VlPWSSd9x5NUCpUauHnMRveoQkdTDWBzEhAzCwQk63TV
	Hsolq/REvOoSeIDU6GjqWD54ZQDLaUU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dpc9Q9J+Dw5x1lxYSi5q5HxjUJnIWTQCouuvCgRk5A=;
	b=aZVtpv1w2XjfWhP4w8mTFuJ+iFWlQPcB92EpgJCzKP3UtyKpmY8kwGX42cMaAi51kSqPR7
	rglliDkbEbsPV7fK+xvdexFQH+VlPWSSd9x5NUCpUauHnMRveoQkdTDWBzEhAzCwQk63TV
	Hsolq/REvOoSeIDU6GjqWD54ZQDLaUU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E199813939;
	Mon,  3 Mar 2025 08:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FGWKNhpxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Mar 2025 08:35:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 2/8] btrfs: prevent inline data extents read from touching blocks beyond its range
Date: Mon,  3 Mar 2025 19:05:10 +1030
Message-ID: <432a8c1f69c0d54e445e91abed056cc99591f89b.1740990125.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
References: <cover.1740990125.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
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
index ae1405b49a9f..3652c3485e19 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6793,6 +6793,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 {
 	int ret;
 	struct extent_buffer *leaf = path->nodes[0];
+	const u32 sectorsize = leaf->fs_info->sectorsize;
 	char *tmp;
 	size_t max_size;
 	unsigned long inline_size;
@@ -6809,7 +6810,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
-	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
+	max_size = min_t(unsigned long, sectorsize, max_size);
 	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
 			       max_size);
 
@@ -6821,14 +6822,15 @@ static noinline int uncompress_inline(struct btrfs_path *path,
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
@@ -6843,14 +6845,14 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
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


