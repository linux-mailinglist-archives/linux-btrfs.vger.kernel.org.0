Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4E3AFA1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 02:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFVAPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFVAPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 20:15:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC19C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 17:12:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 22so14108484qkv.8
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nN3O1RvtF3uUr3pVWHlBK6QbuKJdJmNNgLVJcLHqsk=;
        b=pmlVbK8h6I4wx+T9SYlT0HiN+FwwKErZcIcZjybzcB0hjUc/f9A2sGJeCWoatwkgi4
         J4Mh1iSBDW26jDh2qICIxIuygeRTMRS6IZDSBfoI7MVIMnDqB/GAcH+sdJylvVe+5w+Z
         dSwgnXeT8rqCq8t7GnX/ONVeEggStqDWaJkRtStZXqqdSt9/Ik1Pg2MdW56Zv9RaEubX
         OXMfyTjemEPF/WG4uZeRLYCpeqyJAMVVO8sy1clP6DkaR5aMJd9b5JjDDVf1V7bpdulD
         0M2EzP3RFNX+Wea8uyCMU9so0dMzGaINa19FSz9ATdZuviFCd+fXsROSihTgyAIVB8L6
         IXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nN3O1RvtF3uUr3pVWHlBK6QbuKJdJmNNgLVJcLHqsk=;
        b=Zti8FWyCFp45GN9P2PvzXMFm9gzRxaO58qP4TMkRupMb7ODoEUwqphMqa279HSgaPr
         NoCzo8OSLQlpsAlEBRrhhK3De+Myf6gEXhCrQoHph2K+WDDMgNj8hxLHiGf32TnWsjgl
         Y+Ee5eOt/ALq0txleBaxWSMxz74VvADbBRSXYRHmVVMRM5OlgiNSznBbvzl3LvrS1xbc
         pDDoK+3+xTZ14UvjUE/6jrzRU2BOC+KUx8j1T2B3Cc84auBz6LUddDKd/zy/n9SEODMa
         WCWshhT8vjLowIULhJUcbg8GInpAqv4chl95NIRGIhIRoaDKi7fafNtxyLfqc1lwxUnN
         Rsbg==
X-Gm-Message-State: AOAM530y/0Q71LjQdaICZA+/Wozl2YQ3UqAfL3k4djWC9KTELsMbHgkw
        shCdawGaZCxhGvQm3EBC3nzBhyD4QI/5x2VuMoptyBnFWQk=
X-Google-Smtp-Source: ABdhPJxUyNX4Paep5n8Hv62kVLsjycNMGtboV2tFzvk8/2w+k6IyJgs/j8Z6N4fAwoTTGZoqzWUSLCsdaQjeMODDQZA=
X-Received: by 2002:a25:9705:: with SMTP id d5mr1156170ybo.388.1624320774095;
 Mon, 21 Jun 2021 17:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
In-Reply-To: <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Mon, 21 Jun 2021 20:12:43 -0400
Message-ID: <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 21, 2021 at 7:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> > I have tried removing snapshots, but the disk continues to go ro -
> > after remount, the subvolumes are still there. Is there a way to force
> > a sync of the subvolume removal before the fs goes ro?
>
> Maybe you can try "btrfs fi sync" before remount?

Tried deleting a bunch of snapshots and immediately did a btrfs fi
sync - still forced ro pretty quickly:

[ 1810.858326] ------------[ cut here ]------------
[ 1810.858334] BTRFS: Transaction aborted (error -28)
[ 1810.858384] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
errno=-28 No space left
[ 1810.858493] BTRFS info (device sdf): forced readonly
[ 1810.858405] WARNING: CPU: 5 PID: 10137 at
fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs]
[ 1810.858500] BTRFS: error (device sdf) in
btrfs_run_delayed_refs:2163: errno=-28 No space left
[ 1810.858635] Modules linked in: veth xt_nat nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4
xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter bpfilter ppdev parport_pc parport
vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth ecdh_generic
ecc msr binfmt_misc input_leds joydev ipmi_ssif dm_crypt
intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cstate
intel_pch_thermal lpc_ich mei_me mei acpi_ipmi ipmi_si ipmi_devintf
ipmi_msghandler ie31200_edac mac_hid acpi_pad sch_fq_codel ib_iser
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic
raid10 raid456
[ 1810.858782]  async_raid6_recov async_memcpy async_pq async_xor
async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
hid_generic usbhid hid uas usb_storage ast drm_vram_helper
drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops cec mpt3sas rc_core raid_class drm igb ahci xhci_pci dca
e1000e libahci i2c_algo_bit scsi_transport_sas xhci_pci_renesas video
[ 1810.858857] CPU: 5 PID: 10137 Comm: btrfs-transacti Tainted: G
  W         5.12.12-051212-generic #202106180931
[ 1810.858865] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04/24/2015
[ 1810.858868] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
[ 1810.858973] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d 8b
45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 0c 75 c0 e8 15
e1 f6 f7 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 52 74
c0 e8
[ 1810.858980] RSP: 0018:ffffab4702a43c00 EFLAGS: 00010286
[ 1810.858986] RAX: 0000000000000000 RBX: 0000000000000030 RCX: ffff95e57fd585c8
[ 1810.858991] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95e57fd585c0
[ 1810.858995] RBP: ffffab4702a43ca8 R08: 0000000000000000 R09: ffffab4702a439e0
[ 1810.858998] R10: ffffab4702a439d8 R11: ffffffffb99542e8 R12: 000157fe74a6e000
[ 1810.859002] R13: 0000000000000515 R14: ffff95de8a0941c0 R15: ffff95dfaa212200
[ 1810.859007] FS:  0000000000000000(0000) GS:ffff95e57fd40000(0000)
knlGS:0000000000000000
[ 1810.859012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1810.859016] CR2: 00007fd6fc652718 CR3: 0000000278610004 CR4: 00000000001706e0
[ 1810.859022] Call Trace:
[ 1810.859031]  run_delayed_data_ref+0x96/0x160 [btrfs]
[ 1810.859130]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs]
[ 1810.859225]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
[ 1810.859320]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[ 1810.859474]  btrfs_commit_transaction+0x68/0xa20 [btrfs]
[ 1810.859633]  ? start_transaction+0xd5/0x590 [btrfs]
[ 1810.859783]  ? __next_timer_interrupt+0xd0/0x110
[ 1810.859800]  transaction_kthread+0x138/0x1b0 [btrfs]
[ 1810.859905]  kthread+0x12f/0x150
[ 1810.859916]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [btrfs]
[ 1810.860020]  ? __kthread_bind_mask+0x70/0x70
[ 1810.860031]  ret_from_fork+0x22/0x30
[ 1810.860045] ---[ end trace 64a07c4b91899089 ]---
[ 1810.860052] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
errno=-28 No space left
[ 1810.860172] BTRFS: error (device sdf) in
btrfs_run_delayed_refs:2163: errno=-28 No space left



-- 
Thanks,
Asif
