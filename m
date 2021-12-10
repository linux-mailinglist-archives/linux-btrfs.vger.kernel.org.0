Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B14708F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhLJSk7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 10 Dec 2021 13:40:59 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:40952 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242061AbhLJSk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 13:40:56 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 90E0CCF709; Fri, 10 Dec 2021 13:37:19 -0500 (EST)
Date:   Fri, 10 Dec 2021 13:37:19 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: BUG_ON in relocation.c:4037 (seen on 5.14.18, 5.10.79) (not
 really a bug after all)
Message-ID: <20211210183719.GQ17148@hungrycats.org>
References: <20211120161414.GD17148@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20211120161414.GD17148@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 20, 2021 at 11:14:14AM -0500, Zygo Blaxell wrote:
> I've been hitting this BUG_ON a few times recently on kernel 5.14.18 and
> kernel 5.10.79.  The filesystem is 98% full, and maintenance balances
> often fail with ENOSPC due to free space fragmentation.  Only two hosts
> are hitting this BUG_ON in my fleet, and they both have filesystems with
> similar fullness and fragmentation (and also half the same data contents,
> which probably contributes to their similar structural properties).
> 
> The filesystem itself seems healthy.

It turns out that isn't true.  There were references to extents from
snapshots that no longer exist, and a few extents (from files dated 2018
with contemporary transids) are referenced by inodes that are symlinks
(oops!).  Some block groups fail with ENOENT (because the referencing
inode is a symlink and can't have a data extent reference), others fail
because the root referencing the data extent doesn't exist (buf->start
is NULL and the referencing root is a deleted snapshot).

These references can be deleted with the 'rm' or 'btrfs fi defrag' or
'btrfs sub del' commands, so they don't seem to be bothering btrfs
very much.  There are apparently _thousands_ of these sprinkled over
the filesystem, and balance stops with BUG_ON as soon as any of them
is encountered.

TL;DR the kernel is not really broken here, balance is just responding
to invalid metadata by crashing.

I have no idea where the bad metadata came from.  Affected files have
extents with vintages covering mid-2018 to November 2021.  They could
have been put there just as easily by kernel 4.14 or 5.14.  I only
have one filesystem behaving this way.

