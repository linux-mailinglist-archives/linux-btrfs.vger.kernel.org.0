Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B94483718
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiACSjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiACSjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC8C061761
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 10:39:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 910FE611C2
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 18:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4158C36AEE
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641235185;
        bh=nbQ4Ppel0GW31F9eHrwLlF9r3HebAm1eZIZ/aOPGp5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GWzOmenPkeHByRZGFJNiaA5k8uz8h0oFglfBBFtLo0Y0CP0VW7LF8IL+A+cCP4cKe
         QHJKiDTHZhWoIVE2TZldt9hFTk4QtadOe149l4cFVsqwPHNwXB6aD0+wxH3zXlgkua
         8PJpVUQtw6YA4sAYYEHl+7Y7XHMlDFS5+8tQv7+dA7XaFLOP3MB7fBtZ2X+x+VnlcV
         iS8cRPKtbIuvLgxd11WlMZAU1nLCxyB61XQC3TLMJr/pLwrBijsZE7b8ZfAg4Kzjly
         xLmxyJG70CXbVp0DJrqOQ6q85U2To9v/FN60HVjcYgUDPyatxNuHXFZGn2HCvTqnqj
         T+JUzn/sXazMw==
Received: by mail-qt1-f180.google.com with SMTP id o17so31320917qtk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jan 2022 10:39:45 -0800 (PST)
X-Gm-Message-State: AOAM531Ayb/k9J/XNaMhIeanMmwkCw2Kc7csPxYo7lsGCUegGmQrkKP7
        vaQMi5IesmDSLRbLl07tEbekTC7S21nHVLwV/jA=
X-Google-Smtp-Source: ABdhPJwl9DaBQ/KemKh2xCTKySyI9FdTjNTXWXTlrC8PgZiPOyeopIY9E7SEHc3ys+pL6ycYCzgIEYjG/3OPRcQiKD8=
X-Received: by 2002:ac8:674d:: with SMTP id n13mr40608509qtp.491.1641235184909;
 Mon, 03 Jan 2022 10:39:44 -0800 (PST)
MIME-Version: 1.0
References: <f0bed6300fc1dcad405c894640f7140b4a8e04f4.1639743512.git.fdmanana@suse.com>
 <YdM5xy656x9vi7cQ@localhost.localdomain>
