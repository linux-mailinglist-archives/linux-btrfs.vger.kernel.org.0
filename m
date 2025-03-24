Return-Path: <linux-btrfs+bounces-12512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A69A6D728
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616061656A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1DE25D906;
	Mon, 24 Mar 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VDIgd3hj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KSN/4RiM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67D204F64
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808011; cv=none; b=nbod1qix/klEW7sOkIpEnmIN2Pw6D6NBjAxjokUC/2H4++RTMjh8ro5ZvsKmpE64Y41fOIEfsRU3+EY+4GRGWP6OcHbGgPSLSipbQH8UzvfMDZL3uYcv19kVL9bbQsoFV0stw7QNO4TBqjE+p4fvXx2IwniuJGSqpFWJJsnW0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808011; c=relaxed/simple;
	bh=3YoUVxYKPV8Im7J1pn4sqgruqr8YRro7htlVvZ4U72Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RfUc8VoIPgSICK4hb/TGPPfarGKw72EMUDRZM/K/v5z/P7OZQylIQL8AjXkllamb0hnv4ChgzAChk2FVOUKd9bt9SkY9guucA33+GptbtCLfORpN36OFl2McSGb6xtiFSW3l/x0W2VbKxBb7IUEDepLBxFIka6V0qdJn7l9Vke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VDIgd3hj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KSN/4RiM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03B7C2116A
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742808007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DAuhnD+kT8ge2ovjktatUe9Bh7zN9bT+cPvQWu66Y6E=;
	b=VDIgd3hjWLp/c1pmzuTYrso4kvV3zpKOJUp7pgJsA2iw6aLD6CiMXQovmQRcbmRlSM0cS6
	HfJP2Xuv3ib0Oew0RmKqQ2RtRwp7zhLXJALRRLG5UQST/TWMRy5YSNdTyX3PY6vHM6yXxt
	2rn4vbrA4LXt6JucSYmxEvXf9nNPh10=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742808006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DAuhnD+kT8ge2ovjktatUe9Bh7zN9bT+cPvQWu66Y6E=;
	b=KSN/4RiM5nfmKXZHpdeJ6LZ9RVi2HCRohNTU2OeSYmBeUbB2znU4mjdskal81i8Uz6Lh2t
	hpWj9obH8kX6YnCQjm4kLCLYepd4YnLug0B+ELBgTq1THHooLTbMiqMFvm3x6UUzGj5yEF
	zZlKs32pTGLYa6DxBdj34Ye/W03GLSM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4074013874
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 09:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vg4vAcUj4WcPXwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 09:20:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: simplify the reserved space handling inside copy_one_range()
Date: Mon, 24 Mar 2025 19:49:47 +1030
Message-ID: <bbf613a71ab81953faae900904590de3353b91fb.1742807897.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
X-Spam-Score: -2.80
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

  There is a small exception that, even for zero-byte copied cases, we
  will keep the first block rerserved, and that block will be freed
  by the btrfs_delalloc_release_extents() after btrfs_dirty_folio().
  The behavior is the same as the old one.

- Remove the five variables we no longer need

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a kernel warning that can be triggered by generic/027 with subpage block size
  The fix is to keep the old behavior that the first block will only be
  released by btrfs_delalloc_release_extents() after
  btrfs_dirty_folio().
---
 fs/btrfs/file.c | 81 +++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b72fc00bc2f6..2c6dd8ff9c63 100644
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
@@ -1235,36 +1235,39 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
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
+		/*
+		 * For zero-copied case, we keep the current block as reserved,
+		 * and that block will be released after btrfs_dirty_folio()
+		 * call.
+		 */
+		if (copied == 0)
+			last_block = reserved_start + blocksize;
+		else
+			last_block = round_up(start + copied, blocksize);
+		release_len = reserved_start + reserved_len - last_block;
+
+		/*
+		 * Since we got a short copy, release the reserved bytes
+		 * beyond the last block.
+		 */
+		if (only_release_metadata)
+			btrfs_delalloc_release_metadata(inode, release_len, true);
+		else
+			btrfs_delalloc_release_space(inode, *data_reserved,
+					last_block, release_len, true);
+		/* We should have at least one block reserved. */
+		ASSERT(last_block > reserved_start);
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
@@ -1280,10 +1283,10 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
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


