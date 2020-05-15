Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70341D5A52
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEOTq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 15:46:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgEOTq4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 15:46:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7977ABC7;
        Fri, 15 May 2020 19:46:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AFC72DA732; Fri, 15 May 2020 21:45:59 +0200 (CEST)
Date:   Fri, 15 May 2020 21:45:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: REF_COWS bit rework
Message-ID: <20200515194559.GR18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200515060142.23609-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515060142.23609-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 15, 2020 at 02:01:39PM +0800, Qu Wenruo wrote:
> This small patchset reworks the REF_COWS bit, by renaming it, and remove
> that bit for data relocation root.
> 
> 
> The basic idea of such rework is to reduce the confusion caused by the
> name REF_COWS.
> 
> With the new bit called SHAREABLE, it should be clear that no user can
> really create snapshot for data reloc tree, thus its tree blocks
> shouldn't be shareable.
> 
> This would make data balance for reloc tree a little simpler.
> 
> Changelog:
> v2:
> - Add new patch to address the log tree check in
>   btrfs_truncate_inode_items()
>   Thanks for the advice from David, now it's much simpler than original
>   check, and data reloc tree no longer needs extra hanlding
> 
> - Grab data reloc root in create_reloc_inode() and
>   btrfs_recover_relocation()
> 
> - Comment update
> 
> v3:
> - Remove ALIGN_DOWN() -> round_down() change
> 
> - Remove the confusing comment on the log tree inode

I've added the patches to misc-next, with some fixups. I'll let it also
go through fstests, but a quick run has hit this write-time corruption
very early. I haven't analyzed it and it's possible that it's caused by
my fixups.

