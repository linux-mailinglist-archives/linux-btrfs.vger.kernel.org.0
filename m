Return-Path: <linux-btrfs+bounces-2134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FEA84AAD0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE5B2379D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D44CE0B;
	Mon,  5 Feb 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EfVtKw72";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EfVtKw72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFA1AB7E9
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176768; cv=none; b=dvZzBAvcdoqqD1bJh7tPx47JRRuIiVExW8XW8m7p2h0j6UW9vMdC7zJg79qPHHskctywV3FHaek4Vcpbpah6zxtW5xwpbXx9VCCm65mUSO+LttHtmJ4dnMwPpU0OiyRnZgViwKF3oiN3+TeeJ1LSx8/XtTPDETiscSOpzgtpH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176768; c=relaxed/simple;
	bh=ztt35p37o7CCiKlwUIetjOUq/JPcVPpjXCoC0qZJzSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEb7mQdOYS9ZQTd4/TS/E8tTnf0iRZ31B+jkhkI1mxZMAvc2STj1Hwb59yhMc2wFDVARkLNfzjTxRD9J47Doc/OBRQrRt55Envg7XHf9gqaE5ioLnae/uAbi29e/88H4GbZzK1HNdTU9Yp+ZUCFWAK6gBO+ZcxTjJYU2xVo8/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EfVtKw72; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EfVtKw72; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3C6E22133
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3n+GV8MTQkhOovncwaf9ypUyvvhi6ZXPY8R/MJnCX0=;
	b=EfVtKw72XJZClv66aJ1f3Bz51VlUaZk+MYtKp0btl77o5yNarjhKpPv6FWD1FTPtcJ2ZQp
	49N8/2eCB/HjVe0VVXUOizEo2OCI5bV08UryKote3wphZ68wK51Ud+2/won+6Q09R0KvmW
	sH/co3J/8RT5i8J+kIS7hypV9ySSkA0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3n+GV8MTQkhOovncwaf9ypUyvvhi6ZXPY8R/MJnCX0=;
	b=EfVtKw72XJZClv66aJ1f3Bz51VlUaZk+MYtKp0btl77o5yNarjhKpPv6FWD1FTPtcJ2ZQp
	49N8/2eCB/HjVe0VVXUOizEo2OCI5bV08UryKote3wphZ68wK51Ud+2/won+6Q09R0KvmW
	sH/co3J/8RT5i8J+kIS7hypV9ySSkA0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB1BF136F5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJO5JjpzwWUncAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 23:46:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: defrag: allow fine-tuning on lone extent defrag behavior
Date: Tue,  6 Feb 2024 10:15:56 +1030
Message-ID: <1e862826f30ce2de104b66572ddfbfd6e2d398a5.1707172743.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707172743.git.wqu@suse.com>
References: <cover.1707172743.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Previously we're using a fixed ratio and fixed bytes for lone extents
defragging, which may not fit all situations.

This patch would enhance the behavior by allowing fine-tuning using some
extra members inside btrfs_ioctl_defrag_range_args.

This would introduce two flags and two new members:

- BTRFS_DEFRAG_RANGE_LONE_RATIO and BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES
  With these flags set, defrag would consider lone extents with their
  utilization ratio and wasted bytes as a defrag condition.

- lone_ratio
  This is a u32 value, but only [0, 65536] is allowed (still beyond u16
  range, thus have to go u32).
  0 means disable lone ratio detection.
  [1, 65536] means the ratio. If a lone extent is utilizing less than
  (lone_ratio / 65536) * on-disk size of an extent, it would be
  considered as a defrag target.

- lone_wasted_bytes
  This is a u32 value.
  If we free the lone extent, and can free up to @lone_wasted_bytes
  (excluding the extent itself), then it would be considered as a defrag
  target.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c          | 40 ++++++++++++++++++++++++--------------
 fs/btrfs/ioctl.c           |  9 +++++++++
 include/uapi/linux/btrfs.h | 28 +++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 85c6e45d0cd4..3566845ee3e6 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -958,26 +958,28 @@ struct defrag_target_range {
  * any adjacent ones), but we may still want to defrag them, to free up
  * some space if possible.
  */
-static bool should_defrag_under_utilized(struct extent_map *em)
+static bool should_defrag_under_utilized(struct extent_map *em, u32 lone_ratio,
+					 u32 lone_wasted_bytes)
 {
 	/*
 	 * Ratio based check.
 	 *
-	 * If the current extent is only utilizing 1/16 of its on-disk size,
+	 * If the current extent is only utilizing less than
+	 * (%lone_ratio/65536) of its on-disk size,
 	 * it's definitely under-utilized, and defragging it may free up
 	 * the whole extent.
 	 */
-	if (em->len < em->orig_block_len / 16)
+	if (lone_ratio && em->len < em->orig_block_len * lone_ratio / 65536)
 		return true;
 
 	/*
 	 * Wasted space based check.
 	 *
-	 * If we can free up at least 16MiB, then it may be a good idea
-	 * to defrag.
+	 * If we can free up at least @lone_wasted_bytes, then it may be a
+	 * good idea to defrag.
 	 */
 	if (em->len < em->orig_block_len &&
-	    em->orig_block_len - em->len > SZ_16M)
+	    em->orig_block_len - em->len > lone_wasted_bytes)
 		return true;
 	return false;
 }
