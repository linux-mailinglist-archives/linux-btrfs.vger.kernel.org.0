Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A345727FB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbjFHMOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHMOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:14:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C82695
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pS/uI1P9tHRodT89UHX35RU0rKwqOM5u6Y7GwHsbCGY=; b=XM9IupG99mZug1w6XMMWcGlKnz
        L/uFwwTNKseb/vIw5uY4mvqNS/Hp0GwKJB8cVlMPs/4qRCdYKn8gsh6LKBO+SbJTDnRqevE+N1zBJ
        0hk3IZcuV+2DAEogv6zqkXBDV9Mtpuf7YDau67PDJWNTzVyVYhnE/etl4uWLdBcUUznmk67VNlfoS
        2cHBPWPSsD1hQ6haAyKESPYwfLUQjmrFRK0Ji24XuEra/6bSMaFG22AQkyj28dzjKdhikScSs0+Cp
        pUCqcqnyhfNalgbSA8eDhD2+VyrEIq8+eFt9iDeOAolkBvEg+wAErRl37dK2R0I7810b2tNVV+3ZR
        Vd0kk+rg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7EWv-009HCK-1Y;
        Thu, 08 Jun 2023 12:14:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: allocate dummy ordereded_sums objects for nocsum I/O on zoned file systems
Date:   Thu,  8 Jun 2023 14:14:10 +0200
Message-Id: <20230608121410.275766-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608121410.275766-1-hch@lst.de>
References: <20230608121410.275766-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zoned file systems now need the ordereded_sums structure to record the
actual write location returned by zone append, so allocate dummy
structures without the csum array for them when the I/O doesn't use
checksums, and free them when completing the ordered_extent.

Fixes: 177b0eb2c180 ("btrfs: optimize the logical to physical mapping for zoned writes")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c       |  4 ++++
 fs/btrfs/file-item.c | 16 ++++++++++++++++
 fs/btrfs/file-item.h |  1 +
 fs/btrfs/zoned.c     | 21 +++++++++++++++++++--
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2ca2d1fcdf2b9a..12b12443efaabb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -705,6 +705,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
 				goto fail_put_bio;
+		} else if (use_append) {
+			ret = btrfs_alloc_dummy_sum(bbio);
+			if (ret)
+				goto fail_put_bio;
 		}
 	}
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2db90c3bfd95a9..696bf695d8eb00 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -773,6 +773,22 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	return 0;
 }
 
+/*
+ * Nodatasum I/O on zoned file systems still requires an btrfs_ordered_sum to
+ * record the updated logical address on Zone Append completion.
+ * Allocate just the structure with an empty sums array here for that case.
+ */
+blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
+{
+	bbio->sums = kmalloc(sizeof(*bbio->sums), GFP_NOFS);
+	if (!bbio->sums)
+		return BLK_STS_RESOURCE;
+	bbio->sums->len = bbio->bio.bi_iter.bi_size;
+	bbio->sums->logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	btrfs_add_ordered_sum(bbio->ordered, bbio->sums);
+	return 0;
+}
+
 /*
  * Remove one checksum overlapping a range.
  *
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 6be8725cd57474..4ec669b690080a 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -50,6 +50,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
 			     bool nowait);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bbde4ddd475492..637b2a2f45c94e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1702,7 +1702,8 @@ static bool btrfs_zoned_split_ordered(struct btrfs_ordered_extent *ordered,
 
 void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(ordered->inode->i_sb);
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_sum *sum =
 		list_first_entry(&ordered->list, typeof(*sum), list);
 	u64 logical = sum->logical;
@@ -1717,7 +1718,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 		if (!btrfs_zoned_split_ordered(ordered, logical, len)) {
 			set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
 			btrfs_err(fs_info, "failed to split ordered extent\n");
-			return;
+			goto out;
 		}
 		logical = sum->logical;
 		len = sum->len;
@@ -1725,6 +1726,22 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 
 	if (ordered->disk_bytenr != logical)
 		btrfs_rewrite_logical_zoned(ordered, logical);
+
+out:
+	/*
+	 * If we end up here for nodatasum I/O, the btrfs_ordered_sum structures
+	 * were allocated by btrfs_alloc_dummy_sum only to record the logical
+	 * addresses and don't contain actual checksums.  We thus must free them
+	 * here so that we don't attempt to log the csums later.
+	 */
+	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
+	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
+		while ((sum = list_first_entry_or_null(&ordered->list,
+						       typeof(*sum), list))) {
+			list_del(&sum->list);
+			kfree(sum);
+		}
+	}
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-- 
2.39.2

