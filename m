Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15A6290858
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410103AbgJPP32 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407581AbgJPP30 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DFC061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k9so2224907qki.6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zeaV1DHKYkprUTioJ5r5xvlxV0lCO7Hfg6R1ere1s7Q=;
        b=yg6+/yGF/1LVojo28i/MPMz1CKka8xCLjaB578FUp1mlcQaLuPlcPT0YWsZ3FeBbnW
         sIltPsz5KsSrDzdRKEN5HHDXSNKL2bjC9Ohc8ZiUekd4PZJ/rvva4x3YC2QdWbAytPUK
         9GHXG5d6JO2pTH8uxscsQSgkiX73c6Tq08OaussvUD46kpg79jHkHpJFfeUOM4n7V1eE
         kXfujXP71DRWtBadzX/vN5lQpxQ+J2D5j48dA9NxelNBP4pGIHuYKlogg2NnNh+7EWeY
         gnAYwSLNj335vrcQd26DwmKQEUe4vgcUYqxfEeHQefhjlSu077jpzA3K0vBWmcBoPIXd
         O/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zeaV1DHKYkprUTioJ5r5xvlxV0lCO7Hfg6R1ere1s7Q=;
        b=I53lhCgbqTcSAOrUJcSnANo/x8dC8oMJ7g3MxzJg5UTbmLtPQSmXZ29032AOJCP6I1
         c1yZCBaT1YE0aK1b078zBs201+lNQWtHnik6Lyi8EVYJ+F4ai7XGWXJIygUjZNXTIfac
         hHiYy0+Ls5B9LUry+MTO6YaR56acvbJMZETPbLEgsM3xvWXgBgK92UorAdcg8uBBOvyy
         fkcAa8xxygTc7NLGscMPJJwoea4Sq2o47DmQ7fPDkESP7WrAITzP4wxizxzbJi4MgLN6
         SYQuzzYpqbLf5ZVCUFNEiTp2jKEBbgwI0UsuPNOAQq8vGik/pXTp7bFjImDxNGICuKeY
         REqg==
X-Gm-Message-State: AOAM533E/2Vm4hVEDfUwKREdS+M0mBeX6y+lvaa2s/yI5K0cpBqSxQnI
        Gx7Vhzgh1TazqwUp6vWYLt2LoC01lUtu2g1M
X-Google-Smtp-Source: ABdhPJwHV0ZLj8J93pQwT90nEohQKs2Eeo6qlbicuVKXpNkDPKrvCoDEDw/IlVv7FAq9ZVeXxk9nqQ==
X-Received: by 2002:ae9:edc2:: with SMTP id c185mr4556707qkg.65.1602862165633;
        Fri, 16 Oct 2020 08:29:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p136sm981487qke.25.2020.10.16.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 2/8] btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
Date:   Fri, 16 Oct 2020 11:29:14 -0400
Message-Id: <22b630722cf136979cb91b6f233568979ca6e75a.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we move to being able to handle NULL csum_roots it'll be cleaner to
just check in btrfs_lookup_bio_sums instead of at all of the caller
locations, so push the NODATASUM check into it as well so it's unified.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index da58c58ef9aa..de69bef92c9a 100644
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

