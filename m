Return-Path: <linux-btrfs+bounces-10924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6277A0A2EC
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814361889188
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F25192D9E;
	Sat, 11 Jan 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H0llK0+A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H0llK0+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9671922D8
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592266; cv=none; b=FedLZq0MF9TnO1YbAe7g+bWd2BjunV0c/YjMt+o7CUSSd/LqBEg1vUSEUhjQujdSkPf0ZLg9fRdetvTRDvdLkFD5PAq5lubqMNJ5NQWbCkTxLV9ZVQW9tyM6oc7jjnNEee0DCyOANOecmFPZDoxRHuB+M8dWaoUeKGU8yRr8FFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592266; c=relaxed/simple;
	bh=9+SWLS/grGv5WlsCvryCdac8YSPBLkNgEdBjK974NRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YypUUy9G2D5aJF0gQS/WkzmKe0Fjdqr3TqjlJIkkkyObyHcZqDOLz35e7+nv4i/yQ/9f+KFwsD+xbuQ1VEb12FncsNcfNNEuGHWk9VNygGQgi2r3nIbSoPsK0Pp0uNSui5416XNguIepiYh2q7S14IWtj/95M2rA5z5C2b5spYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H0llK0+A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H0llK0+A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00BC821108
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmhz5cC9i1tPVpezDbt3kDxpuorF7qme+aPQ6bzgVuM=;
	b=H0llK0+AA0SkZuYqf70Vg74jtpALR6kcut1U8YSldO1FTahRzlCU4l6ZH0ZzPYTcocfRSW
	q6p676lQdnao2PIb/swfxxWy/xT9Jj7+Byat8jY7pJjGW7LUQmDpOsRZ8mPOpIyfFNyrty
	dvgnHPMSmXB9OV70YTUPekg3EAqEJv4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmhz5cC9i1tPVpezDbt3kDxpuorF7qme+aPQ6bzgVuM=;
	b=H0llK0+AA0SkZuYqf70Vg74jtpALR6kcut1U8YSldO1FTahRzlCU4l6ZH0ZzPYTcocfRSW
	q6p676lQdnao2PIb/swfxxWy/xT9Jj7+Byat8jY7pJjGW7LUQmDpOsRZ8mPOpIyfFNyrty
	dvgnHPMSmXB9OV70YTUPekg3EAqEJv4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3151D139AB
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAsFOYRLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 10/10] btrfs: move ordered extent cleanup to where they are allocated
Date: Sat, 11 Jan 2025 21:13:44 +1030
Message-ID: <9b55ff95921e88dd00413236390e7fd7561175de.1736591758.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
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

The ordered extent cleanup is hard to grasp because it doesn't follow
the common pattern that the cleanup happens where ordered extent get
allocated.

E.g. run_delalloc_nocow() and cow_file_range() allocate one or more
ordered extents, but if any error is hit, the cleanup is done inside
btrfs_run_delalloc_range().

To fix the existing delayed cleanup:

- Update the comment on error handling
  For @cow_start set case, @cur_offset can be assigned to either
  @cow_start or @cow_end.
  So for such case we can not trust @cur_offset but only @cow_start.

- Only reset @cow_start when fallback_to_cow() succeeded

- Add Extra ASSERT() when @cow_start is still set at error path

- Rewind @cur_offset when @cow_start is set
  When we fall back to COW, @cur_offset can be set to either @cow_start
  or @cow_end.
  We can not directly trust @cur_offset, or we will do double ordered
  extent accounting on range which is already cleaned up
  cow_file_range().

- Move btrfs_cleanup_ordered_extents() into run_delalloc_nocow() and
  cow_file_range()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 58 +++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 130f0490b14f..70ef7f59b692 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1272,10 +1272,8 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * - Else all pages except for @locked_folio are unlocked.
  *
  * When a failure happens in the second or later iteration of the
