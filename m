Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20926E3656
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDPI5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDPI5A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 04:57:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7369F103
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 01:56:56 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1poWgd2QB4-001fhc; Sun, 16
 Apr 2023 10:56:54 +0200
Message-ID: <4adbf458-97ac-535c-cd26-2f1f724cf5d3@gmx.com>
Date:   Sun, 16 Apr 2023 16:56:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Torstein Eide <torsteine@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
 <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
 <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
 <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com>
 <CAL5DHTEYeEXLrV0+=d2wsYpxZvW2+Ku61CC3hLFNOUtOMTxi2A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: scrub/balance a specif LBA range
In-Reply-To: <CAL5DHTEYeEXLrV0+=d2wsYpxZvW2+Ku61CC3hLFNOUtOMTxi2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cX6+Ii4mkOdqaaPmKFafFJcX20QcCWjrh4QFILAqCmodKgzHPI2
 lY1IrcF5LB9N9j3YjgkI4+yFcj6JZk/bgV1V0W5n00J5yDeqpsUJhkuqWdjjXB0ZvXbg5bO
 BqZzYITpnV+dP8UW9CYQhw36gMzLYymEADODa8a6ZlVq19tZ/1JClKm3m5nctm+2J833x4k
 WLUp7fykmIaLzGeRsM75Q==
UI-OutboundReport: notjunk:1;M01:P0:bOr2uSokl3U=;lwx7l+Wuc1I9jycQzlJozhkI1YC
 hoIIPilnocKNa+3oicEPSX359TWGktVC0PGY9+Z5PWEW/sY/5hqLBA3xvF14xbpIbIE4JGhKx
 HlqqiO0ykoCYFm25JJ+F06IyMGHnP/9JJPrdKsNY8nOBOYRIWBlQnokK9oYjo+Z7zmy78rO/t
 uQuf7XqcJE7CjHhLrfTWki71TWKTEd5LadZBmbg6Pgl0fcFWsS+k7ELRN/zoV92od9X2/jpWL
 WJUTyRzfamXIrUF6b+hg97jRzly8uZGa9A6ivKqgS1oRN3b52CmFIIOwOq3QQDGPG5Pcep0Li
 KK1LvPo5D4+ziKus9hFg9OMBOVynLy3wcDl8wVRbl0pAKQYa+g8/DdHLuhbNZBpdO1r1i6kyD
 rLBxHpzZLwnDciOaI/SBMM3s4xM/eC/cWw4tT87eh69ytGeeEI5PvYBEvaMEYXc4H62Keyoon
 uAglZJYIA9TPEGfX5iXUHSvAsvvCKfTgHS4L7MQbgZCZXt2zM4+RmaTolsThPjT9WuLs2Ydha
 ywNdhua6cGKgao7v0Bfv0s0Hp6sPFGLD/Lb8Jd7tVeHBWydJaooChtzC/J4R1lk5KL9i5Co5A
 JyBlAsefN765sQw3g+1TptPevF6J2FMbl8Hkko3DCqrHUq5OOybfSWmo43yMkGE+J6fZGopAe
 27MKh4BMwRY79+9wWpnIGHMcv0AnTIoWANk4wQy2OHpQZ02/Qjm6OcAGxfD1jG8A+OC8RODvB
 vJyDWIIz7S1NNHnWmBVKpKAH442ir/7kzqu68EH2lADEAEXCR0ttFUzYfvS86+3fOwY8nBYZa
 dWtIp1qiOq3U4tVLaBQcSFKonhjwHAe4SljgoWNsn2mNlH0B4UPj5JF+iefTuRT+BbwWecCRj
 keJfnRKExfIDh1ZVunHjQOLgE4uKN6xh63K5shXNieFoYXnTMqza7g07fpZAngul02OAd95rc
 mavrUaYGzcbOGjieDX9xDfPIV9M=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/16 16:36, Torstein Eide wrote:
