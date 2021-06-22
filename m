Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBC3AFD1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 08:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFVGjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 02:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVGjf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 02:39:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A25C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 23:37:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bl4so905383qkb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Siqb5iUOIo5NubPav6dIjfSd0qGjGo+rcWPN7QzYuIk=;
        b=J5X/YgejoNlmEiv5yogc94E+YSvYr4Hhy/WBqJ6UomKA04QIbdo0sZfXQ3gSzDOm5z
         HrFHnyLnqbDzeKgC8gE38AGL0ONNLPtXNY7+ss+ja8KtIA2UtZONrBZQeSfO6bdYRxOf
         O37jcBC5vFBb+JbCIwweG94TmhQgg3G5k9NV9w8hWtzTBhmrsB3WqhYVz/T5XIGc7888
         0l340PUjHZIZ5uC1ey2dI1aAKNL1Pw997UVGsVsjD63vI+B3ttTWrV/E0GU/3C3mhUrs
         qgAn3/218EfgESx87eFqtSOZtbgQWZOt/1cqtDgz++cj1j9Rb+B06amq6urk75CTHSAZ
         aGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Siqb5iUOIo5NubPav6dIjfSd0qGjGo+rcWPN7QzYuIk=;
        b=OUSxAafNIY5QXgO6FBxDt/zviV20ddMDOfgxp27BiWAhNrolUUZqDDoSS1h4zMSRHd
         NjbNOhQsjdq/WBN/+EPyYcsGe3rzkAbT6YwZX2RTXev/1183sTRTshH/XTnsDd8x9T+i
         3ZDWMB83F/xaNOGy4GQoBD3I5IZGJFZuiafiK2CG3NJsuFNfqzTB5PsZt37G5p7tx9z7
         zg10ULPYBbuPjYTjbRS4V3TBe4CMM/I9ACTOnw+w7G2AYUkxtgGIIUa56Yk/X+1anxss
         arvZTP1kzU6KTQZOiTVW5leG7YQULWpxJMJqFDTrA2sg9Wm6w7I1wxt8SmheGYZor3cQ
         auHQ==
X-Gm-Message-State: AOAM533S6U3JOxq6Uvete+EzAJyL5/8SQtrS6lML86iHulvJz/ihle4n
        EvTK5MzL5s5o5j4IbjdC8p7CKhabCHUtkHn3ynI=
X-Google-Smtp-Source: ABdhPJwupZvsNkNF8fq9YW7vXK9VZ8mmlqCu94nC+4r1wvxunRGiN3eRCOw831F7pd8QEABDHYlJwOKxXRn6gUPhpEo=
X-Received: by 2002:a25:e80f:: with SMTP id k15mr2807156ybd.432.1624343837243;
 Mon, 21 Jun 2021 23:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com> <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com> <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com>
In-Reply-To: <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Tue, 22 Jun 2021 02:37:05 -0400
Message-ID: <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 1:03 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/6/22 =E4=B8=8B=E5=8D=8812:54, Asif Youssuff wrote:
> > Qu,
> >
> > I went ahead and remounted and did:
> >
> > btrfs device add -f /dev/sdk /dev/sdq /media/camino/
> >
> > I'm returned to the shell prompt and nothing happens. btrfs fi show
> > doesn't show the new disks, nor do I see anything in dmesg.
>
> Then can you remove subvolume and run "btrfs fi sync"?

Tried this, and it goes ro after a while again. It seems like the
disks are being added, since I tried creating partitions on the disks,
and adding the partitions (using -f) to the btrfs filesystem seems to
"corrupt" the partitions when I look at them in gparted.

Or rather, it seems like btrfs is somehow marking the disks as ready
to be added, but it never actually gets added (since it never shows up
in "btrfs fi show".
>
> >
> > I suppose I can partition the two disks if you would like me to try to
> > add *4* disks, but I don't really think it would make a difference. I
> > see no errors - which is what I would expect in any case (this sounds
> > like an improvement that could be made).

I went ahead and also created two partitions each on the two new usb
disks (for a two of four new partitions) and added them to the btrfs
filesystem using "btrfs device add", then removing a snapshot followed
by a "btrfs fi sync". The filesystem still goes ro after a while.

I also did a "btrfs device add" using the four new partitions and
immediately tried a "btrfs balance cancel" which also went ro.

I then tried not using "skip_balance" and added the four partitions
using "btrfs device add" followed by a "btrfs balance cancel". You
guessed it, it went ro.

I think the biggest hint here seems to be that the new
disks/partitions aren't actually being added to the filesystem, so
further writes to the filesystem continue using the same number of
disks as it was mounted with, making recovery impossible.

Would mounting as degraded make it possible to add the disks and have
it stick? Based on reading elsewhere, it seems like btrfstune to
update the UUIDs of any new partitions would likely corrupt the
filesystem on mount (which was my idea to somehow trick btrfs into
adding new disks offline and having it stick).

Happy to try any other ideas! :)

