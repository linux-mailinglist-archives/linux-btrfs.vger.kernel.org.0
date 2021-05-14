Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944B3813BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 00:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhENWYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 18:24:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:51959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhENWYM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 18:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621030974;
        bh=R6E0AaEzgaLGy8vgOdctZBpgzMnQwFMa2AZdw0NhIvM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UVgmfJuQAJzwelzZvlApnLLOLW6vY82P82sSmRNH81hOXRgp3oKGy8tXsx8/IhLjj
         C9BpenCChqhLlE5ppU0nuiiZ2TJcq9Oyl3BFG9YWYRASzPtuEuzzcOYyyeFB6DxSM7
         RufErEnT5adQa+ZXpDn4cEV0xC4MIj8ITA4vUpOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7QxL-1lRCAi1V6L-017jiM; Sat, 15
 May 2021 00:22:54 +0200
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
 <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
 <20210511104809.evndsdckwhmonyyl@riteshh-domain>
 <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
 <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
 <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
 <20210513163316.ypvh3ppsrmxg7dit@riteshh-domain>
 <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
Date:   Sat, 15 May 2021 06:22:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JNrOfW2AprvRo5LDZM/MdLkpcSCU7UJF3A9R8g+bgm2YCFFMJp5
 GqS2/LPQ1YRiEJ0AtZzrc3hmtcf+UrkHQnmXicnHmEfnWvgNZQdl6wt4ISIAw5oKw0J18xX
 oZoGXOglHBkI6bLM7HnnrMh7erGc4xNoy9O8XuDyfNVpjCCzoP/2K6rI+3Q7uIFonSTiuQ1
 5W+wY1Gs1vpHwu1KHhFHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vnDpIxTfW7c=:0XDzXa9IHJ/m+SyZtiEyvV
 X0aVbpWNjrjPJPJs4r1bBYx+bjAScutN+TCNDvSDdc+R+cndZzTFYrvv1Y447e0DG75mxIcDP
 PjCGu4neGupu9d+LvGZZYsent3A9Nr3OoYjgcQ7CV3ksFd+OtkWGdQxX7HuY+0DZFfwI4F3EI
 DQpQnbxLTROK3+uXoCFUxXFTorxx8Id+lWnYplmLc9ViPID/5RKpcX8n0nXpiC1iNbIxtMof0
 5OLF3hzcQnUZSxsbQMrSpIIhUbbRo46yHprGB0V9aOwAPvHqC5Jq3BS2tEOrEJpA2zjZK/G1u
 96R5Tfxx8FsXVicitmMtNlAcFr5mjLxePLdO880VrUSFqJH/gzVU+ZPm9CIe5kH8dRpb4UiR+
 L/N9lf5j3R4k9n849rsG30H5DKuzrIzPxlv/CtBVTzNY9WkZ79l8ldQes16ckGi2OC5mRpJaP
 F5xD/O4s+iBNfZYUN+oN90WgLQS55Qx+vZos9KCoD9NiGCv/sVlQvgi/vmxKGhb4Aw6cfPwXd
 iZK5Ky8xztvcmP0MNo+Z7Zvtl+B9qlR7wXSnkRIcE8s6r4P+IC/+1kJwaKnMJSkvWxkHq6GNz
 2BOwXTG2Goxsr528/aI8AeXbGZ6aqQpi4fmjLwsSo7j3vRAFMoKRHe0wSbQT+SbonQNbFUiOq
 5duQo8KUtNzaXoqwoPs+gU+6igisCqxXNRW8/K9hB34RyuXjmJjXjJZB4sxT1FOa2etOFCQlr
 L7hB7H7VfnnuxFmwS3tXCf2LgYHcPTWkRXSLGm9cpp6QQnQ9FDaiDe3az/uZRyj64xELN7VUu
 fgceOO+RvbZaf6X2zzvDyxhBNIC8m+WDl9YRzC+1Ze1ZZhVJNIuv6CVJMqgrc81p09i4givFB
 ti34pIshOgwUTziK0CBCvTj4QsoSDIPfWtAofNSuxZYSC7vsCHmpz9i8AeKjvlI2mHo6II/Mz
 SYUkSm8p8HmJcc8rsnUe0RyVHGPcnFfcO8J1/c6Btz6kkzecSdhFkpxXA/N8ugp8nERxT4FcR
 a0ZA+KUQS/TjmaayJKp48V0sZdLsNeeTY1897tS1b7XvqqoEC/u8RMAVvkH6vQzW0NFnubf2C
 5+5q9I0zJ+f7UT7mqsQm4Avz/K/RPSFxmC/6QZ4Zv1Cv6wRKxG2vzLXPGdgyXzQJprbXoHeNh
 7ND0IOASz9bIxgZURf52+BOiHjRZK1o584U+bZovOv0vFwLYJHSK4a6ECmN1MEuFTzoYmw2G2
 /v2w4iXoy/h9IMyFT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/15 =E4=B8=8A=E5=8D=881:53, Ritesh Harjani wrote:
