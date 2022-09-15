Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBCB5B95D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIOH7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIOH7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 03:59:02 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 00:58:53 PDT
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A5979C0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 00:58:52 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 18550 invoked from network); 15 Sep 2022 09:52:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1663228330; bh=UE1TXKbVnlOlNw9RurhVnfbxUXnHQPfMDqkaZE2lF2k=;
          h=To:From:Subject;
          b=CiuuD3OslKh80Q1jdrOQmQIFoY+2dlS+MarM83lQQYc978cPft4VoQ4V1hYXdcoZr
           24UyDvQNC4rnmEI6kfS6wPRr07jhJ3HyhnX8Lc0pTB7QGBX2HyH5138v47c7zhNpmB
           LS+K/h88kui+VoPCO5HHgU0eo1w4ONtr7z28A/zs=
Received: from unknown (HELO [192.168.1.108]) (olgierd86@o2.pl@[89.151.37.169])
          (envelope-sender <olgierd86@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-btrfs@vger.kernel.org>; 15 Sep 2022 09:52:10 +0200
Message-ID: <0c0ea8d6-b6ed-e942-6380-d720068668f0@o2.pl>
Date:   Thu, 15 Sep 2022 09:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Olgierd Jarosz <olgierd86@o2.pl>
Subject: Page allocation failures when running md5sum
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 70d1dce073576bcc7010a7661c3d8329
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [AQK0]                               
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I ran into a couple of page allocation failures like the following on a
fresh system. All I need to do is run md5sum on my data to trigger this.
Is this something I should be worried about?
The only thing running there is an idle NFS server, SSH and the md5sum.
The log below is literally from a fresh boot followed by md5sum on the
data, but these also happen later, usually after copying over another
couple dozen gigabytes and running md5sum again.


Thanks,
Olgierd


[ 1186.232273] md5sum: page allocation failure: order:4, mode:0x40c40(GFP_NOFS|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
[ 1186.232287] CPU: 3 PID: 1108 Comm: md5sum Not tainted 5.19.0-1-amd64 #1  Debian 5.19.6-1
[ 1186.232291] Hardware name: Gigabyte Technology Co., Ltd. B560 HD3/B560 HD3, BIOS F5 04/16/2021
[ 1186.232293] Call Trace:
[ 1186.232296]  <TASK>
[ 1186.232299]  dump_stack_lvl+0x45/0x5e
[ 1186.232308]  warn_alloc+0x138/0x160
[ 1186.232313]  ? __alloc_pages_direct_compact+0x222/0x2f0
[ 1186.232318]  __alloc_pages_slowpath.constprop.0+0xc7b/0xd10
[ 1186.232324]  ? bio_add_page+0x39/0x90
[ 1186.232330]  __alloc_pages+0x308/0x330
[ 1186.232335]  kmalloc_order+0x29/0xa0
[ 1186.232340]  kmalloc_order_trace+0x19/0x90
[ 1186.232347]  btrfs_lookup_bio_sums+0x542/0x580 [btrfs]
[ 1186.232403]  btrfs_submit_data_bio+0x159/0x210 [btrfs]
[ 1186.232451]  extent_readahead+0x40d/0x440 [btrfs]
[ 1186.232511]  read_pages+0x69/0x2d0
[ 1186.232516]  ? folio_add_lru+0x67/0xa0
[ 1186.232521]  page_cache_ra_unbounded+0x125/0x170
[ 1186.232526]  filemap_get_pages+0x4df/0x630
[ 1186.232532]  ? pagevec_move_tail_fn+0x390/0x390
[ 1186.232538]  filemap_read+0xb9/0x3c0
[ 1186.232545]  new_sync_read+0x100/0x180
[ 1186.232551]  vfs_read+0x13c/0x190
[ 1186.232557]  ksys_read+0x5f/0xe0
[ 1186.232561]  do_syscall_64+0x38/0xc0
[ 1186.232567]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1186.232572] RIP: 0033:0x7f6e623e6a7e
[ 1186.232576] Code: c0 e9 b6 fe ff ff 50 48 8d 3d be ec 0b 00 e8 d9 f1 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14
  0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[ 1186.232578] RSP: 002b:00007ffc756ba568 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 1186.232582] RAX: ffffffffffffffda RBX: 0000563f530d56b0 RCX: 00007f6e623e6a7e
