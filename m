Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02EE4BBBC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiBRPD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiBRPD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:58 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9191B2B2FEE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:40 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a19so15242629qvm.4
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4FRFTxc+u4BH/1GAAIPOoN0jFTJbwpCr2MyiZ80wJc8=;
        b=qjZgr70X4ymgqXkPJuSjMAuKdcRKkaM41PNjZGkwMIjlTmaAez7gF+nGgwFbXFSWm7
         zN+2R2Se7RA/r3I+j3yuzk1u6AzXtV6odJvRLGy38thg01navJk6sMWVKYlNj56nOefi
         oq06/sAhfhn/GLYdWeS2+lRDgKgqc/x0TmDGMBBe0SJBlU72nBvcN5sD75IoHg1tT51h
         R4FKwUrY6P5GZC+CffxknD/eQqTFywBpAysun1luPrgkh10t5ph7k8S35QZkfbY/Ynat
         eQ11LF47Lbbxf1dGN4ULXoWa5No2hi5jSB9S39b+X0suThIqU6bXhtLxsWqYur4Eiu2Z
         KN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FRFTxc+u4BH/1GAAIPOoN0jFTJbwpCr2MyiZ80wJc8=;
        b=MtZMZVira7uiVZU9l6ICHONAWp35rNoWq8dfqLhnxDAk5q9q2eZcwo4Qe5X88CGI61
         oflinPnJj+REuKVqvhkqGc1byvREmxdU5DOvkVIX0cEOTmaWpu/yEljlFe2wwp16g3Ap
         jWBBU/TtahL6+yr6cW7ZTSuzaFs7pV7FSsmmLkFeOH3hUiH1pJtIzulsLAMoRgcaTa72
         RVwd1a85lJIriPlnJ0Vq1KbooNtZb4kP+86cdZNlVtIO9TQtKyIjvaMARqAuN/AHOM6l
         4Z+CJnKPduTdfo0ztCjUAdH+olNXhVNOafEC3R2DKKzgl3+dJNc2gZ9JCaxK30vW1dpJ
         +m9A==
X-Gm-Message-State: AOAM532LzSwia+twX0trRCpcqHnaQoxm6GH2/bMP2KS5iKycODTxykuP
        /vpbqdGCQiW+UBeR3eFRU0ggB2L1ctTDJ45S
X-Google-Smtp-Source: ABdhPJxzDgxdqoHFTnc+2CgNY0pKxVHq9tmti3kYMCh7jTdluyxYCnq86kTnu2MTomyYsX+BxhiaDA==
X-Received: by 2002:a05:622a:1787:b0:2cf:9441:19e8 with SMTP id s7-20020a05622a178700b002cf944119e8mr6932499qtk.499.1645196619459;
        Fri, 18 Feb 2022 07:03:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm4119989qtp.4.2022.02.18.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 6/8] btrfs: do not double complete bio on errors during compressed reads
Date:   Fri, 18 Feb 2022 10:03:27 -0500
Message-Id: <1bf9827c7aad64c1686e1d6d51bc7a023f989c33.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
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

I hit some weird panics while fixing up the error handling from
btrfs_lookup_bio_sums().  Turns out the compression path will complete
the bio we use if we set up any of the compression bios and then return
an error, and then btrfs_submit_data_bio() will also call bio_endio() on
the bio.

Fix this by making btrfs_submit_compressed_read() responsible for
calling bio_endio() on the bio if there are any errors.  Currently it
was only doing it if we created the compression bios, otherwise it was
depending on btrfs_submit_data_bio() to do the right thing.  This
creates the above problem, so fix up btrfs_submit_compressed_read() to
always call bio_endio() in case of an error, and then simply return from
btrfs_submit_data_bio() if we had to call
btrfs_submit_compressed_read().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 20 ++++++++++++++------
 fs/btrfs/inode.c       | 12 ++++++++----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 747920ce1c17..6dc727d38d5c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -808,7 +808,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
-	blk_status_t ret = BLK_STS_RESOURCE;
+	blk_status_t ret;
 	int faili = 0;
 	u8 *sums;
 
@@ -821,14 +821,18 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
-	if (!em)
-		return BLK_STS_IOERR;
+	if (!em) {
+		ret = BLK_STS_IOERR;
+		goto out;
+	}
 
 	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
 	compressed_len = em->block_len;
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
-	if (!cb)
+	if (!cb) {
+		ret = BLK_STS_RESOURCE;
 		goto out;
+	}
 
 	refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
 	cb->status = BLK_STS_OK;
@@ -851,8 +855,10 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
 	cb->compressed_pages = kcalloc(nr_pages, sizeof(struct page *),
 				       GFP_NOFS);
-	if (!cb->compressed_pages)
+	if (!cb->compressed_pages) {
+		ret = BLK_STS_RESOURCE;
 		goto fail1;
+	}
 
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
 		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS);
@@ -938,7 +944,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			comp_bio = NULL;
 		}
 	}
-	return 0;
+	return BLK_STS_OK;
 
 fail2:
 	while (faili >= 0) {
@@ -951,6 +957,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	kfree(cb);
 out:
 	free_extent_map(em);
+	bio->bi_status = ret;
+	bio_endio(bio);
 	return ret;
 finish_cb:
 	if (comp_bio) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 24099fe9e120..69fa71186e72 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2542,10 +2542,14 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			goto out;
 
 		if (bio_flags & EXTENT_BIO_COMPRESSED) {
-			ret = btrfs_submit_compressed_read(inode, bio,
-							   mirror_num,
-							   bio_flags);
-			goto out;
+			/*
+			 * btrfs_submit_compressed_read will handle completing
+			 * the bio if there were any errors, so just return
+			 * here.
+			 */
+			return btrfs_submit_compressed_read(inode, bio,
+							    mirror_num,
+							    bio_flags);
 		} else {
 			/*
 			 * Lookup bio sums does extra checks around whether we
-- 
2.26.3

