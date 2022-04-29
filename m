Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1410B514CFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377443AbiD2OeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377414AbiD2OeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAEF7F
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6W9ZkXg04aV32AKjx/3VnmeeT6dYTtfsLJHkxa9rRM0=; b=nRk1zQ4kn1PN/F58i70kks6Rl0
        7g7kWffk9NbyKny6wjbGBx6BuQSo0bBGyA8/cLOT448iDiWlaYDwMi2R7MX4LI3/x75B28h1RtXLe
        PybnXiSwljvhfxOvDmJv0WgX2ZMECkBYXlEdMUKDNzlGXgue078cw35Q/z+FX/9jOh4560GBQn0cD
        OS46dBnkifaFmqder8AJZckExxll3tos5XGBPwg7JlLMgpYnPsPptPm/ve/S0kA/q+VTPpSGhmaXN
        nz5nBsUNPmb07yzxeeLEGu6+tmDE+o8nXBzYVZmO7NzTo1SnB6OgBm/0RK/s2kXQAcCVIEgAULqBJ
        0kxVxANw==;
Received: from [2607:fb90:27d7:71af:6ca1:91e8:bf19:edd2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkRdt-00Bajt-EB; Fri, 29 Apr 2022 14:30:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: don't double-defer bio completions for compressed reads
Date:   Fri, 29 Apr 2022 07:30:34 -0700
Message-Id: <20220429143040.106889-5-hch@lst.de>
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

The bio completion handler of the bio used for the compressed data is
already run in a workqueue using btrfs_bio_wq_end_io, so don't schedule
the completion of the original bio to the same workqueue again but just
execute it directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6476a5d9c09e9..02c4cbd557dcd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2605,12 +2605,6 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio,
-			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
-			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto out;
-
 	if (bio_flags & EXTENT_BIO_COMPRESSED) {
 		/*
 		 * btrfs_submit_compressed_read will handle completing the bio
@@ -2620,6 +2614,12 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 		return;
 	}
 
+	ret = btrfs_bio_wq_end_io(fs_info, bio,
+			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
+			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
+	if (ret)
+		goto out;
+
 	/*
 	 * Lookup bio sums does extra checks around whether we need to csum or
 	 * not, which is why we ignore skip_sum here.
-- 
2.30.2

