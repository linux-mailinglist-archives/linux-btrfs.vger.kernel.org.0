Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F717EB3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCIVdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34258 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgCIVdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:02 -0400
Received: by mail-pj1-f68.google.com with SMTP id 39so360644pjo.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTJ/i6VyAf03sKqOP0yfj+YRFyIZuvyftpW9EALlG5U=;
        b=MX2IoLP/byRIN5Yo1YW7AcE0A0TLqNoNJ+NcYXkN5DmHTGr1jyVWtViKhVBvW0MxNz
         +Fo5qmZXGIduPGn8SSiJl+iYokGXnzn1fxl0tw9CCK9t4vDmglfbZvSD9KBcLW4tx5XX
         /C2w6nPpI2xhqkq3GCvG1IFepf4hTRmTJCgFAYjG8ux3x5JXNbDSzygsnGcD/vNH5pd8
         VG/Ghxg8CnH1lxU9LpTa4yZsTff/5/7CgNkO4xauG727mwbAxHAb9KlCqXdbbAI6gVEO
         EndIBEl+7JwZp7jT6kD8nEiiCPGhj1DPaYMS6DYDm8adDN1EYtWq8z8JEkyiLUTUA8gE
         hNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTJ/i6VyAf03sKqOP0yfj+YRFyIZuvyftpW9EALlG5U=;
        b=E46FYxRstQW6S6dyFODF52WPYBluaJ3BuYgZWI2YQCMdBV2Wf8/ra3payMi6Z1t+9H
         om+OFkwJpwmyW6bn0IKCqj8HfzEaSyVTzqkv5mUfsPUi882RpdDHozBQ/SqGj8Z9n2CE
         M5afjsxej28czG6EssqzFyH2fOLdudenApOB+xeVvQKfHG/Xq9dL/0K5yQOjyD3VNpRc
         OOv1z8EK3JcbjbdBTDpYpiEsEwWAGxQG0SGRZ3mSUFlLjagrrGVgxxt+H18xOg6O0w8d
         PNN0A0RQOOeJDNV24ELLn6LqSPlsgcgVmKA0VpCyk00keLfDd04uxMFQ3VrVI62F7YfM
         rL3Q==
X-Gm-Message-State: ANhLgQ0YaAw+RK9QL/hQO3IhHqaIWrhHg1nrSThfrTHSSZIvnJytCXJa
        YeiTkL1vG+Bvk36oXGUu3a12jvIR3yk=
X-Google-Smtp-Source: ADFU+vuznB8ivUMrnqlY6Z4DqNfjyrdhr2G7J/DR6OudYwtf/SqctKa/9ocFE0LR2qFteaQLAMebiA==
X-Received: by 2002:a17:902:9f87:: with SMTP id g7mr11022992plq.32.1583789581217;
        Mon, 09 Mar 2020 14:33:01 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:00 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/15] btrfs: rename __readpage_endio_check to check_data_csum
Date:   Mon,  9 Mar 2020 14:32:32 -0700
Message-Id: <f0404525ae352a08750f56a822512a52263d7277.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

__readpage_endio_check() is also used from the direct I/O read code, so
give it a more descriptive name.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e986056be3c..50476ae96552 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2725,10 +2725,9 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
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
@@ -2789,8 +2788,8 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	}
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
-	return __readpage_endio_check(inode, io_bio, phy_offset, page, offset,
-				      start, (size_t)(end - start + 1));
+	return check_data_csum(inode, io_bio, phy_offset, page, offset, start,
+			       (size_t)(end - start + 1));
 }
 
 /*
@@ -7593,9 +7592,9 @@ static void btrfs_retry_endio(struct bio *bio)
 
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
@@ -7645,8 +7644,9 @@ static blk_status_t __btrfs_subio_endio_read(struct inode *inode,
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
2.25.1

