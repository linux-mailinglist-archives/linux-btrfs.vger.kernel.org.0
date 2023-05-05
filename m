Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D36F80CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEEKdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 06:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEEKdQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 06:33:16 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1549D3
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 03:33:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C99213FC43
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 12:33:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DdW_grC8gE_v for <linux-btrfs@vger.kernel.org>;
        Fri,  5 May 2023 12:32:59 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D51833FC28
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 12:32:59 +0200 (CEST)
Received: from [94.254.51.203] (port=58045 helo=[10.0.155.198])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1puskF-000MOz-4d
        for linux-btrfs@vger.kernel.org; Fri, 05 May 2023 12:32:59 +0200
Message-ID: <d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net>
Date:   Fri, 5 May 2023 12:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Language: en-GB
From:   Forza <forza@tnonline.net>
Subject: Regression in Linux 6.3.1 vs 6.2.13 with bees: vmalloc error: size 0,
 page order 9, failed to allocate pages,
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I upgraded my Linux kernel from 6.2.13 to 6.3.1 and pretty soon after 
running `bees`, I end up with hundreds of these dmesg messages. The 
issue is reproducible within minutes and goes away if I go back to 6.2.x 
kernels or earlier.


# dmesg on my bare-metal machine
#########
May  4 12:31:29 e350 kernel: [  512.186697] crawl_4065_7997: vmalloc 
error: size 14680064, page order 9, failed to allocate pages, 
mode:0xcc2(GFP_KERNEL|__GFP_HIGHMEM), 
nodemask=(null),cpuset=cmd-zIYd,mems_allowed=0
May  4 12:31:29 e350 kernel: [  512.186711] CPU: 0 PID: 8832 Comm: 
crawl_4065_7997 Not tainted 6.3.1-gentoo-e350 #1
May  4 12:31:29 e350 kernel: [  512.186714] Hardware name: Gigabyte 
Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F62d 10/13/2021
May  4 12:31:29 e350 kernel: [  512.186716] Call Trace:
May  4 12:31:29 e350 kernel: [  512.186718]  <TASK>
May  4 12:31:29 e350 kernel: [  512.186721]  dump_stack_lvl+0x32/0x50
May  4 12:31:29 e350 kernel: [  512.186727]  warn_alloc+0x10e/0x190
May  4 12:31:29 e350 kernel: [  512.186732]  ? __alloc_pages+0x1fc/0x220
May  4 12:31:29 e350 kernel: [  512.186735] 
__vmalloc_node_range+0x60e/0x880
May  4 12:31:29 e350 kernel: [  512.186739]  kvmalloc_node+0x92/0xb0
May  4 12:31:29 e350 kernel: [  512.186743]  ? init_data_container+0x26/0x70
May  4 12:31:29 e350 kernel: [  512.186747]  init_data_container+0x26/0x70
May  4 12:31:29 e350 kernel: [  512.186751] 
btrfs_ioctl_logical_to_ino+0x6d/0x150
May  4 12:31:29 e350 kernel: [  512.186755]  __x64_sys_ioctl+0x92/0xb0
May  4 12:31:29 e350 kernel: [  512.186759]  do_syscall_64+0x3a/0x90
May  4 12:31:29 e350 kernel: [  512.186763] 
entry_SYSCALL_64_after_hwframe+0x72/0xdc
May  4 12:31:29 e350 kernel: [  512.186768] RIP: 0033:0x7f3de134f43b
May  4 12:31:29 e350 kernel: [  512.186783] Code: 00 48 89 44 24 18 31 
c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 
89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 
24 18 64 48 2b 04 25 28 00 00
May  4 12:31:29 e350 kernel: [  512.186785] RSP: 002b:00007f3de09fa810 
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
May  4 12:31:29 e350 kernel: [  512.186790] RAX: ffffffffffffffda RBX: 
00007f3de09fab60 RCX: 00007f3de134f43b
May  4 12:31:29 e350 kernel: [  512.186792] RDX: 00007f3de09faa80 RSI: 
00000000c038943b RDI: 0000000000000003
May  4 12:31:29 e350 kernel: [  512.186794] RBP: 00007f3de09fab70 R08: 
0000000000000000 R09: 0000000000000000
May  4 12:31:29 e350 kernel: [  512.186795] R10: 00007f3de09faaf0 R11: 
0000000000000246 R12: 00007f3cdb20f110
May  4 12:31:29 e350 kernel: [  512.186797] R13: 0000000000000003 R14: 
00007f3de09faa50 R15: 00007f3de09faac0
May  4 12:31:29 e350 kernel: [  512.186799]  </TASK>
May  4 12:31:29 e350 kernel: [  512.186810] Mem-Info:
May  4 12:31:29 e350 kernel: [  512.186811] active_anon:1845472 
inactive_anon:2483 isolated_anon:0
May  4 12:31:29 e350 kernel: [  512.186811]  active_file:321194 
inactive_file:2406595 isolated_file:0
May  4 12:31:29 e350 kernel: [  512.186811]  unevictable:1053673 
dirty:2902 writeback:0
May  4 12:31:29 e350 kernel: [  512.186811]  slab_reclaimable:75639 
slab_unreclaimable:46806
May  4 12:31:29 e350 kernel: [  512.186811]  mapped:499050 shmem:359655 
pagetables:11409
May  4 12:31:29 e350 kernel: [  512.186811]  sec_pagetables:1927 bounce:0
May  4 12:31:29 e350 kernel: [  512.186811]  kernel_misc_reclaimable:0
May  4 12:31:29 e350 kernel: [  512.186811]  free:178268 free_pcp:129 
free_cma:0
May  4 12:31:29 e350 kernel: [  512.186818] Node 0 active_anon:7381888kB 
inactive_anon:9932kB active_file:1284776kB inactive_file:9626380kB 
unevictable:4214692kB isolated(anon):0kB isolated(file):0kB 
mapped:1996200kB dirty:11608kB writeback:0kB shmem:1
438620kB shmem_thp: 1366016kB shmem_pmdmapped: 993280kB anon_thp: 
7041024kB writeback_tmp:0kB kernel_stack:13344kB pagetables:45636kB 
sec_pagetables:7708kB all_unreclaimable? no
May  4 12:31:29 e350 kernel: [  512.186825] Node 0 DMA free:15372kB 
boost:0kB min:40kB low:52kB high:64kB reserved_highatomic:0KB 
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB 
unevictable:0kB writepending:0kB present:15996kB manag
ed:15372kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
May  4 12:31:29 e350 kernel: [  512.186831] lowmem_reserve[]: 0 2396 
23421 23421 23421
May  4 12:31:29 e350 kernel: [  512.186837] Node 0 DMA32 free:91996kB 
boost:0kB min:6964kB low:9440kB high:11916kB reserved_highatomic:0KB 
active_anon:630848kB inactive_anon:56kB active_file:10484kB 
inactive_file:1694468kB unevictable:0kB writepending:
32kB present:2542412kB managed:2476868kB mlocked:0kB bounce:0kB 
free_pcp:0kB local_pcp:0kB free_cma:0kB
May  4 12:31:29 e350 kernel: [  512.186844] lowmem_reserve[]: 0 0 21024 
21024 21024
May  4 12:31:29 e350 kernel: [  512.186848] Node 0 Normal free:605704kB 
boost:0kB min:60572kB low:82104kB high:103636kB reserved_highatomic:0KB 
active_anon:6751040kB inactive_anon:9876kB active_file:1274292kB 
inactive_file:7932360kB unevictable:4214692
kB writepending:11576kB present:22007040kB managed:21533772kB 
mlocked:4214692kB bounce:0kB free_pcp:508kB local_pcp:0kB free_cma:0kB
May  4 12:31:29 e350 kernel: [  512.186854] lowmem_reserve[]: 0 0 0 0 0
May  4 12:31:29 e350 kernel: [  512.186858] Node 0 DMA: 1*4kB (U) 1*8kB 
(U) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB 
(M) 3*4096kB (M) = 15372kB
May  4 12:31:29 e350 kernel: [  512.186872] Node 0 DMA32: 112*4kB (UME) 
83*8kB (UME) 78*16kB (UME) 61*32kB (UME) 48*64kB (UME) 21*128kB (UME) 
13*256kB (UME) 14*512kB (UM) 12*1024kB (UME) 3*2048kB (ME) 13*4096kB 
(UM) = 92248kB
May  4 12:31:29 e350 kernel: [  512.186892] Node 0 Normal: 4507*4kB 
(UME) 4700*8kB (UME) 6468*16kB (UME) 3714*32kB (UME) 1650*64kB (UME) 
536*128kB (UME) 135*256kB (UME) 103*512kB (UME) 65*1024kB (UME) 0*2048kB 
0*4096kB = 606028kB
May  4 12:31:29 e350 kernel: [  512.186908] Node 0 hugepages_total=0 
hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
May  4 12:31:29 e350 kernel: [  512.186910] Node 0 hugepages_total=0 
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
May  4 12:31:29 e350 kernel: [  512.186912] 3088853 total pagecache pages
May  4 12:31:29 e350 kernel: [  512.186913] 0 pages in swap cache
May  4 12:31:29 e350 kernel: [  512.186914] Free swap  = 16575692kB
May  4 12:31:29 e350 kernel: [  512.186915] Total swap = 16576496kB
May  4 12:31:29 e350 kernel: [  512.186916] 6141362 pages RAM
May  4 12:31:29 e350 kernel: [  512.186917] 0 pages HighMem/MovableOnly
May  4 12:31:29 e350 kernel: [  512.186918] 134859 pages reserved
May  4 12:31:29 e350 kernel: [  512.186919] 0 pages cma reserved
May  4 12:31:29 e350 kernel: [  512.186919] 0 pages hwpoisoned
May  4 12:32:36 e350 kernel: [  579.148633] warn_alloc: 2 callbacks 
suppressed


