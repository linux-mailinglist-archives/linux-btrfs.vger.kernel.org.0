Return-Path: <linux-btrfs+bounces-3210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29622878D69
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944AE1F2234B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641B9B66F;
	Tue, 12 Mar 2024 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="syG4JggP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="syG4JggP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C4AD58
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213116; cv=none; b=e3R0v5NJaKP7NjNDtwfW3ogULdgT8HCJ7J9k5XNZoyS5C0fsV8ewxXDet5Aaar4jC0dGFuZe9VpzpP9OdBpqM0ffJVYz4eNs5ZDVky3ZosAUyhbWb9V3pglpl3442q2dJeZBqP2GXHOe1aVNXLl/wEKF3WYLn/6QuAnnFXvOjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213116; c=relaxed/simple;
	bh=3olZ5gvXJpgFCwS9QiYDKZNvyyG5zydgK5TRl3el7pw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDvfQay19AqjKTLZ/Txyr3Z3Yl2nuU/rHJ98bmVOiUOSWNOKTbhM701YcZE1ZL39MDMRQCbRHyq5Li5ZzYwzFRL6/5UD9oQtb73eD7RbfYTDb4wbMpXq/eW7qMtlUD2jil3IBikznQzR9FGH/s75fp45prmsQD9hKlIYy/qV2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=syG4JggP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=syG4JggP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6257A37167
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710213112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGMytFtA0NfDdWwjVj+y1p+ML1Mx7CxUmegSzIGmyZQ=;
	b=syG4JggP5SSF1XxH7PLGGDkIWeKmCCys5O9h8UoroojeIEAWvihK9m2aISvMHbjvhq5LNR
	ReUUgs+hDKoV+Tc01/6xtc7VcFtubXuh1ps4+/bzDXbObPu/YRc3M4Aw21OJedAVGVfUqW
	jadY4VbQTnvPr/r+6TKgWtJHbq/D5pI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710213112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGMytFtA0NfDdWwjVj+y1p+ML1Mx7CxUmegSzIGmyZQ=;
	b=syG4JggP5SSF1XxH7PLGGDkIWeKmCCys5O9h8UoroojeIEAWvihK9m2aISvMHbjvhq5LNR
	ReUUgs+hDKoV+Tc01/6xtc7VcFtubXuh1ps4+/bzDXbObPu/YRc3M4Aw21OJedAVGVfUqW
	jadY4VbQTnvPr/r+6TKgWtJHbq/D5pI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F5D813695
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFb+CPfH72WZSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:11:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: defrag: allow fine-tuning defrag behavior based on file extent usage
Date: Tue, 12 Mar 2024 13:41:30 +1030
Message-ID: <117440b02c88ed5f29fa805b651c3d225310c25a.1710212957.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710212957.git.wqu@suse.com>
References: <cover.1710212957.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 1.90
X-Spam-Flag: NO

Previously we're using a fixed usage ratio and wasted bytes for file
extents which can not be merged with any adjacent ones, but may still
free up some space.

This patch would enhance the behavior by allowing fine-tuning using some
extra members inside btrfs_ioctl_defrag_range_args.

This would introduce two flags and two new members:

- BTRFS_DEFRAG_RANGE_USAGE_RATIO and BTRFS_DEFRAG_RANGE_WASTED_BYTES
  With these flags set, defrag would consider file extents with their
  usage ratio and wasted bytes as a defrag condition.

- usage_ratio
  This is a u32 value, but only [0, 100] is allowed.
  0 means disable usage ratio detection, aka no extra file extents
  would be defragged based on their usage ratio at all.

  1 means file extents which refer less than 1% of the on-disk extent
  size would be defragged.

- wasted_bytes
  This is a u32 value.
  The "wasted" bytes are just the difference between file extent size
  against on-disk extent size. (That's if the file extent size is
  smaller than the on-disk extent size).

  This "wasted" calculation doesn't take other file extents into
  consideration, thus it's not ensured to free up space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c          | 38 +++++++++++++++++-------------------
 fs/btrfs/ioctl.c           |  6 ++++++
 include/uapi/linux/btrfs.h | 40 +++++++++++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 42f59d1456f9..d7fdecaeafb6 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -958,26 +958,16 @@ struct defrag_target_range {
  * any adjacent ones), but we may still want to defrag them, to free up
  * some space if possible.
  */
-static bool should_defrag_under_utilized(struct extent_map *em)
+static bool should_defrag_under_utilized(struct extent_map *em,
+					 u32 usage_ratio, u32 wasted_bytes)
 {
-	/*
-	 * Ratio based check.
-	 *
-	 * If the current extent is only utilizing 1/16 of its on-disk size,
-	 * it's definitely under-utilized, and defragging it may free up
-	 * the whole extent.
-	 */
-	if (em->len < em->orig_block_len / 16)
+	/* Ratio based check. */
+	if (em->len < div_u64(em->orig_block_len * usage_ratio, 100))
 		return true;
 
-	/*
-	 * Wasted space based check.
-	 *
-	 * If we can free up at least 16MiB, then it may be a good idea
-	 * to defrag.
-	 */
+	/* Wasted space based check. */
 	if (em->len < em->orig_block_len &&
-	    em->orig_block_len - em->len > SZ_16M)
+	    em->orig_block_len - em->len > wasted_bytes)
 		return true;
 	return false;
 }
