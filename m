Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389E846940E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhLFKqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 05:46:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34702 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhLFKqF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 05:46:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 630F6B80EE6
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 10:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45D6C341C2;
        Mon,  6 Dec 2021 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638787354;
        bh=HrbaPRijdFhtf6uzXZzUNbAu6qP9uooZmfDMr0h3M+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCkuOeHWqSz4tYQQaQI3r7RSZiy1b5Q7lVJxXqoAQHGDm6/8cBrHrLOIUZrPr1ZGz
         J3qU4scAu6a33ks0cvvn8lwavZK10Z0Hzgfw9Al4hXFB9gbS1LSKyHJxNFMy3DGCDi
         hS4sageuGpOwuHy+30M7EV3WFDqG1bWOxqSXEh679Nlj7rf9jtMLr3pPI3vWOAmmE/
         5pk8IGw4aAbfBsx5xS9VOUt5ExXgVBcBtHvZLLjUWNfS9QiuTvV1z4NhRkhr6irdvB
         /E962uVOAUlzQNDOy3pPemaTIn5et95aOQq2FsYuccn/Vf6/aQx8h/x/e/XNKDygTx
         NqArWTrOA8KnA==
Date:   Mon, 6 Dec 2021 10:42:30 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Free space tree space reservation fixes
Message-ID: <Ya3pFhEcbIQi2bB+@debian9.Home>
References: <cover.1638477127.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638477127.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 03:34:30PM -0500, Josef Bacik wrote:
> v1->v2:
> - Updated the changelog for "btrfs: reserve extra space for free space tree" to
>   make it clear why we're doubling the space reservation per Nikolay's request.
> 
> --- Original email ---
> Hello,
> 
> Filipe reported a problem where he was getting an ENOSPC abort when running
> delayed refs for generic/619.  This is because of two reasons, first generic/619
> creates a very small file system, and our global block rsv calculation doesn't
> take into account the size of the free space tree.  Thus we could get into a
> situation where the global block rsv was not enough to handle the overflow.
> 
> The second is because we simply do not reserve space for the free space tree
> modifications.  Fix this by making sure any free space tree root has their block
> rsv set to the delayed refs rsv, and then make sure if we have the free space
> tree enabled we're reserving extra space for those operations.
> 
> With these patches the problem Filipe was hitting went away.  Thanks,

It went, but it often brings some leaks.
For example, generic/648 triggers those links often:

[267436.763282] BTRFS info (device loop0): forced readonly
[267436.763934] BTRFS warning (device loop0): Skipping commit of aborted transaction.
[267436.764874] BTRFS: error (device loop0) in cleanup_transaction:1913: errno=-5 IO failure
[267438.978412] ------------[ cut here ]------------
[267438.979610] WARNING: CPU: 3 PID: 44901 at fs/btrfs/block-group.c:127 btrfs_put_block_group+0x77/0xb0 [btrfs]
[267438.982274] Modules linked in: overlay dm_zero dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_dust dm_flakey dm_mod loop btrfs blake2b_generic xor raid6_pq libcrc32c inte
l_rapl_msr intel_rapl_common bochs drm_vram_helper crct10dif_pclmul ghash_clmulni_intel drm_ttm_helper aesni_intel ttm crypto_simd ppdev cryptd drm_kms_helper sg input_leds parport_pc led_class joydev parport se
rio_raw evdev button pcspkr qemu_fw_cfg drm ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi virtio_net net_failover failover virtio_scsi ata_generic ata_piix crc32_pclmul libata v
irtio_pci crc32c_intel virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring virtio psmouse scsi_mod i2c_piix4 scsi_common [last unloaded: scsi_debug]
[267438.994384] CPU: 3 PID: 44901 Comm: umount Not tainted 5.16.0-rc3-btrfs-next-107 #1
[267438.995545] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[267438.997171] RIP: 0010:btrfs_put_block_group+0x77/0xb0 [btrfs]
[267438.998031] Code: 21 48 8b bd 80 01 00 00 e8 36 a8 03 e3 48 8b bd 08 04 00 00 e8 2a a8 03 e3 48 89 ef 5d e9 21 a8 03 e3 0f 0b eb db 0f 0b eb b1 <0f> 0b eb b4 0f 0b 48 8b 45 00 48 89 ee 48 8d b8 f0 17 00 00 e
8 b0
[267439.000593] RSP: 0018:ffffb06981af7dd0 EFLAGS: 00010206
[267439.001613] RAX: 0000000000000001 RBX: ffff9caa8c754000 RCX: ffff9caa5db739c8
[267439.002523] RDX: 0000000000000001 RSI: ffffffffc0afd6c7 RDI: ffff9caa5db73800
[267439.003455] RBP: ffff9caa5db73800 R08: 0000000000000000 R09: 0000000000000000
[267439.004359] R10: 0000000000000246 R11: 0000000000000000 R12: ffff9caa8c754148
[267439.005581] R13: ffff9caa8c754198 R14: ffff9caa5db73988 R15: dead000000000100
[267439.006497] FS:  00007fa77deb4800(0000) GS:ffff9cad6d400000(0000) knlGS:0000000000000000
[267439.007603] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[267439.008341] CR2: 00007fff383e4cf8 CR3: 00000002ede58001 CR4: 0000000000370ee0
[267439.009321] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[267439.010658] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[267439.011983] Call Trace:
[267439.012459]  <TASK>
[267439.012874]  btrfs_free_block_groups+0x255/0x3c0 [btrfs]
[267439.013941]  close_ctree+0x301/0x357 [btrfs]
[267439.014791]  generic_shutdown_super+0x74/0x120
[267439.015636]  kill_anon_super+0x14/0x30
[267439.016349]  btrfs_kill_super+0x12/0x20 [btrfs]
[267439.017244]  deactivate_locked_super+0x31/0xa0
[267439.018085]  cleanup_mnt+0x147/0x1c0
[267439.018767]  task_work_run+0x5c/0xa0
[267439.019448]  exit_to_user_mode_prepare+0x1e5/0x1f0
[267439.020320]  syscall_exit_to_user_mode+0x16/0x40
[267439.020911]  do_syscall_64+0x48/0xc0
[267439.021466]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[267439.022127] RIP: 0033:0x7fa77e0f6a97
[267439.022601] Code: 03 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 a1 03 0c 00 f7 d8 64 89 0
2 b8
[267439.024955] RSP: 002b:00007fff383e5d28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[267439.025954] RAX: 0000000000000000 RBX: 00007fa77e21c264 RCX: 00007fa77e0f6a97
[267439.026866] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055e31788edd0
[267439.027784] RBP: 000055e31788eba0 R08: 0000000000000000 R09: 00007fff383e4aa0
[267439.028702] R10: 00007fa77e17bfc0 R11: 0000000000000246 R12: 0000000000000000
[267439.029729] R13: 000055e31788edd0 R14: 000055e31788ecb0 R15: 0000000000000000
[267439.030798]  </TASK>
[267439.031130] irq event stamp: 0
[267439.031559] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[267439.032450] hardirqs last disabled at (0): [<ffffffffa3894214>] copy_process+0x934/0x2040
[267439.033540] softirqs last  enabled at (0): [<ffffffffa3894214>] copy_process+0x934/0x2040
[267439.034578] softirqs last disabled at (0): [<0000000000000000>] 0x0
[267439.035380] ---[ end trace 63cff29aa6aacf3d ]---
[267439.036050] ------------[ cut here ]------------
[267439.036653] WARNING: CPU: 3 PID: 44901 at fs/btrfs/block-group.c:3976 btrfs_free_block_groups+0x330/0x3c0 [btrfs]
[267439.038057] Modules linked in: overlay dm_zero dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_dust dm_flakey dm_mod loop btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common bochs drm_vram_helper crct10di>
[267439.046505] CPU: 3 PID: 44901 Comm: umount Tainted: G        W         5.16.0-rc3-btrfs-next-107 #1
[267439.047636] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[267439.049099] RIP: 0010:btrfs_free_block_groups+0x330/0x3c0 [btrfs]
[267439.049930] Code: 00 00 00 ad de 49 be 22 01 00 00 00 00 ad de e8 76 f0 7c e3 48 89 df e8 4e 85 ff ff 48 8b 83 b0 12 00 00 49 39 c5 75 51 eb 7d <0f> 0b 31 c9 31 d2 4c 89 e6 48 89 df e8 8f 75 ff ff 48 83 7d 40 00
[267439.052257] RSP: 0018:ffffb06981af7de0 EFLAGS: 00010206
[267439.052933] RAX: ffff9cacc606ccb0 RBX: ffff9caa8c754000 RCX: 0000000000000000
[267439.053935] RDX: 0000000000000001 RSI: ffffffffa3b32cd7 RDI: 00000000ffffffff
[267439.054882] RBP: ffff9cacc606ccb0 R08: 0000000000000000 R09: 0000000000000000
[267439.055778] R10: 0000000000000246 R11: 0000000000000001 R12: ffff9cacc606cc00
[267439.056686] R13: ffff9caa8c7552b0 R14: dead000000000122 R15: dead000000000100
[267439.057628] FS:  00007fa77deb4800(0000) GS:ffff9cad6d400000(0000) knlGS:0000000000000000
[267439.058648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[267439.059391] CR2: 00007fff383e4cf8 CR3: 00000002ede58001 CR4: 0000000000370ee0
[267439.060313] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[267439.061287] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[267439.062672] Call Trace:
[267439.063161]  <TASK>
[267439.063624]  close_ctree+0x301/0x357 [btrfs]
[267439.064953]  generic_shutdown_super+0x74/0x120
[267439.065842]  kill_anon_super+0x14/0x30
[267439.066581]  btrfs_kill_super+0x12/0x20 [btrfs]
[267439.067468]  deactivate_locked_super+0x31/0xa0
[267439.068311]  cleanup_mnt+0x147/0x1c0
[267439.069004]  task_work_run+0x5c/0xa0
[267439.069711]  exit_to_user_mode_prepare+0x1e5/0x1f0
[267439.070627]  syscall_exit_to_user_mode+0x16/0x40
[267439.071500]  do_syscall_64+0x48/0xc0
[267439.072179]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[267439.073135] RIP: 0033:0x7fa77e0f6a97
[267439.073837] Code: 03 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 a1 03 0c 00 f7 d8 64 89 02 b8
[267439.077297] RSP: 002b:00007fff383e5d28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[267439.078704] RAX: 0000000000000000 RBX: 00007fa77e21c264 RCX: 00007fa77e0f6a97
[267439.080030] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055e31788edd0
[267439.081379] RBP: 000055e31788eba0 R08: 0000000000000000 R09: 00007fff383e4aa0
[267439.082710] R10: 00007fa77e17bfc0 R11: 0000000000000246 R12: 0000000000000000
[267439.084039] R13: 000055e31788edd0 R14: 000055e31788ecb0 R15: 0000000000000000
[267439.085386]  </TASK>
[267439.085814] irq event stamp: 0
[267439.086398] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[267439.087326] hardirqs last disabled at (0): [<ffffffffa3894214>] copy_process+0x934/0x2040
[267439.088364] softirqs last  enabled at (0): [<ffffffffa3894214>] copy_process+0x934/0x2040
[267439.089415] softirqs last disabled at (0): [<0000000000000000>] 0x0
[267439.090215] ---[ end trace 63cff29aa6aacf3e ]---
[267439.090791] BTRFS info (device dm-0): space_info 4 has 1072562176 free, is not full
[267439.091813] BTRFS info (device dm-0): space_info total=1073741824, used=1064960, pinned=0, reserved=49152, may_use=0, readonly=65536 zone_unusable=0
[267439.093909] BTRFS info (device dm-0): global_block_rsv: size 0 reserved 0
[267439.095078] BTRFS info (device dm-0): trans_block_rsv: size 0 reserved 0
[267439.096229] BTRFS info (device dm-0): chunk_block_rsv: size 0 reserved 0
[267439.097342] BTRFS info (device dm-0): delayed_block_rsv: size 0 reserved 0
[267439.098499] BTRFS info (device dm-0): delayed_refs_rsv: size 0 reserved 0
[267439.211991] BTRFS info (device dm-0): flagging fs with big metadata feature

It nevers happens without this patchset applied.
With it applied, it happens very often (but not always).

Thanks.

> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: include the free space tree in the global rsv minimum
>     calculation
>   btrfs: reserve extra space for the free space tree
> 
>  fs/btrfs/block-rsv.c   | 31 ++++++++++++++++++-------------
>  fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> -- 
> 2.26.3
> 
