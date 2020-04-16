Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31A1AD224
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgDPVqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728445AbgDPVql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8EFC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a22so124660pjk.5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvhwnRTLtN+fEx765ccxADScIuZl05CxCF78j/Vtem8=;
        b=CUGc/cGxQ/+am7qYJzFbTtYdejPaqwrPtvJNuVGcwGdqaQwdmjPKxJ82rFAygbY4qN
         HUcAbjCwhLAy+m+yi+G35NdFMCOQ/TYlYKn1VZ4hCHqV5aH8cTcKoQCWF/rN/Zj0Boq7
         NaWQYuQgAn2YH3xgTr+bsQ9BFEiqxVP3l8UnHESsLo7OpaN01Akmp9wVhCOTpfyXBNHk
         CSZrG/X2NTD/J6/0Alfj319R5DiNEkTWwoszlB87+11/2ty/dPB/QZvTEzxFOrWcb2AM
         +XRibCjlPG9Ktp5mZa5S2ZPOVADaAZYHXtWxArbTcfNTVuAfD87X5xl+2FCFruEPpuMi
         Ptgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvhwnRTLtN+fEx765ccxADScIuZl05CxCF78j/Vtem8=;
        b=kMlVcRWRSTeFJUU1WesffPqGpa13uODej//vYuqA6zXit/OzumEvMKZcQMvG7Km5AP
         WdYI/uh+Scyk8YJGfpDYfqZxkwCYBRHnQwpAR9jjAU/O6UcsfTH40h/MvKZkxaOF0JXs
         y5oeHQl7k09iYZd4UfnppsR769YZQRijuVvWQx+z/vw9TPlfBSOKLVFgVG83WPJeNCX0
         PCVcQN9wBCrfVIUUnXzqeWAGToQyBhdYYrHhjdz0iumN3+8zhcVY0V2yPkFsXECtHRgD
         aQw4vWPuOo0Glnr5EEZvQwh42cf+t/mAY9rpA8eXnTQ0iWYbiOmusEV3i53LoJKZUWgl
         i3rA==
X-Gm-Message-State: AGi0PuZLjnmT/Sunq9pbMk542CnDnubV8Y5CTWAuml2dNLmnEyf6SZQl
        2JoErRT0/yx3nvu8l9HQxJ2IfRn5Mn4=
X-Google-Smtp-Source: APiQypJjCkSPlNHULjmXHFLfA4KhTJZ5wwDxXi2BDPlXa5y/ZGnA/aIa+Vkx92PEWWc+Ck+NEoonkQ==
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr432651pjb.37.1587073600440;
        Thu, 16 Apr 2020 14:46:40 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:39 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/15] btrfs: clarify btrfs_lookup_bio_sums documentation
Date:   Thu, 16 Apr 2020 14:46:16 -0700
Message-Id: <51f9f9b917ded1057f1d24f7bbf7546492f3ea98.1587072977.git.osandov@fb.com>
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

Fix a couple of issues in the btrfs_lookup_bio_sums documentation:

* The bio doesn't need to be a btrfs_io_bio if dst was provided. Move
  the declaration in the code to make that clear, too.
* dst must be large enough to hold nblocks * csum_size, not just
  csum_size.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/file-item.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index b618ad5339ba..22cbb4da6d42 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -242,11 +242,13 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 /**
  * btrfs_lookup_bio_sums - Look up checksums for a bio.
  * @inode: inode that the bio is for.
- * @bio: bio embedded in btrfs_io_bio.
+ * @bio: bio to look up.
  * @offset: Unless (u64)-1, look up checksums for this offset in the file.
  *          If (u64)-1, use the page offsets from the bio instead.
- * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
- *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
+ * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
+ *       checksum (nblocks = bio->bi_iter.bi_size / fs_info->sectorsize). If
+ *       NULL, the checksum buffer is allocated and returned in
+ *       btrfs_io_bio(bio)->csum instead.
  *
  * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
  */
@@ -256,7 +258,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
 	struct btrfs_csum_item *item = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
@@ -277,6 +278,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 
 	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
 	if (!dst) {
+		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
+
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			btrfs_bio->csum = kmalloc_array(nblocks, csum_size,
 							GFP_NOFS);
-- 
2.26.1

