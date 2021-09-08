Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B340388E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhIHLM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 07:12:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:52285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhIHLMZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 07:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631099475;
        bh=u2GALTnGkCfNhR+v5wOIP+p66E4CSvk8YPzcLgLsAvs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Vd+L7ERSzLvyZI5Mhp8cWuhLas31m9fbXF9+vKQ592Yv7AzOY1HCUj0Vr01IR5+J9
         u9mqfDQHpeXM6n3HsMgkuAYbVHItwwOrGZhl8MRq9mBcz9E9z5lcXXtcXQ89J+EVQc
         G8EC8xfHV/y3g96eeXjb7+/TijQLPRZGzKM59J4k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1mmI1L2V57-00kjPi; Wed, 08
 Sep 2021 13:11:15 +0200
Subject: Re: [PATCH v2 00/26] btrfs: limited subpage compressed write support
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210829052458.15454-1-wqu@suse.com>
 <20210907180228.GS3379@twin.jikos.cz>
 <56749aba-4760-0f0a-e626-b2954d61b0d5@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <94351727-3c29-d7d1-273a-adc75045b25a@gmx.com>
Date:   Wed, 8 Sep 2021 19:11:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <56749aba-4760-0f0a-e626-b2954d61b0d5@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XllXibfbaGALOmDcJgG8NoAPN7dsEVUpb7NbT6Cmdz4FUEfTWfW
 m7oiMwHdzJTxF9cG+MWgk8jgp3TS21Jk70Fh4ud373grZSikwfd/rbOXlIZFdQHM4OqnmeD
 z2E/x7F7MUbT+UpONZh0PHUK84GANEeih4NdrlfL2lmmT2W2tkGg2nQv4IiVlDCf/702Y76
 h86txIh9qywGfQU1ieUXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:11BOBEVNpQw=:R++JAfkkQvVIz0uOXAmvoy
 0IsLM9S03O2uV2eEZy1hGWDGcG/n5+79btlwKV5NsBqGzAFLtkdxUODIJYqVvZJDdygZYe7Qv
 YCz4/CwCZKJhn9ACMCZVGQISL+BcKOwa+DHnhvitGdgnAC6e0s3himby8WGSVmRsZsM0g5ttN
 UZzcjG6XtKVrp+9wOVRpdDrSVRyQ0NklZ65gI5OvKqJsGqvoB/eL1aaMzovaP1rg/hSzBzEDa
 WCKkBIOzMlu+CkWT635zrnN91al6raOhm4o11OIAza9/TeVNjHQ2qPkSsWL6mRYpytCCoymUD
 5Lw57UAmbyWi7o5n9sH8NR0TdYCLP0qHzYvYr5ZgSCuI1vKSz0AbrFhhf3jdAGsoSbFZ4QrSF
 RHyhnplRXLLYUWkMpvv597MK3jMGaXF6O8S68cAV7havRYhBtAaJJGEuRPOUJapOAwJObc0By
 BosQRUhnZzLgLdMjky3f802sLjbOuwHf6kUtlRIfstYzqiMrEJFr1Udjn7bQUUAe5QlWsfav4
 QDUSvE/vTkQDaFJOwwDckjLcdR4lhPhc2PdBctq8w6wtblGtl9dqPRN2/OIFLExRP4zBQZRHt
 imNAOgGD4WBmd1jFvMAT64J7sbU4O/GeCjEkYqB8AF06SGaXYaSQKMAM4Hs6kLz1QuX4SD5zV
 9aFKDE/yYn2XjEH0S94jslkv4RLgIZtL5cGPy38iMsZ+/K9z1cJGIP+JKL8nl/Ny4NFW8mVXM
 oxRRQ6bvcydTHCSyrT2WIwl6OJgrW4rWjydw9y9u3eHiCiFSoxRTxzf6pIcodtQ6XkuMt6YOC
 Qjyrqs4/ESoxR2CwY6tw9WkRA0edCjV8WW3SMFCEUN0Ym1PVB5HGYIio/fh9ixgOljHuQViib
 rPbv9JUVbcOwCiwNm+t2iA06M6jPdin8i3R9OX9erJzRy5s26y2ubwV7EvzHOAdSyYsfHoN/N
 AwgdaZtk3AoRcnjcurKVjL8ZMe2fHQSKY/LUDZQmzQUXxIojl+MSgm+GRiEowsLbDn5bKeX0j
 e+IYslmZ1Qho7F1lrl++s91PnPDRvnIAICiBbEPAsPx5qqIaNP3NRafhEyz1PPHPqP/fSpUR2
 0ghUsA2HKQK4fJgthLFJI95MBJ7HEheVgEZBgtI3O0w+FkrldSu/NSUXQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/8 =E4=B8=8A=E5=8D=887:40, Qu Wenruo wrote:
>
>
> On 2021/9/8 =E4=B8=8A=E5=8D=882:02, David Sterba wrote:
>> Crash in btrfs/138
>
> Any reproducibility?
>
> I retried a dozen runs, no reproduce yet.
>
> Although it's x86_64, I also tried on aarch64 with 64K page size, the sa=
me.
>
> My current base is:
>
> commit 23fe0a532654a92093f4fb59845d40bdcf74c1a6 (david/misc-next)
> Author: Kari Argillander <kari.argillander@gmail.com>
> Date:=C2=A0=C2=A0 Tue Aug 31 00:51:52 2021 +0300
>
>  =C2=A0=C2=A0=C2=A0 btrfs: use correct header for div_u64 in misc.h

Still no reproduce after rebasing the patches to latest misc-next.

So I guess it's not that reproducible even on your side?

Thanks,
Qu
>
>
>>
>> btrfs/138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [17:47:31][ 3286.60=
0120] run fstests btrfs/138 at
>> 2021-09-07 17:47:31
>> [ 3286.932138] BTRFS: device fsid 438a1e94-63da-4e19-a479-3bc7d9b9b93a
>> devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (22121)
>> [ 3286.958963] BTRFS info (device vdb): flagging fs with big metadata
>> feature
>> [ 3286.960269] BTRFS info (device vdb): disk space caching is enabled
>> [ 3286.961378] BTRFS info (device vdb): has skinny extents
>> [ 3286.965129] BTRFS info (device vdb): checking UUID tree
>> [ 3334.373345] BTRFS info (device vdb): flagging fs with big metadata
>> feature
>> [ 3334.374919] BTRFS info (device vdb): disk space caching is enabled
>> [ 3334.376099] BTRFS info (device vdb): has skinny extents
>> [ 3334.456496] BTRFS info (device vdb): setting incompat feature flag
>> for COMPRESS_LZO (0x8)
>> [ 3334.708351] BUG: kernel NULL pointer dereference, address:
>> 0000000000000000
>> [ 3334.709746] #PF: supervisor read access in kernel mode
>> [ 3334.710727] #PF: error_code(0x0000) - not-present page
>> [ 3334.711741] PGD 0 P4D 0
>> [ 3334.712341] Oops: 0000 [#1] PREEMPT SMP
>> [ 3334.713178] CPU: 2 PID: 22182 Comm: kworker/u8:7 Not tainted
>> 5.14.0-rc7-default+ #1561
>> [ 3334.714773] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>> [ 3334.716942] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>> [ 3334.718197] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>
> Any code context for the RIP?
>
> Thanks,
> Qu
>
>> [ 3334.723372] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
>> [ 3334.724418] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.725777] RDX: 0000000000000b3d RSI: 0000000000016000 RDI:
>> 0000000000000000
>> [ 3334.727117] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09:
>> ffff9f1d45f34000
>> [ 3334.728517] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d5a812000
>> [ 3334.729878] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15:
>> 0000000000000000
>> [ 3334.731211] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7da00000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.732756] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.733821] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4:
>> 0000000000170ea0
>> [ 3334.735253] Call Trace:
>> [ 3334.735873]=C2=A0 lzo_compress_pages+0x182/0x320 [btrfs]
>> [ 3334.736901]=C2=A0 btrfs_compress_pages+0xbc/0x130 [btrfs]
>> [ 3334.737910]=C2=A0 compress_file_range+0x3ae/0x820 [btrfs]
>> [ 3334.738876]=C2=A0 ? rcu_read_lock_sched_held+0x12/0x70
>> [ 3334.739943]=C2=A0 ? submit_compressed_extents+0xc0/0xc0 [btrfs]
>> [ 3334.741058]=C2=A0 async_cow_start+0x12/0x30 [btrfs]
>> [ 3334.741933]=C2=A0 btrfs_work_helper+0xd6/0x1d0 [btrfs]
>> [ 3334.742987]=C2=A0 process_one_work+0x262/0x5e0
>> [ 3334.743869]=C2=A0 ? exit_to_user_mode_prepare+0x1b2/0x1c0
>> [ 3334.744869]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.745780]=C2=A0 worker_thread+0x55/0x3c0
>> [ 3334.746598]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.747456]=C2=A0 kthread+0x144/0x170
>> [ 3334.748139]=C2=A0 ? set_kthread_struct+0x40/0x40
>> [ 3334.748995]=C2=A0 ret_from_fork+0x1f/0x30
>> [ 3334.749787] Modules linked in: dm_flakey dm_mod btrfs
>> blake2b_generic libcrc32c crc32c_intel xor zstd_decompress
>> zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
>> [ 3334.752514] CR2: 0000000000000000
>> [ 3334.753164] ---[ end trace f1f62e4293ace345 ]---
>> [ 3334.753177] BUG: kernel NULL pointer dereference, address:
>> 0000000000000000
>> [ 3334.753887] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3334.754968] #PF: supervisor read access in kernel mode
>> [ 3334.756704] #PF: error_code(0x0000) - not-present page
>> [ 3334.759238] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
>> [ 3334.760011] PGD 0 P4D 0
>> [ 3334.760787] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.760790] RDX: 0000000000000b3d RSI: 0000000000016000 RDI:
>> 0000000000000000
>> [ 3334.761227] Oops: 0000 [#2] PREEMPT SMP
>> [ 3334.762222] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09:
>> ffff9f1d45f34000
>> [ 3334.763228] CPU: 1 PID: 30809 Comm: kworker/u8:10 Tainted: G
>> D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.14.0-rc=
7-default+ #1561
>> [ 3334.763828] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d5a812000
>> [ 3334.764833] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>> [ 3334.766165] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15:
>> 0000000000000000
>> [ 3334.767166] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>> [ 3334.769097] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7da00000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.770482]
>> [ 3334.771422] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.772857] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3334.773201] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4:
>> 0000000000170ea0
>> [ 3334.779303] RSP: 0018:ffffa7c446f47c20 EFLAGS: 00010293
>> [ 3334.780739] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.783079] RDX: 0000000000000b47 RSI: 0000000000016000 RDI:
>> 0000000000000000
>> [ 3334.784979] RBP: ffffa7c446f47cc4 R08: 0000000000000b47 R09:
>> ffff9f1d1d088000
>> [ 3334.786059] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d249ba000
>> [ 3334.786654] R13: 0000000000000000 R14: ffffa7c446f47cc4 R15:
>> 0000000000000000
>> [ 3334.787216] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7d800000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.788178] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.788721] CR2: 0000000000000000 CR3: 0000000026af4005 CR4:
>> 0000000000170ea0
>> [ 3334.789281] Call Trace:
>> [ 3334.789527]=C2=A0 lzo_compress_pages+0x182/0x320 [btrfs]
>> [ 3334.790013]=C2=A0 btrfs_compress_pages+0xbc/0x130 [btrfs]
>> [ 3334.790468]=C2=A0 compress_file_range+0x3ae/0x820 [btrfs]
>> [ 3334.790921]=C2=A0 ? rcu_read_lock_sched_held+0x12/0x70
>> [ 3334.791327]=C2=A0 ? submit_compressed_extents+0xc0/0xc0 [btrfs]
>> [ 3334.792104]=C2=A0 async_cow_start+0x12/0x30 [btrfs]
>> [ 3334.792615]=C2=A0 btrfs_work_helper+0xd6/0x1d0 [btrfs]
>> [ 3334.793059]=C2=A0 process_one_work+0x262/0x5e0
>> [ 3334.793440]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.793807]=C2=A0 worker_thread+0x55/0x3c0
>> [ 3334.794131]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.794489]=C2=A0 kthread+0x144/0x170
>> [ 3334.794787]=C2=A0 ? set_kthread_struct+0x40/0x40
>> [ 3334.795151]=C2=A0 ret_from_fork+0x1f/0x30
>> [ 3334.795537] Modules linked in: dm_flakey dm_mod btrfs
>> blake2b_generic libcrc32c crc32c_intel xor zstd_decompress
>> zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
>> [ 3334.797011] CR2: 0000000000000000
>> [ 3334.797315] ---[ end trace f1f62e4293ace346 ]---
>> [ 3334.797341] BUG: kernel NULL pointer dereference, address:
>> 0000000000000000
>> [ 3334.797704] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3334.803174] #PF: supervisor read access in kernel mode
>> [ 3334.804664] #PF: error_code(0x0000) - not-present page
>> [ 3334.806086] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
>> [ 3334.806515] PGD 0
>> [ 3334.806515]
>> [ 3334.806516] P4D 0
>> [ 3334.806939] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.807153]
>> [ 3334.807331] RDX: 0000000000000b3d RSI: 0000000000016000 RDI:
>> 0000000000000000
>> [ 3334.807703] Oops: 0000 [#3] PREEMPT SMP
>> [ 3334.808689] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09:
>> ffff9f1d45f34000
>> [ 3334.808921] CPU: 2 PID: 12629 Comm: kworker/u8:16 Tainted: G
>> D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.14.0-rc=
7-default+ #1561
>> [ 3334.809492] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d5a812000
>> [ 3334.809831] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>> [ 3334.810388] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15:
>> 0000000000000000
>> [ 3334.811138] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>> [ 3334.812090] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7d800000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.814225]
>> [ 3334.814227] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3334.815124] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.817404] CR2: 0000000000000000 CR3: 0000000026af4005 CR4:
>> 0000000000170ea0
>> [ 3334.817643] RSP: 0018:ffffa7c4462a7c20 EFLAGS: 00010293
>> [ 3334.823627] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.824686] RDX: 0000000000000b20 RSI: 0000000000013000 RDI:
>> 0000000000000000
>> [ 3334.825690] RBP: ffffa7c4462a7cc4 R08: 0000000000000b20 R09:
>> ffff9f1d0e25c000
>> [ 3334.826514] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d16c9a000
>> [ 3334.827798] R13: 0000000000000000 R14: ffffa7c4462a7cc4 R15:
>> 0000000000000000
>> [ 3334.829022] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7da00000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.831687] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.832449] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4:
>> 0000000000170ea0
>> [ 3334.833424] Call Trace:
>> [ 3334.833856]=C2=A0 lzo_compress_pages+0x182/0x320 [btrfs]
>> [ 3334.834594]=C2=A0 btrfs_compress_pages+0xbc/0x130 [btrfs]
>> [ 3334.835428]=C2=A0 compress_file_range+0x3ae/0x820 [btrfs]
>> [ 3334.836500]=C2=A0 ? rcu_read_lock_sched_held+0x12/0x70
>> [ 3334.837485]=C2=A0 ? submit_compressed_extents+0xc0/0xc0 [btrfs]
>> [ 3334.838699]=C2=A0 async_cow_start+0x12/0x30 [btrfs]
>> [ 3334.839737]=C2=A0 btrfs_work_helper+0xd6/0x1d0 [btrfs]
>> [ 3334.840694]=C2=A0 process_one_work+0x262/0x5e0
>> [ 3334.841483]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.842355]=C2=A0 worker_thread+0x55/0x3c0
>> [ 3334.843458]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.844679]=C2=A0 kthread+0x144/0x170
>> [ 3334.848139]=C2=A0 ? set_kthread_struct+0x40/0x40
>> [ 3334.849036]=C2=A0 ret_from_fork+0x1f/0x30
>> [ 3334.849753] Modules linked in: dm_flakey dm_mod btrfs
>> blake2b_generic libcrc32c crc32c_intel xor zstd_decompress
>> zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
>> [ 3334.853981] CR2: 0000000000000000
>> [ 3334.854724] ---[ end trace f1f62e4293ace347 ]---
>> [ 3334.855728] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3334.861741] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
>> [ 3334.862726] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.863989] RDX: 0000000000000b3d RSI: 0000000000016000 RDI:
>> 0000000000000000
>> [ 3334.865758] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09:
>> ffff9f1d45f34000
>> [ 3334.867185] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d5a812000
>> [ 3334.868428] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15:
>> 0000000000000000
>> [ 3334.869858] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7da00000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.871360] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.872497] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4:
>> 0000000000170ea0
>> [ 3334.873307] BUG: sleeping function called from invalid context at
>> include/linux/percpu-rwsem.h:49
>> [ 3334.874422] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
>> 12629, name: kworker/u8:16
>> [ 3334.875559] INFO: lockdep is turned off.
>> [ 3334.876390] irq event stamp: 0
>> [ 3334.876962] hardirqs last=C2=A0 enabled at (0): [<0000000000000000>]=
 0x0
