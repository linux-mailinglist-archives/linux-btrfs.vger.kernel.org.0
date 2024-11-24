Return-Path: <linux-btrfs+bounces-9877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31959D7944
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 00:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48580B244A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 23:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1618B475;
	Sun, 24 Nov 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pd2c5CHj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pd2c5CHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64723A1B5;
	Sun, 24 Nov 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492673; cv=none; b=lPhR9SRQ0vUbucYPsmpOvx+HiIQN+c44B+hkBXL7a4U2Fhizr0hWSG3Y4ASnMTUykjT1Ude09eHji9AsNJJcAVK3HlAciJjSV5GCnN3sHoQC+isDmAaLl4lNoUqwgP/hKkVqM6nfOMkDfLsfFUhL5P55h4TQqfrlw5RBtgJRW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492673; c=relaxed/simple;
	bh=1it2bmALOUFjbVfLzFBPZL4ssNqgWxVdoDQjcaIxhUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbyjEMBDsXQD7cVefY4B8YJ07ZY1qw7epOwX87S3yl7PD1fpqaUAgVVmA1NIxIbw8zDltUQu/AQONEtFlRlip79A4ZGW/mPK1Bfd78uEvdP3YfU49V4Yadfu8HGaNQf1eznpZ246MGCe1sj/0MerbSPEk0zLv5lJT0eDinWFKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pd2c5CHj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pd2c5CHj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7A691F381;
	Sun, 24 Nov 2024 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XY97jdhXj1f2RgFKbwDZR8FO5rD6dbybMky1LNX7Oxk=;
	b=pd2c5CHjWQ0HKPja6tE8mC9EyGltdPCXxhKL67ZKr/i+O6BO71YgIFRFipjIES1ilzt9bL
	lnJHTBBekxNdL0lDXYtyqyeTGpAZEYQKCp/IwAz92BG2Rbwa3yIG5t3ryGCc3tDsgHB10l
	XoY8TyQXiKGss9kW9glNQpBYyeQ1zOs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XY97jdhXj1f2RgFKbwDZR8FO5rD6dbybMky1LNX7Oxk=;
	b=pd2c5CHjWQ0HKPja6tE8mC9EyGltdPCXxhKL67ZKr/i+O6BO71YgIFRFipjIES1ilzt9bL
	lnJHTBBekxNdL0lDXYtyqyeTGpAZEYQKCp/IwAz92BG2Rbwa3yIG5t3ryGCc3tDsgHB10l
	XoY8TyQXiKGss9kW9glNQpBYyeQ1zOs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83B07132CF;
	Sun, 24 Nov 2024 23:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCllD3u9Q2emSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 24 Nov 2024 23:57:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/7] btrfs: fix double accounting of ordered extents during errors
Date: Mon, 25 Nov 2024 10:27:21 +1030
Message-ID: <3f91b3e146ca8314c21b9afb44ad84def3d2223d.1732492421.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732492421.git.wqu@suse.com>
References: <cover.1732492421.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.953];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Btrfs will fail generic/750 randomly if its sector size is smaller than
page size.

One of the warning looks like this:

 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 90263 at fs/btrfs/ordered-data.c:360 can_finish_ordered_extent+0x33c/0x390 [btrfs]
 CPU: 1 UID: 0 PID: 90263 Comm: kworker/u18:1 Tainted: G           OE      6.12.0-rc3-custom+ #79
 Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
 pc : can_finish_ordered_extent+0x33c/0x390 [btrfs]
 lr : can_finish_ordered_extent+0xdc/0x390 [btrfs]
 Call trace:
  can_finish_ordered_extent+0x33c/0x390 [btrfs]
  btrfs_mark_ordered_io_finished+0x130/0x2b8 [btrfs]
  extent_writepage+0xfc/0x338 [btrfs]
  extent_write_cache_pages+0x1d4/0x4b8 [btrfs]
  btrfs_writepages+0x94/0x158 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x88/0xc8
  start_delalloc_inodes+0x180/0x3b0 [btrfs]
  btrfs_start_delalloc_roots+0x17c/0x288 [btrfs]
  shrink_delalloc+0x11c/0x280 [btrfs]
  flush_space+0x27c/0x310 [btrfs]
  btrfs_async_reclaim_metadata_space+0xcc/0x208 [btrfs]
  process_one_work+0x228/0x670
  worker_thread+0x1bc/0x360
  kthread+0x100/0x118
  ret_from_fork+0x10/0x20
 irq event stamp: 9784200
 hardirqs last  enabled at (9784199): [<ffffd21ec54dc01c>] _raw_spin_unlock_irqrestore+0x74/0x80
 hardirqs last disabled at (9784200): [<ffffd21ec54db374>] _raw_spin_lock_irqsave+0x8c/0xa0
 softirqs last  enabled at (9784148): [<ffffd21ec472ff44>] handle_softirqs+0x45c/0x4b0
 softirqs last disabled at (9784141): [<ffffd21ec46d01e4>] __do_softirq+0x1c/0x28
 ---[ end trace 0000000000000000 ]---
 BTRFS critical (device dm-2): bad ordered extent accounting, root=5 ino=1492 OE offset=1654784 OE len=57344 to_dec=49152 left=0

[CAUSE]
There are several error paths not properly handling during folio
writeback:

