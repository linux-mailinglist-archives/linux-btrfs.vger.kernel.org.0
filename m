Return-Path: <linux-btrfs+bounces-11942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226FA49C61
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC46D3A7A0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD7270EA4;
	Fri, 28 Feb 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EScwuuAA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EScwuuAA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2E26E94D
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754174; cv=none; b=iQ/hf3z/r2J2YGR5Ark0wwuVeNAFBBm0ZJtShtnTtLB0Ie+HpyHwQ0TFHiRIObu4+8ODrZbiLJvEXqOXLCtEq+HsfTfwDo+OaSS9CNmbX8RhzPW10A6Jlktg1jdq2DInia5QDCZNqUh3RWkfBKsLvHBU2ogUPBnlwyipdEmP0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754174; c=relaxed/simple;
	bh=kD/S6LssMrK1MlIiJ9MOu7xdp/mIAichYP7gqhcotWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbFBcoU/ZPAmZ/7eF4aWHHdut4ae9AxWpncKHHmHwG8lTmIbUECV/AZr8O4pNdpYg86Ukab3rA4ZOmKqJ1nMQLp2U317r4vsBEoeDqKcViodreN8uPcXFRg93cCroh0IecQfmNLEZ3sziyA8EXcfYCUok3dVfkR32RDhWpWzcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EScwuuAA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EScwuuAA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFD031F38F;
	Fri, 28 Feb 2025 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7VO1cA/KkW7D7hWqF+niKov7bfZX7rmYWAXxRGLOPw=;
	b=EScwuuAAsbT8nGMTTVYxqbB63ryxSSUmz+YhQ6DsRIqtREr3D8aiDvfit+DqX5ysBxakn4
	qsF0YPC2BPhRWxmP41ujR2tUAjBzGnMPUpYqNO/+aRRpfqSk4oqfUgoCYghinzrkih/U2M
	3i9EquSY6BnAiDSYXnb4Cpb5oqfDv7A=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7VO1cA/KkW7D7hWqF+niKov7bfZX7rmYWAXxRGLOPw=;
	b=EScwuuAAsbT8nGMTTVYxqbB63ryxSSUmz+YhQ6DsRIqtREr3D8aiDvfit+DqX5ysBxakn4
	qsF0YPC2BPhRWxmP41ujR2tUAjBzGnMPUpYqNO/+aRRpfqSk4oqfUgoCYghinzrkih/U2M
	3i9EquSY6BnAiDSYXnb4Cpb5oqfDv7A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9610137AC;
	Fri, 28 Feb 2025 14:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2jNKLfnMwWdQPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Feb 2025 14:49:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: extend trim callchains to pass the operation type
Date: Fri, 28 Feb 2025 15:49:29 +0100
Message-ID: <1d52d90b72769dd652253987e2fcc144d865b345.1740753608.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740753608.git.dsterba@suse.com>
References: <cover.1740753608.git.dsterba@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Preparatory work for more than trim/discard operation that can be
performed on the unused space from an ioctl. As FITRIM is not
extensible, we'll need a new one. Now we extend any caller that takes
part in the trim/discard to take one parameter defining the type of
operation.

The operation multiplexer btrfs_issue_clear_op() will be extended in
followup patches.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/discard.c          |  4 +--
 fs/btrfs/extent-tree.c      | 51 +++++++++++++++++++++++--------------
 fs/btrfs/extent-tree.h      |  3 ++-
 fs/btrfs/free-space-cache.c | 29 +++++++++++----------
 fs/btrfs/free-space-cache.h |  8 +++---
 fs/btrfs/inode.c            |  2 +-
 fs/btrfs/volumes.c          |  3 ++-
 include/uapi/linux/btrfs.h  |  8 ++++++
 8 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e815d165cccc..cd7220465f1f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -518,13 +518,13 @@ static void btrfs_discard_workfn(struct work_struct *work)
 		btrfs_trim_block_group_bitmaps(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
-				       minlen, maxlen, true);
+				       minlen, maxlen, true, BTRFS_CLEAR_OP_DISCARD);
 		discard_ctl->discard_bitmap_bytes += trimmed;
 	} else {
 		btrfs_trim_block_group_extents(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
-				       minlen, true);
+				       minlen, true, BTRFS_CLEAR_OP_DISCARD);
 		discard_ctl->discard_extent_bytes += trimmed;
 	}
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5de1a1293c93..df86ffde478b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1247,8 +1247,20 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int btrfs_issue_clear_op(struct block_device *bdev, u64 start, u64 size,
+				enum btrfs_clear_op_type clear)
+{
+	switch (clear) {
+	case BTRFS_CLEAR_OP_DISCARD:
+		return blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
+					    size >> SECTOR_SHIFT, GFP_NOFS);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
-			       u64 *discarded_bytes)
+			       u64 *discarded_bytes, enum btrfs_clear_op_type clear)
 {
 	int j, ret = 0;
 	u64 bytes_left, end;
@@ -1293,11 +1305,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 			bytes_left = end - start;
 			continue;
 		}
