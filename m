Return-Path: <linux-btrfs+bounces-13060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EDA8B46F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 10:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EEA189D710
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF63231A42;
	Wed, 16 Apr 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tpAHvLUf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="egdA8nsC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC4229B1E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793679; cv=none; b=t4izU+sdC7w0WJ7tIsl/3Je3S56Nj1AHOfkRx+jBO7lkHvE0ebcpqoJ1CeL++Miz9dEQLoHhj3BHMcDWAnLcu5QfjOJIl+jKQmKJ8zrAvZfvjSEM33bOZfIk1GDtBl42788NI9EpW24L3O5ZSqZlHwxqzsbForLL9ynCK5fMubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793679; c=relaxed/simple;
	bh=TfUiAI8G16SeMoZ4pEAMoLjt5Nl2/0ewNBiFWl4bLVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awhVQZyq1NNOen+e2rGgp1KSeEKeshTESdFf/YR46+Z9iT3McOJLEyu/NDS0vYWNuyYIJH7PBul2QFurKeF6V5AOFJVTM4IYzDuM4/aGNwtkpWPkUx/LWEM0gDFal9gI93Wdrrao7WwNjixeiJUjD+WSEmNeahAqOxS4SPp18Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tpAHvLUf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=egdA8nsC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E621E1F74D
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744793670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYgY7tKyR6jAgaBtL4swcuzBLgteF4eLTX33/xp6hUs=;
	b=tpAHvLUfq/McuuffXClPM3H12aY7myYDK5V+UZbzlwDEvYZm2PqA7sCx0uT/5n6/YIkRCJ
	tHVdvB0Riwc1lEep3aFtj6c1Nk/dd115ULK+HTlYrxMgogKKiX7vYf+DWM1FYjXODWOJAo
	FKLIgSinOURAQKeEfr0B9kZyAHqVmug=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=egdA8nsC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744793669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYgY7tKyR6jAgaBtL4swcuzBLgteF4eLTX33/xp6hUs=;
	b=egdA8nsC/DRQgsNptTFUc8/hmCkvblCZ8CCL1e5EQ9OXYNOqlP4Br6j6HU75eCHZ81JZCy
	6Ze5/y4yGmco6DQOQs14IS+1P+gJ3cAwysJLu0xAqX3WAKDYHu5Gzufl8RnHR46CIKVXMM
	8g0D17DagBAjCBeBJzUwZgWh5GXSnH0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2282913A39
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0GiXNERw/2fOZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: make btrfs_truncate_block() to zero involved blocks in a folio
Date: Wed, 16 Apr 2025 18:24:08 +0930
Message-ID: <7d5a82898a352492e8d9e09f56ca7b5884fd4790.1744793549.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744793549.git.wqu@suse.com>
References: <cover.1744793549.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E621E1F74D
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
The following fsx sequence will fail on btrfs with 64K page size and 4K
fs block size:

 #fsx -d -e 1 -N 4 $mnt/junk -S 36386
 READ BAD DATA: offset = 0xe9ba, size = 0x6dd5, fname = /mnt/btrfs/junk
 OFFSET      GOOD    BAD     RANGE
 0xe9ba      0x0000  0x03ac  0x0
 operation# (mod 256) for the bad data may be 3
 ...
 LOG DUMP (4 total operations):
 1(  1 mod 256): WRITE    0x6c62 thru 0x1147d	(0xa81c bytes) HOLE	***WWWW
 2(  2 mod 256): TRUNCATE DOWN	from 0x1147e to 0x5448	******WWWW
 3(  3 mod 256): ZERO     0x1c7aa thru 0x28fe2	(0xc839 bytes)
 4(  4 mod 256): MAPREAD  0xe9ba thru 0x1578e	(0x6dd5 bytes)	***RRRR***

[CAUSE]
Only 2 operations are really involved in this case:

 3 pollute_eof	0x5448 thru	0xffff	(0xabb8 bytes)
 3 zero	from 0x1c7aa to 0x28fe3, (0xc839 bytes)
 4 mapread	0xe9ba thru	0x1578e	(0x6dd5 bytes)

At operation 3, fsx pollutes beyond EOF, that is done by mmap()
and write into that mmap() range beyondd EOF.

Such write will fill the range beyond EOF, but it will never reach disk
as ranges beyond EOF will not be marked dirty nor uptodate.

Then we zero_range for [0x1c7aa, 0x28fe3], and since the range is beyond
our isize (which was 0x5448), we should zero out any range beyond
EOF (0x5448).

