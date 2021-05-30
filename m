Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B910394EF0
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 May 2021 03:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhE3Bv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 21:51:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:38395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhE3Bv6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 21:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622339416;
        bh=TtsUiOPLfXnLM7dogUmiUvHq64EXIwvCvInswv3DohM=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=FvJAvA6VGn13o9+ASzT++C5QAnN5cse8KoUNT+P3AH/SByIG1enQNCqlyPQnLSk7B
         KER9lfG8IQrK3TOyduWL7v7mFXcD69ituIgPCGzokxV4exSg92YOHRrXGPHtBjmaxF
         vZNdbuD6T6s3WHhd8GCZ+PHB1L/KVAeqVxlTslAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1lsIiG3Gkh-00Wq5Y; Sun, 30
 May 2021 03:50:16 +0200
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
 <05a57be6-44f7-e243-dfdb-a6467b056bdc@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <2077a832-6726-525c-95ef-71b95a79f035@gmx.com>
Date:   Sun, 30 May 2021 09:50:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <05a57be6-44f7-e243-dfdb-a6467b056bdc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iYACCwrvHtYcPteWfXeftxbGlmCFTe5UaC1uNuA37OvBKFGunPm
 NKH9RLJL30WXPOCl2Lz6f3viU7MlZ43l2r1rLMWGnc4yxeuNoVsakcZnehlNAV42bjRIZGc
 PUDd2/x+OzuMpJSyyEeLeWEcl09Hc8h8CTGdD+SNvvSHyILLJmtyXLroggfP9+3WtiHBwTy
 YvCbWsXBnb+7a8tbYjwkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+7enaegwpO0=:SeEXUrO1AjmjoCsj7d30vC
 AzKiAKaGCnmdkvbRfiTrenAmGNlaZb0IDBNT4fGD2yipxE4PgXITMaMR0BtqmzsThLLStXOTy
 1S03yMsor/1jfW7FxGFAF6HkExNVi4PqaW2cquN8hSAwQNn4s/ZJbnQvkwzCT887y2TC8pKNe
 71GNSkbtSqIrI+dYRlm/C29x/BgHEE6rnRFu+A34jQKzEsw3V1ywNx5EZSFTvusqC6kUrIs9k
 cu6qJmn6ovqJEfZLEXELkWgK289Y/0cpEnrL3nkJDVgKEbfN8aPZmO/ShJlPxwAdlGafoxpwy
 cJmhX1elNB5LmvCmhH+ud3YlQe9VpqBIErmhGVrkwKdiM/cxJgMShjbDRQkHuiJzAh54ibP3g
 u2U8glgfbQON/waPyZtH3/M927w+6uJvy7M5+1/dpPcSYmG6yPADzuAkfhwjglznR4SFqVFin
 bd44PsBPlaouOK12yWmN+Zhmqo3CyefjkXgILFCVTSAPEcTSn68yvnu3fe0OjnjxDcWG9/Ya+
 5mudPz6yvF7CS44hr+4YLT5xZNYkb4uscwVTYVIrke7SaUBu9gJejfQvtdtsfzV7ZoPWhb0Fb
 kIgYfSq6Jh62k7nLkoPjq3zhEKomIlAnZRG7AgB2aXBaLMo478vk1CH+nUqzURPNSnU5uvLdK
 M6sHa+iCtT2UhbxzTDPJjQ3d5QkrAWQDcRoweUB0W8KFRwj3eT1ounrB5tyR124A4I9NySLGP
 f6Aat/iLq3Cqyv1qdLLP8BBRSpbhPH+/uJh6YJBv9jkItAu4PfkVrcmWo2Zu5lB9d4W36/d+R
 7hjzPJ6V88gmnxh4ohaNnN8j/dWWibXeHolkZpvrh+krnx1QNdqY8Ab1J8OqxsOsDs7nUQBkT
 piruHziDe62SSGAAHh+IEUYQvM+5dtG27E9vsmP1c2ZsMwKXDAj/SakhHzuMtoI3Ft5J7ACch
 Yxy6zsJQkFqFRazRH/pXtREIqTxtX22SuGowB98w1AOakSb9RRPJxEnq9Eh96DJknJifVyp+J
 aPfyj09cl8ugYQrmWgS8gNw76jN99/gmetIZwBpGyeOG4ac77uGx05fgao2tHmShgJ3B4fK3h
 dpoFnyu6kGSkqxBnUxCtjz4dD3X6OvAtbaP2KTj2MsxPDQxKVFOVxVHkhj1t322DvhKTBEy/M
 i6RprVSjuOcITqIpoqvb4IdUGecXbZj18BVu9DQGFSe4Rd+MSWwHCTYBLXRmj05vAtaDUtRsK
 fVqCaW5jvZq09NVoI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]
>
> I got this reproduce once too.

Now much easier to reproduce on my new ARM "toys".

It's RPI CM4 overcloked to 2G, with 8G ram, x1 lane NVME driver, and
running KVM for my test machine, with unsafe cache for the VM disk files
to provide better performance.


Now it's not only much faster overall than my old RK3399 board, but also
much easier to reproduce the btrfs/062 warning than the Power8 VM.

The reproducibility is 1/2~1/3, and only need to run btrfs/062 in a row.

 From the extra info, it's already showing some pattern:

- The inode is regular inode, not data reloc inode
   This means, it's not the balance causing the problem, but the fsstress
   + defrag part.

- The found em is always page aligned, while the expected range is not
   This mostly shows that, the em is created by defrag, but the ordered
   range is from other sector-aligned operations.

For now, I prefer to disable defrag as old branches did.

The full page defrag is already racy, and the full subpage defrag is
already coming soon, no need to let unsafe defrag to slow the full
patchset down.

I'll update the branch soon.

Thanks,
Qu