-
 		if (size) {
-			ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-						   size >> SECTOR_SHIFT,
-						   GFP_NOFS);
+			ret = btrfs_issue_clear_op(bdev, start, size, clear);
 			if (!ret)
 				*discarded_bytes += size;
 			else if (ret != -EOPNOTSUPP)
@@ -1315,9 +1324,7 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	while (bytes_left) {
 		u64 bytes_to_discard = min(BTRFS_MAX_DISCARD_CHUNK_SIZE, bytes_left);
 
-		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_to_discard >> SECTOR_SHIFT,
-					   GFP_NOFS);
+		ret = btrfs_issue_clear_op(bdev, start, bytes_left, clear);
 
 		if (ret) {
 			if (ret != -EOPNOTSUPP)
@@ -1338,7 +1345,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	return ret;
 }
 
-static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
+static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes,
+			     enum btrfs_clear_op_type clear)
 {
 	struct btrfs_device *dev = stripe->dev;
 	struct btrfs_fs_info *fs_info = dev->fs_info;
@@ -1367,7 +1375,7 @@ static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
 					      &discarded);
 		discarded += src_disc;
 	} else if (bdev_max_discard_sectors(stripe->dev->bdev)) {
-		ret = btrfs_issue_discard(dev->bdev, phys, len, &discarded);
+		ret = btrfs_issue_discard(dev->bdev, phys, len, &discarded, clear);
 	} else {
 		ret = 0;
 		*bytes = 0;
@@ -1379,7 +1387,8 @@ static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
 }
 
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes)
+			 u64 num_bytes, u64 *actual_bytes,
+			 enum btrfs_clear_op_type clear)
 {
 	int ret = 0;
 	u64 discarded_bytes = 0;
@@ -1418,7 +1427,7 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 					&stripe->dev->dev_state))
 				continue;
 
-			ret = do_discard_extent(stripe, &bytes);
+			ret = do_discard_extent(stripe, &bytes, clear);
 			if (ret) {
 				/*
 				 * Keep going if discard is not supported by the
@@ -2837,7 +2846,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
-						   end + 1 - start, NULL);
+						   end + 1 - start, NULL,
+						   BTRFS_CLEAR_OP_DISCARD);
 
 		clear_extent_dirty(unpin, start, end, &cached_state);
 		ret = unpin_extent_range(fs_info, start, end, true);
@@ -2866,7 +2876,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			ret = btrfs_discard_extent(fs_info,
 						   block_group->start,
 						   block_group->length,
-						   &trimmed);
+						   &trimmed,
+						   BTRFS_CLEAR_OP_DISCARD);
 
 		list_del_init(&block_group->bg_list);
 		btrfs_unfreeze_block_group(block_group);
@@ -6360,7 +6371,8 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
  * it while performing the free space search since we have already
  * held back allocations.
  */
-static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
+static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed,
+				   enum btrfs_clear_op_type clear)
 {
 	u64 start = BTRFS_DEVICE_RANGE_RESERVED, len = 0, end = 0;
 	int ret;
@@ -6425,8 +6437,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 			break;
 		}
 
-		ret = btrfs_issue_discard(device->bdev, start, len,
-					  &bytes);
+		ret = btrfs_issue_discard(device->bdev, start, len, &bytes, clear);
 		if (!ret)
 			set_extent_bit(&device->alloc_state, start,
 				       start + bytes - 1, CHUNK_TRIMMED, NULL);
@@ -6508,7 +6519,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 						     &group_trimmed,
 						     start,
 						     end,
-						     range->minlen);
+						     range->minlen,
+						     BTRFS_CLEAR_OP_DISCARD);
 
 			trimmed += group_trimmed;
 			if (ret) {
@@ -6529,7 +6541,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 			continue;
 
-		ret = btrfs_trim_free_extents(device, &group_trimmed);
+		ret = btrfs_trim_free_extents(device, &group_trimmed,
+					      BTRFS_CLEAR_OP_DISCARD);
 
 		trimmed += group_trimmed;
 		if (ret) {
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 0ed682d9ed7b..c8e1a30309ab 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -163,7 +163,8 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct extent_buffer *parent);
 void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes);
