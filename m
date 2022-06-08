Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4C542C8C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiFHKFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 06:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiFHKE3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 06:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5019EB65
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 02:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED4F60F38
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864F3C3411C;
        Wed,  8 Jun 2022 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654681673;
        bh=8ftmP1Wp+7lkYKB8YyoJ46V7lBhNqrOQgE5IbxzejtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4b1lfpRx7Swn5U5OFPA7b7mY3cDMeOPF8jZySzAj4zvvTmJRf+MokzFnR7G0krZy
         YN3HwbkILo5ohPqMrA7WlBN/u3ZfKCYpX32DZupEDGvN4UT4izPBaom4z9HNubRpEv
         zXUHAmmVRVL5WP8bdhmZ+fS3kHrFCCmdF1udVH8LmIBo0KZWY4PCp5lgV+GNjXudgt
         vjXM7O0bp0z7jtEflsCa8Ke2cXqfrc0GF9we7sxIA6/n1wszTMoydkTPzyaK/+QvBR
         PZp/Z0hIuF+rOap1D28Jjn2WzfMnUea60UjyYJbk9/74TgN9UfYB2sG026aFG0mRak
         Hc6k5khHdiasg==
Date:   Wed, 8 Jun 2022 10:47:51 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
Message-ID: <20220608094751.GA3603651@falcondesktop>
References: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 03:09:20PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a small workload which is a shorter version extracted from
> btrfs/125:
> 
>   mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>   mount $dev1 $mnt
>   xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>   sync
>   umount $mnt
>   btrfs dev scan -u $dev3
>   mount -o degraded $dev1 $mnt
>   xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>   umount $mnt
>   btrfs dev scan
>   mount $dev1 $mnt
>   btrfs balance start --full-balance $mnt
>   umount $mnt
> 
> In fact, after upstream commit d4e28d9b5f04 ("btrfs: raid56: make
> steal_rbio() subpage compatible") above script will always pass, just
> like btrfs/125.

For me it still fails, very often.
Both before and after that commit.

> 
> But after a bug fix/optimization named "btrfs: update
> stripe_sectors::uptodate in steal_rbio", above test case and btrfs/125
> will always fail (just like the old behavior before upstream d4e28d9b5f04).

And I'm running a branch without that patch, which is just misc-next from
about 2 weeks ago:

https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=test_branch

This is still all due to the fundamental flaw we have with partial stripe
writes I pointed out long ago:

https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com/

Running it again:

root 10:18:07 /home/fdmanana/git/hub/xfstests (for-next)> ./check btrfs/125
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 5.18.0-btrfs-next-119 #1 SMP PREEMPT_DYNAMIC Sat May 28 20:28:23 WEST 2022
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/125 5s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad)
    --- tests/btrfs/125.out	2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad	2022-06-08 10:18:13.521948910 +0100
    @@ -3,5 +3,15 @@
     Write data with degraded mount
     
     Mount normal and balance
    +ERROR: error during balancing '/home/fdmanana/btrfs-tests/scratch_1': Input/output error
    +There may be more info in syslog - try dmesg | tail
    +md5sum: /home/fdmanana/btrfs-tests/scratch_1/tf2: Input/output error
     
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/125.out /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad'  to see the entire diff)
Ran: btrfs/125
Failures: btrfs/125
Failed 1 of 1 tests

root 10:18:17 /home/fdmanana/git/hub/xfstests (for-next)> dmesg
[777880.530807] run fstests btrfs/125 at 2022-06-08 10:18:09
[777881.341004] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 1 transid 6 /dev/sdb scanned by mkfs.btrfs (3174370)
[777881.343023] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 2 transid 6 /dev/sdd scanned by mkfs.btrfs (3174370)
[777881.343156] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 3 transid 6 /dev/sde scanned by mkfs.btrfs (3174370)
[777881.360352] BTRFS info (device sdb): flagging fs with big metadata feature
[777881.360356] BTRFS info (device sdb): using free space tree
[777881.360357] BTRFS info (device sdb): has skinny extents
[777881.365900] BTRFS info (device sdb): checking UUID tree
[777881.459545] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 2 transid 8 /dev/sdd scanned by mount (3174418)
[777881.459637] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 1 transid 8 /dev/sdb scanned by mount (3174418)
[777881.460202] BTRFS info (device sdb): flagging fs with big metadata feature
[777881.460204] BTRFS info (device sdb): allowing degraded mounts
[777881.460206] BTRFS info (device sdb): using free space tree
[777881.460206] BTRFS info (device sdb): has skinny extents
[777881.466293] BTRFS warning (device sdb): devid 3 uuid a9540970-da42-44f8-9e62-30e6fdf013af is missing
[777881.466568] BTRFS warning (device sdb): devid 3 uuid a9540970-da42-44f8-9e62-30e6fdf013af is missing
[777881.923840] BTRFS: device fsid 57e10060-7318-4cd3-8e2d-4c3e481b1dab devid 1 transid 16797 /dev/sda scanned by btrfs (3174443)
[777881.939421] BTRFS info (device sdb): flagging fs with big metadata feature
[777881.939425] BTRFS info (device sdb): using free space tree
[777881.939426] BTRFS info (device sdb): has skinny extents
[777881.959199] BTRFS info (device sdb): balance: start -d -m -s
[777881.959348] BTRFS info (device sdb): relocating block group 754581504 flags data|raid5
[777882.352088] verify_parent_transid: 787 callbacks suppressed
[777882.352092] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.352327] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.352481] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.352692] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.352844] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.353066] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.353241] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.353567] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.353760] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.353982] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
[777882.455036] BTRFS info (device sdb): balance: ended with status: -5
[777882.456202] BTRFS: error (device sdb: state A) in do_free_extent_accounting:2864: errno=-5 IO failure


