Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC55544308
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 07:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiFIFTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 01:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiFIFTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 01:19:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132420F78
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 22:19:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0E8621CE6
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 05:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654751942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NUC8t3+RuUnJYFWFWJnGFnH8eo1tlIrtk7wEnJwDgNY=;
        b=Xvn6QWTyZQQy1Iey0sHhac594z5/YEXafRGWxkTa15SAlJaHn7ddECqTh59Vv+PKMfda0V
        A8yb6OE6SDo5DYaSIj8lWRNjagq2g42GTuN0rKneVJ7UHzM6mzXJ5phrk4hwl2NErcIxIC
        v7Sv6j2SpJTRUObpDzZjJKP/pZ4lmEU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05658137FA
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 05:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GgieMMWCoWKcEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jun 2022 05:19:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: don't trust any cached sector in __raid56_parity_recover()
Date:   Thu,  9 Jun 2022 13:18:44 +0800
Message-Id: <5c6e45e599134cf203b76956d314b28835211990.1654751908.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

[BUG]
There is a small workload which will always fail with recent kernel:
(A simplified version from btrfs/125 test case)

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

The failure is always failed to read some tree blocks:

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

Furthermore, btrfs raid56 write will cache its calculated P/Q sectors to
avoid unnecessary read.

This means, for that full stripe, after any partial write, we will have
stale data, along with P/Q calculated using that stale data.

Thankfully due to patch "btrfs: only write the sectors in the vertical stripe
which has data stripes" we haven't submitted all the corrupted P/Q to disk.

When we really need to recover certain range, aka in
raid56_parity_recover(), we will use the cached rbio, along with its
cached sectors (the full stripe is all cached).

This explains why we have no event raid56_scrub_read_recover()
triggered.

Since we have the cached P/Q which is calculated using the stale data,
the recovered one will just be stale.

In our particular test case, it will always return the same incorrect
metadata, thus causing the same error message "parent transid verify
failed on 39010304 wanted 9 found 7" again and again.

[BTRFS DESTRUCTIVE RMW PROBLEM]

Test case btrfs/125 (and above workload) always has its trouble with
the destructive read-modify-write (RMW) cycle:

        0       32K     64K
Data1:  | Good  | Good  |
Data2:  | Bad   | Bad   |
Parity: | Good  | Good  |

In above case, if we trigger any write into Data1, we will use the bad
data in Data2 to re-generate parity, killing the only chance to recovery
Data2, thus Data2 is lost forever.

This destructive RMW cycle is not specific to btrfs RAID56, but there
are some btrfs specific behaviors making the case even worse:

- Btrfs will cache sectors for unrelated vertical stripes.

  In above example, if we're only writing into 0~32K range, btrfs will
  still read data range (32K ~ 64K) of Data1, and (64K~128K) of Data2.
  This behavior is to cache sectors for later update.

  Incidentally commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio()
  subpage compatible") has a bug which makes RAID56 to never trust the
  cached sectors, thus slightly improve the situation for recovery.

  Unfortunately, follow up fix "btrfs: update stripe_sectors::uptodate in
  steal_rbio" will revert the behavior back to the old one.

- Btrfs raid56 partial write will update all P/Q sectors and cache them

  This means, even if data at (64K ~ 96K) of Data2 is free space, and
  only (96K ~ 128K) of Data2 is really stale data.
  And we write into that (96K ~ 128K), we will update all the parity
  sectors for the full stripe.

  This unnecessary behavior will completely kill the chance of recovery.

  Thankfully, an unrelated optimization "btrfs: only write the sectors
  in the vertical stripe which has data stripes" will prevent
  submitting the write bio for untouched vertical sectors.

  That optimization will keep the on-disk P/Q untouched for a chance for
  later recovery.

[FIX]
Although we have no good way to completely fix the destructive RMW
(unless we go full scrub for each partial write), we can still limit the
damage.

With patch "btrfs: only write the sectors in the vertical stripe which
has data stripes" now we won't really submit the P/Q of unrelated
vertical stripes, so the on-disk P/Q should still be fine.

Now we really need to do is just drop all the cached sectors when doing
recovery.

By this, we have a chance to read the original P/Q from disk, and have a
chance to recover the stale data, while still keep the cache to speed up
regular write path.

In fact, just dropping all the cache for recovery path is good enough to
allow the test case btrfs/125 along with the small script to pass
reliably.

The lack of metadata write after the degraded mount, and forced metadata
COW is saving us this time.

So this patch will fix the behavior by not trust any cache in
__raid56_parity_recover(), to solve the problem while still keep the
cache useful.

But please remind that, this test pass DOES NOT mean we have solved the
destructive RMW problem, we just do better damage control a little
better.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Update the commit message to explain all involved patches better
  There are 3 patches (one in upstream, two in misc-next) involved for
  the case.

- Update the commit message to show we still have the destructive RMW
  problem
  It will never be solved until we do scrub level check for partial
  write.
  This patch is just doing damage control to limit the spread of
  corruption.
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

