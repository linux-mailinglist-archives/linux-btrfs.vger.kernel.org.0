Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D411CF6B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgELOPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 10:15:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgELOPR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 10:15:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48B6FACCE
        for <linux-btrfs@vger.kernel.org>; Tue, 12 May 2020 14:15:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A13DBDA70B; Tue, 12 May 2020 16:14:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Bug 5.7-rc: root leak, eb leak
Date:   Tue, 12 May 2020 16:14:23 +0200
Message-Id: <a1b2a3320c72e9bcd355caf93cc72fc093807c67e63be0fd59a5fbc1a3a6587f.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
References: 
MIME-Version: 1.0
Reference: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Root an eb leak.=0D
=0D
Johannes bisected the problem, the first bad commit is one of=0D
=0D
0e996e7fcf2e3a "btrfs: move ino_cache_inode dropping out of btrfs_free_fs_r=
oot"=0D
3fd6372758d91d "btrfs: make the extent buffer leak check per fs info"=0D
8c38938c7bb096 "btrfs: move the root freeing stuff into btrfs_put_root"=0D
=0D
Reproduced on btrfs/028, I was able to reproduce it once on btrfs/125 (log=
=0D
below). This is most likely a regression.=0D
=0D
btrfs/125		[19:31:06][ 7063.961647] run fstests btrfs/125 at 2020-02-21 19:=
31:06=0D
[ 7064.376156] BTRFS info (device vda): disk space caching is enabled=0D
[ 7064.379500] BTRFS info (device vda): has skinny extents=0D
[ 7067.890863] BTRFS: device fsid f88a762d-a155-40a2-b259-1a9331583726 devi=
d 1 transid 5 /dev/vdb scanned by mkfs.btrfs (28576)=0D
[ 7067.895033] BTRFS: device fsid f88a762d-a155-40a2-b259-1a9331583726 devi=
d 2 transid 5 /dev/vdc scanned by mkfs.btrfs (28576)=0D
[ 7067.899388] BTRFS: device fsid f88a762d-a155-40a2-b259-1a9331583726 devi=
d 3 transid 5 /dev/vdd scanned by mkfs.btrfs (28576)=0D
[ 7067.919633] BTRFS info (device vdb): disk space caching is enabled=0D
[ 7067.922349] BTRFS info (device vdb): has skinny extents=0D
[ 7067.924430] BTRFS info (device vdb): flagging fs with big metadata featu=
re=0D
[ 7067.931360] BTRFS info (device vdb): checking UUID tree=0D
[ 7068.117606] BTRFS: device fsid f88a762d-a155-40a2-b259-1a9331583726 devi=
d 2 transid 7 /dev/vdc scanned by mount (28618)=0D
[ 7068.121547] BTRFS: device fsid f88a762d-a155-40a2-b259-1a9331583726 devi=
d 1 transid 7 /dev/vdb scanned by mount (28618)=0D
[ 7068.125450] BTRFS info (device vdb): allowing degraded mounts=0D
[ 7068.127457] BTRFS info (device vdb): disk space caching is enabled=0D
[ 7068.129299] BTRFS info (device vdb): has skinny extents=0D
[ 7068.132805] BTRFS warning (device vdb): devid 3 uuid 9049eb45-e68b-41d4-=
9fa1-e1b0e08fa552 is missing=0D
[ 7068.135869] BTRFS warning (device vdb): devid 3 uuid 9049eb45-e68b-41d4-=
9fa1-e1b0e08fa552 is missing=0D
[ 7070.095641] BTRFS: device fsid cf4bb9b1-6c5c-46d2-8fd6-b9f427137ade devi=
d 1 transid 250 /dev/vda scanned by btrfs (28646)=0D
[ 7070.118262] BTRFS info (device vdb): disk space caching is enabled=0D
[ 7070.120662] BTRFS info (device vdb): has skinny extents=0D
[ 7080.724838] BTRFS info (device vdb): balance: start -d -m -s=0D
[ 7080.733528] BTRFS info (device vdb): relocating block group 217710592 fl=
ags data|raid5=0D
[ 7081.001862] btrfs_print_data_csum_error: 16829 callbacks suppressed=0D
[ 7081.001870] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2228224 csum 0xa9a2deb9 expected csum 0x8941f998 mirror 1=0D
[ 7081.013321] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2236416 csum 0x85a94242 expected csum 0x8941f998 mirror 1=0D
[ 7081.018428] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2240512 csum 0x95ef75cb expected csum 0x8941f998 mirror 1=0D
[ 7081.018843] repair_io_failure: 17181 callbacks suppressed=0D
[ 7081.018847] BTRFS info (device vdb): read error corrected: ino 257 off 2=
236416 (dev /dev/vdd sector 195344)=0D
[ 7081.022838] BTRFS info (device vdb): read error corrected: ino 257 off 2=
228224 (dev /dev/vdd sector 195328)=0D
[ 7081.022915] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2244608 csum 0x4f96cecf expected csum 0x8941f998 mirror 1=0D
[ 7081.023009] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2248704 csum 0xa8fc61d5 expected csum 0x8941f998 mirror 1=0D
[ 7081.023090] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2252800 csum 0xedb728d1 expected csum 0x8941f998 mirror 1=0D
[ 7081.023134] BTRFS info (device vdb): read error corrected: ino 257 off 2=
240512 (dev /dev/vdd sector 195352)=0D
[ 7081.023168] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2256896 csum 0xeb11484f expected csum 0x8941f998 mirror 1=0D
[ 7081.023248] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2260992 csum 0xc31d9456 expected csum 0x8941f998 mirror 1=0D
[ 7081.023324] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2265088 csum 0xff9caf51 expected csum 0x8941f998 mirror 1=0D
[ 7081.023328] BTRFS info (device vdb): read error corrected: ino 257 off 2=
244608 (dev /dev/vdd sector 195360)=0D
[ 7081.023399] BTRFS warning (device vdb): csum failed root -9 ino 257 off =
2269184 csum 0x866f9727 expected csum 0x8941f998 mirror 1=0D
[ 7081.023497] BTRFS info (device vdb): read error corrected: ino 257 off 2=
248704 (dev /dev/vdd sector 195368)=0D
[ 7081.023680] BTRFS info (device vdb): read error corrected: ino 257 off 2=
252800 (dev /dev/vdd sector 195376)=0D
[ 7081.023846] BTRFS info (device vdb): read error corrected: ino 257 off 2=
256896 (dev /dev/vdd sector 195384)=0D
[ 7081.024009] BTRFS info (device vdb): read error corrected: ino 257 off 2=
265088 (dev /dev/vdd sector 195400)=0D
[ 7081.024012] BTRFS info (device vdb): read error corrected: ino 257 off 2=
260992 (dev /dev/vdd sector 195392)=0D
[ 7081.024217] BTRFS info (device vdb): read error corrected: ino 257 off 2=
269184 (dev /dev/vdd sector 195408)=0D
[ 7082.760255] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7082.760267] BTRFS error (device vdb): bad tree block start, want 3907584=
0 have 30556160=0D
[ 7082.764139] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7082.770746] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7082.770769] BTRFS error (device vdb): bad tree block start, want 3907584=
0 have 30556160=0D
[ 7082.773961] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7082.779340] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7082.779357] BTRFS error (device vdb): bad tree block start, want 3907584=
0 have 30556160=0D
[ 7082.782367] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7082.788031] BTRFS error (device vdb): bad tree block start, want 3905945=
6 have 30539776=0D
[ 7084.736674] BTRFS info (device vdb): balance: ended with status: -5=0D
[failed, exit status 1][ 7084.791281] BTRFS info (device vdb): at unmount d=
elalloc count 1994752=0D
[ 7084.891149] ------------[ cut here ]------------=0D
[ 7084.893431] WARNING: CPU: 0 PID: 28679 at fs/btrfs/block-group.c:3367 bt=
rfs_free_block_groups+0x225/0x2b0 [btrfs]=0D
[ 7084.898426] Modules linked in: dm_flakey dm_mod dax btrfs blake2b_generi=
c libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop=0D
[ 7084.904875] CPU: 0 PID: 28679 Comm: umount Not tainted 5.6.0-rc2-default=
+ #1003=0D
[ 7084.908207] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014=0D
[ 7084.912188] RIP: 0010:btrfs_free_block_groups+0x225/0x2b0 [btrfs]=0D
[ 7084.914049] Code: 49 be 22 01 00 00 00 00 ad de e8 66 b5 21 cc e8 e1 3d =
ba cb 48 89 df e8 f9 7e ff ff 48 8b 83 78 12 00 00 49 39 c5 75 4a eb 76 <0f=
> 0b 31 c9 31 d2 4c 89 e6 48 89 df e8 aa 6c ff ff 48 89 ef e8 b2=0D
[ 7084.918227] RSP: 0018:ffffba52492ffdd8 EFLAGS: 00010206=0D
[ 7084.919331] RAX: ffff9a44ecdbd908 RBX: ffff9a44e6a2c000 RCX: 00000000000=
00001=0D
[ 7084.920735] RDX: 0000000000000000 RSI: ffffffffc056ae01 RDI: ffff9a44ecd=
bcc00=0D
[ 7084.922886] RBP: ffff9a44ecdbd908 R08: 0000000000000000 R09: 00000000000=
00000=0D
[ 7084.925048] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9a44ecd=
bd800=0D
[ 7084.927217] R13: ffff9a44e6a2d278 R14: dead000000000122 R15: dead0000000=
00100=0D
[ 7084.929430] FS:  00007f1a27c27800(0000) GS:ffff9a44fe600000(0000) knlGS:=
0000000000000000=0D
[ 7084.932270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[ 7084.934179] CR2: 00007ffdda6eac48 CR3: 0000000018df5001 CR4: 00000000001=
60ef0=0D
[ 7084.935958] Call Trace:=0D
[ 7084.936818]  close_ctree+0x24b/0x2a0 [btrfs]=0D
[ 7084.948688]  generic_shutdown_super+0x69/0x100=0D
[ 7084.950163]  kill_anon_super+0x14/0x30=0D
[ 7084.951525]  btrfs_kill_super+0x12/0x20 [btrfs]=0D
[ 7084.953001]  deactivate_locked_super+0x2c/0x70=0D
[ 7084.954495]  cleanup_mnt+0x100/0x160=0D
[ 7084.955810]  task_work_run+0x90/0xc0=0D
[ 7084.957364]  exit_to_usermode_loop+0x96/0xa0=0D
[ 7084.958890]  do_syscall_64+0x1df/0x210=0D
[ 7084.960255]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=0D
[ 7084.961756] RIP: 0033:0x7f1a27e6a3f7=0D
[ 7084.962903] Code: fa 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 =
00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 fa 0b 00 f7 d8 64 89 01 48=0D
[ 7084.967021] RSP: 002b:00007ffdda6ebc58 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6=0D
[ 7084.968916] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f1a27e=
6a3f7=0D
[ 7084.971111] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005588b93=
1cb70=0D
[ 7084.973181] RBP: 00005588b931c960 R08: 0000000000000000 R09: 00007ffdda6=
ea9d0=0D
[ 7084.975183] R10: 00005588b931cb90 R11: 0000000000000246 R12: 00005588b93=
1cb70=0D
[ 7084.976700] R13: 0000000000000000 R14: 00005588b931ca58 R15: 00000000000=
00000=0D
[ 7084.978291] irq event stamp: 0=0D
[ 7084.979126] hardirqs last  enabled at (0): [<0000000000000000>] 0x0=0D
[ 7084.980404] hardirqs last disabled at (0): [<ffffffff8c07f423>] copy_pro=
cess+0x653/0x1b40=0D
[ 7084.983042] softirqs last  enabled at (0): [<ffffffff8c07f423>] copy_pro=
cess+0x653/0x1b40=0D
[ 7084.985822] softirqs last disabled at (0): [<0000000000000000>] 0x0=0D
[ 7084.987748] ---[ end trace 4ff66fac35aae386 ]---=0D
[ 7084.989590] BTRFS info (device vdb): space_info 1 has 3983872000 free, i=
s not full=0D
[ 7084.992242] BTRFS info (device vdb): space_info total=3D4294967296, used=
=3D212926464, pinned=3D0, reserved=3D0, may_use=3D98168832, readonly=3D0=0D
[ 7084.995211] BTRFS info (device vdb): global_block_rsv: size 0 reserved 0=
=0D
[ 7084.996814] BTRFS info (device vdb): trans_block_rsv: size 0 reserved 0=
=0D
[ 7084.998581] BTRFS info (device vdb): chunk_block_rsv: size 0 reserved 0=
=0D
[ 7084.999979] BTRFS info (device vdb): delayed_block_rsv: size 0 reserved =
0=0D
[ 7085.001941] BTRFS info (device vdb): delayed_refs_rsv: size 0 reserved 0=
=0D
[ 7085.003886] ------------[ cut here ]------------=0D
[ 7085.005362] WARNING: CPU: 0 PID: 28679 at fs/btrfs/block-group.c:3367 bt=
rfs_free_block_groups+0x225/0x2b0 [btrfs]=0D
[ 7085.007985] Modules linked in: dm_flakey dm_mod dax btrfs blake2b_generi=
c libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop=0D
[ 7085.011615] CPU: 0 PID: 28679 Comm: umount Tainted: G        W         5=
.6.0-rc2-default+ #1003=0D
[ 7085.014036] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014=0D
[ 7085.017209] RIP: 0010:btrfs_free_block_groups+0x225/0x2b0 [btrfs]=0D
[ 7085.018961] Code: 49 be 22 01 00 00 00 00 ad de e8 66 b5 21 cc e8 e1 3d =
ba cb 48 89 df e8 f9 7e ff ff 48 8b 83 78 12 00 00 49 39 c5 75 4a eb 76 <0f=
> 0b 31 c9 31 d2 4c 89 e6 48 89 df e8 aa 6c ff ff 48 89 ef e8 b2=0D
[ 7085.024282] RSP: 0018:ffffba52492ffdd8 EFLAGS: 00010206=0D
[ 7085.025741] RAX: ffff9a44ecdbcd08 RBX: ffff9a44e6a2c000 RCX: 00000000001=
70009=0D
[ 7085.027170] RDX: 0000000000000000 RSI: 0000000000170009 RDI: ffffffff8c2=
54b8e=0D
[ 7085.028565] RBP: ffff9a44ecdbcd08 R08: 0000000000000001 R09: 00000000000=
00000=0D
[ 7085.030727] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9a44ecd=
bcc00=0D
[ 7085.032258] R13: ffff9a44e6a2d278 R14: dead000000000122 R15: dead0000000=
00100=0D
[ 7085.033991] FS:  00007f1a27c27800(0000) GS:ffff9a44fe600000(0000) knlGS:=
0000000000000000=0D
[ 7085.035879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[ 7085.037420] CR2: 00007ffdda6eac48 CR3: 0000000018df5001 CR4: 00000000001=
60ef0=0D
[ 7085.039250] Call Trace:=0D
[ 7085.040374]  close_ctree+0x24b/0x2a0 [btrfs]=0D
[ 7085.041745]  generic_shutdown_super+0x69/0x100=0D
[ 7085.042982]  kill_anon_super+0x14/0x30=0D
[ 7085.043963]  btrfs_kill_super+0x12/0x20 [btrfs]=0D
[ 7085.045184]  deactivate_locked_super+0x2c/0x70=0D
[ 7085.046319]  cleanup_mnt+0x100/0x160=0D
[ 7085.047229]  task_work_run+0x90/0xc0=0D
[ 7085.048130]  exit_to_usermode_loop+0x96/0xa0=0D
[ 7085.049689]  do_syscall_64+0x1df/0x210=0D
[ 7085.050849]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=0D
[ 7085.052025] RIP: 0033:0x7f1a27e6a3f7=0D
[ 7085.053230] Code: fa 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 =
00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 fa 0b 00 f7 d8 64 89 01 48=0D
[ 7085.057154] RSP: 002b:00007ffdda6ebc58 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6=0D
[ 7085.059659] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f1a27e=
6a3f7=0D
[ 7085.061346] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005588b93=
1cb70=0D
[ 7085.062762] RBP: 00005588b931c960 R08: 0000000000000000 R09: 00007ffdda6=
ea9d0=0D
[ 7085.064108] R10: 00005588b931cb90 R11: 0000000000000246 R12: 00005588b93=
1cb70=0D
[ 7085.066292] R13: 0000000000000000 R14: 00005588b931ca58 R15: 00000000000=
00000=0D
[ 7085.068449] irq event stamp: 0=0D
[ 7085.069512] hardirqs last  enabled at (0): [<0000000000000000>] 0x0=0D
[ 7085.071228] hardirqs last disabled at (0): [<ffffffff8c07f423>] copy_pro=
cess+0x653/0x1b40=0D
[ 7085.073611] softirqs last  enabled at (0): [<ffffffff8c07f423>] copy_pro=
cess+0x653/0x1b40=0D
[ 7085.076362] softirqs last disabled at (0): [<0000000000000000>] 0x0=0D
[ 7085.077966] ---[ end trace 4ff66fac35aae387 ]---=0D
[ 7085.079100] BTRFS info (device vdb): space_info 4 has 176652288 free, is=
 not full=0D
[ 7085.081031] BTRFS info (device vdb): space_info total=3D178913280, used=
=3D294912, pinned=3D0, reserved=3D0, may_use=3D1703936, readonly=3D262144=0D
[ 7085.083715] BTRFS info (device vdb): global_block_rsv: size 0 reserved 0=
=0D
[ 7085.085270] BTRFS info (device vdb): trans_block_rsv: size 0 reserved 0=
=0D
[ 7085.087169] BTRFS info (device vdb): chunk_block_rsv: size 0 reserved 0=
=0D
[ 7085.088634] BTRFS info (device vdb): delayed_block_rsv: size 0 reserved =
0=0D
[ 7085.090714] BTRFS info (device vdb): delayed_refs_rsv: size 0 reserved 0=
=0D
[ 7085.092457] BTRFS warning (device vdb): page private not zero on page 39=
485440=0D
[ 7085.094946] BTRFS warning (device vdb): page private not zero on page 39=
489536=0D
[ 7085.097735] BTRFS warning (device vdb): page private not zero on page 39=
493632=0D
[ 7085.100235] BTRFS warning (device vdb): page private not zero on page 39=
497728=0D
[ 7085.102806] VFS: Busy inodes after unmount of vdb. Self-destruct in 5 se=
conds.  Have a nice day...=0D
[ 7085.109816] BTRFS error (device vdb): leaked root 18446744073709551607-0=
 refcount 1=0D
[ 7085.112211] ------------[ cut here ]------------=0D
[ 7085.113493] WARNING: CPU: 0 PID: 28679 at fs/btrfs/disk-io.c:2040 btrfs_=
put_root+0x11a/0x130 [btrfs]=0D
[ 7085.115537] Modules linked in: dm_flakey dm_mod dax btrfs blake2b_generi=
c libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop=0D
[ 7085.119049] CPU: 0 PID: 28679 Comm: umount Tainted: G        W         5=
.6.0-rc2-default+ #1003=0D
[ 7085.121446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014=0D
[ 7085.123866] RIP: 0010:btrfs_put_root+0x11a/0x130 [btrfs]=0D
[ 7085.125532] Code: e8 fb a0 2c cc 48 89 ef 5b 5d 41 5c e9 bf fd d8 cb 5b =
be 03 00 00 00 5d 41 5c e9 d1 1d f7 cb c3 e8 cb be da cb e9 3f ff ff ff <0f=
> 0b e9 2a ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00=0D
[ 7085.130769] RSP: 0018:ffffba52492ffe38 EFLAGS: 00010282=0D
[ 7085.132146] RAX: ffff9a44d8ee7720 RBX: ffff9a44e6a2c000 RCX: 00000000000=
00001=0D
[ 7085.134361] RDX: 0000000000000000 RSI: ffffffff8c1015d9 RDI: ffff9a44f9f=
5c828=0D
[ 7085.136552] RBP: ffff9a44f9f5c000 R08: 0000000000000000 R09: 00000000000=
00000=0D
[ 7085.138720] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9a44f9f=
5cb70=0D
[ 7085.140819] R13: ffff9a44f9f5c000 R14: 0000000000000000 R15: ffff9a44df0=
ca388=0D
[ 7085.142991] FS:  00007f1a27c27800(0000) GS:ffff9a44fe600000(0000) knlGS:=
0000000000000000=0D
[ 7085.145164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[ 7085.146560] CR2: 00007ffdda6eac48 CR3: 0000000018df5001 CR4: 00000000001=
60ef0=0D
[ 7085.147920] Call Trace:=0D
[ 7085.148780]  btrfs_check_leaked_roots+0x88/0xa0 [btrfs]=0D
[ 7085.150186]  btrfs_free_fs_info+0xcf/0x100 [btrfs]=0D
[ 7085.151319]  deactivate_locked_super+0x2c/0x70=0D
[ 7085.152361]  cleanup_mnt+0x100/0x160=0D
[ 7085.153533]  task_work_run+0x90/0xc0=0D
[ 7085.154532]  exit_to_usermode_loop+0x96/0xa0=0D
[ 7085.155547]  do_syscall_64+0x1df/0x210=0D
[ 7085.156513]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=0D
[ 7085.157868] RIP: 0033:0x7f1a27e6a3f7=0D
[ 7085.158883] Code: fa 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 =
00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 fa 0b 00 f7 d8 64 89 01 48=0D
[ 7085.162740] RSP: 002b:00007ffdda6ebc58 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6=0D
[ 7085.164658] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f1a27e=
6a3f7=0D
[ 7085.166939] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005588b93=
1cb70=0D
[ 7085.169078] RBP: 00005588b931c960 R08: 0000000000000000 R09: 00007ffdda6=
ea9d0=0D
[ 7085.171238] R10: 00005588b931cb90 R11: 0000000000000246 R12: 00005588b93=
1cb70=0D
[ 7085.173154] R13: 0000000000000000 R14: 00005588b931ca58 R15: 00000000000=
00000=0D
[ 7085.175417] irq event stamp: 0=0D
[ 7085.176768] hardirqs last  enabled at (0): [<0000000000000000>] 0x0=0D
[ 7085.178525] hardirqs last disabled at (0): [<ffffffff8c07f423>] copy_pro=
cess+0x653/0x1b40=0D
[ 7085.180485] softirqs last  enabled at (0): [<ffffffff8c07f423>] copy_pro=
cess+0x653/0x1b40=0D
[ 7085.183751] softirqs last disabled at (0): [<0000000000000000>] 0x0=0D
[ 7085.185701] ---[ end trace 4ff66fac35aae388 ]---=0D
[ 7085.187428] BTRFS: buffer leak start 39485440 len 16384 refs 1 bflags 52=
9 owner 18446744073709551607=0D
 [19:31:27]- output mismatch (see /tmp/fstests/results//btrfs/125.out.bad)=
=0D
    --- tests/btrfs/125.out	2018-04-12 16:57:00.616225550 +0000=0D
    +++ /tmp/fstests/results//btrfs/125.out.bad	2020-02-21 19:31:27.7320000=
00 +0000=0D
    @@ -3,5 +3,5 @@=0D
     Write data with degraded mount=0D
     =0D
     Mount normal and balance=0D
    -=0D
    -Mount degraded but with other dev=0D
    +failed: '/sbin/btrfs balance start /tmp/scratch'=0D
    +(see /tmp/fstests/results//btrfs/125.full for details)=0D
    ...=0D
    (Run 'diff -u /tmp/fstests/tests/btrfs/125.out /tmp/fstests/results//bt=
rfs/125.out.bad'  to see the entire diff)=0D