> >
> > FWIW, I am running btrfs-progs v5.4.1 in case that makes a difference
> > - I can try to update to a newer btrfs-progs, but it doesn't look like
> > btrfs device add is detecting an error here - the kernel is simply not
> > adding the disk.
>
> I don't think btrfs-progs version would make a difference.
>
> Thanks,
> Qu
>
> >
> > Still holding out hope here. :)
> >
> > On Mon, Jun 21, 2021 at 11:15 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>
> >>
> >>
> >> On 2021/6/22 =E4=B8=8A=E5=8D=888:55, Asif Youssuff wrote:
> >>> To be clear, it was the last snapshot on an infrequently updated
> >>> subvolume, likely with no changes since the prior snapshot to the one
> >>> deleted.
> >>
> >> The last chance would be try to add *two* devices, which should be at
> >> least 1G for each.
> >>
> >> If the device add can success, then you can go delete as many as
> >> subvolumes, and then remove (I mean btrfs device remove, not unplug) t=
he
> >> added two devices.
> >>
> >>
> >> I think we should really rework the metadata over-commit code to use m=
y
> >> previously submitted calculation to avoid such deadly ENOSPC trap.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> On Mon, Jun 21, 2021 at 8:50 PM Asif Youssuff <yoasif@gmail.com> wrot=
e:
> >>>>
> >>>> I tried removing a single snapshot from a subvolume with rarely
> >>>> updated data (likely no changes at all to that subvolume between
> >>>> snapshots), and I was unable to successfully sync the filesystem
> >>>> before it went readonly.
> >>>>
> >>>> On Mon, Jun 21, 2021 at 8:26 PM Qu Wenruo <wqu@suse.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2021/6/22 =E4=B8=8A=E5=8D=888:12, Asif Youssuff wrote:
> >>>>>> On Mon, Jun 21, 2021 at 7:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
> >>>>>>
> >>>>>>>> I have tried removing snapshots, but the disk continues to go ro=
 -
> >>>>>>>> after remount, the subvolumes are still there. Is there a way to=
 force