> Qu, it must be frustrating to listen to me.
> I appreciate all the help you give both for me and my problems, and
> also your contribution to BTRFS.
> 
> Okay, I will try that.
> 
> 
> #btrfs filesystem usage -T -g /mnt/
> 
> Overall:
>      Device size:                       52160.13GiB
>      Device allocated:                  22114.09GiB
>      Device unallocated:                30046.04GiB
>      Device missing:                        0.00GiB
>      Used:                              19436.54GiB
>      Free (estimated):                  25711.53GiB      (min: 12082.50GiB)
>      Free (statfs, df):                 13766.30GiB
>      Data ratio:                               1.27
>      Metadata ratio:                           3.00
>      Global reserve:                        0.50GiB      (used: 0.00GiB)
>      Multiple profiles:                         yes      (data)
> 
>                  Data        Data       Metadata System
> Id Path         RAID5       RAID6      RAID1C3  RAID1C3 Unallocated
> -- ------------ ----------- ---------- -------- ------- -----------
>   1 /dev/loop101  2739.00GiB  339.00GiB        -       -  2511.03GiB
>   2 /dev/loop102  2882.00GiB  903.00GiB        -       -  1804.03GiB

Oh, indeed you really mean no other Meta/Sys chunks on that devid 2, and 
since you're really converting to RAID6, then your initial command is 
correct.

Although the LBA thing still needs the extra multiplication.

