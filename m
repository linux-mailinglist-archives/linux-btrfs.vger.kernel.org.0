Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8864695ABE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 08:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBNHmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 02:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNHmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 02:42:01 -0500
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2421A943
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 23:41:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D13193F3BB;
        Tue, 14 Feb 2023 08:41:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.247
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kqWiSGNjk89z; Tue, 14 Feb 2023 08:41:55 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 874043F39B;
        Tue, 14 Feb 2023 08:41:55 +0100 (CET)
Received: from 90-224-97-87-no521.tbcn.telia.com ([90.224.97.87]:44022 helo=[192.168.1.18])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pRpwo-000Dfr-AM; Tue, 14 Feb 2023 08:41:54 +0100
Message-ID: <73b49250-8aaf-bbb7-92c6-73e0ad3d707b@tnonline.net>
Date:   Tue, 14 Feb 2023 08:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Automatic block group reclaim not working as expected?
From:   Forza <forza@tnonline.net>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <e99483.c11a58d.1863591ca52@tnonline.net>
 <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com>
 <2563c87.c11a58e.18636bcdf0b@tnonline.net>
 <31bf44b.fe8fe284.1863749a10f@tnonline.net>
 <f6e2f95e-0892-f82b-43fa-34ef32f19320@wdc.com>
 <b19674f0-0743-4e34-df85-ba6c458af01c@tnonline.net>