@@ -999,6 +989,7 @@ static bool should_defrag_under_utilized(struct extent_map *em)
 static int defrag_collect_targets(struct btrfs_inode *inode,
 				  u64 start, u64 len, u32 extent_thresh,
 				  u64 newer_than, bool do_compress,
+				  u32 usage_ratio, u32 wasted_bytes,
 				  bool locked, struct list_head *target_list,
 				  u64 *last_scanned_ret)
 {
@@ -1109,7 +1100,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			 * But if we may free up some space, it is still worth
 			 * defragging.
 			 */
-			if (should_defrag_under_utilized(em))
+			if (should_defrag_under_utilized(em, usage_ratio,
+							 wasted_bytes))
 				goto add;
 
 			/* Empty target list, no way to merge with last entry */
@@ -1241,6 +1233,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 
 static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 			    u32 extent_thresh, u64 newer_than, bool do_compress,
+			    u32 usage_ratio, u32 wasted_bytes,
 			    u64 *last_scanned_ret)
 {
 	struct extent_state *cached_state = NULL;
@@ -1286,7 +1279,8 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	 * so that we won't relock the extent range and cause deadlock.
 	 */
 	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, true,
+				     newer_than, do_compress, usage_ratio,
+				     wasted_bytes, true,
 				     &target_list, last_scanned_ret);
 	if (ret < 0)
 		goto unlock_extent;
@@ -1319,6 +1313,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 			      struct file_ra_state *ra,
 			      u64 start, u32 len, u32 extent_thresh,
 			      u64 newer_than, bool do_compress,
+			      u32 usage_ratio, u32 wasted_bytes,
 			      unsigned long *sectors_defragged,
 			      unsigned long max_sectors,
 			      u64 *last_scanned_ret)
@@ -1330,7 +1325,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	int ret;
 
 	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, false,
+				     newer_than, do_compress, usage_ratio,
+				     wasted_bytes, false,
 				     &target_list, NULL);
 	if (ret < 0)
 		goto out;
@@ -1370,6 +1366,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		 */
 		ret = defrag_one_range(inode, entry->start, range_len,
 				       extent_thresh, newer_than, do_compress,
+				       usage_ratio, wasted_bytes,
 				       last_scanned_ret);
 		if (ret < 0)
 			break;
@@ -1495,7 +1492,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			BTRFS_I(inode)->defrag_compress = compress_type;
 		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
 				cluster_end + 1 - cur, extent_thresh,
-				newer_than, do_compress, &sectors_defragged,
+				newer_than, do_compress, range->usage_ratio,
+				range->wasted_bytes, &sectors_defragged,
 				max_to_defrag, &last_scanned);
 
 		if (sectors_defragged > prev_sectors_defragged)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 38459a89b27c..b6d1844b5bbe 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2635,6 +2635,12 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
 				range.extent_thresh = (u32)-1;
 			}
+
+			if (range.flags & BTRFS_DEFRAG_RANGE_LONE_RATIO &&
+			    range.usage_ratio > 100) {
+				ret = -EINVAL;
+				goto out;
+			}
 		} else {
 			/* the rest are all set to zero by kzalloc */
 			range.len = (u64)-1;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index cdf6ad872149..6c9d9cfa5b8a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -613,10 +613,14 @@ struct btrfs_ioctl_clone_range_args {
  * Used by:
  * struct btrfs_ioctl_defrag_range_args.flags
  */
-#define BTRFS_DEFRAG_RANGE_COMPRESS 1
-#define BTRFS_DEFRAG_RANGE_START_IO 2
-#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
-					 BTRFS_DEFRAG_RANGE_START_IO)
+#define BTRFS_DEFRAG_RANGE_COMPRESS		(1ULL << 0)
+#define BTRFS_DEFRAG_RANGE_START_IO		(1ULL << 1)
+#define BTRFS_DEFRAG_RANGE_LONE_RATIO		(1ULL << 2)
+#define BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES	(1ULL << 3)
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |	\
+					 BTRFS_DEFRAG_RANGE_START_IO |	\
+					 BTRFS_DEFRAG_RANGE_LONE_RATIO |\
+					 BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES)
 
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
@@ -645,8 +649,34 @@ struct btrfs_ioctl_defrag_range_args {
 	 */
 	__u32 compress_type;
 
+	/*
+	 * File extents which has lower usage ratio than this would be defragged.
+	 *
+	 * Valid values are [0, 100].
+	 *
+	 * 0 means no check based on usage ratio.
+	 * 1 means one file extent would be defragged if its referred size
+	 * (file extent num bytes) is smaller than 1% of its on-disk extent size.
+	 * 100 means one file extent would be defragged if its referred size
+	 * (file extent num bytes) is smaller than 100% of its on-disk extent size.
+	 */
+	__u32 usage_ratio;
+
+	/*
+	 * File extents which has more "wasted" bytes than this would be
+	 * defragged.
+	 *
+	 * "Wasted" bytes just means the difference between the file extent size
+	 * (file extent num bytes) against the on-disk extent size
+	 * (file extent disk num bytes).
+	 *
+	 * Valid values are [0, U32_MAX], but values larger than
+	 * BTRFS_MAX_EXTENT_SIZE would not make much sense.
+	 */
+	__u32 wasted_bytes;
+
 	/* spare for later */
-	__u32 unused[4];
+	__u32 unused[2];
 };
 
 
-- 
2.44.0