+			 u64 num_bytes, u64 *actual_bytes,
+			 enum btrfs_clear_op_type clear);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 
 #endif
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3095cce904b5..161fdcab07e4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3652,7 +3652,8 @@ static int do_trimming(struct btrfs_block_group *block_group,
 		       u64 *total_trimmed, u64 start, u64 bytes,
 		       u64 reserved_start, u64 reserved_bytes,
 		       enum btrfs_trim_state reserved_trim_state,
-		       struct btrfs_trim_range *trim_entry)
+		       struct btrfs_trim_range *trim_entry,
+		       enum btrfs_clear_op_type clear)
 {
 	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
@@ -3674,7 +3675,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 
-	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
+	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed, clear);
 	if (!ret) {
 		*total_trimmed += trimmed;
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
@@ -3711,7 +3712,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
  */
 static int trim_no_bitmap(struct btrfs_block_group *block_group,
 			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
-			  bool async)
+			  bool async, enum btrfs_clear_op_type clear)
 {
 	struct btrfs_discard_ctl *discard_ctl =
 					&block_group->fs_info->discard_ctl;
@@ -3800,7 +3801,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
 				  extent_start, extent_bytes, extent_trim_state,
-				  &trim_entry);
+				  &trim_entry, clear);
 		if (ret) {
 			block_group->discard_cursor = start + bytes;
 			break;
@@ -3877,7 +3878,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
  */
 static int trim_bitmaps(struct btrfs_block_group *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
-			u64 maxlen, bool async)
+			u64 maxlen, bool async, enum btrfs_clear_op_type clear)
 {
 	struct btrfs_discard_ctl *discard_ctl =
 					&block_group->fs_info->discard_ctl;
@@ -3986,7 +3987,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		mutex_unlock(&ctl->cache_writeout_mutex);
 
 		ret = do_trimming(block_group, total_trimmed, start, bytes,
-				  start, bytes, 0, &trim_entry);
+				  start, bytes, 0, &trim_entry, clear);
 		if (ret) {
 			reset_trimming_bitmap(ctl, offset);
 			block_group->discard_cursor =
@@ -4020,7 +4021,8 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 }
 
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
-			   u64 *trimmed, u64 start, u64 end, u64 minlen)
+			   u64 *trimmed, u64 start, u64 end, u64 minlen,
+			   enum btrfs_clear_op_type clear)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	int ret;
@@ -4038,11 +4040,11 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	btrfs_freeze_block_group(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, false);
+	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, false, clear);
 	if (ret)
 		goto out;
 
-	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, 0, false);
+	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, 0, false, clear);
 	div64_u64_rem(end, BITS_PER_BITMAP * ctl->unit, &rem);
 	/* If we ended in the middle of a bitmap, reset the trimming flag */
 	if (rem)
@@ -4054,7 +4056,7 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 
 int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async)
+				   bool async, enum btrfs_clear_op_type clear)
 {
 	int ret;
 
@@ -4068,7 +4070,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 	btrfs_freeze_block_group(block_group);
 	spin_unlock(&block_group->lock);
 
-	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, async);
+	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, async, clear);
 	btrfs_unfreeze_block_group(block_group);
 
 	return ret;
@@ -4076,7 +4078,8 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   u64 maxlen, bool async)
+				   u64 maxlen, bool async,
+				   enum btrfs_clear_op_type clear)
 {
 	int ret;
 
@@ -4091,7 +4094,7 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 	spin_unlock(&block_group->lock);
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
-			   async);
+			   async, clear);
 
 	btrfs_unfreeze_block_group(block_group);
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 9f1dbfdee8ca..c4c2e5571355 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -159,13 +159,15 @@ void btrfs_return_cluster_to_free_space(
 			       struct btrfs_block_group *block_group,
 			       struct btrfs_free_cluster *cluster);
 int btrfs_trim_block_group(struct btrfs_block_group *block_group,
-			   u64 *trimmed, u64 start, u64 end, u64 minlen);
+			   u64 *trimmed, u64 start, u64 end, u64 minlen,
+			   enum btrfs_clear_op_type clear);
 int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   bool async);
+				   bool async, enum btrfs_clear_op_type clear);
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
-				   u64 maxlen, bool async);
+				   u64 maxlen, bool async,
+				   enum btrfs_clear_op_type clear);
 
 bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
 int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f9bd9242acd3..282ccd1869c0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3289,7 +3289,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 				btrfs_discard_extent(fs_info,
 						ordered_extent->disk_bytenr,
 						ordered_extent->disk_num_bytes,
-						NULL);
+						NULL, BTRFS_CLEAR_OP_DISCARD);
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, 1);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 515003a23e65..b6d007e358d4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3534,7 +3534,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * filesystem's point of view.
 	 */
 	if (btrfs_is_zoned(fs_info)) {
-		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL);
+		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL,
+					   BTRFS_CLEAR_OP_DISCARD);
 		if (ret)
 			btrfs_info(fs_info,
 				"failed to reset zone %llu after relocation",
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d3b222d7af24..64f971a6bcb2 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1086,6 +1086,14 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
+/*
+ * Type of operation that will be used to clear unused blocks.
+ */
+enum btrfs_clear_op_type {
+	BTRFS_CLEAR_OP_DISCARD,
+	BTRFS_NR_CLEAR_OP_TYPES,
+};
+
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
-- 
2.47.1


