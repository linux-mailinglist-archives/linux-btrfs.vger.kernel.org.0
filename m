Return-Path: <linux-btrfs+bounces-12507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4EA6D297
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 01:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A482018939B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC257EEAB;
	Mon, 24 Mar 2025 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lcH3mDRV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lcH3mDRV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050F6FC3
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742776945; cv=none; b=F6VQ9fGKXRJ69g7FUEjglEfc5vhdqViDbJ3UqFl+KCwSiC23ru7gsTun1tnda1v6nxam/sPR5hdIGGKQ1AISo4EZ2PRiL9OmFHONsN7MfZsoM8JCh6E7ksQyHIvXk09TJAnyKwzQ39gZUDEZ6NTjoaXDFv9vpBgN/oUibIlYXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742776945; c=relaxed/simple;
	bh=f1DAFTUD/9cEDEcZjMQF1nESfMUuvuU8OQRF6xW7/9g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VH26ahfmQWZteKfKbIu5+h8LD2hniQZQahwQ5LymvCE7/efX1yrnd4U6kLEMjbZPTYd/ccrAQcaXrmP3x/cddSOEASpqOUvK6LR+1WvS4fcRIdwW1srFfxD7Zi+Gx1skdsLLbsGN2nKTcJaZJSsWU/XsOHBRYwAPWGbBZTl4CGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lcH3mDRV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lcH3mDRV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 034F521192
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 00:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742776935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rzueUzvJ6+fHh6PxeaVgyMi8LEol4ZK0AsFN3Thm/Aw=;
	b=lcH3mDRVk5+j1eqYwPipOu4WGUUtxHlXJWYYODnrWg52AKvwHDI10VsnbFsi19WGE07X9s
	qYt3lRGUyLoZy5qJp0tieUkp+UVfxQAevMsz6C0bvFyKI89eC6rQeJbkIBzkPpFb4WQ4mG
	imu4ctyYcy0nb4FYITK+BZQA72CO+bQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lcH3mDRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742776935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rzueUzvJ6+fHh6PxeaVgyMi8LEol4ZK0AsFN3Thm/Aw=;
	b=lcH3mDRVk5+j1eqYwPipOu4WGUUtxHlXJWYYODnrWg52AKvwHDI10VsnbFsi19WGE07X9s
	qYt3lRGUyLoZy5qJp0tieUkp+UVfxQAevMsz6C0bvFyKI89eC6rQeJbkIBzkPpFb4WQ4mG
	imu4ctyYcy0nb4FYITK+BZQA72CO+bQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC88136D1
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 00:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3cRN2Wq4GelUQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 00:42:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: simplify the reserved space handling inside copy_one_range()
Date: Mon, 24 Mar 2025 11:11:48 +1030
Message-ID: <dd15d8ede1b17f86d2be14390c3927b1633b1a72.1742776906.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 034F521192
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Inside that function we have the following variables all involved to
help handling the reserved space:

- block_offset
- reserve_bytes
- dirty_blocks
- num_blocks
- release_bytes

Many of them (block_offset, dirty_blocks, num_blocks) are only utilized
once or twice as a temporary variables.

Furthermore the variable @release_bytes are utilized for two different
operations:

- As a temporary variable to release exceed range if a short copy
  happened
  And after a short-copy, the @release_bytes will be immediately
  re-calculated to cancel the change such temporary usage.

- As a variables to record the length that will be released

To fix all those unnecessary variables along with the inconsistent
variable usage:

- Introduce @reserved_start and @reserved_len variable
  Both are utilized to track the current reserved range (block aligned).

- Use above variables to calculate the range which needs to be shrunk
  When a short copy happened, we need to shrink the reserved space
  beyond the last block.

  The range to be released is always [@last_block, @reserved_start +
  @reserved_len), and the new @reserved_len will always be
  @last_block - @reserved_start.
  (@last_block is the exclusive block aligned file offset).

- Remove the five variables we no longer need

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 71 ++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b72fc00bc2f6..4d83962ec8d6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1164,15 +1164,13 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
-	const size_t block_offset = start & (fs_info->sectorsize - 1);
+	const u32 blocksize = fs_info->sectorsize;
 	size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset_in_page(start));
-	size_t reserve_bytes;
 	size_t copied;
-	size_t dirty_blocks;
-	size_t num_blocks;
 	struct folio *folio = NULL;
-	u64 release_bytes;
 	int extents_locked;
+	const u64 reserved_start = round_down(start, blocksize);
+	u64 reserved_len;
 	u64 lockstart;
 	u64 lockend;
 	bool only_release_metadata = false;
@@ -1190,23 +1188,22 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 			    &only_release_metadata);
 	if (ret < 0)
 		return ret;
-	reserve_bytes = ret;
-	release_bytes = reserve_bytes;
+	reserved_len = ret;
 
 again:
 	ret = balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_mapping,
 						    bdp_flags);
 	if (ret) {
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		return ret;
 	}
 
 	ret = prepare_one_folio(&inode->vfs_inode, &folio, start, write_bytes, false);
 	if (ret) {
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		return ret;
 	}
@@ -1217,8 +1214,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 		if (!nowait && extents_locked == -EAGAIN)
 			goto again;
 
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		ret = extents_locked;
 		return ret;
@@ -1235,36 +1232,32 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 	 * sure they don't happen by forcing retry this copy.
 	 */
 	if (unlikely(copied < write_bytes)) {
+		u64 last_block;
+		u64 release_len;
+
 		if (!folio_test_uptodate(folio)) {
 			iov_iter_revert(i, copied);
 			copied = 0;
 		}
+
+		if (copied == 0)
+			last_block = round_down(start, blocksize);
+		else
+			last_block = round_up(start + copied, blocksize);
+		release_len = reserved_start + reserved_len - last_block;
+
+		/*
+		 * Since we got a short copy, release the reserved bytes
+		 * byond the last block.
+		 */
+		if (only_release_metadata)
+			btrfs_delalloc_release_metadata(inode, release_len, true);
+		else
+			btrfs_delalloc_release_space(inode, *data_reserved,
+					last_block, release_len, true);
+		reserved_len = last_block - reserved_start;
 	}
 
-	num_blocks = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-	dirty_blocks = round_up(copied + block_offset, fs_info->sectorsize);
-	dirty_blocks = BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
-
-	if (copied == 0)
-		dirty_blocks = 0;
-
-	if (num_blocks > dirty_blocks) {
-		/* Release everything except the sectors we dirtied. */
-		release_bytes -= dirty_blocks << fs_info->sectorsize_bits;
-		if (only_release_metadata) {
-			btrfs_delalloc_release_metadata(inode,
-						release_bytes, true);
-		} else {
-			const u64 release_start = round_up(start + copied,
-							   fs_info->sectorsize);
-
-			btrfs_delalloc_release_space(inode,
-					*data_reserved, release_start,
-					release_bytes, true);
-		}
-	}
-	release_bytes = round_up(copied + block_offset, fs_info->sectorsize);
-
 	ret = btrfs_dirty_folio(inode, folio, start, copied,
 				&cached_state, only_release_metadata);
 	/*
@@ -1280,10 +1273,10 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 	else
 		free_extent_state(cached_state);
 
-	btrfs_delalloc_release_extents(inode, reserve_bytes);
+	btrfs_delalloc_release_extents(inode, reserved_len);
 	if (ret) {
 		btrfs_drop_folio(fs_info, folio, start, copied);
-		release_space(inode, *data_reserved, start, release_bytes,
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		return ret;
 	}
-- 
2.49.0


