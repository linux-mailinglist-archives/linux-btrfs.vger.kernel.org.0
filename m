Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169962379B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 00:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKIXlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 18:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiKIXlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 18:41:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B51E2ED4A
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 15:40:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBF4733864;
        Wed,  9 Nov 2022 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668037196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cbIHHE8pnahgXSN1jYQRQqwKSrewCPRrDvygMt194fk=;
        b=Nljc8r3++6irN9jENgMAdlRcqyTriH1iKG+kocm6ggYRSumbK5JlT5A3V+u9Yq1Wj91Occ
        w7s33Ls0BrqBH0b91JfRNZdv8+59c9qQBRLB/ahMo86r4bTxmU4zFRe4euv9PACoh9akBX
        ObpFsiwVR8Cm/m3yP2/rjFi8eUuUBHg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9AEA139F1;
        Wed,  9 Nov 2022 23:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pqT8J0s6bGOhQwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 09 Nov 2022 23:39:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: [PATCH] btrfs: raid56: use atomic_dec_and_test() in end io functions
Date:   Thu, 10 Nov 2022 07:39:38 +0800
Message-Id: <20221109233938.9969-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

!!! DON'T MERGE AS IS !!!

The latest btrfs raid56 refactor is using atomic_dec() then
unconditionally call wake_up() to let the main thread to check if all
the IO is done.

But atomic_dec() itself is not fully ordered, thus it can have an
impact on the lifespan of the rbio, which causes use-after-free and
crash in the raid6 path.

Unfortunately I don't have a solid environment to reproduce the problem
(even with KASAN enabled).
My guess is, since I'm always using the latest hardware (days ago it's
R9 5900X, now it's i7 13700K) they may have something a little more
strict on the ordering.

So this patch is still just for David to verify the behavior, and if
this one really solved the problem, it's better to be folded into
"btrfs: raid56: switch recovery path to a single function" and
"btrfs: raid56: introduce the a main entrance for rmw path".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4a7932240d42..11be5d0a7eab 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1437,8 +1437,8 @@ static void raid_wait_read_end_io(struct bio *bio)
 		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
-	atomic_dec(&rbio->stripes_pending);
-	wake_up(&rbio->io_wait);
+	if (atomic_dec_and_test(&rbio->stripes_pending))
+		wake_up(&rbio->io_wait);
 }
 
 static void submit_read_bios(struct btrfs_raid_bio *rbio,
@@ -2078,8 +2078,8 @@ static void raid_wait_write_end_io(struct bio *bio)
 	if (err)
 		rbio_update_error_bitmap(rbio, bio);
 	bio_put(bio);
-	atomic_dec(&rbio->stripes_pending);
-	wake_up(&rbio->io_wait);
+	if (atomic_dec_and_test(&rbio->stripes_pending))
+		wake_up(&rbio->io_wait);
 }
 
 static void submit_write_bios(struct btrfs_raid_bio *rbio,
-- 
2.38.0

