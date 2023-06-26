Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7D73E19B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjFZOKK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 26 Jun 2023 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjFZOKJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 10:10:09 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E3D1AA;
        Mon, 26 Jun 2023 07:10:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 2F5F83F637;
        Mon, 26 Jun 2023 16:10:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1f71xxGLKwnm; Mon, 26 Jun 2023 16:10:01 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5ACEB3F5FF;
        Mon, 26 Jun 2023 16:09:59 +0200 (CEST)
Received: from [2a00:801:798:c6f9::21a0:d26f] (port=39084 helo=[10.218.58.85])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1qDmuh-000OUJ-D3; Mon, 26 Jun 2023 16:09:58 +0200
Date:   Mon, 26 Jun 2023 16:09:53 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Message-ID: <bf1ec36.86425ef5.188f80a223e@tnonline.net>
In-Reply-To: <2126cc69-b779-565b-98c7-4fbb0bf9f557@suse.cz>
References: <20230605201107.83298-1-lstoakes@gmail.com> <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz> <f6b42d95-09f1-48d6-8274-e6145febb31d@lucifer.local> <2a6fa9d6-53b8-93cd-16c8-309ce2b8e3ac@suse.cz> <20230607093316.cdf60df195915fa9d38067ea@linux-foundation.org> <11b893e.86425ef4.188f33688b8@tnonline.net> <e3ce1745-0a3e-4c9d-955e-2a0ce20422cf@lucifer.local> <2126cc69-b779-565b-98c7-4fbb0bf9f557@suse.cz>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Vlastimil Babka <vbabka@suse.cz> -- Sent: 2023-06-26 - 11:08 ----

> On 6/25/23 17:59, Lorenzo Stoakes wrote:
>> On Sun, Jun 25, 2023 at 05:40:17PM +0200, Forza wrote:
>>>
>>>
>>> ---- From: Andrew Morton <akpm@linux-foundation.org> -- Sent: 2023-06-07 - 18:33 ----
>>>
>>> > On Wed, 7 Jun 2023 10:58:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>>> >
>>> >> I would really suggest moving the fix to
>>> >> mm-hotfixes instead of mm-unstable, and
>>> >>
>>> >> Fixes: 80b1d8fdfad1 ("mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()")
>>> >> Cc: <stable@vger.kernel.org>
>>> >
>>> > I've made those changes.
>>>
>>> Did the chabge go into 6.3 stable? I saw these issues with kernels 6.3.0-6 3.7. I now updated to 6.3.9 and have had no more warnings since.
>> 
>> Yeah, got the notification from Greg's script that it landed in 6.3 stable.
> 
> It did, but was not yet released. 6.3.9 from Wed Jun 21 doesn't have it yet,
> so it's interesting the warnings are gone already.
> 
> 

Oh dang it. I jinxed the thing... At least there was 4 days uptime before this happened. I did run with vm.swappiness=0, and started a new VM in QEMU, which must have put extra pressure on allocations.