In-Reply-To: <YdM5xy656x9vi7cQ@localhost.localdomain>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 3 Jan 2022 18:39:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4MrdAHWRAKG+-4m6+a1yapjhDRcMN3ovapbUd9ph9vWg@mail.gmail.com>
Message-ID: <CAL3q7H4MrdAHWRAKG+-4m6+a1yapjhDRcMN3ovapbUd9ph9vWg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix reserved space leak on log tree nodes after
 transaction abort
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 3, 2022 at 6:00 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, Dec 17, 2021 at 12:20:09PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > After the recent changes by commit c2e39305299f01 ("btrfs: clear extent
> > buffer uptodate when we fail to write it") and its followup fix that ha=
s
> > the subject "btrfs: check WRITE_ERR when trying to read an extent buffe=
r"
> > (not yet in Linus' tree), after a transaction abort we can often end up
> > not unreserving the space that was reserved for log tree extent buffers=
.
> >
> > This happens because if writeback for a log tree extent buffer failed,
> > than we have cleared the EXTENT_BUFFER_UPTODATE from the extent buffer
> > and we have also set the bit EXTENT_BUFFER_WRITE_ERR on it. Later on,
> > when trying to free the log tree with free_log_tree(), which iterates
> > over the tree, we can end up getting an -EIO error when trying to read
> > a node or leaf, since read_extent_buffer_pages() returns -EIO if an
> > extent buffer does not have EXTENT_BUFFER_UPTODATE set and has the
> > EXTENT_BUFFER_WRITE_ERR bit set. Getting that -EIO means we return
> > immediately as we can not iterate over the entire tree.
> >
> > In that case we never update the reserved space for every extent buffer
> > in the respective block group and space_info object. When this happens
> > we get the following traces when unmmounting the filesystem:
> >
> > [174957.284509] BTRFS: error (device dm-0) in cleanup_transaction:1913:=
 errno=3D-5 IO failure
> > [174957.286497] BTRFS: error (device dm-0) in free_log_tree:3420: errno=
=3D-5 IO failure
> > [174957.399379] ------------[ cut here ]------------
> > [174957.402497] WARNING: CPU: 2 PID: 3206883 at fs/btrfs/block-group.c:=
127 btrfs_put_block_group+0x77/0xb0 [btrfs]
> > [174957.407523] Modules linked in: btrfs overlay dm_zero dm_snapshot dm=
_dust loop dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_wr=
ites dm_flakey dm_mod blake2b_generic xor raid6_pq libcrc32c ppde
> > v intel_rapl_msr intel_rapl_common parport_pc bochs crct10dif_pclmul dr=
m_vram_helper ghash_clmulni_intel aesni_intel drm_ttm_helper crypto_simd pa=
rport ttm cryptd input_leds sg joydev led_class drm_kms_helper se
> > rio_raw qemu_fw_cfg pcspkr evdev button drm ip_tables x_tables autofs4 =
ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi virtio_scsi virtio_net=
 net_failover failover ata_generic ata_piix libata crc32_pclmul v
> > irtio_pci virtio_pci_legacy_dev crc32c_intel virtio_pci_modern_dev virt=
io_ring scsi_mod psmouse virtio scsi_common i2c_piix4 [last unloaded: scsi_=
debug]
> > [174957.424917] CPU: 2 PID: 3206883 Comm: umount Tainted: G        W   =
      5.16.0-rc5-btrfs-next-109 #1
> > [174957.426689] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [174957.428716] RIP: 0010:btrfs_put_block_group+0x77/0xb0 [btrfs]
> > [174957.429717] Code: 21 48 8b bd (...)
> > [174957.432867] RSP: 0018:ffffb70d41cffdd0 EFLAGS: 00010206
> > [174957.433632] RAX: 0000000000000001 RBX: ffff8b09c3848000 RCX: ffff8b=
0758edd1c8
> > [174957.434689] RDX: 0000000000000001 RSI: ffffffffc0b467e7 RDI: ffff8b=
0758edd000
> > [174957.436068] RBP: ffff8b0758edd000 R08: 0000000000000000 R09: 000000=
0000000000
> > [174957.437114] R10: 0000000000000246 R11: 0000000000000000 R12: ffff8b=
09c3848148
> > [174957.438140] R13: ffff8b09c3848198 R14: ffff8b0758edd188 R15: dead00=
0000000100
> > [174957.439317] FS:  00007f328fb82800(0000) GS:ffff8b0a2d200000(0000) k=
nlGS:0000000000000000
> > [174957.440402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [174957.441164] CR2: 00007fff13563e98 CR3: 0000000404f4e005 CR4: 000000=
0000370ee0
> > [174957.442117] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> > [174957.443076] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> > [174957.443948] Call Trace:
> > [174957.444264]  <TASK>
> > [174957.444538]  btrfs_free_block_groups+0x255/0x3c0 [btrfs]
> > [174957.445238]  close_ctree+0x301/0x357 [btrfs]
> > [174957.445803]  ? call_rcu+0x16c/0x290
> > [174957.446250]  generic_shutdown_super+0x74/0x120
> > [174957.446832]  kill_anon_super+0x14/0x30
> > [174957.447305]  btrfs_kill_super+0x12/0x20 [btrfs]
> > [174957.447890]  deactivate_locked_super+0x31/0xa0
> > [174957.448440]  cleanup_mnt+0x147/0x1c0
> > [174957.448888]  task_work_run+0x5c/0xa0
> > [174957.449336]  exit_to_user_mode_prepare+0x1e5/0x1f0
> > [174957.449934]  syscall_exit_to_user_mode+0x16/0x40
> > [174957.450512]  do_syscall_64+0x48/0xc0
> > [174957.450980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [174957.451605] RIP: 0033:0x7f328fdc4a97
> > [174957.452059] Code: 03 0c 00 f7 (...)
> > [174957.454320] RSP: 002b:00007fff13564ec8 EFLAGS: 00000246 ORIG_RAX: 0=
0000000000000a6
> > [174957.455262] RAX: 0000000000000000 RBX: 00007f328feea264 RCX: 00007f=
328fdc4a97
> > [174957.456131] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000056=
0b8ae51dd0
> > [174957.457118] RBP: 0000560b8ae51ba0 R08: 0000000000000000 R09: 00007f=
ff13563c40
> > [174957.458005] R10: 00007f328fe49fc0 R11: 0000000000000246 R12: 000000=
0000000000
> > [174957.459113] R13: 0000560b8ae51dd0 R14: 0000560b8ae51cb0 R15: 000000=
0000000000
> > [174957.460193]  </TASK>
> > [174957.460534] irq event stamp: 0
> > [174957.461003] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [174957.461947] hardirqs last disabled at (0): [<ffffffffb0e94214>] cop=
y_process+0x934/0x2040
> > [174957.463147] softirqs last  enabled at (0): [<ffffffffb0e94214>] cop=
y_process+0x934/0x2040
> > [174957.465116] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [174957.466323] ---[ end trace bc7ee0c490bce3af ]---
> > [174957.467282] ------------[ cut here ]------------
> > [174957.468184] WARNING: CPU: 2 PID: 3206883 at fs/btrfs/block-group.c:=
3976 btrfs_free_block_groups+0x330/0x3c0 [btrfs]
> > [174957.470066] Modules linked in: btrfs overlay dm_zero dm_snapshot dm=
_dust loop dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_wr=
ites dm_flakey dm_mod blake2b_generic xor raid6_pq libcrc32c ppdev intel_ra=
pl_msr intel_rapl_common parport_pc bochs crct10dif_pclmul drm_vram_helper =
ghash_clmulni_intel aesni_intel drm_ttm_helper crypto_simd parport ttm cryp=
td input_leds sg joydev led_class drm_kms_helper serio_raw qemu_fw_cfg pcsp=
kr evdev button drm ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mb=
cache jbd2 sd_mod t10_pi virtio_scsi virtio_net net_failover failover ata_g=
eneric ata_piix libata crc32_pclmul virtio_pci virtio_pci_legacy_dev crc32c=
_intel virtio_pci_modern_dev virtio_ring scsi_mod psmouse virtio scsi_commo=
n i2c_piix4 [last unloaded: scsi_debug]
> > [174957.483137] CPU: 2 PID: 3206883 Comm: umount Tainted: G        W   =
      5.16.0-rc5-btrfs-next-109 #1
> > [174957.484691] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [174957.486853] RIP: 0010:btrfs_free_block_groups+0x330/0x3c0 [btrfs]
> > [174957.488050] Code: 00 00 00 ad de (...)
> > [174957.491479] RSP: 0018:ffffb70d41cffde0 EFLAGS: 00010206
> > [174957.492520] RAX: ffff8b08d79310b0 RBX: ffff8b09c3848000 RCX: 000000=
0000000000
> > [174957.493868] RDX: 0000000000000001 RSI: fffff443055ee600 RDI: ffffff=
ffb1131846
> > [174957.495183] RBP: ffff8b08d79310b0 R08: 0000000000000000 R09: 000000=
0000000000
> > [174957.496580] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8b=
08d7931000
> > [174957.498027] R13: ffff8b09c38492b0 R14: dead000000000122 R15: dead00=
0000000100
> > [174957.499438] FS:  00007f328fb82800(0000) GS:ffff8b0a2d200000(0000) k=
nlGS:0000000000000000
> > [174957.500990] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [174957.502117] CR2: 00007fff13563e98 CR3: 0000000404f4e005 CR4: 000000=
0000370ee0
> > [174957.503513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> > [174957.504864] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> > [174957.506167] Call Trace:
> > [174957.506654]  <TASK>
> > [174957.507047]  close_ctree+0x301/0x357 [btrfs]
> > [174957.507867]  ? call_rcu+0x16c/0x290
> > [174957.508567]  generic_shutdown_super+0x74/0x120
> > [174957.509447]  kill_anon_super+0x14/0x30
> > [174957.510194]  btrfs_kill_super+0x12/0x20 [btrfs]
> > [174957.511123]  deactivate_locked_super+0x31/0xa0
> > [174957.511976]  cleanup_mnt+0x147/0x1c0
> > [174957.512610]  task_work_run+0x5c/0xa0
> > [174957.513309]  exit_to_user_mode_prepare+0x1e5/0x1f0
> > [174957.514231]  syscall_exit_to_user_mode+0x16/0x40
> > [174957.515069]  do_syscall_64+0x48/0xc0
> > [174957.515718]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [174957.516688] RIP: 0033:0x7f328fdc4a97
> > [174957.517413] Code: 03 0c 00 f7 d8 (...)
> > [174957.521052] RSP: 002b:00007fff13564ec8 EFLAGS: 00000246 ORIG_RAX: 0=
0000000000000a6
> > [174957.522514] RAX: 0000000000000000 RBX: 00007f328feea264 RCX: 00007f=
328fdc4a97
> > [174957.523950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000056=
0b8ae51dd0
> > [174957.525375] RBP: 0000560b8ae51ba0 R08: 0000000000000000 R09: 00007f=
ff13563c40
> > [174957.526763] R10: 00007f328fe49fc0 R11: 0000000000000246 R12: 000000=
0000000000
> > [174957.528058] R13: 0000560b8ae51dd0 R14: 0000560b8ae51cb0 R15: 000000=
0000000000
> > [174957.529404]  </TASK>
> > [174957.529843] irq event stamp: 0
> > [174957.530256] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [174957.531061] hardirqs last disabled at (0): [<ffffffffb0e94214>] cop=
y_process+0x934/0x2040
> > [174957.532075] softirqs last  enabled at (0): [<ffffffffb0e94214>] cop=
y_process+0x934/0x2040
> > [174957.533083] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [174957.533865] ---[ end trace bc7ee0c490bce3b0 ]---
> > [174957.534452] BTRFS info (device dm-0): space_info 4 has 1070841856 f=
ree, is not full
> > [174957.535404] BTRFS info (device dm-0): space_info total=3D1073741824=
, used=3D2785280, pinned=3D0, reserved=3D49152, may_use=3D0, readonly=3D655=
36 zone_unusable=3D0
> > [174957.537029] BTRFS info (device dm-0): global_block_rsv: size 0 rese=
rved 0
> > [174957.537859] BTRFS info (device dm-0): trans_block_rsv: size 0 reser=
ved 0
> > [174957.538697] BTRFS info (device dm-0): chunk_block_rsv: size 0 reser=
ved 0
> > [174957.539552] BTRFS info (device dm-0): delayed_block_rsv: size 0 res=
erved 0
> > [174957.540403] BTRFS info (device dm-0): delayed_refs_rsv: size 0 rese=
rved 0
> >
> > This is often triggered with test cases generic/475 and generic/648 fro=
m
> > fstests, which makes the tests fail.
> >
> > So fix this by iterating over the io tree that contains the ranges of a=
ll
> > log tree metadata extents and call unaccount_log_buffer() for the range=
 of
> > each metadata extent. This is only called during the transaction abort
> > path if we failed to walk over the entire log tree.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Errr... You haven't seen my follow-up reply.
This is incomplete and only makes the problem a bit less likely to happen.

I have a working version now, I'll likely send it tomorrow unless
further testing reveals any problem.

Thanks

>
> Thanks,
>
> Josef
