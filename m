Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E651D7D12
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERPj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 11:39:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:51128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgERPj4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 11:39:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3280AEE9;
        Mon, 18 May 2020 15:39:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A43CBDA7AD; Mon, 18 May 2020 17:38:59 +0200 (CEST)
Date:   Mon, 18 May 2020 17:38:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: REF_COWS bit rework
Message-ID: <20200518153859.GW18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200515060142.23609-1-wqu@suse.com>
 <20200515194559.GR18421@twin.jikos.cz>
 <17637fb6-1b76-32bb-b6ab-468eda982c60@gmx.com>
 <d280611d-b4ea-7365-7775-520814368b26@gmx.com>
 <20200518150331.GU18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518150331.GU18421@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 05:03:31PM +0200, David Sterba wrote:
> On Mon, May 18, 2020 at 01:13:34PM +0800, Qu Wenruo wrote:
> - btrfs_read_tree_root
> - btrfs_init_fs_root

With

2291         location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
2292         root = btrfs_read_tree_root(tree_root, &location);
2293         if (IS_ERR(root)) {
2294                 ret = PTR_ERR(root);
2295                 goto out;
2296         }
2297         ret = btrfs_init_fs_root(root);
2298         if (ret)
2299                 goto out;
2300         set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
2301         fs_info->data_reloc_root = root;

still not fine, btrfs/003

[  104.188077] BTRFS error (device vdb): unable to find ref byte nr 31883264 parent 0 root 18446744073709551607  owner 0 offset 0

