Return-Path: <linux-btrfs+bounces-13435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D05A9D5AB
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 00:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252087B70F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 22:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A52951DD;
	Fri, 25 Apr 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h78WYEoC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h78WYEoC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9472957BC
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620656; cv=none; b=XTUBV4vTZEAZNGFoEa7ehPqtOqy/e79fMerj508CPAhlDyssFR+h/0hqWYzXEGq4fhdy4cu41WkyvEhAOMRB8yX5y2NFtZBKnRtbaiz7pbVMcbrSYz8DdWExIoa788FiE4xF9fpAIuGqpeMqrTaEnUsV/NG0vlIHCQVp/Ojl5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620656; c=relaxed/simple;
	bh=3+kE4pFUk4qdSBIK6VHyvG0ag9fZsAPcmQm3BCN9LEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCidp5K/y3SZ2mRLd3bpZ9H5m+NnVBuCtiiMN+U6DKt3NT8nUwqvL6wGsOA73IbXkEsW6FRbb1+FVp3QOyXwB3JYR0g8NWy6mFSKusce0+UdxpcLi9KLhPUe8wapOuYCgK/S9f8yqZXuyhvLD3mSHldXVUm8IylmoHBS6iBL3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h78WYEoC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h78WYEoC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2CA61F44F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745620645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NScQtcGZ71NCDFnIUEW5MoKKKV0IEHJtWFR6xOl3mec=;
	b=h78WYEoCZ63+uyHP83yky93WlYZ1Bk27f+TBaC6Y71CnZWs9lUJyQTnu6Lxh77mXJWUR5z
	ea1BkejZqBSnev85huNMG5CkuaDytjEQvEACQYUaT0W1KzXlyt/XxIIDZn2G6mM0/NQ2CK
	+J2FXbvPRXixpjpj3rsmCQr5x15txos=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745620645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NScQtcGZ71NCDFnIUEW5MoKKKV0IEHJtWFR6xOl3mec=;
	b=h78WYEoCZ63+uyHP83yky93WlYZ1Bk27f+TBaC6Y71CnZWs9lUJyQTnu6Lxh77mXJWUR5z
	ea1BkejZqBSnev85huNMG5CkuaDytjEQvEACQYUaT0W1KzXlyt/XxIIDZn2G6mM0/NQ2CK
	+J2FXbvPRXixpjpj3rsmCQr5x15txos=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2D301398F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIjwJ6QODGgYWQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5 1/2] btrfs: handle unaligned EOF truncation correctly for subpage cases
Date: Sat, 26 Apr 2025 08:06:49 +0930
Message-ID: <160905bef87df342145f992782d686af31362eb1.1745619801.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745619801.git.wqu@suse.com>
References: <cover.1745619801.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

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

[FIX]
Enhance btrfs_truncate_block() by:

- Pass a @start/@end pair to indicate the full truncation range
  This is to handle the following truncation case:

    Page size is 64K, fs block size is 4K, truncate range is
    [6K, 60K]

    0                      32K                    64K
    |   |///////////////////////////////////|     |
        6K                                  60K

    The range is not aligned for its head block, so we need to call
    btrfs_truncate_block() with @from = 6K, @front = 0, @len = 0.

    But with that info we only know to zero the range [6K, 8K),
    if we zero out the range [6K, 64K), the last block will also be
    zeroed, causing data loss.

  So here we need the full range we're truncating, so that we can avoid
  over-truncation.

- Remove @front parameter
  With the full truncate range passed in, we can determine if the @from
  is at the head or tail block.

- Skip truncation if @from is not in the head nor tail blocks
  The call site in hole punch unconditionally call
  btrfs_truncate_block() without even checking the range is aligned or
  not.
  If the @from is not in the head nor tail block, it means we can safely
  ignore it.

- Skip truncate if the range inside the target block is already aligned

- Make btrfs_truncate_block() to zero all blocks beyond EOF
  Since we have the original range, we know exactly if we're doing
  truncation beyond EOF (the @end will be (u64)-1).

  If we're doing truncationg beyond EOF, then enlarge the truncation
  range to the folio end, to address the possibly polluted ranges.

  Otherwise still keep the zero range inside the block, as we can have
  large data folios soon, always truncating every blocks inside the same
  folio can be costly for large folios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  3 +-
 fs/btrfs/file.c        | 34 ++++++++-------
 fs/btrfs/inode.c       | 99 ++++++++++++++++++++++++++++++++----------
 3 files changed, 94 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 61fad5423b6a..8dc583e14bed 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -565,8 +565,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const struct fscrypt_str *name, int add_backref, u64 index);
 int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry);