>   3 /dev/loop105  2882.00GiB  903.00GiB 31.00GiB       -  3636.04GiB
>   4 /dev/loop104  2882.00GiB  903.00GiB 31.00GiB 0.03GiB  3636.01GiB
>   5 /dev/loop106  2882.00GiB  903.00GiB 37.00GiB 0.03GiB  9216.97GiB
>   6 /dev/loop103  2882.00GiB  903.00GiB 12.00GiB 0.03GiB  9241.97GiB
> -- ------------ ----------- ---------- -------- ------- -----------
>     Total        14267.00GiB 3048.00GiB 37.00GiB 0.03GiB 30046.04GiB
>     Used         12106.80GiB 3029.00GiB 20.12GiB 0.00GiB
> 
> 
> 
> 
> #uname -a
> Linux ubuntu 5.19.0-32-generic #33~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
> Mon Jan 30 17:03:34 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> The Dmesg outputs the following:
> [ 5308.421903] BTRFS info (device loop101): balance: start
> -dconvert=raid6,soft,devid=1
> [ 5308.539366] BTRFS info (device loop101): relocating block group
> 93725670768640 flags data|raid5
> [ 5354.099960] btrfs_print_data_csum_error: 92 callbacks suppressed
> [ 5354.099963] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280235520 csum 0xb96d5c53 expected csum 0x040f4404 mirror 1
> [ 5354.099967] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
> [ 5354.099968] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105219, gen 0
> [ 5354.100015] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280239616 csum 0x90e00007 expected csum 0x3094a9df mirror 1
> [ 5354.100018] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105220, gen 0
> [ 5354.100026] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280243712 csum 0xbc290143 expected csum 0x734662fc mirror 1
> [ 5354.100029] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105221, gen 0
> [ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1
> [ 5354.100036] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105222, gen 0
> [ 5354.100043] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280251904 csum 0x34856001 expected csum 0x04a0ca74 mirror 1
> [ 5354.100045] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105223, gen 0
> [ 5354.100053] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280256000 csum 0x14fb4051 expected csum 0x7cd42005 mirror 1
> [ 5354.100056] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105224, gen 0
> [ 5354.100065] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280260096 csum 0x32870ab6 expected csum 0x52d34048 mirror 1
> [ 5354.100067] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105225, gen 0
> [ 5354.100076] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280264192 csum 0x4e089939 expected csum 0x0f56b841 mirror 1
> [ 5354.100079] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105226, gen 0
> [ 5354.100088] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280268288 csum 0xc9887e92 expected csum 0xae8d7cfd mirror 1
> [ 5354.100091] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105227, gen 0
> [ 5354.100100] BTRFS warning (device loop101): csum failed root -9 ino
> 1385 off 5280272384 csum 0x5425dba6 expected csum 0xa86edd67 mirror 1
> [ 5354.100102] BTRFS error (device loop101): bdev /dev/loop101 errs:
> wr 7172193, rd 64992, flush 58, corrupt 105228, gen 0
> [ 5356.447967] BTRFS info (device loop101): balance: ended with status: -5
> 
> Based on the Dmesg, there is nothing that says why it ended before all
> 2.7TiB was converted.

It shows the conversion failed due to unrecoverable data during balance.

But weirdly, the error only mentioned mirror 1 (directly read from 
disks), we should have an extra mirror for RAID5 (rebuild using parity), 
but it doesn't even seem to try rebuild.
(Or it rebuilds some but still some unrepairable?)

Considering the latest LTS is already v6.1, mind to try that kernel or 
the latest one, retry the same command and attach the dmesg for the 
newer kernel?

> 
> There is no output of what files are affected.

All my bad, I forgot relocation is doing a completely different error 
report than scrub.

> 
> My rationale for using convert is that I like to remove 2 devices that
> are failing, and since BTRFS currently don't support *remove flag*,
> like we talked about before. I am using convert to give me extra
> protection and options to disconnect the 2 devices, and do the `btrfs
> device remove` with *missing*.
> 
> 
> And it stops `btrfs device remove`, I like to continue removing or
> converting to Raid6. Since `btrfs device remove` does not take input,
> I am using balance as an alternative to work around the limitations of
> `btrfs device remove`.
> 
> 
> My point was:
> block group 1 (no errors, converted|moved successful)
> block group 2 (Single  (dual raid6) error, sometimes i continue to
> iterate over the groups, sometimes i ends to early, like above and
> below)
> block group 3 (dual  (tripel on raid6) error, )
> 
> Is there a way to tell BTRFS, while iterating blocks, if an
> unrecoverable block, print (or store for print at the end), and do the
> next block?

Unfortunately, as you have already experienced, it's not yet supported 
to output those helpful info during balance.

There is a way to get the offending files, but it's complex:

 > [ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
 > 1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1

In above error message, it shows it's offset 5280247808 inside the block 
group 93725670768640 causing the error.

You can convert the logical bytenr (93725670768640 + 5280247808) to 
filenames using "btrfs ins" subcommand:

  # btrfs ins logical-resolve 93730951016448 <mnt>


On the other hand, scrub is able to do error reporting much better, but 
it has its own problems related to RAID56 (slow perf if scrubbing the 
full fs, no support to only scrub certain blocks, bad error reporting 
for RAID56 P/Q stripes etc).

So unfortunately you're stuck in a very user-unfriendly situation...

But I'd recommend go newer kernel first to make sure the kernel is not 
doing something wrong first.

If possible, please also try scrub first for that devid 2, which has a 
much better error reporting.


And for us developers, we need to make the error reporting during 
balance much better first, then also enhance the error reporting during 
read-repair.

Thanks,
Qu

> 
> Dual error , on raid6, unsure why it failed (I did use the wrong filter):
> [ 1068.539127] BTRFS info (device loop101): balance: start
> -dconvert=raid5,soft,usage=70,devid=1
> [ 1068.546592] BTRFS info (device loop101): relocating block group
> 103315594543104 flags data|raid6
> [ 1068.855596] btrfs_print_data_csum_error: 91 callbacks suppressed
> [ 1068.855600] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror 1
> [ 1068.855607] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
> [ 1068.855608] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 52, gen 0
> [ 1068.855816] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror 1
> [ 1068.855821] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 53, gen 0
> [ 1068.855837] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror 1
> [ 1068.855840] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 54, gen 0
> [ 1068.855850] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403976192 csum 0x6207b5ba expected csum 0xd383f082 mirror 1
> [ 1068.855853] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 55, gen 0
> [ 1068.855860] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror
> **2**
> [ 1068.855863] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror
> **2**
> [ 1068.855964] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403980288 csum 0xd7b71b5b expected csum 0x7612c037 mirror 1
> [ 1068.855967] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 56, gen 0
> [ 1068.855976] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403984384 csum 0x60f71f94 expected csum 0x956a021b mirror 1
> [ 1068.855979] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 57, gen 0
> [ 1068.855980] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror
> **2**
> [ 1068.855989] BTRFS warning (device loop101): csum failed root -9 ino
> 1310 off 403988480 csum 0x613d06ef expected csum 0x75e3d8f4 mirror 1
> [ 1068.855992] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 58, gen 0
> [ 1068.856000] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 59, gen 0
> [ 1068.856008] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 60, gen 0
> [ 1068.856040] BTRFS error (device loop101): bdev /dev/loop102 errs:
> wr 0, rd 0, flush 0, corrupt 61, gen 0
> [ 1069.116491] BTRFS info (device loop101): balance: ended with status: -5
> 
> søn. 16. apr. 2023 kl. 09:38 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> On 2023/4/16 15:24, Torstein Eide wrote:
>>> The correct format is then:
>>>
>>> `btrfs balance start -v
>>> -ddevid=2,convert=raid6,drange=11454997800..11454997807` (convert
>>> force move, only data on that device)
>>> `btrfs balance start -v -ddevid=2,convert=raid6,drange=11455002752..11455002759`
>>
>> I guess that LBA is in 512 or 4K unit (because we're seeing unaligned
>> bytenr like 11454997807).
>>
>> So the proper range should need to be multiplied by 512 or 4096 based on
>> the block size of the device.
>>
>> Furthermore, if you're not doing convert, no need to specify convert=.
>>
>> And finally, you need to duplicate all the filters for metadata and
>> system, just in case those profiles are involved in the drange.
>>
>> So the full output would looks like something like this: (assuming 512
>> as block size)
>>
>> # btrfs balance start -ddevid=2,drange=5864958873600..5864958877695 \
>>                         -mdevid=2,drange=5864958873600..5864958877695 \
>>                         -sdevid=2,drange=5864958873600..5864958877695 \
>>                         <mnt>
>>>
>>> And so on?
>>>
>>> Since I believe one of the ranges is matched with a bad sector on a
>>> different device, can I tell BTRFS to, if failed work on the next
>>> block that is not dual failure?
>>
>> Sorry I didn't get your point.
>>
>> Balance would try its best to rebuild the data (as long as it's
>> checksumed), even there is a bad sector, btrfs can still detect and
>> rebuild the good data.
>>
>> And of course, if btrfs failed to rebuild a data matching the csum, it
>> would fail the balance.
>>
>> If you're concerned about that failure, in that case dmesg should output
>> which file is causing the problem, and you can delete the file and retry
>> the balance.
>>
>> Thanks,
>> Qu
>>
>>>
>>> søn. 16. apr. 2023 kl. 02:23 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>
>>>>
>>>>
>>>> On 2023/4/16 08:16, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2023/4/16 02:59, Torstein Eide wrote:
>>>>>> Hi
>>>>>> I have a disk with "Pending Sector remap".
>>>>>> That can be view with:
>>>>>>
>>>>>> ``smartctl -l defects  /dev/sdd``
>>>>>>
>>>>>> ````
>>>>>> Pending Defects log (GP Log 0x0c)
>>>>>> Index                LBA    Hours
>>>>>>        0        11454997800        -
>>>>>> ....
>>>>>>        7        11454997807        -
>>>>>>        8        11455002752        -
>>>>>> ....
>>>>>>       15        11455002759        -
>>>>>>       16        11464481352        -
>>>>>> ....
>>>>>>       31        11464486423        -
>>>>>>       32        11480702000        -
>>>>>> ....
>>>>>>        39        11480702007        -
>>>>>> ````
>>>>>>
>>>>>> Can I tell btrfs scrub or balance to move files on these locations?
>>>>>> I was thinking the balance `drange` may work but was unsure of the
>>>>>> correct format.
>>>>>
>>>>> You can use balance to only balance a logical range.
>>>>
>>>> s/logical/physical/
>>>>
>>>>>
>>>>> And it's indeed the drange option.
>>>>>
>>>>> Although you may need to specify the option for both metadata, data and
>>>>> system, or go --full-balance to make sure all chunks are covered.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
