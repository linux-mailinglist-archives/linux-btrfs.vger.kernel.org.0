Return-Path: <linux-btrfs+bounces-10916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF461A0A2E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE73AA488
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E2192D7B;
	Sat, 11 Jan 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IW+Lgrb+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IW+Lgrb+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188711922F5;
	Sat, 11 Jan 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592256; cv=none; b=sbBDAeiW8RLkl23pRMBnHoLwuKilTSlN8tUCNFOfBAecKxl9ys0z/Sj/hEYU7nHDZAcnhyBQWSmqxRZMSmVffN1o3gP07ZlFBn8aDPlCXCh6a4/2I9LOGmn+ZOvBQhftShwspU8AJ4KEsqv+aPexhW2VmXF0RMpYhNaKc0bMHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592256; c=relaxed/simple;
	bh=hPsP4EnoMo71ZV497WCiJ1CPhNRwaQ53sTQC46SbPMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMjzRYzxlEapIaMQqGMMuFO38zzc4CgrpLTDiBXhkCCrzFVoKrYGBXw5ImHXtwA71Llx5rW5SIaTOV+oWW0xBPDriG9tHWtyG4PJQ3sd0lV3R1OOviriscfEYOK5agOhCfDTc8D4s6r2sN/4T2tWII6YnBU0YlCdrygbyU0QGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IW+Lgrb+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IW+Lgrb+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBADB2117D;
	Sat, 11 Jan 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rol+B+wK4AVQnCpHz8pf3hNFtJUtE1XkGTh65/hz2AA=;
	b=IW+Lgrb+dUwHcNZnnrMahAXgjSbAEzEAtKcv++bgQisnf3672jD2BrFkQj9F5ZFj7UCQoF
	dsrcL2RM1r/7QizyBcJYnt8Rv6ZI/JW8Rpp+I1Q5Gn6ZrFmWzFJ4fg2Ztv85hrebvTzaVA
	RaO/RnvwMER1tW82wpR//emiGAvWi94=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rol+B+wK4AVQnCpHz8pf3hNFtJUtE1XkGTh65/hz2AA=;
	b=IW+Lgrb+dUwHcNZnnrMahAXgjSbAEzEAtKcv++bgQisnf3672jD2BrFkQj9F5ZFj7UCQoF
	dsrcL2RM1r/7QizyBcJYnt8Rv6ZI/JW8Rpp+I1Q5Gn6ZrFmWzFJ4fg2Ztv85hrebvTzaVA
	RaO/RnvwMER1tW82wpR//emiGAvWi94=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAFCE139AB;
	Sat, 11 Jan 2025 10:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eEjXJnhLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 Jan 2025 10:44:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v4 02/10] btrfs: fix double accounting race when extent_writepage_io() failed
Date: Sat, 11 Jan 2025 21:13:36 +1030
Message-ID: <a183c7ea8d373fb259e9323198bd93850ddc2bc5.1736591758.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736591758.git.wqu@suse.com>
References: <cover.1736591758.git.wqu@suse.com>
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
If submit_one_sector() failed inside extent_writepage_io() for sector
size < page size cases (e.g. 4K sector size and 64K page size), then
we can hit double ordered extent accounting error.

This should be very rare, as submit_one_sector() only fails when we
failed to grab the extent map, and such extent map should exist inside
the memory and have been pinned.

[CAUSE]
For example we have the following folio layout:

    0  4K          32K    48K   60K 64K
    |//|           |//////|     |///|

Where |///| is the dirty range we need to writeback. The 3 different
dirty ranges are submitted for regular COW.

Now we hit the following sequence:

- submit_one_sector() returned 0 for [0, 4K)

- submit_one_sector() returned 0 for [32K, 48K)

- submit_one_sector() returned error for [60K, 64K)

- btrfs_mark_ordered_io_finished() called for the whole folio
  This will mark the following ranges as finished:
  * [0, 4K)
  * [32K, 48K)
    Both ranges have their IO already submitted, this cleanup will
    lead to double accounting.

  * [60K, 64K)
    That's the correct cleanup.

The only good news is, this error is only theoretical, as the target
extent map is always pinned, thus we should directly grab it from
memory, other than reading it from the disk.

[FIX]
Instead of calling btrfs_mark_ordered_io_finished() for the whole folio
range, which can touch ranges we should not touch, instead
move the error handling inside extent_writepage_io().

So that we can cleanup exact sectors that are ought to be submitted but
failed.

This provide much more accurate cleanup, avoiding the double accounting.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7aa3d8c2b0c3..f50e4fccd909 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1420,6 +1420,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
+	bool error = false;
 	const u64 folio_start = folio_pos(folio);
 	u64 cur;
 	int bit;
@@ -1462,11 +1463,26 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			break;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
-		if (ret < 0)
-			goto out;
+		if (unlikely(ret < 0)) {
+			/*
+			 * bio_ctrl may contain a bio crossing several folios.
+			 * Submit it immediately so that the bio has a chance
+			 * to finish normally, other than marked as error.
+			 */
+			submit_one_bio(bio_ctrl);
+			/*
+			 * Failed to grab the extent map which should be very rare.
+			 * Since there is no bio submitted to finish the ordered
+			 * extent, we have to manually finish this sector.
+			 */
+			btrfs_mark_ordered_io_finished(inode, folio, cur,
+					fs_info->sectorsize, false);
+			error = true;
+			continue;
+		}
 		submitted_io = true;
 	}
-out:
+
 	/*
 	 * If we didn't submitted any sector (>= i_size), folio dirty get
 	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
@@ -1474,8 +1490,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 *
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
+	 *
+	 * If we hit any error, the corresponding sector will still be dirty
+	 * thus no need to clear PAGECACHE_TAG_DIRTY.
 	 */
-	if (!submitted_io) {
+	if (!submitted_io && !error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
@@ -1495,7 +1514,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 {
 	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const u64 page_start = folio_pos(folio);
 	int ret;
 	size_t pg_offset;
 	loff_t i_size = i_size_read(&inode->vfs_inode);
@@ -1538,10 +1556,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
 	bio_ctrl->wbc->nr_to_write--;
 
-	if (ret)
-		btrfs_mark_ordered_io_finished(inode, folio,
-					       page_start, PAGE_SIZE, !ret);
-
 done:
 	if (ret < 0)
 		mapping_set_error(folio->mapping, ret);
@@ -2314,11 +2328,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		if (ret == 1)
 			goto next_page;
 
-		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
-						       cur, cur_len, !ret);
+		if (ret)
 			mapping_set_error(mapping, ret);
-		}
 		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
-- 
2.47.1