[ 1186.232584] RDX: 0000000000008000 RSI: 0000563f530d8750 RDI: 0000000000000004
[ 1186.232586] RBP: 00007f6e624dc5e0 R08: 0000000000000004 R09: 00000000a2fd2ca0
[ 1186.232588] R10: 00000000bf353c63 R11: 0000000000000246 R12: 0000563f530d8750
[ 1186.232590] R13: 0000000000000d68 R14: 00007f6e624db9e0 R15: 0000000000008000
[ 1186.232594]  </TASK>
[ 1186.232608] Mem-Info:
[ 1186.232610] active_anon:149 inactive_anon:8055 isolated_anon:0
                 active_file:879220 inactive_file:3045388 isolated_file:0
                 unevictable:0 dirty:0 writeback:0
                 slab_reclaimable:21227 slab_unreclaimable:23113
                 mapped:9203 shmem:256 pagetables:380 bounce:0
                 kernel_misc_reclaimable:0
                 free:50919 free_pcp:0 free_cma:0
[ 1186.232617] Node 0 active_anon:596kB inactive_anon:32220kB active_file:3516880kB inactive_file:12181552kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:36812kB dirty:0kB writeback:0kB shmem:1024kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 2048kB writeback_tmp:0kB kernel_stack:3056kB pagetables:1520kB all_unreclaimable? no
[ 1186.232623] Node 0 DMA free:13312kB boost:0kB min:64kB low:80kB high:96kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1186.232629] lowmem_reserve[]: 0 833 15809 15809 15809
[ 1186.232635] Node 0 DMA32 free:63492kB boost:0kB min:3556kB low:4444kB high:5332kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:103308kB inactive_file:727636kB unevictable:0kB writepending:0kB present:964268kB managed:898436kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1186.232641] lowmem_reserve[]: 0 0 14975 14975 14975
[ 1186.232646] Node 0 Normal free:126872kB boost:0kB min:63960kB low:79948kB high:95936kB reserved_highatomic:0KB active_anon:596kB inactive_anon:32220kB active_file:3413572kB inactive_file:11453916kB unevictable:0kB writepending:0kB present:15663104kB managed:15343300kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1186.232652] lowmem_reserve[]: 0 0 0 0 0
[ 1186.232657] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 2*2048kB (UM) 2*4096kB (M) = 13312kB
[ 1186.232672] Node 0 DMA32: 1*4kB (U) 2*8kB (UE) 3*16kB (UE) 4*32kB (UME) 5*64kB (UE) 6*128kB (UME) 3*256kB (UM) 2*512kB (ME) 3*1024kB (UME) 2*2048kB (U) 13*4096kB (M) = 63492kB
[ 1186.232691] Node 0 Normal: 10995*4kB (UME) 3433*8kB (UME) 3233*16kB (UME) 124*32kB (UME) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 127140kB
[ 1186.232706] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 1186.232708] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 1186.232710] 3924882 total pagecache pages
[ 1186.232711] 0 pages in swap cache
[ 1186.232712] Swap cache stats: add 4, delete 4, find 0/0
[ 1186.232713] Free swap  = 23437052kB
[ 1186.232714] Total swap = 23437308kB
[ 1186.232715] 4160841 pages RAM
[ 1186.232716] 0 pages HighMem/MovableOnly
[ 1186.232716] 96567 pages reserved
[ 1186.232717] 0 pages hwpoisoned
[ 1197.288649] warn_alloc: 6 callbacks suppressed
[ 1197.288651] md5sum: page allocation failure: order:4, mode:0x40c40(GFP_NOFS|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
[ 1197.288657] CPU: 1 PID: 1108 Comm: md5sum Not tainted 5.19.0-1-amd64 #1  Debian 5.19.6-1
[ 1197.288660] Hardware name: Gigabyte Technology Co., Ltd. B560 HD3/B560 HD3, BIOS F5 04/16/2021
[ 1197.288660] Call Trace:
[ 1197.288662]  <TASK>
[ 1197.288663]  dump_stack_lvl+0x45/0x5e
[ 1197.288668]  warn_alloc+0x138/0x160
[ 1197.288670]  ? __alloc_pages_direct_compact+0x222/0x2f0
[ 1197.288673]  __alloc_pages_slowpath.constprop.0+0xc7b/0xd10
[ 1197.288676]  __alloc_pages+0x308/0x330
[ 1197.288677]  kmalloc_order+0x29/0xa0
[ 1197.288680]  kmalloc_order_trace+0x19/0x90
[ 1197.288683]  btrfs_lookup_bio_sums+0x542/0x580 [btrfs]
[ 1197.288709]  btrfs_submit_data_bio+0x159/0x210 [btrfs]
[ 1197.288729]  submit_extent_page+0x179/0x4c0 [btrfs]
[ 1197.288752]  ? btrfs_repair_one_sector+0x370/0x370 [btrfs]
[ 1197.288775]  ? _raw_spin_unlock+0x15/0x30
[ 1197.288777]  ? set_extent_bit+0x4fb/0x690 [btrfs]
[ 1197.288799]  btrfs_do_readpage+0x2fb/0x810 [btrfs]
[ 1197.288821]  ? btrfs_repair_one_sector+0x370/0x370 [btrfs]
[ 1197.288844]  extent_readahead+0x30c/0x440 [btrfs]
[ 1197.288867]  read_pages+0x69/0x2d0
[ 1197.288870]  page_cache_ra_unbounded+0x125/0x170
[ 1197.288872]  filemap_get_pages+0x4df/0x630
[ 1197.288875]  ? pagevec_move_tail_fn+0x390/0x390
[ 1197.288877]  filemap_read+0xb9/0x3c0
[ 1197.288880]  ? tcp_done+0x110/0x110
[ 1197.288882]  new_sync_read+0x100/0x180
[ 1197.288885]  vfs_read+0x13c/0x190
[ 1197.288888]  ksys_read+0x5f/0xe0
[ 1197.288890]  do_syscall_64+0x38/0xc0
[ 1197.288892]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1197.288894] RIP: 0033:0x7f6e623e6a7e
[ 1197.288896] Code: c0 e9 b6 fe ff ff 50 48 8d 3d be ec 0b 00 e8 d9 f1 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[ 1197.288897] RSP: 002b:00007ffc756ba568 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 1197.288899] RAX: ffffffffffffffda RBX: 0000563f530d56b0 RCX: 00007f6e623e6a7e
[ 1197.288900] RDX: 0000000000008000 RSI: 0000563f530d8750 RDI: 0000000000000004
[ 1197.288901] RBP: 00007f6e624dc5e0 R08: 0000000000000004 R09: 0000000092d6da6b
[ 1197.288902] R10: 00000000ed6a4f24 R11: 0000000000000246 R12: 0000563f530d8750
[ 1197.288903] R13: 0000000000000d68 R14: 00007f6e624db9e0 R15: 0000000000008000
[ 1197.288904]  </TASK>
[ 1197.288905] Mem-Info:
[ 1197.288906] active_anon:149 inactive_anon:8055 isolated_anon:0
                 active_file:955343 inactive_file:2943697 isolated_file:0
                 unevictable:0 dirty:0 writeback:0
                 slab_reclaimable:22627 slab_unreclaimable:24723
                 mapped:9331 shmem:256 pagetables:380 bounce:0
                 kernel_misc_reclaimable:0
                 free:73132 free_pcp:165 free_cma:0