Content-Language: sv-SE
In-Reply-To: <b19674f0-0743-4e34-df85-ba6c458af01c@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-02-10 16:14, Forza wrote:
> 
> 
> On 2023-02-10 11:27, Johannes Thumshirn wrote:
>> On 09.02.23 18:47, Forza wrote:
>>>
>>>
>>> ---- From: Forza <forza@tnonline.net> -- Sent: 2023-02-09 - 16:13 ----
>>>
>>>>
>>>>
>>>> ---- From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com> -- Sent: 
>>>> 2023-02-09 - 11:36 ----
>>>>
>>>>> On 09.02.23 11:02, Forza wrote:
>>>>>> I have set set 
>>>>>> /sys/fs/btrfs/<uuid>/allocation/data/bg_reclaim_threshold to 75
>>>>>>
>>>>>> It seems that the calculation isn't correct as I can see chunks 
>>>>>> with 300-400% usage in dmesg, which obviously seems wrong.
>>>>>>
>>>>>> The filesystem is a raid10 with 10 devices.
>>>>>>
>>>>>> dmesg:
>>>>>> [865863.062502] BTRFS info (device sdi1): reclaiming chunk 
>>>>>> 35605527068672 with 369% used 0% unusable
>>>>>> [865863.062552] BTRFS info (device sdi1): relocating block group 
>>>>>> 35605527068672 flags data|raid10
>>>>>> [865892.749204] BTRFS info (device sdi1): found 5729 extents, 
>>>>>> stage: move data extents
>>>>>> [866217.588422] BTRFS info (device sdi1): found 5721 extents, 
>>>>>> stage: update data pointers
>>>>>>
>>>>>> I have tested with kernels 6.1.6 and 6.1.8
>>>>>>
>>>>>
>>>>> Ooops this indeed is not what it should be.
>>>>>
>>>>> Can you re-test with the 'btrfs_reclaim_block_group' tracepoint 
>>>>> enabled,
>>>>> so I can see the raw values of the block group's length and used?
>>>>
>>>> I dont have this option in sysfs. Do I need to enable some 
>>>> additional settings in the kernel for this?
>>>>
>>>> Current kernel has the following config:
>>>>
>>>> # grep -i btrfs .config
>>>> CONFIG_BTRFS_FS=y
>>>> CONFIG_BTRFS_FS_POSIX_ACL=y
>>>> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
>>>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>>>> # CONFIG_BTRFS_DEBUG is not set
>>>> # CONFIG_BTRFS_ASSERT is not set
>>>> # CONFIG_BTRFS_FS_REF_VERIFY is not set
>>>>
>>>>
>>>
>>> I compiled kernel with debug enabled.
>>>
>>> Is it enough to do `echo 1 > 
>>> /sys/kernel/debug/tracing/events/btrfs/btrfs_reclaim_block_group/enable`, or do i need to set the `trigger` to some value too?
>>>
>>
>> Should be:
>> echo 1 > 
>> /sys/kernel/debug/tracing/events/btrfs/btrfs_reclaim_block_group/enable
>> echo 1 > /sys/kernel/debug/tracing/tracing_on
>>
>> somehow trigger reclaim
>>
>> and then
>>
>> cat sys/kernel/debug/tracing/trace
>>
>> Thanks,
>>     Johannes
> 
> Haven't manage to get the >100% ones yet, but I will look more next week 
> when I am back at work.
> 
> dmesg:
> 
> [50980.657844] BTRFS info (device sdc2): reclaiming chunk 2485742731264 
> with 74% used 0% unusable
> [50980.657927] BTRFS info (device sdc2): relocating block group 
> 2485742731264 flags data
> [51008.031986] BTRFS info (device sdc2): found 8097 extents, stage: move 
> data extents
> [51055.649586] BTRFS info (device sdc2): found 8097 extents, stage: 
> update data pointers
> [60601.571226] BTRFS info (device sdb2): reclaiming chunk 66017015365632 
> with 98% used 0% unusable
> [60601.582746] BTRFS info (device sdb2): relocating block group 
> 66017015365632 flags data
> [60632.930377] BTRFS info (device sdb2): found 4070 extents, stage: move 
> data extents
> [60782.286035] BTRFS info (device sdb2): found 4070 extents, stage: 
> update data pointers
> [78375.176713] BTRFS info (device sdb2): reclaiming chunk 96415921471488 
> with 0% used 0% unusable
> [78375.176779] BTRFS info (device sdb2): relocating block group 
> 96415921471488 flags data
> [78375.406347] BTRFS info (device sdb2): reclaiming chunk 96428806373376 
> with 0% used 0% unusable
> [78375.406398] BTRFS info (device sdb2): relocating block group 
> 96428806373376 flags data
> [78375.501360] BTRFS info (device sdb2): reclaiming chunk 66145864384512 
> with 99% used 0% unusable
> [78375.501398] BTRFS info (device sdb2): relocating block group 
> 66145864384512 flags data
> [78393.584698] BTRFS info (device sdb2): found 50 extents, stage: move 
> data extents
> [78401.199793] BTRFS info (device sdb2): found 50 extents, stage: update 
> data pointers
> [78403.553151] BTRFS info (device sdb2): reclaiming chunk 69387490951168 
> with 99% used 0% unusable
> [78403.553183] BTRFS info (device sdb2): relocating block group 
> 69387490951168 flags data
> [78435.332028] BTRFS info (device sdb2): found 658 extents, stage: move 
> data extents
> [78460.180391] BTRFS info (device sdb2): found 658 extents, stage: 
> update data pointers
> [78470.858137] BTRFS info (device sdb2): reclaiming chunk 69753636913152 
> with 99% used 0% unusable
> [78470.858174] BTRFS info (device sdb2): relocating block group 
> 69753636913152 flags data
> [78499.882793] BTRFS info (device sdb2): found 19 extents, stage: move 
> data extents
> [78508.856826] BTRFS info (device sdb2): found 19 extents, stage: update 
> data pointers
> [78512.826989] BTRFS info (device sdb2): reclaiming chunk 67397847351296 
> with 99% used 0% unusable
> [78512.827025] BTRFS info (device sdb2): relocating block group 
> 67397847351296 flags data
> [78546.276209] BTRFS info (device sdb2): found 725 extents, stage: move 
> data extents
> [78595.114415] BTRFS info (device sdb2): found 725 extents, stage: 
> update data pointers
> [78604.856461] BTRFS info (device sdb2): reclaiming chunk 67517032693760 
> with 99% used 0% unusable
> [78604.856495] BTRFS info (device sdb2): relocating block group 
> 67517032693760 flags data
> [78622.988461] BTRFS info (device sdb2): found 170 extents, stage: move 
> data extents
> [78642.777262] BTRFS info (device sdb2): found 170 extents, stage: 
> update data pointers
> 
> 
> trace:
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 348250/12869128   #P:4
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>    kworker/u32:6-18902   [001] ..... 50980.661498: 
> btrfs_reclaim_block_group: aa358efb-ce43-498c-9997-0d35ba13261f: bg 
> bytenr=2485742731264 len=1073741824 used=803196928 flags=1(DATA)
>     kworker/u32:3-32378   [003] ..... 60601.574878: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=66017015365632 len=1073741824 used=1059209216 flags=1(DATA)
>    kworker/u32:16-74472   [000] ..... 78375.180368: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=96415921471488 len=1073741824 used=0 flags=1(DATA)
>    kworker/u32:16-74472   [000] ..... 78375.410000: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=96428806373376 len=1073741824 used=0 flags=1(DATA)
>    kworker/u32:16-74472   [002] ..... 78375.505014: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=66145864384512 len=1073741824 used=1073545216 flags=1(DATA)
>    kworker/u32:16-74472   [002] ..... 78403.556805: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=69387490951168 len=1073741824 used=1073709056 flags=1(DATA)
>    kworker/u32:16-74472   [003] ..... 78470.861792: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=69753636913152 len=1073741824 used=1073709056 flags=1(DATA)
>    kworker/u32:16-74472   [000] ..... 78512.830644: 
> btrfs_reclaim_block_group: fe0a1142-51ab-4181-b635-adbf9f4ea6e6: bg 
> bytenr=67397847351296 len=1073741824 used=1073725440 flags=1(DATA)
> btrfs-trace.txt lines 348220-348265/348265 (END)
> 
> 
> 


