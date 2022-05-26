Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA52534ADE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbiEZHhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiEZHg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5229BAD3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/SzDG9XF1t+x0f/2FAMrx+ysVxYnr+SFz9KCWrk6bxk=; b=j2LZ6nN8AXtGnJcUbR0nqScvJr
        UkoAta9t12lpSJ2YJrF1TPQBUPkG+0ITDI8D8kY78iY6odxNM4+Jlcq67obQD3W2U2IRGFOggAM29
        Pd9z6vEkm04JoteF6WjK5qMPu46QQ7Npm5/bXNUCKBieOUEgjhKeMNb3tVmKrd4PfPCnQ5SMOyiC0
        qhzUpVUO7b5c6wZ+afcThdNz60YVqzOt5KTpYJJeiev0PqPM9Qn/U8AwOr78TmtmsMujrW0dfrRR8
        f/jZqbrUlkFEwtUXXzhOjCcxJetbvi/+ZcimPkr49kJkVdZaDuSfvxOCKmycmfqsHsX0LvqZcfMz4
        r3U87BLw==;
Received: from [2001:4bb8:18c:7298:d94:e0f5:2d65:4015] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nu83F-00DpYI-1S; Thu, 26 May 2022 07:36:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: don't double-defer bio completions for compressed reads
Date:   Thu, 26 May 2022 09:36:37 +0200
Message-Id: <20220526073642.1773373-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526073642.1773373-1-hch@lst.de>
References: <20220526073642.1773373-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 7129bcaa53297..c01880fb5a646 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2633,12 +2633,6 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio,
-			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
-			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto out;
-
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * btrfs_submit_compressed_read will handle completing the bio
@@ -2648,6 +2642,12 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
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

