Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335187ACF00
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 06:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjIYEFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIYEFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 00:05:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A3DF
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 21:05:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6C082184F
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 04:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695614711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1xYV9VWWwk2gHqMQgRnHqXTX2nAucL1uU2Dk6aT+i3w=;
        b=NZxl6mBb/PsPDLUc6wEGLMdAE0zWal+zsEQRbr8bh2CqlHrc4Aeqgyz/6BRu2b9oIpvlaf
        s47/Km3F6c7IgniFMnqllH8LHgZlENcrVKRPMjBTzLmjlMJgS2Dht7VqeiP+4Pd+Sl1r8n
        OiD/iQ/pCm6Z7jFkXyGRtjtbQdg987g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 060C21391E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 04:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jLJDDfYGEWWhXQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 04:05:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: save the physical address for append writes before updating bi_status
Date:   Mon, 25 Sep 2023 13:35:07 +0930
Message-ID: <1fdf92c9de7d496e7591e67624def3dfdbbe577e.1695614683.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a possible bug in side btrfs_orig_wrte_end_io(), that if the
last mirror itself failed to do the APPEND write, but other mirrors
succeeded.

In that case, we know the write itself still succeeded, thus we reset
bio->bi_status to BLK_STS_OK.

But the next step, which would record the physical address, is dependent
on the newly updated bio->bi_status (BLK_STS_OK).

This means even the last mirror write failed, we still update the
physical address for that stripe.

Unfortunately I don't have any better solution for now but only move the
"stripe->physical" assignment before the bi_status update.

The proper fix needs some work from RST/zoned mode to handle such cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4f3b693a16b1..42f1f87f1872 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -407,6 +407,10 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 		btrfs_log_dev_io_error(bio, stripe->dev);
 	}
 
+	/* TODO: Add proper error handling for a single failed mirror case. */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
+		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
 	/*
 	 * Only send an error to the higher layers if it is beyond the tolerance
 	 * threshold.
@@ -416,9 +420,6 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	else
 		bio->bi_status = BLK_STS_OK;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND && !bio->bi_status)
-		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-
 	btrfs_orig_bbio_end_io(bbio);
 	btrfs_put_bioc(bioc);
 }
-- 
2.42.0

