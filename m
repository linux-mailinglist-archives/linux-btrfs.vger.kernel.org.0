Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01442717502
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjEaERw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjEaERu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:17:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B744B10B
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Gu5toxxERMUi5VibRHIhIdhpwg05xSoXqg3wY0BQ1rI=; b=epM4ArWlRLyDLuHVsBVMPG/fgb
        2gGpPzcmlHf3IabdQtDlK2+Q6YvoPOt5k7K5tOCPfDaZH+a2dhTsnqS7U/ejebw+Jky56AZtvfe8/
        tbYbq8VfyRy9ZtZjJTR7sQLX0dSkEFWTUGbGxHplujI6LBCxAni2L/8k+Easvx/ksis2+u5vP8ZLz
        8zNckhedq/SIYrXyGhQHM+ha6F7o6AMAsgQzDplBkJAVsRMH0tAhl0uuNeoXUB+lMWgwnHES9n6hJ
        O3+YCRWb+wmcMS/ywUMntCsI+UEICyce2ou6u0PvAuwuwRKJx76cEScp8K/T22tY+J3XSnEF5aAMn
        omXuxWog==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DHP-00G1P5-1s;
        Wed, 31 May 2023 04:17:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: optimize simple reads in btrfsic_map_block
Date:   Wed, 31 May 2023 06:17:35 +0200
Message-Id: <20230531041740.375963-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
References: <20230531041740.375963-1-hch@lst.de>
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

Pass a smap into __btrfs_map_block so that the usual case of a read that
doesn't require parity raid recovery doesn't need an extra memory
allocation for the btrfs_io_context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/check-integrity.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index b4408037b823c5..fe15367000141a 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1459,13 +1459,13 @@ static int btrfsic_map_block(struct btrfsic_state *state, u64 bytenr, u32 len,
 	struct btrfs_fs_info *fs_info = state->fs_info;
 	int ret;
 	u64 length;
-	struct btrfs_io_context *multi = NULL;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_io_stripe smap, *map;
 	struct btrfs_device *device;
 
 	length = len;
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ,
-			      bytenr, &length, &multi, mirror_num);
-
+	ret = __btrfs_map_block(fs_info, BTRFS_MAP_READ, bytenr, &length, &bioc,
+				NULL, &mirror_num, 0);
 	if (ret) {
 		block_ctx_out->start = 0;
 		block_ctx_out->dev_bytenr = 0;
@@ -1478,21 +1478,26 @@ static int btrfsic_map_block(struct btrfsic_state *state, u64 bytenr, u32 len,
 		return ret;
 	}
 
-	device = multi->stripes[0].dev;
+	if (bioc)
+		map = &bioc->stripes[0];
+	else
+		map = &smap;
+
+	device = map->dev;
 	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state) ||
 	    !device->bdev || !device->name)
 		block_ctx_out->dev = NULL;
 	else
 		block_ctx_out->dev = btrfsic_dev_state_lookup(
 							device->bdev->bd_dev);
-	block_ctx_out->dev_bytenr = multi->stripes[0].physical;
+	block_ctx_out->dev_bytenr = map->physical;
 	block_ctx_out->start = bytenr;
 	block_ctx_out->len = len;
 	block_ctx_out->datav = NULL;
 	block_ctx_out->pagev = NULL;
 	block_ctx_out->mem_to_free = NULL;
 
-	kfree(multi);
+	kfree(bioc);
 	if (NULL == block_ctx_out->dev) {
 		ret = -ENXIO;
 		pr_info("btrfsic: error, cannot lookup dev (#1)!\n");
-- 
2.39.2

