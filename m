Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094E70F9A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbjEXPDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjEXPDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CE1A6
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UMyE1bk35BydsclRtPx2FFQO7xoXpaKy5j1gRizYx2Q=; b=Bzp2WbVsinAItGHOpD8ZFiVoP+
        +kJXII/l6tZX280CLL/Q6SIVplt1Ygk4aiIwSPi0dxVTwFLN/IDnLbGqiq22XW/9m0MfqOCy1GuWq
        Axoy4VgmvjhGFWTcegIz3Nhd4icdQd5NpAC9rFIzXvgUx/j2oLul9pwuiTGpOZiUQ+2iUfr/NUcTj
        nQsimxhde0cP02gW44Esps/TWo7YVY55xiG8VX4XaNHbDg6s58ZSGtbLhYVQC5wCGWUr5qwEgBrqM
        FXeLshfvtUtdDadEViMBzjdI/PrI78BfuUK8/PcSQGXccpKwCgLJTyDOb3NuNJwY8JQYY4kYdyhqi
        MMBGWp1g==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1P-00DmaM-1p;
        Wed, 24 May 2023 15:03:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 02/14] btrfs: don't call btrfs_record_physical_zoned for failed append
Date:   Wed, 24 May 2023 17:03:05 +0200
Message-Id: <20230524150317.1767981-3-hch@lst.de>
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

When a zoned append command fails there is no written address reported,
so don't try to record it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4ecc5f31c0190e..5fad6e032e6c76 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -348,7 +348,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
 		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
 	} else {
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
 			btrfs_record_physical_zoned(bbio);
 		btrfs_orig_bbio_end_io(bbio);
 	}
-- 
2.39.2

