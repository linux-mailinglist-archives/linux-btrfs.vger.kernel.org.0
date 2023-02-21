Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237F69E588
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjBURHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBURHw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 12:07:52 -0500
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50135A7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 09:07:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1424240337;
        Tue, 21 Feb 2023 18:07:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.99
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OnqzfZb2F1Sm; Tue, 21 Feb 2023 18:07:46 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0962840300;
        Tue, 21 Feb 2023 18:07:45 +0100 (CET)
Received: from [192.168.0.122] (port=51758)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pUW7F-000Oai-BR; Tue, 21 Feb 2023 18:07:45 +0100
Message-ID: <571c5253-5368-e453-42d1-00f44d2a1709@tnonline.net>
Date:   Tue, 21 Feb 2023 18:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Automatic block group reclaim not working as expected?
Content-Language: sv-SE
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <e99483.c11a58d.1863591ca52@tnonline.net>
 <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com>
 <2563c87.c11a58e.18636bcdf0b@tnonline.net>
 <31bf44b.fe8fe284.1863749a10f@tnonline.net>
 <f6e2f95e-0892-f82b-43fa-34ef32f19320@wdc.com>
 <b19674f0-0743-4e34-df85-ba6c458af01c@tnonline.net>
 <73b49250-8aaf-bbb7-92c6-73e0ad3d707b@tnonline.net>
 <60d348db-822b-c337-4c4d-edb06094302b@wdc.com>
 <3a6e20d9-2fc0-840a-18fd-e604f65d6d7e@wdc.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <3a6e20d9-2fc0-840a-18fd-e604f65d6d7e@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2023-02-21 17:25, Johannes Thumshirn wrote:
> On 14.02.23 15:32, Johannes Thumshirn wrote:
>> On 14.02.23 08:42, Forza wrote:
>> [snip]
>>
>>> Ihave set bg_reclaim_threshold to 75 and managed to catch one  :)
>>>
>>>
>>> dmesg:
>>> ----------
>>> [45412.900177] BTRFS info (device sdi1): reclaiming chunk 50169828278272
>>> with 293% used 0% unusable
>>> [45412.900214] BTRFS info (device sdi1): relocating block group
>>> 50169828278272 flags data|raid10
>>
>> [snip]
>>
>>> tracing:
>>> ----------------------
>>>
>>> # tracer: nop
>>> #
>>> # entries-in-buffer/entries-written: 12/12   #P:6
>>> #
>>> #                                _-----=> irqs-off/BH-disabled
>>> #                               / _----=> need-resched
>>> #                              | / _---=> hardirq/softirq
>>> #                              || / _--=> preempt-depth
>>> #                              ||| / _-=> migrate-disable
>>> #                              |||| /     delay
>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>> #              | |         |   |||||     |         |
>>>      kworker/u12:6-31740   [003] ..... 45412.981634:
>>> btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg
>>> bytenr=50169828278272 len=5368709120 used=3149168640 flags=65(DATA|RAID10)
>>
>> Just looking at this one used/len*100 should be ~58, not 293.
>>
>> Wild guess can you try this patch (compile tested only):
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 5b10401d803b..a17712429fc3 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1836,7 +1836,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>>   
>>                  btrfs_info(fs_info,
>>                          "reclaiming chunk %llu with %llu%% used %llu%% unusable",
>> -                               bg->start, div_u64(bg->used * 100, bg->length),
>> +                               bg->start, div64_u64(bg->used * 100, bg->length),
>>                                  div64_u64(zone_unusable * 100, bg->length));
>>                  trace_btrfs_reclaim_block_group(bg);
>>                  ret = btrfs_relocate_chunk(fs_info, bg->start);
>>
>>
> s
> ping?

pong... :)

I have so far, since applying the patch, not seen >100% reported.

Is the problem that `len=5368709120` is larger than a 32bit value?

kworker/u12:6-26888   [004] ..... 430948.069356: 
btrfs_reclaim_block_group: 7745e2f7-5c67-4b18-844b-8e93399f7b0b: bg 
bytenr=39886535720960 len=5368709120 used=5149954048 flags=65(DATA|RAID10)



Another reflection. Is bg_reclaim_threshold a 'hard' value? I see lots 
of larger chunks (over 75%) being balanced:

[430761.347844] BTRFS info (device sdi1): reclaiming chunk 
39596625428480 with 85% used 0% unusable
[430761.347904] BTRFS info (device sdi1): relocating block group 
39596625428480 flags data|raid10
[430778.847946] BTRFS info (device sdi1): found 2139 extents, stage: 
move data extents
[430894.992628] BTRFS info (device sdi1): found 2139 extents, stage: 
update data pointers
[430947.989068] BTRFS info (device sdi1): reclaiming chunk 
39886535720960 with 95% used 0% unusable
[430947.989082] BTRFS info (device sdi1): relocating block group 
39886535720960 flags data|raid10
[430969.596876] BTRFS info (device sdi1): found 9295 extents, stage: 
move data extents
[431252.173230] BTRFS info (device sdi1): found 9295 extents, stage: 
update data pointers
[431303.210776] BTRFS info (device sdi1): reclaiming chunk 
39908010557440 with 98% used 0% unusable
[431303.210836] BTRFS info (device sdi1): relocating block group 
39908010557440 flags data|raid10
[431324.379627] BTRFS info (device sdi1): found 8687 extents, stage: 
move data extents
[431567.460620] BTRFS info (device sdi1): found 8687 extents, stage: 
update data pointers

[435989.284542] BTRFS info (device sdi1): reclaiming chunk 
51800842108928 with 92% used 0% unusable
[435989.284558] BTRFS info (device sdi1): relocating block group 
51800842108928 flags metadata|raid1c3
[436135.871967] BTRFS info (device sdi1): found 57015 extents, stage: 
move data extents

[444799.968257] BTRFS info (device sdi1): reclaiming chunk 
51807284559872 with 96% used 0% unusable
[444799.968271] BTRFS info (device sdi1): relocating block group 
51807284559872 flags metadata|raid1c3
[444941.009353] BTRFS info (device sdi1): found 57879 extents, stage: 
move data extents
