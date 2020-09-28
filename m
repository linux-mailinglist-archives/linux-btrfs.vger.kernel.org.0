Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6765827B48A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1SfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1SfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:35:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B2C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so1933182qki.6
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZITVtTPFaeRJaFnvJbuj6ZKcqKx8KMRgFsSXK5mNBM=;
        b=a1hV5SY230SNCkQAO0s8VgYV2Z8+BK9Ice6Ek2OjBQBnCwBjMq0ZOuko+G7VjKw5Fq
         Na1BPAgca688EjFGtZUowarpG2jJjepYBsq6B+Pl2A9lMsRpLcdiHPzGbSXoUYcVNF8D
         LZOCLJO3aySU45uB0xAiMLDFASKIsSqr2TAvI64i2UQlvEuoVzSVPSQZuOxovdadeKbc
         2iqSqUjZsfwjPtc7KEAwdlU4HyBe8Coh2UzMT4kJFWTT046foXlpDhkCK/Mi0DFaK1dP
         uRi6AoWTwZrdrqBt6GCvmmtSmwT/TOBHVqVTQg8EHpYfnKSTxfHDoxxqZvcZmwgdERqb
         OPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZITVtTPFaeRJaFnvJbuj6ZKcqKx8KMRgFsSXK5mNBM=;
        b=s7NX4x70iT7VgQN5B2uP1NdAkHSpdBdJ/aSFWMY4BexyqxZUGk39Lk6muSbDe2R+t0
         D3nKSpceRTuTXspIdaxrioobvWIXA8Rr5Nb5Vn9vF4flUKIVMCQ+vpLFYlYtgZf+N3x9
         iLs75lqozY41WIQWcYG1q2PKLfC227O3q3q/e+Owe05gkUuLRBx2ObsfzxyEn2oFEq2z
         Y4xTUvS12uQVrF6SuIegjqfD0z3T71M51jQT50fW5Co6ZvbULiEfh3yq4BqgwP3Ckt0z
         LlH2rb1qyzp6RaImKsrql+hKfHNFZi91l40KuAl53hClnwkgP0jwlHPEtSvk7Wwqgg4T
         L5Jw==
X-Gm-Message-State: AOAM533uVcjOXCjymd6qQZl1GflRZNqzDlH4UFVYpaQGNWyQTVAxXJcw
        qvgaYSWb3NmY6XIlm2ZWtmLZkaGolI5RbGlT
X-Google-Smtp-Source: ABdhPJzacLhkKvn1+K2NxWaaqKPCcEOqZ7jqeHuhQ/HQXcagxY+vIAxKE0G6RPkeuEMhjn+zeBmqOQ==
X-Received: by 2002:a05:620a:94e:: with SMTP id w14mr824012qkw.86.1601318102827;
        Mon, 28 Sep 2020 11:35:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v15sm1686877qkg.108.2020.09.28.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:35:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 2/5] btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
Date:   Mon, 28 Sep 2020 14:34:54 -0400
Message-Id: <40dee8e2ed9aaceea4869da852f2d2b887e24f1c.1601318001.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601318001.git.josef@toxicpanda.com>
References: <cover.1601318001.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we move to being able to handle NULL csum_roots it'll be cleaner to
just check in btrfs_lookup_bio_sums instead of at all of the caller
locations, so push the NODATASUM check into it as well so it's unified.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 14 +++++---------
 fs/btrfs/file-item.c   |  3 +++
 fs/btrfs/inode.c       | 12 +++++++++---
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index eeface30facd..7e1eb57b923c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -722,11 +722,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			 */
 			refcount_inc(&cb->pending_bios);
 
-			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-				ret = btrfs_lookup_bio_sums(inode, comp_bio,
-							    (u64)-1, sums);
-				BUG_ON(ret); /* -ENOMEM */
-			}
+			ret = btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1,
+						    sums);
+			BUG_ON(ret); /* -ENOMEM */
 
 			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
 						  fs_info->sectorsize);
@@ -751,10 +749,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
 	BUG_ON(ret); /* -ENOMEM */
 
-	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		ret = btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1, sums);
-		BUG_ON(ret); /* -ENOMEM */
-	}
+	ret = btrfs_lookup_bio_sums(inode, comp_bio, (u64)-1, sums);
+	BUG_ON(ret); /* -ENOMEM */
 
 	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 	if (ret) {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 8f4f2bd6d9b9..8083d71d6af6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -272,6 +272,9 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	int count = 0;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+		return BLK_STS_OK;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return BLK_STS_RESOURCE;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d526833b5ec0..d262944c4297 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2202,7 +2202,12 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 							   mirror_num,
 							   bio_flags);
 			goto out;
-		} else if (!skip_sum) {
+		} else {
+			/*
+			 * Lookup bio sums does extra checks around whether we
+			 * need to csum or not, which is why we ignore skip_sum
+			 * here.
+			 */
 			ret = btrfs_lookup_bio_sums(inode, bio, (u64)-1, NULL);
 			if (ret)
 				goto out;
@@ -7781,7 +7786,6 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
 	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
-	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
@@ -7808,10 +7812,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		return BLK_QC_T_NONE;
 	}
 
-	if (!write && csum) {
+	if (!write) {
 		/*
 		 * Load the csums up front to reduce csum tree searches and
 		 * contention when submitting bios.
+		 *
+		 * If we have csums disabled this will do nothing.
 		 */
 		status = btrfs_lookup_bio_sums(inode, dio_bio, file_offset,
 					       dip->csums);
-- 
2.26.2