-int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
-			 int front);
+int btrfs_truncate_block(struct btrfs_inode *inode, u64 from, u64 start, u64 end);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e688587329de..5eaa389bfde5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2614,7 +2614,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	u64 lockend;
 	u64 tail_start;
 	u64 tail_len;
-	u64 orig_start = offset;
+	const u64 orig_start = offset;
+	const u64 orig_end = offset + len - 1;
 	int ret = 0;
 	bool same_block;
 	u64 ino_size;
@@ -2645,10 +2646,6 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	lockend = round_down(offset + len, fs_info->sectorsize) - 1;
 	same_block = (BTRFS_BYTES_TO_BLKS(fs_info, offset))
 		== (BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1));
-	/*
-	 * We needn't truncate any block which is beyond the end of the file
-	 * because we are sure there is no data there.
-	 */
 	/*
 	 * Only do this if we are in the same block and we aren't doing the
 	 * entire block.
@@ -2656,8 +2653,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	if (same_block && len < fs_info->sectorsize) {
 		if (offset < ino_size) {
 			truncated_block = true;
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
-						   0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len - 1,
+						   orig_start, orig_end);
 		} else {
 			ret = 0;
 		}
@@ -2667,7 +2664,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	/* zero back part of the first block */
 	if (offset < ino_size) {
 		truncated_block = true;
-		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), offset, orig_start, orig_end);
 		if (ret) {
 			btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 			return ret;
@@ -2704,8 +2701,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 			if (tail_start + tail_len < ino_size) {
 				truncated_block = true;
 				ret = btrfs_truncate_block(BTRFS_I(inode),
-							tail_start + tail_len,
-							0, 1);
+							tail_start + tail_len - 1,
+							orig_start, orig_end);
 				if (ret)
 					goto out_only_mutex;
 			}
