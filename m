Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844C7ACF4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 06:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjIYE7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 00:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYE7l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 00:59:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AECE3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 21:59:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A3DA821845;
        Mon, 25 Sep 2023 04:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695617972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zLmbQtff+CGCumZvvwhqLYzeOBSxjW9WsGB5I6/g0Mo=;
        b=RrdGZHKCpWCgb94dw1gY2b06JRxy0+KpYp43S9X8dxpVh37qHdQqPfbid9pCYL7y+DggVB
        mulnGBKoiI9K/zr0Dk09meOF1eaj1968/a5ut1XuyvT7BXv/n8vcUIibIzQapvR2mPAi2+
        bhYU2+aqTZfWzoPLeCv3Ga73IJfYKpU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 988921358F;
        Mon, 25 Sep 2023 04:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7jtRFrMTEWWScQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 25 Sep 2023 04:59:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org
Subject: [PATCH] btrfs: fix a race which can lead to unreported write failure
Date:   Mon, 25 Sep 2023 14:29:28 +0930
Message-ID: <8bc4c2aaa8d32ad92838b3778a85660ba7c6bfa8.1695617943.git.wqu@suse.com>
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

[RACE]
For write back to chunks with multiple mirrors, there is a race that due
to when the bioc->error is checked, we may falsely consider a write is
successful:

               Thread A                |            Thread B
---------------------------------------+----------------------------------
 btrfs_orig_write_end_io()             | btrfs_clone_write_end_io()
 |  this bio failed                    | |  this bio failed
 |                                     | |
 |- atommic_inc(&bioc->error);         | |
 |- atomic_read(&bioc->error)          | |
 |  So far we only hit one error,      | |
 |  thus can still consider the write  | |
 |  succeeded                          | |
 `- bio->bi_status = BLK_STS_OK;       | |
                                       | `- atomic_inc(&bioc->error);

This can lead to data loss, especially for metadata which by default
goes with duplication.

[FIX]
Instead of only relying on btrfs_orig_write_end_io() to determine if the
bio is successful, also check the error inside the
btrfs_clone_write_end_io().

If any call site found we have exceed the tolerance, mark the original
bio as failed.

Yes, we still have races between atomic_inc() and atomic_read() in all
the endio threads.

But we have ensured the last thread calling atomic_read() would have a
correct view to do the final call, thus fixing the problem.

Fixes: c3a62baf21ad ("btrfs: use chained bios when cloning")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 42f1f87f1872..4eef135b57af 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -417,8 +417,6 @@ static void btrfs_orig_write_end_io(struct bio *bio)
 	 */
 	if (atomic_read(&bioc->error) > bioc->max_errors)
 		bio->bi_status = BLK_STS_IOERR;
-	else
-		bio->bi_status = BLK_STS_OK;
 
 	btrfs_orig_bbio_end_io(bbio);
 	btrfs_put_bioc(bioc);
@@ -435,6 +433,9 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	}
 
+	if (atomic_read(&stripe->bioc->error) >= stripe->bioc->max_errors)
+		stripe->bioc->orig_bio->bi_status = BLK_STS_IOERR;
+
 	/* Pass on control to the original bio this one was cloned from */
 	bio_endio(stripe->bioc->orig_bio);
 	bio_put(bio);
-- 
2.42.0

