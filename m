Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385D0324873
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 02:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhBYBTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 20:19:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhBYBTG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 20:19:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614215899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ftx4oUCV19rCXvQ44RYbUiRsVz5WB6W+qcB3wLozCO8=;
        b=gr3bOgifVsND20rmMN03FccluYErMSJDz0GJVSfyLnwSonuF00B2AOeKk102KX/pG6DC6o
        9e+PpuvanMLCmaq4njfjw5hoDAN1jEPUlEwo6te4VWF2W2Z1R0xyJHgflmq32b7epqbDeY
        uPu+Qm/6um8oAtpN99SWE3U0ACG6EKU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE8F1ACBF;
        Thu, 25 Feb 2021 01:18:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Erik Jensen <erikjensen@rkjnsn.net>
Subject: [PATCH v2] btrfs: do more graceful error/warning for 32bit kernel
Date:   Thu, 25 Feb 2021 09:18:14 +0800
Message-Id: <20210225011814.24009-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Due to the pagecache limit of 32bit systems, btrfs can't access metadata
at or beyond (ULONG_MAX + 1) << PAGE_SHIFT.
This is 16T for 4K page size while 256T for 64K page size.

And unlike other fses, btrfs uses internally mapped u64 address space for
all of its metadata, this is more tricky than other fses.

Users can have a fs which doesn't have metadata beyond the boundary at
mount time, but later balance can cause btrfs to create metadata beyond
the boundary.

And modification to MM layer is unrealistic just for such minor use
case.

To address such problem, this patch will introduce the following checks,
much like how XFS handles such problem:

- Mount time rejection
  This will reject any fs which has metadata chunk at or beyond the
  boundary.

- Mount time early warning
  If there is any metadata chunk beyond 5/8 of the boundary, we do an
  early warning and hope the end user will see it.

- Runtime extent buffer rejection
  If we're going to allocate an extent buffer at or beyond the boundary,
  reject such request with -EOVERFLOW.
  This is definitely going to cause problems like transaction abort, but
  we have no better ways.

- Runtime extent buffer early warning
  If an extent buffer beyond 5/8 of the max file size is allocated, do
  an early warning.

Above error/warning message will only be outputted once for each fs to
reduce dmesg flood.

Reported-by: Erik Jensen <erikjensen@rkjnsn.net>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Since we're here, there are some alternative methods to support 32bit
better:

- Multiple inodes/address spaces for metadata inodes
  This means we would have multiple metadata inodes.
  Inode 1 for 0~16TB, inodes 2 for 16~32TB, etc.

  The problem is we need to have extra wrapper to read/write metadata
  ranges.

- Remap metadata into 0~16TB range at runtime
  This doesn't really solve the problem, as for fs with metadata usage
  larger than 16T, then we're busted again.
  And the remap mechanism can be pretty complex.

- Use an btrfs internal page cache mechanism
  This can be the most complex way, but it would definitely solve the
  problem.

For now, I prefer method 1, but I still doubt about the test coverage
for 32bit systems, and not sure if it's really worthy.