#  dmesg | tail -n +1550 
[286405.332000] lan: port 5(vnet10) entered blocking state
[286405.332008] lan: port 5(vnet10) entered forwarding state
[286405.686587] qemu:deb12-virt: vmalloc error: size 0, page order 9, failed to allocate pages, mode:0xdc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO), nodemask=(null),cpuset=emulator,mems_allowed=0
[286405.686604] CPU: 1 PID: 16084 Comm: qemu:deb12-virt Not tainted 6.3.9-gentoo-e350 #2
[286405.686608] Hardware name: Gigabyte Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F64 06/08/2023
[286405.686610] Call Trace:
[286405.686612]  <TASK>
[286405.686616]  dump_stack_lvl+0x32/0x50
[286405.686622]  warn_alloc+0x132/0x1b0
[286405.686627]  __vmalloc_node_range+0x639/0x880
[286405.686633]  ? mas_wr_bnode+0x123/0x1060
[286405.686637]  ? amdgpu_bo_create+0xd6/0x480 [amdgpu]
[286405.686919]  kvmalloc_node+0x92/0xb0
[286405.686923]  ? amdgpu_bo_create+0xd6/0x480 [amdgpu]
[286405.687171]  amdgpu_bo_create+0xd6/0x480 [amdgpu]
[286405.687408]  amdgpu_bo_create_vm+0x2e/0x60 [amdgpu]
[286405.687663]  amdgpu_vm_pt_create+0x12b/0x2a0 [amdgpu]
[286405.687941]  amdgpu_vm_init+0x245/0x4d0 [amdgpu]
[286405.688193]  amdgpu_driver_open_kms+0x94/0x230 [amdgpu]
[286405.688440]  drm_file_alloc+0x196/0x240
[286405.688445]  drm_open_helper+0x74/0x120
[286405.688448]  drm_open+0x7b/0x140
[286405.688450]  drm_stub_open+0xa4/0xe0
[286405.688454]  chrdev_open+0xbd/0x210
[286405.688458]  ? __pfx_chrdev_open+0x10/0x10
[286405.688461]  do_dentry_open+0x1e5/0x460
[286405.688465]  path_openat+0xc91/0x1080
[286405.688469]  do_filp_open+0xb4/0x160
[286405.688472]  ? __check_object_size+0x23a/0x2b0
[286405.688475]  do_sys_openat2+0x95/0x150
[286405.688478]  __x64_sys_openat+0x6a/0xa0
[286405.688480]  do_syscall_64+0x3a/0x90
[286405.688484]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[286405.688488] RIP: 0033:0x7fc725f0ae59
[286405.688504] Code: 24 18 48 8d 44 24 30 48 89 44 24 20 75 95 e8 1e e9 f8 ff 45 89 e2 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3f 44 89 c7 89 44 24 0c e8 73 e9 f8 ff 8b 44
[286405.688506] RSP: 002b:00007ffffffe6840 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[286405.688509] RAX: ffffffffffffffda RBX: 0000000000080902 RCX: 00007fc725f0ae59
[286405.688511] RDX: 0000000000080902 RSI: 00007fc72453ad20 RDI: 00000000ffffff9c
[286405.688513] RBP: 00007fc72453ad20 R08: 0000000000000000 R09: 000000000000000c
[286405.688514] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[286405.688516] R13: 0000559e9cfe4708 R14: 00007ffffffe6ac0 R15: 0000559e9cfe4708
[286405.688518]  </TASK>
[286405.688519] Mem-Info:
[286405.688521] active_anon:2351704 inactive_anon:2000415 isolated_anon:0
                 active_file:35015 inactive_file:28668 isolated_file:0
                 unevictable:5145 dirty:129 writeback:0
                 slab_reclaimable:70205 slab_unreclaimable:80481
                 mapped:982607 shmem:1063997 pagetables:18273
                 sec_pagetables:3080 bounce:0
                 kernel_misc_reclaimable:0
                 free:1389338 free_pcp:259 free_cma:0
