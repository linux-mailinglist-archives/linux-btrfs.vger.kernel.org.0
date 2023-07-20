Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2F75B062
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGTNu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjGTNu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 09:50:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111592106
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GTUJ1jiPaEUfuLkRAtPi0ov8YOqX5GXr7wgihItTg1c=; b=WKUsXQAN19pfsuI1tY3XYbAfNw
        uCPOE+WZfOkMF9aFT5M14fo2NA5W1joR2mxMc/v7AWN6FiWIoKUh+SxxzF4mjoZsZKdaJOq3pWSkF
        DWl5GVvQ/vGdxCgxaJshveRCKzoLR4dhb4BNdDCpHcoowJ+LACNjYmKjBHRDNExmPo7F6FwIxPHXK
        xPL9uHmnipnqqvM46iY6HdjlpPx/hLxYHevdp5yQNlxOw7UaDtKXdsyFzjnBtygaGUmDXnJUKZLFi
        1EZf3mmm8sSCiJurpyV/vruvTyUYR7w6/i2pX75cialAZt1dC/spivWCPGrOmSq6uTP2Z/LjEY6Ow
        LIXhFpig==;
Received: from [2001:4bb8:19a:298e:a587:c3ea:b692:5b8d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMU3Q-00BI5H-1k;
        Thu, 20 Jul 2023 13:50:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use WARN_ON_ONCE in btrfs_destroy_inode
Date:   Thu, 20 Jul 2023 15:50:47 +0200
Message-Id: <20230720135047.60686-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a condition in btrfs_destroy_inode is tends to triggers for many
inodes during unmount.  Switch to WARN_ON_ONCE to reduce the log spam.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 02cf05dd730ade..c5464507271dac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8434,17 +8434,17 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	struct btrfs_root *root = inode->root;
 	bool freespace_inode;
 
-	WARN_ON(!hlist_empty(&vfs_inode->i_dentry));
-	WARN_ON(vfs_inode->i_data.nrpages);
-	WARN_ON(inode->block_rsv.reserved);
-	WARN_ON(inode->block_rsv.size);
-	WARN_ON(inode->outstanding_extents);
+	WARN_ON_ONCE(!hlist_empty(&vfs_inode->i_dentry));
+	WARN_ON_ONCE(vfs_inode->i_data.nrpages);
+	WARN_ON_ONCE(inode->block_rsv.reserved);
+	WARN_ON_ONCE(inode->block_rsv.size);
+	WARN_ON_ONCE(inode->outstanding_extents);
 	if (!S_ISDIR(vfs_inode->i_mode)) {
-		WARN_ON(inode->delalloc_bytes);
-		WARN_ON(inode->new_delalloc_bytes);
+		WARN_ON_ONCE(inode->delalloc_bytes);
+		WARN_ON_ONCE(inode->new_delalloc_bytes);
 	}
-	WARN_ON(inode->csum_bytes);
-	WARN_ON(inode->defrag_bytes);
+	WARN_ON_ONCE(inode->csum_bytes);
+	WARN_ON_ONCE(inode->defrag_bytes);
 
 	/*
 	 * This can happen where we create an inode, but somebody else also
-- 
2.39.2

