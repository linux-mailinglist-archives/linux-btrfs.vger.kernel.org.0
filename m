Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0859265AD04
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 05:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjABEIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Jan 2023 23:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABEIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Jan 2023 23:08:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F351026
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Jan 2023 20:08:14 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHGCu-1oz0pY1Va4-00DFpP; Mon, 02
 Jan 2023 05:08:05 +0100
Message-ID: <8fcf8963-7077-21dd-2b87-976014533c7c@gmx.com>
Date:   Mon, 2 Jan 2023 12:08:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
 <20230102112600.8869.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
In-Reply-To: <20230102112600.8869.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eujRDcGprUSpItlXIYyY4l69jxpZE7fU/t3TKsHjvZpBkOAYkUe
 sN4VkcCuefyv6kE3JWA9R2V0QF0a0J8oYPPfizOJ4l0ZAYm0+nl5/ZpbDPr4zY+oV4gcvDU
 cKBpkummKGsBkJYz+6IlGWEBo6SLZHX+rja32WwySYpcgiRK58d4Q5kwNAyd7kgbti7GDjf
 M8MtGPk9nw7sy8XK2PRfw==
UI-OutboundReport: notjunk:1;M01:P0:NuXsKFhwM/o=;4rWFc4nHWvS3M9jMJfBbr691e9r
 tZcNwfX3EDleBG8e3A7tk84XIq/62UVx+GcUgiPT3UCTd7Au5Vv9fCNP9gKDmWvcHSD4cvcKC
 2euZVIVjXEg+LdBfBGjzI1n2jIHoXQoOHPJa+7KmyDzw6H+jZmvGw6N8S+HOHZPdgprUHRlL+
 ryG6bDqY5bhMbSnqUB+gUgnzLYjFkvzsK6su7PQUtyN+c2NHMXnfazt1EdsPnH7Kl2pfZECRs
 15w8fClZFWB0wIlVGTj3KqvtL2XgKtJM/S0DQBz+z94TU7H3gbNiysb888I4Y3fWiVpr6Qf+c
 uZZUM1QNHOac0IWB6ru90YKvAyPiI7TUpurNX13JVvyc7/6n2cpDtH1p9e4AFgU7m+p4vyn/d
 2lP9LWBE40ZlYPIlchoyRESzhrjZQN0G8itx1qbd3O2WxXYeePavQFubuA/VkxScMPjvdIG73
 27xRqMB/W2KcrpwqSX/aNfR4dgtgz9TDnnTY0SaAFbmPdWGJR8J5lrRbiuLwcGJ47DYfA3IuD
 2jnQ2FU/PKgHupFslnjRubDUVRFIm1Z8R3llJdrJfqvzMKrcfjY4QknmnddQPinuEyaCOJ7Me
 zy9gxLdbhRnyXjCnCjkKqkBf97llLExoWekyDncgqYIWW2XGKIe8IG+DWGK+VoA+4r2Wi/W7w
 AcKI0wyOZcG4sWUyh62K51alYOoaj4Yij1pzkmC6l/gE1e3CL5Uu7C/s1uj+W30YUVFUXNd2T
 Ma43cqzguHxRwL7oreOQfR7Pf2caWG7vEydsjq0ioJfj8GiQZiJsERHqvlIhooXJA/cGM2P8I
 pOIjF5hwQTymyf+HkrBiAz6Z/mBMmcETtW+YaPSON3ca5ITWBHWJ7LG6InwnkFM6tnmUKYU2d
 mr7j8QVlEOz8DG/fnLdTmzzzlNvNF7GyVAnIG+UzHLWIE+k41SvQqLVcn0fwqcrqeAuX7NL9D
 /DPX+SR4k8Af0gGVhQhNWQ6hQoY=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/2 11:26, Wang Yugui wrote:
> Hi,
> 
>> [BUG]
>> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
>> (originally repair_io_failure() in v6.0 kernel) got triggered when
>> replacing a unreliable disk:
> 
> It seems a good test case that we could add to fstests.
> 
> Is there any reproducer already?
> corrence of scrub and dev-replace ? still fail to reproduce it here.

It's not that simple, and you need to understand the workflow before 
crafting a script.

It needs several things to happen at the same time:

- The corruption happens at the last mirror.
   This can be done manually, but I doubt if it's reliable for a test
   case.

   As the new data chunks can easily switch their devices:

   	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 
itemsize 112
		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 1 offset 298844160
			dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
			stripe 1 devid 2 offset 277872640
			dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
	item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 1372585984) itemoff 15639 
itemsize 112
		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 1351614464
			dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
			stripe 1 devid 1 offset 1372585984
			dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7