- * while-loop, the ordered extents created in previous iterations are kept
- * intact. So, the caller must clean them up by calling
- * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
- * example.
+ * while-loop, the ordered extents created in previous iterations are
+ * cleaned up, leaving no ordered extent in the range.
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct folio *locked_folio, u64 start,
@@ -1488,9 +1486,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	/*
 	 * For the range (1). We have already instantiated the ordered extents
-	 * for this region. They are cleaned up by
-	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range().
+	 * for this region, and need to clean them up.
 	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
 	 * are also handled by the cleanup function.
 	 *
@@ -1504,6 +1500,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
+
+		btrfs_cleanup_ordered_extents(inode, orig_start, start - orig_start);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_folio, NULL, clear_bits, page_ops);
 	}
@@ -1980,6 +1978,9 @@ static void cleanup_dirty_folios(struct btrfs_inode *inode,
  *
  * If no cow copies or snapshots exist, we write directly to the existing
  * blocks on disk
+ *
+ * If an error is hit, any ordered extent created inside the range is
+ * properly cleaned up.
  */
 static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				       struct folio *locked_folio,
@@ -2152,12 +2153,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (cow_start != (u64)-1) {
 			ret = fallback_to_cow(inode, locked_folio, cow_start,
 					      found_key.offset - 1);
-			cow_start = (u64)-1;
 			if (ret) {
 				cow_end = found_key.offset - 1;
 				btrfs_dec_nocow_writers(nocow_bg);
 				goto error;
 			}
+			cow_start = (u64)-1;
 		}
 
 		nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
@@ -2229,11 +2230,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (cow_start != (u64)-1) {
 		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
-		cow_start = (u64)-1;
 		if (ret) {
 			cow_end = end;
 			goto error;
 		}
+		cow_start = (u64)-1;
 	}
 
 	btrfs_free_path(path);
@@ -2249,25 +2250,40 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 *
 	 *    For range [start, cur_offset) the folios are already unlocked (except
 	 *    @locked_folio), EXTENT_DELALLOC already removed.
-	 *    Only need to clear the dirty flag as they will never be submitted.
-	 *    Ordered extent and extent maps are handled by
-	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
+	 *    Need to finish the ordered extents and their extent maps, then
+	 *    clear the dirty flag as they will never to submitted.
 	 *
 	 * 2) Failed with error from fallback_to_cow()
-	 *    start         cur_offset  cow_end    end
+	 *    start         cow_start  cow_end    end
 	 *    |/////////////|-----------|          |
 	 *
-	 *    For range [start, cur_offset) it's the same as case 1).
-	 *    But for range [cur_offset, cow_end), the folios have dirty flag
+	 *    Special note for this case, @cur_offset may be set to either
+	 *    @cow_end or @cow_start.
+	 *    So for such fallback_to_cow() case, we should not trust @cur_offset
+	 *    but @cow_start.
+	 *    For range [start, cow_start) it's the same as case 1).
+	 *    But for range [cow_start, cow_end), the folios have dirty flag
 	 *    cleared and unlocked, EXTENT_DEALLLOC cleared by cow_file_range().
 	 *
 	 *    Thus we should not call extent_clear_unlock_delalloc() on range
-	 *    [cur_offset, cow_end), as the folios are already unlocked.
+	 *    [cow_start, cow_end), as the folios are already unlocked.
 	 *
-	 * So clear the folio dirty flags for [start, cur_offset) first.
+	 * So clear the folio dirty flags for [start, cur_offset) and finish
+	 * involved ordered extents.
+	 *
+	 * There is a special handling for COW case, where we advanced cur_offset to
+	 * the COW end already. For those cases we need to rewind the cur_offset to
+	 * the real correct location.
 	 */
-	if (cur_offset > start)
+	if (cow_start != (u64)-1) {
+		ASSERT(cow_end);
+		ASSERT(cur_offset >= cow_start);
+		cur_offset = cow_start;
+	}
+	if (cur_offset > start) {
+		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
 		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+	}
 
 	/*
 	 * If an error happened while a COW region is outstanding, cur_offset
@@ -2332,7 +2348,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 	if (should_nocow(inode, start, end)) {
 		ret = run_delalloc_nocow(inode, locked_folio, start, end);
-		goto out;
+		return ret;
 	}
 
 	if (btrfs_inode_can_compress(inode) &&
@@ -2346,10 +2362,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	else
 		ret = cow_file_range(inode, locked_folio, start, end, NULL,
 				     false, false);
-
-out:
-	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 	return ret;
 }
 
-- 
2.47.1


