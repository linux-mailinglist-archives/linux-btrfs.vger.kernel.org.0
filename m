Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF894F8DD9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiDHFLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiDHFK7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:10:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C327F1AFF
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sxlxcxGMpTSrbbfDld/rbv+KdjNK2J9FcKDo6c3ZEyA=; b=YOmWmgXKJdHnME2Mt4NKIT/8vO
        NqVklGEqAY2E2blwN0+U4JVIiWj2iuE2qpss0hTui+r1eH861ocOJ7mSUXeEgHBVft2pSBazizckp
        wrczkm5K27BM2TgmqCTEeebIGBik0GcbaxSLqyLlnD8rjkkJLVZtct8e3PNz66GgU6pFtzbSGcoC/
        Q+nZBD2JdOyDm7c98UG+n7gpDgtw9LAZxKbgrzsz86Ln9vsP8OEKBiTP5LVg9tN9BNNF5yANPu/EV
        +e2qkMTwtmexTD8mHNzd7LLEVuRBfUWrNJ9Jy/CnmMDhi4qM3rbSpGaOe+uLflxh0NPrbA0Bi1KWS
        kXxbb5RQ==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgrc-00F143-SK; Fri, 08 Apr 2022 05:08:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/12] btrfs: simplify btrfsic_read_block
Date:   Fri,  8 Apr 2022 07:08:30 +0200
Message-Id: <20220408050839.239113-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
References: <20220408050839.239113-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfsic_read_block does not need the btrfs_bio structure, so switch to
plain bio_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/check-integrity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 9efd33b4e24d7..864a90e825050 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1561,10 +1561,9 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		struct bio *bio;
 		unsigned int j;
 
-		bio = btrfs_bio_alloc(num_pages - i);
-		bio_set_dev(bio, block_ctx->dev->bdev);
+		bio = bio_alloc(block_ctx->dev->bdev, num_pages - i,
+				REQ_OP_READ, GFP_NOFS);
 		bio->bi_iter.bi_sector = dev_bytenr >> 9;
-		bio->bi_opf = REQ_OP_READ;
 
 		for (j = i; j < num_pages; j++) {
 			ret = bio_add_page(bio, block_ctx->pagev[j],
-- 
2.30.2

