Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27128F3FB6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 06:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfKHFVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 00:21:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:34245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfKHFVJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 00:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573190466;
        bh=MtXAft+ved5zLoaw8tDqGLeJGzM1fIFSPEzqK5CBpbM=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=DdjLY7zodjqKnjXSidzGY99j90PZQwcaKCk+qsnD7/cJg8diNB/r0t9+tuyF9Qpvx
         QRbV3hHDVMdPE/l1PrBCXBHgJNW8JbrdRhr0h+8TBofaNR/8zqKeT8WyJT8/rdsjF2
         O3wupX+ghxV8NffU7LX6meoUJ8ouiNjnRLs3QZYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.164] ([129.146.172.218]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1hclUY1hCt-00ro7L; Fri, 08
 Nov 2019 06:21:06 +0100
From:   Su Yue <Damenly_Su@gmx.com>
Subject: [BUG report] KASAN: null-ptr-deref in btrfs_sync_log
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Su Yue <Damenly_Su@gmx.com>
Message-ID: <dd9f22ee-e73c-7476-82d1-45a10d1f16f9@gmx.com>
Date:   Fri, 8 Nov 2019 13:21:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K+eDWQIx7x2bzuJmZHqMPSaFBytMmD8nYJK4cpbxLt4+1Sb7mV4
 jflmvkZly5lsZolTtwA/2N8voBX9DuiOqpsUu6KKqHguH3RluO60x5hSif7+FYM5Z8gbtSP
 +Jz3bUBR0LBCd9R0pYea1AQot+INryb2zflqxufYNy7BIOl/iK3SFYU1oZCpSIghgA0OW7F
 Cj17+6mW3n55AEufqb8mQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SFUJs/fS1bM=:qS85otUdh3jeRiV7N2wEub
 NV6pnpsQPIaNHtud0jxAunQ7qjokvOcf/LHFLDV8uZoH3hqGVU1iDljnhcWwLHOgmj1gLBwbP
 o0joKDA4r/WTfsjqX+8XSbX9z2ojFQG8gH0lbLOf9pM6XsndT8C54XKQBiZMRDDnRtdFi/xdR
 elBv7dGhMmpnAJICWnwSFY2e0YrH5DQbLKOAC5v1nRIP3BAHFE8GHZiU4dGcObyQ48hfqIkcQ
 gYQ+LA59ag6DzSfGNYXVpMG/L7l/6zeL6iPLLSRMC8lQkJUgaVeWlPfMuMKepN8tkav52sElQ
 CuB/4G0y1J2GL6z1kvpQOv4cy9S51US75bWOuRpcycpgmPbnqK8RhMEdeh1JaFcPlod+9Kkhf
 fQeus/4l64hwMwbblBhk8YLax4G4bVginw8ud9pDSNfuArj2UePodZQ9NriKgUKQvPRJhOmcz
 Y3funPQmOeKQyXnZU16zP9KuNLFB1aA8PZ2QxNQDsp+N+Fy7ypppnZdRPCxU13FPuLp6odkMo
 8ug1gnwUkCpCNDIgVLzSE2umMhgW8z3t1Tr+qAfcjEzlS8fL9blYHq3quIi6EQ0kReTaCPRKl
 roDPQIuQ9MSnWAbqYbONVtcHPGNSq69QmWUgF4fK07QBCYotqSH+wMOyD2loAdb2T9jGKa5KS
 oCug2HjRShQ1KF94LkaJ/5nuT0oOwP9QlMdYUYLivAe92KyuNZeLZpHM2tMTz+09lJlWI20MU
 u9Xw/zniIf7oaIIyuIsqvwN3KE0da83TjDX/RRtl4pn9/JOJjVS4613bmX/ylBQPB25v94Jb1
 gaPfOCtNbILhplRSLAIreiyhL1gcyY6sapZqf7qPXFSsfVXtalS+yzEdX9T9i6myKi3N7Ed+v
 exW045dTfowN7J5ZdBJ1Wq9fX/OqW7OeMjpyPBoe+7UONH9LOXLYlsvugGMhU3MIR/o72SoSC
 bhZuofOTotqNT2mJOzTs+BCkejtKjvvoT0ejL68wsyHYoHaciti5/Tu990ox5sRLbXGFjoyU/
 jWj/QsSfu1Nc617bJQ4jq1YOIYpTJQ/v9ro8E+HgIIiZhjA/dBGmEDbcDwUyqgOtPyfLGlQv3
 IIlIZM9FCgAuxb23Z1CLUR6VSbjXpmZ6dvdOYWuKsSco43M1vf2y542ppDDY8YnqlMK/eFuXn
 ir38cEOOpMyXDC6crHTHM0o7vX7yzz6Xn2plX4uKjw0iz0m1NKPr0szipRSt0ka0ojfP3172H
 TQVOqabhDXQRnUKRR1/CDe8lnmCsSXE+8qovn5uVL0z2tcQIp6m7O1Eec9u8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

While running xfstests/btrfs/004 and btrfs/067 whith KASAN enabled
on v5.4-rc6, KASAN reports following BUG(btrfs/004):

==================================================================
[  681.583782] BUG: KASAN: null-ptr-deref in btrfs_sync_log+0x77c/0x1200
[btrfs]
[  681.585752] Write of size 8 at addr 0000000000000008 by task
fsstress/44351

[  681.588201] CPU: 6 PID: 44351 Comm: fsstress Kdump: loaded Not
tainted 5.4.0-rc6-custom #18
[  681.589903] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
?-20191013_105130-anatol 04/01/2014
[  681.592284] Call Trace:
[  681.592904]  dump_stack+0xa4/0xfa
[  681.593825]  ? btrfs_sync_log+0x77c/0x1200 [btrfs]
[  681.595048]  __kasan_report.cold+0x5/0x41
[  681.596135]  ? btrfs_sync_log+0x77c/0x1200 [btrfs]
[  681.597139]  kasan_report+0x12/0x20
[  681.598054]  __asan_store8+0x57/0x90
[  681.599028]  btrfs_sync_log+0x77c/0x1200 [btrfs]
[  681.600291]  ? btrfs_log_inode_parent+0x1440/0x1440 [btrfs]
[  681.601662]  ? 0xffffffffa0000000
[  681.602561]  ? mark_lock+0xaf/0xab0
[  681.603687]  ? dput+0xdd/0x600
[  681.604595]  ? __kasan_check_write+0x14/0x20
[  681.605732]  ? up_write+0xe5/0x290
[  681.606752]  btrfs_sync_file+0x56e/0x7c0 [btrfs]
[  681.608084]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
[  681.609482]  ? __do_sys_newstat+0xad/0x100
[  681.610559]  ? cp_new_stat+0x310/0x310
[  681.611614]  vfs_fsync_range+0x6d/0x110
[  681.612714]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
[  681.613732]  do_fsync+0x3d/0x70
[  681.614281]  __x64_sys_fsync+0x21/0x30
[  681.614934]  do_syscall_64+0x79/0xe0
[  681.615554]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  681.616405] RIP: 0033:0x7fe6d8d33bd7
[  681.617011] Code: ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 4a 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 03 f7 ff ff
[  681.620086] RSP: 002b:00007ffe4f9a8ff8 EFLAGS: 00000246 ORIG_RAX:
000000000000004a
[  681.621350] RAX: ffffffffffffffda RBX: 000055b5c5a15520 RCX:
00007fe6d8d33bd7
[  681.622533] RDX: 00007ffe4f9a8f50 RSI: 00007ffe4f9a8f50 RDI:
0000000000000003
[  681.623711] RBP: 0000000000000003 R08: 0000000000000001 R09:
00007ffe4f9a900c
[  681.624901] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000243
[  681.626079] R13: 00007ffe4f9a9050 R14: 00007ffe4f9a90e6 R15:
000055b5c5a06760
[  681.627289]
==================================================================
[  681.628487] Disabling lock debugging due to kernel taint
[  681.629463] BUG: kernel NULL pointer dereference, address:
0000000000000008
[  681.630933] #PF: supervisor write access in kernel mode
[  681.632013] #PF: error_code(0x0002) - not-present page
[  681.632856] PGD 0 P4D 0
[  681.633247] Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
[  681.633963] CPU: 6 PID: 44351 Comm: fsstress Kdump: loaded Tainted: G
    B             5.4.0-rc6-custom #18