1) Partially submitted folio
   During extent_writepage_io() if some error happened (the only
   possible case is submit_one_sector() failed to grab an extent map),
   then we can have partially submitted folio.

   Since extent_writepage_io() failed, we need to call
   btrfs_mark_ordered_io_finished() to cleanup the submitted range.

   But we will call btrfs_mark_ordered_io_finished() for submitted range
   too, causing double accounting.

2) Partially created ordered extents
   We cal also fail at writepage_delalloc(), which will stop creating
   new ordered extents if it hit any error from
   btrfs_run_delalloc_range().

   In that case, we will call btrfs_mark_ordered_io_finished() for
   ranges where there is no ordered extent at all.

Both bugs are only affecting sector size < page size cases.

[FIX]
- Introduce a new member btrfs_bio_ctrl::last_submitted
  This will trace the last sector submitted through
  extent_writepage_io().

  So for the above extent_writepage() case, we will know exactly which
  sectors are submitted and should not do the ordered extent accounting.

- Clear the submit_bitmap for ranges where no ordered extent is created
  So if btrfs_run_delalloc_range() failed for a range, it will be not
  cleaned up.

- Introduce a helper cleanup_ordered_extents()
  This will do a sector-by-sector cleanup with
  btrfs_bio_ctrl::last_submitted and btrfs_bio_ctrl::submit_bitmap into
  consideartion.

  Using @last_submitted is to avoid double accounting on the submitted
  ranges.
  Meanwhile using @submit_bitmap is to avoid touching ranges going
  through compression.

cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 54 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e629d2ee152a..1c2246d36672 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -108,6 +108,14 @@ struct btrfs_bio_ctrl {
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
 	unsigned long submit_bitmap;
+
+	/*
+	 * The end (exclusive) of the last submitted range in the folio.
+	 *
+	 * This is for sector size < page size case where we may hit error
+	 * half way.
+	 */
+	u64 last_submitted;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -1254,11 +1262,18 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 		/*
 		 * We have some ranges that's going to be submitted asynchronously
-		 * (compression or inline).  These range have their own control
+		 * (compression or inline, ret > 0).  These range have their own control
 		 * on when to unlock the pages.  We should not touch them
-		 * anymore, so clear the range from the submission bitmap.
+		 * anymore.
+		 *
+		 * We can also have some ranges where we didn't even call
+		 * btrfs_run_delalloc_range() (as previous run failed, ret < 0).
+		 * These error ranges should not be submitted nor cleaned up as
+		 * there is no ordered extent allocated for them.
+		 *
+		 * For either cases, we should clear the submit_bitmap.
 		 */
-		if (ret > 0) {
+		if (ret) {
 			unsigned int start_bit = (found_start - page_start) >>
 						 fs_info->sectorsize_bits;
 			unsigned int end_bit = (min(page_end + 1, found_start + found_len) -
@@ -1435,6 +1450,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (ret < 0)
 			goto out;
+		bio_ctrl->last_submitted = cur + fs_info->sectorsize;
 		submitted_io = true;
 	}
 out:
@@ -1453,6 +1469,24 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	return ret;
 }
 
+static void cleanup_ordered_extents(struct btrfs_inode *inode,
+				    struct folio *folio, u64 file_pos,
+				    u64 num_bytes, unsigned long *bitmap)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	unsigned int cur_bit = (file_pos - folio_pos(folio)) >> fs_info->sectorsize_bits;
+
+	for_each_set_bit_from(cur_bit, bitmap, fs_info->sectors_per_page) {
+		u64 cur_pos = folio_pos(folio) + (cur_bit << fs_info->sectorsize_bits);
+
+		if (cur_pos >= file_pos + num_bytes)
+			break;
+
+		btrfs_mark_ordered_io_finished(inode, folio, cur_pos,
+					       fs_info->sectorsize, false);
+	}
+}
+
 /*
  * the writepage semantics are similar to regular writepage.  extent
  * records are inserted to lock ranges in the tree, and as dirty areas
@@ -1492,6 +1526,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * The proper bitmap can only be initialized until writepage_delalloc().
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
+	bio_ctrl->last_submitted = page_start;
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
@@ -1511,8 +1546,10 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
 done:
 	if (ret) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
-					       page_start, PAGE_SIZE, !ret);
+		cleanup_ordered_extents(BTRFS_I(inode), folio,
+				bio_ctrl->last_submitted,
+				page_start + PAGE_SIZE - bio_ctrl->last_submitted,
+				&bio_ctrl->submit_bitmap);
 		mapping_set_error(folio->mapping, ret);
 	}
 
@@ -2288,14 +2325,17 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		 * extent_writepage_io() will do the truncation correctly.
 		 */
 		bio_ctrl.submit_bitmap = (unsigned long)-1;
+		bio_ctrl.last_submitted = cur;
 		ret = extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
 					  &bio_ctrl, i_size);
 		if (ret == 1)
 			goto next_page;
 
 		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
-						       cur, cur_len, !ret);
+			cleanup_ordered_extents(BTRFS_I(inode), folio,
+					bio_ctrl.last_submitted,
+					cur_end + 1 - bio_ctrl.last_submitted,
+					&bio_ctrl.submit_bitmap);
 			mapping_set_error(mapping, ret);
 		}
 		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
-- 
2.47.0


