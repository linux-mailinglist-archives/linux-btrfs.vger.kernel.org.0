Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262064B154
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLMIlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiLMIlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E0192AD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6AaDY8QEygCjKNZ0EMMPqlr8XxqCl9Z9lZozyTTGgBY=; b=ssCN0WX/141jq4Vc9V0Oz+OKp+
        aWW5AKpwyekrUOctznwITjPLNFlRpADmZfx045vdUsFfCsHkAjj9eu78GCGZWB0wxaIsNm9K5CwJ1
        Z/nK/g1948eEYvxVnJmfTpvDuDXQw2F5Q4nW5TWFxJ+nhI0r8gYU1kxK2QfXXrsLFzz8x9uD9r8gw
        DQQ+TvqvuRsgOMJ8YmMNn1+IaP1hFq8+JYpYrh9S9nwcDJ1Qh1cxPQhcncGhBGxd7oq7fux4731j5
        CcVdh9xQQKXavMbzGQjA6rIr4PpcsZcw9Iozy/QTjab5vF5dfhqUnDzShgqDigTn5YzTR+93HlFMr
        YuVOFpSA==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50rE-00E118-1r; Tue, 13 Dec 2022 08:41:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: call rbio_orig_end_io from scrub_rbio
Date:   Tue, 13 Dec 2022 09:41:23 +0100
Message-Id: <20221213084123.309790-9-hch@lst.de>
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

The only caller of scrub_rbio calls rbio_orig_end_io right after it,
move it into scrub_rbio to match the other work item helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b2e02f02294163..4f2d63bfddae3c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2732,7 +2732,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	return ret;
 }
 
-static int scrub_rbio(struct btrfs_raid_bio *rbio)
+static void scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list = BIO_EMPTY_LIST;
 	bool need_check = false;
@@ -2742,13 +2742,13 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 
 	ret = alloc_rbio_essential_pages(rbio);
 	if (ret)
-		return ret;
+		goto out;
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	ret = scrub_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
@@ -2758,7 +2758,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	if (ret < 0) {
 		while ((bio = bio_list_pop(&bio_list)))
 			bio_put(bio);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -2776,17 +2776,13 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
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

