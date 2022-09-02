Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D555AB95C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIBUQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIBUQy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:54 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E568DD8B3B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:41 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q8so2251394qvr.9
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Dzw3EWx7kn6eUX0ykefO6AJK6Hnu5AfB5HKCh1k4CsU=;
        b=yI4y11bSJy+ywMeKeo5RjBz2OObSFTGcXC3MklHWp+5k5EAa7wT6ys3vBTH+IZpPrU
         8yx/VzmU5d3SR8GiTskg+sqj9oUcXml/NsKHrcf9XbFu8hO0edSzArhfG0l+ZJnRXFc0
         CrsAOt1u0pObSJN0jOIXfSG4rJzWv/adJvE4Us+GMVg6WKJchfD8y1VF0ybLYae4h6Oc
         Ir+THxuAXx+DSNDoptbp/KuSOdHTzuLVNN8ymZHv/x0nctGTqQJCGZ6H9WQVwmd2ydA4
         QmnGn9ZH41Ju8gEQOUuJxf3YhwCl5hi0/B/Ksx2QiLgFvIKNvMj82fGJO6eUGCJidKIo
         vflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Dzw3EWx7kn6eUX0ykefO6AJK6Hnu5AfB5HKCh1k4CsU=;
        b=K4Laq/Cif5jGt6qrO+XwO72lEZXNVFjzlgVfKpXZjAuvJcanSsE4fWIjUbKAR4OM0m
         jaLtyGrEEEkPvVSMrU7ecGlGihm1zJkgNH/nNwKrT+kjTtICVJHc8BfY1D9oi58N+fSK
         LspWq6Hq9I4yNIY4U+2f4PgtGi2UdIQKV3J+fDhf2GliVIK9JiAJ77n9SLQYjYU+NNtj
         aMSwupGyvomG/VI+gwHjdh/6zqk8UngVc9lCP33LdyR3B5GhRq9XM7zPHg/7hrB3sJ6x
         +kic/8Wq9+ByRfH6AywT4C45/BJ/SG1uJVUw/2bZi7816DYGRHxFJPCv4/h5/yuoN7lR
         cnQw==
X-Gm-Message-State: ACgBeo3LquHxViZdoXjnkGR01br9467+Wp9hWaFks2z0/6hKEkkXbbgA
        Q3fh04sOMb1JSbUTFae089+53PYVtXPCzA==
X-Google-Smtp-Source: AA6agR6C8oHC9j1qcoexhtgGdpzB6TaqecYU7M3fftWTRrPDkiQdWXjRpDM0kDKmxmgN4AMJCujMXw==
X-Received: by 2002:a05:6214:d4e:b0:499:669:de05 with SMTP id 14-20020a0562140d4e00b004990669de05mr21164525qvr.9.1662149800535;
        Fri, 02 Sep 2022 13:16:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 184-20020a3706c1000000b006b6757a11fcsm1885339qkg.36.2022.09.02.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/31] btrfs: cleanup clean_io_failure
Date:   Fri,  2 Sep 2022 16:16:06 -0400
Message-Id: <7d5c4a3ca2ceb19fb3c84d5f3e716828cae0fb86.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

This is exported, so rename it to btrfs_clean_io_failure.  Additionally
we are passing in the io tree's and such from the inode, so instead of
doing all that simply pass in the inode itself and get all the
components we need directly inside of btrfs_clean_io_failure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c    |  5 ++---
 fs/btrfs/extent-io-tree.h |  6 ++----
 fs/btrfs/extent_io.c      | 17 +++++++----------
 fs/btrfs/inode.c          |  7 ++-----
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1c77de3239bc..cac0eeceb815 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -183,9 +183,8 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
 		if (!status &&
 		    (!csum || !btrfs_check_data_csum(inode, bbio, offset,
 						     bv.bv_page, bv.bv_offset))) {
-			clean_io_failure(fs_info, &bi->io_failure_tree,
-					 &bi->io_tree, start, bv.bv_page,
-					 btrfs_ino(bi), bv.bv_offset);
+			btrfs_clean_io_failure(bi, start, bv.bv_page,
+					       bv.bv_offset);
 		} else {
 			int ret;
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ec2f8b8e6faa..bb71b4a69022 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -256,9 +256,7 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 int free_io_failure(struct extent_io_tree *failure_tree,
 		    struct extent_io_tree *io_tree,
 		    struct io_failure_record *rec);
-int clean_io_failure(struct btrfs_fs_info *fs_info,
-		     struct extent_io_tree *failure_tree,
-		     struct extent_io_tree *io_tree, u64 start,
-		     struct page *page, u64 ino, unsigned int pg_offset);
+int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
+			   struct page *page, unsigned int pg_offset);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 591c191a58bc..acfbf029c18e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2431,11 +2431,13 @@ static int prev_mirror(const struct io_failure_record *failrec, int cur_mirror)
  * each time an IO finishes, we do a fast check in the IO failure tree
  * to see if we need to process or clean up an io_failure_record
  */
-int clean_io_failure(struct btrfs_fs_info *fs_info,
-		     struct extent_io_tree *failure_tree,
-		     struct extent_io_tree *io_tree, u64 start,
-		     struct page *page, u64 ino, unsigned int pg_offset)
+int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
+			   struct page *page, unsigned int pg_offset)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_io_tree *failure_tree = &inode->io_failure_tree;
+	struct extent_io_tree *io_tree = &inode->io_tree;
+	u64 ino = btrfs_ino(inode);
 	u64 private;
 	struct io_failure_record *failrec;
 	struct extent_state *state;
@@ -2963,7 +2965,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
 	struct bio_vec *bvec;
-	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
@@ -2990,8 +2991,6 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
 			bbio->mirror_num);
-		tree = &BTRFS_I(inode)->io_tree;
-		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
 		/*
 		 * We always issue full-sector reads, but if some block in a
@@ -3032,9 +3031,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
 
-			clean_io_failure(BTRFS_I(inode)->root->fs_info,
-					 failure_tree, tree, start, page,
-					 btrfs_ino(BTRFS_I(inode)), 0);
+			btrfs_clean_io_failure(BTRFS_I(inode), start, page, 0);
 
 			/*
 			 * Zero out the remaining part if this range straddles
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9d40e25d978..a1b9e2a455d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7997,8 +7997,6 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	blk_status_t err = BLK_STS_OK;
 	struct bvec_iter iter;
@@ -8011,9 +8009,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		if (uptodate &&
 		    (!csum || !btrfs_check_data_csum(inode, bbio, offset, bv.bv_page,
 					       bv.bv_offset))) {
-			clean_io_failure(fs_info, failure_tree, io_tree, start,
-					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
-					 bv.bv_offset);
+			btrfs_clean_io_failure(BTRFS_I(inode), start,
+					       bv.bv_page, bv.bv_offset);
 		} else {
 			int ret;
 
-- 
2.26.3

