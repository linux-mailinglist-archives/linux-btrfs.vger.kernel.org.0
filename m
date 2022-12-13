Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6B64B151
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiLMIlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiLMIln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A89192A8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Vunsn7qyb1C5Yo4wE50cnrzj5YJm9AmqETJgFKb1D9w=; b=IpFnV8abCd90GX9YzGhvrMCe66
        JwcwxzC/e2gbqyAkem/hkHD0AFqNOaNVlVTkxTiYdXhnZGuTM5ay4IBAa0nYovxKFi4ZjIc3RZBwk
        dbHLF99VSMOAV257sFXA8K26VbsnxyqZmoa/JtocWC/RRPM//KcBK9j21ovz14bTMjVNuVUcordJU
        xAH5Sg0AENfK0vJDSST9K3FB1pKIBd2j/1/qHIrDoBfo0sBhINmx8fxlMykOQufn4hcs3Q3d93RUZ
        NeCwF8Ovm9qy9ktPFPBbCE0jRyfgJivOUllaubqOycKlZKb9pmDtWz9ounqrBWLBRaimGFVmdlKmA
        IgLoGx9Q==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50r6-00E0tv-0F; Tue, 13 Dec 2022 08:41:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: cleanup scrub_rbio
Date:   Tue, 13 Dec 2022 09:41:20 +0100
Message-Id: <20221213084123.309790-6-hch@lst.de>
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

The bio_list is only filled by scrub_assemble_read_bios when
successful, so don't try to walk it and put the bios on any
failure before the successful call to recover_assemble_read_bios.
Also initialize bio_list at initialization time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5dab0685e17dd5..2a5857d42fff20 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2754,31 +2754,32 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
 
 static int scrub_rbio(struct btrfs_raid_bio *rbio)
 {
+	struct bio_list bio_list = BIO_EMPTY_LIST;
 	bool need_check = false;
-	struct bio_list bio_list;
 	int sector_nr;
 	int ret;
 	struct bio *bio;
 
-	bio_list_init(&bio_list);
-
 	ret = alloc_rbio_essential_pages(rbio);
 	if (ret)
-		goto cleanup;
+		return ret;
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	ret = scrub_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
-		goto cleanup;
+		return ret;
 
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
 	/* We may have some failures, recover the failed sectors first. */
 	ret = recover_scrub_rbio(rbio);
-	if (ret < 0)
-		goto cleanup;
+	if (ret < 0) {
+		while ((bio = bio_list_pop(&bio_list)))
+			bio_put(bio);
+		return ret;
+	}
 
 	/*
 	 * We have every sector properly prepared. Can finish the scrub
@@ -2796,12 +2797,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 		}
 	}
 	return ret;
-
-cleanup:
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
-	return ret;
 }
 
 static void scrub_rbio_work_locked(struct work_struct *work)
-- 
2.35.1