Ihave set bg_reclaim_threshold to 75 and managed to catch one  :)


dmesg:
----------
[45412.900177] BTRFS info (device sdi1): reclaiming chunk 50169828278272 
with 293% used 0% unusable
[45412.900214] BTRFS info (device sdi1): relocating block group 
50169828278272 flags data|raid10
[45438.476880] BTRFS info (device sdi1): found 21702 extents, stage: 
move data extents
[45471.528579] BTRFS info (device sdi1): found 21702 extents, stage: 
update data pointers
[55858.686193] hrtimer: interrupt took 2678 ns
[56476.929128] BTRFS info (device sdo1): reclaiming chunk 3602518114304 
with 74% used 0% unusable
[56476.929153] BTRFS info (device sdo1): relocating block group 
3602518114304 flags metadata|raid10
[56513.141431] BTRFS info (device sdo1): found 49489 extents, stage: 
move data extents
[56518.110654] BTRFS info (device sdo1): reclaiming chunk 3601427595264 
with 73% used 0% unusable
[56518.110674] BTRFS info (device sdo1): relocating block group 
3601427595264 flags metadata|raid10
[56548.334748] BTRFS info (device sdo1): found 48755 extents, stage: 
move data extents
[56554.632139] BTRFS info (device sdo1): reclaiming chunk 5116661858304 
with 49% used 0% unusable
[56554.632151] BTRFS info (device sdo1): relocating block group 
5116661858304 flags metadata|raid10
[56561.724299] BTRFS info (device sdo1): found 30694 extents, stage: 
move data extents
[58195.122409] BTRFS info (device sdi1): reclaiming chunk 37744420782080 
with 297% used 0% unusable
[58195.122438] BTRFS info (device sdi1): relocating block group 
37744420782080 flags data|raid10
[58219.805152] BTRFS info (device sdi1): found 4029 extents, stage: move 
data extents
[58578.020702] BTRFS info (device sdi1): found 4029 extents, stage: 
update data pointers
[58673.387957] BTRFS info (device sdi1): reclaiming chunk 37749789491200 
with 490% used 0% unusable
[58673.387983] BTRFS info (device sdi1): relocating block group 
37749789491200 flags data|raid10
[58699.592758] BTRFS info (device sdi1): found 1244 extents, stage: move 
data extents
[59081.163605] BTRFS info (device sdi1): found 1244 extents, stage: 
update data pointers
[59154.440137] BTRFS info (device sdi1): reclaiming chunk 51182366818304 
with 72% used 0% unusable
[59154.440188] BTRFS info (device sdi1): relocating block group 
51182366818304 flags metadata|raid1c3
[59266.993566] BTRFS info (device sdi1): found 46958 extents, stage: 
move data extents
[59320.787842] BTRFS info (device sdi1): reclaiming chunk 51183440560128 
with 28% used 0% unusable
[59320.787897] BTRFS info (device sdi1): relocating block group 
51183440560128 flags metadata|raid1c3
[59454.701168] BTRFS info (device sdi1): found 18508 extents, stage: 
move data extents
[61728.296989] BTRFS info (device sdo1): reclaiming chunk 5117752377344 
with 75% used 0% unusable
[61728.297055] BTRFS info (device sdo1): relocating block group 
5117752377344 flags metadata|raid10
[61737.166476] BTRFS info (device sdo1): found 48496 extents, stage: 
move data extents
[61742.073009] BTRFS info (device sdo1): reclaiming chunk 5118842896384 
with 59% used 0% unusable
[61742.073029] BTRFS info (device sdo1): relocating block group 
5118842896384 flags metadata|raid10
[61747.052596] BTRFS info (device sdo1): found 38359 extents, stage: 
move data extents
[66707.867350] BTRFS info (device sdi1): reclaiming chunk 51182366818304 
with 72% used 0% unusable
[66707.867376] BTRFS info (device sdi1): relocating block group 
51182366818304 flags metadata|raid1c3
[66807.004091] BTRFS info (device sdi1): found 46109 extents, stage: 
move data extents
[67821.012552] BTRFS info (device sdo1): reclaiming chunk 5119933415424 
with 75% used 0% unusable
[67821.012609] BTRFS info (device sdo1): relocating block group 
5119933415424 flags metadata|raid10
[67829.396295] BTRFS info (device sdo1): found 48949 extents, stage: 
move data extents



