Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1B3ADDD9
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFTJNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhFTJNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 05:13:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29824C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 02:11:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g4so21272416qkl.1
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=65X8xgr+hjkqN88uIyegW7gY0U2Fnom5EMCco6yAcp0=;
        b=ni6b92ruayd4mRC/sYqNT6UbeDalDMN5hyE8OqtIiZKKjMoqsOMmMgSA1BGK4mQ7n/
         KpQoftU7G2tz23WOYNcuLJm9WMRyGXse4cOfqWQpZy+gWsfWqcmp4ic/twTnz+CL/jQR
         UhbQDM/Vz99r0Z4Nb1djukbh7a8WG4VjJwXHw1ZlYQ6NyKUupacTbcrLd9oPPKKw35Zz
         mooZAWtc52Y5k8reC1m4QZjNPmqUPNTYrFQ+QeC30uD+AATpxTmDLTvxVrWlYlyyb6t5
         R2x2HvDzM+CH2yJleXyJqCPna430sz31iPOEY52kJmS6QhFJVGcgCxSFYpifTs3iB4XS
         au1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=65X8xgr+hjkqN88uIyegW7gY0U2Fnom5EMCco6yAcp0=;
        b=b9YCrnd62Am7fJYCsTSn8oPQCf1i+S2JKEqyE7qhGqjUfPkWtBs/M1OG2xR58fJDxW
         DVWo8it0VMywssRUYS62AiifXG66g4z6kKSweK7Sdc7gil+iQtK4nKq8bxpMHTiHlBeo
         zfF9A30IKyyRrDzkgiYsEVtcvDSynDsT60Lb6KQc9cXogCzfcOFAlPm/7prawigXLQl8
         ehGzWU2ZPb9BTIY60kkmFAk+6lS9Ok69n8j2zMriry4XgkYI8MY8TEQr7lS5NxsOsJrT
         jQmqBJbVaT0nDJmEzl5SrpsELiO0h7wBLxkvJ8kul6CmmdtvhJGuc63XebA+G9ZpDDsD
         0c1w==
X-Gm-Message-State: AOAM532jKH8vLlO0Ybe1p6a3IKmzYPBiq2Mn9splc22dQsGHct7MjqvC
        8V6BL12JpCBx4TuaTmWPsXirqRWOvWd8ILaGyblDuJ7WZ2I=
X-Google-Smtp-Source: ABdhPJwn980t3hZjySvAmyZ4XMy2dnnx/q5XdsdAdTn3pto4Hsj5ONjRvenZej4hLy3Nh8qI91r2/rW3/CjU4qWdE7g=
X-Received: by 2002:a25:4055:: with SMTP id n82mr24048930yba.242.1624180297823;
 Sun, 20 Jun 2021 02:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com> <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
In-Reply-To: <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Sun, 20 Jun 2021 05:11:26 -0400
Message-ID: <CAHw5_hmiLqLRJi+8vvvPzU8mSgDqSBbWXxeX223sZSBpdU8Z_A@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replies inline:

On 6/19/21 2:47 PM, Chris Murphy wrote:
> I'm guessing these are stale because there aren't any other messages
> indicating these counts are going up. You can optionally clear them
> with 'btrfs dev stats -z'. It's personal preference, but I figure once
> an array is healthy, these should be zero'd out because as soon as the
> counts change from 0, it's important to find out what's going on.
Yeah, I am pretty sure these are stale.
>> [ 814.681305] BTRFS info (device sdf): balance: resume skipped
>>
>> Is there a balance in progress? Conversion between profiles? And if
>> so, are you converting to raid1 or to raid6? Related operations are
>> filesystem resize, and device remove.
There is a balance in progress - I was trying to balance across disks.
I mistakenly used a balance filter that would end up likely balancing
everything. I wasn't trying to convert between profiles. Most of the
existing data is in raid10, but I never did a full rebalance to raid6
(new data is written as raid6).
> You might explicitly cancel the balance, and start a new one to free
> up some space in data block groups. I think what's going on is it
> wants to allocate another metadata block group but because it's
> raid1c4, it can't allocate a 1GiB chunk on four devices, because
> there's no more unallocated space.

I tried to cancel the balance, but it ends up going ro (I think as a
result of the cancel request):

