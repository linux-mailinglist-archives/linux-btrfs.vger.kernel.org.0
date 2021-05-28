Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC37F3940D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhE1K10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 06:27:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:58933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235980AbhE1K10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 06:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622197535;
        bh=G31LLRWFdniIrruMioj563QOJh4KqNPNq09BU4NKicE=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=H1FDbn68kD1r5NJNyXoGVfXsm7Xe43G36W/u95ENqSu2EvQyPMv1Zi6LZ+JryjcnJ
         vmoQpsd+eoNEF7S/iIGY7NRJhbkazdhkY19ZNnEwtsEsnrK/Zlrvuvhy6oMDTXVxBL
         OgOHt2CfkGApaXX8vqSbdS2yfstNJaczKzCwfQGE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1lm32e2t1K-008Fce; Fri, 28
 May 2021 12:25:35 +0200
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
 <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
 <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
 <82070e33-82f7-3a54-7620-b4a43bdaff50@gmx.com>
 <20210525130227.ldhbj4x7sryr63bk@riteshh-domain>
 <20210526052902.qsaodegp6emjg5bl@riteshh-domain>
 <6b706161-ab53-29e1-d8bb-f5fd779f1722@suse.com>
 <20210526134541.vgjqxcnbnrlkegvx@riteshh-domain>
 <dde0002e-5864-35cf-f826-5b8a4d0e35fd@gmx.com>
 <20210528085919.nynbnwpskonbyvtx@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <05a57be6-44f7-e243-dfdb-a6467b056bdc@gmx.com>
Date:   Fri, 28 May 2021 18:25:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528085919.nynbnwpskonbyvtx@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qYM592slt988jraeBdx+iptCbdAYKH3fbb3UchQZJH54FSU9bpx
 1SAOL6VA6A8JSc8IruWg1JU/Jrhq8ajNK9BU3bYj0ptFnlu6eQyv3hrtgswT8+hunZwEMKQ
 NyLtRYDLpuZIsDyjdGQXcU8f28pa2lmJyUE5vxzs+pXrHO6Gk08ENtncl6/O2BaXAT87QM3
 NQI9p4M3Rh0zhabhari2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dKEsSHLKhnI=:GWm7TzTGrCiu40xDC0lhG2
 Qrk9x3O+LjZoXpNtdhq1vGXY1MUWzfe+4JCMrbEQ+YQ6kJVwD27JWTYhYYDkLqGcsHknvY7Rb
 94THqcr4Q3XrYDsPkQRk7aZ/mmjBs9QYcIlDO7wEw9S6XMqVNjCECE8RXy2u71slcZJ/4Cksn
 zJFfoFw6CaXzwUlmJ1MmpjLquMesHnTAMgt3yp3oKBnuGdBgZfhdR5L0NG48bUCPzLECXYx0W
 IlzfjPlF5pkl7hNk5M2GjKGORVAUw2WUFWfCxgJWNHg13oUV+X0DXmGE7o1hGMVSArqrN8Syf
 2B3WNQSo/lzArCG0bZ5aH46Aph8lx8L//SS+BcB/5etYj1GE1/ewQbU1UVgOTUKhWZ6yuck1e
 UWD7SpBbMZqs+UEhseeFxhf5H7NlHQiVJQSdKMdsXq4KAEck96x0E/GwTpBQx3cA9Y8P7+TSF
 39JHGPRe/RSUg6e7o6VGEXrU/JY/Hn+IGPD0hCT63Mus+GRacU9YswyY18oSdYtuy3yXHnpJb
 +WTLL/3ZfIAZk04/FyvUVFYequhJxlyp6nIeNBMnNSzZnAJoOk+tiQ46xgEeMq3dJ9lrKlX9j
 FvMxLXRTn0yxd1+T7+CcnwcHqJhfzBoT7+UhYxx/M9CYLg3IzpDz4B03BqfsEmujxkw7NfnWi
 ctxTOeQC/yy5jx5angEiLKV2Vtov7HlMiTC4YTe0ygnBmXGsw15JefJiw/QqSuXugcknVR1Xz
 R86o4+NHy1r54u65+o4q2Ov2BwRp5J0XxUrzW8CKLhggxQPqwcmfz0sk1XCBx9IQ8dCDEXV0J
 mpk4biOUsE4n2xjhpdk6/HYgxuW9w+FHQLV+zNsSuOYwZb7t+ps9ZRV0F8l8+Ey6e5IJcjpW9
 cOtFLkWELPHZYMrEYV4jZvLPV72dcK7WWxDPrj8rYEqH3IcNNqtMslx56wXql3RI0GGBMBa6B
 /TabS07s4wDjXFq20S2+aBtyKoJlYI+5oGlV/58U19d2642JnrmyBsKOZQAcP4BRpBh6/aidC
 r6LmuhtP5uly0KK7QYXTVIcDs/LvQAsq9wLeWfiTduOlEG8scMHVJta7Iui9+7kzaINXSQ8qY
 73t/mjaT+rCjjbMIao/Emkze8IHtaf0D2SxrdShVJhOAmp1EOPjAbrxPK7aDs0RaeKxzFqoh2
 iyPgIasXH5Pk+pRGsseeBVjZ7vbwNvsszOLTICaZ5Qwok/xOVQ8nyewkCkyquhAjC+qTTZZk/
 ko9kSrXwGwjzwDzI/
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/28 =E4=B8=8B=E5=8D=884:59, Ritesh Harjani wrote:
> On 21/05/28 04:26PM, Qu Wenruo wrote:
>>> Hi Qu,
>>>
>>> Few updates, overall "-g all" ran fine on Power with both 4k and 64k c=
onfigs.
>>> With no failures (other than which we already know).
>>>
>>> However in order to stress-test btrfs/062, I could observe below kerne=
l crash.
>>> I hit this panic when I kept btrfs/062 to run for 20 iterations. I am =
easily
>>> hitting this warning msg when I run this test, but in one of the itera=
tion it
>>> caused a warning followed by kernel panic.
>>
>> Unfortunately, on power8 VM, I can't reproduce the bug reliably.
>>
>> Just check -I 20 btrfs/062 can't even reproduce the warning.
>>
>> But in a full -g auto run, it's much easier to hit the warning at btrfs=
/062.
>>
>> Any other test case where you can easily reproduce the warning message?
>
> Hi Qu,
>
> No, I didn't try with something else. I was running with 8cpu and 4G con=
fig,
> although I don't see this has anything to do with memory config.
> This definitely is a difficult to catch race, since btrfs/062 does a lot=
 of
