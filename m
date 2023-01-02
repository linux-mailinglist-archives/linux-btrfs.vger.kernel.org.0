Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9465ACF7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 04:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjABD0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Jan 2023 22:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABD0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Jan 2023 22:26:07 -0500
Received: from out20-73.mail.aliyun.com (out20-73.mail.aliyun.com [115.124.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2724110E
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Jan 2023 19:26:03 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04446268|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.055713-0.000692993-0.943594;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.QiRPWPn_1672629960;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QiRPWPn_1672629960)
          by smtp.aliyun-inc.com;
          Mon, 02 Jan 2023 11:26:01 +0800
Date:   Mon, 02 Jan 2023 11:26:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with dev-replace
Cc:     linux-btrfs@vger.kernel.org,
        =?GB2312?B?0KHMqw==?= <nospam@kota.moe>
In-Reply-To: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
Message-Id: <20230102112600.8869.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> [BUG]
> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
> (originally repair_io_failure() in v6.0 kernel) got triggered when
> replacing a unreliable disk:

It seems a good test case that we could add to fstests.

Is there any reproducer already?
corrence of scrub and dev-replace ? still fail to reproduce it here.

local reproducer:
dev1=/dev/sdb2
dev2=/dev/sdb3
dev3=/dev/sdb4

mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
mount $dev1 /mnt/scratch/
dd if=/dev/urandom bs=1M count=2K of=/mnt/scratch/r.txt
umount /mnt/scratch
blkdiscard -f --offset 32MiB $dev1
mount $dev2 /mnt/scratch/
btrfs replace start -f 1 $dev3 /mnt/scratch/ &
btrfs scrub start /mnt/scratch/ &
wait; sleep 1m
btrfs replace status /mnt/scratch
umount /mnt/scratch

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/02

> 
>  BTRFS warning (device sda1): csum failed root 257 ino 2397453 off 39624704 csum 0xb0d18c75 expected csum 0x4dae9c5e mirror 3
>  kernel BUG at fs/btrfs/extent_io.c:2380!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 3614331 Comm: kworker/u257:2 Tainted: G           OE      6.0.0-5-amd64 #1  Debian 6.0.10-2
>  Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40 PRO WIFI (MS-7C60), BIOS 2.70 07/01/2021
>  Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>  RIP: 0010:repair_io_failure+0x24a/0x260 [btrfs]
>  Call Trace:
>   <TASK>
>   clean_io_failure+0x14d/0x180 [btrfs]
>   end_bio_extent_readpage+0x412/0x6e0 [btrfs]
>   ? __switch_to+0x106/0x420
>   process_one_work+0x1c7/0x380
>   worker_thread+0x4d/0x380
>   ? rescuer_thread+0x3a0/0x3a0
>   kthread+0xe9/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> [CAUSE]
> 
> Before the BUG_ON(), we got some read errors from the replace target
> first, note the mirror number (3, which is beyond RAID1 duplication,
> thus it's read from the replace target device).
> 
> Then at the BUG_ON() location, we are trying to writeback the repaired
> sectors back the failed device.
> 
> The check looks like this:
> 
> 		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
> 				      &map_length, &bioc, mirror_num);
> 		if (ret)
> 			goto out_counter_dec;
> 		BUG_ON(mirror_num != bioc->mirror_num);
> 
> But inside btrfs_map_block(), we can modify bioc->mirror_num especially
> for dev-replace:
> 
> 	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
> 	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
> 		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
> 						    dev_replace->srcdev->devid,
> 						    &mirror_num,
> 					    &physical_to_patch_in_first_stripe);
> 		patch_the_first_stripe_for_dev_replace = 1;
> 	}
> 
> Thus if we're repairing the replace target device, we're going to
> triggere that BUG_ON().
> 
> But in reality, the read failure from the replace target device may be that,
> our replace haven't reach the range we're reading, thus we're reading
> garbage, but with replace running, the range would be properly filled
> later.
> 
> Thus in that case, we don't need to do anything but let the replace
> routine to handle it.
> 
> [FIX]
> Instead of a BUG_ON(), just skip the repair if we're repairing the
> device replace target device.
> 
> Reported-by: С̫ <nospam@kota.moe>
> Link: https://lore.kernel.org/linux-btrfs/CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index b8fb7ef6b520..444e20b15e26 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -329,7 +329,16 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>  				      &map_length, &bioc, mirror_num);
>  		if (ret)
>  			goto out_counter_dec;
> -		BUG_ON(mirror_num != bioc->mirror_num);
> +		/*
> +		 * This happens when dev-replace is also happening, and
> +		 * the mirror_num indicates the dev-replace target.
> +		 *
> +		 * In this case, we don't need to do anything, as the read
> +		 * error just means the replace progress hasn't reached our
> +		 * read range, and later replace routine would handle it well.
> +		 */
> +		if (mirror_num != bioc->mirror_num)
> +			goto out_counter_dec;
>  	}
>  
>  	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
> -- 
> 2.39.0