> On 21/05/14 08:38PM, Ritesh Harjani wrote:
>> On 21/05/14 07:41AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/14 =E4=B8=8A=E5=8D=885:36, Ritesh Harjani wrote:
>>>> On 21/05/13 10:03PM, Ritesh Harjani wrote:
>>>>> On 21/05/12 12:39PM, Ritesh Harjani wrote:
>>>>>> On 21/05/12 09:49AM, Qu Wenruo wrote:
>>>>>>> Hi Ritesh,
>>>>>>>
>>>>>>> The patchset gets updated, and I am already running the tests, so =
far so
>>>>>>> good.
>>>>>> Sure, I have started the testing. Will update the results for both
>>>>>> 4k, 64k configs with "-g quick", "-g auto" options on PPC64.
>>>>>
>>>>> Hi Qu,
>>>>>
>>>>> I completed the testing of "4k" and "64k" configs with "-g quick" an=
d "-g auto"
>>>>> groups on ppc64 machine. There were no crashes nor any related failu=
res with
>>>>> your latest patch series. Also thanks a lot for getting this patch s=
eries ready
>>>>> and fixing all the reported failures :)
>>>
>>> Awesome!
>>>
>>> I also finished my local run, although not that perfect, I found a sma=
ll
>>> BUG_ON() crash, in btrfs/195, caused by the fact that RAID5/6 is only
>>> rejected at mount time, not at balance time.
>
> Hi Qu,
>
> Thanks for pointing this out. I could see that w/o your new fix I could
> reproduce the BUG_ON() crash. But with your patch the test btrfs/195 sti=
ll
> fails.  I guess that is expected right, since
> "RAID5/6 is not supported yet for sectorsize 4096 with page size 65536"?
>
> Is my understanding correct?

Yep, the test is still going to fail, as we reject such convert.

There are tons of other btrfs tests that fails due to the same reason.

Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environment
variant to avoid raid5/6, but not all.

Thus I'm going to update those tests to use that variant to make it
easier to rule out certain profiles.

Thanks,
Qu
>
> Failure log
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> QA output created by 195
> ERROR: error during balancing '/vdc': Invalid argument
> There may be more info in syslog - try dmesg | tail
> 4:single:raid5: Failed convert
> ERROR: error during balancing '/vdc': Invalid argument
> There may be more info in syslog - try dmesg | tail
> 4:single:raid6: Failed convert
> Silence is golden
>
> -ritesh
>
>
>
>
>>
>> Aah, I see I didn't setup SCRATCH_DEV_POOL earlier. So this tests was a=
 [not
>> run] for me. Ohh I should definitely set this up next time for testing =
this
>> patch series, as w/o this raid path will not get tested I guess.
>> Thanks for pointing it out.
>>
>>>
>>> A small and quick fix though.
>>
>> Thanks
>> ritesh
>>
>>>
>>> Thanks for your test!
>>>>>
>>>>> Let me also know if you would like to me to test anything else too, =
will be
>>>>> happy to help. Feel free below tag for your full patch series:-
>>>>>
>>>>> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com> 	[ppc64]
>>>>>
>>>>>
>>>>>
>>>>
>>>>> FYI, I found this below lockdep warning from btrfs/112 with 64k conf=
ig.
>>>>> This may not be related to your patch series though. But I thought I=
 will report
