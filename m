Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1889665482
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjAKGYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjAKGX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:23:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B81116F
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=movQ0H4vgF8A+YM2ZQNpXSXAUus2/vLUAWgwwjm4sns=; b=Cf+fXO43681OjTfwufyU1qA9ZV
        YZPL37F2jmApKrIHghIZx/TEyL3XG9tYF06qspQIGim/5NUfwyJd6mL39vlUybEjf5MqHx2kizpIC
        5hPberaTCeBzqlmKA7QHD+lCQYpet+sLp6p4cpnRxvZkusP/L/7Wnv/E/DjTVTBin1e7LkHh7jf2j
        4Tbd9ioq+grNSngiTzR9MyaMo/dz+fVqEM122jrtsHmnW02Z84MO+dkeIdTa47J4cor/lwu5Avpnc
        dx9Z4tHd3lWq8Cn6QOaUfrlETaPw9SxkkqoDHGD8JG6KY2Nfb8I16gmkKw2dWu1hjNdR/a3kNAaaK
        IGw02wPg==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWZ-009rB8-Ah; Wed, 11 Jan 2023 06:23:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: add a bio_list_put helper
Date:   Wed, 11 Jan 2023 07:23:28 +0100
Message-Id: <20230111062335.1023353-5-hch@lst.de>
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

Add a helper to put all bios in a list.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e3fef81a4d96d3..666d634f0ba2c1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1183,6 +1183,14 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
 	trace_info->stripe_nr = -1;
 }
 
+static inline void bio_list_put(struct bio_list *bio_list)
+{
+	struct bio *bio;
+
+	while ((bio = bio_list_pop(bio_list)))
+		bio_put(bio);
+}
+
 /* Generate PQ for one veritical stripe. */
 static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 {
@@ -1228,7 +1236,6 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 				   struct bio_list *bio_list)
 {
-	struct bio *bio;
 	/* The total sector number inside the full stripe. */
 	int total_sector_nr;
 	int sectornr;
@@ -1317,8 +1324,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 
 	return 0;
 error:
-	while ((bio = bio_list_pop(bio_list)))
-		bio_put(bio);
+	bio_list_put(bio_list);
 	return -EIO;
 }
 
@@ -1514,7 +1520,6 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
 static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				  struct bio_list *bio_list)
 {
-	struct bio *bio;
 	int total_sector_nr;
 	int ret = 0;
 
@@ -1541,8 +1546,7 @@ static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	return 0;
 
 cleanup:
-	while ((bio = bio_list_pop(bio_list)))
-		bio_put(bio);
+	bio_list_put(bio_list);
 	return ret;
 }
 
@@ -1939,7 +1943,6 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				      struct bio_list *bio_list)
 {
-	struct bio *bio;
 	int total_sector_nr;
 	int ret = 0;
 
@@ -1981,16 +1984,13 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	}
 	return 0;
 error:
-	while ((bio = bio_list_pop(bio_list)))
-		bio_put(bio);
-
+	bio_list_put(bio_list);
 	return -EIO;
 }
 
 static int recover_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
-	struct bio *bio;
 	int ret;
 
 	/*
@@ -2016,9 +2016,7 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	ret = recover_sectors(rbio);
 
 out:
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
+	bio_list_put(&bio_list);
 	return ret;
 }
 
@@ -2191,7 +2189,6 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
-	struct bio *bio;
 	int ret;
 
 	bio_list_init(&bio_list);
@@ -2216,9 +2213,7 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	ret = recover_sectors(rbio);
 	return ret;
 out:
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
+	bio_list_put(&bio_list);
 	return ret;
 }
 
@@ -2489,7 +2484,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 	struct sector_ptr p_sector = { 0 };
 	struct sector_ptr q_sector = { 0 };
 	struct bio_list bio_list;
-	struct bio *bio;
 	int is_replace = 0;
 	int ret;
 
@@ -2620,8 +2614,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 	return 0;
 
 cleanup:
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
+	bio_list_put(&bio_list);
 	return ret;
 }
 
@@ -2719,7 +2712,6 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				    struct bio_list *bio_list)
 {
-	struct bio *bio;
 	int total_sector_nr;
 	int ret = 0;
 
@@ -2760,8 +2752,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	}
 	return 0;
 error:
-	while ((bio = bio_list_pop(bio_list)))
-		bio_put(bio);
+	bio_list_put(bio_list);
 	return ret;
 }
 
@@ -2771,7 +2762,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	struct bio_list bio_list;
 	int sector_nr;
 	int ret;
-	struct bio *bio;
 
 	bio_list_init(&bio_list);
 
@@ -2810,9 +2800,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	return ret;
 
 cleanup:
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
+	bio_list_put(&bio_list);
 	return ret;
 }
 
-- 
2.35.1

