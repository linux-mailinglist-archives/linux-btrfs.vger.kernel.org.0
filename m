Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D705127756D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgIXPdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgIXPdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 11:33:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C7C0613D5
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:33:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t138so3688590qka.0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9gEtPQD4EpxQ0sNieQuWsjfv/UYDxta6WrtRrHM8TX4=;
        b=bwnHqTs9XF0rttUUFNZM8lSEpYuufwO5sn00Ft57TYCKIEAj2i263INS+NqOZ3xiXu
         M0rqZuK8g8A6le8mt2fbQjPA17ckMff/TQGwEOkRORHp07EAQjrgT2KbLVchwOY03791
         hHSPshJTvxa/BbCDRZoJjt6xAC1eFZgnY4wDkvv8JMcrl/pYxmeWoV5lYksVq+03mwVo
         0Cf7Fz0lRprn/kQj9ZmBd4nJHi/r41qY5+cBPKPEgL6gxspePZhN4deZbT72fmwoKCiG
         89roxj7stp4kujlkPzZPkd5rX71s73OJ5iQI+0GKIvsK2tPnbatlS5jGGV1d1HFfIqKE
         nw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gEtPQD4EpxQ0sNieQuWsjfv/UYDxta6WrtRrHM8TX4=;
        b=Ajq5SoREYLkLGhPFhQfJIT/TN6jFZqMpd98IXKNrNC6b/QUTtKk9cNTSR5weiojeCl
         t+D0uxJ1sjDI0xu3fmw4pf5KZ3Dk35lClfhnVs4npIw3ANup7hKrME7c3OUxCRKpzYgL
         zOKdCceUGx8aer+dVyrKT9atY9ZqvEjSenXGlAJwaIjf3d6vxMb4fTIW23F1hQ4Kw1XK
         U8n68nI/zhanyfbm9ihrnOoQ9Xjw66Ksq557aARCmpUno+oPA1wcY4v43KXnkICLpRpZ
         YynxdJlDdjs7VrYe3C/je5YZIwQIAJFli3uu9fUpl+VffHWjkpiipch+Fm6wr6Yt4UPR
         Ng3Q==
X-Gm-Message-State: AOAM533fX+SCozvg3KNvbncBo7BlkDow8WPSyBKv9ycXbN4a2bm3zaDf
        xQtFz98+yCqzovlkCLGOFdYdz16vuZ1u0vIA
X-Google-Smtp-Source: ABdhPJw7eeQynzuq5gmqQy2FTLwuul2LPbnmsGirpP3LDce/ZbTbzYzaI2l7wGYVHc/gfi14ZDND1w==
X-Received: by 2002:a05:620a:1583:: with SMTP id d3mr160267qkk.495.1600961581535;
        Thu, 24 Sep 2020 08:33:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d12sm2329400qka.34.2020.09.24.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:33:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
Date:   Thu, 24 Sep 2020 11:32:51 -0400
Message-Id: <bdf1bf5c65679fdf39021e16a242094acd71b270.1600961206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600961206.git.josef@toxicpanda.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we move to being able to handle NULL csum_roots it'll be cleaner to
just check in btrfs_lookup_bio_sums instead of at all of the caller
locations, so push the NODATASUM check into it as well so it's unified.

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

