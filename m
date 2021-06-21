Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B263AE199
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUCGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 22:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFUCGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 22:06:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E605C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 19:04:29 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c138so26560026qkg.5
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9eiWIkmMJHK8FoxCCiTfRvvJPvzBOMyIIjrD512LJU=;
        b=UBzmS4l4WJeWEE13XNGjkkKgnANg3isKSjvinbYwry7vHnF0HxwiaZgiyXK1mIKf4H
         KDxhsKBlf25GoHWMVnklvK1uXckymTy7LaGiwCCeqTU1lh1OFlOBQeEbzXO7PW9TiewZ
         Q9BDEceTR0t95tR4kcV/I5o/fw26xpv6zeyJ3UKxqZGAY1ZQaMlRuLBT08yZC025c6Gy
         wFk0SlB42QlqPAmRO6LAClWiBdOjtw5DPXnd1ImGh3Gg0D5ivDdTRmkNecbOyEOxBuwQ
         +pWEmFu4b7dWVHCaziayvkCNsfkowC72eAcIDPqKm4BOLRLslmWDL9W16gbY3MR0lZxl
         L45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9eiWIkmMJHK8FoxCCiTfRvvJPvzBOMyIIjrD512LJU=;
        b=my6GZtKTyXswDuVR5maOHeooWDBj9rGBPM1RsWbv93qd9Q/jTdULNyvBA+Kkd1mbWk
         7kNpynT1mybXkEVLqkzi9iMvHkOjALHdl3yzZ/GZAg/qeXpyXxQ3i//tpmitLCbc0Lkr
         H8Nqg3PWh7QKrrhme4UoUgFatfnPriUYIZ9lNdzbFyyyGs6hSpql7OoLo0SsALIv95za
         2jZQgsTxJCTVuZ0rUi7eQzIOD8bJpI6BHwqbAesA/nsWU6Y5liwtjWw0WYST2d+lFegG
         ytuf8yG0cBeTefE6D+GOWi4Aa1WDkox76YxRKd7oGZauQRhLJHGKR5JmbzPG8vDQiTmU
         P1sQ==
X-Gm-Message-State: AOAM533enBXCJEKE4BP+/E8jnjlIkHohVW/PbPkyg1V2nRFwWiX4D0aI
        smm/tg/e+mY0kFIZX82m3v4lHTueZPO09zrCKFTcZMvFs9U=
X-Google-Smtp-Source: ABdhPJz3eh5CLlqrHqsn4x7FZ/cSX8glvn05O5zhgrHZIFO1DxVSjjKbR7ftVGNfwsZ+SQVeTPsvPIikDraPzUMu/SI=
X-Received: by 2002:a25:b903:: with SMTP id x3mr30096679ybj.82.1624241068507;
 Sun, 20 Jun 2021 19:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
 <ab0e8705-e18f-90eb-c42b-318c04a2101c@gmail.com> <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
In-Reply-To: <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Sun, 20 Jun 2021 22:04:16 -0400
Message-ID: <CAHw5_hkJu-O8+F2WNFvab=z4LFfy2QYh0u6yr-CPmcSQHGjEXQ@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 12:24 PM Chris Murphy <lists@colorremedies.com> wrote:

> Can you try to mount with just the skip_balance mount option, and show
> dmesg from that point? I'd like to know how much time we have before
> it goes read only and also what it's trying to do when it goes ro. And
> make sure no user space programs write to this file system at all once
> it's mounted.
> So I think your mount options should be:
>
> skip_balance,nospace_cache

I did this in the mount that follows.