[17105.643738] ------------[ cut here ]------------
[17105.643747] BTRFS: Transaction aborted (error -28)
[17105.643802] BTRFS: error (device sde) in __btrfs_free_extent:3216:
errno=-28 No space left
[17105.643820] WARNING: CPU: 3 PID: 8461 at
fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs]
[17105.646288] Modules linked in:
[17105.646289] BTRFS info (device sde): forced readonly
[17105.646291]  xt_CHECKSUM iptable_mangle ipt_REJECT nf_reject_ipv4
[17105.646299] BTRFS: error (device sde) in
btrfs_run_delayed_refs:2163: errno=-28 No space left
[17105.646302]  veth xt_nat xt_tcpudp xt_conntrack xt_MASQUERADE
[17105.648805] BTRFS: error (device sde) in reset_balance_state:3421:
errno=-28 No space left
[17105.649176] BTRFS info (device sde): balance: canceled
[17105.652489]  nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
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
raid6_pq libcrc32c raid1 raid0 multipath linear dm_mirror
dm_region_hash dm_log hid_generic usbhid hid uas usb_storage ast
drm_vram_helper
[17105.652825]  drm_ttm_helper crct10dif_pclmul ttm crc32_pclmul
ghash_clmulni_intel drm_kms_helper aesni_intel crypto_simd cryptd
syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core mpt3sas igb
drm ahci raid_class dca xhci_pci e1000e libahci i2c_algo_bit
scsi_transport_sas xhci_pci_renesas video
[17105.652930] CPU: 3 PID: 8461 Comm: btrfs-transacti Tainted: G
 W         5.12.12-051212-generic #202106180931
[17105.652943] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04/24/2015
[17105.652947] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
[17105.653083] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d 8b
45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 ec 8a c0 e8 15
01 41 e0 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 32 8a
c0 e8
[17105.653090] RSP: 0018:ffffb84b83393b78 EFLAGS: 00010286
[17105.653097] RAX: 0000000000000000 RBX: 000000000000003f RCX: ffff97b53fcd85c8
[17105.653101] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff97b53fcd85c0
[17105.653105] RBP: ffffb84b83393c20 R08: 0000000000000000 R09: ffffb84b83393958
[17105.653109] R10: ffffb84b83393950 R11: ffffffffa1f542e8 R12: 000157fc8e48e000
[17105.653113] R13: 000000000000068c R14: ffff97b00af52ee0 R15: ffff97afaca01c00
[17105.653117] FS:  0000000000000000(0000) GS:ffff97b53fcc0000(0000)
knlGS:0000000000000000
[17105.653122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17105.653127] CR2: 00007f0e7f5944d0 CR3: 0000000743a10001 CR4: 00000000001706e0
[17105.653137] Call Trace:
[17105.653148]  run_delayed_data_ref+0x96/0x160 [btrfs]
[17105.653314]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs]
[17105.653446]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
[17105.653607]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
[17105.653769]  btrfs_start_dirty_block_groups+0x296/0x4f0 [btrfs]
[17105.654008]  ? btrfs_create_pending_block_groups+0x1c2/0x2c0 [btrfs]
[17105.654231]  btrfs_commit_transaction+0x7ff/0xa20 [btrfs]
[17105.654418]  ? start_transaction+0xd5/0x590 [btrfs]
[17105.654592]  ? __next_timer_interrupt+0xd0/0x110
[17105.654617]  transaction_kthread+0x138/0x1b0 [btrfs]
[17105.654798]  kthread+0x12f/0x150
[17105.654820]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [btrfs]
[17105.655020]  ? __kthread_bind_mask+0x70/0x70
[17105.655043]  ret_from_fork+0x22/0x30
[17105.655064] ---[ end trace 1702f15782806541 ]---
[17105.655073] BTRFS: error (device sde) in __btrfs_free_extent:3216:
errno=-28 No space left
[17105.658820] BTRFS: error (device sde) in
btrfs_run_delayed_refs:2163: errno=-28 No space left

I tried to reduce the number of writes to the disk to allow the
balance cancel to complete via the clear_cache,nospace_cache mount
options, but that doesn't seem to have helped.

My complete mount options are:
noatime,nodiratime,space_cache=v2,clear_cache,nospace_cache,skip_balance,commit=120,compress-force=zstd:9

Any other ideas are appreciated!

Thanks,
Asif
