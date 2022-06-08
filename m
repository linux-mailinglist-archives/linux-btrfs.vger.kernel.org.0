Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095BD542C13
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiFHJzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 05:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbiFHJyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 05:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B76E4424;
        Wed,  8 Jun 2022 02:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30786617F5;
        Wed,  8 Jun 2022 09:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E39EC3411C;
        Wed,  8 Jun 2022 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654680315;
        bh=dcAB5EtQDyrZzmvmzkzYIxRS3J5vHsfxOzBah/JAS1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjO9qya2kG0H6jQt+roA3lb3vPp+3OyOuKT1pQAxude6xnAuFIUDSGPyF1uPTVJ5R
         cM9VVJmNKXrQqo6j/eDARasQzy+7g6a08bjCTICJMl8C/aXhDMN0U13ZE3BkkPXP7T
         y+KEhS0TuYIa8Bco6ZFLQxMEY0DbTPJp4JZw4a3EiPhCHxvBDknJKnUqgz3tUlfarT
         LZkcGbRZFdZ5iXTa+YC7ufo7aYv5O0bpHbvCjQ1wxLSJWbQwQ0S45zqE7UOh5BcVuQ
         +Dub3yXEox5rfipzYoX6A9aWzHitRtjOU3izl360wmhk3qRWuu6X24lwynBJDBiD1p
         Rkv2jezD3gbYA==
Date:   Wed, 8 Jun 2022 10:25:12 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: re-add btrfs/125 into auto group
Message-ID: <20220608092512.GA3602146@falcondesktop>
References: <63471ce6c6d4a4e9db4c3f4771bb512f31131932.1654672817.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63471ce6c6d4a4e9db4c3f4771bb512f31131932.1654672817.git.wqu@suse.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 03:20:21PM +0800, Qu Wenruo wrote:
> Test case btrfs/125 previous has a very random pass/fail ratio.
> 
> This is due to the fact that previously btrfs RAID56 recovery path will
> always trust the cached data.
> 
> Thus if there is some operation reading part/all of the full stripe,
> that full stripe can be cached, making later recovery to generate bad
> data.
> 
> As the cached data can be stale (intentionally caused by the test case).
> 
> Upstream commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
> compatible") incidentally disable all the cache re-use for btrfs RAID56,
> thus make btrfs/125 to always pass.
> 
> Although we will later re-enable the cache behavior for btrfs RAID56, we
> will not let recovery path to use any cache at all, thus this will give
> us the best things from both worlds, making btrfs/125 to pass
> consistently, while still enable cache for regular read/write.

The test has failed very often, and that's due to known problem with
degraded rw mounts and partial stripe writes [1].

I just ran it again, and the problem is obviously still there, as nothing
changed regarding that problem:

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

So I don't think it should be added to the auto group.
Thanks.

[1] https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com/
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/125 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index b58f2aa282bd..ced812cd921a 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -22,7 +22,7 @@
>  # Verify if all three checkpoints match
>  #
>  . ./common/preamble
> -_begin_fstest replace volume balance
> +_begin_fstest auto replace volume balance
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.36.1
> 