[77381.752464] BTRFS info (device sde): force clearing of disk cache
[77381.752484] BTRFS info (device sde): has skinny extents
[77393.853245] BTRFS info (device sde): bdev /dev/sde errs: wr
1298641, rd 7847, flush 5, corrupt 13, gen 0
[77393.853267] BTRFS info (device sde): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 231, gen 0
[77393.853277] BTRFS info (device sde): bdev /dev/sdg errs: wr 957680,
rd 477125, flush 3, corrupt 51358, gen 719
[77393.853287] BTRFS info (device sde): bdev /dev/sdd errs: wr
3620417, rd 304456, flush 8, corrupt 164, gen 0
[77393.853296] BTRFS info (device sde): bdev /dev/sdp errs: wr 0, rd
0, flush 0, corrupt 271, gen 0
[77393.853304] BTRFS info (device sde): bdev /dev/sdl errs: wr 0, rd
0, flush 0, corrupt 404, gen 0
[77393.853311] BTRFS info (device sde): bdev /dev/sdb errs: wr 0, rd
0, flush 0, corrupt 111, gen 0
[77393.853319] BTRFS info (device sde): bdev /dev/sda errs: wr 0, rd
0, flush 0, corrupt 553, gen 0
[77393.853326] BTRFS info (device sde): bdev /dev/sdn errs: wr 0, rd
0, flush 0, corrupt 1613, gen 0
[77393.853334] BTRFS info (device sde): bdev /dev/sdf errs: wr 0, rd
0, flush 0, corrupt 369, gen 0
[77393.853342] BTRFS info (device sde): bdev /dev/sdm errs: wr 0, rd
0, flush 0, corrupt 175, gen 0
[77393.853349] BTRFS info (device sde): bdev /dev/sdc errs: wr 0, rd
0, flush 0, corrupt 1663, gen 0
[77393.853357] BTRFS info (device sde): bdev /dev/sdo errs: wr
189088938, rd 10028589, flush 0, corrupt 1037856, gen 698
[77763.027733] BTRFS info (device sde): balance: resume skipped
[77763.027749] BTRFS info (device sde): checking UUID tree
[78007.542667] ------------[ cut here ]------------
[78007.542675] BTRFS: Transaction aborted (error -28)
[78007.542745] WARNING: CPU: 4 PID: 29307 at
fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs]
[78007.542888] Modules linked in: xt_CHECKSUM iptable_mangle
ipt_REJECT nf_reject_ipv4 veth xt_nat xt_tcpudp xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
xt_addrtype iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 br_netfilter bridge stp llc ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bpfilter ppdev parport_pc
parport vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth
ecdh_generic ecc msr binfmt_misc joydev input_leds ipmi_ssif dm_crypt
intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm rapl intel_cstate intel_pch_thermal lpc_ich
mei_me mei acpi_ipmi ipmi_si ipmi_devintf ie31200_edac ipmi_msghandler
acpi_pad mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables
x_tables autofs4 btrfs blake2b_generic raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0
[78007.543056]  multipath linear dm_mirror dm_region_hash dm_log
hid_generic usbhid hid uas usb_storage ast drm_vram_helper
drm_ttm_helper crct10dif_pclmul ttm crc32_pclmul ghash_clmulni_intel
drm_kms_helper aesni_intel crypto_simd cryptd syscopyarea sysfillrect
sysimgblt fb_sys_fops cec rc_core mpt3sas igb drm ahci raid_class dca
xhci_pci e1000e libahci i2c_algo_bit scsi_transport_sas
xhci_pci_renesas video
[78007.543136] CPU: 4 PID: 29307 Comm: btrfs-transacti Tainted: G
  W         5.12.12-051212-generic #202106180931
[78007.543143] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04/24/2015
[78007.543147] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
[78007.543256] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d 8b
45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 ec 8a c0 e8 15
01 41 e0 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 32 8a
c0 e8
[78007.543263] RSP: 0018:ffffb84b88a4fc00 EFLAGS: 00010286
[78007.543270] RAX: 0000000000000000 RBX: 000000000000000a RCX: ffff97b53fd185c8
[78007.543274] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff97b53fd185c0
[78007.543278] RBP: ffffb84b88a4fca8 R08: 0000000000000000 R09: ffffb84b88a4f9e0
[78007.543282] R10: ffffb84b88a4f9d8 R11: ffffffffa1f542e8 R12: 000157fefe76e000
[78007.543286] R13: 000000000000015f R14: ffff97ae4b7f4850 R15: ffff97b020f4bb00
[78007.543291] FS:  0000000000000000(0000) GS:ffff97b53fd00000(0000)
knlGS:0000000000000000
[78007.543296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[78007.543300] CR2: 00007f3ad3a504c0 CR3: 0000000743a10002 CR4: 00000000001706e0
[78007.543306] Call Trace:
[78007.543315]  run_delayed_data_ref+0x96/0x160 [btrfs]
[78007.543424]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs]
[78007.543528]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
[78007.543633]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[78007.543738]  btrfs_commit_transaction+0x68/0xa20 [btrfs]
[78007.543852]  ? start_transaction+0xd5/0x590 [btrfs]
[78007.543969]  ? __next_timer_interrupt+0xd0/0x110
[78007.543982]  transaction_kthread+0x138/0x1b0 [btrfs]
[78007.544099]  kthread+0x12f/0x150
[78007.544110]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [btrfs]
[78007.544225]  ? __kthread_bind_mask+0x70/0x70
[78007.544236]  ret_from_fork+0x22/0x30
[78007.544250] ---[ end trace 1702f15782806547 ]---
[78007.544256] BTRFS: error (device sde) in __btrfs_free_extent:3216:
errno=-28 No space left
[78007.546713] BTRFS info (device sde): forced readonly
[78007.546726] BTRFS: error (device sde) in
btrfs_run_delayed_refs:2163: errno=-28 No space left


