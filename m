Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C086535BC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349287AbiE0Ina (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiE0In2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CB2AC64
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eB+5gB9D9FX3TVoZQAoCn6FKb/EkoZKAq3CE2JBaW3A=; b=TyuHvVF68kbsr8qrNM1LcNrGz+
        14+pmUw453zKee2MZvkE3DhSW++6Sip+86XVqhzcy8fijDO7sST3SgLWQpwktKNNCUq8Xcni7LXlG
        IoClhyZwHFpRBgFrf5lVT9v5xdgkPTDOBTvEaE89MEfmyLmR3qRkUKPfVTApPxblWwhGgsJq6btwk
        xa0xz0ousMagLqHYcmFY11/6BQIz4qFimHOB86LL7G57xl3dR4x/rD6SW3nYoA5/15kyX4JxuLOlu
        /afsgPWfCef1VIwuJGyLVud6U6KStONlFN9WfI8rovYr0Q+1JsroTuo7Elxi/d3UGiMH32qzW9FnE
        4Alo4vFQ==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZ6-00H3UM-RR; Fri, 27 May 2022 08:43:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: save the original bi_iter into btrfs_bio for buffered read
Date:   Fri, 27 May 2022 10:43:12 +0200
Message-Id: <20220527084320.2130831-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

Although we have btrfs_bio::iter, it currently have very limited usage:

- RAID56
  Which is not needed at all

- btrfs_bio_clone()
  This is used mostly for direct IO.

For the incoming read repair patches, we want to grab the original
logical bytenr, and be able to iterate the range of the bio (no matter
if it's cloned).

So this patch will also save btrfs_bio::iter for buffered read bios at
submit_one_bio().
And for the sake of consistency, also save the btrfs_bio::iter for
direct IO at btrfs_submit_dio_bio().

The reason that we didn't save the iter in btrfs_map_bio() is,
btrfs_map_bio() is going to handle various bios, with or without
btrfs_bio bioset.
And we  want to keep btrfs_map_bio() to handle and only handle plain bios
without bother the bioset.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eaeef64ea3486..025444aba2847 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2633,6 +2633,10 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
 
+	/* save the original iter for read repair */
+	if (bio_op(bio) == REQ_OP_READ)
+		btrfs_bio(bio)->iter = bio->bi_iter;
+
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * btrfs_submit_compressed_read will handle completing the bio
@@ -7947,6 +7951,10 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
 	blk_status_t ret;
+		
+	/* save the original iter for read repair */
+	if (btrfs_op(bio) == BTRFS_MAP_READ) {
+		btrfs_bio(bio)->iter = bio->bi_iter;
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		goto map;
-- 
2.30.2

