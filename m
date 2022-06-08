Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A454284F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiFHHqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiFHHpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 03:45:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DCE27B48F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:09:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCAA21B2F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654672178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ImvqvERKXyP3LNFV0Z0hg1SqA1rlLJyruXiSCABFLhQ=;
        b=BMj3bQ7uKOLd6oU3G5czJY1XhUrTk6R+3IVmdTGnCPku+XBrKI2N3Str3dSLbbA9lwPmGL
        ZZWcHy9Wc+XGUgRuuaRYkgRegY0zsqAQ4Q32vClWLEyF96HGMpG46voxgzDuBfAccmuai3
        //YbkK+Gosh0RhyPuLwAKnbO3E1y82g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B91CC13A15
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 07:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ksijIDFLoGLqEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 07:09:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't trust any cached sector in __raid56_parity_recover()
Date:   Wed,  8 Jun 2022 15:09:20 +0800
Message-Id: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a small workload which is a shorter version extracted from
btrfs/125:

  mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
  mount $dev1 $mnt
  xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
  sync
  umount $mnt
  btrfs dev scan -u $dev3
  mount -o degraded $dev1 $mnt
  xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
  umount $mnt
  btrfs dev scan
  mount $dev1 $mnt
  btrfs balance start --full-balance $mnt
  umount $mnt

In fact, after upstream commit d4e28d9b5f04 ("btrfs: raid56: make
steal_rbio() subpage compatible") above script will always pass, just
like btrfs/125.

But after a bug fix/optimization named "btrfs: update
stripe_sectors::uptodate in steal_rbio", above test case and btrfs/125
will always fail (just like the old behavior before upstream d4e28d9b5f04).

In my case, it fails due to tree block read failure, mostly on bytenr
38993920:

 BTRFS info (device dm-4): relocating block group 217710592 flags data|raid5
 BTRFS error (device dm-4): parent transid verify failed on 38993920 wanted 9 found 7
 BTRFS error (device dm-4): parent transid verify failed on 38993920 wanted 9 found 7
 ...

[CAUSE]
With the recently added debug output, we can see all RAID56 operations
related to full stripe 38928384:

 23256.118349: raid56_read_partial: full_stripe=38928384 devid=2 type=DATA1 offset=0 opf=0x0 physical=9502720 len=65536
 23256.118547: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=16384 opf=0x0 physical=9519104 len=16384
 23256.118562: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x0 physical=9551872 len=16384
 23256.118704: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=0 opf=0x1 physical=9502720 len=16384
 23256.118867: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=32768 opf=0x1 physical=9535488 len=16384
 23256.118887: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=0 opf=0x1 physical=30474240 len=16384
 23256.118902: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=32768 opf=0x1 physical=30507008 len=16384
 23256.121894: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x1 physical=9551872 len=16384
 23256.121907: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=49152 opf=0x1 physical=30523392 len=16384
 23256.272185: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
 23256.272335: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
 23256.272446: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2

Before we enter raid56_parity_recover(), we have triggered some metadata
write for the full stripe 38928384, this leads to us to read all the
sectors from disk.

However the test case itself intentionally uses degraded mount to create
stale metadata.
Thus we read out the stale data and cached them.

When we really need to recover certain range, aka in
raid56_parity_recover(), we will use the cached rbio, along with its
cached sectors.

And since those sectors are already cached, we won't even bother to
re-read them.
This explains why we have no event raid56_scrub_read_recover()
triggered.

Since we use the staled sectors to recover, and obviously this
will lead to incorrect data recovery.

In our particular test case, it will always return the same incorrect
metadata, thus causing the same error message "parent transid verify
failed on 39010304 wanted 9 found 7" again and again.

[FIX]
Commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
compatible") has a bug that makes RAID56 to skip any cached sector, thus
it incidentally fixed the failure of btrfs/125.

But later patch "btrfs: update stripe_sectors::uptodate in steal_rbio",
reverted to the old trust-cache-unconditionally behavior, and
re-introduced the bug.

In fact, we should still trust the cache for cases where everything is
fine.

What we really need is, trust nothing if we're recovery the full stripe.

So this patch will fix the behavior by not trust any cache in
__raid56_parity_recover(), to solve the problem while still keep the
cache useful.

Now btrfs/125 and above test case can always pass, instead of the old
random failure behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
I'm not sure how to push this patch.

It's a bug fix for the very old trust-cache-unconditionally bug, but
since upstream d4e28d9b5f04 incidentally fixed it (by never trusting the
cache), and later "btrfs: update stripe_sectors::uptodate in steal_rbio"
is really re-introducing the bad old behavior.

Thus I guess it may be a good idea to fold this small fix into "btrfs:
update stripe_sectors::uptodate in steal_rbio" ?
---
 fs/btrfs/raid56.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c1f61d1708ee..be2f0ea81116 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2125,9 +2125,12 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	atomic_set(&rbio->error, 0);
 
 	/*
-	 * read everything that hasn't failed.  Thanks to the
-	 * stripe cache, it is possible that some or all of these
-	 * pages are going to be uptodate.
+	 * Read everything that hasn't failed. However this time we will
+	 * not trust any cached sector.
+	 * As we may read out some stale data but higher layer is not reading
+	 * that stale part.
+	 *
+	 * So here we always re-read everything in recovery path.
 	 */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
@@ -2142,11 +2145,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 			total_sector_nr += rbio->stripe_nsectors - 1;
 			continue;
 		}
-		/* The rmw code may have already read this page in. */
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		if (sector->uptodate)
-			continue;
-
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
 					 sectornr, rbio->stripe_len,
 					 REQ_OP_READ);
-- 
2.36.1

