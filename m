Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9670653C5C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 09:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiFCHLN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFCHLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 03:11:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456373633A
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SFXEiOEFnthXuTNIy3v7+GaVqb61Qx2+L6cLdOpYhkg=; b=Jb4eXLF36sGRfijmnYBeoVPuBK
        Mu1fVSV6a3Qx8yxFHy/kDSCk02/H3RH4RWCwYwFSgh7EXrCKYTxH4eme1RyquMPcMYjN5JkYDOvOW
        k6zvkLDuxYjQjaNU0/+pWpsbYxR2fl27WTCo8t1wnru08M3uRkeYf0d3qIF0ic96oIs0AGyvqwu/T
        gcVKqIVZ3jBx0Wn5tZamfvtwppTrXviCn2EDG8WGjwlodLgLFRJkYCFcFcHbP8FKuKquCbfvte+I2
        IardhPSj8NkMQCkX2aUWZ6w4QiL8iHtd8X0Md93LeBMrtDw+kqrNxV3/p6VRNHOD/uGhHtlTccA8t
        W0GqQ8gA==;
Received: from [2001:4bb8:185:a81e:b29a:8b56:eb9a:ca3b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx1Sd-006EmP-QX; Fri, 03 Jun 2022 07:11:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: don't use bio->bi_private to pass the inode to submit_one_bio
Date:   Fri,  3 Jun 2022 09:11:01 +0200
Message-Id: <20220603071103.43440-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603071103.43440-1-hch@lst.de>
References: <20220603071103.43440-1-hch@lst.de>
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

submit_one_bio is only used for page cache I/O, so the inode can be
trivially derived from the first page in the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b5f872d2eb9f..025349aeec31f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -181,10 +181,7 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 static void submit_one_bio(struct bio *bio, int mirror_num,
 			   enum btrfs_compression_type compress_type)
 {
-	struct extent_io_tree *tree = bio->bi_private;
-	struct inode *inode = tree->private_data;
-
-	bio->bi_private = NULL;
+	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
@@ -3360,7 +3357,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
 	bio->bi_end_io = end_io_func;
-	bio->bi_private = &inode->io_tree;
 	bio->bi_opf = opf;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
-- 
2.30.2

