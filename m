Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5B4B18B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbiBJWoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbiBJWof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:35 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DC05F78
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:31 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id j24so6483457qkk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WfGtmUcSTVRYIz9KWMLPvX51lEAkGUBahW7DzB+DJ7Y=;
        b=pUT5lJIl2LnmxtdkrThEntatT+Xqm0itcHQP8cKVqKTzeDSikGzTTMN0JR1haCpP+h
         Rvf41dGo3HeUJw1WNyeagNfXUzEhHZ8kZ6eHIhmKa7mfIR9llZpOm04LR6ZN5xvQ/AZN
         MDd8kBPDRoJhp48P2c7pekC+CIm+Jesr7osUIRW1XugCr2Uj3aQuzWSxPdmiHKw0iNpO
         KQmGQzqx+5cdF/sWeHvNM4oh8s4AsV4RS+0rdkxFviq5eXdYn9mL0aGL1QhwKBvi9OWj
         9rH44YLWthzJWGbf8b8wZRHRTL6MTcJbpgymV/bFQFRluGIBIYak61jwFNqRU3lCbVBY
         betg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfGtmUcSTVRYIz9KWMLPvX51lEAkGUBahW7DzB+DJ7Y=;
        b=PRlvvAJW/sliuvNd/oASv+blqv3whZscbCdIA7YKxWYsvrlVj0gCEmzvimvEJqdLp3
         IBJjzkKhpM2NmzPCabCxV63coOe7rWUsjZmrFybhyDUCgEdBnAcAOvuASEJpDNgsIIxP
         Ua6tnIKpPX6+pK2XOFGG03F+HCtJFqrc3ei6vDx/un7j8DxALykKw2UeZWpDmtvKkFPg
         ZRiFPI6d3FE6poeM6zec6fvNHbkcRFp52ijUxXC4mGwDQS6UiEXtaUj3L46R7cA30mDK
         Zuv7B21acJL6WaIrFzShvKh7+Hp+7VJK6q/Kp1TSDGDVhyvK/p75LTBflZD6HXJjp+tB
         L+MA==
X-Gm-Message-State: AOAM531Uzo+mR+NOMeny2ZkId4YQL0dJpRVFuLqwy8Abty15+4Sfp/Zq
        JqspIwxSIq/lWXSthXXa4P6azAipW8yLpo69
X-Google-Smtp-Source: ABdhPJyKWnimLhsCV5O3m1TRQbUBbALTtJ1bG5Z2IzqzmdNyjfVp94mf6bhaBu98ex+kRRQDl/WFeA==
X-Received: by 2002:a05:620a:4694:: with SMTP id bq20mr4982787qkb.116.1644533070728;
        Thu, 10 Feb 2022 14:44:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c20sm11826831qtb.58.2022.02.10.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: handle csum lookup errors properly on reads
Date:   Thu, 10 Feb 2022 17:44:20 -0500
Message-Id: <9aa5cdf08820eeb53feb0457bc6994231a7ff9fd.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644532798.git.josef@toxicpanda.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
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

Currently any error we get while trying to lookup csums during reads
shows up as a missing csum, and then on the read completion side we spit
out an error saying there was a csum mismatch and we increase the device
corruption count.

However we could have gotten an EIO from the lookup.  We could also be
inside of a memory constrained container and gotten a ENOMEM while
trying to do the read.  In either case we don't want to make this look
like a file system corruption problem, we want to make it look like the
actual error it is.  Capture any negative value, convert it to the
appropriate blk_sts_t, free the csum array if we have one and bail.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index efb24cc0b083..e68be492109d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -368,6 +368,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_bio *bbio = NULL;
 	struct btrfs_path *path;
 	const u32 sectorsize = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
@@ -377,6 +378,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	u8 *csum;
 	const unsigned int nblocks = orig_len >> fs_info->sectorsize_bits;
 	int count = 0;
+	blk_status_t ret = BLK_STS_OK;
 
 	if ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
 	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
@@ -400,7 +402,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 		return BLK_STS_RESOURCE;
 
 	if (!dst) {
-		struct btrfs_bio *bbio = btrfs_bio(bio);
+		bbio = btrfs_bio(bio);
 
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
@@ -456,6 +458,13 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 
 		count = search_csum_tree(fs_info, path, cur_disk_bytenr,
 					 search_len, csum_dst);
+		if (count < 0) {
+			ret = errno_to_blk_status(count);
+			if (bbio)
+				btrfs_bio_free_csum(bbio);
+			break;
+		}
+
 		if (count <= 0) {
 			/*
 			 * Either we hit a critical error or we didn't find
@@ -491,7 +500,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst
 	}
 
 	btrfs_free_path(path);
-	return BLK_STS_OK;
+	return ret;
 }
 
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
-- 
2.26.3

