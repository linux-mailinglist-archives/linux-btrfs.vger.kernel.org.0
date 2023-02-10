Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A680169195E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjBJHtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBJHtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:49:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B55C483
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OMhCkzrE6bRmLSRBSywYaPvNr/8GwRfLl0Y8/hIm4SE=; b=UWzKBJ68jOsBTrJz5nrJ66ajNl
        SfLh+0zCcUFlrTbZFDV6yVIzUi9shFY5YXtbD/gxc2gxZVihn4D8vQLt0ZHtU2zgjdAuCQrieHzDb
        A4jROcjLHuU6ZmykpMbd5lxRl6A1ubUJMwQSoBQ4g2uLl0cEldCAhigYnE2eO9J2PYbzkyahmE6mh
        aRKpDpEOO8tSb3/lg4sBJP7BH1iVgIFnUHHf1pcgr4FOCvxxCrJM9Xo/XyNAaNDBK9Pn6DdrU8SaE
        SE2NpSSrDzRtBOMP9eW0y/STEVfuD/fMT/HOTF7rKRVaB8uq9ELMoU0xR/FWJ9dAQ6tEPSJaPwjTH
        ZA540F/Q==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9p-004fjy-1u; Fri, 10 Feb 2023 07:49:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: fold finish_compressed_bio_write into btrfs_finish_compressed_write_work
Date:   Fri, 10 Feb 2023 08:48:41 +0100
Message-Id: <20230210074841.628201-9-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
References: <20230210074841.628201-1-hch@lst.de>
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

Fold finish_compressed_bio_write into its only caller as there is no
reason to keep them separate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0bbaccb1787080..0dff70cfd2371c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -222,8 +222,11 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 	/* the inode may be gone now */
 }
 
-static void finish_compressed_bio_write(struct compressed_bio *cb)
+static void btrfs_finish_compressed_write_work(struct work_struct *work)
 {
+	struct compressed_bio *cb =
+		container_of(work, struct compressed_bio, write_end_work);
+
 	/*
 	 * Ok, we're the last bio for this extent, step one is to call back
 	 * into the FS and do all the end_io operations.
@@ -240,14 +243,6 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
 	bio_put(&cb->bbio.bio);
 }
 
-static void btrfs_finish_compressed_write_work(struct work_struct *work)
-{
-	struct compressed_bio *cb =
-		container_of(work, struct compressed_bio, write_end_work);
-
-	finish_compressed_bio_write(cb);
-}
-
 /*
  * Do the cleanup once all the compressed pages hit the disk.  This will clear
  * writeback on the file pages and free the compressed pages.
-- 
2.39.1

