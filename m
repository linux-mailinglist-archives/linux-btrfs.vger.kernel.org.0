Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F176A614859
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKALQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKALQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70518E31
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC2251F90F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0u0mMxl8UTn3dqvKhJlSQas2a6my9dqIcgLJE+lQhWA=;
        b=ro7LK5HV9V0ppRLZW2rvX+hLc81o/3EZxeBOO//VjtGCL61Zbkg6sa3exoXQD+VsWEs4bG
        UtwtX9JbQu5prE1tNsXgDXjFWtlRBtEtHEfFTt87RMIXTkTwkdcKlonZVPup0jk3jG8eZ3
        hhIJa/gI4lLfDujSj8iSeVAtSvt88q0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6303D1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIR6DQcAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/12] btrfs: raid56: extract scrub read bio list assembly code into a helper
Date:   Tue,  1 Nov 2022 19:16:10 +0800
Message-Id: <3494e916977652078d5e6c1f06088b8f1b05936f.1667300355.git.wqu@suse.com>
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

Just like what we did for write/recovery, also extract the read bio
assembly code into a helper for scrub.

The difference between the three are:

- rmw_assemble_read_bios() only submit reads for missing sectors
  Thus it will skip cached sectors, but will also read sectors which
  is not covered by any full stripe. (For cache usage)

- recover_assemble_read_bios() reads every sector which has not failed

- scrub_assemble_read_bios() has extra check for vertical stripes
  It's mostly the same as rmw_assemble_read_bios(), but will skip
  sectors which is not covered by a vertical stripe.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 94df689713ea..4a82bffbcb4b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2708,21 +2708,15 @@ static void raid56_parity_scrub_end_io_work(struct work_struct *work)
 	validate_rbio_for_parity_scrub(rbio);
 }
 
-static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
+static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
+				    struct bio_list *bio_list)
 {
-	int bios_to_read = 0;
-	struct bio_list bio_list;
-	int ret;
-	int total_sector_nr;
 	struct bio *bio;
+	int total_sector_nr;
+	int ret = 0;
 
-	bio_list_init(&bio_list);
+	ASSERT(bio_list_size(bio_list) == 0);
 
-	ret = alloc_rbio_essential_pages(rbio);
-	if (ret)
-		goto cleanup;
-
-	atomic_set(&rbio->error, 0);
 	/* Build a list of bios to read all the missing parts. */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
@@ -2751,11 +2745,35 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 		if (sector->uptodate)
 			continue;
 
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
 					 sectornr, REQ_OP_READ);
 		if (ret)
-			goto cleanup;
+			goto error;
 	}
+	return 0;
+error:
+	while ((bio = bio_list_pop(bio_list)))
+		bio_put(bio);
+	return ret;
+}
+
+static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
+{
+	int bios_to_read = 0;
+	struct bio_list bio_list;
+	int ret;
+	struct bio *bio;
+
+	bio_list_init(&bio_list);
+
+	ret = alloc_rbio_essential_pages(rbio);
+	if (ret)
+		goto cleanup;
+
+	atomic_set(&rbio->error, 0);
+	ret = scrub_assemble_read_bios(rbio, &bio_list);
+	if (ret < 0)
+		goto cleanup;
 
 	bios_to_read = bio_list_size(&bio_list);
 	if (!bios_to_read) {
-- 
2.38.1