[ 1197.288908] Node 0 active_anon:596kB inactive_anon:32220kB active_file:3821372kB inactive_file:11774788kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:37324kB dirty:0kB writeback:0kB shmem:1024kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 2048kB writeback_tmp:0kB kernel_stack:3056kB pagetables:1520kB all_unreclaimable? no
[ 1197.288911] Node 0 DMA free:13312kB boost:0kB min:64kB low:80kB high:96kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1197.288914] lowmem_reserve[]: 0 833 15809 15809 15809
[ 1197.288916] Node 0 DMA32 free:63456kB boost:0kB min:3556kB low:4444kB high:5332kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:103308kB inactive_file:727668kB unevictable:0kB writepending:0kB present:964268kB managed:898436kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1197.288918] lowmem_reserve[]: 0 0 14975 14975 14975
[ 1197.288920] Node 0 Normal free:215760kB boost:129024kB min:192984kB low:208972kB high:224960kB reserved_highatomic:0KB active_anon:596kB inactive_anon:32220kB active_file:3717980kB inactive_file:11046992kB unevictable:0kB writepending:0kB present:15663104kB managed:15343300kB mlocked:0kB bounce:0kB free_pcp:788kB local_pcp:0kB free_cma:0kB
[ 1197.288923] lowmem_reserve[]: 0 0 0 0 0
[ 1197.288925] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 2*2048kB (UM) 2*4096kB (M) = 13312kB
[ 1197.288931] Node 0 DMA32: 2*4kB (U) 1*8kB (E) 3*16kB (UE) 3*32kB (UE) 5*64kB (UE) 6*128kB (UME) 3*256kB (UM) 2*512kB (ME) 3*1024kB (UME) 2*2048kB (U) 13*4096kB (M) = 63456kB
[ 1197.288940] Node 0 Normal: 15508*4kB (UME) 8405*8kB (UME) 5268*16kB (UME) 101*32kB (UME) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 216792kB
[ 1197.288946] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 1197.288947] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 1197.288948] 3899227 total pagecache pages
[ 1197.288949] 0 pages in swap cache
[ 1197.288949] Swap cache stats: add 4, delete 4, find 0/0
[ 1197.288950] Free swap  = 23437052kB
[ 1197.288950] Total swap = 23437308kB
[ 1197.288951] 4160841 pages RAM
[ 1197.288951] 0 pages HighMem/MovableOnly
[ 1197.288952] 96567 pages reserved
[ 1197.288952] 0 pages hwpoisoned