Changelog:
v2:
- Calculate the boundary using PAGE_SHIFT
- Output the calculated boundary other than hardcoded value
---
 fs/btrfs/ctree.h     | 18 +++++++++++++++
 fs/btrfs/extent_io.c | 12 ++++++++++
 fs/btrfs/super.c     | 26 ++++++++++++++++++++++
 fs/btrfs/volumes.c   | 53 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 40ec3393d2a1..1373cae2db4f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -572,6 +572,12 @@ enum {
 
 	/* Indicate that we can't trust the free space tree for caching yet */
 	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
+
+#if BITS_PER_LONG == 32
+	/* Indicate if we have error/warn message outputted for 32bit system */
+	BTRFS_FS_32BIT_ERROR,
+	BTRFS_FS_32BIT_WARN,
+#endif
 };
 
 /*
@@ -3405,6 +3411,18 @@ static inline void assertfail(const char *expr, const char* file, int line) { }
 #define ASSERT(expr)	(void)(expr)
 #endif
 
+#if BITS_PER_LONG == 32
+#define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
+/*
+ * The warning threshold is 5/8 of the max file size.
+ *
+ * For 4K page size it should be 10T, for 64K it would 160T.
+ */
+#define BTRFS_32BIT_EARLY_WARN_THRESHOLD (BTRFS_32BIT_MAX_FILE_SIZE * 5 / 8)
+void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
+void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
+#endif
+
 /*
  * Get the correct offset inside the page of extent buffer.
  *
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dfb3ead1175..6af6714d49c1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5554,6 +5554,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-EINVAL);
 	}
 
+#if BITS_PER_LONG == 32
+	if (start >= MAX_LFS_FILESIZE) {
+		btrfs_err(fs_info,
+		"extent buffer %llu is beyond 32bit page cache limit",
+			  start);
+		btrfs_err_32bit_limit(fs_info);
+		return ERR_PTR(-EOVERFLOW);
+	}
+	if (start >= BTRFS_32BIT_EARLY_WARN_THRESHOLD)
+		btrfs_warn_32bit_limit(fs_info);
+#endif
+
 	if (fs_info->sectorsize < PAGE_SIZE &&
 	    offset_in_page(start) + len > PAGE_SIZE) {
 		btrfs_err(fs_info,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f8435641b912..d3f0e5294f50 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -252,6 +252,32 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
 }
 #endif
 
+#if BITS_PER_LONG == 32
+void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
+{
+	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
+		btrfs_warn(fs_info, "btrfs is reaching 32bit kernel limit.");
+		btrfs_warn(fs_info,
+"due to 32bit page cache limit, btrfs can't access metadata at or beyond %lluT.",
+			   BTRFS_32BIT_MAX_FILE_SIZE >> 40);
+		btrfs_warn(fs_info,
+			   "please consider upgrade to 64bit kernel/hardware.");
+	}
+}
+
+void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
+{
+	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
+		btrfs_err(fs_info, "btrfs reached 32bit kernel limit.");
+		btrfs_err(fs_info,
+"due to 32bit page cache limit, btrfs can't access metadata at or beyond %lluT.",
+			  BTRFS_32BIT_MAX_FILE_SIZE >> 40);
+		btrfs_err(fs_info,
+			   "please consider upgrade to 64bit kernel/hardware.");
+	}
+}
+#endif
+
 /*
  * We only mark the transaction aborted and then set the file system read-only.
  * This will prevent new transactions from starting or trying to join this
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8fab44394f5..19a1bfe6f01b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6787,6 +6787,46 @@ static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes)
 	return div_u64(chunk_len, data_stripes);
 }
 
+#if BITS_PER_LONG == 32
+/*
+ * Due to page cache limit, btrfs can't access metadata at or beyond
+ * BTRFS_32BIT_MAX_FILE_SIZE on 32bit systemts.
+ *
+ * This function do mount time check to reject the fs if it already has
+ * metadata chunk beyond that limit.
+ */
+static int check_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
+				  u64 logical, u64 length, u64 type)
+{
+	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
+		return 0;
+
+	if (logical + length < MAX_LFS_FILESIZE)
+		return 0;
+
+	btrfs_err_32bit_limit(fs_info);
+	return -EOVERFLOW;
+}
+
+/*
+ * This is to give early warning for any metadata chunk reaching
+ * BTRFS_32BIT_EARLY_WARN_THRESHOLD.
+ * Although we can still access the metadata, it's a timed bomb thus an early
+ * warning is definitely needed.
+ */
+static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
+				  u64 logical, u64 length, u64 type)
+{
+	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
+		return;
+
+	if (logical + length < BTRFS_32BIT_EARLY_WARN_THRESHOLD)
+		return;
+
+	btrfs_warn_32bit_limit(fs_info);
+}
+#endif
+
 static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  struct btrfs_chunk *chunk)
 {
@@ -6797,6 +6837,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	u64 logical;
 	u64 length;
 	u64 devid;
+	u64 type;
 	u8 uuid[BTRFS_UUID_SIZE];
 	int num_stripes;
 	int ret;
@@ -6804,8 +6845,16 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 
 	logical = key->offset;
 	length = btrfs_chunk_length(leaf, chunk);
+	type = btrfs_chunk_type(leaf, chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 
+#if BITS_PER_LONG == 32
+	ret = check_32bit_meta_chunk(fs_info, logical, length, type);
+	if (ret < 0)
+		return ret;
+	warn_32bit_meta_chunk(fs_info, logical, length, type);
+#endif
+
 	/*
 	 * Only need to verify chunk item if we're reading from sys chunk array,
 	 * as chunk item in tree block is already verified by tree-checker.
@@ -6849,10 +6898,10 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	map->io_width = btrfs_chunk_io_width(leaf, chunk);
 	map->io_align = btrfs_chunk_io_align(leaf, chunk);
 	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
-	map->type = btrfs_chunk_type(leaf, chunk);
+	map->type = type;
 	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
 	map->verified_stripes = 0;
-	em->orig_block_len = calc_stripe_length(map->type, em->len,
+	em->orig_block_len = calc_stripe_length(type, em->len,
 						map->num_stripes);
 	for (i = 0; i < num_stripes; i++) {
 		map->stripes[i].physical =
-- 
2.30.1

