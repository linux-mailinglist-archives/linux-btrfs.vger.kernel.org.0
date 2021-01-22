Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C692300E20
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 21:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbhAVUvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 15:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbhAVUul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 15:50:41 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A51C06121F
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 12:47:28 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so4607730pgc.8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6h5hjUeTADVbhi8eHCMzrRhrLIPDNaWWcRgC7w9ijyo=;
        b=NSlH8Ne2gMtUEugZ8xzh7OlBaW2jT7JgdKEkjoSpfFEnbdGNk/E4akR24gYwxrdqw0
         fnXQQc9GpBsdfwJYPIUJtbLP1C/01acNe/9vsGGsBXJ8ScPiy9A9/3N0LOtXygCf6Mpt
         0atYzKkGBBCCo3+HHGeXGwGdzWAU9lnRumvLzEykLE5cAkTrvMNhkjHeoLdH5lUWHyoC
         sBhkF4Fi5tKTGNBHyyGgJVgd4d61bTjwSEeEm0soRXU7J4MNzEZd3XPRpULLlP2bTqIh
         YfothBa/R0Iv8fSdnhJd5WujYalhtKB+lgnpUlNZEiFCy/NCBTQBkBwmFepVgj/DY2QH
         5LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6h5hjUeTADVbhi8eHCMzrRhrLIPDNaWWcRgC7w9ijyo=;
        b=ZePns+cw8IwfsRVufJoSS2+HFXOcLTRSaUQeVWBGv+LfrGCKSeeJU017tZLQuS3Kif
         yjiAgQ19FoIpQueZiz6dLYxcUihBw6zk9CC9WjkFyUqfwVjKB9y4dU7MCnmFtD+zboss
         a70Fn/YTQK1tjHdSFmTwllhsEi+7dPnfFqrCYSrfUrg9GyaQk7mo47j65+CxL096GmAn
         hD+HCJX5C8nw2/NPEDEbPK1ZzqZvR9GlNzZJSwamqM+9FEf7GbR8idg/8RZfJ87s84/J
         lpogRx4h2EV96KqPB1U+25e3qWA6k7cQRpMR8UNUbi6VdEi56ayzktwR3FfXxwiJtym9
         CtKg==
X-Gm-Message-State: AOAM531frM0r7DU1fbDpzEmSLfqoyKPquJ3mhua6fVyflwPegkCvkXvE
        j7L4pp8T/P1YZjxNVCABMPUqew==
X-Google-Smtp-Source: ABdhPJzhrRQ2JKaTHVfq9C0+YrZj8Zv/nyNIO/WRAiVWyezpYTZdzbsa9CF7k6pZ/z2BekWOvSyXyw==
X-Received: by 2002:a63:4b5c:: with SMTP id k28mr66913pgl.294.1611348448453;
        Fri, 22 Jan 2021 12:47:28 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:27 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 04/10] btrfs: fix check_data_csum() error message for direct I/O
Date:   Fri, 22 Jan 2021 12:46:51 -0800
Message-Id: <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
References: <cover.1611346706.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
check_data_csum()") replaced the start parameter to check_data_csum()
with page_offset(), but page_offset() is not meaningful for direct I/O
pages. Bring back the start parameter.

Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_data_csum")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef6cb7b620d0..d2ece8554416 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2947,11 +2947,13 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @page:	page where is the data to be verified
  * @pgoff:	offset inside the page
+ * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   u32 bio_offset, struct page *page, u32 pgoff)
+			   u32 bio_offset, struct page *page, u32 pgoff,
+			   u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
@@ -2978,8 +2980,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), page_offset(page) + pgoff,
-				    csum, csum_expected, io_bio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
+				    io_bio->mirror_num);
 	if (io_bio->device)
 		btrfs_dev_stat_inc_and_print(io_bio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
@@ -3032,7 +3034,8 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	     pg_off += sectorsize, bio_offset += sectorsize) {
 		int ret;
 
-		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off);
+		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off,
+				      page_offset(page) + pg_off);
 		if (ret < 0)
 			return -EIO;
 	}
@@ -7742,7 +7745,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
 			    (!csum || !check_data_csum(inode, io_bio,
-					bio_offset, bvec.bv_page, pgoff))) {
+						       bio_offset, bvec.bv_page,
+						       pgoff, start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
 						 start, bvec.bv_page,
 						 btrfs_ino(BTRFS_I(inode)),
-- 
2.30.0

