Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0885502BF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354561AbiDOOgL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiDOOgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:36:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22938A9951
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CoWwbOpCj1SNh39HQvQm4IClPiupWnk7ahZVwhoP8Ns=; b=pZVXwFQFSdXZFz6Afy7ypcDxFV
        Ubxf92zm61yyp+KcY9Vhox/IXWLAoMEQuoRV8SrSt+XHstE41aqcPRxoffWdej7LJZgiTT3ZoskXq
        OL5YT/P6bCTZaFppm3K2aZKekkKjgXBOU0ruxPyFFMdy8evWepQkdHaOx52GWIr8Zzpl4b36kIXER
        lddz+704nGvn79J3GPQfJUicJ08t31TuQHgV4wYIJgiTOhWojtxMaRw0kqE/2ghUG3fwQuRobn2kM
        GYMJ9ckPc6SDASjJrHT0T663BSiEl0hPQ64c4OyKNmMnUJpo8WjegculQyjCSGwYXe+qW/jic9iPM
        94fTs3oQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfN10-00AMtS-7K; Fri, 15 Apr 2022 14:33:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: do not return errors from btrfs_submit_metadata_bio
Date:   Fri, 15 Apr 2022 16:33:26 +0200
Message-Id: <20220415143328.349010-4-hch@lst.de>
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

btrfs_submit_metadata_bio already calls ->bi_end_io on error and the
caller must ignore the return value, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 26 ++++++++++----------------
 fs/btrfs/disk-io.h |  4 ++--
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 28b9cf020b8df..9c488224edc73 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -920,8 +920,8 @@ static bool should_async_write(struct btrfs_fs_info *fs_info,
 	return true;
 }
 
-blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
-				       int mirror_num)
+void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
+			       int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
@@ -933,14 +933,12 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 		 */
 		ret = btrfs_bio_wq_end_io(fs_info, bio,
 					  BTRFS_WQ_ENDIO_METADATA);
-		if (ret)
-			goto out_w_error;
-		ret = btrfs_map_bio(fs_info, bio, mirror_num);
+		if (!ret)
+			ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
 		ret = btree_csum_one_bio(bio);
-		if (ret)
-			goto out_w_error;
-		ret = btrfs_map_bio(fs_info, bio, mirror_num);
+		if (!ret)
+			ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else {
 		/*
 		 * kthread helpers are used to submit writes so that
@@ -950,14 +948,10 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 					  0, btree_submit_bio_start);
 	}
 
-	if (ret)
-		goto out_w_error;
-	return 0;
-
-out_w_error:
-	bio->bi_status = ret;
-	bio_endio(bio);
-	return ret;
+	if (ret) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 56607abe75aa4..1312d93c02edb 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -87,8 +87,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
-blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
-				       int mirror_num);
+void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
+			       int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
-- 
2.30.2

