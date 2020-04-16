Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED51AD225
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgDPVqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgDPVqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C33C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so118762plp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPoL16KD4zJkxaql5M14RhRv+rZlvV4Dkvjaf7+tRhk=;
        b=BVSkejBHp8H9h5v7HKHxXY3+Erhk5uft256J8S/p3AttXoEgyXZaQ9QUkulzr7Iy2E
         o08h4gCFoGmDhhDT7dWkrbOD3cQwnzmxjWkGOqsDZFm09RROLcYSacEHphslq2m/2AyW
         AHJIEeBT/9nQZ0Q1ry6xGQXEkzJlIhv7+/7Yli0zdneS4D7fKN/xZT6E/dqv+pv3az6L
         2rE1QE8pwAT9mS6pL+9NiK5u2rn3g39wJR9E4RvQs7pq2OQCCUcNRRsFjkKgf6aXeS/P
         204ogmr1W8QVvXmHonM3Yin9wd7f7BNqiFB+p/w/mPC79XDEx8tVK6EfbXiTeZDR6ER4
         ELZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPoL16KD4zJkxaql5M14RhRv+rZlvV4Dkvjaf7+tRhk=;
        b=NqtQu5VOheSKUKhPYTVfxWDCTtgFrZAypYkeiidETilhUfONKVNQRiWOOq+M5MVkF+
         +lAXuJ+7MFxmXrVGLTUhRy97KhbVmjOtPEDgYMJjWPC0rO0RIxDJnf71A2z6OyjWgVq1
         Uy0PoykGrUsEqrZrY6SotKIMup9hQA5b10VnuOPoYKhgQjw5Tr656AN6tK5WBVKs4Utl
         S3OMkYDK6u1tLpOn23cfl2YHjsaJcmmncBtQeCQtGgQpSq6VQcbw1kC9lypNDD/emjRb
         v5wlUSLrv/htrU6nfG7Qbi0k1X+ZkP/Iqw7xjASoFNvjoEwUdRmVxn8vyqW7Q8aiBukr
         yzGA==
X-Gm-Message-State: AGi0PuaKmVIAhq2yUSyF6/4C9oiGUUTpDxGEVxggx3p0krp4oJ8UOsTE
        x7j7X02qITHKNYeSqDoAbT6oFhi71kQ=
X-Google-Smtp-Source: APiQypL5bdU7WuI5JLv99MoSiNM+6f8dAzfGusl7iv6XYmedb5fOq7mj5FwipKBkr8j/jKN+V+/7hA==
X-Received: by 2002:a17:90a:a40b:: with SMTP id y11mr482941pjp.130.1587073601439;
        Thu, 16 Apr 2020 14:46:41 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:41 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 07/15] btrfs: rename __readpage_endio_check to check_data_csum
Date:   Thu, 16 Apr 2020 14:46:17 -0700
Message-Id: <5627c63e0a8cbcb02eab1b539414f0ccc271426b.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

__readpage_endio_check() is also used from the direct I/O read code, so
give it a more descriptive name.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f6ce9749adb6..eb3fcdc7c337 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2726,10 +2726,9 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 	btrfs_queue_work(wq, &ordered_extent->work);
 }
 
-static int __readpage_endio_check(struct inode *inode,
-				  struct btrfs_io_bio *io_bio,
-				  int icsum, struct page *page,
-				  int pgoff, u64 start, size_t len)
+static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
+			   int icsum, struct page *page, int pgoff, u64 start,
+			   size_t len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
@@ -2790,8 +2789,8 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	}
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
-	return __readpage_endio_check(inode, io_bio, phy_offset, page, offset,
-				      start, (size_t)(end - start + 1));
+	return check_data_csum(inode, io_bio, phy_offset, page, offset, start,
+			       (size_t)(end - start + 1));
 }
 
 /*
@@ -7584,9 +7583,9 @@ static void btrfs_retry_endio(struct bio *bio)
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		ret = __readpage_endio_check(inode, io_bio, i, bvec->bv_page,
-					     bvec->bv_offset, done->start,
-					     bvec->bv_len);
+		ret = check_data_csum(inode, io_bio, i, bvec->bv_page,
+				      bvec->bv_offset, done->start,
+				      bvec->bv_len);
 		if (!ret)
 			clean_io_failure(BTRFS_I(inode)->root->fs_info,
 					 failure_tree, io_tree, done->start,
@@ -7636,8 +7635,9 @@ static blk_status_t __btrfs_subio_endio_read(struct inode *inode,
 next_block:
 		if (uptodate) {
 			csum_pos = BTRFS_BYTES_TO_BLKS(fs_info, offset);
-			ret = __readpage_endio_check(inode, io_bio, csum_pos,
-					bvec.bv_page, pgoff, start, sectorsize);
+			ret = check_data_csum(inode, io_bio, csum_pos,
+					      bvec.bv_page, pgoff, start,
+					      sectorsize);
 			if (likely(!ret))
 				goto next;
 		}
-- 
2.26.1