> >>>>>>>> a sync of the subvolume removal before the fs goes ro?
> >>>>>>>
> >>>>>>> Maybe you can try "btrfs fi sync" before remount?
> >>>>>>
> >>>>>> Tried deleting a bunch of snapshots and immediately did a btrfs fi
> >>>>>> sync - still forced ro pretty quickly:
> >>>>>
> >>>>> So that's the worst case, metadata already exhausted.
> >>>>>
> >>>>> Have you tried to just delete one small subvolume and then fi sync?
> >>>>>
> >>>>> It's possible that too many pending subvolume deletion can cause to=
o
> >>>>> much metadata space usage.
> >>>>>
> >>>>> Thus if you do it one by one, there may be a chance to commit succe=
ssfully.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>>
> >>>>>> [ 1810.858326] ------------[ cut here ]------------
> >>>>>> [ 1810.858334] BTRFS: Transaction aborted (error -28)
> >>>>>> [ 1810.858384] BTRFS: error (device sdf) in __btrfs_free_extent:32=
16:
> >>>>>> errno=3D-28 No space left
> >>>>>> [ 1810.858493] BTRFS info (device sdf): forced readonly
> >>>>>> [ 1810.858405] WARNING: CPU: 5 PID: 10137 at
> >>>>>> fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs=
]
> >>>>>> [ 1810.858500] BTRFS: error (device sdf) in
> >>>>>> btrfs_run_delayed_refs:2163: errno=3D-28 No space left
> >>>>>> [ 1810.858635] Modules linked in: veth xt_nat nf_conntrack_netlink
> >>>>>> nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
> >>>>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
> >>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ip=
v4
> >>>>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
> >>>>>> ip6_tables iptable_filter bpfilter ppdev parport_pc parport
> >>>>>> vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth ecdh_gen=
eric
> >>>>>> ecc msr binfmt_misc input_leds joydev ipmi_ssif dm_crypt
> >>>>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerc=
lamp
> >>>>>> coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
> >>>>>> ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_csta=
te
> >>>>>> intel_pch_thermal lpc_ich mei_me mei acpi_ipmi ipmi_si ipmi_devint=
f
> >>>>>> ipmi_msghandler ie31200_edac mac_hid acpi_pad sch_fq_codel ib_iser
> >>>>>> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
> >>>>>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_gene=
ric
> >>>>>> raid10 raid456
> >>>>>> [ 1810.858782]  async_raid6_recov async_memcpy async_pq async_xor
> >>>>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
> >>>>>> hid_generic usbhid hid uas usb_storage ast drm_vram_helper
> >>>>>> drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgbl=
t
> >>>>>> fb_sys_fops cec mpt3sas rc_core raid_class drm igb ahci xhci_pci d=
ca
> >>>>>> e1000e libahci i2c_algo_bit scsi_transport_sas xhci_pci_renesas vi=
deo
> >>>>>> [ 1810.858857] CPU: 5 PID: 10137 Comm: btrfs-transacti Tainted: G
> >>>>>>      W         5.12.12-051212-generic #202106180931
> >>>>>> [ 1810.858865] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3=
.0 04/24/2015
> >>>>>> [ 1810.858868] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
> >>>>>> [ 1810.858973] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d =
8b
> >>>>>> 45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 0c 75 c0 e8 =
15
> >>>>>> e1 f6 f7 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 5=
2 74
> >>>>>> c0 e8
> >>>>>> [ 1810.858980] RSP: 0018:ffffab4702a43c00 EFLAGS: 00010286
> >>>>>> [ 1810.858986] RAX: 0000000000000000 RBX: 0000000000000030 RCX: ff=
ff95e57fd585c8
> >>>>>> [ 1810.858991] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ff=
ff95e57fd585c0
> >>>>>> [ 1810.858995] RBP: ffffab4702a43ca8 R08: 0000000000000000 R09: ff=
ffab4702a439e0
> >>>>>> [ 1810.858998] R10: ffffab4702a439d8 R11: ffffffffb99542e8 R12: 00=
0157fe74a6e000
> >>>>>> [ 1810.859002] R13: 0000000000000515 R14: ffff95de8a0941c0 R15: ff=
ff95dfaa212200
> >>>>>> [ 1810.859007] FS:  0000000000000000(0000) GS:ffff95e57fd40000(000=
0)
> >>>>>> knlGS:0000000000000000
> >>>>>> [ 1810.859012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> [ 1810.859016] CR2: 00007fd6fc652718 CR3: 0000000278610004 CR4: 00=
000000001706e0
> >>>>>> [ 1810.859022] Call Trace:
> >>>>>> [ 1810.859031]  run_delayed_data_ref+0x96/0x160 [btrfs]
> >>>>>> [ 1810.859130]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs=
]
> >>>>>> [ 1810.859225]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
> >>>>>> [ 1810.859320]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> >>>>>> [ 1810.859474]  btrfs_commit_transaction+0x68/0xa20 [btrfs]
> >>>>>> [ 1810.859633]  ? start_transaction+0xd5/0x590 [btrfs]
> >>>>>> [ 1810.859783]  ? __next_timer_interrupt+0xd0/0x110
> >>>>>> [ 1810.859800]  transaction_kthread+0x138/0x1b0 [btrfs]
> >>>>>> [ 1810.859905]  kthread+0x12f/0x150
> >>>>>> [ 1810.859916]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [bt=
rfs]
> >>>>>> [ 1810.860020]  ? __kthread_bind_mask+0x70/0x70
> >>>>>> [ 1810.860031]  ret_from_fork+0x22/0x30
> >>>>>> [ 1810.860045] ---[ end trace 64a07c4b91899089 ]---
> >>>>>> [ 1810.860052] BTRFS: error (device sdf) in __btrfs_free_extent:32=
16:
> >>>>>> errno=3D-28 No space left
> >>>>>> [ 1810.860172] BTRFS: error (device sdf) in
> >>>>>> btrfs_run_delayed_refs:2163: errno=3D-28 No space left
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Thanks,
> >>>> Asif
> >>>
> >>>
> >>>
> >
> >
> >



--=20
Thanks,
Asif