[286405.688526] Node 0 active_anon:9406816kB inactive_anon:8001660kB active_file:140060kB inactive_file:114672kB unevictable:20580kB isolated(anon):0kB isolated(file):0kB mapped:3930428kB dirty:516kB writeback:0kB shmem:4255988kB shmem_thp: 4151296kB shmem_pmdmapped: 2641920kB anon_thp: 10160128kB writeback_tmp:0kB kernel_stack:18384kB pagetables:73092kB sec_pagetables:12320kB all_unreclaimable? no
[286405.688532] DMA free:15372kB boost:0kB min:40kB low:52kB high:64kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15372kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[286405.688536] lowmem_reserve[]: 0 2671 23694 23694 23694
[286405.688541] DMA32 free:933372kB boost:0kB min:7616kB low:10352kB high:13088kB reserved_highatomic:0KB active_anon:1140744kB inactive_anon:634600kB active_file:0kB inactive_file:324kB unevictable:0kB writepending:0kB present:2801616kB managed:2736072kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[286405.688546] lowmem_reserve[]: 0 0 21022 21022 21022
[286405.688550] Normal free:4608608kB boost:0kB min:59924kB low:81448kB high:102972kB reserved_highatomic:2048KB active_anon:8265464kB inactive_anon:7367108kB active_file:139392kB inactive_file:114328kB unevictable:20580kB writepending:516kB present:22007040kB managed:21527488kB mlocked:20580kB bounce:0kB free_pcp:1036kB local_pcp:0kB free_cma:0kB
[286405.688555] lowmem_reserve[]: 0 0 0 0 0
[286405.688558] DMA: 1*4kB (U) 1*8kB (U) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15372kB
[286405.688571] DMA32: 1421*4kB (UME) 1447*8kB (UME) 1443*16kB (UME) 1491*32kB (UME) 1279*64kB (UME) 1024*128kB (UME) 667*256kB (UM) 424*512kB (UM) 239*1024kB (UM) 0*2048kB 0*4096kB = 933564kB
[286405.688585] Normal: 34288*4kB (UME) 25137*8kB (UME) 18613*16kB (UME) 13225*32kB (UME) 8674*64kB (UME) 5360*128kB (UME) 3163*256kB (UME) 1722*512kB (UM) 601*1024kB (UM) 1*2048kB (H) 0*4096kB = 4609336kB
[286405.688600] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[286405.688603] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[286405.688606] 1129365 total pagecache pages
[286405.688608] 0 pages in swap cache
[286405.688609] Free swap  = 16576496kB
[286405.688610] Total swap = 16576496kB
[286405.688611] 6206163 pages RAM
[286405.688612] 0 pages HighMem/MovableOnly
[286405.688613] 136430 pages reserved
[286405.688613] 0 pages hwpoisoned
[289047.869189] lan: port 5(vnet10) entered disabled state
[289047.871407] vnet10 (unregistering): left allmulticast mode
[289047.871412] vnet10 (unregistering): left promiscuous mode
[289047.871416] lan: port 5(vnet10) entered disabled state
[290840.031863] kworker/u16:5: vmalloc error: size 0, page order 9, failed to allocate pages, mode:0xcc2(GFP_KERNEL|__GFP_HIGHMEM), nodemask=(null),cpuset=/,mems_allowed=0
[290840.031877] CPU: 2 PID: 24909 Comm: kworker/u16:5 Not tainted 6.3.9-gentoo-e350 #2
[290840.031880] Hardware name: Gigabyte Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F64 06/08/2023
[290840.031882] Workqueue: btrfs-delalloc btrfs_work_helper
[290840.031887] Call Trace:
[290840.031900]  <TASK>
[290840.031903]  dump_stack_lvl+0x32/0x50
[290840.031912]  warn_alloc+0x132/0x1b0
[290840.031917]  __vmalloc_node_range+0x639/0x880
[290840.031921]  ? zstd_alloc_workspace+0x6a/0xe0
[290840.031925]  kvmalloc_node+0x92/0xb0
[290840.031928]  ? zstd_alloc_workspace+0x6a/0xe0
[290840.031931]  zstd_alloc_workspace+0x6a/0xe0
[290840.031934]  zstd_get_workspace+0xfc/0x230
[290840.031939]  btrfs_compress_pages+0x4c/0x110
[290840.031944]  compress_file_range+0x37c/0x8d0
[290840.031948]  async_cow_start+0x12/0x40
[290840.031950]  ? __pfx_async_cow_submit+0x10/0x10
[290840.031953]  btrfs_work_helper+0xde/0x300
[290840.031955]  process_one_work+0x20f/0x3e0
[290840.031959]  worker_thread+0x4a/0x3c0
[290840.031962]  ? __pfx_worker_thread+0x10/0x10
[290840.031964]  kthread+0xc3/0xe0
[290840.031968]  ? __pfx_kthread+0x10/0x10
[290840.031970]  ret_from_fork+0x2c/0x50
[290840.031975]  </TASK>
[290840.031976] Mem-Info:
[290840.031978] active_anon:2339909 inactive_anon:2064196 isolated_anon:0
                 active_file:65663 inactive_file:55179 isolated_file:0
                 unevictable:5145 dirty:25418 writeback:0
                 slab_reclaimable:70164 slab_unreclaimable:80864
                 mapped:986684 shmem:1076299 pagetables:18629
                 sec_pagetables:3104 bounce:0
                 kernel_misc_reclaimable:0
                 free:1284125 free_pcp:64 free_cma:0
