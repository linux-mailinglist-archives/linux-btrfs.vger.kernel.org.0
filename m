Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD74B15E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiBJTKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiBJTKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCEE10BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so9563818pjl.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Zh2+pk+XRnuuNmR/Zh4xLoNRRCKPCTCf8vQ0e4Mxpk=;
        b=cl/RCPCNfKsPCRLAXYDy5uhuxYJomsAVSMPqTSmra6kVAsQCcghFXJMBkSLgKx2CuL
         TmE6AZDAv/ec5Z82WOwswCb2ji9y+gWwalDV6ihNAYMoK/bv0xL4Ojn/HXmZbkzcCkGh
         dnZCb5ALs5Snb0Q8A6xh13Y1KuLyK30oXy1lyu+sizF1rMW7Dajqbo9gic4TgdyUAVWv
         ZzSunbdQ9/PacK6m8QeysTYL+c0Z8hRADGincWGq+kIKGELIUPvEoJAOM6bT4mk2tlem
         /VWSulZyCtaSHSqXres3rY8N8fjMjXhnMaRTpSlavxbbj0hwGoHxZ7yZKusxAFw2j8OO
         QslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Zh2+pk+XRnuuNmR/Zh4xLoNRRCKPCTCf8vQ0e4Mxpk=;
        b=8HEXFVF6YbW+SMy5vjqcb6rQKWXAkWrfntPIzaOt04UZSDr4A0uFSUB11Wq+i07Cs5
         BdS/9MPPYvi987ZNs2SpgmQ0Q0UWAu/LNt+kmL2E4HB/2/9UZPhqJdbr9HAeUJKdFe8t
         EPT1oHrtAn+pXCg4tVr8f9SXzx6dt/HNccnQTJINqj5JOxYfrURXhi+kGPZxob1L1Qp4
         YQ2OVDeydno2l7tlLwO6OJT9ozW6/p4QPzFhP4EeT4THiduE1kqqXyqH5xTPlzHBA+dB
         UJQXdHRsiuj+yx5YwUii6dFAcQBfchBi6i/XwaUZhySWT3Sloph9EZWyyOF86z0yCN20
         HT4g==
X-Gm-Message-State: AOAM530GX7PmyiQeX6d3MaNNbsSlvS0FcgXp1kvyhMog+JP3XQHigOdv
        SYeZEngp16erD9bKqhry05jdGAJ/jnxAiA==
X-Google-Smtp-Source: ABdhPJwe1MpluiPgXslawYXVlKamMS5uR0WXGkARAt/Sq6sGScXayg/vkh6MocKthGNpW02r19kyLw==
X-Received: by 2002:a17:902:e84a:: with SMTP id t10mr8768698plg.25.1644520232751;
        Thu, 10 Feb 2022 11:10:32 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:32 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 03/17] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Thu, 10 Feb 2022 11:09:53 -0800
Message-Id: <723131ef561f7dcf676c1ca30fd1afa6c73048d3.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_csum_one_bio() loops over each filesystem block in the bio while
keeping a cursor of its current logical position in the file in order to
look up the ordered extent to add the checksums to. However, this
doesn't make much sense for compressed extents, as a sector on disk does
not correspond to a sector of decompressed file data. It happens to work
because 1) the compressed bio always covers one ordered extent and 2)
the size of the bio is always less than the size of the ordered extent.
However, the second point will not always be true for encoded writes.

Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
it can assume that the bio only covers one ordered extent. Since we're
already changing the signature, let's get rid of the contig parameter
and make it implied by the offset parameter, similar to the change we
recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
nr_sectors to blockcount to make it clear that it's the number of
filesystem blocks, not the number of 512-byte sectors.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  3 ++-
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 32 ++++++++++++++------------------
 fs/btrfs/inode.c       |  8 ++++----
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 71e5b2e9a1ba..4bd4cdf866aa 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -591,7 +591,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		if (submit) {
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true);
 				if (ret)
 					goto finish_cb;
 			}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9f7a950b8a69..65c0d67cd286 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3193,7 +3193,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 file_start, int contig);
+				u64 offset, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9a3de652ada8..cda113727bd2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -616,28 +616,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
- * @file_start:  offset in file this bio begins to describe
- * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
- *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contain potentially discontiguous bio vecs
- *		 so the logical offset of each should be calculated separately.
+ * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
+ *               file offsets are determined from the page offsets in the bio.
+ *               Otherwise, this is the starting file offset of the bio vecs in
+ *               @bio, which must be contiguous.
+ * @one_ordered: If true, @bio only refers to one ordered extent.
  */
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-		       u64 file_start, int contig)
+				u64 offset, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
+	const bool use_page_offsets = (offset == (u64)-1);
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
 	int index;
-	int nr_sectors;
+	int blockcount;
 	unsigned long total_bytes = 0;
 	unsigned long this_sum_bytes = 0;
 	int i;
-	u64 offset;
 	unsigned nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
@@ -651,18 +651,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	if (contig)
-		offset = file_start;
-	else
-		offset = 0; /* shut up gcc */
-
 	sums->bytenr = bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!contig)
+		if (use_page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 
 		if (!ordered) {
@@ -681,13 +676,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 			}
 		}
 
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
+		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
 						 bvec.bv_len + fs_info->sectorsize
 						 - 1);
 
-		for (i = 0; i < nr_sectors; i++) {
-			if (offset >= ordered->file_offset + ordered->num_bytes ||
-			    offset < ordered->file_offset) {
+		for (i = 0; i < blockcount; i++) {
+			if (!one_ordered &&
+			    !in_range(offset, ordered->file_offset,
+				      ordered->num_bytes)) {
 				unsigned long bytes_left;
 
 				sums->len = this_sum_bytes;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24099fe9e120..1fadbdc25168 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2314,7 +2314,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 					   u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
 
 /*
@@ -2566,7 +2566,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 					  0, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 		if (ret)
 			goto out;
 	}
@@ -7817,7 +7817,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 						     struct bio *bio,
 						     u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, 1);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -7874,7 +7874,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.35.1

