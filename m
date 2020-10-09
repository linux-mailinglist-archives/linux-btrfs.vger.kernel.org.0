Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B59289928
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbgJIUKA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390847AbgJIUIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F8C0613A7
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so11884765qki.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78sPD/imWiDIsa2rzloBZkC1dL8B6n9ak9VaEkzrNVo=;
        b=LyaaMB7q73jfibfd/klzPuiY/AzaOG00XH84vQLWe7seh+5l0M7y4ddZbIGQFAevP5
         7LAvySi8BQKSBnycfTpNUZCpcvFqNSBT/d+mxkaQGGk/FzbVApTjfd3+8fj9cZ9KFQnv
         jk6lCiGCus+9DucCy4slT4Dldhg8VzFWFrL2a4wRUjVEMeZ2g8agcKgYaXA+7N/OJCMb
         UVfZXvUteQx+fVczJrQK+3SYUyODEM49CIN4PNbysvfB0MoR6b7qMjMu259c0KnrqeSs
         AoLTa6oAfvjlqkw8wvdrNbS3DQqhsaPYdg7d1KS66byLlYJ/Bkri9XK+IYu9Z9eXRDpS
         ElxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78sPD/imWiDIsa2rzloBZkC1dL8B6n9ak9VaEkzrNVo=;
        b=gyK9EO9MFF2F9W+dX8/19eYFW4YiuCXyBsHQVXFwRKno/ck2QeHRQ8gt6mqk89J9D3
         mdjU9rkJ7K8cVyODDHcJ5MWOll005R0ucguIPHlqA54012SnNIilzJZ5dZsCfnA05erN
         pozwOKAGIHCzALNmEimJxkoDEpRrh8b1jgn25PDId+FH0wyt8pRkfJYwzNT92yO86QBX
         Z+QjhIOt6H3Lqcw/Z+Tr2CZ1Jh30Rb6L9TeU92LbONfDKPVrlBOzWTxJSX9kLMG2yugm
         Hv9CCRtH1n4HkTwnSaHcIQBSFuEU4NR9ayJvy3jAURLoMRPSQf078Q10r5S4mXNb8Dd1
         Huig==
X-Gm-Message-State: AOAM533Q1rfhlzW2VkPXe0nnjdw1BdgqBgM+EWMgs1S//PKzbi6DNl3r
        6brFX37bEkB4kGktYlIQmRfm8tnJno3Fk064
X-Google-Smtp-Source: ABdhPJz7T8qphhVzZJVJLrFg4cK2xaNv8JvmweGmHM3ljMLVKT0wcJc5y6JGmOjWyxs7MoIvZu7s/w==
X-Received: by 2002:a37:6413:: with SMTP id y19mr15003063qkb.139.1602274046466;
        Fri, 09 Oct 2020 13:07:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i22sm1687058qki.74.2020.10.09.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 2/8] btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
Date:   Fri,  9 Oct 2020 16:07:14 -0400
Message-Id: <668ac60b9f619639eaedca3b3fe026f546751517.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
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
index 936c3137c646..9f77e9e9c31d 100644
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
@@ -7778,7 +7783,6 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
 	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
-	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
@@ -7805,10 +7809,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
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

