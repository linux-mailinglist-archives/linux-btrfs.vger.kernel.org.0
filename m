Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F036865BC85
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjACIza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 03:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjACIz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 03:55:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB46392
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 00:55:27 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1oapLj3L5d-00gF8P; Tue, 03
 Jan 2023 09:55:19 +0100
Message-ID: <85b489b6-565b-ddd3-f527-3f63054d7ee3@gmx.com>
Date:   Tue, 3 Jan 2023 16:55:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
 <4a708562-b91f-636b-f8ae-388ab2c14859@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4a708562-b91f-636b-f8ae-388ab2c14859@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dJpETn2Yrivbsop4Iclx8BGCnsinB9eiz+ubFkaftm+oJ1zPtbT
 K+HIio5VAY5Eto3TrBy6uuGIhA9nE6pYF/UWUS7W1IvyoLNHVdycVkhZnAxW/w1Eye8Uf/m
 EpStrPOZLPHjrY2IdCVRV4eoLa2sTsH2bXlaiYM4NW8piu0PdY1zVC8jDPQiI83x9a85L1h
 DO65Ph2ttvW2bDjVU8jUg==
UI-OutboundReport: notjunk:1;M01:P0:MmwCVksIebE=;O9aPeG9dkTYYLMDStVNlRoZzYTL
 YMa9Fnl+D9G0l9JByAh2O7g/evTdCFGZjCYr/6ssTDFDhW5fk98HrhV09ICfCdhlQhmUci5BR
 0mN4sW+DQZ9Qf86intNZQyaz+jpEOpvmWLawXsGBcWe+DuiDK0nu5IG+ljj3Qx4LXh6MP8ghU
 D0ccARWyQrWApZliCLBY37SQQhH0CLLY7lZJGYczjW6n4gqh1JD/melQGSlpcxwMuDDeq9FZW
 6AxtriwpWxRjnXail3cFp6twWiH1/UWg3+xn5UB9ZqPJsp+b6D8uNekWNz4rT3ML5ZMcGYLbu
 jCrhseheSFoqV22djYo2QvmG9H/sL02lNyiIajNY/RcMNALvQqwskb57eQPzXTa/XvZvXgp7x
 lghVKjgvpLFLY8jFHXY+0JEPbNm2WzlNrk+4ZmOhsA6CcF8HwsR3leSZo9pG8EvikUO7ymXwS
 bbbiS7ahBiTMeyJQrGQ7eBa3jXk0dOvGXKJdEtbOfGVKBJXpcPPAF6SN+W2SvwOX6FeExePY7
 6TIKHo5N2aDs/7zn6JjfGN6yYhnH/LwqGPzv1yfW5ZoxGe8wpfHPLBbP8UbXZaEg+cPPV9mD6
 5R40wiGavbDEHtlTyVaYPF/WNZQBYgFSgO4ocJtWmXRPPVPDg3xWAMXGJUV+hjqo08CF4bdhZ
 rnx31n35bIl/F+uSMvjqLFIPkGOtsOeNUAWfprZ5VUYrrzb6pQ3tyLbufO6W1lMYq0ca8PkGs
 F0SLPDuve/aG+rfix7OfFuWqChrfrwaTHBRPSqJ1H6D/WVQRxN/v/nF3X8kqh0EmW1FekFmkr
 7OlTYsj/Dj5v8De6HnN++1S9unA8YfYOq3eJhLKXG513Ny4IlBatR6RgFuXXHJ+gNYQnz0YaL
 38TXDgLivMiZE/cOc0dbUVHXdWAS3cMdwcBMZgIBFMMursqcmv+iWEIFyKA0Va0qZe1DjFcvB
 kNoXSIbg3k6gsIrZr3wGlW8r8jU=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/3 16:29, Anand Jain wrote:
