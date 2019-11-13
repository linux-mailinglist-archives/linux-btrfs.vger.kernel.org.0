Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6DFB2A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 15:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKMObm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 09:31:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:51812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfKMObl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 09:31:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9793AD69;
        Wed, 13 Nov 2019 14:31:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 922B9DA7E8; Wed, 13 Nov 2019 15:31:43 +0100 (CET)
Date:   Wed, 13 Nov 2019 15:31:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH 1/2] btrfs: block-group: Fix two rebase errors where
 assignment for cache is missing
Message-ID: <20191113143143.GA3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191105013535.14239-1-wqu@suse.com>
 <20191105013535.14239-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105013535.14239-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 05, 2019 at 09:35:34AM +0800, Qu Wenruo wrote:
> Without proper cache->flags, btrfs space info will be screwed up and
> report error at mount time.
> 
> And without proper cache->used, commit transaction will report -EEXIST
> when running delayed refs.
> 
> Please fold this into the original patch "btrfs: block-group: Refactor btrfs_read_block_groups()".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/block-group.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b5eededaa750..c2bd85d29070 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1713,6 +1713,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  	}
>  	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
>  			   sizeof(bgi));
> +	cache->used = btrfs_stack_block_group_used(&bgi);
> +	cache->flags = btrfs_stack_block_group_flags(&bgi);
>  	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
>  	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
>  			btrfs_err(info,

Is it possible that there's another missing bit that got lost during my
rebase? VM testing is fine but I get a reproducible crash on a physical
machine with the following stacktrace:

 113 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 114                              u64 total_bytes, u64 bytes_used,
 115                              u64 bytes_readonly,
 116                              struct btrfs_space_info **space_info)
 117 {
 118         struct btrfs_space_info *found;
 119         int factor;
 120
 121         factor = btrfs_bg_type_to_factor(flags);
 122
 123         found = btrfs_find_space_info(info, flags);
 124         ASSERT(found);

[ 1570.447326] assertion failed: found, in fs/btrfs/space-info.c:124
[ 1570.453862] ------------[ cut here ]------------
[ 1570.458629] kernel BUG at fs/btrfs/ctree.h:3117!
[ 1570.463445] invalid opcode: 0000 [#1] PREEMPT SMP
[ 1570.468310] CPU: 3 PID: 2189 Comm: mount Not tainted 5.4.0-rc7-1.ge195904-vanilla+ #509
[ 1570.468312] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
[ 1570.468388] RIP: 0010:assfail.constprop.14+0x18/0x26 [btrfs]
[ 1570.508150] RSP: 0018:ffff9f9c40f7fa20 EFLAGS: 00010282
[ 1570.508153] RAX: 0000000000000035 RBX: 0000000000000000 RCX: 0000000000000000
[ 1570.508157] RDX: 0000000000000000 RSI: ffff918ae73d9208 RDI: ffff918ae73d9208
[ 1570.528092] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000000000
[ 1570.528093] R10: ffff9f9c40f7f978 R11: 0000000000000000 R12: ffff918ab37c0000
[ 1570.528095] R13: 0000000000000000 R14: 0000000000400000 R15: 0000000000000000
[ 1570.528097] FS:  00007f0d3f937840(0000) GS:ffff918ae7200000(0000) knlGS:0000000000000000
[ 1570.528098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1570.528100] CR2: 00007f9559f4c000 CR3: 000000021bdb9000 CR4: 00000000000006e0
[ 1570.528101] Call Trace:
[ 1570.528149]  btrfs_update_space_info+0xb7/0xc0 [btrfs]
[ 1570.579229]  btrfs_read_block_groups+0x5b2/0x8e0 [btrfs]
[ 1570.579283]  open_ctree+0x1bd5/0x2323 [btrfs]
[ 1570.589311]  ? btrfs_mount_root+0x648/0x770 [btrfs]
[ 1570.589351]  btrfs_mount_root+0x648/0x770 [btrfs]
[ 1570.599226]  ? sched_clock+0x5/0x10
[ 1570.599233]  ? sched_clock_cpu+0x15/0x130
[ 1570.607049]  ? rcu_read_lock_sched_held+0x59/0xa0
[ 1570.607058]  ? legacy_get_tree+0x30/0x60
[ 1570.616042]  legacy_get_tree+0x30/0x60
[ 1570.616045]  vfs_get_tree+0x28/0xe0
[ 1570.616052]  fc_mount+0xe/0x40
[ 1570.626809]  vfs_kern_mount.part.5+0x6f/0x80
[ 1570.626842]  btrfs_mount+0x179/0x940 [btrfs]
[ 1570.626855]  ? sched_clock+0x5/0x10
[ 1570.639359]  ? sched_clock+0x5/0x10
[ 1570.639361]  ? sched_clock_cpu+0x15/0x130
[ 1570.639369]  ? rcu_read_lock_sched_held+0x59/0xa0
[ 1570.652054]  ? legacy_get_tree+0x30/0x60
[ 1570.652056]  legacy_get_tree+0x30/0x60
[ 1570.652058]  vfs_get_tree+0x28/0xe0
[ 1570.652062]  do_mount+0x828/0xa50
[ 1570.652068]  ? memdup_user+0x4b/0x70
[ 1570.670815]  ksys_mount+0x80/0xd0
[ 1570.670819]  __x64_sys_mount+0x21/0x30
[ 1570.670825]  do_syscall_64+0x56/0x220
[ 1570.682011]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1570.682014] RIP: 0033:0x7f0d3f22b5ea
[ 1570.682018] RSP: 002b:00007ffd2cf30e38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 1570.682020] RAX: ffffffffffffffda RBX: 000055d29414c060 RCX: 00007f0d3f22b5ea
[ 1570.682021] RDX: 000055d29414c2c0 RSI: 000055d29414c300 RDI: 000055d29414c2e0
[ 1570.682023] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f0d3f4dd698
[ 1570.682024] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 000055d29414c2e0
[ 1570.682025] R13: 000055d29414c2c0 R14: 000055d293a02160 R15: 000055d29414c060
[ 1570.682035] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache af_packet btrfs bridge stp llc iscsi_ibft iscsi_boot_sysfs xor kvm_amd zstd_decompress kvm zstd_compress xxhash raid6_pq tpm_infineon tpm_tis tpm_tis_core libcrc32c tg3 tpm libphy mptctl acpi_cpufreq serio_raw irqbypass pcspkr k10temp i2c_piix4 button ext4 mbcache jbd2 sr_mod cdrom ohci_pci i2c_algo_bit ehci_pci drm_kms_helper ohci_hcd mptsas ata_generic scsi_transport_sas syscopyarea sysfillrect ehci_hcd sysimgblt mptscsih fb_sys_fops ttm mptbase drm usbcore sata_svw pata_serverworks sg scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[ 1570.810782] ---[ end trace ceba6fe68d860cea ]---