>
> What I see is it's hanging at the data reloc inode writeback.
> But not sure about the cause yet.
>
> Let me continue testing, with the -g auto to reproduce it and with extra
> trace events to catch it.
>
> Thanks,
> Qu
>
>> If you want I can provide those details too.
>>
>> -ritesh
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Can you pls take a look at it. Please let me know if anything will
>>>> be needed
>>>> from my end on this. Looking at the logs, I am guessing somewhere
>>>> the error is
>>>> not properly handeled and we are accessing a freed up pointer or
>>>> something.
>>>>
>>>> ./check -i 20 tests/btrfs/062
>>>>
>>>>
>>>> [=C2=A0 680.370377] run fstests btrfs/062 at 2021-05-26 13:20:18
>>>> <...>
>>>> [=C2=A0 715.900314] BTRFS info (device vdc): setting incompat feature
>>>> flag for COMPRESS_LZO (0x8)
>>>> [=C2=A0 716.203818] ------------[ cut here ]------------
>>>> [=C2=A0 716.204056] WARNING: CPU: 1 PID: 1033 at
>>>> fs/btrfs/extent_map.c:306 unpin_extent_cache+0x78/0x140
>>>> [=C2=A0 716.204347] Modules linked in:
>>>> [=C2=A0 716.204412] CPU: 1 PID: 1033 Comm: kworker/u16:9 Tainted:
>>>> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.13.0-rc2-00382-g1d349b93923f #34
>>>> [=C2=A0 716.204596] Workqueue: btrfs-endio-write btrfs_work_helper
>>>> [=C2=A0 716.204779] NIP:=C2=A0 c000000000a334c8 LR: c000000000a334b4 =
CTR:
>>>> 0000000000000000
>>>> [=C2=A0 716.204898] REGS: c000000023fb7750 TRAP: 0700=C2=A0=C2=A0 Tai=
nted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5.13.0-rc2-0=
0382-g1d349b93923f)
>>>> [=C2=A0 716.205053] MSR:=C2=A0 800000000282b033
>>>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=C2=A0 CR: 84002428=C2=A0 XER: 20000=
000
>>>> [=C2=A0 716.205232] CFAR: c000000000a3303c IRQMASK: 0
>>>> [=C2=A0 716.205232] GPR00: c000000000a334b4 c000000023fb79f0
>>>> c000000001c5dc00 c00000003a780008
>>>> [=C2=A0 716.205232] GPR04: 0000000000350000 0000000000019000
>>>> 0000000000000001 0000000000000001
>>>> [=C2=A0 716.205232] GPR08: 0000000000000002 0000000000000002
>>>> 0000000000000001 0000000000000001
>>>> [=C2=A0 716.205232] GPR12: 0000000000002200 c00000003fffee00
>>>> c000000022e65810 0000000000102000
>>>> [=C2=A0 716.205232] GPR16: c000000011cd4000 c000000014d03620
>>>> c000000023fb7ac8 0000000000000000
>>>> [=C2=A0 716.205232] GPR20: 0000000000000000 c000000014d03228
>>>> 0000000000004024 c00000002b50a000
>>>> [=C2=A0 716.205232] GPR24: 0000000000004020 0000000000019000
>>>> c000000014d03168 0000000000000007
>>>> [=C2=A0 716.205232] GPR28: 000000000035a000 c000000014d031e8
>>>> c000000014d031c8 c00000003a780008
>>>> [=C2=A0 716.206237] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x=
140
>>>> [=C2=A0 716.206335] LR [c000000000a334b4] unpin_extent_cache+0x64/0x1=
40
>>>> [=C2=A0 716.206447] Call Trace:
>>>> [=C2=A0 716.206487] [c000000023fb79f0] [c000000000a334b4]
>>>> unpin_extent_cache+0x64/0x140 (unreliable)
>>>> [=C2=A0 716.206624] [c000000023fb7a50] [c000000000a23cfc]
>>>> btrfs_finish_ordered_io+0x4fc/0xbd0
>>>> [=C2=A0 716.206740] [c000000023fb7ba0] [c000000000a64360]
>>>> btrfs_work_helper+0x260/0x8e0
>>>> [=C2=A0 716.206861] [c000000023fb7c40] [c000000000206954]
>>>> process_one_work+0x434/0x7d0
>>>> [=C2=A0 716.206989] [c000000023fb7d10] [c000000000206ff4]
>>>> worker_thread+0x304/0x570
>>>> [=C2=A0 716.207088] [c000000023fb7da0] [c00000000021371c]
>>>> kthread+0x1bc/0x1d0
>>>> [=C2=A0 716.207186] [c000000023fb7e10] [c00000000000d6ec]
>>>> ret_from_kernel_thread+0x5c/0x70
>>>> [=C2=A0 716.207304] Instruction dump:
>>>> [=C2=A0 716.207364] 4887a5d1 60000000 7f84e378 7fc3f378 38c00001 e8a1=
0028
>>>> 4bfff949 7c7f1b79
>>>> [=C2=A0 716.207486] 41820010 e89f0018 7fa4e000 419e000c <0fe00000>
>>>> 41820088 fb7f0060 395f0068
>>>> [=C2=A0 716.207607] irq event stamp: 0
>>>> [=C2=A0 716.207665] hardirqs last=C2=A0 enabled at (0): [<00000000000=
00000>] 0x0
>>>> [=C2=A0 716.207763] hardirqs last disabled at (0): [<c0000000001cb190=
>]
>>>> copy_process+0x760/0x1be0
>>>> [=C2=A0 716.207881] softirqs last=C2=A0 enabled at (0): [<c0000000001=
cb190>]
>>>> copy_process+0x760/0x1be0
>>>> [=C2=A0 716.207997] softirqs last disabled at (0): [<0000000000000000=
>] 0x0
>>>> [=C2=A0 716.208098] ---[ end trace 6c0ed3a64655c790 ]---
>>>> [=C2=A0 716.424792] BTRFS info (device vdc): balance: start -d -m -s
>>>> [=C2=A0 717.803034] BTRFS info (device vdc): relocating block group
>>>> 307232768 flags data|raid0
>>>> [=C2=A0 720.496353] BTRFS info (device vdc): found 296 extents, stage=
:
>>>> move data extents
>>>> [=C2=A0 720.952379] BTRFS info (device vdc): found 260 extents, stage=
:
>>>> update data pointers
>>>> [=C2=A0 721.393848] BTRFS info (device vdc): relocating block group
>>>> 38797312 flags metadata|raid0
>>>> [=C2=A0 721.864427] BTRFS info (device vdc): found 80 extents, stage:
>>>> move data extents
>>>> [=C2=A0 722.210788] BTRFS info (device vdc): relocating block group
>>>> 22020096 flags system|raid0
>>>> [=C2=A0 722.536611] BTRFS info (device vdc): found 1 extents, stage: =
move
>>>> data extents
>>>> [=C2=A0 722.887924] BTRFS info (device vdc): balance: ended with stat=
us: 0
>>>> <...>
>>>> [=C2=A0 749.122205] BTRFS info (device vdc): balance: start -d -m -s
>>>> [=C2=A0 749.317906] Page cache invalidation failure on direct I/O.
>>>> Possible data corruption due to collision with buffered I/O!
>>>> [=C2=A0 749.318042] File: /vdc/stressdir/p4/f4 PID: 6002 Comm: fsstre=
ss
>>>> [=C2=A0 751.201149] BTRFS info (device vdc): relocating block group
>>>> 298844160 flags data|raid1
>>>> [=C2=A0 753.219675] BTRFS info (device vdc): found 365 extents, stage=
:
>>>> move data extents
>>>> [=C2=A0 753.570365] BTRFS info (device vdc): found 339 extents, stage=
:
>>>> update data pointers
>>>> [=C2=A0 753.890819] BTRFS info (device vdc): relocating block group
>>>> 30408704 flags metadata|raid1
>>>> [=C2=A0 754.219420] BTRFS info (device vdc): found 77 extents, stage:
>>>> move data extents
>>>> [=C2=A0 754.553047] BTRFS info (device vdc): relocating block group
>>>> 22020096 flags system|raid1
>>>> [=C2=A0 754.847516] BTRFS info (device vdc): found 1 extents, stage: =
move
>>>> data extents
>>>> [=C2=A0 755.162938] BTRFS info (device vdc): balance: ended with stat=
us: 0
>>>> [=C2=A0 756.146222] BTRFS info (device vdc): scrub: started on devid =
1
>>>> [=C2=A0 756.147147] BTRFS info (device vdc): scrub: started on devid =
2
>>>> [=C2=A0 756.147206] BTRFS info (device vdc): scrub: started on devid =
4
>>>> [=C2=A0 756.147237] BTRFS info (device vdc): scrub: started on devid =
3
>>>> [=C2=A0 756.150075] BTRFS info (device vdc): scrub: finished on devid=
 4
