Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBA3AFC61
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 07:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVFGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 01:06:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:40703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhFVFGQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 01:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624338238;
        bh=Z/azgNm/zi1VbZ677dtZEyvYXJh2prOg0FSpMqFuWkM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J/KIHttfNXas7hNyMoXP+rmSoMMZji1gsC9X6Kw/MNmQ9MFexoHJfCupqIbSGRwr5
         h9FRlDzMIJhDBypaZzur+8m9mD4S+w28rlTO3+LSFWob+fQLJEh5aOAcZmeaYvVyW3
         52fEaze4oI2QgpjX5GL3J4nBw+YZeTHFqTnaV3ko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1lnTRI3Srt-00RuQf; Tue, 22
 Jun 2021 07:03:58 +0200
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
 <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
 <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com>
 <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com>
 <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com>
Date:   Tue, 22 Jun 2021 13:03:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0GiNYTMXnqT9v1xdNldlECpiNjhhivxJ7oY+6Fp4SquPUiRnObS
 7Un9io/b80Alr5mw95gTffxIfYboilFqRZJzRH1VmFtJr2HTOa4xGxdjptI+PSivsirhcZ0
 5p7xCh08a9/09e8g2I5NsVkRs7eiNuuZ2dqtA+ipdrm7RSzJ6hLrfU3AQMcrLDPot8u7tAM
 0cW4XxRFkZtU/rYqMaV1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OluGmr/fZX8=:ScXHDfoy0U17wmUFNoLX1l
 qPM7b4kubu0FDl41LIjOhoTw8XCoMQN6HSicq14YL0dkC0r9OgTynlQ13Ov1LTOx5/LcPbbal
 j4/Fyawi8crfIVrnO9qfg6V4O1noi3PkHZkmvNgcjv6aORE2RBM0phinoNrHkVy4mhsL5N+mI
 5AaUpkd7kFquiQCzEgCeHtcNFAz46KLDcJkA/RZGZIucwtqJLt8MdRTfzCALWrFcAS7uIFdol
 KvHhsJtBX02N4rA6cZrMsO5ph+20bCPChOWmxZEJ9zXTMny2AXahhV0ryG2F0jaY7P7Vfbt7A
 YIE1RivKJLfGs6jmpOwJXWNhWaz/RICZt7lan/4nY34Mt3R4hwcPjiUJmKrEbyUHFYvu+PwUT
 lkfoVHbOTzsIEXH8DwKv5XiZI32U9c47E2Faa4X7kwSi751/fOCIMtPlUSMEaseXTI6zaFBuP
 k93Gtrn8DU4iZj2q7F/ML/0NRhZ+oQ9zq5V8FdTM21D6TNXs/eaOmPsH8uCdM0WIwImReSGPh
 K9eWEEOevd0EIe2QMCQ8ZGrbtI7oWW2nXAabehS7fINKAICzl1OTchk2GGizHfsk5bvIPUsgF
 0KYJbhH+yMxpL/cklsoSacVfjPIjSxwyQmU47/n2Xum93Ov0jLMiC1LT6YjAYkvxXcRg3D2iu
 XwtimurdV6mXmPR/eoOi4ZtaP5LrkaTnFIbJe7PeLhctYoaeeWbZP+pJpeTyVWfpEUDn97dEX
 0ChfJ00GZyX6745RIAAc0E2GEBLZS/mIcn4JBVsDDjhLOSPJu29Yr2vd39uqyBdUq8SkgxWXs
 M3+mZmjfuXa9SBbM7E7hfuEZMZGONEEQYfM84+9rkHvAW7+2qlMF28baDkGpcJTkrbEHaIL+K
 5uvtc5umQLI2wO4qu/3+lCxbNzOFrtIGd99Ti6HZibwckjOuhx+pgzHl5kn6SXWKn4R5zOHx4
 k2HR5PdDIj8G1jobvKYuqzkZZKkc56VuK6+u/sqSuiMCz9ofp0oJ4hTFVIkYOwQNK6CXLsKIn
 27aSJmDO5Tu/3wdrwehSUJEBz2UaC5Xgn0JSyYWM7rnSvAj6Z7StbdZKmdEXsdLzjcFBMv0We
 N+5ivQoUOskw74aOBpWO0RyVhv+baDpniUE5xd/mQrD4DY9jx/V7UcuRA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/22 =E4=B8=8B=E5=8D=8812:54, Asif Youssuff wrote:
> Qu,
>
> I went ahead and remounted and did:
>
> btrfs device add -f /dev/sdk /dev/sdq /media/camino/
>
> I'm returned to the shell prompt and nothing happens. btrfs fi show
> doesn't show the new disks, nor do I see anything in dmesg.

Then can you remove subvolume and run "btrfs fi sync"?

>
> I suppose I can partition the two disks if you would like me to try to
> add *4* disks, but I don't really think it would make a difference. I
> see no errors - which is what I would expect in any case (this sounds
> like an improvement that could be made).
>
> FWIW, I am running btrfs-progs v5.4.1 in case that makes a difference
> - I can try to update to a newer btrfs-progs, but it doesn't look like
> btrfs device add is detecting an error here - the kernel is simply not
> adding the disk.

I don't think btrfs-progs version would make a difference.

Thanks,
Qu

>
> Still holding out hope here. :)
>
> On Mon, Jun 21, 2021 at 11:15 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2021/6/22 =E4=B8=8A=E5=8D=888:55, Asif Youssuff wrote:
>>> To be clear, it was the last snapshot on an infrequently updated
>>> subvolume, likely with no changes since the prior snapshot to the one
>>> deleted.
>>
>> The last chance would be try to add *two* devices, which should be at
>> least 1G for each.
>>
>> If the device add can success, then you can go delete as many as
>> subvolumes, and then remove (I mean btrfs device remove, not unplug) th=
e
>> added two devices.
>>
>>
>> I think we should really rework the metadata over-commit code to use my
>> previously submitted calculation to avoid such deadly ENOSPC trap.
>>
>> Thanks,
>> Qu
>>>
>>> On Mon, Jun 21, 2021 at 8:50 PM Asif Youssuff <yoasif@gmail.com> wrote=
:
>>>>
>>>> I tried removing a single snapshot from a subvolume with rarely
>>>> updated data (likely no changes at all to that subvolume between
>>>> snapshots), and I was unable to successfully sync the filesystem
>>>> before it went readonly.
>>>>
>>>> On Mon, Jun 21, 2021 at 8:26 PM Qu Wenruo <wqu@suse.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2021/6/22 =E4=B8=8A=E5=8D=888:12, Asif Youssuff wrote:
>>>>>> On Mon, Jun 21, 2021 at 7:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>
>>>>>>>> I have tried removing snapshots, but the disk continues to go ro =
-
>>>>>>>> after remount, the subvolumes are still there. Is there a way to =
force
>>>>>>>> a sync of the subvolume removal before the fs goes ro?
>>>>>>>
>>>>>>> Maybe you can try "btrfs fi sync" before remount?
>>>>>>
>>>>>> Tried deleting a bunch of snapshots and immediately did a btrfs fi
>>>>>> sync - still forced ro pretty quickly:
>>>>>
>>>>> So that's the worst case, metadata already exhausted.
>>>>>
>>>>> Have you tried to just delete one small subvolume and then fi sync?
>>>>>
>>>>> It's possible that too many pending subvolume deletion can cause too
>>>>> much metadata space usage.
>>>>>
>>>>> Thus if you do it one by one, there may be a chance to commit succes=
sfully.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> [ 1810.858326] ------------[ cut here ]------------
>>>>>> [ 1810.858334] BTRFS: Transaction aborted (error -28)
>>>>>> [ 1810.858384] BTRFS: error (device sdf) in __btrfs_free_extent:321=
6:
>>>>>> errno=3D-28 No space left
>>>>>> [ 1810.858493] BTRFS info (device sdf): forced readonly
>>>>>> [ 1810.858405] WARNING: CPU: 5 PID: 10137 at
>>>>>> fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs]
>>>>>> [ 1810.858500] BTRFS: error (device sdf) in
>>>>>> btrfs_run_delayed_refs:2163: errno=3D-28 No space left
>>>>>> [ 1810.858635] Modules linked in: veth xt_nat nf_conntrack_netlink
>>>>>> nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
>>>>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
>>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv=
4
>>>>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
>>>>>> ip6_tables iptable_filter bpfilter ppdev parport_pc parport
>>>>>> vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth ecdh_gene=
ric
>>>>>> ecc msr binfmt_misc input_leds joydev ipmi_ssif dm_crypt
>>>>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powercl=
amp
>>>>>> coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
>>>>>> ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cstat=
e
>>>>>> intel_pch_thermal lpc_ich mei_me mei acpi_ipmi ipmi_si ipmi_devintf
>>>>>> ipmi_msghandler ie31200_edac mac_hid acpi_pad sch_fq_codel ib_iser
>>>>>> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
>>>>>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_gener=
ic
>>>>>> raid10 raid456
>>>>>> [ 1810.858782]  async_raid6_recov async_memcpy async_pq async_xor
>>>>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
>>>>>> hid_generic usbhid hid uas usb_storage ast drm_vram_helper
>>>>>> drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
>>>>>> fb_sys_fops cec mpt3sas rc_core raid_class drm igb ahci xhci_pci dc=
a
>>>>>> e1000e libahci i2c_algo_bit scsi_transport_sas xhci_pci_renesas vid=
eo
>>>>>> [ 1810.858857] CPU: 5 PID: 10137 Comm: btrfs-transacti Tainted: G
>>>>>>      W         5.12.12-051212-generic #202106180931
>>>>>> [ 1810.858865] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.=
0 04/24/2015
>>>>>> [ 1810.858868] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
>>>>>> [ 1810.858973] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d 8=
b
>>>>>> 45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 0c 75 c0 e8 1=
5
>>>>>> e1 f6 f7 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 52=
 74
