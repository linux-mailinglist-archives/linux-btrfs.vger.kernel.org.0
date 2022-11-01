Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C01614856
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKALQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiKALQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EA225E9
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5AD091F90F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94RmREFitfhN3Smv6QbXqd3i9Dd/3tjp5cfQnUX87YE=;
        b=u8FJG1Y0W7UARvVMZtEJ6uLzD94WYgcDCJE+jzWRil1o0k6oxybOeyvpE+g/olFxorMdse
        ZU1obFwRDwpQB/CKbe7X8XzDEBYqzo79MG4vd5x7BaTramXlUYp33tmsYlKL4dS5k8Lj3P
        C2Y+lIKpnQX+4xIndCI/FZvES8OLJO4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6E2D1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YD/0JQMAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/12] btrfs: raid56: extract the rmw bio list build code into a helper
Date:   Tue,  1 Nov 2022 19:16:06 +0800
Message-Id: <505a8a6f48131485edc392e93fa6fb1889637518.1667300355.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667300355.git.wqu@suse.com>
References: <cover.1667300355.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper will later be used to refactor the whole RMW path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 56 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4bef7e32acbe..3133c9706da4 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1596,28 +1596,16 @@ static void raid56_rmw_end_io_work(struct work_struct *work)
 	validate_rbio_for_rmw(rbio);
 }
 
-/*
- * the stripe must be locked by the caller.  It will
- * unlock after all the writes are done
- */
-static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
+static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
+				  struct bio_list *bio_list)
 {
-	int bios_to_read = 0;
-	struct bio_list bio_list;
 	const int nr_data_sectors = rbio->stripe_nsectors * rbio->nr_data;
-	int ret;
-	int total_sector_nr;
 	struct bio *bio;
+	int total_sector_nr;
+	int ret = 0;
 
-	bio_list_init(&bio_list);
+	ASSERT(bio_list_size(bio_list) == 0);
 
-	ret = alloc_rbio_pages(rbio);
-	if (ret)
-		goto cleanup;
-
-	index_rbio_pages(rbio);
-
-	atomic_set(&rbio->error, 0);
 	/* Build a list of bios to read all the missing data sectors. */
 	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
 	     total_sector_nr++) {
@@ -1642,11 +1630,43 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 		if (sector->uptodate)
 			continue;
 
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+		ret = rbio_add_io_sector(rbio, bio_list, sector,
 			       stripe, sectornr, REQ_OP_READ);
 		if (ret)
 			goto cleanup;
 	}
+	return 0;
+
+cleanup:
+	while ((bio = bio_list_pop(bio_list)))
+		bio_put(bio);
+	return ret;
+}
+
+/*
+ * the stripe must be locked by the caller.  It will
+ * unlock after all the writes are done
+ */
+static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
+{
+	int bios_to_read = 0;
+	struct bio_list bio_list;
+	int ret;
+	struct bio *bio;
+
+	bio_list_init(&bio_list);
+
+	ret = alloc_rbio_pages(rbio);
+	if (ret)
+		goto cleanup;
+
+	index_rbio_pages(rbio);
+
+	atomic_set(&rbio->error, 0);
+
+	ret = rmw_assemble_read_bios(rbio, &bio_list);
+	if (ret < 0)
+		goto cleanup;
 
 	bios_to_read = bio_list_size(&bio_list);
 	if (!bios_to_read) {
-- 
2.38.1

