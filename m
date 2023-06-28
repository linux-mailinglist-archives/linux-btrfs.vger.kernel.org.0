Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5B740B39
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjF1IYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjF1ITt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 04:19:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFBC49E6
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 01:11:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1624D1F8BF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687939894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sL8OYiOPL9gFF4jFQ9jOrLUnubdupvE/zVUQxfnstlc=;
        b=RP7wNdy2viBGf+VJ30mjZwFzsi5Pq+w1V7+vrFDAtaTQr46XmacOpPe4N6WtNU79MtYFW4
        fwy3ov/frl7CHmVkupzZfM1jiHadDXVZ35PmuKc/KnDmO7solP4s4rBrd+Cc63yRXD1/xa
        /stcPbkAsgfrm92n5ity2PFjTWE4q7E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5899F138EF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 08:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BoRSBjXrm2RbUAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 08:11:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: raid56: remove unused BTRFS_RBIO_PARITY_SCRUB
Date:   Wed, 28 Jun 2023 16:11:15 +0800
Message-ID: <65b7602d5baadf1b7102072abc98515322c67892.1687939844.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit aca43fe839e4 ("btrfs: remove unused raid56 functions which were
dedicated for scrub") removed the special handling of RAID56 scrub for
missing device.

As scrub goes full mirror_num based recovery, that means if it hits a
missing device in RAID56, it would just try the next mirror, which would
go through the BTRFS_RBIO_READ_REBUILD operation.

This means there is no longer any use of BTRFS_RBIO_PARITY_SCRUB
operation and we can safely remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 17 +++++------------
 fs/btrfs/raid56.h |  1 -
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f37b925d587f..cf2c74ce76a9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -584,8 +584,7 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	if (last->operation == BTRFS_RBIO_PARITY_SCRUB)
 		return 0;
 
-	if (last->operation == BTRFS_RBIO_REBUILD_MISSING ||
-	    last->operation == BTRFS_RBIO_READ_REBUILD)
+	if (last->operation == BTRFS_RBIO_READ_REBUILD)
 		return 0;
 
 	return 1;
@@ -784,10 +783,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 			spin_unlock(&rbio->bio_list_lock);
 			spin_unlock(&h->lock);
 
-			if (next->operation == BTRFS_RBIO_READ_REBUILD)
-				start_async_work(next, recover_rbio_work_locked);
-			else if (next->operation == BTRFS_RBIO_REBUILD_MISSING) {
-				steal_rbio(rbio, next);
+			if (next->operation == BTRFS_RBIO_READ_REBUILD) {
 				start_async_work(next, recover_rbio_work_locked);
 			} else if (next->operation == BTRFS_RBIO_WRITE) {
 				steal_rbio(rbio, next);
@@ -1698,8 +1694,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	 * If we're rebuilding a read, we have to use pages from the
 	 * bio list if possible.
 	 */
-	if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-	     rbio->operation == BTRFS_RBIO_REBUILD_MISSING)) {
+	if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
 		sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
 	} else {
 		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
@@ -1763,8 +1758,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		 * If we're rebuilding a read, we have to use pages from the
 		 * bio list if possible.
 		 */
-		if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-		     rbio->operation == BTRFS_RBIO_REBUILD_MISSING)) {
+		if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
 			sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
 		} else {
 			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
@@ -1897,8 +1891,7 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 		goto out;
 	}
 
-	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
+	if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
 		spin_lock(&rbio->bio_list_lock);
 		set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
 		spin_unlock(&rbio->bio_list_lock);
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 0e84c9c9293f..45e6ff78316f 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -14,7 +14,6 @@ enum btrfs_rbio_ops {
 	BTRFS_RBIO_WRITE,
 	BTRFS_RBIO_READ_REBUILD,
 	BTRFS_RBIO_PARITY_SCRUB,
-	BTRFS_RBIO_REBUILD_MISSING,
 };
 
 struct btrfs_raid_bio {
-- 
2.41.0

