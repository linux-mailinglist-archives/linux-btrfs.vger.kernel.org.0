Return-Path: <linux-btrfs+bounces-10222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939AB9EC8AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F4281946
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809102210DC;
	Wed, 11 Dec 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NBoBCsoK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NBoBCsoK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1C2040B2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908603; cv=none; b=E+VxvlgpG6CHIBtFiqt4Z3BPHsvIX21GoJD+iT6+pSIn9hfcJLIP1GHpc2v65p9A4cvkoglXEyDrAjkru5pL2p2cjhSCbLTr+he4u3A+7mP+zgyipaftE62vYauog+addjvWIO2Kp+v77bDGIZWVLdKGxzz4kCQVQLbbGO8+FUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908603; c=relaxed/simple;
	bh=2maFmEwlQHorfFEKtEkw/4s2H2zTK60ENI/YtTH5/Zk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E7Miyu42D9LO1ProRyDMTP6QcMXc0CdYRBJUVfcaaHwb/yORepea33Lle9JwGQz9gjXr4nk55ll1vlHKygyJ5fF+PqA59ZgHdRcLiOhn6i+ENQemwfYSUTgcTPrz6AvSLOb+2hJYnVA/JXSLWZeK2KAPEj4pMJMQ2BgYk1x0LW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NBoBCsoK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NBoBCsoK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B71E821166
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733908599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9tgdKevOesIbXHDvp3fGUzyhmqcZqlpM3/89Ivuu6IU=;
	b=NBoBCsoKn29L5wRH3xb+VrQGROz65uRrtifTR6i0ph43M6AjVlPSPPyU653UedfyyZYxam
	m2+HOCCFSEpg9E2zkjACWv2UTKR5n52LqUTtvEQ7sMLR53Cpv7W3Zro3iav6S4OPD8PLjQ
	xJFBd94U+gz0kHIvnECjzh+hFvEg71o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733908599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9tgdKevOesIbXHDvp3fGUzyhmqcZqlpM3/89Ivuu6IU=;
	b=NBoBCsoKn29L5wRH3xb+VrQGROz65uRrtifTR6i0ph43M6AjVlPSPPyU653UedfyyZYxam
	m2+HOCCFSEpg9E2zkjACWv2UTKR5n52LqUTtvEQ7sMLR53Cpv7W3Zro3iav6S4OPD8PLjQ
	xJFBd94U+gz0kHIvnECjzh+hFvEg71o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED48813983
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 09:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5H+jKnZYWWdvRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 09:16:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: enhance ordered extent double freeing detection
Date: Wed, 11 Dec 2024 19:46:21 +1030
Message-ID: <192dc91881d143a4ae2b13cd9d8769f62b6fda8c.1733908542.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

With recent bugs exposed through run_delalloc_range() failure, the
importance of detecting double accounting is obvious.

Currently the way to detect such errors is to just check if we underflow
the btrfs_ordered_extent::bytes_left member.

That's fine but that only shows the length we're trying to decrease, not
enough to show the problem.

Here we enhance the situation by:

- Introduce btrfs_ordered_extent::finished_bitmap
  This is a new bitmap to indicate which blocks are already finished.
  This bitmap will be initialized at alloc_ordered_extent() and release
  when the ordered extent is freed.

- Detect any already finished block during can_finish_ordered_extent()
  If double accounting detected, show the full range we're trying and the bitmap.

- Make sure the bitmap is all set when the OE is finished

- Show the full range we're finishing for the existing double accounting
  detection
  This is to enhance the code to work with the new run_delalloc_range()
  error messages.

This will have extra memory and runtime cost, now an ordered extent can
have as large as 4K memory just for the finished_bitmap, and extra
operations to detect such double accounting.

Thus this double accounting detection is only enabled for
CONFIG_BTRFS_DEBUG build for developers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a false alert when the ordered extent is truncated
  In that case the bitmap's length should be based on truncated_len.
---
 fs/btrfs/misc.h         | 28 +++++++++++++++++++
 fs/btrfs/ordered-data.c | 60 +++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/ordered-data.h |  9 +++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 0d599fd847c9..438887a1ca32 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -163,4 +163,32 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
 	return (found_set == start + nbits);
 }
 