>>>> with status: 0
>>>> [=C2=A0 756.156601] BTRFS info (device vdc): scrub: finished on devid=
 3
>>>> with status: 0
>>>> [=C2=A0 756.486566] BTRFS info (device vdc): scrub: finished on devid=
 2
>>>> with status: 0
>>>> [=C2=A0 756.846646] BTRFS info (device vdc): scrub: finished on devid=
 1
>>>> with status: 0
>>>> [=C2=A0 758.205162] BTRFS: device fsid
>>>> 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf devid 1 transid 5 /dev/vdc
>>>> scanned by systemd-udevd (6342)
>>>> [=C2=A0 758.220277] BTRFS: device fsid
>>>> 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf devid 2 transid 5 /dev/vdi
>>>> scanned by mkfs.btrfs (6340)
>>>> [=C2=A0 758.220436] BTRFS: device fsid
>>>> 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf devid 3 transid 5 /dev/vdj
>>>> scanned by mkfs.btrfs (6340)
>>>> [=C2=A0 758.226954] BTRFS: device fsid
>>>> 045ea8fc-4c17-48d3-9c38-7d5dad85c7bf devid 4 transid 5 /dev/vdk
>>>> scanned by mkfs.btrfs (6340)
>>>> [=C2=A0 758.254977] BTRFS info (device vdc): disk space caching is en=
abled
>>>> [=C2=A0 758.255099] BTRFS info (device vdc): has skinny extents
>>>> [=C2=A0 758.255151] BTRFS warning (device vdc): read-write for sector
>>>> size 4096 with page size 65536 is experimental
>>>> [=C2=A0 758.271336] BTRFS info (device vdc): checking UUID tree
>>>> [=C2=A0 758.799031] BTRFS info (device vdc): balance: start -d -m -s
>>>> [=C2=A0 759.522570] ------------[ cut here ]------------
>>>> [=C2=A0 759.525038] WARNING: CPU: 3 PID: 381 at fs/btrfs/extent_map.c=
:306
>>>> unpin_extent_cache+0x78/0x140
>>>> [=C2=A0 759.525234] Modules linked in:
>>>> [=C2=A0 759.525307] CPU: 3 PID: 381 Comm: kworker/u16:4 Tainted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.13.0-rc2-00382-g1=
d349b93923f #34
>>>> [=C2=A0 759.525448] Workqueue: btrfs-endio-write btrfs_work_helper
>>>> [=C2=A0 759.525501] NIP:=C2=A0 c000000000a334c8 LR: c000000000a334b4 =
CTR:
>>>> 0000000000000000
>>>> [=C2=A0 759.525565] REGS: c00000000c347750 TRAP: 0700=C2=A0=C2=A0 Tai=
nted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5.13.0-rc2-0=
0382-g1d349b93923f)
>>>> [=C2=A0 759.525653] MSR:=C2=A0 800000000282b033
>>>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=C2=A0 CR: 84002448=C2=A0 XER: 20000=
000
>>>> [=C2=A0 759.525726] ------------[ cut here ]------------
>>>> [=C2=A0 759.525787] CFAR: c000000000a3303c IRQMASK: 0
>>>> [=C2=A0 759.525787] GPR00: c000000000a334b4 c00000000c3479f0
>>>> c000000001c5dc00 c00000002d2ba508
>>>> [=C2=A0 759.525871] WARNING: CPU: 1 PID: 0 at fs/btrfs/ordered-data.c=
:408
>>>> btrfs_mark_ordered_io_finished+0x2f8/0x550
>>>> [=C2=A0 759.525966]
>>>> [=C2=A0 759.525966] GPR04:
>>>> [=C2=A0 759.526086] Modules linked in:
>>>> [=C2=A0 759.526087] 00000000000b0000 0000000000017000
>>>> [=C2=A0 759.526134]
>>>> [=C2=A0 759.526164] 0000000000000001
>>>> [=C2=A0 759.526227] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.13.0-rc2-00382-g1=
d349b93923f #34
>>>> [=C2=A0 759.526247] 0000000000000001
>>>> [=C2=A0 759.526294] NIP:=C2=A0 c000000000a3ba88 LR: c000000000a3ba78 =
CTR:
>>>> c000000000a46580
>>>> [=C2=A0 759.526364]
>>>> [=C2=A0 759.526364] GPR08:
>>>> [=C2=A0 759.526410] REGS: c0000000fffd35d0 TRAP: 0700=C2=A0=C2=A0 Tai=
nted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5.13.0-rc2-0=
0382-g1d349b93923f)
>>>> [=C2=A0 759.526510] 0000000000000002
>>>> [=C2=A0 759.526556] MSR:=C2=A0 8000000000029033
>>>> [=C2=A0 759.526642] 0000000000000002
>>>> [=C2=A0 759.526689] <
>>>> [=C2=A0 759.526722] 0000000000000001
>>>> [=C2=A0 759.526772] SF
>>>> [=C2=A0 759.526793] ffffffffffffffff
>>>> [=C2=A0 759.526846] ,EE
>>>> [=C2=A0 759.526869]
>>>> [=C2=A0 759.526869] GPR12:
>>>> [=C2=A0 759.526921] ,ME
>>>> [=C2=A0 759.526942] 0000000000002200
>>>> [=C2=A0 759.526991] ,IR
>>>> [=C2=A0 759.527013] c00000003ffeae00
>>>> [=C2=A0 759.527063] ,DR
>>>> [=C2=A0 759.527085] c000000000213568
>>>> [=C2=A0 759.527132] ,RI
>>>> [=C2=A0 759.527154] c000000009ed1e40
>>>> [=C2=A0 759.527206] ,LE
>>>> [=C2=A0 759.527227]
>>>> [=C2=A0 759.527227] GPR16:
>>>> [=C2=A0 759.527275] >
>>>> [=C2=A0 759.527296] c000000011cd4000
>>>> [=C2=A0 759.527346]=C2=A0=C2=A0 CR: 44084424=C2=A0 XER: 00000000
>>>> [=C2=A0 759.527367] c000000014d0e7e0
>>>> [=C2=A0 759.527426] CFAR: c000000000af8794
>>>> [=C2=A0 759.527457] c00000000c347ac8
>>>> [=C2=A0 759.527509] IRQMASK: 1
>>>> [=C2=A0 759.527541] 0000000000000001
>>>> [=C2=A0 759.527589]
>>>> [=C2=A0 759.527589] GPR00:
>>>> [=C2=A0 759.527612]
>>>> [=C2=A0 759.527612] GPR20:
>>>> [=C2=A0 759.527661] c000000000a3ba78
>>>> [=C2=A0 759.527695] 0000000000000000
>>>> [=C2=A0 759.527746] c0000000fffd3870
>>>> [=C2=A0 759.527777] c000000014d0e3e8
>>>> [=C2=A0 759.527828] c000000001c5dc00
>>>> [=C2=A0 759.527859] 0000000000000024
>>>> [=C2=A0 759.527907] 0000000000000001
>>>> [=C2=A0 759.527939] c0000000123da000
>>>> [=C2=A0 759.527991]
>>>> [=C2=A0 759.527991] GPR04:
>>>> [=C2=A0 759.528021]
>>>> [=C2=A0 759.528021] GPR24:
>>>> [=C2=A0 759.528070] 0000000000000001
>>>> [=C2=A0 759.528105] 0000000000000020
>>>> [=C2=A0 759.528156] 0000000000000000
>>>> [=C2=A0 759.528187] 0000000000017000
>>>> [=C2=A0 759.528239] 0000000000000000
>>>> [=C2=A0 759.528269] c000000014d0e328
>>>> [=C2=A0 759.528321] 00000000000000ff
>>>> [=C2=A0 759.528351] 0000000000000009
>>>> [=C2=A0 759.528400]
>>>> [=C2=A0 759.528400] GPR08:
>>>> [=C2=A0 759.528434]
>>>> [=C2=A0 759.528434] GPR28:
>>>> [=C2=A0 759.528487] 0000000000000001
>>>> [=C2=A0 759.528520] 00000000000b5000
>>>> [=C2=A0 759.528570] 0000000000010003
>>>> [=C2=A0 759.528600] c000000014d0e3a8
>>>> [=C2=A0 759.528646] 0000000000000000
>>>> [=C2=A0 759.528678] c000000014d0e388
>>>> [=C2=A0 759.528725] fffffffffffffffd
>>>> [=C2=A0 759.528757] c00000002d2ba508
>>>> [=C2=A0 759.528810]
>>>> [=C2=A0 759.528810] GPR12:
>>>> [=C2=A0 759.528841]
>>>> [=C2=A0 759.528888] 0000000044002422
>>>> [=C2=A0 759.528925] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x=
140
>>>> [=C2=A0 759.528961] c00000003fffee00
>>>> [=C2=A0 759.528991] LR [c000000000a334b4] unpin_extent_cache+0x64/0x1=
40
>>>> [=C2=A0 759.529812] 00000000000c0000
>>>> [=C2=A0 759.529844] Call Trace:
>>>> [=C2=A0 759.529923] c000000014d0e328
>>>> [=C2=A0 759.529954] [c00000000c3479f0] [c000000000a334b4]
>>>> unpin_extent_cache+0x64/0x140
>>>> [=C2=A0 759.529986]
>>>> [=C2=A0 759.529986] GPR16:
>>>> [=C2=A0 759.530107]=C2=A0 (unreliable)
>>>> [=C2=A0 759.530463] c0000000016680e0
>>>> [=C2=A0 759.530494]
>>>> [=C2=A0 759.530495] [c00000000c347a50] [c000000000a23d28]
>>>> btrfs_finish_ordered_io+0x528/0xbd0
>>>> [=C2=A0 759.530525] c000000000a243d0
>>>> [=C2=A0 759.530557]
>>>> [=C2=A0 759.530588] c00000000da7b530
>>>> [=C2=A0 759.530650] [c00000000c347ba0] [c000000000a64360]
>>>> btrfs_work_helper+0x260/0x8e0
>>>> [=C2=A0 759.530694] 0000000000000080
>>>> [=C2=A0 759.530717]
>>>> [=C2=A0 759.530718] [c00000000c347c40] [c000000000206954]
>>>> process_one_work+0x434/0x7d0
>>>> [=C2=A0 759.530762]
>>>> [=C2=A0 759.530762] GPR20:
>>>> [=C2=A0 759.530826]
>>>> [=C2=A0 759.530870] 0000000000000020
>>>> [=C2=A0 759.530893] [c00000000c347d10] [c000000000206ff4]
>>>> worker_thread+0x304/0x570
>>>> [=C2=A0 759.530980] 0000000000000001
>>>> [=C2=A0 759.531009]
>>>> [=C2=A0 759.531040] 00000000fffffffe
>>>> [=C2=A0 759.531071] [c00000000c347da0] [c00000000021371c]
>>>> kthread+0x1bc/0x1d0
>>>> [=C2=A0 759.531145] 0000000000000001
>>>> [=C2=A0 759.531178]
>>>> [=C2=A0 759.531208]
>>>> [=C2=A0 759.531208] GPR24:
>>>> [=C2=A0 759.531240] [c00000000c347e10] [c00000000000d6ec]
>>>> ret_from_kernel_thread+0x5c/0x70
>>>> [=C2=A0 759.531312] c000000014d0e5b0
>>>> [=C2=A0 759.531344]
>>>> [=C2=A0 759.531374] 0000000000000000
>>>> [=C2=A0 759.531407] Instruction dump:
>>>> [=C2=A0 759.531494] c000000011cd4000
>>>> [=C2=A0 759.531526]
>>>> [=C2=A0 759.531528] 4887a5d1
>>>> [=C2=A0 759.531557] c00c000000093340
>>>> [=C2=A0 759.531589] 60000000
>>>> [=C2=A0 759.531633]
>>>> [=C2=A0 759.531633] GPR28:
>>>> [=C2=A0 759.531665] 7f84e378
>>>> [=C2=A0 759.531695] 00000000000c0000
>>>> [=C2=A0 759.531717] 7fc3f378
>>>> [=C2=A0 759.531762] 0000000000001000
>>>> [=C2=A0 759.531781] 38c00001
>>>> [=C2=A0 759.531825] 00000000000bf000
>>>> [=C2=A0 759.531847] e8a10028
>>>> [=C2=A0 759.531891] c000000022e25710
>>>> [=C2=A0 759.531912] 4bfff949
>>>> [=C2=A0 759.531958]
>>>> [=C2=A0 759.531980] 7c7f1b79
>>>> [=C2=A0 759.532025] NIP [c000000000a3ba88]
>>>> btrfs_mark_ordered_io_finished+0x2f8/0x550
>>>> [=C2=A0 759.532044]
>>>> [=C2=A0 759.532045] 41820010
>>>> [=C2=A0 759.532089] LR [c000000000a3ba78]
>>>> btrfs_mark_ordered_io_finished+0x2e8/0x550
>>>> [=C2=A0 759.532108] e89f0018
>>>> [=C2=A0 759.532138] Call Trace:
>>>> [=C2=A0 759.532157] 7fa4e000
>>>> [=C2=A0 759.532248] [c0000000fffd3870] [c000000000a3ba78]
>>>> btrfs_mark_ordered_io_finished+0x2e8/0x550
>>>> [=C2=A0 759.532267] 419e000c
>>>> [=C2=A0 759.532299]=C2=A0 (unreliable)
>>>> [=C2=A0 759.532355] <0fe00000>
>>>> [=C2=A0 759.532385]
>>>> [=C2=A0 759.532406] 41820088
>>>> [=C2=A0 759.532437] [c0000000fffd3970] [c000000000a149cc]
>>>> btrfs_writepage_endio_finish_ordered+0x19c/0x1d0
>>>> [=C2=A0 759.532505] fb7f0060
>>>> [=C2=A0 759.532535]
>>>> [=C2=A0 759.532557] 395f0068
>>>> [=C2=A0 759.532587] [c0000000fffd39d0] [c000000000a46304]
>>>> end_extent_writepage+0x74/0x2f0
>>>> [=C2=A0 759.532606]
>>>> [=C2=A0 759.532607] irq event stamp: 888416
>>>> [=C2=A0 759.532636]
>>>> [=C2=A0 759.532712] hardirqs last=C2=A0 enabled at (888415):
>>>> [<c0000000012ad654>] _raw_spin_unlock_irq+0x44/0x80
>>>> [=C2=A0 759.532742] [c0000000fffd3a00] [c000000000a466c4]
>>>> end_bio_extent_writepage+0x144/0x270
>>>> [=C2=A0 759.532762] hardirqs last disabled at (888416):
>>>> [<c0000000012a1cfc>] __schedule+0x31c/0xce0
>>>> [=C2=A0 759.532792]
>>>> [=C2=A0 759.532857] softirqs last=C2=A0 enabled at (887252):
>>>> [<c000000000465ecc>] wb_wakeup_delayed+0x8c/0xb0
>>>> [=C2=A0 759.532888] [c0000000fffd3ac0] [c000000000b520f4]
>>>> bio_endio+0x254/0x270
>>>> [=C2=A0 759.532920] softirqs last disabled at (887248):
>>>> [<c000000000465e98>] wb_wakeup_delayed+0x58/0xb0
>>>> [=C2=A0 759.532950]
>>>> [=C2=A0 759.533023] ---[ end trace 6c0ed3a64655c791 ]---
>>>> [=C2=A0 759.533110] [c0000000fffd3b00] [c000000000a624b0]
>>>> btrfs_end_bio+0x1a0/0x200
>>>> [=C2=A0 759.533648] [c0000000fffd3b40] [c000000000b520f4]
>>>> bio_endio+0x254/0x270
>>>> [=C2=A0 759.533757] [c0000000fffd3b80] [c000000000b5a73c]
>>>> blk_update_request+0x46c/0x670
>>>> [=C2=A0 759.533858] [c0000000fffd3c30] [c000000000b6d9a4]
>>>> blk_mq_end_request+0x34/0x1d0
>>>> [=C2=A0 759.533956] [c0000000fffd3c70] [c000000000d6ea4c]
>>>> virtblk_request_done+0x8c/0xb0
>>>> [=C2=A0 759.534089] [c0000000fffd3ca0] [c000000000b6b360]
>>>> blk_mq_complete_request+0x50/0x70
>>>> [=C2=A0 759.534184] [c0000000fffd3cd0] [c000000000d6e74c]
>>>> virtblk_done+0x9c/0x190
>>>> [=C2=A0 759.534264] [c0000000fffd3d30] [c000000000cb9420]
>>>> vring_interrupt+0x140/0x160
>>>> [=C2=A0 759.534359] [c0000000fffd3da0] [c0000000002907b8]
>>>> __handle_irq_event_percpu+0x1e8/0x490
>>>> [=C2=A0 759.534454] [c0000000fffd3e70] [c000000000290aa4]
>>>> handle_irq_event_percpu+0x44/0xc0
>>>> [=C2=A0 759.534548] [c0000000fffd3eb0] [c000000000290b80]
>>>> handle_irq_event+0x60/0xa0
>>>> [=C2=A0 759.534642] [c0000000fffd3ef0] [c000000000297df0]
>>>> handle_fasteoi_irq+0x160/0x290
>>>> [=C2=A0 759.534736] [c0000000fffd3f30] [c00000000028eb64]
>>>> generic_handle_irq+0x54/0x80
>>>> [=C2=A0 759.534829] [c0000000fffd3f50] [c000000000015c14]
>>>> __do_irq+0x214/0x390
>>>> [=C2=A0 759.534908] [c0000000fffd3f90] [c000000000015fec] do_IRQ+0x1f=
c/0x240
>>>> [=C2=A0 759.534987] [c000000007877930] [c000000000015f44] do_IRQ+0x15=
4/0x240
>>>> [=C2=A0 759.535066] [c0000000078779c0] [c000000000009240]
>>>> hardware_interrupt_common_virt+0x1b0/0x1c0
>>>> [=C2=A0 759.535174] --- interrupt: 500 at
>>>> plpar_hcall_norets_notrace+0x18/0x24
>>>> [=C2=A0 759.535253] NIP:=C2=A0 c00000000010d9a8 LR: c000000001009994 =
CTR:
>>>> c00000003fffee00
>>>> [=C2=A0 759.535342] REGS: c000000007877a30 TRAP: 0500=C2=A0=C2=A0 Tai=
nted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5.13.0-rc2-0=
0382-g1d349b93923f)
>>>> [=C2=A0 759.535461] MSR:=C2=A0 800000000280b033
>>>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=C2=A0 CR: 44000224=C2=A0 XER: 20000=
000
>>>> [=C2=A0 759.535583] CFAR: c0000000001bde6c IRQMASK: 0
>>>> [=C2=A0 759.535583] GPR00: 0000000024000224 c000000007877cd0
>>>> c000000001c5dc00 0000000000000000
>>>> [=C2=A0 759.535583] GPR04: c000000001b48e58 0000000000000001
>>>> 0000000115cee6b0 00000000fda10000
>>>> [=C2=A0 759.535583] GPR08: 00000000fda10000 0000000000000000
>>>> 0000000000000000 000000000098967f
>>>> [=C2=A0 759.535583] GPR12: c000000001009cc0 c00000003fffee00
>>>> 0000000000000000 0000000000000000
>>>> [=C2=A0 759.535583] GPR16: 0000000000000000 0000000000000000
>>>> 0000000000000000 0000000000000000
>>>> [=C2=A0 759.535583] GPR20: 0000000000000000 0000000000000000
>>>> 0000000000000000 c000000001b48e58
>>>> [=C2=A0 759.535583] GPR24: c000000001ca9158 000000b0d710f49a
>>>> 0000000000000000 0000000000000001
>>>> [=C2=A0 759.535583] GPR28: c000000001c9ce05 0000000000000001
>>>> c0000000018f21e0 c0000000018f21e8
>>>> [=C2=A0 759.536361] NIP [c00000000010d9a8]
>>>> plpar_hcall_norets_notrace+0x18/0x24
>>>> [=C2=A0 759.536425] LR [c000000001009994] check_and_cede_processor+0x=
34/0x70
>>>> [=C2=A0 759.536497] --- interrupt: 500
>>>> [=C2=A0 759.536533] [c000000007877cd0] [c000000001009980]
>>>> check_and_cede_processor+0x20/0x70 (unreliable)
>>>> [=C2=A0 759.536617] [c000000007877d30] [c000000001009dc0]
>>>> shared_cede_loop+0x100/0x220
>>>> [=C2=A0 759.536698] [c000000007877db0] [c00000000100635c]
>>>> cpuidle_enter_state+0x2cc/0x670
>>>> [=C2=A0 759.536766] [c000000007877e20] [c00000000100679c]
>>>> cpuidle_enter+0x4c/0x70
>>>> [=C2=A0 759.536823] [c000000007877e60] [c000000000234f64]
>>>> call_cpuidle+0x74/0x90
>>>> [=C2=A0 759.536879] [c000000007877e80] [c000000000235570]
>>>> do_idle+0x340/0x400
>>>> [=C2=A0 759.536935] [c000000007877f00] [c0000000002359f4]
>>>> cpu_startup_entry+0x44/0x50
>>>> [=C2=A0 759.537003] [c000000007877f30] [c00000000006ac54]
>>>> start_secondary+0x2b4/0x2c0
>>>> [=C2=A0 759.537072] [c000000007877f90] [c00000000000c754]
>>>> start_secondary_prolog+0x10/0x14
>>>> [=C2=A0 759.537138] Instruction dump:
>>>> [=C2=A0 759.537171] 60000000 2fa30000 419e01b0 7fc5f378 7fa6eb78 7f64=
db78
>>>> 7f43d378 480be475
>>>> [=C2=A0 759.537242] 60000000 e95fff58 7fbd5040 409d00ac <0fe00000>
>>>> e8cf0008 e92f0000 2fa60000
>>>> [=C2=A0 759.537315] irq event stamp: 1110413
>>>> [=C2=A0 759.537347] hardirqs last=C2=A0 enabled at (1110413):
>>>> [<c000000000016d14>] prep_irq_for_idle+0x44/0x70
>>>> [=C2=A0 759.537431] hardirqs last disabled at (1110412):
>>>> [<c000000000235388>] do_idle+0x158/0x400
>>>> [=C2=A0 759.537497] softirqs last=C2=A0 enabled at (1110378):
>>>> [<c0000000012ae818>] __do_softirq+0x5e8/0x680
>>>> [=C2=A0 759.537573] softirqs last disabled at (1110369):
>>>> [<c0000000001dc56c>] irq_exit+0x15c/0x1e0
>>>> [=C2=A0 759.537641] ---[ end trace 6c0ed3a64655c792 ]---
>>>> [=C2=A0 759.537688] BTRFS critical (device vdc): bad ordered extent
>>>> accounting, root=3D5 ino=3D348 OE offset=3D741376 OE len=3D94208 to_d=
ec=3D4096
>>>> left=3D0
>>>> [=C2=A0 759.538033] ------------[ cut here ]------------
>>>> [=C2=A0 759.538204] BTRFS: Transaction aborted (error -22)
>>>> [=C2=A0 759.538423] BTRFS warning (device vdc): Skipping commit of
>>>> aborted transaction.
>>>> [=C2=A0 759.538521] WARNING: CPU: 3 PID: 381 at fs/btrfs/file.c:1131
>>>> btrfs_mark_extent_written+0x26c/0xf00
>>>> [=C2=A0 759.538712] BTRFS: error (device vdc) in
>>>> cleanup_transaction:1978: errno=3D-30 Readonly filesystem
>>>> [=C2=A0 759.538783] Modules linked in:
>>>> [=C2=A0 759.538785] CPU: 3 PID: 381 Comm: kworker/u16:4 Tainted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.13.0-rc2-00382-g1=
d349b93923f #34
>>>> [=C2=A0 759.538788] Workqueue: btrfs-endio-write btrfs_work_helper
>>>> [=C2=A0 759.538791] NIP:=C2=A0 c000000000a2eeec LR: c000000000a2eee8 =
CTR:
>>>> c000000000e5fd30
>>>> [=C2=A0 759.538793] REGS: c00000000c347620 TRAP: 0700=C2=A0=C2=A0 Tai=
nted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5.13.0-rc2-0=
0382-g1d349b93923f)
>>>> [=C2=A0 759.538795] MSR:=C2=A0 800000000282b033
>>>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=C2=A0 CR: 48002222=C2=A0 XER: 20000=
000
>>>> [=C2=A0 759.538808] CFAR: c0000000001cea40 IRQMASK: 0
>>>> [=C2=A0 759.538808] GPR00: c000000000a2eee8 c00000000c3478c0
>>>> c000000001c5dc00 0000000000000026
>>>> [=C2=A0 759.538808] GPR04: c000000000289310 0000000000000000
>>>> 0000000000000027 c0000000ff507e98
>>>> [=C2=A0 759.538808] GPR08: 0000000000000023 0000000000000000
>>>> c00000000d290080 c00000000c34740f
>>>> [=C2=A0 759.538808] GPR12: 0000000000002200 c00000003ffeae00
>>>> c000000000213568 0000000000000002
>>>> [=C2=A0 759.538808] GPR16: 000000000000006c 0000000000000000
>>>> [=C2=A0 759.538967] BTRFS info (device vdc): forced readonly
>>>> [=C2=A0 759.538997] c00000000c347ac8 0000000000000000
>>>> [=C2=A0 759.538997] GPR20: 0000000000000000 000000000000015c
>>>> 0000000000000024 00000000000cc000
>>>> [=C2=A0 759.538997] GPR24: 0000000000000001 c0000000123da000
>>>> c000000014d0e328 00000000000b5000
>>>> [=C2=A0 759.538997] GPR28: c000000014b401c0 c0000000428a8348
>>>> 0000000000000d9f c00000001f980008
>>>> [=C2=A0 759.540013] NIP [c000000000a2eeec]
>>>> btrfs_mark_extent_written+0x26c/0xf00
>>>> [=C2=A0 759.540067] LR [c000000000a2eee8]
>>>> btrfs_mark_extent_written+0x268/0xf00
>>>> [=C2=A0 759.540118] Call Trace:
>>>> [=C2=A0 759.540139] [c00000000c3478c0] [c000000000a2eee8]
>>>> btrfs_mark_extent_written+0x268/0xf00 (unreliable)
>>>> [=C2=A0 759.540211] [c00000000c347a50] [c000000000a23ba4]
>>>> btrfs_finish_ordered_io+0x3a4/0xbd0
>>>> [=C2=A0 759.540274] [c00000000c347ba0] [c000000000a64360]
>>>> btrfs_work_helper+0x260/0x8e0
>>>> [=C2=A0 759.540335] [c00000000c347c40] [c000000000206954]
>>>> process_one_work+0x434/0x7d0
>>>> [=C2=A0 759.540398] [c00000000c347d10] [c000000000206ff4]
>>>> worker_thread+0x304/0x570
>>>> [=C2=A0 759.540452] [c00000000c347da0] [c00000000021371c]
>>>> kthread+0x1bc/0x1d0
>>>> [=C2=A0 759.540504] [c00000000c347e10] [c00000000000d6ec]
>>>> ret_from_kernel_thread+0x5c/0x70
>>>> [=C2=A0 759.540566] Instruction dump:
>>>> [=C2=A0 759.540597] 7d4048a8 7d474378 7ce049ad 40c2fff4 7c0004ac 7149=
0008
>>>> 4082001c 3c62ffa0
>>>> [=C2=A0 759.540665] 3880ffea 38635040 4b79faf5 60000000 <0fe00000>
>>>> 3c82ff6d 7f83e378 38c0ffea
>>>> [=C2=A0 759.540731] irq event stamp: 888416
>>>> [=C2=A0 759.540762] hardirqs last=C2=A0 enabled at (888415):
>>>> [<c0000000012ad654>] _raw_spin_unlock_irq+0x44/0x80
>>>> [=C2=A0 759.540832] hardirqs last disabled at (888416):
>>>> [<c0000000012a1cfc>] __schedule+0x31c/0xce0
>>>> [=C2=A0 759.540895] softirqs last=C2=A0 enabled at (887252):
>>>> [<c000000000465ecc>] wb_wakeup_delayed+0x8c/0xb0
>>>> [=C2=A0 759.540968] softirqs last disabled at (887248):
>>>> [<c000000000465e98>] wb_wakeup_delayed+0x58/0xb0
>>>> [=C2=A0 759.541039] ---[ end trace 6c0ed3a64655c793 ]---
>>>> [=C2=A0 759.541090] BTRFS: error (device vdc) in
>>>> btrfs_mark_extent_written:1131: errno=3D-22 unknown
>>>> [=C2=A0 759.541169] ------------[ cut here ]------------
>>>> [=C2=A0 759.541211] WARNING: CPU: 3 PID: 381 at fs/btrfs/extent_map.c=
:306
>>>> unpin_extent_cache+0x78/0x140
>>>> [=C2=A0 759.541282] Modules linked in:
>>>> [=C2=A0 759.541313] CPU: 3 PID: 381 Comm: kworker/u16:4 Tainted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.13.0-rc2-00382-g1=
d349b93923f #34
>>>> [=C2=A0 759.541403] Workqueue: btrfs-endio-write btrfs_work_helper
>>>> [=C2=A0 759.541445] NIP:=C2=A0 c000000000a334c8 LR: c000000000a334b4 =
CTR:
>>>> 0000000000000000
>>>> [=C2=A0 759.541505] REGS: c00000000c347750 TRAP: 0700=C2=A0=C2=A0 Tai=
nted: G
>>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (5.13.0-rc2-0=
0382-g1d349b93923f)
>>>> [=C2=A0 759.541587] MSR:=C2=A0 800000000282b033
>>>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=C2=A0 CR: 84002428=C2=A0 XER: 20000=
000
>>>> [=C2=A0 759.541667] CFAR: c000000000a3303c IRQMASK: 0
>>>> [=C2=A0 759.541667] GPR00: c000000000a334b4 c00000000c3479f0
>>>> c000000001c5dc00 c00000002d2ba508
>>>> [=C2=A0 759.541667] GPR04: 00000000000b0000 0000000000017000
>>>> 0000000000000001 0000000000000001
>>>> [=C2=A0 759.541667] GPR08: 0000000000000002 0000000000000002
>>>> 0000000000000001 c000000001a20050
>>>> [=C2=A0 759.541667] GPR12: 0000000000002200 c00000003ffeae00
>>>> c000000000213568 c000000009ed1e40
>>>> [=C2=A0 759.541667] GPR16: c000000011cd4000 c000000014d0e7e0
>>>> c00000000c347ac8 0000000000000001
>>>> [=C2=A0 759.541667] GPR20: 0000000000000000 c000000014d0e3e8
>>>> 0000000000000024 c0000000123da000
>>>> [=C2=A0 759.541667] GPR24: 0000000000000020 0000000000017000
>>>> c000000014d0e328 0000000000000009
>>>> [=C2=A0 759.541667] GPR28: 00000000000b5000 c000000014d0e3a8
>>>> c000000014d0e388 c00000002d2ba508
>>>> [=C2=A0 759.542201] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x=
140
>>>> [=C2=A0 759.542253] LR [c000000000a334b4] unpin_extent_cache+0x64/0x1=
40
>>>> [=C2=A0 759.542330] Call Trace:
>>>> [=C2=A0 759.542351] [c00000000c3479f0] [c000000000a334b4]
>>>> unpin_extent_cache+0x64/0x140 (unreliable)
>>>> [=C2=A0 759.542485] [c00000000c347a50] [c000000000a23d28]
>>>> btrfs_finish_ordered_io+0x528/0xbd0
>>>> [=C2=A0 759.542547] [c00000000c347ba0] [c000000000a64360]
>>>> btrfs_work_helper+0x260/0x8e0
>>>> [=C2=A0 759.542610] [c00000000c347c40] [c000000000206954]
>>>> process_one_work+0x434/0x7d0
>>>> [=C2=A0 759.542672] [c00000000c347d10] [c000000000206ff4]
>>>> worker_thread+0x304/0x570
>>>> [=C2=A0 759.542726] [c00000000c347da0] [c00000000021371c]
>>>> kthread+0x1bc/0x1d0
>>>> [=C2=A0 759.542778] [c00000000c347e10] [c00000000000d6ec]
>>>> ret_from_kernel_thread+0x5c/0x70
>>>> [=C2=A0 759.542844] Instruction dump:
>>>> [=C2=A0 759.542878] 4887a5d1 60000000 7f84e378 7fc3f378 38c00001 e8a1=
0028
>>>> 4bfff949 7c7f1b79
>>>> [=C2=A0 759.542947] 41820010 e89f0018 7fa4e000 419e000c <0fe00000>
>>>> 41820088 fb7f0060 395f0068
>>>> [=C2=A0 759.543016] irq event stamp: 888416
>>>> [=C2=A0 759.543046] hardirqs last=C2=A0 enabled at (888415):
>>>> [<c0000000012ad654>] _raw_spin_unlock_irq+0x44/0x80
>>>> [=C2=A0 759.543118] hardirqs last disabled at (888416):
>>>> [<c0000000012a1cfc>] __schedule+0x31c/0xce0
>>>> [=C2=A0 759.543181] softirqs last=C2=A0 enabled at (887252):
>>>> [<c000000000465ecc>] wb_wakeup_delayed+0x8c/0xb0
>>>> [=C2=A0 759.543254] softirqs last disabled at (887248):
>>>> [<c000000000465e98>] wb_wakeup_delayed+0x58/0xb0
>>>> [=C2=A0 759.543329] ---[ end trace 6c0ed3a64655c794 ]---
>>>> [=C2=A0 759.572677] BTRFS info (device vdc): balance: ended with stat=
us: -30
>>>> [=C2=A0 759.602897] BUG: Unable to handle kernel data access on write=
 at
