Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D780519F43
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349432AbiEDM3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349433AbiEDM3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6F25D8
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QxSvgApOoz47bvfuFlYw117u1C0uSJbbsu4gnZONafk=; b=QiCqcryzoaVsP9u3X9BwYHWmI9
        NMfD9pQGTSDDriBCPNxxoIx8ViX+g6GrW4rUBzpJEKGMV0YbW/Ed9LHA/XoyDBbUmASZ6f/LTeYPA
        UpX0VorZO3kfKlz4osbQxdc707rPTBLj9lPon0rLuWbz+ljYJn8k+BbqUaOPOcdl9ahGlpInOYY+q
        D1ptoFZGknHnEjOIQTgXJq49INNQ6bTr+bk52rU+QEd20bQhOIqHV3hdIXD1qGwtCcLSjWTmkXKJM
        cUpHLntmI/5AYO97nheR1hLFTsKFy1NSKsj8CeSCWct8BM0bBbBgnQ47eQCnuwXH0sHEc+RW3hIod
        sQdoV+bg==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4M-00Ahm9-TI; Wed, 04 May 2022 12:25:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/10] btrfs: cleanup btrfs_submit_dio_bio
Date:   Wed,  4 May 2022 05:25:17 -0700
Message-Id: <20220504122524.558088-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504122524.558088-1-hch@lst.de>
References: <20220504122524.558088-1-hch@lst.de>
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

Remove the pointless goto just to return err and clean up the code flow
to be a little more straight forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39da19645e890..b98f5291e941c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7948,31 +7948,27 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
-	/* Check btrfs_submit_bio_hook() for rules about async submit. */
-	if (async_submit)
-		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
-
 	if (!write) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		goto map;
 
-	if (write && async_submit) {
-		ret = btrfs_wq_submit_bio(inode, bio, 0, file_offset,
-					  btrfs_submit_bio_start_direct_io);
-		goto err;
-	} else if (write) {
+	if (write) {
+		/* check btrfs_submit_data_bio() for async submit rules */
+		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
+			return btrfs_wq_submit_bio(inode, bio, 0, file_offset,
+					btrfs_submit_bio_start_direct_io);
 		/*
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
 		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret)
-			goto err;
+			return ret;
 	} else {
 		u64 csum_offset;
 
@@ -7982,9 +7978,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		btrfs_bio(bio)->csum = dip->csums + csum_offset;
 	}
 map:
-	ret = btrfs_map_bio(fs_info, bio, 0);
-err:
-	return ret;
+	return btrfs_map_bio(fs_info, bio, 0);
 }
 
 /*
-- 
2.30.2