> That way space cache v1 isn't created. If you've already mounted
> before seeing this and it went read-only, you might need to do:
>
> Also, provide the output from "btrfs fi us".

btrfs fi us /media/camino/
WARNING: RAID56 detected, not implemented
Overall:
    Device size:          96.42TiB
    Device allocated:          75.24TiB
    Device unallocated:          21.18TiB
    Device missing:             0.00B
    Used:              74.02TiB
    Free (estimated):          15.30TiB    (min: 11.42TiB)
    Data ratio:                  1.46
    Metadata ratio:              1.00
    Global reserve:         512.00MiB    (used: 1.61MiB)

Data,RAID1: Size:37.59TiB, Used:36.98TiB
   /dev/sda       5.70TiB
   /dev/sdb       4.65TiB
   /dev/sdc       5.80TiB
   /dev/sdd       4.69TiB
   /dev/sde       4.62TiB
   /dev/sdf       5.41TiB
   /dev/sdg      11.22TiB
   /dev/sdj       6.32TiB
   /dev/sdl       5.26TiB
   /dev/sdm       5.71TiB
   /dev/sdn       5.68TiB
   /dev/sdo       4.01TiB
   /dev/sdp       6.10TiB

Data,RAID6: Size:13.77TiB, Used:13.75TiB
   /dev/sda       1.56TiB
   /dev/sdb     808.33GiB
   /dev/sdc       1.46TiB
   /dev/sdd     775.98GiB
   /dev/sde     849.14GiB
   /dev/sdf       2.07TiB
   /dev/sdg       1.45TiB
   /dev/sdj     964.87GiB
   /dev/sdl       2.00TiB
   /dev/sdm       1.56TiB
   /dev/sdn       1.58TiB
   /dev/sdo       2.37TiB
   /dev/sdp       1.14TiB

Metadata,single: Size:66.00GiB, Used:65.58GiB
   /dev/sda      18.00GiB
   /dev/sdb      14.00GiB
   /dev/sdc      16.00GiB
   /dev/sdd      15.00GiB
   /dev/sde       9.00GiB
   /dev/sdf      12.00GiB
   /dev/sdg      66.00GiB
   /dev/sdj      14.00GiB
   /dev/sdl      15.00GiB
   /dev/sdm      11.00GiB
   /dev/sdn      18.00GiB
   /dev/sdo      28.00GiB
   /dev/sdp      28.00GiB

System,single: Size:32.00MiB, Used:13.00MiB
   /dev/sdf      32.00MiB
   /dev/sdg      32.00MiB
   /dev/sdl      32.00MiB
   /dev/sdo      32.00MiB

Unallocated:
   /dev/sda       1.02MiB
   /dev/sdb       1.02MiB
   /dev/sdc       1.02MiB
   /dev/sdd       1.02MiB
   /dev/sde       1.02MiB
   /dev/sdf       1.60TiB
   /dev/sdg       3.44MiB
   /dev/sdj       1.02MiB
   /dev/sdl      14.09MiB
   /dev/sdm       1.02MiB
   /dev/sdn       1.02MiB
   /dev/sdo     881.16GiB
   /dev/sdp       1.02MiB

> There is a small chance it's possible to add four devices, and it
> would need to be four, so that it can do what it's being very
> insistent on, which is create a metadata block group. Since it's
> raid1c4 profile, it needs to create one chunk on each of four devices.
> If it works, that'd allow a filtered balance, to free up specific data
> block groups and hopefully get enough space free to then remove those
> four new devices.
> If you can mount with skip_balance and it does not go read only after
> ~5 minutes, try 'btrfs device add'. Just be aware that if the add
> succeeds, that device is part of the file system now, until 'btrfs
> device remove' succeeds. So they can't go missing or things get even
> harder than they already are.

Before I emailed the list, I had tried to add a new disk - it never
worked for me - I think because btrfs sees the balance operation in
progress and the "add" won't complete with it.  I can try again, but
was previously unsuccessful in adding a single device.

> Also, consider backing up the most important data off this array in
> case it's not repairable. Just in case. Right now it's going read-only
> to prevent further confusion on disk. It's worth taking advantage of
> it.

Yep, the array seems stable enough now, so I can work to make those backups.

> Last, consider updating btrfs-progs. Off hand I don't think you need
> anything bug fix wise between 5.4 and 5.12, but 5.12.1 is current and
> it'd be better to be closer to that, even though it's a low priority.

I'm running an older Ubuntu LTS and it is a bit painful to do this - I
can certainly try if it makes sense, though.

-- 
Thanks,
Asif
