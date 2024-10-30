Return-Path: <linux-btrfs+bounces-9236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E7B9B5BC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84F11C20F9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 06:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CF1D27A5;
	Wed, 30 Oct 2024 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dvYpr1yg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dvYpr1yg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754419DF95
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270081; cv=none; b=ro0WsjmGOww/YY6JAb8ZCQmOij3/sMgSehiMGzNWSUyiuzIbmetRsTyRvxvxK2Vmam+zThfryn+Y77n2LAGVmXJqgf0kElU72vRZ4htXO3eUXmYxnIFwaQtvgmxP/iE3TadvA02rYy7UNakXJ8jacpdFdfqzHanT0uX/Sk1X67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270081; c=relaxed/simple;
	bh=h1J3GgOA2jCNdbp1PGrtNt1SUrfy9iElE41Mb1XoEUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkvL/fHRErXUGZIYLRDecUlel8ee2RBiZHFUXZaqjjJ/3r8g47thg1yRFMVbj1GmiruepgaKX3KWLCWXsD/p8Ee7iroQJ0crse9w0AEkcy7CNIpUknQNJGlI4bETLhkNir6wKJezZTqKUahNHJoow0GS749+4n2jc3Xgj4hmoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dvYpr1yg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dvYpr1yg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D03A31F7D9
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730270076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmQVfuqidDBvATraHd+tbzzmEJJJW4E7ih4Hrt/Qw+M=;
	b=dvYpr1ygnP32zUMkjk40u0QlZx1PT2s12SGwnHq6e95VO+HmTPvEXhcmN/eIXUs/WzX0jn
	fX24h8PndmHyY1YcmoQoaycWvMmlFyG18JKnfKCd3L5OqFfjiMk2VO5L1gbnwjgusk6Zyg
	9pF1ryt8hdd03ABiyskZaUz1v47Pk2A=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730270076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmQVfuqidDBvATraHd+tbzzmEJJJW4E7ih4Hrt/Qw+M=;
	b=dvYpr1ygnP32zUMkjk40u0QlZx1PT2s12SGwnHq6e95VO+HmTPvEXhcmN/eIXUs/WzX0jn
	fX24h8PndmHyY1YcmoQoaycWvMmlFyG18JKnfKCd3L5OqFfjiMk2VO5L1gbnwjgusk6Zyg
	9pF1ryt8hdd03ABiyskZaUz1v47Pk2A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C34136A5
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAtyM3vTIWcFcwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 06:34:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: fix double accounting of ordered extents during errors
Date: Wed, 30 Oct 2024 17:03:57 +1030
Message-ID: <2faab8a96c6dd2a414a96e4cebae97ecbddf021d.1730269807.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730269807.git.wqu@suse.com>
References: <cover.1730269807.git.wqu@suse.com>
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
The function btrfs_mark_ordered_io_finished() is called for marking all
ordered extents in the page range as finished, for error handling.

But for sector size < page size cases, we can have multiple ordered
extents in one page.

If extent_writepage_io() failed (the only possible case is
submit_one_sector() failed to grab an extent map), then the call site
inside extent_writepage() will call btrfs_mark_ordered_io_finished() to
finish the created ordered extents.

However some range of the ordered extent may have been submitted already,
then btrfs_mark_ordered_io_finished() is called on the same range, causing
double accounting.

[FIX]
- Introduce a new member btrfs_bio_ctrl::last_submitted
  This will trace the last sector submitted through
  extent_writepage_io().

  So for the above extent_writepage() case, we will know exactly which
  sectors are submitted and should not do the ordered extent accounting.

- Introduce a helper cleanup_ordered_extents()
  This will do a sector-by-sector cleanup with
  btrfs_bio_ctrl::last_submitted and btrfs_bio_ctrl::submit_bitmap into
  consideartion.

  Using @last_submitted is to avoid double accounting on the submitted
  ranges.
  Meanwhile using @submit_bitmap is to avoid touching ranges going
  through compression.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e629d2ee152a..427bfbe737f2 100644
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
@@ -1435,6 +1443,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (ret < 0)
 			goto out;
+		bio_ctrl->last_submitted = cur + fs_info->sectorsize;
 		submitted_io = true;
 	}
 out:
@@ -1453,6 +1462,24 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
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
@@ -1492,6 +1519,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * The proper bitmap can only be initialized until writepage_delalloc().
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
+	bio_ctrl->last_submitted = page_start;
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
@@ -1511,8 +1539,10 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
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
 
@@ -2288,14 +2318,17 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
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


