Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820D03AFA56
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 02:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFVAw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 20:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVAw5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 20:52:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF44C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 17:50:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q64so28920432qke.7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 17:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oIN6c1xCSiOfLn2kKxmstlsG2u2YZRJtk6ECLibOy2I=;
        b=KDuBNl2ZHmfgbglqAEccXGW/vJiE5ZJ/MUkQwGDS9aDnQkahQ7vCFgfGJKWg/exF+H
         aC+nYh7KU6CrigtG3q80lPh4lM8abMPXuAb3TbR/5fHLPu05tqzEl9VUpQmGTXMMvKnS
         0+bJf6+6AnJeCIW0K2muD5PGr79ELFWAKnlHIuynqzhR3wx6WexgxsCqP67/+6H7XKIp
         jSIYTrnvS+8imFg/Hvp1BzqrUBwpS8BrBucUajIgMsOwAoX9sZBDdiC8JQQUU0ox5BmB
         Y1cDpylg7YNxJFXXMyFwKJa/LGJS37efLSH7HmzYbeII4AaC6h+AinjxPn/Gpd6WV/7P
         xbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oIN6c1xCSiOfLn2kKxmstlsG2u2YZRJtk6ECLibOy2I=;
        b=ck/NzOhlusqD1mK1xwktgbWdB/6E0v2WVKvzuOpFOJ1VAM41PRHH6+bdu5yer86Ptu
         woEkyT42pYu8pK7/iEkKIL0tuJZvRctDO+jQbuFUK6YLmhqImpsl5vsQYBFxfAxEH3Cm
         oNIuz0c2/7X7Za8R5mK01Q+lnkRRzE+xb4KezwuPVxSSa/CJAI4CjaiVzuvHMaqGiOtf
         MI1jqacpD85hv1ZPsM7qpPwo3txH9FRO2veE6Zj9i7AFl9ZP1SlOV8hzNeWeCH+7jIsG
         vj5j1k4iWXUFiQsc3OTMFvPb3g6+IQ3vuB9XKSUxhlMpFn0AQBYhfD4hMo+GKDyWEZSL
         YYtg==
X-Gm-Message-State: AOAM530HU5h7s2cxU4gMOEZS2D83q+HTA+XLPSAnP5QDo2nTIu3qWvd+
        I2NuuKQ0C7gzJTB0+nNjVT9BZG02QZ/7vxaHX8w=
X-Google-Smtp-Source: ABdhPJwbqOOXVzqDyEw+Tl0aha4DHhDY2bjrwf+4+ZriDenqXny7Banf8jgnG+UwO1DhimzS4uawVZubaAPJnNT866E=
X-Received: by 2002:a25:25c5:: with SMTP id l188mr1168925ybl.41.1624323041807;
 Mon, 21 Jun 2021 17:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com>
In-Reply-To: <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Mon, 21 Jun 2021 20:50:30 -0400
Message-ID: <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I tried removing a single snapshot from a subvolume with rarely
updated data (likely no changes at all to that subvolume between
snapshots), and I was unable to successfully sync the filesystem
before it went readonly.