>>>> 0x6b6b6b6b6b6b6b6b
>>>> [=C2=A0 759.603041] Faulting instruction address: 0xc000000000c31af4
>>>> cpu 0x5: Vector: 380 (Data SLB Access) at [c00000001fbd6fc0]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc: c000000000c31af4: rb_insert_color+=
0x54/0x1d0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lr: c000000000a3abf4: tree_insert+0x94=
/0xb0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp: c00000001fbd7260
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 msr: 800000000280b033
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 dar: 6b6b6b6b6b6b6b6b
>>>> =C2=A0=C2=A0=C2=A0 current =3D 0xc000000022536580
>>>> =C2=A0=C2=A0=C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000003ffe8a00=C2=
=A0=C2=A0=C2=A0=C2=A0 irqmask: 0x03=C2=A0=C2=A0=C2=A0=C2=A0 irq_happened:
>>>> 0x01
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 20914, comm =3D kw=
orker/u16:1
>>>> Linux version 5.13.0-rc2-00382-g1d349b93923f (root@ltctulc6a-p1)
>>>> (gcc (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for
>>>> Ubuntu) 2.30) #34 SMP Tue May 25 07:53:29 CDT 2021
>>>> enter ? for help
>>>> [link register=C2=A0=C2=A0 ] c000000000a3abf4 tree_insert+0x94/0xb0
>>>> [c00000001fbd7260] c00000000059d670 igrab+0x60/0xa0 (unreliable)
>>>> [c00000001fbd7290] c000000000a3b110
>>>> __btrfs_add_ordered_extent+0x360/0x6c0
>>>> [c00000001fbd7350] c000000000a275a8 cow_file_range+0x308/0x580
>>>> [c00000001fbd7460] c000000000a28a70
>>>> btrfs_run_delalloc_range+0x220/0x770
>>>> [c00000001fbd7520] c000000000a45e70 writepage_delalloc+0xd0/0x260
>>>> [c00000001fbd75b0] c000000000a49798 __extent_writepage+0x508/0x6a0
>>>> [c00000001fbd7670] c000000000a49d94
>>>> extent_write_cache_pages+0x464/0x6b0
>>>> [c00000001fbd77c0] c000000000a4b35c extent_writepages+0x5c/0x100
>>>> [c00000001fbd7820] c000000000a0f870 btrfs_writepages+0x20/0x40
>>>> [c00000001fbd7840] c00000000042fa84 do_writepages+0x64/0x100
>>>> [c00000001fbd7870] c0000000005c151c
>>>> __writeback_single_inode+0x1dc/0x940
>>>> [c00000001fbd78d0] c0000000005c5068 writeback_sb_inodes+0x418/0x770
>>>> [c00000001fbd79c0] c0000000005c5484 __writeback_inodes_wb+0xc4/0x140
>>>> [c00000001fbd7a20] c0000000005c580c wb_writeback+0x30c/0x6e0
>>>> [c00000001fbd7af0] c0000000005c6f4c wb_workfn+0x37c/0x8e0
>>>> [c00000001fbd7c40] c000000000206954 process_one_work+0x434/0x7d0
>>>> [c00000001fbd7d10] c000000000206ff4 worker_thread+0x304/0x570
>>>> [c00000001fbd7da0] c00000000021371c kthread+0x1bc/0x1d0
>>>> [c00000001fbd7e10] c00000000000d6ec ret_from_kernel_thread+0x5c/0x70
>>>>
>>>>
>>>> While writing this email, I thought of checking the some obvious
>>>> error handling
>>>> in function btrfs_mark_extent_written(). I think we definitely this
>>>> below patch,
>>>> however there could be something else too which I am missing from btr=
fs
>>>> functionality perspective. But I thought below might help.
>>>>
>>>> I haven't yet tested it though.
>>>>
>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>> index e307fbe398f0..c47f406ce9c1 100644
>>>> --- a/fs/btrfs/file.c
>>>> +++ b/fs/btrfs/file.c
>>>> @@ -1097,7 +1097,7 @@ int btrfs_mark_extent_written(struct
>>>> btrfs_trans_handle *trans,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int del_nr =3D=
 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int del_slot =
=3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int recow;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 ino =3D bt=
rfs_ino(inode);
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D btrfs=
_alloc_path();
>>>> @@ -1318,7 +1318,7 @@ int btrfs_mark_extent_written(struct
>>>> btrfs_trans_handle *trans,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_pat=
h(path);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0 /*
>>>>
>>>>
>>>> Thanks
>>>> -ritesh
>>>>
