Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9B77A001
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjHLMtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Aug 2023 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHLMtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Aug 2023 08:49:00 -0400
Received: from out28-85.mail.aliyun.com (out28-85.mail.aliyun.com [115.124.28.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1A10DF;
        Sat, 12 Aug 2023 05:49:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04439297|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0568178-0.000947161-0.942235;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.UEk8l1d_1691844530;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.UEk8l1d_1691844530)
          by smtp.aliyun-inc.com;
          Sat, 12 Aug 2023 20:48:55 +0800
Date:   Sat, 12 Aug 2023 20:48:57 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH v2] btrfs/213: avoid occasional failure due to already finished balance
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
In-Reply-To: <ff12321e5ddfdb763b9258f746e67fe3f6ea1321.1684489375.git.fdmanana@suse.com>
References: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com> <ff12321e5ddfdb763b9258f746e67fe3f6ea1321.1684489375.git.fdmanana@suse.com>
Message-Id: <20230812204850.B86D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/213 writes data, in 1M extents, for 4 seconds into a file, then
> triggers a balance and then after 2 seconds it tries to cancel the
> balance operation. More often than not, this works because the balance
> is still running after 2 seconds. However it also fails sporadically
> because balance has finished in less than 2 seconds, which is plausible
> since data and metadata are cached or other factors such as virtualized
> environment. When that's the case, it fails like this:
> 
>   $ ./check btrfs/213
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc1-btrfs-next-131+ #1 SMP PREEMPT_DYNAMIC Thu May 11 11:26:19 WEST 2023
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/213 51s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad)
>       --- tests/btrfs/213.out	2020-06-10 19:29:03.822519250 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad	2023-05-17 15:39:32.653727223 +0100
>       @@ -1,2 +1,3 @@
>        QA output created by 213
>       +ERROR: balance cancel on '/home/fdmanana/btrfs-tests/scratch_1' failed: Not in progress
>        Silence is golden
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/213.out /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad'  to see the entire diff)
>   Ran: btrfs/213
>   Failures: btrfs/213
>   Failed 1 of 1 tests
> 
> To make it much less likely that balance has already finished before we
> try to cancel it, unmount and mount again the filesystem before starting
> balance, to clear cached metadata and data, and also double the time we
> spend writing 1M data extents. Also make the test not run with an
> informative message if we detect that balance finished before we could
> cancel it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> v2: Make the test _notrun if we detect that balance finished before we
>     could cancel it.
> 
>  tests/btrfs/213 | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> index e16e41c0..5666d9b9 100755
> --- a/tests/btrfs/213
> +++ b/tests/btrfs/213
> @@ -31,7 +31,7 @@ _fixed_by_kernel_commit 1dae7e0e58b4 \
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
>  
> -runtime=4
> +runtime=8
>  
>  # Create enough IO so that we need around $runtime seconds to relocate it.
>  #
> @@ -42,11 +42,21 @@ sleep $runtime
>  kill $write_pid
>  wait $write_pid
>  
> +# Unmount and mount again the fs to clear any cached data and metadata, so that
> +# it's less likely balance has already finished when we try to cancel it below.
> +_scratch_cycle_mount
> +
>  # Now balance should take at least $runtime seconds, we can cancel it at
>  # $runtime/2 to ensure a success cancel.
>  _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
> -sleep $(($runtime / 2))
> -$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> +sleep $(($runtime / 4))
> +# It's possible that balance has already completed. It's unlikely but often
> +# it may happen due to virtualization, caching and other factors, so ignore
> +# any error about no balance currently running.
> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in progress'
> +if [ $? -eq 0 ]; then
> +	_not_run "balance finished before we could cancel it"
> +fi

fstests(btrfs/213) failed once here.

btrfs/213 22s ... - output mismatch (see /usr/hpc-bio/xfstests/results//btrfs/213.out.bad)
    --- tests/btrfs/213.out     2023-03-28 06:09:10.372680814 +0800
    +++ /usr/hpc-bio/xfstests/results//btrfs/213.out.bad        2023-08-12 20:31:47.848303940 +0800
    @@ -1,2 +1,5 @@
     QA output created by 213
    +/usr/hpc-bio/xfstests/tests/btrfs/213: line 59: _not_run: command not found
    +ERROR: error during balancing '/mnt/scratch': No space left on device
    +There may be more info in syslog - try dmesg | tail
     Silence is golden

we need to fix the error of '_not_run: command not found'  firstly.

I will update the info if fstests(btrfs/213) fails again.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/12



