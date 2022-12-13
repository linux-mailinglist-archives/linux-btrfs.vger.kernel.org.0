Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83664B14F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiLMIlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiLMIli (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5661929B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a9g89CWmg9c2tt2K+qz4cHez4C9fIXxJ0TSQCEDcdQM=; b=nIaf0VTuehw3qy+H7sAkdpnbtK
        3WLI1IjOZePC/bFlIPLo9OXH5aAb4zWZWdNvA1fjUadUfmlYBcFVIiN+F4tircyJ3em1UiE0iYRes
        JDW/gsJkvuFyoDxmp0oHRe+s2Xvzrfts8lJM6ossonI4qKD7Vjwh2GW6N61HBd5If8WiCz7ommx/9
        xyMEg1NdJgB+XLU9+KOKb93+lryRjK1x6bvGOn25W3kXrSgGiV+ofhmgBsFQ5q68EtfI1bFB3edB7
        qWwXvor0wGnpL/16VG7JuqGn6LhB+6u0Xg9H0go50cEy+R8lcwq99qHdXZ936jf4xjMIHtRx93l7G
        SBXDrLLw==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50r0-00E0pQ-LG; Tue, 13 Dec 2022 08:41:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: cleanup rmw_read_wait_recover
Date:   Tue, 13 Dec 2022 09:41:18 +0100
Message-Id: <20221213084123.309790-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213084123.309790-1-hch@lst.de>
References: <20221213084123.309790-1-hch@lst.de>
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

rmw_assemble_read_bios already cleans up the bio_list on failure, so the
loop to do so in rmw_read_wait_recover will never do anything and can be
removed.  Also initialize the bio_list at initialization time, and
directly return the value from recover_sectors instead of assigning it to
ret first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5035e2b20a5e02..e0966126ab27a4 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2189,12 +2189,9 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 
 static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 {
-	struct bio_list bio_list;
-	struct bio *bio;
+	struct bio_list bio_list = BIO_EMPTY_LIST;
 	int ret;
 
-	bio_list_init(&bio_list);
-
 	/*
 	 * Fill the data csums we need for data verification.  We need to fill
 	 * the csum_bitmap/csum_buf first, as our endio function will try to
@@ -2204,7 +2201,7 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 
 	ret = rmw_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
@@ -2213,13 +2210,7 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	 * We may or may not have any corrupted sectors (including missing dev
 	 * and csum mismatch), just let recover_sectors() to handle them all.
 	 */
-	ret = recover_sectors(rbio);
-	return ret;
-out:
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
-	return ret;
+	return recover_sectors(rbio);
 }
 
 static void raid_wait_write_end_io(struct bio *bio)
-- 
2.35.1

