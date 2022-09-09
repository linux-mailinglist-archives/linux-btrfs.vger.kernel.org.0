Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479E25B41B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiIIVx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIIVxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:53:55 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB7F913B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:53:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r20so1644967qtn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=9lhOBWAtwRXXN1xkbQc+GDl6n3yAIaM6dUgf7ugdbx0=;
        b=LJ9pRJ4U2tRqY0EESS/x2oNRwxKpafD3Xl50cREVynHp5Z7uYl3lonJm2Xg0JvfYH2
         bTjyi9eYIlEKmXUJn4sqgyGhUAjNpn9hg+Mzt8/eum7kEhShw2NnqcOaa4IzAtDNeuE/
         PD1IuXyftBypoGT3nPbVY16Firf1rUxE20RPDOupxDmO+2cqpN3B5STiSiRgnbd+gqJp
         KAHFv00qDEx86B08C9jlX/bK/e4MZjCRDwXfiQdBTUGkdy7LporfmgV4Pg3oqL1oWprr
         3Dzk35oXxgkSgufuC5ARqpOMf31gfu9jvpV2ygSBgym0A1etp0ur67KitVACrj+46IoK
         F6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9lhOBWAtwRXXN1xkbQc+GDl6n3yAIaM6dUgf7ugdbx0=;
        b=Kb8DlOtB5t4O9Ybe+jD9fObEIO9GFTiCLh6cy6G9nY63uYWwZa5gzoWoYptVnNbnKI
         EFJiOSSgQGe5LMdKW5O1UOUd5jxfkTqglFwjHAWvZF6fKqAhiaInvGe7Fh1O0PEptRGb
         roI/s/x21il8qZDFqa96bPxoVnhvqagOD8pgvSpG8pUjqtphnFsGfHGiJD6dYl+YTuAo
         Fr9+zLeFH8Du1+TlHHKllUlRsH+IA3GFtNX0d5rnb/2EJ3Q3v8bjRhm/TFyuqSeJnntb
         jvimufMY470gOwOpk0JhIkJnNe7mF5Mo0ktSrWc8PHB7MgWCo0ZrNorRydWXpM2KSD71
         xWAg==
X-Gm-Message-State: ACgBeo3aMPlhZQNZIzY/lpuH1oLp6P+gH3iL9DRBPKYNhaKap3huNFqF
        FwtGE30JCd9kZWxyjgvqB5aOOpEb86JRgA==
X-Google-Smtp-Source: AA6agR5YwVthWKwtgyz17nmmiHTseKARliS+J0YiTKHV0aDaXH5tJodLVcQCE9mTfc/+kD/Pmcud8Q==
X-Received: by 2002:a05:622a:13cd:b0:344:7bcd:4411 with SMTP id p13-20020a05622a13cd00b003447bcd4411mr14141351qtk.644.1662760432969;
        Fri, 09 Sep 2022 14:53:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fe10-20020a05622a4d4a00b0035ba2f6d081sm1126888qtb.88.2022.09.09.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:53:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove extraneous args
Date:   Fri,  9 Sep 2022 17:53:14 -0400
Message-Id: <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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
index cea7d09c2dc1..5ee8b5be636d 100644
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
index 10849db7f3a5..548665299e57 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7869,8 +7869,6 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	blk_status_t err = BLK_STS_OK;
 	struct bvec_iter iter;
@@ -7883,9 +7881,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
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