> 
> In my case, it fails due to tree block read failure, mostly on bytenr
> 38993920:
> 
>  BTRFS info (device dm-4): relocating block group 217710592 flags data|raid5
>  BTRFS error (device dm-4): parent transid verify failed on 38993920 wanted 9 found 7
>  BTRFS error (device dm-4): parent transid verify failed on 38993920 wanted 9 found 7
>  ...
> 
> [CAUSE]
> With the recently added debug output, we can see all RAID56 operations
> related to full stripe 38928384:
> 
>  23256.118349: raid56_read_partial: full_stripe=38928384 devid=2 type=DATA1 offset=0 opf=0x0 physical=9502720 len=65536
>  23256.118547: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=16384 opf=0x0 physical=9519104 len=16384
>  23256.118562: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x0 physical=9551872 len=16384
>  23256.118704: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=0 opf=0x1 physical=9502720 len=16384
>  23256.118867: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=32768 opf=0x1 physical=9535488 len=16384
>  23256.118887: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=0 opf=0x1 physical=30474240 len=16384
>  23256.118902: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=32768 opf=0x1 physical=30507008 len=16384
>  23256.121894: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x1 physical=9551872 len=16384
>  23256.121907: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=49152 opf=0x1 physical=30523392 len=16384
>  23256.272185: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
>  23256.272335: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
>  23256.272446: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
> 
> Before we enter raid56_parity_recover(), we have triggered some metadata
> write for the full stripe 38928384, this leads to us to read all the
> sectors from disk.
> 
> However the test case itself intentionally uses degraded mount to create
> stale metadata.
> Thus we read out the stale data and cached them.
> 
> When we really need to recover certain range, aka in
> raid56_parity_recover(), we will use the cached rbio, along with its
> cached sectors.
> 
> And since those sectors are already cached, we won't even bother to
> re-read them.
> This explains why we have no event raid56_scrub_read_recover()
> triggered.
> 
> Since we use the staled sectors to recover, and obviously this
> will lead to incorrect data recovery.
> 
> In our particular test case, it will always return the same incorrect
> metadata, thus causing the same error message "parent transid verify
> failed on 39010304 wanted 9 found 7" again and again.
> 
> [FIX]
> Commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
> compatible") has a bug that makes RAID56 to skip any cached sector, thus
> it incidentally fixed the failure of btrfs/125.

As mentioned before, I still have the test failing very often even after
that commit, and I don't see how that could ever fix the fundamental
problem raid56 has with partial stripe writes.

Thanks.

> 
> But later patch "btrfs: update stripe_sectors::uptodate in steal_rbio",
> reverted to the old trust-cache-unconditionally behavior, and
> re-introduced the bug.
> 
> In fact, we should still trust the cache for cases where everything is
> fine.
> 
> What we really need is, trust nothing if we're recovery the full stripe.
> 
> So this patch will fix the behavior by not trust any cache in
> __raid56_parity_recover(), to solve the problem while still keep the
> cache useful.
> 
> Now btrfs/125 and above test case can always pass, instead of the old
> random failure behavior.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> I'm not sure how to push this patch.
> 
> It's a bug fix for the very old trust-cache-unconditionally bug, but
> since upstream d4e28d9b5f04 incidentally fixed it (by never trusting the
> cache), and later "btrfs: update stripe_sectors::uptodate in steal_rbio"
> is really re-introducing the bad old behavior.
> 
> Thus I guess it may be a good idea to fold this small fix into "btrfs:
> update stripe_sectors::uptodate in steal_rbio" ?
> ---
>  fs/btrfs/raid56.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index c1f61d1708ee..be2f0ea81116 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2125,9 +2125,12 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  	atomic_set(&rbio->error, 0);
>  
>  	/*
> -	 * read everything that hasn't failed.  Thanks to the
> -	 * stripe cache, it is possible that some or all of these
> -	 * pages are going to be uptodate.
> +	 * Read everything that hasn't failed. However this time we will
> +	 * not trust any cached sector.
> +	 * As we may read out some stale data but higher layer is not reading
> +	 * that stale part.
> +	 *
> +	 * So here we always re-read everything in recovery path.
>  	 */
>  	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
>  	     total_sector_nr++) {
> @@ -2142,11 +2145,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  			total_sector_nr += rbio->stripe_nsectors - 1;
>  			continue;
>  		}
> -		/* The rmw code may have already read this page in. */
>  		sector = rbio_stripe_sector(rbio, stripe, sectornr);
> -		if (sector->uptodate)
> -			continue;
> -
>  		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
>  					 sectornr, rbio->stripe_len,
>  					 REQ_OP_READ);
> -- 
> 2.36.1
> 
