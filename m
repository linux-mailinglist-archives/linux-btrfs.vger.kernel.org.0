Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4F6E3CDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 01:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDPXrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 19:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPXrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 19:47:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DB71FC6
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 16:47:31 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEV3C-1pZOFm3UOA-00FzdL; Mon, 17
 Apr 2023 01:47:29 +0200
Message-ID: <789e7082-9494-63c4-dcc3-5b522532e298@gmx.com>
Date:   Mon, 17 Apr 2023 07:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: scrub/balance a specif LBA range
To:     Torstein Eide <torsteine@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
 <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
 <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
 <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com>
 <CAL5DHTEYeEXLrV0+=d2wsYpxZvW2+Ku61CC3hLFNOUtOMTxi2A@mail.gmail.com>
 <4adbf458-97ac-535c-cd26-2f1f724cf5d3@gmx.com>
 <CAL5DHTHQp-8EvwwcjJRuZR90Tn9LnV6aQKVkkRfZi+dx+H203A@mail.gmail.com>
 <5640ce1f-b6ca-1060-f0b6-60851856374b@gmx.com>
 <CAL5DHTFAUCKBmW_j737j8dzRvaBnKWa9Wo5VtvoAgW8f93oR9A@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL5DHTFAUCKBmW_j737j8dzRvaBnKWa9Wo5VtvoAgW8f93oR9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fr6/o2Ltc3gTa+33NHUxKhSpgzcS6IAGNsYJ1CdvuxKF/KTey0U
 ci/cBgdg2liIpIpiR4REQbJI4MEixi/LD4ScvWzFYWov/9oWLvj0oM4WHz0kXB1UhXA+WLd
 KcviTIqeepWw6W2coFs8B8MIoD2Qke2LD1LHz/e/EeHM/Lfps/Rcj9oj0lEOrI1PgE/TJRw
 qE7TsHNc+aXtwLRinZSDw==
UI-OutboundReport: notjunk:1;M01:P0:O3e0S0CEZtk=;ZXGYsqsmgj7EyO6oUy1bYCIWZXy
 hhw0fHcpBjXow6msDiwqv2vVdGpM6+sHlUvH6K8wjzPUmcSvoS/3n5RLyuKPlgodpdo99kV6o
 /RYLm/8fuCPC9CNy/f+zb/3VRTZrIhHC7ZtvjPPzTP8fjiQtK5j7sQE+dlLk1aRxItIqZvSbg
 0vOjK0oqBAZmJujILqRBHbeKhriJW77UDHS2NCan1AarIfzxCQMJmvO9tL6WD2CsdzXHl/KIP
 NuocLvwU/xNzyPQ+R64eCjTTkFcKs+oqUO/1iaPbHiGVIWBT1LVmp380ENXdbYD3tti+r1TMI
 iEbgGuu5ifmYda4ecgkgAo/vm7HtNZwZo/D813cKPk0f7MObfjaF8MU0rzTawSZsMX11dPgak
 d4noQW12QbjhjdSadeVb1XvSVsHw9U9oaeREARcIoN0Z9x91G4tK1oM2IQc72DsXvNF1vFKgc
 L68/vD/16oOttTYWXZNl2xXuqibEMd3UUAq7pOu2SPJWPBLZyAEkdXXbPhMGAv0rpWqV+LvG9
 wpfzxDv4yW88weXLcc/QCEuV5YzhRhHbcjWKVgatzbWJWo2VAKqMxwb7klnz5kcNwgNyFfhqV
 IIzpQNEvHpfU0jy99ZNs6egFg307Y4zhpY/4ZopVU/P5/g3Qcy2Ipyno37sQ9usPgKmmcFpAd
 R6u+K+za2eWIFxvLLK3s9hwwVfHeLdFuCLvG3Ze6y0NtOLGBY4Ysh5kBJEA3OJpYPuUIznyco
 8G3w9ZJ4jeAaWHueV4S6mOlZrgh2cWArE7ZECu1J0S3+wAq+Y7Jb+rt1ICvwns0bDaIIY+KZX
 0BnU4ztw7+OpUkUusa/sQc2I9OtLtwYpieUN1h80ckMtibsPstVIImJ4hf28LC+e7jOl1YBDa
 4MuS7m8IU3r5lXqx132WErurbQSTu4SlOt0U/U3KZckz2W8bCKdqrZ9BvmEzdW51fTgMw3XdY
 O5mQG+J3s3Z6Owqp2Pfw3nfd9eY=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/16 21:03, Torstein Eide wrote:
> søn. 16. apr. 2023 kl. 13:53 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> On 2023/4/16 19:43, Torstein Eide wrote:
>>> #uname -a
>>> Linux sysrescue 6.1.20-1-lts  x86_64 GNU/Linux
>>>
>>>
>>> ````
>>> # btrfs device remove /dev/loop101 /mnt/volum1/
>>> ERROR: error removing device '/dev/loop101': Input/output error
>>> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
>>> WARNING:    Data: raid5, raid6
>>> ````
>>>
>>> ## Dmesg
>>> ````
>>> [ 2734.955532] BTRFS info (device loop101): relocating block group
>>> 103315594543104 flags data|raid6
>>> [ 2738.169941] btrfs_print_data_csum_error: 92 callbacks suppressed
>>> [ 2738.169950] BTRFS warning (device loop101): csum failed root -9 ino
>>> 275 off 940359680 csum 0x2b42e85b expected csum 0xea6c2bd2 mirror
>>> ````
>>>
>>> The output is  suppressed, so the fault that there is an error on the
>>> second and/ third disk is hidden.
>>> So there may need a third and a fourth error message, in Dmesg:
>>> nr3: Error: Was unable to so read  with integri block group XXX, with
>>> the following offsets ZZZ1, ZZ2
>>> nr4: Error: BTRFS $task, stop due  to inability to read with integri
>>> block. (until a options to skip is implemented)
>>>
>>> There may need to be an option to read a file with corruption_errs.
>>>
>>> [/dev/loop102].corruption_errs  56
>>> [/dev/loop103].corruption_errs  12
>>>
>>> ````
>>> # btrfs inspect-internal logical-resolve 93730951016448 volum1/
>>> inode 13386884 subvol @plexConfig could not be accessed: not mounted
>>> ````
>>> Why does the subvolum need to be mounted,  to resolve content?
>>
>> Because it's using the ioctl to let kernel do the resolve, thus it must
>> be mounted.
>>
> 
> Can't BTRFS inform ioctl about the implied mounted subvolums, when a
> parent subvolum like subvolid=5 is mounted? Having hundreds of  mounts
> in mount table might be too much.

This one is a little different, that subvolume is not accessible from 
your current subvolume, thus it requires the target subvolume to be mounted.

In your case, you may want to mount the top level subvolume (5) to your 
mount point, other than your default subvolume.

