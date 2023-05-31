Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E31717687
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjEaGFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaGFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284811C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9gPQE0Quw3lg7jqB4gDKLPCUrdRVRQcbxnWJyG7Lt+s=; b=cY1F+urRXgMzYScnS28SHPo+Sh
        kISTQndJc2DWrPPki8xBz4P3OfDFRI57tKG0dQryyQHxv1AWt5Y3XgPb3bB4BBEBp9YEUnvpUaeE2
        4RVqf2zJXwE/dlqshZ3ct9+kR/T7CI+qcOkM2Dlz2cjhIDdnSL5vM+p5axOLYoCSV81RjZnYmt3fP
        OCJEvP/BQw1zAREFgPFcnwzisRxf6BC1IC64AyZ6JOX6Esm5+HYuX8WrK1Li21VE0jRODomdIB7B2
        J0eGjd1RN2qwih9adLhQyMGsbcK89bL6MWW2x8bVfNrHnkShN5HPCpMyjp1cxqrwS64glvHx7K4b3
        cofJTZSg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ExM-00GF2Q-1K;
        Wed, 31 May 2023 06:05:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs: fix range_end calculation in extent_write_locked_range
Date:   Wed, 31 May 2023 08:04:50 +0200
Message-Id: <20230531060505.468704-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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

The range_end field in struct writeback_control is inclusive, just like
the end parameter passed to extent_write_locked_range.  Not doing this
could cause extra writeout, which is harmless but suboptimal.

Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and reads")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d5b3b15f7ab222..0726c82db309a2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2310,7 +2310,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	struct writeback_control wbc_writepages = {
 		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
-		.range_end	= end + 1,
+		.range_end	= end,
 		.no_cgroup_owner = 1,
 	};
 	struct btrfs_bio_ctrl bio_ctrl = {
-- 
2.39.2