On Mon, Jun 21, 2021 at 8:26 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2021/6/22 =E4=B8=8A=E5=8D=888:12, Asif Youssuff wrote:
> > On Mon, Jun 21, 2021 at 7:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >
> >>> I have tried removing snapshots, but the disk continues to go ro -
> >>> after remount, the subvolumes are still there. Is there a way to forc=
e
> >>> a sync of the subvolume removal before the fs goes ro?
> >>
> >> Maybe you can try "btrfs fi sync" before remount?
> >
> > Tried deleting a bunch of snapshots and immediately did a btrfs fi
> > sync - still forced ro pretty quickly:
>
> So that's the worst case, metadata already exhausted.
>
> Have you tried to just delete one small subvolume and then fi sync?
>
> It's possible that too many pending subvolume deletion can cause too
> much metadata space usage.
>
> Thus if you do it one by one, there may be a chance to commit successfull=
y.
>
> Thanks,
> Qu
> >
> > [ 1810.858326] ------------[ cut here ]------------
> > [ 1810.858334] BTRFS: Transaction aborted (error -28)
> > [ 1810.858384] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
> > errno=3D-28 No space left
> > [ 1810.858493] BTRFS info (device sdf): forced readonly
> > [ 1810.858405] WARNING: CPU: 5 PID: 10137 at
> > fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs]
> > [ 1810.858500] BTRFS: error (device sdf) in
> > btrfs_run_delayed_refs:2163: errno=3D-28 No space left
> > [ 1810.858635] Modules linked in: veth xt_nat nf_conntrack_netlink
> > nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
> > iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
> > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4
> > xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
> > ip6_tables iptable_filter bpfilter ppdev parport_pc parport
> > vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth ecdh_generic
> > ecc msr binfmt_misc input_leds joydev ipmi_ssif dm_crypt
> > intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
> > coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
> > ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cstate
> > intel_pch_thermal lpc_ich mei_me mei acpi_ipmi ipmi_si ipmi_devintf
> > ipmi_msghandler ie31200_edac mac_hid acpi_pad sch_fq_codel ib_iser
> > rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
> > scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic
> > raid10 raid456
> > [ 1810.858782]  async_raid6_recov async_memcpy async_pq async_xor
> > async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
> > hid_generic usbhid hid uas usb_storage ast drm_vram_helper
> > drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
> > fb_sys_fops cec mpt3sas rc_core raid_class drm igb ahci xhci_pci dca
> > e1000e libahci i2c_algo_bit scsi_transport_sas xhci_pci_renesas video
> > [ 1810.858857] CPU: 5 PID: 10137 Comm: btrfs-transacti Tainted: G
> >    W         5.12.12-051212-generic #202106180931
> > [ 1810.858865] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04=
/24/2015
> > [ 1810.858868] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
> > [ 1810.858973] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d 8b
> > 45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 0c 75 c0 e8 15
> > e1 f6 f7 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 52 74
> > c0 e8
> > [ 1810.858980] RSP: 0018:ffffab4702a43c00 EFLAGS: 00010286
> > [ 1810.858986] RAX: 0000000000000000 RBX: 0000000000000030 RCX: ffff95e=
57fd585c8
> > [ 1810.858991] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95e=
57fd585c0
> > [ 1810.858995] RBP: ffffab4702a43ca8 R08: 0000000000000000 R09: ffffab4=
702a439e0
> > [ 1810.858998] R10: ffffab4702a439d8 R11: ffffffffb99542e8 R12: 000157f=
e74a6e000
> > [ 1810.859002] R13: 0000000000000515 R14: ffff95de8a0941c0 R15: ffff95d=
faa212200
> > [ 1810.859007] FS:  0000000000000000(0000) GS:ffff95e57fd40000(0000)
> > knlGS:0000000000000000
> > [ 1810.859012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1810.859016] CR2: 00007fd6fc652718 CR3: 0000000278610004 CR4: 0000000=
0001706e0
> > [ 1810.859022] Call Trace:
> > [ 1810.859031]  run_delayed_data_ref+0x96/0x160 [btrfs]
> > [ 1810.859130]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs]
> > [ 1810.859225]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
> > [ 1810.859320]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> > [ 1810.859474]  btrfs_commit_transaction+0x68/0xa20 [btrfs]
> > [ 1810.859633]  ? start_transaction+0xd5/0x590 [btrfs]
> > [ 1810.859783]  ? __next_timer_interrupt+0xd0/0x110
> > [ 1810.859800]  transaction_kthread+0x138/0x1b0 [btrfs]
> > [ 1810.859905]  kthread+0x12f/0x150
> > [ 1810.859916]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [btrfs]
> > [ 1810.860020]  ? __kthread_bind_mask+0x70/0x70
> > [ 1810.860031]  ret_from_fork+0x22/0x30
> > [ 1810.860045] ---[ end trace 64a07c4b91899089 ]---
> > [ 1810.860052] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
> > errno=3D-28 No space left
> > [ 1810.860172] BTRFS: error (device sdf) in
> > btrfs_run_delayed_refs:2163: errno=3D-28 No space left
> >
> >
> >
>


--=20
Thanks,
Asif