>> [ 3334.877656] hardirqs last disabled at (0): [<ffffffff9d066794>]
>> copy_process+0x514/0x17e0
>> [ 3334.878434] softirqs last=C2=A0 enabled at (0): [<ffffffff9d066794>]
>> copy_process+0x514/0x17e0
>> [ 3334.879105] softirqs last disabled at (0): [<0000000000000000>] 0x0
>> [ 3334.879748] CPU: 2 PID: 12629 Comm: kworker/u8:16 Tainted: G
>> D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.14.0-rc=
7-default+ #1561
>> [ 3334.882202] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>> [ 3334.884399] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>> [ 3334.885295] Call Trace:
>> [ 3334.885608]=C2=A0 ? wake_up_klogd+0x29/0x90
>> [ 3334.886045]=C2=A0 dump_stack_lvl+0x45/0x59
>> [ 3334.886405]=C2=A0 ___might_sleep.cold+0x107/0x132
>> [ 3334.887080]=C2=A0 exit_signals+0x1d/0x360
>> [ 3334.887534]=C2=A0 do_exit+0xa2/0x4a0
>> [ 3334.888203]=C2=A0 rewind_stack_do_exit+0x17/0x17
>> [ 3334.889005] RIP: 0000:0x0
>> [ 3334.889588] Code: Unable to access opcode bytes at RIP
>> 0xffffffffffffffd6.
>> [ 3334.890916] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX:
>> 0000000000000000
>> [ 3334.892556] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [ 3334.893452] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> 0000000000000000
>> [ 3334.894030] RBP: 0000000000000000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [ 3334.894607] R10: 0000000000000000 R11: 0000000000000000 R12:
>> 0000000000000000
>> [ 3334.895181] R13: 0000000000000000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [ 3334.940770] BUG: kernel NULL pointer dereference, address:
>> 0000000000000000
>> [ 3334.942068] #PF: supervisor read access in kernel mode
>> [ 3334.942907] #PF: error_code(0x0000) - not-present page
>> [ 3334.943832] PGD 0 P4D 0
>> [ 3334.944322] Oops: 0000 [#4] PREEMPT SMP
>> [ 3334.944956] CPU: 3 PID: 12136 Comm: kworker/u8:13 Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 D
>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.14.0-rc7-default+ #=
1561
>> [ 3334.946320] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>> [ 3334.949150] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>> [ 3334.950820] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3334.956308] RSP: 0018:ffffa7c4456bfc20 EFLAGS: 00010293
>> [ 3334.957453] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3334.958890] RDX: 0000000000000b56 RSI: 0000000000007000 RDI:
>> 0000000000000000
>> [ 3334.960140] RBP: ffffa7c4456bfcc4 R08: 0000000000000b56 R09:
>> ffff9f1d09658000
>> [ 3334.961348] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d248aa000
>> [ 3334.963742] R13: 0000000000000000 R14: ffffa7c4456bfcc4 R15:
>> 0000000000000000
>> [ 3334.969393] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7dc00000(000=
0)
>> knlGS:0000000000000000
>> [ 3334.971288] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3334.973754] CR2: 0000000000000000 CR3: 00000000117ee006 CR4:
>> 0000000000170ea0
>> [ 3334.975493] Call Trace:
>> [ 3334.976151]=C2=A0 lzo_compress_pages+0x182/0x320 [btrfs]
>> [ 3334.977397]=C2=A0 btrfs_compress_pages+0xbc/0x130 [btrfs]
>> [ 3334.978906]=C2=A0 compress_file_range+0x3ae/0x820 [btrfs]
>> [ 3334.980271]=C2=A0 ? rcu_read_lock_sched_held+0x12/0x70
>> [ 3334.981391]=C2=A0 ? submit_compressed_extents+0xc0/0xc0 [btrfs]
>> [ 3334.982740]=C2=A0 async_cow_start+0x12/0x30 [btrfs]
>> [ 3334.983962]=C2=A0 btrfs_work_helper+0xd6/0x1d0 [btrfs]
>> [ 3334.986359]=C2=A0 process_one_work+0x262/0x5e0
>> [ 3334.987320]=C2=A0 worker_thread+0x55/0x3c0
>> [ 3334.988282]=C2=A0 ? process_one_work+0x5e0/0x5e0
>> [ 3334.989283]=C2=A0 kthread+0x144/0x170
>> [ 3334.990107]=C2=A0 ? set_kthread_struct+0x40/0x40
>> [ 3334.991160]=C2=A0 ret_from_fork+0x1f/0x30
>> [ 3334.992044] Modules linked in: dm_flakey dm_mod btrfs
>> blake2b_generic libcrc32c crc32c_intel xor zstd_decompress
>> zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
>> [ 3334.995615] CR2: 0000000000000000
>> [ 3334.996498] ---[ end trace f1f62e4293ace348 ]---
>> [ 3334.997623] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrf=
s]
>> [ 3335.003578] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
>> [ 3335.004802] RAX: 0000000000000000 RBX: 0000000000000fff RCX:
>> 0000000000000000
>> [ 3335.006422] RDX: 0000000000000b3d RSI: 0000000000016000 RDI:
>> 0000000000000000
>> [ 3335.008009] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09:
>> ffff9f1d45f34000
>> [ 3335.009396] R10: ffff9f1d7de00000 R11: 0000000000000000 R12:
>> ffff9f1d5a812000
>> [ 3335.010622] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15:
>> 0000000000000000
>> [ 3335.011865] FS:=C2=A0 0000000000000000(0000) GS:ffff9f1d7dc00000(000=
0)
>> knlGS:0000000000000000
>> [ 3335.013416] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3335.014513] CR2: 0000000000000000 CR3: 00000000117ee006 CR4:
>> 0000000000170ea0
>>
