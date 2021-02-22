Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E23210DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBVGfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVGfH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pj04379aq97FYYoWVJBcgIeXLAvDAJFQB8aT2QVoW9Q=;
        b=YuenxpT7/vAUfaKQcGWBqb2E4G5trLDGSAHTzUqOkt7aiZHZ6+32Gn6bgW2n9miZdpWlrb
        sdJqULH19ON9J3aNUpJ3vQaimSUjYIpjv1FFe1VML1PVCRPvKsZoi3Z24q0qiClwwmhzcz
        caYg1OsGHyVZGMmH9jLl5EBusjIFDtk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54AE7B11F
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: disk-io: support subpage metadata csum calculation at write time
Date:   Mon, 22 Feb 2021 14:33:49 +0800
Message-Id: <20210222063357.92930-5-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new helper, csum_dirty_subpage_buffers(), to iterate through all
dirty extent buffers in one bvec.

Also extract the code of calculating csum for one extent buffer into
csum_one_extent_buffer(), so that both the existing csum_dirty_buffer()
and the new csum_dirty_subpage_buffers() can reuse the same routine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 96 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 437e6b2163c7..3c00a65f6679 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -441,6 +441,74 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
 	return ret;
 }
 
+static int csum_one_extent_buffer(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u8 result[BTRFS_CSUM_SIZE];
+	int ret;
+
+	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
+				    offsetof(struct btrfs_header, fsid),
+				    BTRFS_FSID_SIZE) == 0);
+	csum_tree_block(eb, result);
+
+	if (btrfs_header_level(eb))
+		ret = btrfs_check_node(eb);
+	else
+		ret = btrfs_check_leaf_full(eb);
+
+	if (ret < 0) {
+		btrfs_print_tree(eb, 0);
+		btrfs_err(fs_info,
+		"block=%llu write time tree block corruption detected",
+			  eb->start);
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		return ret;
+	}
+	write_extent_buffer(eb, result, 0, fs_info->csum_size);
+
+	return 0;
+}
+
+/* Checksum all dirty extent buffers in one bio_vec. */
+static int csum_dirty_subpage_buffers(struct btrfs_fs_info *fs_info,
+				      struct bio_vec *bvec)
+{
+	struct page *page = bvec->bv_page;
+	u64 bvec_start = page_offset(page) + bvec->bv_offset;
+	u64 cur;
+	int ret = 0;
+
+	for (cur = bvec_start; cur < bvec_start + bvec->bv_len;
+	     cur += fs_info->nodesize) {
+		struct extent_buffer *eb;
+		bool uptodate;
+
+		eb = find_extent_buffer(fs_info, cur);
+		uptodate = btrfs_subpage_test_uptodate(fs_info, page, cur,
+						       fs_info->nodesize);
+
+		/* A dirty eb shouldn't disappera from buffer_radix */
+		if (WARN_ON(!eb))
+			return -EUCLEAN;
+
+		if (WARN_ON(cur != btrfs_header_bytenr(eb))) {
+			free_extent_buffer(eb);
+			return -EUCLEAN;
+		}
+		if (WARN_ON(!uptodate)) {
+			free_extent_buffer(eb);
+			return -EUCLEAN;
+		}
+
+		ret = csum_one_extent_buffer(eb);
+		free_extent_buffer(eb);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
 /*
  * Checksum a dirty tree block before IO.  This has extra checks to make sure
  * we only fill in the checksum field in the first page of a multi-page block.
@@ -451,9 +519,10 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	struct page *page = bvec->bv_page;
 	u64 start = page_offset(page);
 	u64 found_start;
-	u8 result[BTRFS_CSUM_SIZE];
 	struct extent_buffer *eb;
-	int ret;
+
+	if (fs_info->sectorsize < PAGE_SIZE)
+		return csum_dirty_subpage_buffers(fs_info, bvec);
 
 	eb = (struct extent_buffer *)page->private;
 	if (page != eb->pages[0])
@@ -475,28 +544,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	if (WARN_ON(!PageUptodate(page)))
 		return -EUCLEAN;
 
-	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
-				    offsetof(struct btrfs_header, fsid),
-				    BTRFS_FSID_SIZE) == 0);
-
-	csum_tree_block(eb, result);
-
-	if (btrfs_header_level(eb))
-		ret = btrfs_check_node(eb);
-	else
-		ret = btrfs_check_leaf_full(eb);
-
-	if (ret < 0) {
-		btrfs_print_tree(eb, 0);
-		btrfs_err(fs_info,
-		"block=%llu write time tree block corruption detected",
-			  eb->start);
-		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
-		return ret;
-	}
-	write_extent_buffer(eb, result, 0, fs_info->csum_size);
-
-	return 0;
+	return csum_one_extent_buffer(eb);
 }
 
 static int check_tree_block_fsid(struct extent_buffer *eb)
-- 
2.30.0