[290840.031983] Node 0 active_anon:9359636kB inactive_anon:8256784kB active_file:262652kB inactive_file:220716kB unevictable:20580kB isolated(anon):0kB isolated(file):0kB mapped:3946736kB dirty:101672kB writeback:0kB shmem:4305196kB shmem_thp: 4149248kB shmem_pmdmapped: 2641920kB anon_thp: 10182656kB writeback_tmp:0kB kernel_stack:18560kB pagetables:74516kB sec_pagetables:12416kB all_unreclaimable? no
[290840.031988] DMA free:15372kB boost:0kB min:40kB low:52kB high:64kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15372kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[290840.031995] lowmem_reserve[]: 0 2671 23694 23694 23694
[290840.032001] DMA32 free:929580kB boost:0kB min:7616kB low:10352kB high:13088kB reserved_highatomic:0KB active_anon:690416kB inactive_anon:1084604kB active_file:332kB inactive_file:212kB unevictable:0kB writepending:0kB present:2801616kB managed:2736072kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[290840.032007] lowmem_reserve[]: 0 0 21022 21022 21022
[290840.032012] Normal free:4191548kB boost:0kB min:59924kB low:81448kB high:102972kB reserved_highatomic:2048KB active_anon:8669148kB inactive_anon:7172160kB active_file:262204kB inactive_file:219956kB unevictable:20580kB writepending:101672kB present:22007040kB managed:21527488kB mlocked:20580kB bounce:0kB free_pcp:512kB local_pcp:0kB free_cma:0kB
[290840.032018] lowmem_reserve[]: 0 0 0 0 0
[290840.032023] DMA: 1*4kB (U) 1*8kB (U) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15372kB
[290840.032039] DMA32: 1429*4kB (UME) 1449*8kB (UME) 1443*16kB (UME) 1491*32kB (UME) 1278*64kB (UME) 1021*128kB (UME) 667*256kB (UM) 421*512kB (UM) 237*1024kB (UM) 0*2048kB 0*4096kB = 929580kB
[290840.032052] Normal: 3292*4kB (UME) 8398*8kB (UME) 16602*16kB (UME) 13421*32kB (UME) 8881*64kB (UME) 5345*128kB (UME) 3056*256kB (UME) 1553*512kB (UM) 571*1024kB (UM) 1*2048kB (H) 0*4096kB = 4192224kB
[290840.032069] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[290840.032071] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[290840.032073] 1198652 total pagecache pages
[290840.032074] 0 pages in swap cache
[290840.032074] Free swap  = 16576496kB
[290840.032075] Total swap = 16576496kB
[290840.032076] 6206163 pages RAM
[290840.032077] 0 pages HighMem/MovableOnly
[290840.032077] 136430 pages reserved
[290840.032078] 0 pages hwpoisoned
[294419.578589] warn_alloc: 3 callbacks suppressed
[294419.578592] kworker/u16:7: vmalloc error: size 0, page order 9, failed to allocate pages, mode:0xcc2(GFP_KERNEL|__GFP_HIGHMEM), nodemask=(null),cpuset=/,mems_allowed=0
[294419.578603] CPU: 2 PID: 24910 Comm: kworker/u16:7 Not tainted 6.3.9-gentoo-e350 #2
[294419.578606] Hardware name: Gigabyte Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F64 06/08/2023
[294419.578607] Workqueue: btrfs-delalloc btrfs_work_helper
[294419.578612] Call Trace:
[294419.578615]  <TASK>
[294419.578617]  dump_stack_lvl+0x32/0x50
[294419.578623]  warn_alloc+0x132/0x1b0
[294419.578627]  __vmalloc_node_range+0x639/0x880
[294419.578631]  ? zstd_alloc_workspace+0x6a/0xe0
[294419.578635]  kvmalloc_node+0x92/0xb0
[294419.578638]  ? zstd_alloc_workspace+0x6a/0xe0
[294419.578642]  zstd_alloc_workspace+0x6a/0xe0
[294419.578646]  zstd_get_workspace+0xfc/0x230
[294419.578650]  btrfs_compress_pages+0x4c/0x110
[294419.578654]  compress_file_range+0x37c/0x8d0
[294419.578658]  async_cow_start+0x12/0x40
[294419.578661]  ? __pfx_async_cow_submit+0x10/0x10
[294419.578664]  btrfs_work_helper+0xde/0x300
[294419.578667]  process_one_work+0x20f/0x3e0
[294419.578671]  worker_thread+0x4a/0x3c0
[294419.578673]  ? __pfx_worker_thread+0x10/0x10
[294419.578676]  ? __pfx_worker_thread+0x10/0x10
[294419.578678]  kthread+0xc3/0xe0
[294419.578682]  ? __pfx_kthread+0x10/0x10
[294419.578686]  ret_from_fork+0x2c/0x50
[294419.578692]  </TASK>
[294419.578694] Mem-Info:
[294419.578696] active_anon:1869566 inactive_anon:2491416 isolated_anon:0
                 active_file:82836 inactive_file:33435 isolated_file:6
                 unevictable:5145 dirty:10368 writeback:0
                 slab_reclaimable:70163 slab_unreclaimable:79069
                 mapped:992200 shmem:1077022 pagetables:18383
                 sec_pagetables:3104 bounce:0
                 kernel_misc_reclaimable:0
                 free:1330442 free_pcp:5208 free_cma:0