During btrfs_zero_range(), we call btrfs_truncate_block() to dirty the
unaligned head block.
But that function only really zero out the block at [0x5000, 0x5fff], it
doesn't bother any range other that that block, since those range will
not be marked dirty nor written back.

So the range [0x6000, 0xffff] is still polluted, and later mapread()
will return the poisoned value.

Such behavior is only exposed when page size is larger than fs block
btrfs, as for block size == page size case the block is exactly one
page, and fsx only checks exactly one page at EOF.

[FIX]
Enhance btrfs_truncate_block() by:

- Force callers to pass a @start/@end combination
  So that there will be no 0 length passed in.

- Rename the @front parameter to an enum
  And make it matches the @start/@end parameter better by using
  TRUNCATE_HEAD_BLOCK and TRUNCATE_TAIL_BLOCK instead.

- Pass the original unmodified range into btrfs_truncate_block()
  There are several call sites inside btrfs_zero_range() and
  btrfs_punch_hole() where we pass part of the original range for
  truncating.

  This hides the original range which can lead to under or over
  truncating.
  Thus we have to pass the original zero/punch range.

- Make btrfs_truncate_block() to zero any involved blocks inside the folio
  Since we have the original range, we know exactly which range inside
  the folio that should be zeroed.

  It may cover other blocks other than the one with data space reserved,
  but that's fine, the zeroed range will not be written back anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 10 +++++--
 fs/btrfs/file.c        | 37 ++++++++++++++++--------
 fs/btrfs/inode.c       | 65 +++++++++++++++++++++++++++---------------
 3 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 4e2952cf5766..21b005ddf42c 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -547,8 +547,14 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const struct fscrypt_str *name, int add_backref, u64 index);
 int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry);
-int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
-			 int front);
+
+enum btrfs_truncate_where {
+	BTRFS_TRUNCATE_HEAD_BLOCK,
+	BTRFS_TRUNCATE_TAIL_BLOCK,
+};
+int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
+			 u64 orig_start, u64 orig_end,
+			 enum btrfs_truncate_where where);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e3fea1db4304..9e370d2b9784 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2616,7 +2616,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	u64 lockend;
 	u64 tail_start;
 	u64 tail_len;
-	u64 orig_start = offset;
+	const u64 orig_start = offset;
+	const u64 orig_end = offset + len - 1;
 	int ret = 0;
 	bool same_block;
 	u64 ino_size;
@@ -2658,8 +2659,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	if (same_block && len < fs_info->sectorsize) {
 		if (offset < ino_size) {
 			truncated_block = true;
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
-						   0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
+						   orig_start, orig_end,
+						   BTRFS_TRUNCATE_HEAD_BLOCK);
 		} else {
 			ret = 0;
 		}
@@ -2669,7 +2671,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	/* zero back part of the first block */
 	if (offset < ino_size) {
 		truncated_block = true;
-		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), offset, -1,
+					   orig_start, orig_end,
+					   BTRFS_TRUNCATE_HEAD_BLOCK);
 		if (ret) {
 			btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 			return ret;
@@ -2706,8 +2710,9 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 			if (tail_start + tail_len < ino_size) {
 				truncated_block = true;
 				ret = btrfs_truncate_block(BTRFS_I(inode),
-							tail_start + tail_len,
-							0, 1);
+						tail_start, tail_start + tail_len - 1,
+						orig_start, orig_end,
+						BTRFS_TRUNCATE_TAIL_BLOCK);
 				if (ret)
 					goto out_only_mutex;
 			}
