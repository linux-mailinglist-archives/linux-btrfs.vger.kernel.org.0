Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4934F66C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 03:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhCaB6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 21:58:30 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43758 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaB63 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 21:58:29 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 25AE09F3B32; Tue, 30 Mar 2021 21:58:27 -0400 (EDT)
Date:   Tue, 30 Mar 2021 21:58:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Markus Schaaf <markuschaaf@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Any ideas what this warnings are about?
Message-ID: <20210331015827.GV32440@hungrycats.org>
References: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 30, 2021 at 08:05:56PM +0200, Markus Schaaf wrote:
> Hi all,
> 
> on one of my machines I'm seeing these warnings a lot lately:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 314 at fs/fs-writeback.c:2472 __writeback_inodes_sb_nr+0xb8/0xd0
> Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20poly1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_64 ip6_udp_tunnel udp_tunnel libcurve25519_generic libchacha libblake2s_generic psmouse joydev mousedev pcspkr i2c_i801 i2c_smbus lpc_ich iptable_filter xt_nat xt_tcpudp intel_agp intel_gtt iptable_nat nf_nat qemu_fw_cfg nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mac_hid vfat fat auth_rpcgss sunrpc fuse ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted tpm usbhid dm_mod virtio_gpu virtio_dma_buf drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm virtio_scsi virtio_balloon virtio_net virtio_console net_failover agpgart failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper serio_raw sr_mod cdrom xhci_pci virtio_pci virtio_rng rng_core
> CPU: 1 PID: 314 Comm: btrfs-transacti Tainted: G        W         5.10.26-1-MANJARO #1
> Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
> RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
> Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf e8 df 8c 75 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> RSP: 0018:ffffb1f5448f7d98 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: 0000000000004b45 RDI: ffff9611b7220000
> RBP: ffff9611b64d3958 R08: ffff961184efc800 R09: 0000000000000140
> R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff9611838f7c00
> R13: ffff961185aa5000 R14: ffff961185aa5460 R15: 0000000000011a0f
> FS:  0000000000000000(0000) GS:ffff9611fad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f654bc76b58 CR3: 0000000002c60000 CR4: 00000000003506e0
> Call Trace:
>  btrfs_commit_transaction+0x448/0xbc0 [btrfs]
>  ? start_transaction+0xcc/0x5b0 [btrfs]
>  transaction_kthread+0x143/0x170 [btrfs]
>  ? btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
>  kthread+0x133/0x150
>  ? __kthread_bind_mask+0x60/0x60
>  ret_from_fork+0x22/0x30
> ---[ end trace 3cefecf5d9d20b50 ]---
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 758 at fs/fs-writeback.c:2472 __writeback_inodes_sb_nr+0xb8/0xd0

That bug was introduced in 4.15 as part of a fix for a deadlock bug.
It's still there today.  Not very high on anyone's TODO list as it's
mostly harmless--btrfs can't be umounted during a transaction as the
umount itself uses a transaction.  The warning doesn't come from btrfs
code, so we can't just turn it off.

> Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20poly1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_>
> CPU: 0 PID: 758 Comm: journal-offline Tainted: G        W         5.10.26-1-MANJARO #1
> Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
> RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
> Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf e8 df 8c 75 00 66>
> RSP: 0018:ffffb1f540d7fd40 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: 0000000000004be5 RDI: ffff9611b7220000
> RBP: ffff961182209208 R08: ffff961184efc800 R09: 0000000000000140
> R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff961183891200
> R13: ffff961185aa5000 R14: ffff961185aa5460 R15: ffff9611b65d5e10
> FS:  00007f654b80e640(0000) GS:ffff9611fac00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f654cf39010 CR3: 0000000003884000 CR4: 00000000003506f0
> Call Trace:
>  btrfs_commit_transaction+0x448/0xbc0 [btrfs]
>  ? btrfs_wait_ordered_range+0x1b8/0x210 [btrfs]
>  ? btrfs_sync_file+0x2b8/0x4e0 [btrfs]
>  btrfs_sync_file+0x343/0x4e0 [btrfs]
>  __x64_sys_fsync+0x34/0x60
>  do_syscall_64+0x33/0x40

Normally you need to mount -o flushoncommit to trigger this warning.
Maybe sync is triggering it too?

>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f654cf26deb
> Code: 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 33 f7 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89>
> RSP: 002b:00007f654b80db10 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> RAX: ffffffffffffffda RBX: 00005636c966b410 RCX: 00007f654cf26deb
> RDX: 0000000000000002 RSI: 00007f654d169d43 RDI: 0000000000000016
> RBP: 00007f654d16c6f0 R08: 0000000000000000 R09: 00007f654b80e640
> R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000002
> R13: 00007ffc8bd7461f R14: 0000000000000000 R15: 00007f654b80e640
> ---[ end trace 3cefecf5d9d20b84 ]---
> 
> This is a KVM guest on an AMD host. A similar machine on an Intel host doesn't show this.
> There is a single BTRFS filesystem on LUKS. It has been created like:
> 
> 	mkfs.btrfs --csum blake2 -d single -m single /dev/mapper/rootfs
> 
> I've tested Manjaro's 5.11.10 kernel too. No change. btrfs-check (5.11.1) shows nothing.
> I've even recreated the filesystem. No change. Maybe the machine without warnings uses
> the default hash. How can I find out?
> 
> Thanks!
> Markus