@@ -2873,6 +2870,8 @@ static int btrfs_zero_range(struct inode *inode,
 	int ret;
 	u64 alloc_hint = 0;
 	const u64 sectorsize = fs_info->sectorsize;
+	const u64 orig_start = offset;
+	const u64 orig_end = offset + len - 1;
 	u64 alloc_start = round_down(offset, sectorsize);
 	u64 alloc_end = round_up(offset + len, sectorsize);
 	u64 bytes_to_reserve = 0;
@@ -2935,8 +2934,9 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
 			btrfs_free_extent_map(em);
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
-						   0);
+			ret = btrfs_truncate_block(BTRFS_I(inode),
+						   offset + len - 1,
+						   orig_start, orig_end);
 			if (!ret)
 				ret = btrfs_fallocate_update_isize(inode,
 								   offset + len,
@@ -2967,7 +2967,8 @@ static int btrfs_zero_range(struct inode *inode,
 			alloc_start = round_down(offset, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset,
+						   orig_start, orig_end);
 			if (ret)
 				goto out;
 		} else {
@@ -2984,8 +2985,8 @@ static int btrfs_zero_range(struct inode *inode,
 			alloc_end = round_up(offset + len, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
-			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
-						   0, 1);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len - 1,
+						   orig_start, orig_end);
 			if (ret)
 				goto out;
 		} else {
@@ -3105,7 +3106,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 		 * need to zero out the end of the block if i_size lands in the
 		 * middle of a block.
 		 */
-		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size,
+					   inode->i_size, (u64)-1);
 		if (ret)
 			goto out;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 538a9ec86abc..08dda7b0883f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4760,20 +4760,32 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
+static bool is_inside_block(u64 bytenr, u64 blockstart, u32 blocksize)
+{
+	ASSERT(IS_ALIGNED(blockstart, blocksize), "blockstart=%llu blocksize=%u",
+		blockstart, blocksize);
+
+	if (blockstart <= bytenr && bytenr <= blockstart + blocksize - 1)
+		return true;
+	return false;
+}
+
 /*
- * Read, zero a chunk and write a block.
+ * Handle the truncation of a fs block.
+ *
+ * If the range is not block aligned, read out the folio covers @from, and
+ * zero any blocks that are inside the folio and covered by [@start, @end).
+ * If @start or @end + 1 lands inside a block, that block will be marked dirty
+ * for writeback.
+ *
+ * This is utilized by hole punch, zero range, file expansion.
  *
  * @inode - inode that we're zeroing
  * @from - the offset to start zeroing
- * @len - the length to zero, 0 to zero the entire range respective to the
- *	offset
- * @front - zero up to the offset instead of from the offset on
- *
- * This will find the block for the "from" offset and cow the block and zero the
- * part we want to zero.  This is used with truncate and hole punching.
+ * @start - the start file offset of the range we want to zero
+ * @end - the end (inclusive) file offset of the range we want to zero.
  */
-int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
-			 int front)
+int btrfs_truncate_block(struct btrfs_inode *inode, u64 from, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
@@ -4784,16 +4796,45 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	bool only_release_metadata = false;
 	u32 blocksize = fs_info->sectorsize;
 	pgoff_t index = from >> PAGE_SHIFT;
-	unsigned offset = from & (blocksize - 1);
 	struct folio *folio;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
 	size_t write_bytes = blocksize;
 	int ret = 0;
+	const bool in_head_block = is_inside_block(from, round_down(start, blocksize),
+						   blocksize);
+	const bool in_tail_block = is_inside_block(from, round_down(end, blocksize),
+						   blocksize);
+	bool need_truncate_head = false;
+	bool need_truncate_tail = false;
+	u64 zero_start;
+	u64 zero_end;
 	u64 block_start;
 	u64 block_end;
 
-	if (IS_ALIGNED(offset, blocksize) &&
-	    (!len || IS_ALIGNED(len, blocksize)))
+	/* @from should be inside the range. */
+	ASSERT(start <= from && from <= end, "from=%llu start=%llu end=%llu",
+	       from, start, end);
+
+	/* The range is aligned at both ends. */
+	if (IS_ALIGNED(start, blocksize) && IS_ALIGNED(end + 1, blocksize))
+		goto out;
+
+	/*
+	 * @from may not be inside the head nor tail block. In that case
+	 * we need to do nothing.
+	 */
+	if (!in_head_block && !in_tail_block)
+		goto out;
+
+	/*
+	 * Skip the truncatioin if the range in the target block is already aligned.
+	 * The seemingly complex check will also handle the same block case.
+	 */
+	if (in_head_block && !IS_ALIGNED(start, blocksize))
+		need_truncate_head = true;
+	if (in_tail_block && !IS_ALIGNED(end + 1, blocksize))
+		need_truncate_tail = true;
+	if (!need_truncate_head && !need_truncate_tail)
 		goto out;
 
 	block_start = round_down(from, blocksize);
@@ -4876,17 +4917,26 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
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
+	if (end == (u64)-1) {
+		/*
+		 * We're truncating beyond EOF, the remaining blocks normally
+		 * are already holes thus no need to zero again, but it's
+		 * possible for fs block size < page size cases to have memory
+		 * mapped writes to pollute ranges beyond EOF.
+		 *
+		 * In that case although such polluted blocks beyond EOF will
+		 * not reach disk, it still affects our page caches.
+		 */
+		zero_start = max_t(u64, folio_pos(folio), start);
+		zero_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
+				 end);
+	} else {
+		zero_start = max_t(u64, block_start, start);
+		zero_end = min_t(u64, block_end, end);
 	}
+	folio_zero_range(folio, zero_start - folio_pos(folio),
+			 zero_end - zero_start + 1);
+
 	btrfs_folio_clear_checked(fs_info, folio, block_start,
 				  block_end + 1 - block_start);
 	btrfs_folio_set_dirty(fs_info, folio, block_start,
@@ -4988,7 +5038,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	 * rest of the block before we expand the i_size, otherwise we could
 	 * expose stale data.
 	 */
-	ret = btrfs_truncate_block(inode, oldsize, 0, 0);
+	ret = btrfs_truncate_block(inode, oldsize, oldsize, -1);
 	if (ret)
 		return ret;
 
@@ -7623,7 +7673,8 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
 
-		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size, 0, 0);
+		ret = btrfs_truncate_block(inode, inode->vfs_inode.i_size,
+					   inode->vfs_inode.i_size, (u64)-1);
 		if (ret)
 			goto out;
 		trans = btrfs_start_transaction(root, 1);
-- 
2.49.0


