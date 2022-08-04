Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9065898C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiHDHyo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiHDHyn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 03:54:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7465554;
        Thu,  4 Aug 2022 00:54:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B9311FA50;
        Thu,  4 Aug 2022 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659599680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ+qT4mfdn7OrmKDgAghhd9N5+5Yvbp+4Pg1Dtoedcs=;
        b=fLw2uCQfBDCeuqUIUx3pj146z1m5T3J8+gV6oR48m0jqjmtYjH4ndqpM3LsSm8eGhVWUeA
        tC7DRY1UEnhAWgiDATWqBZGnKjytN+xVES+tCHCF65Hu9QG13FYegwsx3oczyXzyTANRda
        YtOWYy2N7nP6PkfzZoZqB4g1mQZNiUI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1196F13AE1;
        Thu,  4 Aug 2022 07:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0NfJMz5762JvIgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 04 Aug 2022 07:54:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH STABLE 4.9 5.4 2/2] btrfs: raid56: don't trust any cached sector in __raid56_parity_recover()
Date:   Thu,  4 Aug 2022 15:54:19 +0800
Message-Id: <0af04ca8e0f1254df402c8fbd6a42992bcb4ae9f.1659599526.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659599526.git.wqu@suse.com>
References: <cover.1659599526.git.wqu@suse.com>
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

commit f6065f8edeb25f4a9dfe0b446030ad995a84a088 upstream.

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

  56.1183: raid56_read_partial: full_stripe=38928384 devid=2 type=DATA1 offset=0 opf=0x0 physical=9502720 len=65536
  56.1185: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=16384 opf=0x0 physical=9519104 len=16384
  56.1185: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x0 physical=9551872 len=16384
  56.1187: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=0 opf=0x1 physical=9502720 len=16384
  56.1188: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=32768 opf=0x1 physical=9535488 len=16384
  56.1188: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=0 opf=0x1 physical=30474240 len=16384
  56.1189: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=32768 opf=0x1 physical=30507008 len=16384
  56.1218: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x1 physical=9551872 len=16384
  56.1219: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=49152 opf=0x1 physical=30523392 len=16384
  56.2721: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
  56.2723: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
  56.2724: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2

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

But please note that this test pass DOES NOT mean we have solved the
destructive RMW problem, we just do better damage control a little
better.

Related patches:

- btrfs: only write the sectors in the vertical stripe
- d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage compatible")
- btrfs: update stripe_sectors::uptodate in steal_rbio

Cc: stable@vger.kernel.org # 4.9 5.4
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4bd73713592f..1fd3fabf8a93 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2116,9 +2116,12 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
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
 	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
 		if (rbio->faila == stripe || rbio->failb == stripe) {
@@ -2127,16 +2130,6 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		}
 
 		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
-			struct page *p;
-
-			/*
-			 * the rmw code may have already read this
-			 * page in
-			 */
-			p = rbio_stripe_page(rbio, stripe, pagenr);
-			if (PageUptodate(p))
-				continue;
-
 			ret = rbio_add_io_page(rbio, &bio_list,
 				       rbio_stripe_page(rbio, stripe, pagenr),
 				       stripe, pagenr, rbio->stripe_len);
-- 
2.37.0