- The corrupted device still needs to be recognized

- Dev-replace must be running, and has not yet reach the corrupted
   mirror

- A read on that corrupted mirror happened

The last two conditions are already very hard to trigger.

> 
> local reproducer:
> dev1=/dev/sdb2
> dev2=/dev/sdb3
> dev3=/dev/sdb4
> 
> mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
> mount $dev1 /mnt/scratch/
> dd if=/dev/urandom bs=1M count=2K of=/mnt/scratch/r.txt

This would create extra data stripes, but it won't ensure that devid 1 
is going to mirror 2.

It may or may not depending on the chunk layout, and I'd say it's a 
little random.

> umount /mnt/scratch
> blkdiscard -f --offset 32MiB $dev1
> mount $dev2 /mnt/scratch/
> btrfs replace start -f 1 $dev3 /mnt/scratch/ &
> btrfs scrub start /mnt/scratch/ &

Scrub repair is completely different compared to read-repair.

> wait; sleep 1m
> btrfs replace status /mnt/scratch
> umount /mnt/scratch
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/01/02
> 
>>
>>   BTRFS warning (device sda1): csum failed root 257 ino 2397453 off 39624704 csum 0xb0d18c75 expected csum 0x4dae9c5e mirror 3
>>   kernel BUG at fs/btrfs/extent_io.c:2380!
>>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 9 PID: 3614331 Comm: kworker/u257:2 Tainted: G           OE      6.0.0-5-amd64 #1  Debian 6.0.10-2
>>   Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40 PRO WIFI (MS-7C60), BIOS 2.70 07/01/2021
>>   Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>>   RIP: 0010:repair_io_failure+0x24a/0x260 [btrfs]
>>   Call Trace:
>>    <TASK>
>>    clean_io_failure+0x14d/0x180 [btrfs]
>>    end_bio_extent_readpage+0x412/0x6e0 [btrfs]
>>    ? __switch_to+0x106/0x420
>>    process_one_work+0x1c7/0x380
>>    worker_thread+0x4d/0x380
>>    ? rescuer_thread+0x3a0/0x3a0
>>    kthread+0xe9/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x22/0x30
>>    </TASK>
>>
>> [CAUSE]
>>
>> Before the BUG_ON(), we got some read errors from the replace target
>> first, note the mirror number (3, which is beyond RAID1 duplication,
>> thus it's read from the replace target device).
>>
>> Then at the BUG_ON() location, we are trying to writeback the repaired
>> sectors back the failed device.
>>
>> The check looks like this:
>>
>> 		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
>> 				      &map_length, &bioc, mirror_num);
>> 		if (ret)
>> 			goto out_counter_dec;
>> 		BUG_ON(mirror_num != bioc->mirror_num);
>>
>> But inside btrfs_map_block(), we can modify bioc->mirror_num especially
>> for dev-replace:
>>
>> 	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
>> 	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
>> 		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
>> 						    dev_replace->srcdev->devid,
>> 						    &mirror_num,
>> 					    &physical_to_patch_in_first_stripe);
>> 		patch_the_first_stripe_for_dev_replace = 1;
>> 	}
>>
>> Thus if we're repairing the replace target device, we're going to
>> triggere that BUG_ON().
>>
>> But in reality, the read failure from the replace target device may be that,
>> our replace haven't reach the range we're reading, thus we're reading
>> garbage, but with replace running, the range would be properly filled
>> later.
>>
>> Thus in that case, we don't need to do anything but let the replace
>> routine to handle it.
>>
>> [FIX]
>> Instead of a BUG_ON(), just skip the repair if we're repairing the
>> device replace target device.
>>
>> Reported-by: 小太 <nospam@kota.moe>
>> Link: https://lore.kernel.org/linux-btrfs/CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index b8fb7ef6b520..444e20b15e26 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -329,7 +329,16 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>>   				      &map_length, &bioc, mirror_num);
>>   		if (ret)
>>   			goto out_counter_dec;
>> -		BUG_ON(mirror_num != bioc->mirror_num);
>> +		/*
>> +		 * This happens when dev-replace is also happening, and
>> +		 * the mirror_num indicates the dev-replace target.
>> +		 *
>> +		 * In this case, we don't need to do anything, as the read
>> +		 * error just means the replace progress hasn't reached our
>> +		 * read range, and later replace routine would handle it well.
>> +		 */
>> +		if (mirror_num != bioc->mirror_num)
>> +			goto out_counter_dec;
>>   	}
>>   
>>   	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
>> -- 
>> 2.39.0
> 
> 