[  103.476564] BTRFS info (device vdb): relocating block group 22020096 flags system|raid1
[  103.481260] ------------[ cut here ]------------
[  103.483638] WARNING: CPU: 0 PID: 21011 at fs/btrfs/extent-tree.c:3055 __btrfs_free_extent+0x66c/0x900 [btrfs]
[  103.488388] Modules linked in: xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[  103.492733] CPU: 0 PID: 21011 Comm: btrfs Not tainted 5.7.0-rc6-default+ #1109
[  103.495057] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  103.498331] RIP: 0010:__btrfs_free_extent+0x66c/0x900 [btrfs]
[  103.500037] Code: 48 c7 44 24 48 00 00 00 00 48 89 ea 4c 89 f6 e8 da a3 ff ff 41 89 c7 e9 c8 fb ff ff 0f 0b 48 c7 c7 60 fa 2d c0 e8 2a 8f 2e f1 <0f> 0b 49 8b 3e e8 8a 76 00 00 ff 74 24 18 49 89 d9 4d 89 e8 48 8b
[  103.505108] RSP: 0018:ffffac68455678b0 EFLAGS: 00010246
[  103.506711] RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 0000000000000002
[  103.508748] RDX: 00000000fffffffe RSI: 0000000000000000 RDI: 000151b4a32a2068
[  103.510624] RBP: 0000000001e68000 R08: 000313fad20cf648 R09: ffff8f6e74474a88
[  103.512589] R10: 0000000000000000 R11: ffff8f6e781ffb88 R12: 0000000000000000
[  103.514486] R13: fffffffffffffff7 R14: ffff8f6e74474a88 R15: 00000000fffffffe
[  103.516691] FS:  00007f9ab400b8c0(0000) GS:ffff8f6e7d600000(0000) knlGS:0000000000000000
[  103.519541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  103.521430] CR2: 000055f4d1e28e18 CR3: 00000000747d3006 CR4: 0000000000160ef0
[  103.523684] Call Trace:
[  103.524743]  ? native_sched_clock_from_tsc+0x41/0xc0
[  103.526212]  ? btrfs_run_delayed_refs_for_head+0x197/0xcd0 [btrfs]
[  103.527983]  btrfs_run_delayed_refs_for_head+0x248/0xcd0 [btrfs]
[  103.529704]  ? _raw_read_unlock+0x1f/0x30
[  103.530973]  ? btrfs_merge_delayed_refs+0x3d3/0x480 [btrfs]
[  103.532566]  __btrfs_run_delayed_refs+0x9d/0x680 [btrfs]
[  103.534327]  ? join_transaction+0x15d/0x4c0 [btrfs]
[  103.536146]  ? kvm_sched_clock_read+0x14/0x30
[  103.537535]  ? sched_clock+0x5/0x10
[  103.538720]  ? sched_clock_cpu+0x15/0x130
[  103.540023]  btrfs_run_delayed_refs+0x86/0x1e0 [btrfs]
[  103.541486]  btrfs_commit_transaction+0x57/0xae0 [btrfs]
[  103.543049]  ? start_transaction+0xd2/0x5e0 [btrfs]
[  103.544578]  prepare_to_relocate+0x107/0x130 [btrfs]
[  103.546117]  relocate_block_group+0x5b/0x600 [btrfs]
[  103.547677]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
[  103.549589]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
[  103.551293]  btrfs_shrink_device+0x214/0x530 [btrfs]
[  103.553023]  btrfs_rm_device+0x22e/0x7f0 [btrfs]
[  103.554635]  ? _copy_from_user+0x6a/0xa0
[  103.556118]  btrfs_ioctl+0x218f/0x2590 [btrfs]
[  103.557709]  ? __handle_mm_fault+0x1c1/0x740
[  103.559204]  ? do_user_addr_fault+0x1d8/0x3f0
[  103.560590]  ? kvm_sched_clock_read+0x14/0x30
[  103.561927]  ? sched_clock+0x5/0x10
[  103.563126]  ? sched_clock_cpu+0x15/0x130
[  103.564458]  ? do_user_addr_fault+0x1d8/0x3f0
[  103.565817]  ? ksys_ioctl+0x68/0xa0
[  103.566965]  ksys_ioctl+0x68/0xa0
[  103.568135]  __x64_sys_ioctl+0x16/0x20
[  103.569426]  do_syscall_64+0x50/0x210
[  103.570718]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  103.572304] RIP: 0033:0x7f9ab4104227
[  103.573566] Code: 00 00 90 48 8b 05 69 8c 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 8c 0c 00 f7 d8 64 89 01 48
[  103.578827] RSP: 002b:00007ffc5dd62938 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  103.581443] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ab4104227
[  103.583643] RDX: 00007ffc5dd62960 RSI: 000000005000943a RDI: 0000000000000003
[  103.585796] RBP: 00007ffc5dd64b00 R08: 00007ffc5dd62998 R09: 006764762f766564
[  103.587920] R10: 00007f9ab432ecf0 R11: 0000000000000202 R12: 0000000000000000
[  103.590108] R13: 00007ffc5dd62960 R14: 000055ee38909e8c R15: 0000000000000003
[  103.592356] irq event stamp: 1219702
[  103.593688] hardirqs last  enabled at (1219701): [<ffffffffb17b090e>] _raw_spin_unlock_irqrestore+0x3e/0x50
[  103.596941] hardirqs last disabled at (1219702): [<ffffffffb1002b5b>] trace_hardirqs_off_thunk+0x1a/0x1c
[  103.600110] softirqs last  enabled at (1219564): [<ffffffffb1a0031e>] __do_softirq+0x31e/0x55d
[  103.602911] softirqs last disabled at (1219503): [<ffffffffb108d9ed>] irq_exit+0x9d/0xb0
[  103.605756] ---[ end trace 0cea18996e5ca624 ]---
[  103.607373] BTRFS info (device vdb): leaf 12916031488 gen 22 total ptrs 111 free space 9383 owner 2
[  103.610495] BTRFS info (device vdb): refs 2 lock (w:1 r:0 bw:0 br:0 sw:1 sr:0) lock_owner 21011 current 21011
[  103.613684] 	item 0 key (22020096 169 0) itemoff 16250 itemsize 33
[  103.615597] 		extent refs 1 gen 22 flags 2
[  103.617040] 		ref#0: tree block backref root 3
[  103.618523] 	item 1 key (22020096 192 8388608) itemoff 16226 itemsize 24
[  103.620533] 		block group used 16384 chunk_objectid 256 flags 18
[  103.622401] 	item 2 key (7546601472 168 262144) itemoff 16173 itemsize 53
[  103.624531] 		extent refs 1 gen 19 flags 1
[  103.625954] 		ref#0: extent data backref root 1 objectid 256 offset 0 count 1
[  103.628154] 	item 3 key (7546601472 192 5368709120) itemoff 16149 itemsize 24
[  103.630330] 		block group used 4538368 chunk_objectid 256 flags 9
[  103.632218] 	item 4 key (7547125760 168 262144) itemoff 16096 itemsize 53
[  103.634240] 		extent refs 1 gen 21 flags 1
[  103.635634] 		ref#0: extent data backref root 1 objectid 259 offset 0 count 1
[  103.637862] 	item 5 key (7547387904 168 1310720) itemoff 16043 itemsize 53
[  103.639966] 		extent refs 1 gen 21 flags 1
[  103.641218] 		ref#0: extent data backref root 1 objectid 258 offset 0 count 1
[  103.643165] 	item 6 key (7549747200 168 12288) itemoff 16006 itemsize 37
[  103.645120] 		extent refs 1 gen 8 flags 1
[  103.646443] 		ref#0: shared data backref parent 12915392512 count 1
[  103.648219] 	item 7 key (7549759488 168 12288) itemoff 15969 itemsize 37
[  103.649972] 		extent refs 1 gen 8 flags 1
[  103.651361] 		ref#0: shared data backref parent 12915392512 count 1
[  103.653234] 	item 8 key (7549771776 168 12288) itemoff 15932 itemsize 37
[  103.654963] 		extent refs 1 gen 8 flags 1
[  103.656235] 		ref#0: shared data backref parent 12915392512 count 1
[  103.657918] 	item 9 key (7549784064 168 12288) itemoff 15895 itemsize 37
[  103.659702] 		extent refs 1 gen 8 flags 1
[  103.661039] 		ref#0: shared data backref parent 12915392512 count 1
[  103.662705] 	item 10 key (7549796352 168 12288) itemoff 15858 itemsize 37
[  103.664576] 		extent refs 1 gen 8 flags 1
[  103.665833] 		ref#0: shared data backref parent 12915392512 count 1
[  103.667512] 	item 11 key (7549808640 168 12288) itemoff 15821 itemsize 37
[  103.669324] 		extent refs 1 gen 8 flags 1
[  103.670581] 		ref#0: shared data backref parent 12915392512 count 1
[  103.672305] 	item 12 key (7549820928 168 12288) itemoff 15784 itemsize 37
[  103.682923] 		extent refs 1 gen 8 flags 1
[  103.684201] 		ref#0: shared data backref parent 12915392512 count 1
[  103.685913] 	item 13 key (7549833216 168 12288) itemoff 15747 itemsize 37
[  103.687798] 		extent refs 1 gen 8 flags 1
[  103.689116] 		ref#0: shared data backref parent 12915392512 count 1
[  103.690910] 	item 14 key (7549845504 168 12288) itemoff 15710 itemsize 37
[  103.692850] 		extent refs 1 gen 8 flags 1
[  103.694070] 		ref#0: shared data backref parent 12915392512 count 1
[  103.695744] 	item 15 key (7549857792 168 12288) itemoff 15673 itemsize 37
[  103.697593] 		extent refs 1 gen 8 flags 1
[  103.698824] 		ref#0: shared data backref parent 12915392512 count 1
[  103.700589] 	item 16 key (7549870080 168 12288) itemoff 15636 itemsize 37
[  103.702508] 		extent refs 1 gen 8 flags 1
[  103.703873] 		ref#0: shared data backref parent 12915392512 count 1
[  103.705573] 	item 17 key (7549882368 168 12288) itemoff 15599 itemsize 37
[  103.707363] 		extent refs 1 gen 8 flags 1
[  103.708644] 		ref#0: shared data backref parent 12915392512 count 1
[  103.710300] 	item 18 key (7549894656 168 12288) itemoff 15562 itemsize 37
[  103.712431] 		extent refs 1 gen 8 flags 1
[  103.713877] 		ref#0: shared data backref parent 12915392512 count 1
[  103.715866] 	item 19 key (7549906944 168 12288) itemoff 15525 itemsize 37
[  103.717995] 		extent refs 1 gen 8 flags 1
[  103.719438] 		ref#0: shared data backref parent 12915392512 count 1
[  103.721452] 	item 20 key (7549919232 168 12288) itemoff 15488 itemsize 37
[  103.723574] 		extent refs 1 gen 8 flags 1
[  103.725085] 		ref#0: shared data backref parent 12915392512 count 1
[  103.727163] 	item 21 key (7549931520 168 12288) itemoff 15451 itemsize 37
[  103.729031] 		extent refs 1 gen 8 flags 1
[  103.730305] 		ref#0: shared data backref parent 12915392512 count 1
[  103.732026] 	item 22 key (7549943808 168 12288) itemoff 15414 itemsize 37
[  103.733761] 		extent refs 1 gen 8 flags 1
[  103.734983] 		ref#0: shared data backref parent 12915392512 count 1
[  103.736710] 	item 23 key (7549956096 168 12288) itemoff 15377 itemsize 37
[  103.738589] 		extent refs 1 gen 8 flags 1
[  103.739962] 		ref#0: shared data backref parent 12915392512 count 1
[  103.741925] 	item 24 key (7549968384 168 12288) itemoff 15340 itemsize 37
[  103.744059] 		extent refs 1 gen 8 flags 1
[  103.745476] 		ref#0: shared data backref parent 12915392512 count 1
[  103.747416] 	item 25 key (7549980672 168 12288) itemoff 15303 itemsize 37
[  103.749495] 		extent refs 1 gen 8 flags 1
[  103.750908] 		ref#0: shared data backref parent 12915392512 count 1
[  103.752878] 	item 26 key (7549992960 168 12288) itemoff 15266 itemsize 37
[  103.754966] 		extent refs 1 gen 8 flags 1
[  103.756378] 		ref#0: shared data backref parent 12915408896 count 1
[  103.758320] 	item 27 key (7550005248 168 12288) itemoff 15229 itemsize 37
[  103.760225] 		extent refs 1 gen 8 flags 1
[  103.761495] 		ref#0: shared data backref parent 12915408896 count 1
[  103.763406] 	item 28 key (7550017536 168 12288) itemoff 15192 itemsize 37
[  103.765476] 		extent refs 1 gen 8 flags 1
[  103.766879] 		ref#0: shared data backref parent 12915408896 count 1
[  103.768840] 	item 29 key (7550029824 168 12288) itemoff 15155 itemsize 37
[  103.770881] 		extent refs 1 gen 8 flags 1
[  103.772294] 		ref#0: shared data backref parent 12915408896 count 1
[  103.774244] 	item 30 key (7550042112 168 12288) itemoff 15118 itemsize 37
[  103.776246] 		extent refs 1 gen 8 flags 1
[  103.777593] 		ref#0: shared data backref parent 12915408896 count 1
[  103.779486] 	item 31 key (7550054400 168 12288) itemoff 15081 itemsize 37
[  103.781516] 		extent refs 1 gen 8 flags 1
[  103.782920] 		ref#0: shared data backref parent 12915408896 count 1
[  103.784833] 	item 32 key (7550066688 168 12288) itemoff 15044 itemsize 37
[  103.786906] 		extent refs 1 gen 8 flags 1
[  103.788360] 		ref#0: shared data backref parent 12915408896 count 1
[  103.790355] 	item 33 key (7550078976 168 12288) itemoff 15007 itemsize 37
[  103.792499] 		extent refs 1 gen 8 flags 1
[  103.793941] 		ref#0: shared data backref parent 12915408896 count 1
[  103.795927] 	item 34 key (7550091264 168 12288) itemoff 14970 itemsize 37
[  103.798011] 		extent refs 1 gen 8 flags 1
[  103.799220] 		ref#0: shared data backref parent 12915408896 count 1
[  103.800900] 	item 35 key (7550103552 168 12288) itemoff 14933 itemsize 37
[  103.802949] 		extent refs 1 gen 8 flags 1
[  103.804399] 		ref#0: shared data backref parent 12915408896 count 1
[  103.806333] 	item 36 key (7550115840 168 12288) itemoff 14896 itemsize 37
[  103.808405] 		extent refs 1 gen 8 flags 1
[  103.809805] 		ref#0: shared data backref parent 12915408896 count 1
[  103.811731] 	item 37 key (7550128128 168 12288) itemoff 14859 itemsize 37
[  103.813803] 		extent refs 1 gen 8 flags 1
[  103.815196] 		ref#0: shared data backref parent 12915408896 count 1
[  103.817131] 	item 38 key (7550140416 168 12288) itemoff 14822 itemsize 37
[  103.819033] 		extent refs 1 gen 8 flags 1
[  103.820379] 		ref#0: shared data backref parent 12915408896 count 1
[  103.822148] 	item 39 key (7550152704 168 12288) itemoff 14785 itemsize 37
[  103.823891] 		extent refs 1 gen 8 flags 1
[  103.825117] 		ref#0: shared data backref parent 12915408896 count 1
[  103.826770] 	item 40 key (7550164992 168 12288) itemoff 14748 itemsize 37
[  103.828634] 		extent refs 1 gen 8 flags 1
[  103.829825] 		ref#0: shared data backref parent 12915408896 count 1
[  103.831482] 	item 41 key (7550177280 168 12288) itemoff 14711 itemsize 37
[  103.833271] 		extent refs 1 gen 8 flags 1
[  103.834512] 		ref#0: shared data backref parent 12915408896 count 1
[  103.836181] 	item 42 key (7550189568 168 12288) itemoff 14674 itemsize 37
[  103.837971] 		extent refs 1 gen 8 flags 1
[  103.839255] 		ref#0: shared data backref parent 12915408896 count 1
[  103.841066] 	item 43 key (7550201856 168 12288) itemoff 14637 itemsize 37
[  103.843080] 		extent refs 1 gen 8 flags 1
[  103.844450] 		ref#0: shared data backref parent 12915408896 count 1
[  103.846317] 	item 44 key (7550214144 168 12288) itemoff 14600 itemsize 37
[  103.848286] 		extent refs 1 gen 8 flags 1
[  103.849647] 		ref#0: shared data backref parent 12915408896 count 1
[  103.851373] 	item 45 key (7550226432 168 12288) itemoff 14563 itemsize 37
[  103.853123] 		extent refs 1 gen 8 flags 1
[  103.854370] 		ref#0: shared data backref parent 12915408896 count 1
[  103.855922] 	item 46 key (7550238720 168 12288) itemoff 14526 itemsize 37
[  103.857613] 		extent refs 1 gen 8 flags 1
[  103.858815] 		ref#0: shared data backref parent 12915408896 count 1
[  103.860629] 	item 47 key (7550251008 168 12288) itemoff 14489 itemsize 37
[  103.862379] 		extent refs 1 gen 8 flags 1
[  103.863572] 		ref#0: shared data backref parent 12915408896 count 1
[  103.865192] 	item 48 key (7550263296 168 12288) itemoff 14452 itemsize 37
[  103.867156] 		extent refs 1 gen 8 flags 1
[  103.868559] 		ref#0: shared data backref parent 12915408896 count 1
[  103.870353] 	item 49 key (7550275584 168 12288) itemoff 14415 itemsize 37
[  103.872282] 		extent refs 1 gen 8 flags 1
[  103.873621] 		ref#0: shared data backref parent 12915408896 count 1
[  103.875483] 	item 50 key (7550287872 168 12288) itemoff 14378 itemsize 37
[  103.877456] 		extent refs 1 gen 8 flags 1
[  103.878808] 		ref#0: shared data backref parent 12915408896 count 1
[  103.880700] 	item 51 key (7550300160 168 12288) itemoff 14341 itemsize 37
[  103.882595] 		extent refs 1 gen 8 flags 1
[  103.883928] 		ref#0: shared data backref parent 12915408896 count 1
[  103.885784] 	item 52 key (7550312448 168 12288) itemoff 14304 itemsize 37
[  103.887773] 		extent refs 1 gen 8 flags 1
[  103.889119] 		ref#0: shared data backref parent 12915408896 count 1
[  103.890982] 	item 53 key (7550324736 168 12288) itemoff 14267 itemsize 37
[  103.892949] 		extent refs 1 gen 8 flags 1
[  103.894317] 		ref#0: shared data backref parent 12915408896 count 1
[  103.896196] 	item 54 key (7550337024 168 12288) itemoff 14230 itemsize 37
[  103.898119] 		extent refs 1 gen 8 flags 1
[  103.899457] 		ref#0: shared data backref parent 12915408896 count 1
[  103.901260] 	item 55 key (7550349312 168 12288) itemoff 14193 itemsize 37
[  103.903243] 		extent refs 1 gen 8 flags 1
[  103.904590] 		ref#0: shared data backref parent 12915408896 count 1
[  103.906360] 	item 56 key (7550361600 168 12288) itemoff 14156 itemsize 37
[  103.908352] 		extent refs 1 gen 8 flags 1
[  103.909696] 		ref#0: shared data backref parent 12915408896 count 1
[  103.911544] 	item 57 key (7550373888 168 12288) itemoff 14119 itemsize 37
[  103.913484] 		extent refs 1 gen 8 flags 1
[  103.914840] 		ref#0: shared data backref parent 12915408896 count 1
[  103.916722] 	item 58 key (7550386176 168 12288) itemoff 14082 itemsize 37
[  103.918610] 		extent refs 1 gen 8 flags 1
[  103.919917] 		ref#0: shared data backref parent 12915408896 count 1
[  103.921737] 	item 59 key (7550398464 168 12288) itemoff 14045 itemsize 37
[  103.923633] 		extent refs 1 gen 8 flags 1
[  103.924949] 		ref#0: shared data backref parent 12915408896 count 1
[  103.926814] 	item 60 key (7550410752 168 12288) itemoff 14008 itemsize 37
[  103.928791] 		extent refs 1 gen 8 flags 1
[  103.930148] 		ref#0: shared data backref parent 12915408896 count 1
[  103.932015] 	item 61 key (7550423040 168 12288) itemoff 13971 itemsize 37
[  103.933978] 		extent refs 1 gen 8 flags 1
[  103.935300] 		ref#0: shared data backref parent 12915408896 count 1
[  103.937034] 	item 62 key (7550435328 168 12288) itemoff 13934 itemsize 37
[  103.938804] 		extent refs 1 gen 8 flags 1
[  103.940190] 		ref#0: shared data backref parent 12915408896 count 1
[  103.941935] 	item 63 key (7550447616 168 12288) itemoff 13897 itemsize 37
[  103.943663] 		extent refs 1 gen 8 flags 1
[  103.944856] 		ref#0: shared data backref parent 12915408896 count 1
[  103.946601] 	item 64 key (7550459904 168 12288) itemoff 13860 itemsize 37
[  103.948478] 		extent refs 1 gen 8 flags 1
[  103.949773] 		ref#0: shared data backref parent 12915408896 count 1
[  103.951587] 	item 65 key (7550472192 168 12288) itemoff 13823 itemsize 37
[  103.953509] 		extent refs 1 gen 8 flags 1
[  103.954809] 		ref#0: shared data backref parent 12915408896 count 1
[  103.956624] 	item 66 key (7550484480 168 12288) itemoff 13786 itemsize 37
[  103.958499] 		extent refs 1 gen 8 flags 1
[  103.959789] 		ref#0: shared data backref parent 12915425280 count 1
[  103.961575] 	item 67 key (7550496768 168 12288) itemoff 13749 itemsize 37
[  103.963453] 		extent refs 1 gen 8 flags 1
[  103.964763] 		ref#0: shared data backref parent 12915425280 count 1
[  103.966566] 	item 68 key (7550509056 168 12288) itemoff 13712 itemsize 37
[  103.968528] 		extent refs 1 gen 8 flags 1
[  103.969886] 		ref#0: shared data backref parent 12915425280 count 1
[  103.971797] 	item 69 key (7550521344 168 12288) itemoff 13675 itemsize 37
[  103.973722] 		extent refs 1 gen 8 flags 1
[  103.975026] 		ref#0: shared data backref parent 12915425280 count 1
[  103.976821] 	item 70 key (7550533632 168 12288) itemoff 13638 itemsize 37
[  103.978724] 		extent refs 1 gen 8 flags 1
[  103.980091] 		ref#0: shared data backref parent 12915425280 count 1
[  103.981963] 	item 71 key (7550545920 168 12288) itemoff 13601 itemsize 37
[  103.983946] 		extent refs 1 gen 8 flags 1
[  103.985294] 		ref#0: shared data backref parent 12915425280 count 1
[  103.987105] 	item 72 key (7550558208 168 12288) itemoff 13564 itemsize 37
[  103.997580] 		extent refs 1 gen 8 flags 1
[  103.998898] 		ref#0: shared data backref parent 12915425280 count 1
[  104.000716] 	item 73 key (7550570496 168 12288) itemoff 13527 itemsize 37
[  104.002621] 		extent refs 1 gen 8 flags 1
[  104.003925] 		ref#0: shared data backref parent 12915425280 count 1
[  104.005513] 	item 74 key (7550582784 168 12288) itemoff 13490 itemsize 37
[  104.007451] 		extent refs 1 gen 8 flags 1
[  104.008770] 		ref#0: shared data backref parent 12915425280 count 1
[  104.010582] 	item 75 key (7550595072 168 12288) itemoff 13453 itemsize 37
[  104.012568] 		extent refs 1 gen 8 flags 1
[  104.013918] 		ref#0: shared data backref parent 12915425280 count 1
[  104.015782] 	item 76 key (7550607360 168 12288) itemoff 13416 itemsize 37
[  104.017765] 		extent refs 1 gen 8 flags 1
[  104.019090] 		ref#0: shared data backref parent 12915425280 count 1
[  104.020901] 	item 77 key (7550619648 168 12288) itemoff 13379 itemsize 37
[  104.022809] 		extent refs 1 gen 8 flags 1
[  104.024160] 		ref#0: shared data backref parent 12915425280 count 1
[  104.025952] 	item 78 key (7550631936 168 12288) itemoff 13342 itemsize 37
[  104.027850] 		extent refs 1 gen 8 flags 1
[  104.029148] 		ref#0: shared data backref parent 12915425280 count 1
[  104.030891] 	item 79 key (7550644224 168 12288) itemoff 13305 itemsize 37
[  104.032760] 		extent refs 1 gen 8 flags 1
[  104.034032] 		ref#0: shared data backref parent 12915425280 count 1
[  104.035771] 	item 80 key (7550656512 168 12288) itemoff 13268 itemsize 37
[  104.037636] 		extent refs 1 gen 8 flags 1
[  104.038905] 		ref#0: shared data backref parent 12915425280 count 1
[  104.040709] 	item 81 key (7550668800 168 12288) itemoff 13231 itemsize 37
[  104.042632] 		extent refs 1 gen 8 flags 1
[  104.043927] 		ref#0: shared data backref parent 12915425280 count 1
[  104.045772] 	item 82 key (7550681088 168 12288) itemoff 13194 itemsize 37
[  104.047678] 		extent refs 1 gen 8 flags 1
[  104.048986] 		ref#0: shared data backref parent 12915425280 count 1
[  104.050793] 	item 83 key (7550693376 168 12288) itemoff 13157 itemsize 37
[  104.052722] 		extent refs 1 gen 8 flags 1
[  104.054036] 		ref#0: shared data backref parent 12915425280 count 1
[  104.055867] 	item 84 key (7550705664 168 12288) itemoff 13120 itemsize 37
[  104.057848] 		extent refs 1 gen 8 flags 1
[  104.059145] 		ref#0: shared data backref parent 12915425280 count 1
[  104.060941] 	item 85 key (7550717952 168 12288) itemoff 13083 itemsize 37
[  104.062845] 		extent refs 1 gen 8 flags 1
[  104.064128] 		ref#0: shared data backref parent 12915425280 count 1
[  104.065880] 	item 86 key (7550730240 168 12288) itemoff 13046 itemsize 37
[  104.067738] 		extent refs 1 gen 8 flags 1
[  104.069039] 		ref#0: shared data backref parent 12915425280 count 1
[  104.070841] 	item 87 key (7550742528 168 12288) itemoff 13009 itemsize 37
[  104.072842] 		extent refs 1 gen 8 flags 1
[  104.074149] 		ref#0: shared data backref parent 12915425280 count 1
[  104.075938] 	item 88 key (7550754816 168 12288) itemoff 12972 itemsize 37
[  104.077870] 		extent refs 1 gen 8 flags 1
[  104.079177] 		ref#0: shared data backref parent 12915425280 count 1
[  104.080995] 	item 89 key (7550767104 168 12288) itemoff 12935 itemsize 37
[  104.082924] 		extent refs 1 gen 8 flags 1
[  104.084297] 		ref#0: shared data backref parent 12915425280 count 1
[  104.086150] 	item 90 key (7550779392 168 12288) itemoff 12898 itemsize 37
[  104.088063] 		extent refs 1 gen 8 flags 1
[  104.089377] 		ref#0: shared data backref parent 12915425280 count 1
[  104.091150] 	item 91 key (7550791680 168 12288) itemoff 12861 itemsize 37
[  104.093056] 		extent refs 1 gen 8 flags 1
[  104.094350] 		ref#0: shared data backref parent 12915425280 count 1
[  104.096173] 	item 92 key (7550803968 168 12288) itemoff 12824 itemsize 37
[  104.098077] 		extent refs 1 gen 8 flags 1
[  104.099361] 		ref#0: shared data backref parent 12915425280 count 1
[  104.101121] 	item 93 key (7550816256 168 12288) itemoff 12787 itemsize 37
[  104.103008] 		extent refs 1 gen 8 flags 1
[  104.104297] 		ref#0: shared data backref parent 12915425280 count 1
[  104.106081] 	item 94 key (7550828544 168 12288) itemoff 12750 itemsize 37
[  104.107974] 		extent refs 1 gen 8 flags 1
[  104.109295] 		ref#0: shared data backref parent 12915425280 count 1
[  104.111066] 	item 95 key (7550840832 168 12288) itemoff 12713 itemsize 37
[  104.112967] 		extent refs 1 gen 8 flags 1
[  104.114261] 		ref#0: shared data backref parent 12915425280 count 1
[  104.115916] 	item 96 key (7550853120 168 12288) itemoff 12676 itemsize 37
[  104.117640] 		extent refs 1 gen 8 flags 1
[  104.118875] 		ref#0: shared data backref parent 12915425280 count 1
[  104.120509] 	item 97 key (7550865408 168 12288) itemoff 12639 itemsize 37
[  104.122156] 		extent refs 1 gen 8 flags 1
[  104.123308] 		ref#0: shared data backref parent 12915425280 count 1
[  104.124884] 	item 98 key (7550877696 168 12288) itemoff 12602 itemsize 37
[  104.126612] 		extent refs 1 gen 8 flags 1
[  104.127829] 		ref#0: shared data backref parent 12915425280 count 1
[  104.129434] 	item 99 key (7550889984 168 12288) itemoff 12565 itemsize 37
[  104.131155] 		extent refs 1 gen 8 flags 1
[  104.132501] 		ref#0: shared data backref parent 12915425280 count 1
[  104.134353] 	item 100 key (7550902272 168 12288) itemoff 12528 itemsize 37
[  104.136348] 		extent refs 1 gen 8 flags 1
[  104.137680] 		ref#0: shared data backref parent 12915425280 count 1
[  104.139515] 	item 101 key (7550914560 168 12288) itemoff 12491 itemsize 37
[  104.141450] 		extent refs 1 gen 8 flags 1
[  104.142747] 		ref#0: shared data backref parent 12915425280 count 1
[  104.144628] 	item 102 key (7550926848 168 12288) itemoff 12454 itemsize 37
[  104.146583] 		extent refs 1 gen 8 flags 1
[  104.147918] 		ref#0: shared data backref parent 12915425280 count 1
[  104.149800] 	item 103 key (7550939136 168 12288) itemoff 12417 itemsize 37
[  104.151820] 		extent refs 1 gen 8 flags 1
[  104.153185] 		ref#0: shared data backref parent 12915425280 count 1
[  104.155038] 	item 104 key (7550951424 168 12288) itemoff 12380 itemsize 37
[  104.156994] 		extent refs 1 gen 8 flags 1
[  104.158305] 		ref#0: shared data backref parent 12915425280 count 1
[  104.160059] 	item 105 key (7550963712 168 12288) itemoff 12343 itemsize 37
[  104.162041] 		extent refs 1 gen 8 flags 1
[  104.163343] 		ref#0: shared data backref parent 12915425280 count 1
[  104.165122] 	item 106 key (7550976000 168 12288) itemoff 12306 itemsize 37
[  104.166748] 		extent refs 1 gen 8 flags 1
[  104.167929] 		ref#0: shared data backref parent 12915441664 count 1
[  104.169624] 	item 107 key (7550988288 168 12288) itemoff 12269 itemsize 37
[  104.171436] 		extent refs 1 gen 8 flags 1
[  104.172703] 		ref#0: shared data backref parent 12915441664 count 1
[  104.174373] 	item 108 key (7551000576 168 12288) itemoff 12232 itemsize 37
[  104.176201] 		extent refs 1 gen 8 flags 1
[  104.177348] 		ref#0: shared data backref parent 12915441664 count 1
[  104.178988] 	item 109 key (7551012864 168 12288) itemoff 12195 itemsize 37
[  104.180779] 		extent refs 1 gen 8 flags 1
[  104.181980] 		ref#0: shared data backref parent 12915441664 count 1
[  104.183531] 	item 110 key (7551025152 168 12288) itemoff 12158 itemsize 37
[  104.185268] 		extent refs 1 gen 8 flags 1
[  104.186464] 		ref#0: shared data backref parent 12915441664 count 1
[  104.188077] BTRFS error (device vdb): unable to find ref byte nr 31883264 parent 0 root 18446744073709551607  owner 0 offset 0
[  104.190938] ------------[ cut here ]------------
[  104.192233] BTRFS: Transaction aborted (error -2)
[  104.193563] WARNING: CPU: 0 PID: 21011 at fs/btrfs/extent-tree.c:3061 __btrfs_free_extent+0x6c7/0x900 [btrfs]
[  104.196276] Modules linked in: xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[  104.200443] CPU: 0 PID: 21011 Comm: btrfs Tainted: G        W         5.7.0-rc6-default+ #1109
[  104.202857] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  104.206257] RIP: 0010:__btrfs_free_extent+0x6c7/0x900 [btrfs]
[  104.208018] Code: 8b 40 50 f0 48 0f ba a8 f8 1b 00 00 02 0f 92 c0 5e 84 c0 0f 85 44 d9 0c 00 be fe ff ff ff 48 c7 c7 e8 c4 27 c0 e8 19 92 ef f0 <0f> 0b e9 2c d9 0c 00 83 e8 01 49 8b 3e b9 11 00 00 00 48 8d 74 24
[  104.213484] RSP: 0018:ffffac68455678b0 EFLAGS: 00010282
[  104.215108] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
[  104.217146] RDX: ffff8f6e74a2d500 RSI: ffff8f6e74a2de08 RDI: ffff8f6e74a2d500
[  104.219176] RBP: 0000000001e68000 R08: 00000018426b0f4e R09: 0000000000000000
[  104.221126] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  104.223127] R13: fffffffffffffff7 R14: ffff8f6e74474a88 R15: 00000000fffffffe
[  104.225090] FS:  00007f9ab400b8c0(0000) GS:ffff8f6e7d600000(0000) knlGS:0000000000000000
[  104.227602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.229265] CR2: 000055f4d1e28e18 CR3: 00000000747d3006 CR4: 0000000000160ef0
[  104.231230] Call Trace:
[  104.232217]  ? native_sched_clock_from_tsc+0x41/0xc0
[  104.233711]  ? btrfs_run_delayed_refs_for_head+0x197/0xcd0 [btrfs]
[  104.235452]  btrfs_run_delayed_refs_for_head+0x248/0xcd0 [btrfs]
[  104.237153]  ? _raw_read_unlock+0x1f/0x30
[  104.238443]  ? btrfs_merge_delayed_refs+0x3d3/0x480 [btrfs]
[  104.240071]  __btrfs_run_delayed_refs+0x9d/0x680 [btrfs]
[  104.241662]  ? join_transaction+0x15d/0x4c0 [btrfs]
[  104.243119]  ? kvm_sched_clock_read+0x14/0x30
[  104.244486]  ? sched_clock+0x5/0x10
[  104.245671]  ? sched_clock_cpu+0x15/0x130
[  104.246987]  btrfs_run_delayed_refs+0x86/0x1e0 [btrfs]
[  104.248558]  btrfs_commit_transaction+0x57/0xae0 [btrfs]
[  104.250129]  ? start_transaction+0xd2/0x5e0 [btrfs]
[  104.251577]  prepare_to_relocate+0x107/0x130 [btrfs]
[  104.253145]  relocate_block_group+0x5b/0x600 [btrfs]
[  104.254491]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
[  104.255998]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
[  104.257371]  btrfs_shrink_device+0x214/0x530 [btrfs]
[  104.258701]  btrfs_rm_device+0x22e/0x7f0 [btrfs]
[  104.260057]  ? _copy_from_user+0x6a/0xa0
[  104.261241]  btrfs_ioctl+0x218f/0x2590 [btrfs]
[  104.262524]  ? __handle_mm_fault+0x1c1/0x740
[  104.263783]  ? do_user_addr_fault+0x1d8/0x3f0
[  104.265202]  ? kvm_sched_clock_read+0x14/0x30
[  104.266596]  ? sched_clock+0x5/0x10
[  104.267780]  ? sched_clock_cpu+0x15/0x130
[  104.269056]  ? do_user_addr_fault+0x1d8/0x3f0
[  104.270437]  ? ksys_ioctl+0x68/0xa0
[  104.271634]  ksys_ioctl+0x68/0xa0
[  104.272705]  __x64_sys_ioctl+0x16/0x20
[  104.273851]  do_syscall_64+0x50/0x210
[  104.275171]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  104.276793] RIP: 0033:0x7f9ab4104227
[  104.278087] Code: 00 00 90 48 8b 05 69 8c 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 8c 0c 00 f7 d8 64 89 01 48
[  104.291704] RSP: 002b:00007ffc5dd62938 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  104.294058] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ab4104227
[  104.295819] RDX: 00007ffc5dd62960 RSI: 000000005000943a RDI: 0000000000000003
[  104.297535] RBP: 00007ffc5dd64b00 R08: 00007ffc5dd62998 R09: 006764762f766564
[  104.299491] R10: 00007f9ab432ecf0 R11: 0000000000000202 R12: 0000000000000000
[  104.301225] R13: 00007ffc5dd62960 R14: 000055ee38909e8c R15: 0000000000000003
[  104.303016] irq event stamp: 1224070
[  104.304101] hardirqs last  enabled at (1224069): [<ffffffffb110a256>] console_unlock+0x436/0x590
[  104.306736] hardirqs last disabled at (1224070): [<ffffffffb1002b5b>] trace_hardirqs_off_thunk+0x1a/0x1c
[  104.309723] softirqs last  enabled at (1224058): [<ffffffffb1a0031e>] __do_softirq+0x31e/0x55d
[  104.312528] softirqs last disabled at (1224051): [<ffffffffb108d9ed>] irq_exit+0x9d/0xb0
[  104.315200] ---[ end trace 0cea18996e5ca625 ]---
[  104.316770] BTRFS: error (device vdb) in __btrfs_free_extent:3061: errno=-2 No such entry
[  104.319480] BTRFS info (device vdb): forced readonly
[  104.321109] BTRFS: error (device vdb) in btrfs_run_delayed_refs:2173: errno=-2 No such entry
[failed, exit status 1] [15:10:54]- output mismatch (see /tmp/fstests/results//btrfs/003.out.bad)
    --- tests/btrfs/003.out	2018-04-12 16:57:00.608225550 +0000
    +++ /tmp/fstests/results//btrfs/003.out.bad	2020-05-18 15:10:54.312000000 +0000
    @@ -1,2 +1,4 @@
     QA output created by 003
    -Silence is golden
    +ERROR: error removing device '/dev/vdg': Read-only file system
    +btrfs device delete failed
    +(see /tmp/fstests/results//btrfs/003.full for details)
    ...
    (Run 'diff -u /tmp/fstests/tests/btrfs/003.out /tmp/fstests/results//btrfs/003.out.bad'  to see the entire diff)