free -h
                total        used        free      shared  buff/cache   available
Mem:            15Gi       293Mi       176Mi       0.0Ki        15Gi        14Gi
Swap:           22Gi       1.0Mi        22Gi


uname -a
Linux wormhole 5.19.0-1-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.19.6-1 (2022-09-01) x86_64 GNU/Linux


btrfs --version
btrfs-progs v5.19


btrfs fi show
Label: none  uuid: e96c2616-f40e-42c1-b2fe-895b6aad0fcf
     Total devices 1 FS bytes used 1.53GiB
     devid    1 size 279.40GiB used 8.02GiB path /dev/nvme0n1p2

Label: 'data_pool'  uuid: e1c40719-5aac-45bd-8178-cb1eee9780a4
     Total devices 6 FS bytes used 384.15GiB
     devid    1 size 3.64TiB used 193.00GiB path /dev/sda
     devid    2 size 3.64TiB used 193.00GiB path /dev/sdb
     devid    3 size 3.64TiB used 193.00GiB path /dev/sdd
     devid    4 size 3.64TiB used 192.01GiB path /dev/sdc
     devid    5 size 3.64TiB used 192.01GiB path /dev/sde
     devid    6 size 3.64TiB used 192.01GiB path /dev/sdf


btrfs fi usage /srv/data
Overall:
     Device size:          21.83TiB
     Device allocated:          1.13TiB
     Device unallocated:       20.70TiB
     Device missing:          0.00B
     Used:              1.12TiB
     Free (estimated):          6.90TiB  (min: 6.90TiB)
     Free (statfs, df):         6.90TiB
     Data ratio:               3.00
     Metadata ratio:           3.00
     Global reserve:      512.00MiB  (used: 0.00B)
     Multiple profiles:              no

Data,RAID1C3: Size:381.00GiB, Used:380.88GiB (99.97%)
    /dev/sda  190.00GiB
    /dev/sdb  190.00GiB
    /dev/sdd  190.00GiB
    /dev/sdc  191.00GiB
    /dev/sde  191.00GiB
    /dev/sdf  191.00GiB

Metadata,RAID1C3: Size:4.00GiB, Used:3.27GiB (81.75%)
    /dev/sda    3.00GiB
    /dev/sdb    3.00GiB
    /dev/sdd    3.00GiB
    /dev/sdc    1.00GiB
    /dev/sde    1.00GiB
    /dev/sdf    1.00GiB

System,RAID1C3: Size:8.00MiB, Used:96.00KiB (1.17%)
    /dev/sdc    8.00MiB
    /dev/sde    8.00MiB
    /dev/sdf    8.00MiB

Unallocated:
    /dev/sda    3.45TiB
    /dev/sdb    3.45TiB
    /dev/sdd    3.45TiB
    /dev/sdc    3.45TiB
    /dev/sde    3.45TiB
    /dev/sdf    3.45TiB


md5sum --version
md5sum (GNU coreutils) 8.32
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Ulrich Drepper, Scott Miller, and David Madore.