@@ -2875,6 +2880,8 @@ static int btrfs_zero_range(struct inode *inode,
 	int ret;
 	u64 alloc_hint = 0;
 	const u64 sectorsize = fs_info->sectorsize;
+	const u64 orig_start = offset;
+	const u64 orig_end = offset + len - 1;
 	u64 alloc_start = round_down(offset, sectorsize);
 	u64 alloc_end = round_up(offset + len, sectorsize);
 	u64 bytes_to_reserve = 0;
@@ -2937,8 +2944,9 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
 			free_extent_map(em);
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
-						   0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
+						   orig_start, orig_end,
+						   BTRFS_TRUNCATE_HEAD_BLOCK);
 			if (!ret)
 				ret = btrfs_fallocate_update_isize(inode,
 								   offset + len,
@@ -2969,7 +2977,9 @@ static int btrfs_zero_range(struct inode *inode,
 			alloc_start = round_down(offset, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, -1,
+						   orig_start, orig_end,
+						   BTRFS_TRUNCATE_HEAD_BLOCK);
 			if (ret)
 				goto out;
 		} else {
@@ -2986,8 +2996,9 @@ static int btrfs_zero_range(struct inode *inode,
 			alloc_end = round_up(offset + len, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
-						   0, 1);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, offset + len - 1,
+						   orig_start, orig_end,
+						   BTRFS_TRUNCATE_TAIL_BLOCK);
 			if (ret)
 				goto out;
 		} else {
@@ -3107,7 +3118,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 		 * need to zero out the end of the block if i_size lands in the
 		 * middle of a block.
 		 */
-		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, -1,
+					   inode->i_size, -1,
+					   BTRFS_TRUNCATE_HEAD_BLOCK);
 		if (ret)
 			goto out;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e283627c087d..0700a161b80e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4782,15 +4782,16 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
  *
  * @inode - inode that we're zeroing
  * @from - the offset to start zeroing
- * @len - the length to zero, 0 to zero the entire range respective to the
- *	offset
- * @front - zero up to the offset instead of from the offset on
+ * @end - the inclusive end to finish zeroing, can be -1 meaning truncating
+ *	  everything beyond @from.
+ * @where - Head or tail block to truncate.
  *
  * This will find the block for the "from" offset and cow the block and zero the
  * part we want to zero.  This is used with truncate and hole punching.
  */
-int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
-			 int front)
+int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
+			 u64 orig_start, u64 orig_end,
+			 enum btrfs_truncate_where where)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
@@ -4800,20 +4801,30 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	struct extent_changeset *data_reserved = NULL;
 	bool only_release_metadata = false;
 	u32 blocksize = fs_info->sectorsize;
-	pgoff_t index = from >> PAGE_SHIFT;
-	unsigned offset = from & (blocksize - 1);
+	pgoff_t index = (where == BTRFS_TRUNCATE_HEAD_BLOCK) ?
+			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
 	struct folio *folio;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
 	size_t write_bytes = blocksize;
 	int ret = 0;
 	u64 block_start;
 	u64 block_end;
+	u64 clamp_start;
+	u64 clamp_end;
 
-	if (IS_ALIGNED(offset, blocksize) &&
-	    (!len || IS_ALIGNED(len, blocksize)))
+	ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK ||
+	       where == BTRFS_TRUNCATE_TAIL_BLOCK);
+
+	if (end == (loff_t)-1)
+		ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK);
+
+	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize))
 		goto out;
 
-	block_start = round_down(from, blocksize);
+	if (where == BTRFS_TRUNCATE_HEAD_BLOCK)
+		block_start = round_down(from, blocksize);
+	else
+		block_start = round_down(end, blocksize);
 	block_end = block_start + blocksize - 1;
 
 	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
@@ -4893,17 +4904,22 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		goto out_unlock;
 	}
 
-	if (offset != blocksize) {
-		if (!len)
-			len = blocksize - offset;
-		if (front)
-			folio_zero_range(folio, block_start - folio_pos(folio),
-					 offset);
-		else
-			folio_zero_range(folio,
-					 (block_start - folio_pos(folio)) + offset,
-					 len);
-	}
+	/*
+	 * Although we have only reserved space for the one block, we still should
+	 * zero out all blocks in the original range.
+	 * The remaining blocks normally are already holes thus no need to zero again,
+	 * but it's possible for fs block size < page size cases to have memory mapped
+	 * writes to pollute ranges beyond EOF.
+	 *
+	 * In that case although the polluted blocks beyond EOF will not reach disk,
+	 * it still affects our page cache.
+	 */
+	clamp_start = max_t(u64, folio_pos(folio), orig_start);
+	clamp_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
+			  orig_end);
+	folio_zero_range(folio, clamp_start - folio_pos(folio),
+			 clamp_end - clamp_start + 1);
+
 	btrfs_folio_clear_checked(fs_info, folio, block_start,
 				  block_end + 1 - block_start);
 	btrfs_folio_set_dirty(fs_info, folio, block_start,
@@ -5005,7 +5021,8 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	 * rest of the block before we expand the i_size, otherwise we could
 	 * expose stale data.
 	 */
-	ret = btrfs_truncate_block(inode, oldsize, 0, 0);
+	ret = btrfs_truncate_block(inode, oldsize, -1, oldsize, -1,
+				   BTRFS_TRUNCATE_HEAD_BLOCK);
 	if (ret)
 		return ret;
 
@@ -7649,7 +7666,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
 
-		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, 0, 0);
+		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, -1,
+					   inode->vfs_inode.i_size, -1,
+					   BTRFS_TRUNCATE_HEAD_BLOCK);
 		if (ret)
 			goto out;
 		trans = btrfs_start_transaction(root, 1);
-- 
2.49.0


