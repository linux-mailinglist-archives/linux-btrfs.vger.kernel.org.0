Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B192ECCD1
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 02:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKBBXc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 21:23:32 -0400
Received: from mail.virtall.com ([46.4.129.203]:59948 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfKBBXb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 21:23:31 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 21:23:27 EDT
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 5398337CFA02
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Nov 2019 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1572657243; bh=qFLYRf0YeZoz8jMJF2UrCo/pWZ/6vc3SVuUsi5shpsA=;
        h=Date:From:To:Subject;
        b=dt5CTvCXj66WHwGzLXrh6tXfyKmCAEb5q1SkK+Es5EOiesFTYr9rtUE0VilquP1PV
         PgoGNa5YZUP3dY9pn8dD4sTXLdJQ2i+o08mD/bmoawhOH0ZGVg/BuV2iIkZZjgi7TE
         9hseIUpuNAAJt1g6komNYHounQF2VzKmw2llVxOM4DnTyzjKwNnv8cILAmfSPOJBLf
         ZjvLlwelRz/Ez2ZCEwtgTd9RdAt2mJFXR6F7FduvgJxdZa4P6OrxzP9z7fQkI442DH
         2tboA/UE1CVCO+9DgZsnJKBWUZFZWKPp005iaHpYQ7OJhtxPsNvSDnGfe/Y5xlduLj
         AVcpf1VRW+TmA==
X-Fuglu-Suspect: 7c373195505f4751b4ef61ecb301da54
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Nov 2019 01:14:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 02 Nov 2019 10:13:56 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     linux-btrfs@vger.kernel.org
Subject: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
 btrfs_update_device.cold+0x10/0x1b [btrfs]
Message-ID: <0a25bc52b9d3649d499b76d06e0d117b@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm getting these recently from time to time (first noticed in 5.3.x, 
but maybe they were showing up before and I didn't notice).

Everything seems to work fine so far. Anything to worry about?

# btrfs fi usage /home
Overall:
     Device size:                   7.19TiB
     Device allocated:              1.19TiB
     Device unallocated:            6.00TiB
     Device missing:                  0.00B
     Used:                          1.17TiB
     Free (estimated):              3.00TiB      (min: 3.00TiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:537.00GiB, Used:536.08GiB
    /dev/sda4     537.00GiB
    /dev/sdb4     537.00GiB

Metadata,RAID1: Size:72.00GiB, Used:61.47GiB
    /dev/sda4      72.00GiB
    /dev/sdb4      72.00GiB

System,RAID1: Size:32.00MiB, Used:112.00KiB
    /dev/sda4      32.00MiB
    /dev/sdb4      32.00MiB

Unallocated:
    /dev/sda4       3.00TiB
    /dev/sdb4       3.00TiB


# btrfs fi df /home
Data, RAID1: total=537.00GiB, used=536.08GiB
System, RAID1: total=32.00MiB, used=112.00KiB
Metadata, RAID1: total=72.00GiB, used=61.47GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


# btrfs fi show /home
Label: 'btrfs'  uuid: c94ea4a9-6d10-4e78-9b4a-ffe664386af2
         Total devices 2 FS bytes used 597.56GiB
         devid    2 size 3.59TiB used 609.03GiB path /dev/sda4
         devid    3 size 3.59TiB used 609.03GiB path /dev/sdb4


[20419.701419] ------------[ cut here ]------------
[20419.701546] WARNING: CPU: 3 PID: 9489 at fs/btrfs/ctree.h:1593 
btrfs_update_device.cold+0x10/0x1b [btrfs]
[20419.701548] Modules linked in: nf_conntrack_netlink xt_conntrack 
nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtables 
binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE 
xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter 
bridge stp llc unix_diag intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw 
intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables 
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
multipath linear raid1 e1000e psmouse ahci libahci wmi video
[20419.701602] CPU: 3 PID: 9489 Comm: storagenode Not tainted 
5.3.8-050308-generic #201910290940
[20419.701605] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12 
R1.18.0.SR.1 for D3401-H2x               07/02/2018
[20419.701672] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
[20419.701676] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8 
0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2 
ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
[20419.701679] RSP: 0018:ffffa89400903a60 EFLAGS: 00010246
[20419.701683] RAX: 0000000000000024 RBX: ffff90bd80633800 RCX: 
0000000000000000
[20419.701685] RDX: 0000000000000000 RSI: ffff90bd8e2d7448 RDI: 
ffff90bd8e2d7448
[20419.701687] RBP: ffffa89400903ab0 R08: ffff90bd8e2d7448 R09: 
0000000000000004
[20419.701688] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff90bce73397e0
[20419.701690] R13: 0000000000000000 R14: 0000000000003f3c R15: 
ffff90bcd7a995a8
[20419.701694] FS:  00007fd22268df20(0000) GS:ffff90bd8e2c0000(0000) 
knlGS:0000000000000000
[20419.701696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[20419.701698] CR2: 00007fd2229f1010 CR3: 0000000767104004 CR4: 
00000000003606e0
[20419.701700] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[20419.701702] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[20419.701704] Call Trace:
[20419.701770]  btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
[20419.701807]  ? btrfs_insert_item+0x7f/0xf0 [btrfs]
[20419.701846]  btrfs_create_pending_block_groups+0xeb/0x220 [btrfs]
[20419.701893]  __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
[20419.701936]  btrfs_end_transaction+0x10/0x20 [btrfs]
[20419.701995]  btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]
[20419.702052]  btrfs_check_data_free_space+0x59/0xb0 [btrfs]
[20419.702099]  btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
[20419.702108]  ? inet6_recvmsg+0x5e/0xf0
[20419.702154]  btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
[20419.702162]  new_sync_write+0x125/0x1c0
[20419.702168]  __vfs_write+0x29/0x40
[20419.702173]  vfs_write+0xb9/0x1a0
[20419.702178]  ksys_write+0x67/0xe0
[20419.702183]  __x64_sys_write+0x1a/0x20
[20419.702190]  do_syscall_64+0x5a/0x130
[20419.702196]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[20419.702200] RIP: 0033:0x47f050
[20419.702204] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2 
00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f 
05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[20419.702206] RSP: 002b:000000c00054f260 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[20419.702210] RAX: ffffffffffffffda RBX: 000000c000044500 RCX: 
000000000047f050
[20419.702212] RDX: 0000000000040000 RSI: 000000c0006f0000 RDI: 
0000000000000026
[20419.702214] RBP: 000000c00054f2b0 R08: 0000000000000000 R09: 
0000000000000000
[20419.702216] R10: 0000000000000000 R11: 0000000000000202 R12: 
ffea2367ffa35605
[20419.702218] R13: 0000000000000006 R14: 000000001a4c0b00 R15: 
ffffffffe743d8bf
[20419.702222] ---[ end trace 77f3c728fd91fa16 ]---
[20419.702282] ------------[ cut here ]------------
[20419.702382] WARNING: CPU: 3 PID: 9489 at fs/btrfs/ctree.h:1593 
btrfs_update_device.cold+0x10/0x1b [btrfs]
[20419.702383] Modules linked in: nf_conntrack_netlink xt_conntrack 
nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtables 
binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE 
xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter 
bridge stp llc unix_diag intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw 
intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables 
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
multipath linear raid1 e1000e psmouse ahci libahci wmi video
[20419.702429] CPU: 3 PID: 9489 Comm: storagenode Tainted: G        W    
      5.3.8-050308-generic #201910290940
[20419.702431] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12 
R1.18.0.SR.1 for D3401-H2x               07/02/2018
[20419.702492] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
[20419.702497] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8 
0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2 
ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
[20419.702499] RSP: 0018:ffffa89400903a60 EFLAGS: 00010246
[20419.702502] RAX: 0000000000000024 RBX: ffff90bd80636000 RCX: 
0000000000000006
[20419.702503] RDX: 0000000000000000 RSI: 0000000000000086 RDI: 
ffff90bd8e2d7440
[20419.702505] RBP: ffffa89400903ab0 R08: 0000000000000357 R09: 
0000000000000004
[20419.702507] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff90bce73397e0
[20419.702509] R13: 0000000000000000 R14: 0000000000003f9e R15: 
ffff90bcd7a995a8
[20419.702512] FS:  00007fd22268df20(0000) GS:ffff90bd8e2c0000(0000) 
knlGS:0000000000000000
[20419.702514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[20419.702516] CR2: 00007fd2229f1010 CR3: 0000000767104004 CR4: 
00000000003606e0
[20419.702519] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[20419.702521] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[20419.702522] Call Trace:
[20419.702582]  btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
[20419.702623]  btrfs_create_pending_block_groups+0xeb/0x220 [btrfs]
[20419.702667]  __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
[20419.702708]  btrfs_end_transaction+0x10/0x20 [btrfs]
[20419.702765]  btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]
[20419.702820]  btrfs_check_data_free_space+0x59/0xb0 [btrfs]
[20419.702866]  btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
[20419.702874]  ? inet6_recvmsg+0x5e/0xf0
[20419.702920]  btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
[20419.702927]  new_sync_write+0x125/0x1c0
[20419.702932]  __vfs_write+0x29/0x40
[20419.702937]  vfs_write+0xb9/0x1a0
[20419.702942]  ksys_write+0x67/0xe0
[20419.702947]  __x64_sys_write+0x1a/0x20
[20419.702952]  do_syscall_64+0x5a/0x130
[20419.702958]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[20419.702961] RIP: 0033:0x47f050
[20419.702965] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2 
00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f 
05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[20419.702967] RSP: 002b:000000c00054f260 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[20419.702970] RAX: ffffffffffffffda RBX: 000000c000044500 RCX: 
000000000047f050
[20419.702972] RDX: 0000000000040000 RSI: 000000c0006f0000 RDI: 
0000000000000026
[20419.702974] RBP: 000000c00054f2b0 R08: 0000000000000000 R09: 
0000000000000000
[20419.702976] R10: 0000000000000000 R11: 0000000000000202 R12: 
ffea2367ffa35605
[20419.702978] R13: 0000000000000006 R14: 000000001a4c0b00 R15: 
ffffffffe743d8bf
[20419.702982] ---[ end trace 77f3c728fd91fa17 ]---
[32358.499676] ------------[ cut here ]------------
[32358.499794] WARNING: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593 
btrfs_update_device.cold+0x10/0x1b [btrfs]
[32358.499796] Modules linked in: nf_conntrack_netlink xt_conntrack 
nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtables 
binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE 
xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter 
bridge stp llc unix_diag intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw 
intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables 
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
multipath linear raid1 e1000e psmouse ahci libahci wmi video
[32358.499851] CPU: 6 PID: 13386 Comm: kworker/u16:0 Tainted: G        W 
         5.3.8-050308-generic #201910290940
[32358.499853] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12 
R1.18.0.SR.1 for D3401-H2x               07/02/2018
[32358.499914] Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
[32358.499981] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
[32358.500002] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8 
0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2 
ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
[32358.500004] RSP: 0018:ffffa89400e33940 EFLAGS: 00010246
[32358.500007] RAX: 0000000000000024 RBX: ffff90bd80633800 RCX: 
0000000000000000
[32358.500009] RDX: 0000000000000000 RSI: ffff90bd8e397448 RDI: 
ffff90bd8e397448
[32358.500011] RBP: ffffa89400e33990 R08: ffff90bd8e397448 R09: 
0000000000000004
[32358.500012] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff90bb94f828c0
[32358.500014] R13: 0000000000000000 R14: 0000000000003f3c R15: 
ffff90bb53dbbad0
[32358.500017] FS:  0000000000000000(0000) GS:ffff90bd8e380000(0000) 
knlGS:0000000000000000
[32358.500019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32358.500020] CR2: 00007f3a0089eb02 CR3: 00000003b4e0a004 CR4: 
00000000003606e0
[32358.500022] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[32358.500024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[32358.500026] Call Trace:
[32358.500080]  btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
[32358.500111]  ? btrfs_insert_item+0x7f/0xf0 [btrfs]
[32358.500160]  btrfs_create_pending_block_groups+0xeb/0x220 [btrfs]
[32358.500218]  __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
[32358.500258]  btrfs_end_transaction+0x10/0x20 [btrfs]
[32358.500299]  find_free_extent+0xb40/0xdf0 [btrfs]
[32358.500307]  ? generic_make_request+0xcf/0x320
[32358.500340]  btrfs_reserve_extent+0xe9/0x180 [btrfs]
[32358.500376]  cow_file_range.isra.0+0x178/0x440 [btrfs]
[32358.500412]  submit_compressed_extents+0x1a4/0x430 [btrfs]
[32358.500445]  async_cow_submit+0x75/0x80 [btrfs]
[32358.500491]  normal_work_helper+0x19e/0x2f0 [btrfs]
[32358.500535]  btrfs_delalloc_helper+0x12/0x20 [btrfs]
[32358.500541]  process_one_work+0x1db/0x380
[32358.500544]  worker_thread+0x4d/0x400
[32358.500550]  kthread+0x104/0x140
[32358.500554]  ? process_one_work+0x380/0x380
[32358.500558]  ? kthread_park+0x80/0x80
[32358.500564]  ret_from_fork+0x35/0x40
[32358.500569] ---[ end trace 77f3c728fd91fa18 ]---
[32358.500618] ------------[ cut here ]------------
[32358.500701] WARNING: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593 
btrfs_update_device.cold+0x10/0x1b [btrfs]
[32358.500702] Modules linked in: nf_conntrack_netlink xt_conntrack 
nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtables 
binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE 
xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter 
bridge stp llc unix_diag intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw 
intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables 
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
multipath linear raid1 e1000e psmouse ahci libahci wmi video
[32358.500743] CPU: 6 PID: 13386 Comm: kworker/u16:0 Tainted: G        W 
         5.3.8-050308-generic #201910290940
[32358.500745] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12 
R1.18.0.SR.1 for D3401-H2x               07/02/2018
[32358.500792] Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
[32358.500849] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
[32358.500852] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8 
0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2 
ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
[32358.500854] RSP: 0018:ffffa89400e33940 EFLAGS: 00010246
[32358.500857] RAX: 0000000000000024 RBX: ffff90bd80636000 RCX: 
0000000000000006
[32358.500859] RDX: 0000000000000000 RSI: 0000000000000082 RDI: 
ffff90bd8e397440
[32358.500860] RBP: ffffa89400e33990 R08: 00000000000003ab R09: 
0000000000000004
[32358.500862] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff90bb94f828c0
[32358.500864] R13: 0000000000000000 R14: 0000000000003f9e R15: 
ffff90bb53dbbad0
[32358.500866] FS:  0000000000000000(0000) GS:ffff90bd8e380000(0000) 
knlGS:0000000000000000
[32358.500868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32358.500870] CR2: 00007f3a0089eb02 CR3: 00000003b4e0a004 CR4: 
00000000003606e0
[32358.500872] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[32358.500873] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[32358.500875] Call Trace:
[32358.500922]  btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
[32358.500955]  btrfs_create_pending_block_groups+0xeb/0x220 [btrfs]
[32358.501009]  __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
[32358.501046]  btrfs_end_transaction+0x10/0x20 [btrfs]
[32358.501079]  find_free_extent+0xb40/0xdf0 [btrfs]
[32358.501084]  ? generic_make_request+0xcf/0x320
[32358.501118]  btrfs_reserve_extent+0xe9/0x180 [btrfs]
[32358.501159]  cow_file_range.isra.0+0x178/0x440 [btrfs]
[32358.501199]  submit_compressed_extents+0x1a4/0x430 [btrfs]
[32358.501238]  async_cow_submit+0x75/0x80 [btrfs]
[32358.501286]  normal_work_helper+0x19e/0x2f0 [btrfs]
[32358.501334]  btrfs_delalloc_helper+0x12/0x20 [btrfs]
[32358.501338]  process_one_work+0x1db/0x380
[32358.501342]  worker_thread+0x4d/0x400
[32358.501348]  kthread+0x104/0x140
[32358.501352]  ? process_one_work+0x380/0x380
[32358.501357]  ? kthread_park+0x80/0x80
[32358.501362]  ret_from_fork+0x35/0x40
[32358.501366] ---[ end trace 77f3c728fd91fa19 ]---
[49906.088064] ------------[ cut here ]------------
[49906.088197] WARNING: CPU: 5 PID: 9511 at fs/btrfs/ctree.h:1593 
btrfs_update_device.cold+0x10/0x1b [btrfs]
[49906.088199] Modules linked in: nf_conntrack_netlink xt_conntrack 
nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtables 
binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE 
xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter 
bridge stp llc unix_diag intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw 
intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables 
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
multipath linear raid1 e1000e psmouse ahci libahci wmi video
[49906.088254] CPU: 5 PID: 9511 Comm: storagenode Tainted: G        W    
      5.3.8-050308-generic #201910290940
[49906.088256] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12 
R1.18.0.SR.1 for D3401-H2x               07/02/2018
[49906.088323] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
[49906.088328] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8 
0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2 
ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
[49906.088331] RSP: 0018:ffffa89401233a60 EFLAGS: 00010246
[49906.088335] RAX: 0000000000000024 RBX: ffff90bd80633800 RCX: 
0000000000000000
[49906.088337] RDX: 0000000000000000 RSI: ffff90bd8e357448 RDI: 
ffff90bd8e357448
[49906.088338] RBP: ffffa89401233ab0 R08: ffff90bd8e357448 R09: 
0000000000000004
[49906.088340] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff90bb5373a2a0
[49906.088342] R13: 0000000000000000 R14: 0000000000003f3c R15: 
ffff90bb42780840
[49906.088345] FS:  00007fd22258ff20(0000) GS:ffff90bd8e340000(0000) 
knlGS:0000000000000000
[49906.088348] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[49906.088350] CR2: 00007f8cf3721180 CR3: 0000000767104001 CR4: 
00000000003606e0
[49906.088352] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[49906.088354] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[49906.088356] Call Trace:
[49906.088422]  btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
[49906.088460]  ? btrfs_insert_item+0x7f/0xf0 [btrfs]
[49906.088500]  btrfs_create_pending_block_groups+0xeb/0x220 [btrfs]
[49906.088547]  __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
[49906.088590]  btrfs_end_transaction+0x10/0x20 [btrfs]
[49906.088649]  btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]
[49906.088706]  btrfs_check_data_free_space+0x59/0xb0 [btrfs]
[49906.088754]  btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
[49906.088763]  ? inet6_recvmsg+0x5e/0xf0
[49906.088811]  btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
[49906.088819]  new_sync_write+0x125/0x1c0
[49906.088824]  __vfs_write+0x29/0x40
[49906.088829]  vfs_write+0xb9/0x1a0
[49906.088834]  ksys_write+0x67/0xe0
[49906.088839]  __x64_sys_write+0x1a/0x20
[49906.088846]  do_syscall_64+0x5a/0x130
[49906.088852]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[49906.088855] RIP: 0033:0x47f050
[49906.088860] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2 
00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f 
05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[49906.088862] RSP: 002b:000000c00034b260 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[49906.088866] RAX: ffffffffffffffda RBX: 000000c000048f00 RCX: 
000000000047f050
[49906.088867] RDX: 0000000000040000 RSI: 000000c00077e000 RDI: 
0000000000000026
[49906.088869] RBP: 000000c00034b2b0 R08: 0000000000000000 R09: 
0000000000000000
[49906.088871] R10: 0000000000000000 R11: 0000000000000202 R12: 
ffffe7dcdd518784
[49906.088873] R13: 0000000000000002 R14: 00000000078dfd25 R15: 
00000000073b9ee2
[49906.088878] ---[ end trace 77f3c728fd91fa1a ]---
[49906.088930] ------------[ cut here ]------------
[49906.089028] WARNING: CPU: 5 PID: 9511 at fs/btrfs/ctree.h:1593 
btrfs_update_device.cold+0x10/0x1b [btrfs]
[49906.089029] Modules linked in: nf_conntrack_netlink xt_conntrack 
nfnetlink xfrm_user xfrm_algo xt_addrtype xt_nat ebtable_filter ebtables 
binfmt_misc veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE 
xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter 
bridge stp llc unix_diag intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 
crypto_simd cryptd glue_helper intel_cstate intel_rapl_perf serio_raw 
intel_pch_thermal mac_hid acpi_pad sch_fq_codel ip_tables x_tables 
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 
multipath linear raid1 e1000e psmouse ahci libahci wmi video
[49906.089075] CPU: 5 PID: 9511 Comm: storagenode Tainted: G        W    
      5.3.8-050308-generic #201910290940
[49906.089077] Hardware name: FUJITSU /D3401-H2, BIOS V5.0.0.12 
R1.18.0.SR.1 for D3401-H2x               07/02/2018
[49906.089139] RIP: 0010:btrfs_update_device.cold+0x10/0x1b [btrfs]
[49906.089143] Code: 00 48 c7 c7 b8 06 30 c0 48 8b 50 70 48 8d 48 70 e8 
0a 07 a2 ee e9 1d 76 f9 ff 48 c7 c7 f8 06 30 c0 48 89 4d b0 e8 f5 06 a2 
ee <0f> 0b 48 8b 4d b0 e9 2b 7b f9 ff 41 89 c6 e9 98 7e f9 ff 4c 89 ef
[49906.089145] RSP: 0018:ffffa89401233a60 EFLAGS: 00010246
[49906.089148] RAX: 0000000000000024 RBX: ffff90bd80636000 RCX: 
0000000000000006
[49906.089150] RDX: 0000000000000000 RSI: 0000000000000086 RDI: 
ffff90bd8e357440
[49906.089152] RBP: ffffa89401233ab0 R08: 00000000000003ff R09: 
0000000000000004
[49906.089154] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff90bb5373a2a0
[49906.089155] R13: 0000000000000000 R14: 0000000000003f9e R15: 
ffff90bb42780840
[49906.089159] FS:  00007fd22258ff20(0000) GS:ffff90bd8e340000(0000) 
knlGS:0000000000000000
[49906.089161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[49906.089163] CR2: 00007f8cf3721180 CR3: 0000000767104001 CR4: 
00000000003606e0
[49906.089165] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[49906.089167] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[49906.089168] Call Trace:
[49906.089227]  btrfs_finish_chunk_alloc+0x119/0x470 [btrfs]
[49906.089268]  btrfs_create_pending_block_groups+0xeb/0x220 [btrfs]
[49906.089312]  __btrfs_end_transaction+0x6a/0x1b0 [btrfs]
[49906.089353]  btrfs_end_transaction+0x10/0x20 [btrfs]
[49906.089409]  btrfs_alloc_data_chunk_ondemand+0xe9/0x350 [btrfs]
[49906.089464]  btrfs_check_data_free_space+0x59/0xb0 [btrfs]
[49906.089511]  btrfs_buffered_write.isra.0+0x1b2/0x770 [btrfs]
[49906.089519]  ? inet6_recvmsg+0x5e/0xf0
[49906.089565]  btrfs_file_write_iter+0x3f3/0x5a0 [btrfs]
[49906.089571]  new_sync_write+0x125/0x1c0
[49906.089577]  __vfs_write+0x29/0x40
[49906.089581]  vfs_write+0xb9/0x1a0
[49906.089586]  ksys_write+0x67/0xe0
[49906.089592]  __x64_sys_write+0x1a/0x20
[49906.089597]  do_syscall_64+0x5a/0x130
[49906.089603]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[49906.089606] RIP: 0033:0x47f050
[49906.089610] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2 
00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f 
05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[49906.089612] RSP: 002b:000000c00034b260 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[49906.089615] RAX: ffffffffffffffda RBX: 000000c000048f00 RCX: 
000000000047f050
[49906.089617] RDX: 0000000000040000 RSI: 000000c00077e000 RDI: 
0000000000000026
[49906.089619] RBP: 000000c00034b2b0 R08: 0000000000000000 R09: 
0000000000000000
[49906.089621] R10: 0000000000000000 R11: 0000000000000202 R12: 
ffffe7dcdd518784
[49906.089623] R13: 0000000000000002 R14: 00000000078dfd25 R15: 
00000000073b9ee2
[49906.089627] ---[ end trace 77f3c728fd91fa1b ]---


Tomasz Chmielewski
https://lxadm.com
