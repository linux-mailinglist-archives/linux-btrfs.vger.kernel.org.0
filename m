Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0A70F9B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjEXPDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEXPDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A42130
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UPuEp2pyF9HXTTkpgvrsDwER64K9cKesDZCDmWkhxco=; b=RXvlvBANAVXXEUQcXYI6oyf8C/
        Wc8+0gKR9IJYmmjqiNHgKGsXjby+/bao0v0sdB7QcAn7t+96X2BHFoSAUwftB6o/nH1jMdslfMBQc
        s/zfGZpHN+StMQ8rK/6udRhGXJ08DC4OC/blmy9kAuRvsa53FHVW5mKiPnR8BcaSMgpYF/YTEEcbU
        jqiWjuhOZZeduT2CcsUDl0HnSvtiTRiI0szJ/xehgfpGplHIXc0uLGpYO8Lk+ZbfeA7wDwM0qDrVZ
        xlnYDOWKfDrDBP7ZPrFhx2FAn/3sz5mHor9o2cswIFJhvfqLSFlScgG6G4nxnKew/ifCEd9V1iYCS
        en2F7U1A==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1j-00DmeW-13;
        Wed, 24 May 2023 15:03:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 09/14] btrfs: return void from btrfs_finish_ordered_io
Date:   Wed, 24 May 2023 17:03:12 +0200
Message-Id: <20230524150317.1767981-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
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

The callers don't check the btrfs_finish_ordered_io return value, so
drop it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        | 4 +---
 fs/btrfs/ordered-data.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 31124954ec6ecf..cee71eaec7cff9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3180,7 +3180,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
  * an ordered extent if the range of bytes in the file it covers are
  * fully written.
  */
-int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
+void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
 	struct btrfs_root *root = inode->root;
@@ -3383,8 +3383,6 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	btrfs_put_ordered_extent(ordered_extent);
 	/* once for the tree */
 	btrfs_put_ordered_extent(ordered_extent);
-
-	return ret;
 }
 
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 2a20017d9ec6f5..2c6efebd043c04 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -161,7 +161,7 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 	t->last = NULL;
 }
 
-int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
+void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
-- 
2.39.2

