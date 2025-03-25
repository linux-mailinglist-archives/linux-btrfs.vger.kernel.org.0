Return-Path: <linux-btrfs+bounces-12522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FAA6EAF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 09:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11DB7A3E7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65019F13B;
	Tue, 25 Mar 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WchAzNWk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WchAzNWk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55997481C4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889692; cv=none; b=KIBBNiEIuzObk0tqLJiOfP2yMK8nXH4fb5tS/5LdpiTZMbN8Co2pkeQzjB0EgaQ8DozVFebPPHILCYuudmOxMEBrCwMc6U69klel6LSUEEGH0QJlAJytfGkfhkDWb4DeHb2ndidxAq+AEyZ/nzap1nSkI8Sn4mt2Clgrayv0qfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889692; c=relaxed/simple;
	bh=DRlDFu2R1H5xhuTOVdMNrilJWwnPOVFFpO5qDeiRN+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DZISCPlS6OGw6xbxreP65wH7YdQ4OKY5i4XCxLBX/G5vBXeRLKMns5IhIX8REPDhkY2HFsWyKVQL/Uf1LU2L/m2v873GN8sVtiME6j9wGUyuHdvDO+PQ5IIqAITzfcGXLVwhRRekkk+XPfLFNGBHzAHJb/LUteX1JOwpn2GAdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WchAzNWk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WchAzNWk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 522951F391
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742889688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ksaBdGkjYD+0UlthWB2KpncmobIz/KacR2OFfzAFXrE=;
	b=WchAzNWkihdnM1K62t9u1fb86QpRRIZe2ky6zyo/T63lvELYDgz9StB9imlAA150GzjITq
	rnBYzb/foKrUMTAvxViT4phSyJzZHb/91dSkjQ93BRvc1KAwvQh65o7FyYeIBZ7X0rB7FH
	9o2l9/SCwoOWa1f0So0wYjObjdg4BFI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WchAzNWk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742889688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ksaBdGkjYD+0UlthWB2KpncmobIz/KacR2OFfzAFXrE=;
	b=WchAzNWkihdnM1K62t9u1fb86QpRRIZe2ky6zyo/T63lvELYDgz9StB9imlAA150GzjITq
	rnBYzb/foKrUMTAvxViT4phSyJzZHb/91dSkjQ93BRvc1KAwvQh65o7FyYeIBZ7X0rB7FH
	9o2l9/SCwoOWa1f0So0wYjObjdg4BFI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8377713957
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 08:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FteBENdi4meYFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 08:01:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: simplify the reserved space handling inside copy_one_range()
Date: Tue, 25 Mar 2025 18:31:09 +1030
Message-ID: <75e2c5599917601879ad120425376d54e95cb49c.1742889641.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 522951F391
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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

And there is even a bug in the short-copy handling:

- btrfs_delalloc_release_extents() is not called for short-copy
  Which looks like a bug from the very beginning, affecting both
  zero byte copied and partial copied cases.
  This can lead to rare generic/027 kernel warnings for subpage block
  size.

To fix all those unnecessary variables along with the inconsistent
variable usage:

- Introduce @reserved_start and @reserved_len variable
  Both are utilized to track the current reserved range (block aligned).

- Use above variables to calculate the range which needs to be shrunk
  When a short copy happened, we need to shrink the reserved space
  beyond the last block.

- Handle zero byte copied case and return immediately
  Not all functions are handling 0 length correct, and to be extra safe,
  just manually do the cleanup and exit.

- Call btrfs_delalloc_release_extents() for short-copy cases
  This also fixes a bug in the original code that it doesn't call
  btrfs_delalloc_release_extents() to release the ranges beyond
  the last block.

- Remove the five variables we no longer need

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Do cleanup and return directly if no byte is copied

- Call btrfs_delalloc_release_extents() when short copy happened
  Which is not done in the original code.

v2:
- Fix a bug that can be triggered by generic/027 with subpage block size
  The fix is to keep the old behavior that the first block will only be
  released by btrfs_delalloc_release_extents() after
  btrfs_dirty_folio().
---
 fs/btrfs/file.c | 79 ++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b72fc00bc2f6..0b637e61fdee 100644
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
@@ -1190,23 +1188,25 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 			    &only_release_metadata);
 	if (ret < 0)
 		return ret;
-	reserve_bytes = ret;
-	release_bytes = reserve_bytes;
+	reserved_len = ret;
+	/* The write range must be inside the reserved range. */
+	ASSERT(start >= reserved_start);
+	ASSERT(start + write_bytes <= reserved_start + reserved_len);
 
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
@@ -1217,8 +1217,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 		if (!nowait && extents_locked == -EAGAIN)
 			goto again;
 
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		ret = extents_locked;
 		return ret;
@@ -1235,35 +1235,40 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
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
-	}
 
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
+		if (copied == 0) {
+			btrfs_drop_folio(fs_info, folio, start, copied);
+			if (extents_locked)
+				unlock_extent(&inode->io_tree, lockstart, lockend,
+				      &cached_state);
+			else
+				free_extent_state(cached_state);
+			btrfs_delalloc_release_extents(inode, reserved_len);
+			release_space(inode, *data_reserved, reserved_start,
+				      reserved_len, only_release_metadata);
+			return 0;
 		}
+
+		/* Release space beyond the last block and continue. */
+		last_block = round_up(start + copied, blocksize);
+		release_len = reserved_start + reserved_len - last_block;
+		btrfs_delalloc_release_extents(inode, release_len);
+		if (only_release_metadata)
+			btrfs_delalloc_release_metadata(inode, release_len, true);
+		else
+			btrfs_delalloc_release_space(inode, *data_reserved,
+					last_block, release_len, true);
+		/* We should have at least one block reserved. */
+		ASSERT(last_block > reserved_start);
+		reserved_len = last_block - reserved_start;
 	}
-	release_bytes = round_up(copied + block_offset, fs_info->sectorsize);
 
 	ret = btrfs_dirty_folio(inode, folio, start, copied,
 				&cached_state, only_release_metadata);
@@ -1280,10 +1285,10 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
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


