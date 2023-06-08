Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F25727AE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjFHJMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjFHJLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:11:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1357BE46
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NVTzS1/v1hmnV3McvqLU1/PexT1wMYrK4Hoak6PEa7A=; b=dXoRt0z3f8xUvYoV8cXlIxjEIe
        6I7leV0BtQTCkaCjdIuI8+Et/HhFIHRyJvFikigvbq8bJSXxT4m+ccN4J6k0lJdhM5voarTrNtTeZ
        jjiY5zYrDhyTnnuJtz0mAe0yQ4RA6gkGun05Fu+7MnOmAkevlHviNJ6mNLswIOlPJcUbFj01r/8eM
        pAJ5aeRC329WMGIjqeAC94SjE4kRsYhMv6fp1jQxlgMKuxHMYQB9D7VGJVl6G1v0K3whgTtS8r2gb
        e4AxGfg/5yXafdvcKKqW8jI2DvNRVoJSMQ7YDsqP5T7DTM94SB0SG9B06Z4Guio/JwgBYCBAfv5sI
        FvA1a6zw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Bg7-008eRl-2x;
        Thu, 08 Jun 2023 09:11:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date:   Thu,  8 Jun 2023 11:11:33 +0200
Message-Id: <20230608091133.104734-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
wiring up a dummy direct_IO method to indicate support for direct I/O.
Do that for btrfs so that noop_direct_IO can eventually be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file.c  | 1 +
 fs/btrfs/inode.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f649647392e0e4..af5bfe13824512 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3710,6 +3710,7 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	int ret;
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
+	filp->f_mode |= FMODE_CAN_ODIRECT;
 
 	ret = fsverity_file_open(inode, filp);
 	if (ret)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3f99f02dc1fe20..027e28fc69b2fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10903,7 +10903,6 @@ static const struct address_space_operations btrfs_aops = {
 	.read_folio	= btrfs_read_folio,
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
-	.direct_IO	= noop_direct_IO,
 	.invalidate_folio = btrfs_invalidate_folio,
 	.release_folio	= btrfs_release_folio,
 	.migrate_folio	= btrfs_migrate_folio,
-- 
2.39.2