I thought it might be my custom kernel, so I installed a VM with 
Libvirt/QEMU using the gentooo-kernel-bin config applied to the 6.3.1 
sources and have the same error there. When I go back to kernel 6.2.x or 
6.1.x there is no message even after many hours.

AMD Ryzen CPU. I am running Gentoo Linux.
sys-devel/gcc:             12.2.1_p20230304::gentoo
sys-kernel/linux-headers:  6.2::gentoo (virtual/os-headers)
sys-libs/glibc:            2.36-r7::gentoo


# dmesg in QEMU VM
#########
May  5 10:51:34 static kernel: crawl_4523_7997: vmalloc error: size 0, 
page order 9, failed to allocate pages, 
mode:0xcc2(GFP_KERNEL|__GFP_HIGHMEM), 
nodemask=(null),cpuset=cmd-mqLt,mems_allowed=0
May  5 10:51:34 static kernel: CPU: 2 PID: 2632 Comm: crawl_4523_7997 
Tainted: G        W          6.3.1-gentoo-gentoo-dist #1
May  5 10:51:34 static kernel: Hardware name: QEMU Standard PC (Q35 + 
ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
May  5 10:51:34 static kernel: Call Trace:
May  5 10:51:34 static kernel:  <TASK>
May  5 10:51:34 static kernel:  dump_stack_lvl+0x43/0x60
May  5 10:51:34 static kernel:  warn_alloc+0x136/0x1c0
May  5 10:51:34 static kernel:  ? __alloc_pages+0x209/0x230
May  5 10:51:34 static kernel:  __vmalloc_node_range+0x607/0x850
May  5 10:51:34 static kernel:  ? __smp_call_single_queue+0x23/0x40
May  5 10:51:34 static kernel:  kvmalloc_node+0xa2/0xd0
May  5 10:51:34 static kernel:  ? init_data_container+0x26/0x60
May  5 10:51:34 static kernel:  init_data_container+0x26/0x60
May  5 10:51:34 static kernel:  btrfs_ioctl_logical_to_ino+0xc3/0x170
May  5 10:51:34 static kernel:  __x64_sys_ioctl+0x90/0xd0
May  5 10:51:34 static kernel:  do_syscall_64+0x5b/0xc0
May  5 10:51:34 static kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May  5 10:51:34 static kernel:  ? do_syscall_64+0x67/0xc0
May  5 10:51:34 static kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May  5 10:51:34 static kernel:  ? do_syscall_64+0x67/0xc0
May  5 10:51:34 static kernel:  ? switch_fpu_return+0x4c/0xd0
May  5 10:51:34 static kernel:  ? exit_to_user_mode_prepare+0x132/0x1e0
May  5 10:51:34 static kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May  5 10:51:34 static kernel:  ? do_syscall_64+0x67/0xc0
May  5 10:51:34 static kernel:  ? do_syscall_64+0x67/0xc0
May  5 10:51:34 static kernel:  ? do_syscall_64+0x67/0xc0
May  5 10:51:34 static kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
May  5 10:51:34 static kernel: RIP: 0033:0x7fdfc892663b
May  5 10:51:34 static kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 
10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 
04 25 28 00 00
May  5 10:51:34 static kernel: RSP: 002b:00007fdfc7025250 EFLAGS: 
00000246 ORIG_RAX: 0000000000000010
May  5 10:51:34 static kernel: RAX: ffffffffffffffda RBX: 
00007fdfc70255a0 RCX: 00007fdfc892663b
May  5 10:51:34 static kernel: RDX: 00007fdfc70254c0 RSI: 
00000000c038943b RDI: 0000000000000003
May  5 10:51:34 static kernel: RBP: 00007fdfc70255b0 R08: 
0000000000000000 R09: 0000000000000000
May  5 10:51:34 static kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 00007fdfb40097e0
May  5 10:51:34 static kernel: R13: 0000000000000003 R14: 
00007fdfc7025490 R15: 00007fdfc7025500
May  5 10:51:34 static kernel:  </TASK>
May  5 10:51:34 static kernel: Mem-Info:
May  5 10:51:34 static kernel: active_anon:41299 inactive_anon:165 
isolated_anon:0\x0a active_file:36568 inactive_file:754506 
isolated_file:0\x0a unevictable:1049576 dirty:864 writeback:0\x0a 
slab_reclaimable:21319 slab_unreclaimable:10258\x0a mapped:16667 
shmem:1162 pagetables:2614\x0a sec_pagetables:0 bounce:0\x0a 
kernel_misc_reclaimable:0\x0a free:48523 free_pcp:198 free_cma:0
May  5 10:51:34 static kernel: Node 0 active_anon:165196kB 
inactive_anon:660kB active_file:146272kB inactive_file:3017852kB 
unevictable:4198304kB isolated(anon):0kB isolated(file):0kB 
mapped:66668kB dirty:3456kB writeback:0kB shmem:4648kB shmem_thp: 0kB 
shmem_pmdmapped: 0kB anon_thp: 4194304kB writeback_tmp:0kB 
kernel_stack:4080kB pagetables:10456kB sec_pagetables:0kB 
all_unreclaimable? no
May  5 10:51:34 static kernel: Node 0 DMA free:14332kB boost:0kB 
min:128kB low:160kB high:192kB reserved_highatomic:0KB active_anon:0kB 
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:15992kB managed:15356kB mlocked:0kB bounce:0kB 
free_pcp:0kB local_pcp:0kB free_cma:0kB
May  5 10:51:34 static kernel: lowmem_reserve[]: 0 1942 7698 7698 7698
May  5 10:51:34 static kernel: Node 0 DMA32 free:45784kB boost:0kB 
min:17020kB low:21272kB high:25524kB reserved_highatomic:0KB 
active_anon:35560kB inactive_anon:0kB active_file:0kB 
inactive_file:1924076kB unevictable:0kB writepending:0kB 
present:2080632kB managed:2015096kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
May  5 10:51:34 static kernel: lowmem_reserve[]: 0 0 5755 5755 5755
May  5 10:51:34 static kernel: Node 0 Normal free:133976kB boost:0kB 
min:50428kB low:63032kB high:75636kB reserved_highatomic:32768KB 
active_anon:129636kB inactive_anon:660kB active_file:146272kB 
inactive_file:1094056kB unevictable:4198304kB writepending:3456kB 
present:6094848kB managed:5901680kB mlocked:4194304kB bounce:0kB 
free_pcp:792kB local_pcp:0kB free_cma:0kB
May  5 10:51:34 static kernel: lowmem_reserve[]: 0 0 0 0 0
May  5 10:51:34 static kernel: Node 0 DMA: 1*4kB (M) 1*8kB (M) 1*16kB 
(M) 1*32kB (M) 1*64kB (M) 1*128kB (M) 1*256kB (M) 1*512kB (M) 1*1024kB 
(M) 2*2048kB (M) 2*4096kB (M) = 14332kB
May  5 10:51:34 static kernel: Node 0 DMA32: 114*4kB (UME) 84*8kB (UME) 
57*16kB (UME) 64*32kB (UME) 38*64kB (UME) 17*128kB (UME) 16*256kB (U) 
19*512kB (U) 23*1024kB (U) 0*2048kB 0*4096kB = 46072kB
May  5 10:51:34 static kernel: Node 0 Normal: 770*4kB (UMEH) 679*8kB 
(UMEH) 508*16kB (UMEH) 550*32kB (UMEH) 304*64kB (UMEH) 242*128kB (UMEH) 
62*256kB (UMEH) 31*512kB (UMH) 18*1024kB (MEH) 0*2048kB 0*4096kB = 134848kB
May  5 10:51:34 static kernel: Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=1048576kB
May  5 10:51:34 static kernel: Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
May  5 10:51:34 static kernel: 792139 total pagecache pages
May  5 10:51:34 static kernel: 0 pages in swap cache
May  5 10:51:34 static kernel: Free swap  = 4194300kB
May  5 10:51:34 static kernel: Total swap = 4194300kB
May  5 10:51:34 static kernel: 2047868 pages RAM
May  5 10:51:34 static kernel: 0 pages HighMem/MovableOnly
May  5 10:51:34 static kernel: 64835 pages reserved
May  5 10:51:34 static kernel: 0 pages cma reserved
May  5 10:51:34 static kernel: 0 pages hwpoisoned
#########

