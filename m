Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCB27DE21
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgI3B5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgI3B5I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQuXTQ8wGZMeGkbOyMaJVaGYtD6UrQBAoNom1MdB1HQ=;
        b=kX7GoQ0zuLfFVIEkrkGR/7GETcihbToiFZktk7C2rLL1ApqXn+dmq2vDeBsrdFnwAcE3jB
        qJBc6cZ/q9k0HGXoWcKe8fjfu4cN5HYDJ5ulrs5m0vTTl/UN2zbXu0UCr+JQIbZ+Xhj7mQ
        1GpxazBHoeycHDgbHSbG56NfpF/Nnhc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46DFDAE07
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 40/49] btrfs: disk-io: support subpage metadata csum calculation at write time
Date:   Wed, 30 Sep 2020 09:55:30 +0800
Message-Id: <20200930015539.48867-41-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new helper, csum_dirty_subpage_buffers(), to iterate through all
possible extent buffers in one bvec.

Also extract the code to calculate csum for one extent buffer into
csum_one_extent_buffer(), so that both the existing csum_dirty_buffer()
and the new csum_dirty_subpage_buffers() can reuse the same routine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 103 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d31999978821..9aa68e2344e1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -490,35 +490,13 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
 	return ret;
 }
 
-/*
- * checksum a dirty tree block before IO.  This has extra checks to make sure
- * we only fill in the checksum field in the first page of a multi-page block
- */
-
-static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec)
+static int csum_one_extent_buffer(struct extent_buffer *eb)
 {
-	struct extent_buffer *eb;
-	struct page *page = bvec->bv_page;
-	u64 start = page_offset(page);
-	u64 found_start;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u8 result[BTRFS_CSUM_SIZE];
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int ret;
 
-	eb = (struct extent_buffer *)page->private;
-	if (page != eb->pages[0])
-		return 0;
-
-	found_start = btrfs_header_bytenr(eb);
-	/*
-	 * Please do not consolidate these warnings into a single if.
-	 * It is useful to know what went wrong.
-	 */
-	if (WARN_ON(found_start != start))
-		return -EUCLEAN;
-	if (WARN_ON(!PageUptodate(page)))
-		return -EUCLEAN;
-
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
 				    offsetof(struct btrfs_header, fsid),
 				    BTRFS_FSID_SIZE) == 0);
@@ -543,6 +521,83 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	return 0;
 }
 
+/*
+ * Do all the csum calculation and extra sanity checks on all extent
+ * buffers in the bvec.
+ */
+static int csum_dirty_subpage_buffers(struct btrfs_fs_info *fs_info,
+				      struct bio_vec *bvec)
+{
+	struct page *page = bvec->bv_page;
+	u64 page_start = page_offset(page);
+	u64 start = page_start + bvec->bv_offset;
+	u64 end = start + bvec->bv_len - 1;
+	u64 cur = start;
+	int ret = 0;
+
+	while (cur <= end) {
+		struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+		struct extent_buffer *eb;
+
+		ret = btrfs_find_first_subpage_eb(fs_info, &eb, cur, end, 0);
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+
+		/*
+		 * Here we can't use PageUptodate() to check the status.
+		 * As one page is uptodate only when all its extent buffers
+		 * are uptodate, and no holes between them.
+		 * So here we use EXTENT_UPTODATE bit to make sure the exntent
+		 * buffer is uptodate.
+		 */
+		if (WARN_ON(test_range_bit(io_tree, eb->start,
+				eb->start + eb->len - 1, EXTENT_UPTODATE, 1,
+				NULL) == 0))
+			return -EUCLEAN;
+		if (WARN_ON(cur != btrfs_header_bytenr(eb)))
+			return -EUCLEAN;
+
+		ret = csum_one_extent_buffer(eb);
+		if (ret < 0)
+			return ret;
+		cur = eb->start + eb->len;
+	}
+	return ret;
+}
+
+/*
+ * checksum a dirty tree block before IO.  This has extra checks to make sure
+ * we only fill in the checksum field in the first page of a multi-page block
+ */
+static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec)
+{
+	struct extent_buffer *eb;
+	struct page *page = bvec->bv_page;
+	u64 start = page_offset(page) + bvec->bv_offset;
+	u64 found_start;
+
+	if (btrfs_is_subpage(fs_info))
+		return csum_dirty_subpage_buffers(fs_info, bvec);
+
+	eb = (struct extent_buffer *)page->private;
+	if (page != eb->pages[0])
+		return 0;
+
+	found_start = btrfs_header_bytenr(eb);
+	/*
+	 * Please do not consolidate these warnings into a single if.
+	 * It is useful to know what went wrong.
+	 */
+	if (WARN_ON(found_start != start))
+		return -EUCLEAN;
+	if (WARN_ON(!PageUptodate(page)))
+		return -EUCLEAN;
+
+	return csum_one_extent_buffer(eb);
+}
+
 static int check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-- 
2.28.0