>>>>>> c0 e8
>>>>>> [ 1810.858980] RSP: 0018:ffffab4702a43c00 EFLAGS: 00010286
>>>>>> [ 1810.858986] RAX: 0000000000000000 RBX: 0000000000000030 RCX: fff=
f95e57fd585c8
>>>>>> [ 1810.858991] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: fff=
f95e57fd585c0
>>>>>> [ 1810.858995] RBP: ffffab4702a43ca8 R08: 0000000000000000 R09: fff=
fab4702a439e0
>>>>>> [ 1810.858998] R10: ffffab4702a439d8 R11: ffffffffb99542e8 R12: 000=
157fe74a6e000
>>>>>> [ 1810.859002] R13: 0000000000000515 R14: ffff95de8a0941c0 R15: fff=
f95dfaa212200
>>>>>> [ 1810.859007] FS:  0000000000000000(0000) GS:ffff95e57fd40000(0000=
)
>>>>>> knlGS:0000000000000000
>>>>>> [ 1810.859012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [ 1810.859016] CR2: 00007fd6fc652718 CR3: 0000000278610004 CR4: 000=
00000001706e0
>>>>>> [ 1810.859022] Call Trace:
>>>>>> [ 1810.859031]  run_delayed_data_ref+0x96/0x160 [btrfs]
>>>>>> [ 1810.859130]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs]
>>>>>> [ 1810.859225]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
>>>>>> [ 1810.859320]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
>>>>>> [ 1810.859474]  btrfs_commit_transaction+0x68/0xa20 [btrfs]
>>>>>> [ 1810.859633]  ? start_transaction+0xd5/0x590 [btrfs]
>>>>>> [ 1810.859783]  ? __next_timer_interrupt+0xd0/0x110
>>>>>> [ 1810.859800]  transaction_kthread+0x138/0x1b0 [btrfs]
>>>>>> [ 1810.859905]  kthread+0x12f/0x150
>>>>>> [ 1810.859916]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [btr=
fs]
>>>>>> [ 1810.860020]  ? __kthread_bind_mask+0x70/0x70
>>>>>> [ 1810.860031]  ret_from_fork+0x22/0x30
>>>>>> [ 1810.860045] ---[ end trace 64a07c4b91899089 ]---
>>>>>> [ 1810.860052] BTRFS: error (device sdf) in __btrfs_free_extent:321=
6:
>>>>>> errno=3D-28 No space left
>>>>>> [ 1810.860172] BTRFS: error (device sdf) in
>>>>>> btrfs_run_delayed_refs:2163: errno=3D-28 No space left
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> Thanks,
>>>> Asif
>>>
>>>
>>>
>
>
>