> things in parallel.
>
> But the kernel crash that I reported does not seems to be because of thi=
s
> warning. I think it is because of the error value not properly returned
> in btrfs_mark_extent_written().
>
> Check below diff and the kernel crash msgs. Either ways below patch shou=
ld be
> taken in kernel right?
> if needed I can submit this patch to fix the returned error value?

Definitely worthy submitting.

But this also means, btrfs_mark_extent_written() has hit some file
extent layout which is not expected.

Looks like some race, my first guess is fsstress against defrag, and
balance is not really involved.
But still need more testing.

>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e307fbe398f0..c47f406ce9c1 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1097,7 +1097,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_h=
andle *trans,
>           int del_nr =3D 0;
>           int del_slot =3D 0;
>           int recow;
> -       int ret;
> +       int ret =3D 0;
>           u64 ino =3D btrfs_ino(inode);
>
>           path =3D btrfs_alloc_path();
> @@ -1318,7 +1318,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_h=
andle *trans,
>           }
>    out:
>           btrfs_free_path(path);
> -       return 0;
> +       return ret;
>    }
>
>    /*
>
> Also when I am trying to recreate this, I am finding some other deadlock
> scenario where my system gets stuck sometimes with some dumps of locking=
 details
> dumped no console.

I got this reproduce once too.

What I see is it's hanging at the data reloc inode writeback.
But not sure about the cause yet.

Let me continue testing, with the -g auto to reproduce it and with extra
trace events to catch it.

Thanks,
Qu

> If you want I can provide those details too.
>
> -ritesh
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Can you pls take a look at it. Please let me know if anything will be =
needed
>>> from my end on this. Looking at the logs, I am guessing somewhere the =
error is
>>> not properly handeled and we are accessing a freed up pointer or somet=
hing.
>>>
>>> ./check -i 20 tests/btrfs/062
>>>
>>>
>>> [  680.370377] run fstests btrfs/062 at 2021-05-26 13:20:18
>>> <...>
>>> [  715.900314] BTRFS info (device vdc): setting incompat feature flag =
for COMPRESS_LZO (0x8)
>>> [  716.203818] ------------[ cut here ]------------
>>> [  716.204056] WARNING: CPU: 1 PID: 1033 at fs/btrfs/extent_map.c:306 =
unpin_extent_cache+0x78/0x140
>>> [  716.204347] Modules linked in:
>>> [  716.204412] CPU: 1 PID: 1033 Comm: kworker/u16:9 Tainted: G        =
W         5.13.0-rc2-00382-g1d349b93923f #34
>>> [  716.204596] Workqueue: btrfs-endio-write btrfs_work_helper
>>> [  716.204779] NIP:  c000000000a334c8 LR: c000000000a334b4 CTR: 000000=
0000000000
>>> [  716.204898] REGS: c000000023fb7750 TRAP: 0700   Tainted: G        W=
          (5.13.0-rc2-00382-g1d349b93923f)
>>> [  716.205053] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 84002428  XER: 20000000
>>> [  716.205232] CFAR: c000000000a3303c IRQMASK: 0
>>> [  716.205232] GPR00: c000000000a334b4 c000000023fb79f0 c000000001c5dc=
00 c00000003a780008
>>> [  716.205232] GPR04: 0000000000350000 0000000000019000 00000000000000=
01 0000000000000001
>>> [  716.205232] GPR08: 0000000000000002 0000000000000002 00000000000000=
01 0000000000000001
>>> [  716.205232] GPR12: 0000000000002200 c00000003fffee00 c000000022e658=
10 0000000000102000
>>> [  716.205232] GPR16: c000000011cd4000 c000000014d03620 c000000023fb7a=
c8 0000000000000000
>>> [  716.205232] GPR20: 0000000000000000 c000000014d03228 00000000000040=
24 c00000002b50a000
>>> [  716.205232] GPR24: 0000000000004020 0000000000019000 c000000014d031=
68 0000000000000007
>>> [  716.205232] GPR28: 000000000035a000 c000000014d031e8 c000000014d031=
c8 c00000003a780008
>>> [  716.206237] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x140
>>> [  716.206335] LR [c000000000a334b4] unpin_extent_cache+0x64/0x140
>>> [  716.206447] Call Trace:
>>> [  716.206487] [c000000023fb79f0] [c000000000a334b4] unpin_extent_cach=
e+0x64/0x140 (unreliable)
>>> [  716.206624] [c000000023fb7a50] [c000000000a23cfc] btrfs_finish_orde=
red_io+0x4fc/0xbd0
>>> [  716.206740] [c000000023fb7ba0] [c000000000a64360] btrfs_work_helper=
+0x260/0x8e0
>>> [  716.206861] [c000000023fb7c40] [c000000000206954] process_one_work+=
0x434/0x7d0
>>> [  716.206989] [c000000023fb7d10] [c000000000206ff4] worker_thread+0x3=
04/0x570
>>> [  716.207088] [c000000023fb7da0] [c00000000021371c] kthread+0x1bc/0x1=
d0
>>> [  716.207186] [c000000023fb7e10] [c00000000000d6ec] ret_from_kernel_t=
hread+0x5c/0x70
>>> [  716.207304] Instruction dump:
>>> [  716.207364] 4887a5d1 60000000 7f84e378 7fc3f378 38c00001 e8a10028 4=
bfff949 7c7f1b79
>>> [  716.207486] 41820010 e89f0018 7fa4e000 419e000c <0fe00000> 41820088=
 fb7f0060 395f0068
>>> [  716.207607] irq event stamp: 0
>>> [  716.207665] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>> [  716.207763] hardirqs last disabled at (0): [<c0000000001cb190>] cop=
y_process+0x760/0x1be0
>>> [  716.207881] softirqs last  enabled at (0): [<c0000000001cb190>] cop=
y_process+0x760/0x1be0
>>> [  716.207997] softirqs last disabled at (0): [<0000000000000000>] 0x0
>>> [  716.208098] ---[ end trace 6c0ed3a64655c790 ]---
>>> [  716.424792] BTRFS info (device vdc): balance: start -d -m -s
>>> [  717.803034] BTRFS info (device vdc): relocating block group 3072327=
68 flags data|raid0
>>> [  720.496353] BTRFS info (device vdc): found 296 extents, stage: move=
 data extents
>>> [  720.952379] BTRFS info (device vdc): found 260 extents, stage: upda=
te data pointers
>>> [  721.393848] BTRFS info (device vdc): relocating block group 3879731=
2 flags metadata|raid0
>>> [  721.864427] BTRFS info (device vdc): found 80 extents, stage: move =
data extents
>>> [  722.210788] BTRFS info (device vdc): relocating block group 2202009=
6 flags system|raid0
>>> [  722.536611] BTRFS info (device vdc): found 1 extents, stage: move d=
ata extents
>>> [  722.887924] BTRFS info (device vdc): balance: ended with status: 0
>>> <...>
>>> [  749.122205] BTRFS info (device vdc): balance: start -d -m -s
>>> [  749.317906] Page cache invalidation failure on direct I/O.  Possibl=
e data corruption due to collision with buffered I/O!
>>> [  749.318042] File: /vdc/stressdir/p4/f4 PID: 6002 Comm: fsstress
>>> [  751.201149] BTRFS info (device vdc): relocating block group 2988441=
60 flags data|raid1
>>> [  753.219675] BTRFS info (device vdc): found 365 extents, stage: move=
 data extents
>>> [  753.570365] BTRFS info (device vdc): found 339 extents, stage: upda=
te data pointers
>>> [  753.890819] BTRFS info (device vdc): relocating block group 3040870=
4 flags metadata|raid1
>>> [  754.219420] BTRFS info (device vdc): found 77 extents, stage: move =
data extents
>>> [  754.553047] BTRFS info (device vdc): relocating block group 2202009=
6 flags system|raid1
>>> [  754.847516] BTRFS info (device vdc): found 1 extents, stage: move d=
ata extents
>>> [  755.162938] BTRFS info (device vdc): balance: ended with status: 0
>>> [  756.146222] BTRFS info (device vdc): scrub: started on devid 1
>>> [  756.147147] BTRFS info (device vdc): scrub: started on devid 2
>>> [  756.147206] BTRFS info (device vdc): scrub: started on devid 4
>>> [  756.147237] BTRFS info (device vdc): scrub: started on devid 3
>>> [  756.150075] BTRFS info (device vdc): scrub: finished on devid 4 wit=
h status: 0
>>> [  756.156601] BTRFS info (device vdc): scrub: finished on devid 3 wit=
h status: 0
>>> [  756.486566] BTRFS info (device vdc): scrub: finished on devid 2 wit=
h status: 0
>>> [  756.846646] BTRFS info (device vdc): scrub: finished on devid 1 wit=
h status: 0
>>> [  758.205162] BTRFS: device fsid 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf=
 devid 1 transid 5 /dev/vdc scanned by systemd-udevd (6342)
>>> [  758.220277] BTRFS: device fsid 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf=
 devid 2 transid 5 /dev/vdi scanned by mkfs.btrfs (6340)
>>> [  758.220436] BTRFS: device fsid 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf=
 devid 3 transid 5 /dev/vdj scanned by mkfs.btrfs (6340)
>>> [  758.226954] BTRFS: device fsid 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf=
 devid 4 transid 5 /dev/vdk scanned by mkfs.btrfs (6340)
>>> [  758.254977] BTRFS info (device vdc): disk space caching is enabled
>>> [  758.255099] BTRFS info (device vdc): has skinny extents
>>> [  758.255151] BTRFS warning (device vdc): read-write for sector size =
4096 with page size 65536 is experimental
>>> [  758.271336] BTRFS info (device vdc): checking UUID tree
>>> [  758.799031] BTRFS info (device vdc): balance: start -d -m -s
>>> [  759.522570] ------------[ cut here ]------------
>>> [  759.525038] WARNING: CPU: 3 PID: 381 at fs/btrfs/extent_map.c:306 u=
npin_extent_cache+0x78/0x140
>>> [  759.525234] Modules linked in:
>>> [  759.525307] CPU: 3 PID: 381 Comm: kworker/u16:4 Tainted: G        W=
         5.13.0-rc2-00382-g1d349b93923f #34
>>> [  759.525448] Workqueue: btrfs-endio-write btrfs_work_helper
>>> [  759.525501] NIP:  c000000000a334c8 LR: c000000000a334b4 CTR: 000000=
0000000000
>>> [  759.525565] REGS: c00000000c347750 TRAP: 0700   Tainted: G        W=
          (5.13.0-rc2-00382-g1d349b93923f)
>>> [  759.525653] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 84002448  XER: 20000000
>>> [  759.525726] ------------[ cut here ]------------
>>> [  759.525787] CFAR: c000000000a3303c IRQMASK: 0
>>> [  759.525787] GPR00: c000000000a334b4 c00000000c3479f0 c000000001c5dc=
00 c00000002d2ba508
>>> [  759.525871] WARNING: CPU: 1 PID: 0 at fs/btrfs/ordered-data.c:408 b=
trfs_mark_ordered_io_finished+0x2f8/0x550
>>> [  759.525966]
>>> [  759.525966] GPR04:
>>> [  759.526086] Modules linked in:
>>> [  759.526087] 00000000000b0000 0000000000017000
>>> [  759.526134]
>>> [  759.526164] 0000000000000001
>>> [  759.526227] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W      =
   5.13.0-rc2-00382-g1d349b93923f #34
>>> [  759.526247] 0000000000000001
>>> [  759.526294] NIP:  c000000000a3ba88 LR: c000000000a3ba78 CTR: c00000=
0000a46580
>>> [  759.526364]
>>> [  759.526364] GPR08:
>>> [  759.526410] REGS: c0000000fffd35d0 TRAP: 0700   Tainted: G        W=
          (5.13.0-rc2-00382-g1d349b93923f)
>>> [  759.526510] 0000000000000002
>>> [  759.526556] MSR:  8000000000029033
>>> [  759.526642] 0000000000000002
>>> [  759.526689] <
>>> [  759.526722] 0000000000000001
>>> [  759.526772] SF
>>> [  759.526793] ffffffffffffffff
>>> [  759.526846] ,EE
>>> [  759.526869]
>>> [  759.526869] GPR12:
>>> [  759.526921] ,ME
>>> [  759.526942] 0000000000002200
>>> [  759.526991] ,IR
>>> [  759.527013] c00000003ffeae00
>>> [  759.527063] ,DR
>>> [  759.527085] c000000000213568
>>> [  759.527132] ,RI
>>> [  759.527154] c000000009ed1e40
>>> [  759.527206] ,LE
>>> [  759.527227]
>>> [  759.527227] GPR16:
>>> [  759.527275] >
>>> [  759.527296] c000000011cd4000
>>> [  759.527346]   CR: 44084424  XER: 00000000
>>> [  759.527367] c000000014d0e7e0
>>> [  759.527426] CFAR: c000000000af8794
>>> [  759.527457] c00000000c347ac8
>>> [  759.527509] IRQMASK: 1
>>> [  759.527541] 0000000000000001
>>> [  759.527589]
>>> [  759.527589] GPR00:
>>> [  759.527612]
>>> [  759.527612] GPR20:
>>> [  759.527661] c000000000a3ba78
>>> [  759.527695] 0000000000000000
>>> [  759.527746] c0000000fffd3870
>>> [  759.527777] c000000014d0e3e8
>>> [  759.527828] c000000001c5dc00
>>> [  759.527859] 0000000000000024
>>> [  759.527907] 0000000000000001
>>> [  759.527939] c0000000123da000
>>> [  759.527991]
>>> [  759.527991] GPR04:
>>> [  759.528021]
>>> [  759.528021] GPR24:
>>> [  759.528070] 0000000000000001
>>> [  759.528105] 0000000000000020
>>> [  759.528156] 0000000000000000
>>> [  759.528187] 0000000000017000
>>> [  759.528239] 0000000000000000
>>> [  759.528269] c000000014d0e328
>>> [  759.528321] 00000000000000ff
>>> [  759.528351] 0000000000000009
>>> [  759.528400]
>>> [  759.528400] GPR08:
>>> [  759.528434]
>>> [  759.528434] GPR28:
>>> [  759.528487] 0000000000000001
>>> [  759.528520] 00000000000b5000
>>> [  759.528570] 0000000000010003
>>> [  759.528600] c000000014d0e3a8
>>> [  759.528646] 0000000000000000
>>> [  759.528678] c000000014d0e388
>>> [  759.528725] fffffffffffffffd
>>> [  759.528757] c00000002d2ba508
>>> [  759.528810]
>>> [  759.528810] GPR12:
>>> [  759.528841]
>>> [  759.528888] 0000000044002422
>>> [  759.528925] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x140
>>> [  759.528961] c00000003fffee00
>>> [  759.528991] LR [c000000000a334b4] unpin_extent_cache+0x64/0x140
>>> [  759.529812] 00000000000c0000
>>> [  759.529844] Call Trace:
>>> [  759.529923] c000000014d0e328
>>> [  759.529954] [c00000000c3479f0] [c000000000a334b4] unpin_extent_cach=
e+0x64/0x140
>>> [  759.529986]
>>> [  759.529986] GPR16:
>>> [  759.530107]  (unreliable)
>>> [  759.530463] c0000000016680e0
>>> [  759.530494]
>>> [  759.530495] [c00000000c347a50] [c000000000a23d28] btrfs_finish_orde=
red_io+0x528/0xbd0
>>> [  759.530525] c000000000a243d0
>>> [  759.530557]
>>> [  759.530588] c00000000da7b530
>>> [  759.530650] [c00000000c347ba0] [c000000000a64360] btrfs_work_helper=
+0x260/0x8e0
>>> [  759.530694] 0000000000000080
>>> [  759.530717]
>>> [  759.530718] [c00000000c347c40] [c000000000206954] process_one_work+=
0x434/0x7d0
>>> [  759.530762]
>>> [  759.530762] GPR20:
>>> [  759.530826]
>>> [  759.530870] 0000000000000020
>>> [  759.530893] [c00000000c347d10] [c000000000206ff4] worker_thread+0x3=
04/0x570
>>> [  759.530980] 0000000000000001
>>> [  759.531009]
>>> [  759.531040] 00000000fffffffe
>>> [  759.531071] [c00000000c347da0] [c00000000021371c] kthread+0x1bc/0x1=
d0
>>> [  759.531145] 0000000000000001
>>> [  759.531178]
>>> [  759.531208]
>>> [  759.531208] GPR24:
>>> [  759.531240] [c00000000c347e10] [c00000000000d6ec] ret_from_kernel_t=
hread+0x5c/0x70
>>> [  759.531312] c000000014d0e5b0
>>> [  759.531344]
>>> [  759.531374] 0000000000000000
>>> [  759.531407] Instruction dump:
>>> [  759.531494] c000000011cd4000
>>> [  759.531526]
>>> [  759.531528] 4887a5d1
>>> [  759.531557] c00c000000093340
>>> [  759.531589] 60000000
>>> [  759.531633]
>>> [  759.531633] GPR28:
>>> [  759.531665] 7f84e378
>>> [  759.531695] 00000000000c0000
>>> [  759.531717] 7fc3f378
>>> [  759.531762] 0000000000001000
>>> [  759.531781] 38c00001
>>> [  759.531825] 00000000000bf000
>>> [  759.531847] e8a10028
>>> [  759.531891] c000000022e25710
>>> [  759.531912] 4bfff949
>>> [  759.531958]
>>> [  759.531980] 7c7f1b79
>>> [  759.532025] NIP [c000000000a3ba88] btrfs_mark_ordered_io_finished+0=
x2f8/0x550
>>> [  759.532044]
>>> [  759.532045] 41820010
>>> [  759.532089] LR [c000000000a3ba78] btrfs_mark_ordered_io_finished+0x=
2e8/0x550
>>> [  759.532108] e89f0018
>>> [  759.532138] Call Trace:
>>> [  759.532157] 7fa4e000
>>> [  759.532248] [c0000000fffd3870] [c000000000a3ba78] btrfs_mark_ordere=
d_io_finished+0x2e8/0x550
>>> [  759.532267] 419e000c
>>> [  759.532299]  (unreliable)
>>> [  759.532355] <0fe00000>
>>> [  759.532385]
>>> [  759.532406] 41820088
>>> [  759.532437] [c0000000fffd3970] [c000000000a149cc] btrfs_writepage_e=
ndio_finish_ordered+0x19c/0x1d0
>>> [  759.532505] fb7f0060
>>> [  759.532535]
>>> [  759.532557] 395f0068
>>> [  759.532587] [c0000000fffd39d0] [c000000000a46304] end_extent_writep=
age+0x74/0x2f0
>>> [  759.532606]
>>> [  759.532607] irq event stamp: 888416
>>> [  759.532636]
>>> [  759.532712] hardirqs last  enabled at (888415): [<c0000000012ad654>=
] _raw_spin_unlock_irq+0x44/0x80
>>> [  759.532742] [c0000000fffd3a00] [c000000000a466c4] end_bio_extent_wr=
itepage+0x144/0x270
>>> [  759.532762] hardirqs last disabled at (888416): [<c0000000012a1cfc>=
] __schedule+0x31c/0xce0
>>> [  759.532792]
>>> [  759.532857] softirqs last  enabled at (887252): [<c000000000465ecc>=
] wb_wakeup_delayed+0x8c/0xb0
>>> [  759.532888] [c0000000fffd3ac0] [c000000000b520f4] bio_endio+0x254/0=
x270
>>> [  759.532920] softirqs last disabled at (887248): [<c000000000465e98>=
] wb_wakeup_delayed+0x58/0xb0
>>> [  759.532950]
>>> [  759.533023] ---[ end trace 6c0ed3a64655c791 ]---
>>> [  759.533110] [c0000000fffd3b00] [c000000000a624b0] btrfs_end_bio+0x1=
a0/0x200
>>> [  759.533648] [c0000000fffd3b40] [c000000000b520f4] bio_endio+0x254/0=
x270
>>> [  759.533757] [c0000000fffd3b80] [c000000000b5a73c] blk_update_reques=
t+0x46c/0x670
>>> [  759.533858] [c0000000fffd3c30] [c000000000b6d9a4] blk_mq_end_reques=
t+0x34/0x1d0
>>> [  759.533956] [c0000000fffd3c70] [c000000000d6ea4c] virtblk_request_d=
one+0x8c/0xb0
>>> [  759.534089] [c0000000fffd3ca0] [c000000000b6b360] blk_mq_complete_r=
equest+0x50/0x70
>>> [  759.534184] [c0000000fffd3cd0] [c000000000d6e74c] virtblk_done+0x9c=
/0x190
>>> [  759.534264] [c0000000fffd3d30] [c000000000cb9420] vring_interrupt+0=
x140/0x160
>>> [  759.534359] [c0000000fffd3da0] [c0000000002907b8] __handle_irq_even=
t_percpu+0x1e8/0x490
>>> [  759.534454] [c0000000fffd3e70] [c000000000290aa4] handle_irq_event_=
percpu+0x44/0xc0
>>> [  759.534548] [c0000000fffd3eb0] [c000000000290b80] handle_irq_event+=
0x60/0xa0
>>> [  759.534642] [c0000000fffd3ef0] [c000000000297df0] handle_fasteoi_ir=
q+0x160/0x290
>>> [  759.534736] [c0000000fffd3f30] [c00000000028eb64] generic_handle_ir=
q+0x54/0x80
>>> [  759.534829] [c0000000fffd3f50] [c000000000015c14] __do_irq+0x214/0x=
390
>>> [  759.534908] [c0000000fffd3f90] [c000000000015fec] do_IRQ+0x1fc/0x24=
0
>>> [  759.534987] [c000000007877930] [c000000000015f44] do_IRQ+0x154/0x24=
0
>>> [  759.535066] [c0000000078779c0] [c000000000009240] hardware_interrup=
t_common_virt+0x1b0/0x1c0
>>> [  759.535174] --- interrupt: 500 at plpar_hcall_norets_notrace+0x18/0=
x24
>>> [  759.535253] NIP:  c00000000010d9a8 LR: c000000001009994 CTR: c00000=
003fffee00
>>> [  759.535342] REGS: c000000007877a30 TRAP: 0500   Tainted: G        W=
          (5.13.0-rc2-00382-g1d349b93923f)
>>> [  759.535461] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 44000224  XER: 20000000
>>> [  759.535583] CFAR: c0000000001bde6c IRQMASK: 0
>>> [  759.535583] GPR00: 0000000024000224 c000000007877cd0 c000000001c5dc=
00 0000000000000000
>>> [  759.535583] GPR04: c000000001b48e58 0000000000000001 0000000115cee6=
b0 00000000fda10000
>>> [  759.535583] GPR08: 00000000fda10000 0000000000000000 00000000000000=
00 000000000098967f
>>> [  759.535583] GPR12: c000000001009cc0 c00000003fffee00 00000000000000=
00 0000000000000000
>>> [  759.535583] GPR16: 0000000000000000 0000000000000000 00000000000000=
00 0000000000000000
>>> [  759.535583] GPR20: 0000000000000000 0000000000000000 00000000000000=
00 c000000001b48e58
>>> [  759.535583] GPR24: c000000001ca9158 000000b0d710f49a 00000000000000=
00 0000000000000001
>>> [  759.535583] GPR28: c000000001c9ce05 0000000000000001 c0000000018f21=
e0 c0000000018f21e8
>>> [  759.536361] NIP [c00000000010d9a8] plpar_hcall_norets_notrace+0x18/=
0x24
>>> [  759.536425] LR [c000000001009994] check_and_cede_processor+0x34/0x7=
0
>>> [  759.536497] --- interrupt: 500
>>> [  759.536533] [c000000007877cd0] [c000000001009980] check_and_cede_pr=
ocessor+0x20/0x70 (unreliable)
>>> [  759.536617] [c000000007877d30] [c000000001009dc0] shared_cede_loop+=
0x100/0x220
>>> [  759.536698] [c000000007877db0] [c00000000100635c] cpuidle_enter_sta=
te+0x2cc/0x670
>>> [  759.536766] [c000000007877e20] [c00000000100679c] cpuidle_enter+0x4=
c/0x70
>>> [  759.536823] [c000000007877e60] [c000000000234f64] call_cpuidle+0x74=
/0x90
>>> [  759.536879] [c000000007877e80] [c000000000235570] do_idle+0x340/0x4=
00
>>> [  759.536935] [c000000007877f00] [c0000000002359f4] cpu_startup_entry=
+0x44/0x50
>>> [  759.537003] [c000000007877f30] [c00000000006ac54] start_secondary+0=
x2b4/0x2c0
>>> [  759.537072] [c000000007877f90] [c00000000000c754] start_secondary_p=
rolog+0x10/0x14
>>> [  759.537138] Instruction dump:
>>> [  759.537171] 60000000 2fa30000 419e01b0 7fc5f378 7fa6eb78 7f64db78 7=
f43d378 480be475
>>> [  759.537242] 60000000 e95fff58 7fbd5040 409d00ac <0fe00000> e8cf0008=
 e92f0000 2fa60000
>>> [  759.537315] irq event stamp: 1110413
>>> [  759.537347] hardirqs last  enabled at (1110413): [<c000000000016d14=
>] prep_irq_for_idle+0x44/0x70
>>> [  759.537431] hardirqs last disabled at (1110412): [<c000000000235388=
>] do_idle+0x158/0x400
>>> [  759.537497] softirqs last  enabled at (1110378): [<c0000000012ae818=
>] __do_softirq+0x5e8/0x680
>>> [  759.537573] softirqs last disabled at (1110369): [<c0000000001dc56c=
>] irq_exit+0x15c/0x1e0
>>> [  759.537641] ---[ end trace 6c0ed3a64655c792 ]---
>>> [  759.537688] BTRFS critical (device vdc): bad ordered extent account=
ing, root=3D5 ino=3D348 OE offset=3D741376 OE len=3D94208 to_dec=3D4096 le=
ft=3D0
>>> [  759.538033] ------------[ cut here ]------------
>>> [  759.538204] BTRFS: Transaction aborted (error -22)
>>> [  759.538423] BTRFS warning (device vdc): Skipping commit of aborted =
transaction.
>>> [  759.538521] WARNING: CPU: 3 PID: 381 at fs/btrfs/file.c:1131 btrfs_=
mark_extent_written+0x26c/0xf00
>>> [  759.538712] BTRFS: error (device vdc) in cleanup_transaction:1978: =
errno=3D-30 Readonly filesystem
>>> [  759.538783] Modules linked in:
>>> [  759.538785] CPU: 3 PID: 381 Comm: kworker/u16:4 Tainted: G        W=
         5.13.0-rc2-00382-g1d349b93923f #34
>>> [  759.538788] Workqueue: btrfs-endio-write btrfs_work_helper
>>> [  759.538791] NIP:  c000000000a2eeec LR: c000000000a2eee8 CTR: c00000=
0000e5fd30
>>> [  759.538793] REGS: c00000000c347620 TRAP: 0700   Tainted: G        W=
          (5.13.0-rc2-00382-g1d349b93923f)
>>> [  759.538795] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 48002222  XER: 20000000
>>> [  759.538808] CFAR: c0000000001cea40 IRQMASK: 0
>>> [  759.538808] GPR00: c000000000a2eee8 c00000000c3478c0 c000000001c5dc=
00 0000000000000026
>>> [  759.538808] GPR04: c000000000289310 0000000000000000 00000000000000=
27 c0000000ff507e98
>>> [  759.538808] GPR08: 0000000000000023 0000000000000000 c00000000d2900=
80 c00000000c34740f
>>> [  759.538808] GPR12: 0000000000002200 c00000003ffeae00 c0000000002135=
68 0000000000000002
>>> [  759.538808] GPR16: 000000000000006c 0000000000000000
>>> [  759.538967] BTRFS info (device vdc): forced readonly
>>> [  759.538997] c00000000c347ac8 0000000000000000
>>> [  759.538997] GPR20: 0000000000000000 000000000000015c 00000000000000=
24 00000000000cc000
>>> [  759.538997] GPR24: 0000000000000001 c0000000123da000 c000000014d0e3=
28 00000000000b5000
>>> [  759.538997] GPR28: c000000014b401c0 c0000000428a8348 0000000000000d=
9f c00000001f980008
>>> [  759.540013] NIP [c000000000a2eeec] btrfs_mark_extent_written+0x26c/=
0xf00
>>> [  759.540067] LR [c000000000a2eee8] btrfs_mark_extent_written+0x268/0=
xf00
>>> [  759.540118] Call Trace:
>>> [  759.540139] [c00000000c3478c0] [c000000000a2eee8] btrfs_mark_extent=
_written+0x268/0xf00 (unreliable)
>>> [  759.540211] [c00000000c347a50] [c000000000a23ba4] btrfs_finish_orde=
red_io+0x3a4/0xbd0
>>> [  759.540274] [c00000000c347ba0] [c000000000a64360] btrfs_work_helper=
+0x260/0x8e0
>>> [  759.540335] [c00000000c347c40] [c000000000206954] process_one_work+=
0x434/0x7d0
>>> [  759.540398] [c00000000c347d10] [c000000000206ff4] worker_thread+0x3=
04/0x570
>>> [  759.540452] [c00000000c347da0] [c00000000021371c] kthread+0x1bc/0x1=
d0
>>> [  759.540504] [c00000000c347e10] [c00000000000d6ec] ret_from_kernel_t=
hread+0x5c/0x70
>>> [  759.540566] Instruction dump:
>>> [  759.540597] 7d4048a8 7d474378 7ce049ad 40c2fff4 7c0004ac 71490008 4=
082001c 3c62ffa0
>>> [  759.540665] 3880ffea 38635040 4b79faf5 60000000 <0fe00000> 3c82ff6d=
 7f83e378 38c0ffea
>>> [  759.540731] irq event stamp: 888416
>>> [  759.540762] hardirqs last  enabled at (888415): [<c0000000012ad654>=
] _raw_spin_unlock_irq+0x44/0x80
>>> [  759.540832] hardirqs last disabled at (888416): [<c0000000012a1cfc>=
] __schedule+0x31c/0xce0
>>> [  759.540895] softirqs last  enabled at (887252): [<c000000000465ecc>=
] wb_wakeup_delayed+0x8c/0xb0
>>> [  759.540968] softirqs last disabled at (887248): [<c000000000465e98>=
] wb_wakeup_delayed+0x58/0xb0
>>> [  759.541039] ---[ end trace 6c0ed3a64655c793 ]---
>>> [  759.541090] BTRFS: error (device vdc) in btrfs_mark_extent_written:=
1131: errno=3D-22 unknown
>>> [  759.541169] ------------[ cut here ]------------
>>> [  759.541211] WARNING: CPU: 3 PID: 381 at fs/btrfs/extent_map.c:306 u=
npin_extent_cache+0x78/0x140
>>> [  759.541282] Modules linked in:
>>> [  759.541313] CPU: 3 PID: 381 Comm: kworker/u16:4 Tainted: G        W=
         5.13.0-rc2-00382-g1d349b93923f #34
>>> [  759.541403] Workqueue: btrfs-endio-write btrfs_work_helper
>>> [  759.541445] NIP:  c000000000a334c8 LR: c000000000a334b4 CTR: 000000=
0000000000
>>> [  759.541505] REGS: c00000000c347750 TRAP: 0700   Tainted: G        W=
          (5.13.0-rc2-00382-g1d349b93923f)
>>> [  759.541587] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 84002428  XER: 20000000
>>> [  759.541667] CFAR: c000000000a3303c IRQMASK: 0
>>> [  759.541667] GPR00: c000000000a334b4 c00000000c3479f0 c000000001c5dc=
00 c00000002d2ba508
>>> [  759.541667] GPR04: 00000000000b0000 0000000000017000 00000000000000=
01 0000000000000001
>>> [  759.541667] GPR08: 0000000000000002 0000000000000002 00000000000000=
01 c000000001a20050
>>> [  759.541667] GPR12: 0000000000002200 c00000003ffeae00 c0000000002135=
68 c000000009ed1e40
>>> [  759.541667] GPR16: c000000011cd4000 c000000014d0e7e0 c00000000c347a=
c8 0000000000000001
>>> [  759.541667] GPR20: 0000000000000000 c000000014d0e3e8 00000000000000=
24 c0000000123da000
>>> [  759.541667] GPR24: 0000000000000020 0000000000017000 c000000014d0e3=
28 0000000000000009
>>> [  759.541667] GPR28: 00000000000b5000 c000000014d0e3a8 c000000014d0e3=
88 c00000002d2ba508
>>> [  759.542201] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x140
>>> [  759.542253] LR [c000000000a334b4] unpin_extent_cache+0x64/0x140
>>> [  759.542330] Call Trace:
>>> [  759.542351] [c00000000c3479f0] [c000000000a334b4] unpin_extent_cach=
e+0x64/0x140 (unreliable)
>>> [  759.542485] [c00000000c347a50] [c000000000a23d28] btrfs_finish_orde=
red_io+0x528/0xbd0
>>> [  759.542547] [c00000000c347ba0] [c000000000a64360] btrfs_work_helper=
+0x260/0x8e0
>>> [  759.542610] [c00000000c347c40] [c000000000206954] process_one_work+=
0x434/0x7d0
>>> [  759.542672] [c00000000c347d10] [c000000000206ff4] worker_thread+0x3=
04/0x570
>>> [  759.542726] [c00000000c347da0] [c00000000021371c] kthread+0x1bc/0x1=
d0
>>> [  759.542778] [c00000000c347e10] [c00000000000d6ec] ret_from_kernel_t=
hread+0x5c/0x70
>>> [  759.542844] Instruction dump:
>>> [  759.542878] 4887a5d1 60000000 7f84e378 7fc3f378 38c00001 e8a10028 4=
bfff949 7c7f1b79
>>> [  759.542947] 41820010 e89f0018 7fa4e000 419e000c <0fe00000> 41820088=
 fb7f0060 395f0068
>>> [  759.543016] irq event stamp: 888416
>>> [  759.543046] hardirqs last  enabled at (888415): [<c0000000012ad654>=
] _raw_spin_unlock_irq+0x44/0x80
>>> [  759.543118] hardirqs last disabled at (888416): [<c0000000012a1cfc>=
] __schedule+0x31c/0xce0
>>> [  759.543181] softirqs last  enabled at (887252): [<c000000000465ecc>=
] wb_wakeup_delayed+0x8c/0xb0
>>> [  759.543254] softirqs last disabled at (887248): [<c000000000465e98>=
] wb_wakeup_delayed+0x58/0xb0
>>> [  759.543329] ---[ end trace 6c0ed3a64655c794 ]---
>>> [  759.572677] BTRFS info (device vdc): balance: ended with status: -3=
0
>>> [  759.602897] BUG: Unable to handle kernel data access on write at 0x=
6b6b6b6b6b6b6b6b
>>> [  759.603041] Faulting instruction address: 0xc000000000c31af4
>>> cpu 0x5: Vector: 380 (Data SLB Access) at [c00000001fbd6fc0]
>>>       pc: c000000000c31af4: rb_insert_color+0x54/0x1d0
>>>       lr: c000000000a3abf4: tree_insert+0x94/0xb0
>>>       sp: c00000001fbd7260
>>>      msr: 800000000280b033
>>>      dar: 6b6b6b6b6b6b6b6b
>>>     current =3D 0xc000000022536580
>>>     paca    =3D 0xc00000003ffe8a00	 irqmask: 0x03	 irq_happened: 0x01
>>>       pid   =3D 20914, comm =3D kworker/u16:1
>>> Linux version 5.13.0-rc2-00382-g1d349b93923f (root@ltctulc6a-p1) (gcc =
(Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30=
) #34 SMP Tue May 25 07:53:29 CDT 2021
>>> enter ? for help
>>> [link register   ] c000000000a3abf4 tree_insert+0x94/0xb0
>>> [c00000001fbd7260] c00000000059d670 igrab+0x60/0xa0 (unreliable)
>>> [c00000001fbd7290] c000000000a3b110 __btrfs_add_ordered_extent+0x360/0=
x6c0
>>> [c00000001fbd7350] c000000000a275a8 cow_file_range+0x308/0x580
>>> [c00000001fbd7460] c000000000a28a70 btrfs_run_delalloc_range+0x220/0x7=
70
>>> [c00000001fbd7520] c000000000a45e70 writepage_delalloc+0xd0/0x260
>>> [c00000001fbd75b0] c000000000a49798 __extent_writepage+0x508/0x6a0
>>> [c00000001fbd7670] c000000000a49d94 extent_write_cache_pages+0x464/0x6=
b0
>>> [c00000001fbd77c0] c000000000a4b35c extent_writepages+0x5c/0x100
>>> [c00000001fbd7820] c000000000a0f870 btrfs_writepages+0x20/0x40
>>> [c00000001fbd7840] c00000000042fa84 do_writepages+0x64/0x100
>>> [c00000001fbd7870] c0000000005c151c __writeback_single_inode+0x1dc/0x9=
40
>>> [c00000001fbd78d0] c0000000005c5068 writeback_sb_inodes+0x418/0x770
>>> [c00000001fbd79c0] c0000000005c5484 __writeback_inodes_wb+0xc4/0x140
>>> [c00000001fbd7a20] c0000000005c580c wb_writeback+0x30c/0x6e0
>>> [c00000001fbd7af0] c0000000005c6f4c wb_workfn+0x37c/0x8e0
>>> [c00000001fbd7c40] c000000000206954 process_one_work+0x434/0x7d0
>>> [c00000001fbd7d10] c000000000206ff4 worker_thread+0x304/0x570
>>> [c00000001fbd7da0] c00000000021371c kthread+0x1bc/0x1d0
>>> [c00000001fbd7e10] c00000000000d6ec ret_from_kernel_thread+0x5c/0x70
>>>
>>>
>>> While writing this email, I thought of checking the some obvious error=
 handling
>>> in function btrfs_mark_extent_written(). I think we definitely this be=
low patch,
>>> however there could be something else too which I am missing from btrf=
s
>>> functionality perspective. But I thought below might help.
>>>
>>> I haven't yet tested it though.
>>>
>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>> index e307fbe398f0..c47f406ce9c1 100644
>>> --- a/fs/btrfs/file.c
>>> +++ b/fs/btrfs/file.c
>>> @@ -1097,7 +1097,7 @@ int btrfs_mark_extent_written(struct btrfs_trans=
_handle *trans,
>>>           int del_nr =3D 0;
>>>           int del_slot =3D 0;
>>>           int recow;
>>> -       int ret;
>>> +       int ret =3D 0;
>>>           u64 ino =3D btrfs_ino(inode);
>>>
>>>           path =3D btrfs_alloc_path();
>>> @@ -1318,7 +1318,7 @@ int btrfs_mark_extent_written(struct btrfs_trans=
_handle *trans,
>>>           }
>>>    out:
>>>           btrfs_free_path(path);
>>> -       return 0;
>>> +       return ret;
>>>    }
>>>
>>>    /*
>>>
>>>
>>> Thanks
>>> -ritesh
>>>