@@ -998,7 +1000,8 @@ static bool should_defrag_under_utilized(struct extent_map *em)
  */
 static int defrag_collect_targets(struct btrfs_inode *inode,
 				  u64 start, u64 len, u32 extent_thresh,
-				  u64 newer_than, bool do_compress,
+				  u64 newer_than, u32 lone_ratio,
+				  u32 lone_wasted_bytes, bool do_compress,
 				  bool locked, struct list_head *target_list,
 				  u64 *last_scanned_ret)
 {
@@ -1109,7 +1112,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			 * But if we may free up some space, it is still worth
 			 * defragging.
 			 */
-			if (should_defrag_under_utilized(em))
+			if (should_defrag_under_utilized(em, lone_ratio, lone_wasted_bytes))
 				goto add;
 
 			/* Empty target list, no way to merge with last entry */
@@ -1240,7 +1243,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 }
 
 static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
-			    u32 extent_thresh, u64 newer_than, bool do_compress,
+			    u32 extent_thresh, u64 newer_than,
+			    u32 lone_ratio, u32 lone_wasted_bytes, bool do_compress,
 			    u64 *last_scanned_ret)
 {
 	struct extent_state *cached_state = NULL;
@@ -1286,7 +1290,8 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	 * so that we won't relock the extent range and cause deadlock.
 	 */
 	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, true,
+				     newer_than, lone_ratio, lone_wasted_bytes,
+				     do_compress, true,
 				     &target_list, last_scanned_ret);
 	if (ret < 0)
 		goto unlock_extent;
@@ -1318,7 +1323,9 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 static int defrag_one_cluster(struct btrfs_inode *inode,
 			      struct file_ra_state *ra,
 			      u64 start, u32 len, u32 extent_thresh,
-			      u64 newer_than, bool do_compress,
+			      u64 newer_than, u32 lone_ratio,
+			      u32 lone_wasted_bytes,
+			      bool do_compress,
 			      unsigned long *sectors_defragged,
 			      unsigned long max_sectors,
 			      u64 *last_scanned_ret)
@@ -1330,8 +1337,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	int ret;
 
 	ret = defrag_collect_targets(inode, start, len, extent_thresh,
-				     newer_than, do_compress, false,
-				     &target_list, NULL);
+				     newer_than, lone_ratio, lone_wasted_bytes,
+				     do_compress, false, &target_list, NULL);
 	if (ret < 0)
 		goto out;
 
@@ -1369,7 +1376,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		 * accounting.
 		 */
 		ret = defrag_one_range(inode, entry->start, range_len,
-				       extent_thresh, newer_than, do_compress,
+				       extent_thresh, newer_than, lone_ratio,
+				       lone_wasted_bytes, do_compress,
 				       last_scanned_ret);
 		if (ret < 0)
 			break;
@@ -1495,7 +1503,9 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			BTRFS_I(inode)->defrag_compress = compress_type;
 		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
 				cluster_end + 1 - cur, extent_thresh,
-				newer_than, do_compress, &sectors_defragged,
+				newer_than, range->lone_ratio,
+				range->lone_wasted_bytes, do_compress,
+				&sectors_defragged,
 				max_to_defrag, &last_scanned);
 
 		if (sectors_defragged > prev_sectors_defragged)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 46f9a6645bf6..d2d9b6d440b3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2616,6 +2616,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
 				range.extent_thresh = (u32)-1;
 			}
+
+			if (!(range.flags & BTRFS_DEFRAG_RANGE_LONE_RATIO))
+				range.lone_ratio = 0;
+			else if (range.lone_ratio > 65536) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (!(range.flags & BTRFS_DEFRAG_RANGE_LONE_RATIO))
+				range.lone_wasted_bytes = U32_MAX;
 		} else {
 			/* the rest are all set to zero by kzalloc */
 			range.len = (u64)-1;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f8bc34a6bcfa..3d5517c33f42 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -612,10 +612,14 @@ struct btrfs_ioctl_clone_range_args {
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
@@ -644,8 +648,22 @@ struct btrfs_ioctl_defrag_range_args {
 	 */
 	__u32 compress_type;
 
+	/*
+	 * If a lone extent (has no adjacent file extent) is utilizing less
+	 * than the ratio (0 means 0%, while 65536 means 100%) of the on-disk
+	 * space, it would be considered as a defrag target.
+	 */
+	__u32 lone_ratio;
+
+	/*
+	 * If we defrag a lone extent (has no adjacent file extent) can free
+	 * up more space than this value (in bytes), it would be considered
+	 * as a defrag target.
+	 */
+	__u32 lone_wasted_bytes;
+
 	/* spare for later */
-	__u32 unused[4];
+	__u32 unused[2];
 };
 
 
-- 
2.43.0


