Return-Path: <linux-btrfs+bounces-12957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89553A85728
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EFD1B62193
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E63629898D;
	Fri, 11 Apr 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EebiAVGb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EebiAVGb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF4293460
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361975; cv=none; b=m9dIwLGtoc9K7S2DccVR1Ga767F62zvUEWIHt0cTVnxmVXTMQQ2MbQij11Sj6f3AGlH7cdt6pwxr093JddbMhZEJsM+n4EEyggKf1iXeBZE3XSbkQondYZwpQlZxx93aNSbabyjsHWr8/xAszbiP+1+lA5BKMjJR2TKbMN3FI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361975; c=relaxed/simple;
	bh=sdF9RmFbgnGl/3bZGpclKxeTuIYWeS7v1VM0ooHVNfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixnKzXBjQ8LXhcYKtJRpab8NYxoGjI5TE8LZUVvEVuV8u2/18xbNqwaTwCcNEIlrO4olaGqeKexnW0cR1n/mRWkhgJhlG3KvGKwjZIvzepOxFYGTQbn3eWqYVwuG7IZaEI6kjhcMKZ4iWBMaAHolkky5OpeaRZl4vOR9MWFkYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EebiAVGb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EebiAVGb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E56C2118D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744361959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sZPn68YsL/HDO4If50phxsThbRPHIDd2xVtoFyHmm8=;
	b=EebiAVGbpzz5syrngm1o1YSCwdEP1tUhw9A3sMUPJpNyzBe/Evvefsu8J+JgwmSxO2EnnE
	b27wGVoNQY/7dPcCI/sFCpr1PNU5Zv+InzS41Lgwu7434vICrqdIPTQWuW80LuEUT8kdIP
	5nwB4zTTmMrS4NWSGkuylXaUVzx5+Pc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744361959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sZPn68YsL/HDO4If50phxsThbRPHIDd2xVtoFyHmm8=;
	b=EebiAVGbpzz5syrngm1o1YSCwdEP1tUhw9A3sMUPJpNyzBe/Evvefsu8J+JgwmSxO2EnnE
	b27wGVoNQY/7dPcCI/sFCpr1PNU5Zv+InzS41Lgwu7434vICrqdIPTQWuW80LuEUT8kdIP
	5nwB4zTTmMrS4NWSGkuylXaUVzx5+Pc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD5313886
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yJh8J+bZ+GfJHQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: make btrfs_truncate_block() zero folio range for certain subpage corner cases
Date: Fri, 11 Apr 2025 18:28:54 +0930
Message-ID: <83be89b5ae029353b8e0807edabb47df607b02f0.1744361863.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744361863.git.wqu@suse.com>
References: <cover.1744361863.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

[BUG]
For the following fsx -e 1 run, the btrfs still fails the run on 64K
page size with 4K fs block size:

