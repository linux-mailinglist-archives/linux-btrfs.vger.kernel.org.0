Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4270D6F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbjEWIPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjEWIPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F19129
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C4yUvFKlHSZ5zA3mUqo6HhAQKxoRImKgFZxgmYeGMCg=; b=39UYIIRl4aOmCUPGq5XcnqBAk/
        SolilyQNlvyTGgJWcIuC1jsL4cYUE+iQL6T+0x3X4C0YTS3lp2YBylAK9EEeFBB/qgrzg2Lm+OUMY
        ZsMOysIjSJutSvN3HWQ2IGOddhytLDmlaFmXpuhjyofRFggcDOe7fEyCHcTlaZwnzzgMCKsI1XTjB
        ah4HgBs6SaTYco9xIIje8ygfVCZl6tZkgpRJtq2NTzVD/5iURlC5dj/KnqhKL7dWVyqnrTVrY8xaW
        kltAg+6MEsJJgjmJHKtpeDJAkqwUMPDmCWqBVUgphsDgtC6vp1zinjgDWsxAj+PgLCq7EG7VWbsUN
        w9qt1RXQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N95-009OSq-0E;
        Tue, 23 May 2023 08:13:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs: fix range_end calculation in extent_write_locked_range
Date:   Tue, 23 May 2023 10:13:07 +0200
Message-Id: <20230523081322.331337-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
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
the end parameter passed to extent_write_locked_range.

Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and reads")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5999ac3ee601db..c1b0ca94be34e1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2309,7 +2309,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
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

