Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B050DAB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiDYH7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbiDYH5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:57:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3BBF1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IMa1hZ3Qg//hCNugJWftcFipPjSAKoJl14BmMyI94wk=; b=GjuZF9iour0S8B5PStXZnhRyC3
        BztV93H/AIctBMggvIkf4c9oYI9YzL3AscbzurX9V8U4VcvhcNOAh85gGwp5C4WQwXmzINUrIXKfZ
        Zc7I04/ThXUfXyI7x6et20WI58HVQmzFuq6uD/L2tD+ZGAGgBUR3fAgG677GN3cKOyh6Xt+karux4
        fX1XGOMv5jYiGCi7jNNmZ5zIma7RPo0rtHAp4X/JdJ7tT/f8MbHFWZO8VnOabEnSeFpiAwy5mKZwI
        nXLAgO5G0wRZSMCDx7nCEk15UfdbOzGz7AGGL0E32/jHomrqeuqcQalb0EJ2mK9WEV9ByAnOdtAhg
        MnUqtQww==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitYD-008gem-JG; Mon, 25 Apr 2022 07:54:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs: cleanup btrfs_submit_dio_bio
Date:   Mon, 25 Apr 2022 09:54:10 +0200
Message-Id: <20220425075418.2192130-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425075418.2192130-1-hch@lst.de>
References: <20220425075418.2192130-1-hch@lst.de>
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
---
 fs/btrfs/inode.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef3bee1cbc6db..b188f724eff2d 100644
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