tracing:
----------------------

# tracer: nop
#
# entries-in-buffer/entries-written: 12/12   #P:6
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    kworker/u12:6-31740   [003] ..... 45412.981634: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=50169828278272 len=5368709120 used=3149168640 flags=65(DATA|RAID10)
    kworker/u12:2-4866    [002] ..... 56477.010584: 
btrfs_reclaim_block_group: d34c187e-c57d-44b9-ac08-203bbe00a56a: bg 
bytenr=3602518114304 len=1090519040 used=817528832 flags=68(METADATA|RAID10)
    kworker/u12:2-4866    [002] ..... 56518.192113: 
btrfs_reclaim_block_group: d34c187e-c57d-44b9-ac08-203bbe00a56a: bg 
bytenr=3601427595264 len=1090519040 used=799031296 flags=68(METADATA|RAID10)
    kworker/u12:2-4866    [001] ..... 56554.713595: 
btrfs_reclaim_block_group: d34c187e-c57d-44b9-ac08-203bbe00a56a: bg 
bytenr=5116661858304 len=1090519040 used=542162944 flags=68(METADATA|RAID10)
    kworker/u12:0-6401    [003] ..... 58195.203865: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=37744420782080 len=5368709120 used=3189420032 flags=65(DATA|RAID10)
    kworker/u12:0-6401    [001] ..... 58673.469418: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=37749789491200 len=5368709120 used=5265637376 flags=65(DATA|RAID10)
    kworker/u12:0-6401    [004] ..... 59154.521605: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=51182366818304 len=1073741824 used=776749056 
flags=516(METADATA|0x200)
    kworker/u12:0-6401    [005] ..... 59320.869311: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=51183440560128 len=1073741824 used=306151424 
flags=516(METADATA|0x200)
   kworker/u12:15-24812   [001] ..... 61728.378446: 
btrfs_reclaim_block_group: d34c187e-c57d-44b9-ac08-203bbe00a56a: bg 
bytenr=5117752377344 len=1090519040 used=826523648 flags=68(METADATA|RAID10)
   kworker/u12:15-24812   [003] ..... 61742.154469: 
btrfs_reclaim_block_group: d34c187e-c57d-44b9-ac08-203bbe00a56a: bg 
bytenr=5118842896384 len=1090519040 used=650428416 flags=68(METADATA|RAID10)
   kworker/u12:15-9561    [002] ..... 66707.948806: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=51182366818304 len=1073741824 used=776273920 
flags=516(METADATA|0x200)
    kworker/u12:5-5854    [002] ..... 67821.094022: 
btrfs_reclaim_block_group: d34c187e-c57d-44b9-ac08-203bbe00a56a: bg 
bytenr=5119933415424 len=1090519040 used=819445760 flags=68(METADATA|RAID10)
