Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C6514CF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377411AbiD2OeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377418AbiD2OeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E610F7A
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wEoSkHTlNTWk+5H+QuZIQpSEI48X3r+1EGB9cSfbQck=; b=A2hG5zftdN3VQ/EomFWxmzp08W
        Zg84RFmx7DwftQbA5qOwg5jR689+4Dah5JStBiLGrbBKuZUr/1YG2mfHcdQPDeqr1dQOJIfYtA6fO
        sCicKbQKkXmXJgv+3OF9QQfXW2BLd2rj8ZLnpJZbsSjAmna6yzCPfQUT/dx9R+NFa8JF7Mxs9YT0R
        aDub+UJ1KokFAH2R4vbDbHf7bEdDYywL3GGRZXrITxUz3WO6OTijbLJKgTROIJp6arQd9ZQ2dAGYv
        1Khcp5+PJsK0YD8CI1X09ezr36qPtkLdlGuCPo4+CvqMn6I8OOSji1ZXwzEJNkBB6QEvE4zOW/Yh9
        oZTMoJTQ==;
Received: from [2607:fb90:27d7:71af:6ca1:91e8:bf19:edd2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkRdr-00BajL-LZ; Fri, 29 Apr 2022 14:30:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/10] btrfs: cleanup btrfs_submit_dio_bio
Date:   Fri, 29 Apr 2022 07:30:32 -0700
Message-Id: <20220429143040.106889-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429143040.106889-1-hch@lst.de>
References: <20220429143040.106889-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/btrfs/inode.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b7df1c0ee5ee..3be52ed6ed196 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7899,31 +7899,28 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
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
-		ret = btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
-					  btrfs_submit_bio_start_direct_io);
-		goto err;
-	} else if (write) {
+	if (write) {
+		/* check btrfs_submit_data_bio() for async submit rules */
+		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
+			return btrfs_wq_submit_bio(inode, bio, 0, 0,
+					file_offset,
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
 
@@ -7933,9 +7930,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
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