btrfs/003		[19:39:32][   79.959953] run fstests btrfs/003 at 2020-05-15 19:39:32
[   80.527008] BTRFS info (device vda): disk space caching is enabled
[   80.530862] BTRFS info (device vda): has skinny extents
[   81.588702] BTRFS: device fsid 168518c8-d58c-40bb-b921-1853b5f43e13 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (11353)
[   81.598929] BTRFS: device fsid 168518c8-d58c-40bb-b921-1853b5f43e13 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (11353)
[   81.607316] BTRFS: device fsid 168518c8-d58c-40bb-b921-1853b5f43e13 devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (11353)
[   81.616304] BTRFS: device fsid 168518c8-d58c-40bb-b921-1853b5f43e13 devid 4 transid 5 /dev/vde scanned by mkfs.btrfs (11353)
[   81.625220] BTRFS: device fsid 168518c8-d58c-40bb-b921-1853b5f43e13 devid 5 transid 5 /dev/vdf scanned by mkfs.btrfs (11353)
[   81.633532] BTRFS: device fsid 168518c8-d58c-40bb-b921-1853b5f43e13 devid 6 transid 5 /dev/vdg scanned by mkfs.btrfs (11353)
[   81.677123] BTRFS info (device vdb): disk space caching is enabled
[   81.680643] BTRFS info (device vdb): has skinny extents
[   81.682275] BTRFS info (device vdb): flagging fs with big metadata feature
[   81.701692] BTRFS info (device vdb): checking UUID tree
[   89.421089] BTRFS: device fsid 62194f9a-4bb9-4f11-9d72-34bb627770a8 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (12984)
[   89.426854] BTRFS: device fsid 62194f9a-4bb9-4f11-9d72-34bb627770a8 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (12984)
[   89.433740] BTRFS: device fsid 62194f9a-4bb9-4f11-9d72-34bb627770a8 devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (12984)
[   89.442686] BTRFS: device fsid 62194f9a-4bb9-4f11-9d72-34bb627770a8 devid 4 transid 5 /dev/vde scanned by mkfs.btrfs (12984)
[   89.451243] BTRFS: device fsid 62194f9a-4bb9-4f11-9d72-34bb627770a8 devid 5 transid 5 /dev/vdf scanned by mkfs.btrfs (12984)
[   89.459020] BTRFS: device fsid 62194f9a-4bb9-4f11-9d72-34bb627770a8 devid 6 transid 5 /dev/vdg scanned by mkfs.btrfs (12984)
[   89.499238] BTRFS info (device vdb): disk space caching is enabled
[   89.501868] BTRFS info (device vdb): has skinny extents
[   89.503909] BTRFS info (device vdb): flagging fs with big metadata feature
[   89.519384] BTRFS info (device vdb): checking UUID tree
[   97.219663] BTRFS: device fsid 18c8f856-5d32-44e3-8a97-f898c01c4806 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (14616)
[   97.228409] BTRFS: device fsid 18c8f856-5d32-44e3-8a97-f898c01c4806 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (14616)
[   97.233077] BTRFS: device fsid 18c8f856-5d32-44e3-8a97-f898c01c4806 devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (14616)
[   97.238235] BTRFS: device fsid 18c8f856-5d32-44e3-8a97-f898c01c4806 devid 4 transid 5 /dev/vde scanned by mkfs.btrfs (14616)
[   97.246465] BTRFS: device fsid 18c8f856-5d32-44e3-8a97-f898c01c4806 devid 5 transid 5 /dev/vdf scanned by mkfs.btrfs (14616)
[   97.251105] BTRFS: device fsid 18c8f856-5d32-44e3-8a97-f898c01c4806 devid 6 transid 5 /dev/vdg scanned by mkfs.btrfs (14616)
[   97.291084] BTRFS info (device vdb): disk space caching is enabled
[   97.293793] BTRFS info (device vdb): has skinny extents
[   97.295700] BTRFS info (device vdb): flagging fs with big metadata feature
[   97.317883] BTRFS info (device vdb): checking UUID tree
[  104.896913] BTRFS: device fsid 0860e370-740c-4f73-a631-8155b52a2a9c devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (16207)
[  104.904143] BTRFS: device fsid 0860e370-740c-4f73-a631-8155b52a2a9c devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (16207)
[  104.912371] BTRFS: device fsid 0860e370-740c-4f73-a631-8155b52a2a9c devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (16207)
[  104.916558] BTRFS: device fsid 0860e370-740c-4f73-a631-8155b52a2a9c devid 4 transid 5 /dev/vde scanned by mkfs.btrfs (16207)
[  104.922823] BTRFS: device fsid 0860e370-740c-4f73-a631-8155b52a2a9c devid 5 transid 5 /dev/vdf scanned by mkfs.btrfs (16207)
[  104.927640] BTRFS: device fsid 0860e370-740c-4f73-a631-8155b52a2a9c devid 6 transid 5 /dev/vdg scanned by mkfs.btrfs (16207)
[  104.968049] BTRFS info (device vdb): disk space caching is enabled
[  104.972725] BTRFS info (device vdb): has skinny extents
[  104.975199] BTRFS info (device vdb): flagging fs with big metadata feature
[  104.994401] BTRFS info (device vdb): checking UUID tree
[  112.217591] BTRFS: device fsid 25db6680-c72d-494b-b8db-e9719d8dfd36 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (17799)
[  112.293518] BTRFS info (device vdb): disk space caching is enabled
[  112.296310] BTRFS info (device vdb): has skinny extents
[  112.298225] BTRFS info (device vdb): flagging fs with big metadata feature
[  112.320796] BTRFS info (device vdb): checking UUID tree
[  119.314197] BTRFS info (device vdb): disk added /dev/vdd
[  119.411823] BTRFS info (device vdb): disk added /dev/vde
[  119.491205] BTRFS info (device vdb): disk added /dev/vdf
[  119.585185] BTRFS info (device vdb): disk added /dev/vdg
[  119.624572] BTRFS info (device vdb): balance: start -d -m -s
[  119.630843] BTRFS info (device vdb): relocating block group 30408704 flags metadata|dup
[  119.640113] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=298909696 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
[  119.647511] BTRFS info (device vdb): leaf 298909696 gen 11 total ptrs 4 free space 15851 owner 18446744073709551607
[  119.652214] BTRFS info (device vdb): refs 3 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 19404
[  119.656275] 	item 0 key (1 1 0) itemoff 16123 itemsize 160
[  119.658436] 		inode generation 1 size 0 mode 100600
[  119.660812] 	item 1 key (256 1 0) itemoff 15963 itemsize 160
[  119.663645] 		inode generation 4 size 0 mode 40755
[  119.665768] 	item 2 key (256 12 256) itemoff 15951 itemsize 12
[  119.668146] 	item 3 key (18446744073709551611 48 1) itemoff 15951 itemsize 0
[  119.671438] BTRFS error (device vdb): block=298909696 write time tree block corruption detected
[  119.675319] ------------[ cut here ]------------
[  119.677789] WARNING: CPU: 1 PID: 19404 at fs/btrfs/disk-io.c:537 btree_csum_one_bio+0x297/0x2a0 [btrfs]
[  119.683116] Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[  119.690407] CPU: 1 PID: 19404 Comm: btrfs Not tainted 5.7.0-rc5-default+ #1108
[  119.693724] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  119.698411] RIP: 0010:btree_csum_one_bio+0x297/0x2a0 [btrfs]
[  119.700653] Code: bc fd ff ff e8 9a 24 c1 c9 31 f6 48 89 3c 24 e8 ef 7b ff ff 48 8b 3c 24 48 c7 c6 f0 45 55 c0 48 8b 17 4c 89 e7 e8 94 cc 0b 00 <0f> 0b e9 8f fd ff ff 66 90 0f 1f 44 00 00 48 89 f7 e9 53 fd ff ff
[  119.706847] RSP: 0018:ffff9ec884397778 EFLAGS: 00010292
[  119.707997] RAX: 0000000000000000 RBX: ffff902c7faf0dc0 RCX: 0000000000000006
[  119.709428] RDX: 0000000000000000 RSI: ffff902c4fcd5dd0 RDI: ffff902c4fcd5500
[  119.711051] RBP: 0000000000000001 R08: 0000001bdd341101 R09: 0000000000000000
[  119.712587] R10: 0000000000000000 R11: 0000000000000000 R12: ffff902c74b3c000
[  119.714957] R13: ffff902c428a16b0 R14: 0000000000000000 R15: 00000000ffffff8b
[  119.716474] FS:  00007fdc12d658c0(0000) GS:ffff902c7b800000(0000) knlGS:0000000000000000
[  119.719045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  119.720724] CR2: 000055a44869a2d8 CR3: 00000001367c2003 CR4: 0000000000160ee0
[  119.725194] Call Trace:
[  119.727333]  btree_submit_bio_hook+0x74/0xc0 [btrfs]
[  119.730365]  submit_one_bio+0x2b/0x40 [btrfs]
[  119.732253]  btree_write_cache_pages+0x373/0x440 [btrfs]
[  119.734909]  do_writepages+0x40/0xe0
[  119.736667]  ? do_raw_spin_unlock+0x4b/0xc0
[  119.738667]  ? _raw_spin_unlock+0x1f/0x30
[  119.740122]  ? wbc_attach_and_unlock_inode+0x194/0x2a0
[  119.743009]  __filemap_fdatawrite_range+0xce/0x110
[  119.744446]  btrfs_write_marked_extents+0x68/0x160 [btrfs]
[  119.746166]  btrfs_write_and_wait_transaction+0x4f/0xd0 [btrfs]
[  119.748184]  btrfs_commit_transaction+0x76a/0xae0 [btrfs]
[  119.750072]  ? start_transaction+0xd2/0x5e0 [btrfs]
[  119.751896]  prepare_to_relocate+0x107/0x130 [btrfs]
[  119.753666]  relocate_block_group+0x5b/0x600 [btrfs]
[  119.755321]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
[  119.757111]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
[  119.758833]  __btrfs_balance+0x41c/0xcc0 [btrfs]
[  119.760526]  btrfs_balance+0x65b/0xbd0 [btrfs]
[  119.762050]  ? kmem_cache_alloc_trace+0x1a7/0x320
[  119.763777]  ? btrfs_ioctl_balance+0x21c/0x350 [btrfs]
[  119.765593]  btrfs_ioctl_balance+0x298/0x350 [btrfs]
[  119.767444]  ? __handle_mm_fault+0x499/0x740
[  119.769007]  btrfs_ioctl+0x304/0x2590 [btrfs]
[  119.770537]  ? do_raw_spin_unlock+0x4b/0xc0
[  119.772015]  ? _raw_spin_unlock+0x1f/0x30
[  119.774671]  ? __handle_mm_fault+0x499/0x740
[  119.777106]  ? do_user_addr_fault+0x1d8/0x3f0
[  119.779366]  ? kvm_sched_clock_read+0x14/0x30
[  119.781451]  ? sched_clock+0x5/0x10
[  119.783584]  ? sched_clock_cpu+0x15/0x130
[  119.785507]  ? do_user_addr_fault+0x1d8/0x3f0
[  119.787587]  ? ksys_ioctl+0x68/0xa0
[  119.789577]  ksys_ioctl+0x68/0xa0
[  119.790909]  __x64_sys_ioctl+0x16/0x20
[  119.792361]  do_syscall_64+0x50/0x210
[  119.793749]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  119.795547] RIP: 0033:0x7fdc12e5e227
[  119.796967] Code: 00 00 90 48 8b 05 69 8c 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 8c 0c 00 f7 d8 64 89 01 48
[  119.802957] RSP: 002b:00007ffc3c0bf7b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[  119.805509] RAX: ffffffffffffffda RBX: 00007ffc3c0bf860 RCX: 00007fdc12e5e227
[  119.807832] RDX: 00007ffc3c0bf860 RSI: 00000000c4009420 RDI: 0000000000000003
[  119.810088] RBP: 0000000000000003 R08: 000055a4486922a0 R09: 0000000000000231
[  119.812378] R10: 00007fdc13088cf0 R11: 0000000000000206 R12: 0000000000000001
[  119.814654] R13: 00007ffc3c0c2127 R14: 0000000000000002 R15: 0000000000000000
[  119.816912] irq event stamp: 19394
[  119.818225] hardirqs last  enabled at (19393): [<ffffffff8a10a166>] console_unlock+0x436/0x590
[  119.821106] hardirqs last disabled at (19394): [<ffffffff8a002b5b>] trace_hardirqs_off_thunk+0x1a/0x1c
[  119.824311] softirqs last  enabled at (19390): [<ffffffff8aa0031e>] __do_softirq+0x31e/0x55d
[  119.827257] softirqs last disabled at (19383): [<ffffffff8a08d91d>] irq_exit+0x9d/0xb0
[  119.830080] ---[ end trace 247639532e5b557e ]---
[  119.832171] BTRFS: error (device vdb) in btrfs_commit_transaction:2323: errno=-5 IO failure (Error while writing out transaction)
[  119.836020] BTRFS info (device vdb): forced readonly
[  119.837888] BTRFS warning (device vdb): Skipping commit of aborted transaction.
[  119.841381] BTRFS: error (device vdb) in cleanup_transaction:1894: errno=-5 IO failure
[  119.845600] BTRFS info (device vdb): balance: ended with status: -30
[  120.282656] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (19409)
[  120.287896] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (19409)
[  120.298518] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (19409)
[  120.303545] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 devid 4 transid 5 /dev/vde scanned by mkfs.btrfs (19409)
[  120.311101] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 devid 5 transid 5 /dev/vdf scanned by mkfs.btrfs (19409)
[  120.314834] BTRFS: device fsid b28016df-bc50-4ac6-a337-926c19fb18f3 devid 6 transid 5 /dev/vdg scanned by mkfs.btrfs (19409)
[  120.349393] BTRFS info (device vdb): disk space caching is enabled
[  120.353340] BTRFS info (device vdb): has skinny extents
[  120.355944] BTRFS info (device vdb): flagging fs with big metadata feature
[  120.377592] BTRFS info (device vdb): checking UUID tree
[  127.395164] BTRFS info (device vdb): relocating block group 1104150528 flags data|raid0
[  127.448678] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=30769152 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
[  127.458117] BTRFS info (device vdb): leaf 30769152 gen 7 total ptrs 4 free space 15851 owner 18446744073709551607
[  127.462400] BTRFS info (device vdb): refs 3 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 21002
[  127.466146] 	item 0 key (1 1 0) itemoff 16123 itemsize 160
[  127.468412] 		inode generation 1 size 0 mode 100600
[  127.470284] 	item 1 key (256 1 0) itemoff 15963 itemsize 160
[  127.472282] 		inode generation 4 size 0 mode 40755
[  127.473848] 	item 2 key (256 12 256) itemoff 15951 itemsize 12
[  127.475601] 	item 3 key (18446744073709551611 48 1) itemoff 15951 itemsize 0
[  127.477585] BTRFS error (device vdb): block=30769152 write time tree block corruption detected
[  127.480577] ------------[ cut here ]------------
[  127.482417] WARNING: CPU: 3 PID: 21002 at fs/btrfs/disk-io.c:537 btree_csum_one_bio+0x297/0x2a0 [btrfs]
[  127.486001] Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[  127.491491] CPU: 3 PID: 21002 Comm: btrfs Tainted: G        W         5.7.0-rc5-default+ #1108
[  127.494777] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  127.498791] RIP: 0010:btree_csum_one_bio+0x297/0x2a0 [btrfs]
[  127.500882] Code: bc fd ff ff e8 9a 24 c1 c9 31 f6 48 89 3c 24 e8 ef 7b ff ff 48 8b 3c 24 48 c7 c6 f0 45 55 c0 48 8b 17 4c 89 e7 e8 94 cc 0b 00 <0f> 0b e9 8f fd ff ff 66 90 0f 1f 44 00 00 48 89 f7 e9 53 fd ff ff
[  127.507102] RSP: 0018:ffff9ec8852ff700 EFLAGS: 00010282
[  127.509172] RAX: 0000000000000000 RBX: ffff902c7f20c680 RCX: 0000000000000006
[  127.511742] RDX: 0000000000000000 RSI: ffff902c4fd28910 RDI: ffff902c4fd28040
[  127.514884] RBP: 0000000000000005 R08: 0000001dae6ee2ba R09: 0000000000000000
[  127.517380] R10: 0000000000000000 R11: 0000000000000000 R12: ffff902c4a994000
[  127.519327] R13: ffff902c428a1ef0 R14: 0000000000000000 R15: 00000000ffffff8b
[  127.523221] FS:  00007f69ecb3b8c0(0000) GS:ffff902c7bc00000(0000) knlGS:0000000000000000
[  127.527813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  127.529913] CR2: 00007f69ecca0af0 CR3: 000000010579c002 CR4: 0000000000160ee0
[  127.531942] Call Trace:
[  127.533156]  btree_submit_bio_hook+0x74/0xc0 [btrfs]
[  127.535744]  submit_one_bio+0x2b/0x40 [btrfs]
[  127.537542]  submit_extent_page+0x104/0x210 [btrfs]
[  127.540137]  write_one_eb+0x1b1/0x390 [btrfs]
[  127.542825]  ? find_first_extent_bit_state+0x90/0x90 [btrfs]
[  127.559976]  btree_write_cache_pages+0x1af/0x440 [btrfs]
[  127.562025]  do_writepages+0x40/0xe0
[  127.563813]  ? do_raw_spin_unlock+0x4b/0xc0
[  127.565541]  ? _raw_spin_unlock+0x1f/0x30
[  127.567363]  ? wbc_attach_and_unlock_inode+0x194/0x2a0
[  127.569545]  __filemap_fdatawrite_range+0xce/0x110
[  127.571519]  btrfs_write_marked_extents+0x68/0x160 [btrfs]
[  127.574396]  btrfs_write_and_wait_transaction+0x4f/0xd0 [btrfs]
[  127.576877]  btrfs_commit_transaction+0x76a/0xae0 [btrfs]
[  127.579328]  ? start_transaction+0xd2/0x5e0 [btrfs]
[  127.581449]  prepare_to_relocate+0x107/0x130 [btrfs]
[  127.583958]  relocate_block_group+0x5b/0x600 [btrfs]
[  127.586867]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
[  127.588999]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
[  127.590844]  btrfs_shrink_device+0x214/0x530 [btrfs]
[  127.592345]  btrfs_rm_device+0x22e/0x7f0 [btrfs]
[  127.593913]  ? _copy_from_user+0x6a/0xa0
[  127.595367]  btrfs_ioctl+0x218f/0x2590 [btrfs]
[  127.596993]  ? __handle_mm_fault+0x1c1/0x740
[  127.598537]  ? do_user_addr_fault+0x1d8/0x3f0
[  127.600139]  ? kvm_sched_clock_read+0x14/0x30
[  127.601713]  ? sched_clock+0x5/0x10
[  127.603121]  ? sched_clock_cpu+0x15/0x130
[  127.604840]  ? do_user_addr_fault+0x1d8/0x3f0
[  127.606740]  ? ksys_ioctl+0x68/0xa0
[  127.608092]  ksys_ioctl+0x68/0xa0
[  127.609434]  __x64_sys_ioctl+0x16/0x20
[  127.610860]  do_syscall_64+0x50/0x210
[  127.612294]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  127.614042] RIP: 0033:0x7f69ecc34227
[  127.615464] Code: 00 00 90 48 8b 05 69 8c 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 8c 0c 00 f7 d8 64 89 01 48
[  127.621798] RSP: 002b:00007ffc4c0a4e08 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  127.624742] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f69ecc34227
[  127.627020] RDX: 00007ffc4c0a4e30 RSI: 000000005000943a RDI: 0000000000000003
[  127.629398] RBP: 00007ffc4c0a6fd0 R08: 00007ffc4c0a4e68 R09: 006764762f766564
[  127.631559] R10: 00007f69ece5ecf0 R11: 0000000000000202 R12: 0000000000000000
[  127.634138] R13: 00007ffc4c0a4e30 R14: 000056046c20be8c R15: 0000000000000003
[  127.635759] irq event stamp: 108944
[  127.637314] hardirqs last  enabled at (108943): [<ffffffff8a10a166>] console_unlock+0x436/0x590
[  127.640821] hardirqs last disabled at (108944): [<ffffffff8a002b5b>] trace_hardirqs_off_thunk+0x1a/0x1c
[  127.644549] softirqs last  enabled at (108940): [<ffffffff8aa0031e>] __do_softirq+0x31e/0x55d
[  127.647486] softirqs last disabled at (108933): [<ffffffff8a08d91d>] irq_exit+0x9d/0xb0
[  127.650608] ---[ end trace 247639532e5b557f ]---
[  127.653165] BTRFS: error (device vdb) in btrfs_commit_transaction:2323: errno=-5 IO failure (Error while writing out transaction)
[  127.657655] BTRFS info (device vdb): forced readonly
[  127.659739] BTRFS warning (device vdb): Skipping commit of aborted transaction.
[  127.663588] BTRFS: error (device vdb) in cleanup_transaction:1894: errno=-5 IO failure
[failed, exit status 1] [19:40:22]- output mismatch (see /tmp/fstests/results//btrfs/003.out.bad)
    --- tests/btrfs/003.out	2018-04-12 16:57:00.608225550 +0000
    +++ /tmp/fstests/results//btrfs/003.out.bad	2020-05-15 19:40:22.176000000 +0000
    @@ -1,2 +1,6 @@
     QA output created by 003
    -Silence is golden
    +ERROR: error during balancing '/tmp/scratch': Read-only file system
    +There may be more info in syslog - try dmesg | tail
    +ERROR: error removing device '/dev/vdg': Read-only file system
    +btrfs device delete failed
    +(see /tmp/fstests/results//btrfs/003.full for details)
    ...
    (Run 'diff -u /tmp/fstests/tests/btrfs/003.out /tmp/fstests/results//btrfs/003.out.bad'  to see the entire diff)
