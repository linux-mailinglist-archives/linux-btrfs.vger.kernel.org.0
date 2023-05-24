Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DFB70F9A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjEXPDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjEXPDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6623F199
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lwkJO6RU8HMQy/EIjHkoDP2NyXd8yCPFXc3b2YZWgkk=; b=ffXVQd25Q/1g2vIPi/eRGYoLXc
        cw4ntOy1i+HgmYjIyGVLaGRagPHbPqgEdksxn/RACiCZ7o6WL3L+zvpCrgGMLz/6tj2YC7gcCdzOa
        VL1a372fm/FKP9OfAeJ0g3nfwFaAG26Ji2jJNYjszFyDvdyD139fdhhS5vS3+xVLTe31ncpCvqg0F
        MyCO14MTh54y1ojvrOv9MnjG0DX53bUSSAmPA5sD4Oc+53ru5LJCJFdL58p0sJk3a1VwL/HphdDVB
        UZJ2dY6p3rcrFBbIBjglXu4YwEeCRws8YMCDEvHPlVjhi4KmKOjs8Ax3y7n4IyeSo456cjiYJxG/Z
        qRK5PuBQ==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1V-00Dmbk-0v;
        Wed, 24 May 2023 15:03:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 04/14] btrfs: rename the bytenr field in struct btrfs_ordered_sum to logical
Date:   Wed, 24 May 2023 17:03:07 +0200
Message-Id: <20230524150317.1767981-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
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

->bytenr in struct btrfs_ordered_sum stores a logical address.  Make that
clear by renaming it to ->logical.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file-item.c    |  8 ++++----
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ordered-data.h |  8 ++++----
 fs/btrfs/relocation.c   |  4 ++--
 fs/btrfs/tree-log.c     | 12 ++++++------
 fs/btrfs/zoned.c        |  4 ++--
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e74b9804bcdec8..ca321126816e94 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -560,7 +560,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 				goto fail;
 			}
 
-			sums->bytenr = start;
+			sums->logical = start;
 			sums->len = (int)size;
 
 			offset = bytes_to_csum_size(fs_info, start - key.offset);
@@ -749,7 +749,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	sums->bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
@@ -799,7 +799,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 				ordered = btrfs_lookup_ordered_extent(inode,
 								offset);
 				ASSERT(ordered); /* Logic error */
-				sums->bytenr = (bio->bi_iter.bi_sector << SECTOR_SHIFT)
+				sums->logical = (bio->bi_iter.bi_sector << SECTOR_SHIFT)
 					+ total_bytes;
 				index = 0;
 			}
@@ -1086,7 +1086,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 again:
 	next_offset = (u64)-1;
 	found_next = 0;
-	bytenr = sums->bytenr + total_bytes;
+	bytenr = sums->logical + total_bytes;
 	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	file_key.offset = bytenr;
 	file_key.type = BTRFS_EXTENT_CSUM_KEY;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e83fb22505261..253ad6206179ce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2850,7 +2850,7 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
 		trans->adding_csums = true;
 		if (!csum_root)
 			csum_root = btrfs_csum_root(trans->fs_info,
-						    sum->bytenr);
+						    sum->logical);
 		ret = btrfs_csum_file_blocks(trans, csum_root, sum);
 		trans->adding_csums = false;
 		if (ret)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 2e54820a5e6ff7..ebc980ac967ad4 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -14,13 +14,13 @@ struct btrfs_ordered_inode_tree {
 };
 
 struct btrfs_ordered_sum {
-	/* bytenr is the start of this extent on disk */
-	u64 bytenr;
-
 	/*
-	 * this is the length in bytes covered by the sums array below.
+	 * Logical start address and length for of the blocks covered by
+	 * the sums array.
 	 */
+	u64 logical;
 	u32 len;
+
 	struct list_head list;
 	/* last field is a variable length array of csums */
 	u8 sums[];
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 38cfbd38a81990..770a7ffaf22425 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4379,8 +4379,8 @@ int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 		 * disk_len vs real len like with real inodes since it's all
 		 * disk length.
 		 */
-		new_bytenr = ordered->disk_bytenr + sums->bytenr - disk_bytenr;
-		sums->bytenr = new_bytenr;
+		new_bytenr = ordered->disk_bytenr + sums->logical - disk_bytenr;
+		sums->logical = new_bytenr;
 
 		btrfs_add_ordered_sum(ordered, sums);
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ecb73da5d25aa3..f91a6175fd117e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -859,10 +859,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 						struct btrfs_ordered_sum,
 						list);
 				csum_root = btrfs_csum_root(fs_info,
-							    sums->bytenr);
+							    sums->logical);
 				if (!ret)
 					ret = btrfs_del_csums(trans, csum_root,
-							      sums->bytenr,
+							      sums->logical,
 							      sums->len);
 				if (!ret)
 					ret = btrfs_csum_file_blocks(trans,
@@ -4221,7 +4221,7 @@ static int log_csums(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *log_root,
 		     struct btrfs_ordered_sum *sums)
 {
-	const u64 lock_end = sums->bytenr + sums->len - 1;
+	const u64 lock_end = sums->logical + sums->len - 1;
 	struct extent_state *cached_state = NULL;
 	int ret;
 
@@ -4239,7 +4239,7 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 * file which happens to refer to the same extent as well. Such races
 	 * can leave checksum items in the log with overlapping ranges.
 	 */
-	ret = lock_extent(&log_root->log_csum_range, sums->bytenr, lock_end,
+	ret = lock_extent(&log_root->log_csum_range, sums->logical, lock_end,
 			  &cached_state);
 	if (ret)
 		return ret;
@@ -4252,11 +4252,11 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 * some checksums missing in the fs/subvolume tree. So just delete (or
 	 * trim and adjust) any existing csum items in the log for this range.
 	 */
-	ret = btrfs_del_csums(trans, log_root, sums->bytenr, sums->len);
+	ret = btrfs_del_csums(trans, log_root, sums->logical, sums->len);
 	if (!ret)
 		ret = btrfs_csum_file_blocks(trans, log_root, sums);
 
-	unlock_extent(&log_root->log_csum_range, sums->bytenr, lock_end,
+	unlock_extent(&log_root->log_csum_range, sums->logical, lock_end,
 		      &cached_state);
 
 	return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bda301a55cbe3b..76411d96fa7afc 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1711,9 +1711,9 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 
 	list_for_each_entry(sum, &ordered->list, list) {
 		if (logical < orig_logical)
-			sum->bytenr -= orig_logical - logical;
+			sum->logical -= orig_logical - logical;
 		else
-			sum->bytenr += logical - orig_logical;
+			sum->logical += logical - orig_logical;
 	}
 }
 
-- 
2.39.2

