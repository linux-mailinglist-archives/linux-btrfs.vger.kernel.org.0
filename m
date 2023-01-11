Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8716E66547E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAKGYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjAKGYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:24:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9F1180F
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kuc6OC5ZM76eefZLhjj3RV5H4WO5wDU+QysOJl/RthI=; b=P8NkL6Ni3w7k6sBxEPf9p1f/ZN
        kdelGFkLn9cLZckVvqrODn3ISpVheSB8bF6l/akjQuw62ffKIkV3LCPt3FMKCP5quRCObsnmLalV3
        c6rmPzTyvCdGqaj8Uc4jjzJnZOGRn/imweCFdyHb+9xHXuN2WgK3g2eXwI1L8Oz0+fcR0KXnl8F4B
        aDAfxIp2kVesSKaBK8tDlBaFlNnp6FN38cRjAFFg0LCZRjss8F8EbKo7TykvP5bfgVu46KkZnSXHf
        3Xv5KHReSD57LMKFKoXxR1u/iTa6kFALP2GNlyGJKqMZECFcD4brr1t4sADci17tbWrakGKzhYAqs
        554gO17w==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWg-009rBy-Vw; Wed, 11 Jan 2023 06:23:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: submit the read bios from scrub_assemble_read_bios
Date:   Wed, 11 Jan 2023 07:23:31 +0100
Message-Id: <20230111062335.1023353-8-hch@lst.de>
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

Instead of filling in a bio_list and submitting the bios in the only
caller, do that in scrub_assemble_read_bios.  This removes the
need to pass the bio_list, and also makes it clear that the extra
bio_list cleanup in the caller is entirely pointless.  Rename the
function to scrub_read_bios to make it clear that the bios are not
only assembled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 88404a6b0b98e7..374c3873169b3f 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2668,14 +2668,12 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
-static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
-				    struct bio_list *bio_list)
+static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 {
+	struct bio_list bio_list = BIO_EMPTY_LIST;
 	int total_sector_nr;
 	int ret = 0;
 
-	ASSERT(bio_list_size(bio_list) == 0);
-
 	/* Build a list of bios to read all the missing parts. */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
@@ -2704,42 +2702,38 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
 		if (sector->uptodate)
 			continue;
 
-		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
 					 sectornr, REQ_OP_READ);
-		if (ret)
-			goto error;
+		if (ret) {
+			bio_list_put(&bio_list);
+			return ret;
+		}
 	}
+
+	submit_read_wait_bio_list(rbio, &bio_list);
 	return 0;
-error:
-	bio_list_put(bio_list);
-	return ret;
 }
 
 static int scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	bool need_check = false;
-	struct bio_list bio_list;
 	int sector_nr;
 	int ret;
 
-	bio_list_init(&bio_list);
-
 	ret = alloc_rbio_essential_pages(rbio);
 	if (ret)
-		goto cleanup;
+		return ret;
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
-	ret = scrub_assemble_read_bios(rbio, &bio_list);
+	ret = scrub_assemble_read_bios(rbio);
 	if (ret < 0)
-		goto cleanup;
-
-	submit_read_wait_bio_list(rbio, &bio_list);
+		return ret;
 
 	/* We may have some failures, recover the failed sectors first. */
 	ret = recover_scrub_rbio(rbio);
 	if (ret < 0)
-		goto cleanup;
+		return ret;
 
 	/*
 	 * We have every sector properly prepared. Can finish the scrub
@@ -2757,10 +2751,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 		}
 	}
 	return ret;
-
-cleanup:
-	bio_list_put(&bio_list);
-	return ret;
 }
 
 static void scrub_rbio_work_locked(struct work_struct *work)
-- 
2.35.1