[  681.635365] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
?-20191013_105130-anatol 04/01/2014
[  681.636538] RIP: 0010:btrfs_sync_log+0x77c/0x1200 [btrfs]
[  681.637182] Code: 89 fc 4d 8d 44 24 20 4c 89 4c 24 78 4c 89 c7 4c 89
84 24 80 00 00 00 e8 72 fa da df 4d 8b 7c 24 20 48 8d 7b 08 e8 f4 fa da
df <4c> 89 7b 08 4c 89 ff e8 e8 fa da df 49 89 1f 4c 8b 4c 24 78 4c 89
[  681.639367] RSP: 0018:ffff8884245ef970 EFLAGS: 00010217
[  681.639987] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[  681.640910] RDX: 0000000000000001 RSI: 0000000000000004 RDI:
ffffffffa3240820
[  681.641993] RBP: ffff8884245efd10 R08: ffffffffa012b3c8 R09:
fffffbfff437c161
[  681.643054] R10: fffffbfff437c160 R11: ffffffffa1be0b03 R12:
ffff8884245efae0
[  681.644014] R13: ffffffffffffffe8 R14: ffff8884245efaf8 R15:
0000000000000000
[  681.644953] FS:  00007fe6d8b57b80(0000) GS:ffff88843f800000(0000)
knlGS:0000000000000000
[  681.645998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  681.646756] CR2: 0000000000000008 CR3: 00000004341fc000 CR4:
00000000003406e0
[  681.647681] Call Trace:
[  681.648083]  ? btrfs_log_inode_parent+0x1440/0x1440 [btrfs]
[  681.648805]  ? 0xffffffffa0000000
[  681.649235]  ? mark_lock+0xaf/0xab0
[  681.649725]  ? dput+0xdd/0x600
[  681.650125]  ? __kasan_check_write+0x14/0x20
[  681.650671]  ? up_write+0xe5/0x290
[  681.651170]  btrfs_sync_file+0x56e/0x7c0 [btrfs]
[  681.651820]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
[  681.652544]  ? __do_sys_newstat+0xad/0x100
[  681.653111]  ? cp_new_stat+0x310/0x310
[  681.653638]  vfs_fsync_range+0x6d/0x110
[  681.654178]  ? btrfs_file_write_iter+0x920/0x920 [btrfs]
[  681.654896]  do_fsync+0x3d/0x70
[  681.655337]  __x64_sys_fsync+0x21/0x30
[  681.655867]  do_syscall_64+0x79/0xe0
[  681.656361]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  681.657025] RIP: 0033:0x7fe6d8d33bd7
[  681.657511] Code: ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 4a 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 03 f7 ff ff
[  681.660006] RSP: 002b:00007ffe4f9a8ff8 EFLAGS: 00000246 ORIG_RAX:
000000000000004a
[  681.661052] RAX: ffffffffffffffda RBX: 000055b5c5a15520 RCX:
00007fe6d8d33bd7
[  681.662009] RDX: 00007ffe4f9a8f50 RSI: 00007ffe4f9a8f50 RDI:
0000000000000003
[  681.662962] RBP: 0000000000000003 R08: 0000000000000001 R09:
00007ffe4f9a900c
[  681.663920] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000243
[  681.664888] R13: 00007ffe4f9a9050 R14: 00007ffe4f9a90e6 R15:
000055b5c5a06760
[  681.665841] Modules linked in: mousedev nls_iso8859_1 nls_cp437 vfat
fat snd_hda_codec_generic crct10dif_pclmul input_leds led_class
crc32_pclmul ghash_clmulni_intel psmouse snd_hda_intel snd_intel_nhlt
snd_hda_codec snd_hwdep snd_hda_core iTCO_wdt iTCO_vendor_support
snd_pcm snd_timer snd aesni_intel glue_helper soundcore crypto_simd
lpc_ich i2c_i801 cryptd pcspkr intel_agp intel_gtt evdev agpgart mac_hid
rtc_cmos qemu_fw_cfg ip_tables x_tables xfs btrfs xor zstd_decompress
zstd_compress raid6_pq sr_mod cdrom sd_mod dm_mod virtio_rng
virtio_balloon virtio_blk virtio_console virtio_scsi rng_core virtio_net
net_failover failover ahci libahci libata crc32c_intel scsi_mod
serio_raw atkbd virtio_pci virtio_ring libps2 virtio i8042 serio
[  681.674563] CR2: 0000000000000008
[  681.675034] ---[ end trace b973ab2013a7b9e2 ]---
[  681.675699] RIP: 0010:btrfs_sync_log+0x77c/0x1200 [btrfs]
[  681.676438] Code: 89 fc 4d 8d 44 24 20 4c 89 4c 24 78 4c 89 c7 4c 89
84 24 80 00 00 00 e8 72 fa da df 4d 8b 7c 24 20 48 8d 7b 08 e8 f4 fa da
df <4c> 89 7b 08 4c 89 ff e8 e8 fa da df 49 89 1f 4c 8b 4c 24 78 4c 89
[  681.678931] RSP: 0018:ffff8884245ef970 EFLAGS: 00010217
[  681.679645] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[  681.680622] RDX: 0000000000000001 RSI: 0000000000000004 RDI:
ffffffffa3240820
[  681.681588] RBP: ffff8884245efd10 R08: ffffffffa012b3c8 R09:
fffffbfff437c161
[  681.682554] R10: fffffbfff437c160 R11: ffffffffa1be0b03 R12:
ffff8884245efae0
[  681.683522] R13: ffffffffffffffe8 R14: ffff8884245efaf8 R15:
0000000000000000
[  681.684475] FS:  00007fe6d8b57b80(0000) GS:ffff88843f800000(0000)
knlGS:0000000000000000
[  681.685583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  681.686353] CR2: 0000000000000008 CR3: 00000004341fc000 CR4:
00000000003406e0
====================================================================

The local.config is nothing special only with default mount option.

The above BUG is easy to reproduce but not in 100%. 10 rounds is enough
to hit this.

linux 21:13#  ~/linux/scripts/faddr2line ~/linux/fs/btrfs/btrfs.ko
btrfs_sync_log+0x77c
btrfs_sync_log+0x77c/0x1200:
__list_del at /root/linux/./include/linux/list.h:105
(inlined by) __list_del_entry at /root/linux/./include/linux/list.h:134
(inlined by) list_del_init at /root/linux/./include/linux/list.h:190
(inlined by) btrfs_remove_all_log_ctxs at
/root/linux/fs/btrfs/tree-log.c:3016
(inlined by) btrfs_sync_log at /root/linux/fs/btrfs/tree-log.c:3283

Here are my .config and the whole dmesg:
https://drive.google.com/open?id=1DcaYg820sxWweNj7zG42_AM6ZjusPePG
https://drive.google.com/open?id=1Ris7pzDsAkl6CuluZqbMwZzxgPfNOkSw