Thanks,
Qu
> 
>>>
>>>
>>> I now have a workflow that allows me to continue removing devices,
>>> even if it involves a lot of manual work.
>>> 1. Start `btrfs device remove /dev/loop101 /mnt/volum1/`
>>> 2. When stop, read Dmesg:
>>>         - BTRFS info (device loop101): relocating block group
>>> **93446497894400** flags data|raid5
>>>         - BTRFS warning (device loop101): csum failed root -9 ino 329
>>> off ** 2920988672** csum 0x79a48ce1 expected csum 0xf590b5be mirror 1
>>> 3. `btrfs inspect-internal logical-resolve
>>> $((103315594543104+940359680)) /mnt/volum1/`
>>>          - inode 613878 subvol @plexconfig could not be accessed: not mounted
>>> 3B. If file is not on top root volume mount, subvolum that is points to
>>>          - `mount /dev/loop101 ,subvol=@plexconfig /mnt/plexconfig/`
>>>          - `btrfs inspect-internal logical-resolve
>>> $((103315594543104+940359680)) /mnt/plexconfig/`
>>> 5. Delete or move files.
>>> 6. Repeat
>>
>> Yes, that's the workaround for now.
>>
>> Thanks,
>> Qu
>>
>>>
>>> søn. 16. apr. 2023 kl. 10:56 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>
>>>>
>>>>
>>>> On 2023/4/16 16:36, Torstein Eide wrote:
>>>>> Qu, it must be frustrating to listen to me.
>>>>> I appreciate all the help you give both for me and my problems, and
>>>>> also your contribution to BTRFS.
>>>>>
>>>>> Okay, I will try that.
>>>>>
>>>>>
>>>>> #btrfs filesystem usage -T -g /mnt/
>>>>>
>>>>> Overall:
>>>>>        Device size:                       52160.13GiB
>>>>>        Device allocated:                  22114.09GiB
>>>>>        Device unallocated:                30046.04GiB
>>>>>        Device missing:                        0.00GiB
>>>>>        Used:                              19436.54GiB
>>>>>        Free (estimated):                  25711.53GiB      (min: 12082.50GiB)
>>>>>        Free (statfs, df):                 13766.30GiB
>>>>>        Data ratio:                               1.27
>>>>>        Metadata ratio:                           3.00
>>>>>        Global reserve:                        0.50GiB      (used: 0.00GiB)
>>>>>        Multiple profiles:                         yes      (data)
>>>>>
>>>>>                    Data        Data       Metadata System
>>>>> Id Path         RAID5       RAID6      RAID1C3  RAID1C3 Unallocated
>>>>> -- ------------ ----------- ---------- -------- ------- -----------
>>>>>     1 /dev/loop101  2739.00GiB  339.00GiB        -       -  2511.03GiB
>>>>>     2 /dev/loop102  2882.00GiB  903.00GiB        -       -  1804.03GiB
>>>>
>>>> Oh, indeed you really mean no other Meta/Sys chunks on that devid 2, and
>>>> since you're really converting to RAID6, then your initial command is
>>>> correct.
>>>>
>>>> Although the LBA thing still needs the extra multiplication.
>>>>
>>>>>     3 /dev/loop105  2882.00GiB  903.00GiB 31.00GiB       -  3636.04GiB
>>>>>     4 /dev/loop104  2882.00GiB  903.00GiB 31.00GiB 0.03GiB  3636.01GiB
>>>>>     5 /dev/loop106  2882.00GiB  903.00GiB 37.00GiB 0.03GiB  9216.97GiB
>>>>>     6 /dev/loop103  2882.00GiB  903.00GiB 12.00GiB 0.03GiB  9241.97GiB
>>>>> -- ------------ ----------- ---------- -------- ------- -----------
>>>>>       Total        14267.00GiB 3048.00GiB 37.00GiB 0.03GiB 30046.04GiB
>>>>>       Used         12106.80GiB 3029.00GiB 20.12GiB 0.00GiB
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> #uname -a
>>>>> Linux ubuntu 5.19.0-32-generic #33~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
>>>>> Mon Jan 30 17:03:34 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>>>>>
>>>>>
>>>>> The Dmesg outputs the following:
>>>>> [ 5308.421903] BTRFS info (device loop101): balance: start
>>>>> -dconvert=raid6,soft,devid=1
>>>>> [ 5308.539366] BTRFS info (device loop101): relocating block group
>>>>> 93725670768640 flags data|raid5
>>>>> [ 5354.099960] btrfs_print_data_csum_error: 92 callbacks suppressed
>>>>> [ 5354.099963] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280235520 csum 0xb96d5c53 expected csum 0x040f4404 mirror 1
>>>>> [ 5354.099967] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
>>>>> [ 5354.099968] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105219, gen 0
>>>>> [ 5354.100015] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280239616 csum 0x90e00007 expected csum 0x3094a9df mirror 1
>>>>> [ 5354.100018] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105220, gen 0
>>>>> [ 5354.100026] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280243712 csum 0xbc290143 expected csum 0x734662fc mirror 1
>>>>> [ 5354.100029] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105221, gen 0
>>>>> [ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1
>>>>> [ 5354.100036] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105222, gen 0
>>>>> [ 5354.100043] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280251904 csum 0x34856001 expected csum 0x04a0ca74 mirror 1
>>>>> [ 5354.100045] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105223, gen 0
>>>>> [ 5354.100053] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280256000 csum 0x14fb4051 expected csum 0x7cd42005 mirror 1
>>>>> [ 5354.100056] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105224, gen 0
>>>>> [ 5354.100065] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280260096 csum 0x32870ab6 expected csum 0x52d34048 mirror 1
>>>>> [ 5354.100067] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105225, gen 0
>>>>> [ 5354.100076] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280264192 csum 0x4e089939 expected csum 0x0f56b841 mirror 1
>>>>> [ 5354.100079] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105226, gen 0
>>>>> [ 5354.100088] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280268288 csum 0xc9887e92 expected csum 0xae8d7cfd mirror 1
>>>>> [ 5354.100091] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105227, gen 0
>>>>> [ 5354.100100] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1385 off 5280272384 csum 0x5425dba6 expected csum 0xa86edd67 mirror 1
>>>>> [ 5354.100102] BTRFS error (device loop101): bdev /dev/loop101 errs:
>>>>> wr 7172193, rd 64992, flush 58, corrupt 105228, gen 0
>>>>> [ 5356.447967] BTRFS info (device loop101): balance: ended with status: -5
>>>>>
>>>>> Based on the Dmesg, there is nothing that says why it ended before all
>>>>> 2.7TiB was converted.
>>>>
>>>> It shows the conversion failed due to unrecoverable data during balance.
>>>>
>>>> But weirdly, the error only mentioned mirror 1 (directly read from
>>>> disks), we should have an extra mirror for RAID5 (rebuild using parity),
>>>> but it doesn't even seem to try rebuild.
>>>> (Or it rebuilds some but still some unrepairable?)
>>>>
>>>> Considering the latest LTS is already v6.1, mind to try that kernel or
>>>> the latest one, retry the same command and attach the dmesg for the
>>>> newer kernel?
>>>>
>>>>>
>>>>> There is no output of what files are affected.
>>>>
>>>> All my bad, I forgot relocation is doing a completely different error
>>>> report than scrub.
>>>>
>>>>>
>>>>> My rationale for using convert is that I like to remove 2 devices that
>>>>> are failing, and since BTRFS currently don't support *remove flag*,
>>>>> like we talked about before. I am using convert to give me extra
>>>>> protection and options to disconnect the 2 devices, and do the `btrfs
>>>>> device remove` with *missing*.
>>>>>
>>>>>
>>>>> And it stops `btrfs device remove`, I like to continue removing or
>>>>> converting to Raid6. Since `btrfs device remove` does not take input,
>>>>> I am using balance as an alternative to work around the limitations of
>>>>> `btrfs device remove`.
>>>>>
>>>>>
>>>>> My point was:
>>>>> block group 1 (no errors, converted|moved successful)
>>>>> block group 2 (Single  (dual raid6) error, sometimes i continue to
>>>>> iterate over the groups, sometimes i ends to early, like above and
>>>>> below)
>>>>> block group 3 (dual  (tripel on raid6) error, )
>>>>>
>>>>> Is there a way to tell BTRFS, while iterating blocks, if an
>>>>> unrecoverable block, print (or store for print at the end), and do the
>>>>> next block?
>>>>
>>>> Unfortunately, as you have already experienced, it's not yet supported
>>>> to output those helpful info during balance.
>>>>
>>>> There is a way to get the offending files, but it's complex:
>>>>
>>>>    > [ 5354.100034] BTRFS warning (device loop101): csum failed root -9 ino
>>>>    > 1385 off 5280247808 csum 0x60cbdb35 expected csum 0xc3396cc0 mirror 1
>>>>
>>>> In above error message, it shows it's offset 5280247808 inside the block
>>>> group 93725670768640 causing the error.
>>>>
>>>> You can convert the logical bytenr (93725670768640 + 5280247808) to
>>>> filenames using "btrfs ins" subcommand:
>>>>
>>>>     # btrfs ins logical-resolve 93730951016448 <mnt>
>>>>
>>>>
>>>> On the other hand, scrub is able to do error reporting much better, but
>>>> it has its own problems related to RAID56 (slow perf if scrubbing the
>>>> full fs, no support to only scrub certain blocks, bad error reporting
>>>> for RAID56 P/Q stripes etc).
>>>>
>>>> So unfortunately you're stuck in a very user-unfriendly situation...
>>>>
>>>> But I'd recommend go newer kernel first to make sure the kernel is not
>>>> doing something wrong first.
>>>>
>>>> If possible, please also try scrub first for that devid 2, which has a
>>>> much better error reporting.
>>>>
>>>>
>>>> And for us developers, we need to make the error reporting during
>>>> balance much better first, then also enhance the error reporting during
>>>> read-repair.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Dual error , on raid6, unsure why it failed (I did use the wrong filter):
>>>>> [ 1068.539127] BTRFS info (device loop101): balance: start
>>>>> -dconvert=raid5,soft,usage=70,devid=1
>>>>> [ 1068.546592] BTRFS info (device loop101): relocating block group
>>>>> 103315594543104 flags data|raid6
>>>>> [ 1068.855596] btrfs_print_data_csum_error: 91 callbacks suppressed
>>>>> [ 1068.855600] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror 1
>>>>> [ 1068.855607] btrfs_dev_stat_print_on_error: 7 callbacks suppressed
>>>>> [ 1068.855608] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 52, gen 0
>>>>> [ 1068.855816] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror 1
>>>>> [ 1068.855821] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 53, gen 0
>>>>> [ 1068.855837] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror 1
>>>>> [ 1068.855840] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 54, gen 0
>>>>> [ 1068.855850] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403976192 csum 0x6207b5ba expected csum 0xd383f082 mirror 1
>>>>> [ 1068.855853] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 55, gen 0
>>>>> [ 1068.855860] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403963904 csum 0xb74df7ea expected csum 0x4452d211 mirror
>>>>> **2**
>>>>> [ 1068.855863] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403968000 csum 0xa9cbfdf1 expected csum 0xbb12d590 mirror
>>>>> **2**
>>>>> [ 1068.855964] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403980288 csum 0xd7b71b5b expected csum 0x7612c037 mirror 1
>>>>> [ 1068.855967] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 56, gen 0
>>>>> [ 1068.855976] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403984384 csum 0x60f71f94 expected csum 0x956a021b mirror 1
>>>>> [ 1068.855979] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 57, gen 0
>>>>> [ 1068.855980] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403972096 csum 0x4e09c075 expected csum 0x33c08e79 mirror
>>>>> **2**
>>>>> [ 1068.855989] BTRFS warning (device loop101): csum failed root -9 ino
>>>>> 1310 off 403988480 csum 0x613d06ef expected csum 0x75e3d8f4 mirror 1
>>>>> [ 1068.855992] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 58, gen 0
>>>>> [ 1068.856000] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 59, gen 0
>>>>> [ 1068.856008] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 60, gen 0
>>>>> [ 1068.856040] BTRFS error (device loop101): bdev /dev/loop102 errs:
>>>>> wr 0, rd 0, flush 0, corrupt 61, gen 0
>>>>> [ 1069.116491] BTRFS info (device loop101): balance: ended with status: -5
>>>>>
>>>>> søn. 16. apr. 2023 kl. 09:38 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2023/4/16 15:24, Torstein Eide wrote:
>>>>>>> The correct format is then:
>>>>>>>
>>>>>>> `btrfs balance start -v
>>>>>>> -ddevid=2,convert=raid6,drange=11454997800..11454997807` (convert
>>>>>>> force move, only data on that device)
>>>>>>> `btrfs balance start -v -ddevid=2,convert=raid6,drange=11455002752..11455002759`
>>>>>>
>>>>>> I guess that LBA is in 512 or 4K unit (because we're seeing unaligned
>>>>>> bytenr like 11454997807).
>>>>>>
>>>>>> So the proper range should need to be multiplied by 512 or 4096 based on
>>>>>> the block size of the device.
>>>>>>
>>>>>> Furthermore, if you're not doing convert, no need to specify convert=.
>>>>>>
>>>>>> And finally, you need to duplicate all the filters for metadata and
>>>>>> system, just in case those profiles are involved in the drange.
>>>>>>
>>>>>> So the full output would looks like something like this: (assuming 512
>>>>>> as block size)
>>>>>>
>>>>>> # btrfs balance start -ddevid=2,drange=5864958873600..5864958877695 \
>>>>>>                           -mdevid=2,drange=5864958873600..5864958877695 \
>>>>>>                           -sdevid=2,drange=5864958873600..5864958877695 \
>>>>>>                           <mnt>
>>>>>>>
>>>>>>> And so on?
>>>>>>>
>>>>>>> Since I believe one of the ranges is matched with a bad sector on a
>>>>>>> different device, can I tell BTRFS to, if failed work on the next
>>>>>>> block that is not dual failure?
>>>>>>
>>>>>> Sorry I didn't get your point.
>>>>>>
>>>>>> Balance would try its best to rebuild the data (as long as it's
>>>>>> checksumed), even there is a bad sector, btrfs can still detect and
>>>>>> rebuild the good data.
>>>>>>
>>>>>> And of course, if btrfs failed to rebuild a data matching the csum, it
>>>>>> would fail the balance.
>>>>>>
>>>>>> If you're concerned about that failure, in that case dmesg should output
>>>>>> which file is causing the problem, and you can delete the file and retry
>>>>>> the balance.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> søn. 16. apr. 2023 kl. 02:23 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2023/4/16 08:16, Qu Wenruo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2023/4/16 02:59, Torstein Eide wrote:
>>>>>>>>>> Hi
>>>>>>>>>> I have a disk with "Pending Sector remap".
>>>>>>>>>> That can be view with:
>>>>>>>>>>
>>>>>>>>>> ``smartctl -l defects  /dev/sdd``
>>>>>>>>>>
>>>>>>>>>> ````
>>>>>>>>>> Pending Defects log (GP Log 0x0c)
>>>>>>>>>> Index                LBA    Hours
>>>>>>>>>>          0        11454997800        -
>>>>>>>>>> ....
>>>>>>>>>>          7        11454997807        -
>>>>>>>>>>          8        11455002752        -
>>>>>>>>>> ....
>>>>>>>>>>         15        11455002759        -
>>>>>>>>>>         16        11464481352        -
>>>>>>>>>> ....
>>>>>>>>>>         31        11464486423        -
>>>>>>>>>>         32        11480702000        -
>>>>>>>>>> ....
>>>>>>>>>>          39        11480702007        -
>>>>>>>>>> ````
>>>>>>>>>>
>>>>>>>>>> Can I tell btrfs scrub or balance to move files on these locations?
>>>>>>>>>> I was thinking the balance `drange` may work but was unsure of the
>>>>>>>>>> correct format.
>>>>>>>>>
>>>>>>>>> You can use balance to only balance a logical range.
>>>>>>>>
>>>>>>>> s/logical/physical/
>>>>>>>>
>>>>>>>>>
>>>>>>>>> And it's indeed the drange option.
>>>>>>>>>
>>>>>>>>> Although you may need to specify the option for both metadata, data and
>>>>>>>>> system, or go --full-balance to make sure all chunks are covered.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
