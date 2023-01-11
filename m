Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278AF665483
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjAKGYS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjAKGYK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:24:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902A10FD2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=58TmHCn1MtL/0JpAhI+6to0aVthdxMZrpfGFShN7iQE=; b=Td8n/DwlOEpSm4ydkNNCcKOy3Q
        rdVj0Zx0/opmy++3qHHHfrso7izxBErncDoYUQ2HfG+y2EzqEOC9kKuIwK793IE7QIQEmf3B2HhVt
        oNt1LKWDkIJJBHhsdsN1CwEhgnhp7nt/dxd+5Ats/t/voCaEgmEz1U3EdbDbjDjUZDRHUF3S/2/ST
        nMxWO6L0FHreqMDnj5/zFVGM0Y/5bTS0fG05tQTLgCuccPvHYsJA3kZPRhm3PguQ2HVcjD1uYM2vn
        7kkd+q0kmypPz5H8yrDPbD9kdSrK985ftiGFq2060FcacNrbpC3c4gt3fAvV0JOl3qvXY76PwjAKX
        uY9Xr1/Q==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWo-009rD0-Jj; Wed, 11 Jan 2023 06:24:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: call rbio_orig_end_io from scrub_rbio
Date:   Wed, 11 Jan 2023 07:23:34 +0100
Message-Id: <20230111062335.1023353-11-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
References: <20230111062335.1023353-1-hch@lst.de>
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

The only caller of scrub_rbio calls rbio_orig_end_io right after it,
move it into scrub_rbio to match the other work item helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c007992bf4426c..d8dd25a8155a52 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2695,7 +2695,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 	return 0;
 }
 
-static int scrub_rbio(struct btrfs_raid_bio *rbio)
+static void scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	bool need_check = false;
 	int sector_nr;
@@ -2703,18 +2703,18 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 
 	ret = alloc_rbio_essential_pages(rbio);
 	if (ret)
-		return ret;
+		goto out;
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	ret = scrub_assemble_read_bios(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* We may have some failures, recover the failed sectors first. */
 	ret = recover_scrub_rbio(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * We have every sector properly prepared. Can finish the scrub
@@ -2731,17 +2731,13 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 			break;
 		}
 	}
-	return ret;
+out:
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
 static void scrub_rbio_work_locked(struct work_struct *work)
 {
-	struct btrfs_raid_bio *rbio;
-	int ret;
-
-	rbio = container_of(work, struct btrfs_raid_bio, work);
-	ret = scrub_rbio(rbio);
-	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	scrub_rbio(container_of(work, struct btrfs_raid_bio, work));
 }
 
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
-- 
2.35.1