[294419.578704] Node 0 active_anon:7478264kB inactive_anon:9965664kB active_file:331344kB inactive_file:133740kB unevictable:20580kB isolated(anon):0kB isolated(file):24kB mapped:3968800kB dirty:41472kB writeback:0kB shmem:4308088kB shmem_thp: 4149248kB shmem_pmdmapped: 2646016kB anon_thp: 10196992kB writeback_tmp:0kB kernel_stack:18432kB pagetables:73532kB sec_pagetables:12416kB all_unreclaimable? no
[294419.578709] DMA free:15372kB boost:0kB min:40kB low:52kB high:64kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15372kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[294419.578714] lowmem_reserve[]: 0 2671 23694 23694 23694
[294419.578724] DMA32 free:927704kB boost:0kB min:7616kB low:10352kB high:13088kB reserved_highatomic:0KB active_anon:973788kB inactive_anon:807332kB active_file:104kB inactive_file:220kB unevictable:0kB writepending:0kB present:2801616kB managed:2736072kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[294419.578730] lowmem_reserve[]: 0 0 21022 21022 21022
[294419.578736] Normal free:4380452kB boost:0kB min:59924kB low:81448kB high:102972kB reserved_highatomic:2048KB active_anon:6504476kB inactive_anon:9158332kB active_file:331240kB inactive_file:133520kB unevictable:20580kB writepending:41472kB present:22007040kB managed:21527488kB mlocked:20580kB bounce:0kB free_pcp:19148kB local_pcp:13588kB free_cma:0kB
[294419.578741] lowmem_reserve[]: 0 0 0 0 0
[294419.578744] DMA: 1*4kB (U) 1*8kB (U) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15372kB
[294419.578760] DMA32: 1432*4kB (UME) 1445*8kB (UME) 1437*16kB (UME) 1484*32kB (UME) 1276*64kB (UME) 1019*128kB (UME) 665*256kB (UM) 420*512kB (UM) 237*1024kB (UM) 0*2048kB 0*4096kB = 927832kB
[294419.578777] Normal: 7051*4kB (UME) 11342*8kB (UME) 16910*16kB (UME) 13380*32kB (UME) 9035*64kB (UME) 5516*128kB (UME) 3230*256kB (UME) 1696*512kB (UM) 581*1024kB (UM) 1*2048kB (H) 0*4096kB = 4394172kB
[294419.579034] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[294419.579036] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[294419.579037] 1194726 total pagecache pages
[294419.579038] 0 pages in swap cache
[294419.579038] Free swap  = 16576496kB
[294419.579039] Total swap = 16576496kB
[294419.579040] 6206163 pages RAM
[294419.579040] 0 pages HighMem/MovableOnly
[294419.579041] 136430 pages reserved
[294419.579041] 0 pages hwpoisoned