>>>>> it to here anyways.
>>>>
>>>> Hi Qu,
>>>>
>>>> Please ignore below error. I could reproduce below on v5.13-rc1 too w=
/o your
>>>> patches, so this is not at all realted to bs < ps patch series. Will =
report this
>>>> seperately on mailing list.
>>>
>>> What a relief, now everytime I see a false alert related to subpage I
>>> almost feel my heart stopped.
>>>
>>> Maybe it's related to the recent inline extent reflink fix?
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> -ritesh
>>>>
>>>>>
>>>>> [  756.021743] run fstests btrfs/112 at 2021-05-13 03:27:39
>>>>> [  756.554974] BTRFS info (device vdd): disk space caching is enable=
d
>>>>> [  756.555223] BTRFS info (device vdd): has skinny extents
>>>>> [  757.062425] BTRFS: device fsid 453f3a16-65f2-4406-b666-1cb096966a=
d5 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29656)
>>>>> [  757.111042] BTRFS info (device vdc): disk space caching is enable=
d
>>>>> [  757.111309] BTRFS info (device vdc): has skinny extents
>>>>> [  757.121898] BTRFS info (device vdc): checking UUID tree
>>>>>
>>>>> [  757.373434] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> [  757.373557] WARNING: possible circular locking dependency detecte=
d
>>>>> [  757.373670] 5.12.0-rc8-00161-g71a7ca634d59 #26 Not tainted
>>>>> [  757.373751] -----------------------------------------------------=
-
>>>>> [  757.373851] cloner/29747 is trying to acquire lock:
>>>>> [  757.373931] c00000002de71638 (sb_internal#2){.+.+}-{0:0}, at: clo=
ne_copy_inline_extent+0xe4/0x5a0
>>>>> [  757.374130]
>>>>>                  but task is already holding lock:
>>>>> [  757.374232] c000000036abc620 (btrfs-tree-00){++++}-{3:3}, at: __b=
trfs_tree_read_lock+0x70/0x1d0
>>>>> [  757.374389]
>>>>>                  which lock already depends on the new lock.
>>>>>
>>>>> [  757.374507]
>>>>>                  the existing dependency chain (in reverse order) is=
:
>>>>> [  757.374627]
>>>>>                  -> #1 (btrfs-tree-00){++++}-{3:3}:
>>>>> [  757.374735]        down_read_nested+0x68/0x200
>>>>> [  757.374827]        __btrfs_tree_read_lock+0x70/0x1d0
>>>>> [  757.374908]        btrfs_read_lock_root_node+0x88/0x200
>>>>> [  757.374988]        btrfs_search_slot+0x298/0xb70
>>>>> [  757.375078]        btrfs_set_inode_index+0xfc/0x260
>>>>> [  757.375156]        btrfs_new_inode+0x26c/0x950
>>>>> [  757.375243]        btrfs_create+0xf4/0x2b0
>>>>> [  757.375303]        lookup_open.isra.56+0x56c/0x690
>>>>> [  757.375393]        path_openat+0x418/0xd20
>>>>> [  757.375455]        do_filp_open+0x9c/0x130
>>>>> [  757.375518]        do_sys_openat2+0x2ec/0x430
>>>>> [  757.375596]        do_sys_open+0x90/0xc0
>>>>> [  757.375657]        system_call_exception+0x384/0x3d0
>>>>> [  757.375750]        system_call_common+0xec/0x278
>>>>> [  757.375832]
>>>>>                  -> #0 (sb_internal#2){.+.+}-{0:0}:
>>>>> [  757.375936]        __lock_acquire+0x1e80/0x2c40
>>>>> [  757.376017]        lock_acquire+0x2b4/0x5b0
>>>>> [  757.376078]        start_transaction+0x3cc/0x950
>>>>> [  757.376158]        clone_copy_inline_extent+0xe4/0x5a0
>>>>> [  757.376239]        btrfs_clone+0x5fc/0x880
>>>>> [  757.376299]        btrfs_clone_files+0xd8/0x1c0
>>>>> [  757.376376]        btrfs_remap_file_range+0x3d8/0x590
>>>>> [  757.376455]        do_clone_file_range+0x10c/0x270
>>>>> [  757.376542]        vfs_clone_file_range+0x1b0/0x310
>>>>> [  757.376621]        ioctl_file_clone+0x90/0x130
>>>>> [  757.376700]        do_vfs_ioctl+0x984/0x1630
>>>>> [  757.376781]        sys_ioctl+0x6c/0x120
>>>>> [  757.376843]        system_call_exception+0x384/0x3d0
>>>>> [  757.376924]        system_call_common+0xec/0x278
>>>>> [  757.377003]
>>>>>                  other info that might help us debug this:
>>>>>
>>>>> [  757.377119]  Possible unsafe locking scenario:
>>>>>
>>>>> [  757.377216]        CPU0                    CPU1
>>>>> [  757.377295]        ----                    ----
>>>>> [  757.377372]   lock(btrfs-tree-00);
>>>>> [  757.377432]                                lock(sb_internal#2);
>>>>> [  757.377530]                                lock(btrfs-tree-00);
>>>>> [  757.377627]   lock(sb_internal#2);
>>>>> [  757.377689]
>>>>>                   *** DEADLOCK ***
>>>>>
>>>>> [  757.377783] 6 locks held by cloner/29747:
>>>>> [  757.377843]  #0: c00000002de71448 (sb_writers#12){.+.+}-{0:0}, at=
: ioctl_file_clone+0x90/0x130
>>>>> [  757.377990]  #1: c000000010b87ce8 (&sb->s_type->i_mutex_key#15){+=
+++}-{3:3}, at: lock_two_nondirectories+0x58/0xc0
>>>>> [  757.378155]  #2: c000000010b8d610 (&sb->s_type->i_mutex_key#15/4)=
{+.+.}-{3:3}, at: lock_two_nondirectories+0x9c/0xc0
>>>>> [  757.378322]  #3: c000000010b8d4a0 (&ei->i_mmap_lock){++++}-{3:3},=
 at: btrfs_remap_file_range+0xd0/0x590
>>>>> [  757.378463]  #4: c000000010b87b78 (&ei->i_mmap_lock/1){+.+.}-{3:3=
}, at: btrfs_remap_file_range+0xe0/0x590
>>>>> [  757.378605]  #5: c000000036abc620 (btrfs-tree-00){++++}-{3:3}, at=
: __btrfs_tree_read_lock+0x70/0x1d0
>>>>> [  757.378745]
>>>>>                  stack backtrace:
>>>>> [  757.378823] CPU: 0 PID: 29747 Comm: cloner Not tainted 5.12.0-rc8=
-00161-g71a7ca634d59 #26
>>>>> [  757.378972] Call Trace:
>>>>> [  757.379013] [c00000002de07200] [c000000000c12ea8] dump_stack+0xec=
/0x144 (unreliable)
>>>>> [  757.379135] [c00000002de07240] [c0000000002775d8] print_circular_=
bug.isra.32+0x3a8/0x400
>>>>> [  757.379269] [c00000002de072e0] [c000000000277774] check_noncircul=
ar+0x144/0x190
>>>>> [  757.379389] [c00000002de073b0] [c00000000027c500] __lock_acquire+=
0x1e80/0x2c40
>>>>> [  757.379509] [c00000002de074f0] [c00000000027dfd4] lock_acquire+0x=
2b4/0x5b0
>>>>> [  757.379609] [c00000002de075e0] [c000000000a063cc] start_transacti=
on+0x3cc/0x950
>>>>> [  757.379726] [c00000002de07690] [c000000000aede64] clone_copy_inli=
ne_extent+0xe4/0x5a0
>>>>> [  757.379842] [c00000002de077c0] [c000000000aee91c] btrfs_clone+0x5=
fc/0x880
>>>>> [  757.379940] [c00000002de07990] [c000000000aeed58] btrfs_clone_fil=
es+0xd8/0x1c0
>>>>> [  757.380056] [c00000002de07a00] [c000000000aef218] btrfs_remap_fil=
e_range+0x3d8/0x590
>>>>> [  757.380172] [c00000002de07ae0] [c0000000005d481c] do_clone_file_r=
ange+0x10c/0x270
>>>>> [  757.380289] [c00000002de07b40] [c0000000005d4b30] vfs_clone_file_=
range+0x1b0/0x310
>>>>> [  757.380405] [c00000002de07bb0] [c000000000588a10] ioctl_file_clon=
e+0x90/0x130
>>>>> [  757.380523] [c00000002de07c10] [c000000000589434] do_vfs_ioctl+0x=
984/0x1630
>>>>> [  757.380621] [c00000002de07d10] [c00000000058a14c] sys_ioctl+0x6c/=
0x120
>>>>> [  757.380719] [c00000002de07d60] [c000000000039e64] system_call_exc=
eption+0x384/0x3d0
>>>>> [  757.380836] [c00000002de07e10] [c00000000000d45c] system_call_com=
mon+0xec/0x278
>>>>> [  757.380953] --- interrupt: c00 at 0x7ffff7e32990
>>>>> [  757.381042] NIP:  00007ffff7e32990 LR: 00000001000010ec CTR: 0000=
000000000000
>>>>> [  757.381157] REGS: c00000002de07e80 TRAP: 0c00   Not tainted  (5.1=
2.0-rc8-00161-g71a7ca634d59)
>>>>> [  757.381289] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,=
RI,LE>  CR: 28000244  XER: 00000000
>>>>> [  757.381445] IRQMASK: 0
>>>>>                  GPR00: 0000000000000036 00007fffffffdec0 00007ffff7=
f27100 0000000000000004
>>>>>                  GPR04: 000000008020940d 00007fffffffdf40 0000000000=
000000 0000000000000000
>>>>>                  GPR08: 0000000000000004 0000000000000000 0000000000=
000000 0000000000000000
>>>>>                  GPR12: 0000000000000000 00007ffff7ffa940 0000000000=
000000 0000000000000000
>>>>>                  GPR16: 0000000000000000 0000000000000000 0000000000=
000000 0000000000000000
>>>>>                  GPR20: 0000000000000000 000000009123683e 00007fffff=
ffdf40 0000000000000000
>>>>>                  GPR24: 0000000000000000 0000000000000000 0000000000=
000000 0000000000000004
>>>>>                  GPR28: 0000000100030260 0000000100030280 0000000000=
000003 000000000000005f
>>>>> [  757.382382] NIP [00007ffff7e32990] 0x7ffff7e32990
>>>>> [  757.382460] LR [00000001000010ec] 0x1000010ec
>>>>> [  757.382537] --- interrupt: c00
>>>>> [  757.787411] BTRFS: device fsid fd5f535c-f163-4a14-b9a5-c423b470fd=
d7 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29753)
>>>>> [  757.829757] BTRFS info (device vdc): use zlib compression, level =
3
>>>>> [  757.829948] BTRFS info (device vdc): disk space caching is enable=
d
>>>>> [  757.830051] BTRFS info (device vdc): has skinny extents
>>>>> [  757.837338] BTRFS info (device vdc): checking UUID tree
>>>>> [  758.421670] BTRFS: device fsid e2a0fa31-ad7e-47b9-879c-309e8e2b35=
83 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29850)
>>>>> [  758.456197] BTRFS info (device vdc): disk space caching is enable=
d
>>>>> [  758.456306] BTRFS info (device vdc): has skinny extents
>>>>> [  758.502055] BTRFS info (device vdc): checking UUID tree
>>>>> [  759.067243] BTRFS: device fsid b66a7909-8293-4467-9ec7-217007bc10=
23 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29947)
>>>>> [  759.099884] BTRFS info (device vdc): use zlib compression, level =
3
>>>>> [  759.100112] BTRFS info (device vdc): disk space caching is enable=
d
>>>>> [  759.100222] BTRFS info (device vdc): has skinny extents
>>>>> [  759.108120] BTRFS info (device vdc): checking UUID tree
>>>>>
>>>>>
>>>>>
>>>>> -ritesh
>>>>>
>>>>>>
>>>>>>>
>>>>>>> The new head is:
>>>>>>> commit cb81da05e7899b8196c3c5e0b122798da3b94af0
>>>>>>> Author: Qu Wenruo <wqu@suse.com>
>>>>>>> Date:   Mon May 3 08:19:27 2021 +0800
>>>>>>>
>>>>>>>       btrfs: remove io_failure_record::in_validation
>>>>>>>
>>>>>>> I may have some minor change the to commit messages and comments
>>>>>>> preparing for the next submit, but the code shouldn't change any m=
ore.
>>>>>>>
>>>>>>>
>>>>>>> Just one note, thanks to your report on btrfs/028, I even find a d=
ata
>>>>>>> corruption bug in relocation code.
>>>>>> Nice :)
>>>>>>
>>>>>>> Kudos (and of-course Reported-by tags) to you!
>>>>>> Thanks!
>>>>>>
>>>>>>>
>>>>>>> New changes since v2 patchset:
>>>>>>>
>>>>>>> - Fix metadata read path ASSERT() when last eb is already dereferr=
ed
>>>>>>> - Fix read repair related bugs
>>>>>>>     * fix possible hang due to unreleased sectors after read error
>>>>>>>     * fix double accounting in btrfs_subpage::readers
>>>>>>>
>>>>>>> - Fix false alert when relocating data extent without csum
>>>>>>>     This is really a false alert, the expected csum is always 0x00
>>>>>>>
>>>>>>> - Fix a data corruption when relocating certain data extents layou=
t
>>>>>>>     This is a real corruption, both relocation and scrub will repo=
rt
>>>>>>>     error.
>>>>>> Thanks for the detailed info.
>>>>>>
>>>>>>>
>>>>>>> Thanks and happy testing!
>>>>>> Thanks for the quick replies and all your work in supporting bs < p=
s.
>>>>>> This is definitely very useful for Power platform too!!
>>>>>>
>>>>>> -ritesh