> On 1/1/23 09:02, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
>> (originally repair_io_failure() in v6.0 kernel) got triggered when
>> replacing a unreliable disk:
>>
>>   BTRFS warning (device sda1): csum failed root 257 ino 2397453 off 
>> 39624704 csum 0xb0d18c75 expected csum 0x4dae9c5e mirror 3
>>   kernel BUG at fs/btrfs/extent_io.c:2380!
>>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 9 PID: 3614331 Comm: kworker/u257:2 Tainted: G           
>> OE      6.0.0-5-amd64 #1  Debian 6.0.10-2
>>   Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40 PRO 
>> WIFI (MS-7C60), BIOS 2.70 07/01/2021
>>   Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>>   RIP: 0010:repair_io_failure+0x24a/0x260 [btrfs]
>>   Call Trace:
>>    <TASK>
>>    clean_io_failure+0x14d/0x180 [btrfs]
>>    end_bio_extent_readpage+0x412/0x6e0 [btrfs]
>>    ? __switch_to+0x106/0x420
>>    process_one_work+0x1c7/0x380
>>    worker_thread+0x4d/0x380
>>    ? rescuer_thread+0x3a0/0x3a0
>>    kthread+0xe9/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x22/0x30
>>    </TASK>
>>
> 
> 
>> [CAUSE]
>>
>> Before the BUG_ON(), we got some read errors from the replace target
>> first, note the mirror number (3, which is beyond RAID1 duplication,
>> thus it's read from the replace target device).
>>
>> Then at the BUG_ON() location, we are trying to writeback the repaired
>> sectors back the failed device.
> 
> s/failed device/replace target
> 
> makes it consistnt with the para before.
> 
> 
>>
>> The check looks like this:
>>
>>         ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
>>                       &map_length, &bioc, mirror_num);
>>         if (ret)
>>             goto out_counter_dec;
>>         BUG_ON(mirror_num != bioc->mirror_num);
>>
>> But inside btrfs_map_block(), we can modify bioc->mirror_num especially
>> for dev-replace:
>>
>>     if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
>>         !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
>>         ret = get_extra_mirror_from_replace(fs_info, logical, *length,
>>                             dev_replace->srcdev->devid,
>>                             &mirror_num,
>>                         &physical_to_patch_in_first_stripe);
>>         patch_the_first_stripe_for_dev_replace = 1;
>>     }
>>
>> Thus if we're repairing the replace target device, we're going to
>> triggere that BUG_ON().
>>
> 
> 
>> But in reality, the read failure from the replace target device may be 
>> that,
>> our replace haven't reach the range we're reading, thus we're reading
>> garbage, but with replace running, the range would be properly filled
>> later.
> 
> Although we write good data later, I am not sure if it is acceptable to 
> read from the unfinished replace target (devid 0) in the first place. Do 
> you have any ideas?

This is a optimistic "optimization" to enlarge our chance to get the 
good data.

It can only happen for a very limited case, that we just replaced some 
data of the source device, then the device itself gone dead or had some 
problems.

If we don't allow reading from the target device, then any read on that 
range would fail, even if we have the good copy on the target device.

I'm not that confident about the chance. Yes it can help for replacing 
unreliable disks.

But if that unreliable disk is our only copy, then we're in a much 
bigger problem.

So if you want completely remote the ability to read from replace target 
device, I'm mostly fine with that.

Thanks,
Qu

> 
> Thanks,
> Anand
> 
>> Thus in that case, we don't need to do anything but let the replace
>> routine to handle it.
>>
>> [FIX]
>> Instead of a BUG_ON(), just skip the repair if we're repairing the
>> device replace target device.
>>
>> Reported-by: 小太 <nospam@kota.moe>
>> Link: 
>> https://lore.kernel.org/linux-btrfs/CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index b8fb7ef6b520..444e20b15e26 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -329,7 +329,16 @@ int btrfs_repair_io_failure(struct btrfs_fs_info 
>> *fs_info, u64 ino, u64 start,
>>                         &map_length, &bioc, mirror_num);
>>           if (ret)
>>               goto out_counter_dec;
>> -        BUG_ON(mirror_num != bioc->mirror_num);
>> +        /*
>> +         * This happens when dev-replace is also happening, and
>> +         * the mirror_num indicates the dev-replace target.
>> +         *
>> +         * In this case, we don't need to do anything, as the read
>> +         * error just means the replace progress hasn't reached our
>> +         * read range, and later replace routine would handle it well.
>> +         */
>> +        if (mirror_num != bioc->mirror_num)
>> +            goto out_counter_dec;
>>       }
>>       sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
> 
