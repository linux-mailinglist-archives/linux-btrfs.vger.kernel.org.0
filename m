Return-Path: <linux-btrfs+bounces-11721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D684AA4124F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE630172274
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FD1FC0E3;
	Sun, 23 Feb 2025 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gQTYD8uV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gQTYD8uV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CC10E4
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354407; cv=none; b=luEQwNZFMF3CD3CDHNyqaxCjb5ymCTggBjzVt0mCbaX8bUeG9nZHEqfk+0lj51NYJHKF91+vCfFoYAquFl3sp+aTaooqUuNLylLXXmoSADn4qiot2CA73+JBdswtEfimDviacbmh1XhqQ86Vj10Rjy7DNIYdozlZyqSqhAwMGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354407; c=relaxed/simple;
	bh=mTjmuqA5BArVsHcb8QLce6phzxvyC8W226UB8rVGJvk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsgs8wlLOuLSjSgsAsY0bKnOb65O58EPiEC/MIYtmm5RrcVwqylFUNQ7g3+GQEz50lBVJv6fPgd+c6IIabaz83c3TaqsulMAuI8mXWcytCKisSnrKgx6QPTulf8eMd8g0w2kBjhiK3/BBM5sCy+LJxfrfcjRkl8y9YmkMCXfXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gQTYD8uV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gQTYD8uV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6FD1F383
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WUCmoGyGI+pXz/FPiyG9ovIsPNjQyoiLpNU/cHXNzM=;
	b=gQTYD8uVb24diBGHZuovrpUfJuRbIEvAdP9XxLmEPK6NtSfJEWl3XzafBpiIHHjWiLdNpz
	XQzQ2bJnb6Kxls7enK7kavsd1pJRt6K2kjiqVmiTn+8P80Pd/DcUFrki9s+lu96Z12crJa
	ky+bMVnUdQRzKg05E+mNWIMIwGRR2vs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gQTYD8uV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WUCmoGyGI+pXz/FPiyG9ovIsPNjQyoiLpNU/cHXNzM=;
	b=gQTYD8uVb24diBGHZuovrpUfJuRbIEvAdP9XxLmEPK6NtSfJEWl3XzafBpiIHHjWiLdNpz
	XQzQ2bJnb6Kxls7enK7kavsd1pJRt6K2kjiqVmiTn+8P80Pd/DcUFrki9s+lu96Z12crJa
	ky+bMVnUdQRzKg05E+mNWIMIwGRR2vs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C259613A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EG5DIGGzu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: prevent inline data extents read from touching blocks beyond its range
Date: Mon, 24 Feb 2025 10:16:16 +1030
Message-ID: <31a8b02ec99fd3bf6399b7f543ef6de786665fd2.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740354271.git.wqu@suse.com>
References: <cover.1740354271.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E6FD1F383
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c432ccfba56e..fe2c6038064a 100644
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
@@ -6816,17 +6817,19 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size < PAGE_SIZE)
-		folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
+	if (max_size < sectorsize)
+		folio_zero_range(folio, max_size, sectorsize - max_size);
 	kfree(tmp);
 	return ret;
 }
 
-static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
+static int read_inline_extent(struct btrfs_fs_info *fs_info,
+			      struct btrfs_path *path, struct folio *folio)
 {
 	struct btrfs_file_extent_item *fi;
 	void *kaddr;
 	size_t copy_size;
+	const u32 sectorsize = fs_info->sectorsize;
 
 	if (!folio || folio_test_uptodate(folio))
 		return 0;
@@ -6844,8 +6847,8 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 	read_extent_buffer(path->nodes[0], kaddr,
 			   btrfs_file_extent_inline_start(fi), copy_size);
 	kunmap_local(kaddr);
-	if (copy_size < PAGE_SIZE)
-		folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size);
+	if (copy_size < sectorsize)
+		folio_zero_range(folio, copy_size, sectorsize - copy_size);
 	return 0;
 }
 
@@ -7020,7 +7023,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
 		ASSERT(em->len == fs_info->sectorsize);
 
-		ret = read_inline_extent(path, folio);
+		ret = read_inline_extent(fs_info, path, folio);
 		if (ret < 0)
 			goto out;
 		goto insert;
-- 
2.48.1


