Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06696614853
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiKALQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKALQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8236186C9
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAB1133956
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+M+CpDTDR88Wlq4dSEH2rXxtlehzWDLLK9PssHV77I=;
        b=T5PksB/O1HtlNQAXoxSMT3HhYyjnZFpAVfygiQd2YNnAshtANX1uIYe82tDDvaUoiPDonf
        zDNKrnnGv+HAsj9EVjGYDagRW1UOw0qEmQLrZsNZBirUChqqlVqR8cv1uUngObjpaTi6pW
        eZi6lDXVGXeV08835AvIFunlUgpANZo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FF0B1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sOzZOAAAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/12] btrfs: raid56: extract the recovery bio list build code into a helper
Date:   Tue,  1 Nov 2022 19:16:03 +0800
Message-Id: <936b87aa10c06d4dedac1a455cb90930e29f01e7.1667300355.git.wqu@suse.com>
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

This new helper will be also utilized in the incoming refactor of
recovery path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 64 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index fe525fe9338f..e3c172ba3c80 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2134,30 +2134,14 @@ static void raid_recover_end_io_work(struct work_struct *work)
 		__raid_recover_end_io(rbio);
 }
 
-/*
- * reads everything we need off the disk to reconstruct
- * the parity. endio handlers trigger final reconstruction
- * when the IO is done.
- *
- * This is used both for reads from the higher layers and for
- * parity construction required to finish a rmw cycle.
- */
-static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
+static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
+				      struct bio_list *bio_list)
 {
-	int bios_to_read = 0;
-	struct bio_list bio_list;
-	int ret;
-	int total_sector_nr;
 	struct bio *bio;
+	int total_sector_nr;
+	int ret = 0;
 
-	bio_list_init(&bio_list);
-
-	ret = alloc_rbio_pages(rbio);
-	if (ret)
-		goto cleanup;
-
-	atomic_set(&rbio->error, 0);
-
+	ASSERT(bio_list_size(bio_list) == 0);
 	/*
 	 * Read everything that hasn't failed. However this time we will
 	 * not trust any cached sector.
@@ -2180,11 +2164,45 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
 					 sectornr, REQ_OP_READ);
 		if (ret < 0)
-			goto cleanup;
+			goto error;
 	}
+	return 0;
+error:
+	while ((bio = bio_list_pop(bio_list)))
+		bio_put(bio);
+
+	return -EIO;
+}
+
+/*
+ * reads everything we need off the disk to reconstruct
+ * the parity. endio handlers trigger final reconstruction
+ * when the IO is done.
+ *
+ * This is used both for reads from the higher layers and for
+ * parity construction required to finish a rmw cycle.
+ */
+static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
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
+	atomic_set(&rbio->error, 0);
+
+	ret = recover_assemble_read_bios(rbio, &bio_list);
+	if (ret < 0)
+		goto cleanup;
 
 	bios_to_read = bio_list_size(&bio_list);
 	if (!bios_to_read) {
-- 
2.38.1

