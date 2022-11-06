Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAC61E787
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 00:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKFXXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 18:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKFXXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 18:23:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB963AD
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 15:23:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3808D21A20
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 23:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667777024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XAkDCVCVD6l3FaTsko3fq2IUhGXlSFv/Eprnx1NFPrs=;
        b=cr+Vct4SIXqfU278KTSit+6sEd9kuIDyKctO878cfhNb+wpxFiGXtFVNpmZrgoWAS9yXAH
        sQQhA8N/Jc8+zMnVxA5kaxDtCWThdo1CEYIprilbV8U1HNaZ3HFKr5Od/BFuR8xJt5ZYxi
        Wb8e/Frmx1ql8TsBt5mmczRsBkM8R8I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C521132E7
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 23:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9fmPFf9BaGMzQQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 23:23:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Revert "btrfs: scrub: use larger block size for data extent scrub"
Date:   Mon,  7 Nov 2022 07:23:26 +0800
Message-Id: <97622c5c2e2dbb2316901c6ebd9792cbf58385fd.1667776994.git.wqu@suse.com>
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

This reverts commit 786672e9e1a39a231806313e3c445c236588ceef.

[BUG]
Since commit 786672e9e1a3 ("btrfs: scrub: use larger block size for data
extent scrub"), btrfs scrub no longer reports errors if the corruption
is not in the first sector of a STRIPE_LEN.

The following script can expose the problem:

 mkfs.btrfs -f $dev
 mount $dev $mnt
 xfs_io -f -c "pwrite -S 0xff 0 8k" $mnt/foobar
 umount $mnt

 # 13631488 is the logical bytenr of above 8K extent
 btrfs-map-logical -l 13631488 -b 4096 $dev
 mirror 1 logical 13631488 physical 13631488 device /dev/test/scratch1

 # Corrupt the 2nd sector of that extent
 xfs_io -f -c "pwrite -S 0x00 13635584 4k" $dev

 mount $dev $mnt
 btrfs scrub start -B $mnt
 scrub done for 54e63f9f-0c30-4c84-a33b-5c56014629b7
 Scrub started:    Mon Nov  7 07:18:27 2022
 Status:           finished
 Duration:         0:00:00
 Total to scrub:   536.00MiB
 Rate:             0.00B/s
 Error summary:    no errors found <<<

[CAUSE]
That offending commit enlarge the data extent scrub size from sector
size to BTRFS_STRIPE_LEN, to avoid extra scrub_block to be allocated.

But unfortunately the data extent scrub is still heavily relying on the
fact that there is only one scrub_sector per scrub_block.

Thus it will only check the first sector, and ignoring the remaining
sectors.

Furthermore the error reporting is not able to handle multiple sectors
either.

[FIX]
For now just revert the offending commit.

The consequence is just extra memory usage during scrub.
We will need a proper change to make the remaining data scrub path to
handle multiple sectors before we enlarging the data scrub size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 06c6626eae3d..e5dbf875f6d9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2691,17 +2691,11 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	u8 csum[BTRFS_CSUM_SIZE];
 	u32 blocksize;
 
-	/*
-	 * Block size determines how many scrub_block will be allocated.  Here
-	 * we use BTRFS_STRIPE_LEN (64KiB) as default limit, so we won't
-	 * allocate too many scrub_block, while still won't cause too large
-	 * bios for large extents.
-	 */
 	if (flags & BTRFS_EXTENT_FLAG_DATA) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			blocksize = map->stripe_len;
 		else
-			blocksize = BTRFS_STRIPE_LEN;
+			blocksize = sctx->fs_info->sectorsize;
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.data_extents_scrubbed++;
 		sctx->stat.data_bytes_scrubbed += len;
-- 
2.38.1

