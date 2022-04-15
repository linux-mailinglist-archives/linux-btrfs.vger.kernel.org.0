Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426D3502BFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350007AbiDOOgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiDOOgM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:36:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C2A94FB
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=s9y1MmOCiBS4lgXGLjSeEb41v2mw1Oy66MKlhTGeug8=; b=fXow2rokmIMSX3omr+MB0TvrKU
        PbsKONTwK7nVi8GK18Hdu1nVchvypRk3hbOZ7s2smtt47EpGCsg65apqeuuZfXosTzBadPZTuKQDT
        TojwvUTD7X5Kjnj+jR4FE3rtjLhpbHHT4u1pN8sapCpH4B+qYxzWsMHJBC0Z2SfCrOxLqCZMWpR/Z
        WMw7dElTp/bFXNluPmydSjtxYOubL27IkNqL7dNRCbRqQAIaR2rdP2Bqf3FDYDoKOMDt8LVPmDfBh
        yjDb18m6sNway8SlAOR2HtCz+hteqytOPXNB890O3/+kOvE57gEQ6x00btxKE83m9JbkFQhLh6FPY
        aL0iaFDw==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfN12-00AMuA-Ey; Fri, 15 Apr 2022 14:33:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: do not return errors from btrfs_submit_compressed_read
Date:   Fri, 15 Apr 2022 16:33:27 +0200
Message-Id: <20220415143328.349010-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
References: <20220415143328.349010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_submit_compressed_read already calls ->bi_end_io on error and
the caller must ignore the return value, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 11 +++++------
 fs/btrfs/compression.h |  4 ++--
 fs/btrfs/inode.c       |  8 +++-----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3e8417bfabe65..8fda38a587067 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -801,8 +801,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags)
+void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
+				  int mirror_num, unsigned long bio_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map_tree *em_tree;
@@ -947,7 +947,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			comp_bio = NULL;
 		}
 	}
-	return BLK_STS_OK;
+	return;
 
 fail:
 	if (cb->compressed_pages) {
@@ -963,7 +963,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	free_extent_map(em);
 	bio->bi_status = ret;
 	bio_endio(bio);
-	return ret;
+	return;
 finish_cb:
 	if (comp_bio) {
 		comp_bio->bi_status = ret;
@@ -971,7 +971,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	}
 	/* All bytes of @cb is submitted, endio will free @cb */
 	if (cur_disk_byte == disk_bytenr + compressed_len)
-		return ret;
+		return;
 
 	wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
 			   (disk_bytenr + compressed_len - cur_disk_byte) >>
@@ -983,7 +983,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	ASSERT(refcount_read(&cb->pending_sectors));
 	/* Now we are the only one referring @cb, can finish it safely. */
 	finish_compressed_bio_read(cb);
-	return ret;
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index ac5b20731d2ad..ac3c79f8c3492 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -102,8 +102,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  unsigned int write_flags,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
-blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags);
+void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
+				  int mirror_num, unsigned long bio_flags);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f2fb2bfc2f9a2..414156c0ac38a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2618,10 +2618,9 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			 * the bio if there were any errors, so just return
 			 * here.
 			 */
-			ret = btrfs_submit_compressed_read(inode, bio,
-							   mirror_num,
-							   bio_flags);
-			goto out_no_endio;
+			btrfs_submit_compressed_read(inode, bio, mirror_num,
+						     bio_flags);
+			return BLK_STS_OK;
 		} else {
 			/*
 			 * Lookup bio sums does extra checks around whether we
@@ -2655,7 +2654,6 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		bio->bi_status = ret;
 		bio_endio(bio);
 	}
-out_no_endio:
 	return ret;
 }
 
-- 
2.30.2