> I attempted to balance this
> particular block group with 5.10.79 and I got ENOSPC instead of the
> BUG_ON, but a day later 5.10 later crashed with the same BUG_ON (different
> line in the sources) on a different block group.
> 
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS debug (device dm-34): Drop subvolume 18446744073709551608
> 	[Tue Nov 16 23:09:47 2021] BTRFS info (device dm-34): found 11051 extents
> 	[Tue Nov 16 23:11:01 2021] ------------[ cut here ]------------
> 	[Tue Nov 16 23:11:01 2021] kernel BUG at fs/btrfs/relocation.c:4307!
> 	[Tue Nov 16 23:11:01 2021] invalid opcode: 0000 [#1] SMP NOPTI
> 	[Tue Nov 16 23:11:01 2021] CPU: 4 PID: 548 Comm: btrfs-balance-l Tainted: G        W         5.14.18-zb64-260c4e85dcba+ #1 f242a5476f7f35fa14c415ee82e5b20e0d28c8e8
> 	[Tue Nov 16 23:11:01 2021] Hardware name: ASUS System Product Name/PRIME B550-PLUS, BIOS 2423 08/09/2021
> 	[Tue Nov 16 23:11:01 2021] RIP: 0010:btrfs_reloc_cow_block+0x280/0x290
> 	[Tue Nov 16 23:11:01 2021] Code: 8b 4d a0 48 8b 45 c8 48 89 79 70 49 89 42 30 49 89 72 38 48 89 3e 41 80 4a 71 20 e9 e5 fe ff ff 49 3b 52 20 0f 84 8f fe ff ff <0f> 0b c7 45 d0 00 00 00 00 e9 6f fe ff ff 66 90 0f 1f 44 00 00 55
> 	[Tue Nov 16 23:11:01 2021] RSP: 0018:ffffa7e8f1a37840 EFLAGS: 00010287
> 	[Tue Nov 16 23:11:01 2021] RAX: 0000000000000001 RBX: ffff93336f9b79a8 RCX: fffffffffffffff8
> 	[Tue Nov 16 23:11:01 2021] RDX: 00004f795eae8000 RSI: 0000000000000001 RDI: ffff9334d0bac478
> 	[Tue Nov 16 23:11:01 2021] RBP: ffffa7e8f1a378a0 R08: ffff9334d0bac478 R09: 0000000000000000
> 	[Tue Nov 16 23:11:01 2021] R10: ffff933a95e29680 R11: 0000000000000000 R12: ffff934de5dd1000
> 	[Tue Nov 16 23:11:01 2021] R13: ffff9341866fb800 R14: ffff93336f9b7d38 R15: 0000000000000001
> 	[Tue Nov 16 23:11:01 2021] FS:  00007eff68938740(0000) GS:ffff935168000000(0000) knlGS:0000000000000000
> 	[Tue Nov 16 23:11:01 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[Tue Nov 16 23:11:01 2021] CR2: 000055a1623e6880 CR3: 0000001ae5df4000 CR4: 0000000000350ee0
> 	[Tue Nov 16 23:11:01 2021] Call Trace:
> 	[Tue Nov 16 23:11:01 2021]  ? update_ref_for_cow+0x2a6/0x330
> 	[Tue Nov 16 23:11:01 2021]  __btrfs_cow_block+0x3ad/0x5c0
> 	[Tue Nov 16 23:11:01 2021]  btrfs_cow_block+0xfc/0x200
> 	[Tue Nov 16 23:11:01 2021]  btrfs_search_slot+0x584/0x870
> 	[Tue Nov 16 23:11:01 2021]  do_relocation+0x123/0x680
> 	[Tue Nov 16 23:11:01 2021]  ? btrfs_block_rsv_refill+0x48/0xa0
> 	[Tue Nov 16 23:11:01 2021]  relocate_tree_blocks+0x2bf/0x670
> 	[Tue Nov 16 23:11:01 2021]  ? add_data_references+0x399/0x4a0
> 	[Tue Nov 16 23:11:01 2021]  relocate_block_group+0x1fe/0x580
> 	[Tue Nov 16 23:11:01 2021]  btrfs_relocate_block_group+0x187/0x340
> 	[Tue Nov 16 23:11:01 2021]  btrfs_relocate_chunk+0x3d/0x120
> 	[Tue Nov 16 23:11:01 2021]  btrfs_balance+0x7d3/0xf60
> 	[Tue Nov 16 23:11:01 2021]  btrfs_ioctl_balance+0x33c/0x410
> 	[Tue Nov 16 23:11:01 2021]  btrfs_ioctl+0x383/0x2dc0
> 	[Tue Nov 16 23:11:01 2021]  ? rcu_read_lock_sched_held+0x16/0x80
> 	[Tue Nov 16 23:11:01 2021]  ? syscall_exit_to_user_mode+0x4c/0x60
> 	[Tue Nov 16 23:11:01 2021]  ? do_syscall_64+0x69/0xc0
> 	[Tue Nov 16 23:11:01 2021]  __x64_sys_ioctl+0x91/0xc0
> 	[Tue Nov 16 23:11:01 2021]  ? __x64_sys_ioctl+0x91/0xc0
> 	[Tue Nov 16 23:11:01 2021]  do_syscall_64+0x5c/0xc0
> 	[Tue Nov 16 23:11:01 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 	[Tue Nov 16 23:11:01 2021] RIP: 0033:0x7eff68a2f957
> 	[Tue Nov 16 23:11:01 2021] Code: 3c 1c 48 f7 d8 4c 39 e0 77 b9 e8 24 ff ff ff 85 c0 78 be 4c 89 e0 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 94 0c 00 f7 d8 64 89 01 48
> 	[Tue Nov 16 23:11:01 2021] RSP: 002b:00007ffc4b7dec88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[Tue Nov 16 23:11:01 2021] RAX: ffffffffffffffda RBX: 00000000c4009420 RCX: 00007eff68a2f957
> 	[Tue Nov 16 23:11:01 2021] RDX: 00007ffc4b7decef RSI: 00000000c4009420 RDI: 0000000000000003
> 	[Tue Nov 16 23:11:01 2021] RBP: 0000000000000400 R08: 0000000000000000 R09: 00007ffc4b7ded40
> 	[Tue Nov 16 23:11:01 2021] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000003
> 	[Tue Nov 16 23:11:01 2021] R13: 0000000000000001 R14: 0000000001a42c30 R15: 00000000019a1cb0
> 	[Tue Nov 16 23:11:01 2021] Modules linked in: uinput rpcsec_gss_krb5 rfcomm nfsv3 nf_conntrack_netlink cmac algif_hash algif_skcipher af_alg bnep cpufreq_userspace cpufreq_powersave cpufreq_conservative binfmt_misc nfsd auth_rpcgss nfs_acl nfs lockd grace fscache netfs sunrpc nbd ip_tables ipt_REJECT nf_reject_ipv4 xt_MASQUERADE xt_state xt_conntrack nft_chain_nat xt_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp nft_counter xt_LOG nft_compat x_tables nf_tables nfnetlink tcp_cubic sch_fq_codel nct6775 hwmon_vid jc42 netconsole dummy parport_pc ppdev lp parport intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_amd snd_hda_codec snd_hda_core snd_hwdep kvm snd_pcm_oss eeepc_wmi pktcdvd asus_wmi snd_mixer_oss irqbypass battery amdgpu joydev rapl snd_pcm sparse_keymap wmi_bmof input_leds btusb ccp snd_timer btrtl btbcm sp5100_tco k10temp
> 	[Tue Nov 16 23:11:01 2021]  btintel snd iommu_v2 soundcore gpu_sched bluetooth drm_ttm_helper ecdh_generic sg rfkill ecc acpi_cpufreq evdev dm_crypt trusted asn1_encoder tee af_packet efivars raid10 raid0 multipath linear dm_mirror dm_region_hash dm_log hid_generic uas dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bufio dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx crct10dif_pclmul ghash_clmulni_intel raid1 sr_mod md_mod aesni_intel cdrom r8169 i2c_piix4 realtek xhci_pci xhci_pci_renesas xhci_hcd wmi rtc_cmos gpio_amdpt
> 	[Tue Nov 16 23:11:01 2021] ---[ end trace 0972673383e1b609 ]---
> 	[Tue Nov 16 23:11:01 2021] RIP: 0010:btrfs_reloc_cow_block+0x280/0x290
> 	[Tue Nov 16 23:11:01 2021] Code: 8b 4d a0 48 8b 45 c8 48 89 79 70 49 89 42 30 49 89 72 38 48 89 3e 41 80 4a 71 20 e9 e5 fe ff ff 49 3b 52 20 0f 84 8f fe ff ff <0f> 0b c7 45 d0 00 00 00 00 e9 6f fe ff ff 66 90 0f 1f 44 00 00 55
> 	[Tue Nov 16 23:11:01 2021] RSP: 0018:ffffa7e8f1a37840 EFLAGS: 00010287
> 	[Tue Nov 16 23:11:01 2021] RAX: 0000000000000001 RBX: ffff93336f9b79a8 RCX: fffffffffffffff8
> 	[Tue Nov 16 23:11:01 2021] RDX: 00004f795eae8000 RSI: 0000000000000001 RDI: ffff9334d0bac478
> 	[Tue Nov 16 23:11:01 2021] RBP: ffffa7e8f1a378a0 R08: ffff9334d0bac478 R09: 0000000000000000
> 	[Tue Nov 16 23:11:01 2021] R10: ffff933a95e29680 R11: 0000000000000000 R12: ffff934de5dd1000
> 	[Tue Nov 16 23:11:01 2021] R13: ffff9341866fb800 R14: ffff93336f9b7d38 R15: 0000000000000001
> 	[Tue Nov 16 23:11:01 2021] FS:  00007eff68938740(0000) GS:ffff935168000000(0000) knlGS:0000000000000000
> 	[Tue Nov 16 23:11:01 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[Tue Nov 16 23:11:01 2021] CR2: 000055a1623e6880 CR3: 0000001ae5df4000 CR4: 0000000000350ee0
> 
> 	(gdb) l *(btrfs_reloc_cow_block+0x280)
> 	0xffffffff81619ad0 is in btrfs_reloc_cow_block (fs/btrfs/relocation.c:4307).
> 	4302            if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID &&
> 	4303                rc->create_reloc_tree) {
> 	4304                    WARN_ON(!first_cow && level == 0);
> 	4305
> 	4306                    node = rc->backref_cache.path[level];
> 	4307                    BUG_ON(node->bytenr != buf->start &&
> 	4308                           node->new_bytenr != buf->start);
> 	4309
> 	4310                    btrfs_backref_drop_node_buffer(node);
> 	4311                    atomic_inc(&cow->refs);