+/*
+ * Count how many bits are set in the bitmap.
+ *
+ * Similar to bitmap_weight() but accepts a subrange of the bitmap.
+ */
+static inline unsigned int bitmap_count_set(const unsigned long *addr,
+					    unsigned long start,
+					    unsigned long nbits)
+{
+	const unsigned long bitmap_nbits = start + nbits;
+	unsigned long cur = start;
+	unsigned long total_set = 0;
+
+	while (cur < bitmap_nbits) {
+		unsigned long found_zero;
+		unsigned long found_set;
+
+		found_zero = find_next_zero_bit(addr, bitmap_nbits, cur);
+		total_set += found_zero - cur;
+
+		cur = found_zero;
+		if (cur >= bitmap_nbits)
+			break;
+		found_set = find_next_bit(addr, bitmap_nbits, cur);
+		cur = found_set;
+	}
+	return total_set;
+}
 #endif
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 30eceaf829a7..31a2c6f06776 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -194,6 +194,16 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	INIT_LIST_HEAD(&entry->bioc_list);
 	init_completion(&entry->completion);
 
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
+		struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+		entry->finished_bitmap = bitmap_zalloc(
+			num_bytes >> fs_info->sectorsize_bits, GFP_NOFS);
+		if (!entry->finished_bitmap) {
+			kmem_cache_free(btrfs_ordered_extent_cache, entry);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
 	/*
 	 * We don't need the count_max_extents here, we can assume that all of
 	 * that work has been done at higher layers, so this is truly the
@@ -356,13 +366,38 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 		btrfs_folio_clear_ordered(fs_info, folio, file_offset, len);
 	}
 
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
+		unsigned long start_bit;
+		unsigned long nbits;
+		unsigned long nr_set;
+
+		ASSERT(file_offset >= ordered->file_offset);
+		ASSERT(file_offset + len <= ordered->file_offset  + ordered->num_bytes);
+
+		start_bit = (file_offset - ordered->file_offset) >> fs_info->sectorsize_bits;
+		nbits = len >> fs_info->sectorsize_bits;
+
+		nr_set = bitmap_count_set(ordered->finished_bitmap, start_bit, nbits);
+		if (WARN_ON(nr_set)) {
+			btrfs_crit(fs_info,
+"double ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu range offset=%llu range len=%llu already finished len=%lu finish_bitmap=%*pbl",
+				   btrfs_root_id(inode->root), btrfs_ino(inode),
+				   ordered->file_offset, ordered->num_bytes,
+				   file_offset, len, nr_set << fs_info->sectorsize_bits,
+				   (int)(ordered->num_bytes >> fs_info->sectorsize_bits),
+				   ordered->finished_bitmap);
+		}
+		bitmap_set(ordered->finished_bitmap, start_bit, nbits);
+		len -= (nr_set << fs_info->sectorsize_bits);
+	}
+
 	/* Now we're fine to update the accounting. */
 	if (WARN_ON_ONCE(len > ordered->bytes_left)) {
 		btrfs_crit(fs_info,
-"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu to_dec=%llu left=%llu",
+"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu range start=%llu range len=%llu left=%llu",
 			   btrfs_root_id(inode->root), btrfs_ino(inode),
 			   ordered->file_offset, ordered->num_bytes,
-			   len, ordered->bytes_left);
+			   file_offset, len, ordered->bytes_left);
 		ordered->bytes_left = 0;
 	} else {
 		ordered->bytes_left -= len;
@@ -379,6 +414,25 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	 * the finish_func to be executed.
 	 */
 	set_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags);
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
+		u64 real_len;
+
+		if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags))
+			real_len = ordered->truncated_len;
+		else
+			real_len = ordered->num_bytes;
+
+		if (WARN_ON(!bitmap_full(ordered->finished_bitmap,
+					 real_len >> fs_info->sectorsize_bits))) {
+			btrfs_crit(fs_info,
+"ordered extent finished bitmap desync, root=%llu ino=%llu OE offset=%llu OE len=%llu bytes_left=%llu bitmap=%*pbl",
+				btrfs_root_id(inode->root), btrfs_ino(inode),
+				ordered->file_offset, ordered->num_bytes,
+				ordered->bytes_left,
+				(int)(ordered->num_bytes >> fs_info->sectorsize_bits),
+				ordered->finished_bitmap);
+		}
+	}
 	cond_wake_up(&ordered->wait);
 	refcount_inc(&ordered->refs);
 	trace_btrfs_ordered_extent_mark_finished(inode, ordered);
@@ -624,6 +678,8 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 			list_del(&sum->list);
 			kvfree(sum);
 		}
+		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
+			bitmap_free(entry->finished_bitmap);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4e152736d06c..f04a2f7a593a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -154,6 +154,15 @@ struct btrfs_ordered_extent {
 	struct list_head work_list;
 
 	struct list_head bioc_list;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/*
+	 * Set if one block has finished.
+	 *
+	 * To catch double freeing with more accuracy.
+	 */
+	unsigned long *finished_bitmap;
+#endif
 };
 
 int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent);
-- 
2.47.1