READ BAD DATA: offset = 0x26b3a, size = 0xfafa, fname = /mnt/btrfs/junk
OFFSET      GOOD    BAD     RANGE
0x26b3a     0x0000  0x15b4  0x0
operation# (mod 256) for the bad data may be 21
[...]
LOG DUMP (28 total operations):
1(  1 mod 256): SKIPPED (no operation)
2(  2 mod 256): SKIPPED (no operation)
3(  3 mod 256): SKIPPED (no operation)
4(  4 mod 256): SKIPPED (no operation)
5(  5 mod 256): WRITE    0x1ea90 thru 0x285e0	(0x9b51 bytes) HOLE
6(  6 mod 256): ZERO     0x1b1a8 thru 0x20bd4	(0x5a2d bytes)
7(  7 mod 256): FALLOC   0x22b1a thru 0x272fa	(0x47e0 bytes) INTERIOR
8(  8 mod 256): WRITE    0x741d thru 0x13522	(0xc106 bytes)
9(  9 mod 256): MAPWRITE 0x73ee thru 0xdeeb	(0x6afe bytes)
10( 10 mod 256): FALLOC   0xb719 thru 0xb994	(0x27b bytes) INTERIOR
11( 11 mod 256): COPY 0x15ed8 thru 0x18be1	(0x2d0a bytes) to 0x25f6e thru 0x28c77
12( 12 mod 256): ZERO     0x1615e thru 0x1770e	(0x15b1 bytes)
13( 13 mod 256): SKIPPED (no operation)
14( 14 mod 256): DEDUPE 0x20000 thru 0x27fff	(0x8000 bytes) to 0x1000 thru 0x8fff
15( 15 mod 256): SKIPPED (no operation)
16( 16 mod 256): CLONE 0xa000 thru 0xffff	(0x6000 bytes) to 0x36000 thru 0x3bfff
17( 17 mod 256): ZERO     0x14adc thru 0x1b78a	(0x6caf bytes)
18( 18 mod 256): TRUNCATE DOWN	from 0x3c000 to 0x1e2e3	******WWWW
19( 19 mod 256): CLONE 0x4000 thru 0x11fff	(0xe000 bytes) to 0x16000 thru 0x23fff
20( 20 mod 256): FALLOC   0x311e1 thru 0x3681b	(0x563a bytes) PAST_EOF
21( 21 mod 256): FALLOC   0x351c5 thru 0x40000	(0xae3b bytes) EXTENDING
22( 22 mod 256): WRITE    0x920 thru 0x7e51	(0x7532 bytes)
23( 23 mod 256): COPY 0x2b58 thru 0xc508	(0x99b1 bytes) to 0x117b1 thru 0x1b161
24( 24 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3c9a5
25( 25 mod 256): SKIPPED (no operation)
26( 26 mod 256): MAPWRITE 0x25020 thru 0x26b06	(0x1ae7 bytes)
27( 27 mod 256): SKIPPED (no operation)
28( 28 mod 256): READ     0x26b3a thru 0x36633	(0xfafa bytes)	***RRRR***

[CAUSE]
The involved operations are:

 fallocating to largest ever: 0x40000
 21 pollute_eof	0x24000 thru	0x2ffff	(0xc000 bytes)
 21 falloc	from 0x351c5 to 0x40000 (0xae3b bytes)
 28 read	0x26b3a thru	0x36633	(0xfafa bytes)

At operation #21 a pollute_eof is done, by memory mappaed write into
range [0x24000, 0x2ffff).
At this stage, the inode size is 0x24000, which is block aligned.

Then fallocate happens, and since it's expanding the inode, it will call
btrfs_truncate_block() to truncate any unaligned range.

But since the inode size is already block aligned,
btrfs_truncate_block() does nothing and exit.

However remember the folio at 0x20000 has some range polluted already,
although they will not be written back to disk, it still affects the
page cache, resulting the later operation #28 to read out the polluted
value.

[FIX]
Instead of early exit from btrfs_truncate_block() if the range is
already block aligned, do extra filio zeroing if the fs block size is
smaller than the page size.

This is to address exactly the above case where memory mapped write can
still leave some garbage beyond EOF.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0700a161b80e..2dc9b565f1f1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4777,6 +4777,87 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
+/*
+ * A helper to zero out all blocks inside range [@orig_start, @orig_end) of
+ * the target folio.
+ * The target folio is the one containing the head or tail block of the range
+ * [@from, @end].
+ *
+ * This is a special case for fs block size < page size, where even if the range
+ * [from, end] is already block aligned, we can still have blocks beyond EOF being
+ * polluted by memory mapped write.
+ */
+static int zero_range_folio(struct btrfs_inode *inode, loff_t from, loff_t end,
+			    u64 orig_start, u64 orig_end,
+			    enum btrfs_truncate_where where)
+{
+	const u32 blocksize = inode->root->fs_info->sectorsize;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	struct extent_io_tree *io_tree = &inode->io_tree;
+	struct extent_state *cached_state = NULL;
+	struct btrfs_ordered_extent *ordered;
+	pgoff_t index = (where == BTRFS_TRUNCATE_HEAD_BLOCK) ?
+			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
+	struct folio *folio;
+	u64 block_start;
+	u64 block_end;
+	u64 clamp_start;
+	u64 clamp_end;
+	int ret = 0;
+
+	/*
+	 * The target head/tail block is already block aligned.
+	 * If block size >= PAGE_SIZE, meaning it's impossible to mmap a
+	 * page containing anything other than the target block.
+	 */
+	if (blocksize >= PAGE_SIZE)
+		return 0;
+again:
+	folio = filemap_lock_folio(mapping, index);
+	/* No folio present. */
+	if (IS_ERR(folio))
+		return 0;
+
+	if (!folio_test_uptodate(folio)) {
+		ret = btrfs_read_folio(NULL, folio);
+		folio_lock(folio);
+		if (folio->mapping != mapping) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto again;
+		}
+		if (!folio_test_uptodate(folio)) {
+			ret = -EIO;
+			goto out_unlock;
+		}
+	}
+	folio_wait_writeback(folio);
+
+	clamp_start = max_t(u64, folio_pos(folio), orig_start);
+	clamp_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
+			  orig_end);
+	block_start = round_down(clamp_start, block_size);
+	block_end = round_up(clamp_end + 1, block_size) - 1;
+	lock_extent(io_tree, block_start, block_end, &cached_state);
+	ordered = btrfs_lookup_ordered_range(inode, block_start, block_end + 1 - block_end);
+	if (ordered) {
+		unlock_extent(io_tree, block_start, block_end, &cached_state);
+		folio_unlock(folio);
+		folio_put(folio);
+		btrfs_start_ordered_extent(ordered);
+		btrfs_put_ordered_extent(ordered);
+		goto again;
+	}
+	folio_zero_range(folio, clamp_start - folio_pos(folio),
+			 clamp_end - clamp_start + 1);
+	unlock_extent(io_tree, block_start, block_end, &cached_state);
+
+out_unlock:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ret;
+}
+
 /*
  * Read, zero a chunk and write a block.
  *
@@ -4819,7 +4900,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t end,
 		ASSERT(where == BTRFS_TRUNCATE_HEAD_BLOCK);
 
 	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize))
-		goto out;
+		return zero_range_folio(inode, from, end, orig_start, orig_end, where);
 
 	if (where == BTRFS_TRUNCATE_HEAD_BLOCK)
 		block_start = round_down(from, blocksize);
-- 
2.49.0


