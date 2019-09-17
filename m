Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07EB577C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfIQV0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 17:26:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34275 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfIQV0p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 17:26:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so6347524qth.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=0NUkpn21+JobtanLPDaPvln+1dnx3yRnfF6sG6UAnPQ=;
        b=LmU3BzM284ExvjkwWnmMEdEU76Jww2LYvPY2AOZKNgNwuGr6kk0VoATq5oXFzsAdxE
         B+Jf27VhqyzK8qSrtn+Aw4KZpdQpeYETegyxkL3bH4jbzVALgld7flH//KjxkoDmIQtL
         huS8KR7JROoPGWPWj25ocT/t9zXbhHyWYSAJOcG4Dh5NUOmGNJsxkU4xFf1EZblQ0+sk
         MFq6G1esKo3IBhFMDHfJC0ZL7hVqJltI8yEOjcwHt0EI5r+/BZKMbkTPJ3GUZB0U5EXq
         5eA4Piu5ljIbLYFPZpoA8hjFmCryDAKpD4xnajRcYJFM0P9toeXW1UMnRUyBXNUcnV73
         SkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0NUkpn21+JobtanLPDaPvln+1dnx3yRnfF6sG6UAnPQ=;
        b=kX4mvyWM/GPTW2YekBetQE6FUk5An8/XVVKJVMOvNnwvjN5Q7OImhDdBTdANYMrbAA
         CdKP14UouG02qUWq10xeFRbHDE84kMHV+ol1jfI5kRc8itqANscZFjtXFvsz5deMt3bW
         LgoeLhM0YEjzz/Vudv/LqgyDAV3Qq6BVRXqvkLKN4yW1r/GZ4MvclUwTK4ZqjVnyrpqF
         dSBGZCZQXMuoTaS3mx3krjA2xoGiza6VXv1e2i+hNSilJUBmSlCB8xwBkHvbmpUi1x6g
         m121lCHdVdOefTUJuTmJDdzt4yqNUqgZ9kmwfiQOr3B+gYvJlunV+pP5ZHbVjM+Z6UZX
         grbg==
X-Gm-Message-State: APjAAAVGV6sqlHMKh4MDL8dpzWdwED9eyUunlw3q2TzLEWjVaJpy+2XH
        TRirOtuxsTN0RyXrNBGSi0WkOAyL
X-Google-Smtp-Source: APXvYqwEYQrCCD4l73LQI9uG8+8UutyWzslcMec//yj3nJte9/Aw8C3E/+xI7RKXTgdmMFuJqNBWuQ==
X-Received: by 2002:a05:6214:850:: with SMTP id dg16mr568859qvb.243.1568755603828;
        Tue, 17 Sep 2019 14:26:43 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:18b:e59f:6c80:981b? ([2604:6000:1014:c7c6:18b:e59f:6c80:981b])
        by smtp.gmail.com with ESMTPSA id z38sm2326868qtj.83.2019.09.17.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:26:43 -0700 (PDT)
Message-ID: <fbe5c62b275d8338d79617cdf6d0d6aadae5823f.camel@gmail.com>
Subject: Re: BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x330
 [btrfs]
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 17 Sep 2019 17:26:42 -0400
In-Reply-To: <752f6e85-7466-2773-932c-0bbc20c7bcd6@gmx.com>
References: <11898294e644baf5da8121f2c0f3d71e155a7352.camel@gmail.com>
         <752f6e85-7466-2773-932c-0bbc20c7bcd6@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 2019-09-15 at 14:56 +0800, Qu Wenruo wrote:
> 
> On 2019/9/15 上午4:52, Cebtenzzre wrote:
> > I have been able to trigger a use-after-free in btrfs on a stock Arch
> > Linux kernel, versions 5.2.9 and 5.2.11. I also reproduced it on
> > kernel.org mainline 5.3-rc8, resulting in this KASAN report:
> > 
> > 
> > [49286.511157] BTRFS info (device sdi1): balance: start -dvrange=2221681934336..2221681934337
> > [49286.515651] BTRFS info (device sdi1): relocating block group 2221681934336 flags data|raid0
> > [49294.092536] ==================================================================
> > [49294.092637] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> 
> It would be much nicer if you could provide the code context by using
> 1) gdb:
>    $gdb fs/btrfs/btrfs.ko
>     list *(btrfs_init_reloc_root+0x2bf)
> 
> 2) faddr2line scripts:
>    <in linux kernel source code directory>
>    $ ./scripts/faddr2line fs/btrfs/btrfs.kobtrfs_init_reloc_root+0x2bf

Unfortunately, I didn't have debug info on that build of 5.3-rc8. I did
have it enabled (though with CONFIG_DEBUG_INFO_REDUCED) on a build of
5.2.11, which gave me this report:

[10083.021120] BTRFS info (device sdi1): balance: start -dvrange=1256811659264..1256811659265
[10083.025073] BTRFS info (device sdi1): relocating block group 1256811659264 flags data|raid0
[10090.396218] ==================================================================
[10090.396266] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
[10090.396270] Write of size 8 at addr ffff88856f671710 by task kworker/u24:10/261579

[10090.396277] CPU: 2 PID: 261579 Comm: kworker/u24:10 Tainted: P           OE     5.2.11-arch1-1-kasan #4
[10090.396279] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
[10090.396303] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[10090.396306] Call Trace:
[10090.396312]  dump_stack+0x7b/0xba
[10090.396317]  print_address_description+0x6c/0x22e
[10090.396341]  ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
[10090.396344]  __kasan_report.cold+0x1b/0x3b
[10090.396368]  ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
[10090.396372]  kasan_report+0x12/0x17
[10090.396374]  __asan_report_store8_noabort+0x17/0x20
[10090.396397]  btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
[10090.396418]  record_root_in_trans+0x2a0/0x370 [btrfs]
[10090.396439]  btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
[10090.396459]  start_transaction+0x1ab/0xe90 [btrfs]
[10090.396485]  btrfs_join_transaction+0x1d/0x20 [btrfs]
[10090.396522]  btrfs_finish_ordered_io+0x7bf/0x18a0 [btrfs]
[10090.396528]  ? lock_repin_lock+0x400/0x400
[10090.396532]  ? __kmem_cache_shutdown.cold+0x140/0x1ad
[10090.396571]  ? btrfs_unlink_subvol+0x9b0/0x9b0 [btrfs]
[10090.396611]  finish_ordered_fn+0x15/0x20 [btrfs]
[10090.396648]  normal_work_helper+0x1bd/0xca0 [btrfs]
[10090.396652]  ? process_one_work+0x819/0x1720
[10090.396657]  ? kasan_check_read+0x11/0x20
[10090.396696]  btrfs_endio_write_helper+0x12/0x20 [btrfs]
[10090.396700]  process_one_work+0x8c9/0x1720
[10090.396709]  ? pwq_dec_nr_in_flight+0x2f0/0x2f0
[10090.396712]  ? worker_thread+0x1d9/0x1030
[10090.396723]  worker_thread+0x98/0x1030
[10090.396736]  kthread+0x2bb/0x3b0
[10090.396739]  ? process_one_work+0x1720/0x1720
[10090.396742]  ? kthread_park+0x120/0x120
[10090.396749]  ret_from_fork+0x35/0x40

[10090.396763] Allocated by task 369692:
[10090.396769]  __kasan_kmalloc.part.0+0x44/0xc0
[10090.396772]  __kasan_kmalloc.constprop.0+0xba/0xc0
[10090.396775]  kasan_kmalloc+0x9/0x10
[10090.396778]  kmem_cache_alloc_trace+0x138/0x260
[10090.396812]  btrfs_read_tree_root+0x92/0x360 [btrfs]
[10090.396846]  btrfs_read_fs_root+0x10/0xb0 [btrfs]
[10090.396882]  create_reloc_root+0x47d/0xa10 [btrfs]
[10090.396919]  btrfs_init_reloc_root+0x1e2/0x340 [btrfs]
[10090.396952]  record_root_in_trans+0x2a0/0x370 [btrfs]
[10090.396985]  btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
[10090.397019]  start_transaction+0x1ab/0xe90 [btrfs]
[10090.397052]  btrfs_start_transaction+0x1e/0x20 [btrfs]
[10090.397086]  __btrfs_prealloc_file_range+0x1c2/0xa00 [btrfs]
[10090.397120]  btrfs_prealloc_file_range+0x13/0x20 [btrfs]
[10090.397156]  prealloc_file_extent_cluster+0x29f/0x570 [btrfs]
[10090.397191]  relocate_file_extent_cluster+0x193/0xc30 [btrfs]
[10090.397227]  relocate_data_extent+0x1f8/0x490 [btrfs]
[10090.397263]  relocate_block_group+0x600/0x1060 [btrfs]
[10090.397298]  btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
[10090.397334]  btrfs_relocate_chunk+0x9e/0x180 [btrfs]
[10090.397371]  btrfs_balance+0x14e4/0x2fc0 [btrfs]
[10090.397407]  btrfs_ioctl_balance+0x47f/0x640 [btrfs]
[10090.397443]  btrfs_ioctl+0x119d/0x8380 [btrfs]
[10090.397446]  do_vfs_ioctl+0x9f5/0x1060
[10090.397449]  ksys_ioctl+0x67/0x90
[10090.397452]  __x64_sys_ioctl+0x73/0xb0
[10090.397456]  do_syscall_64+0xa5/0x370
[10090.397459]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[10090.397465] Freed by task 369692:
[10090.397470]  __kasan_slab_free+0x14f/0x210
[10090.397472]  kasan_slab_free+0xe/0x10
[10090.397475]  kfree+0xd8/0x270
[10090.397508]  btrfs_drop_snapshot+0x154c/0x1eb0 [btrfs]
[10090.397544]  clean_dirty_subvols+0x227/0x340 [btrfs]
[10090.397580]  relocate_block_group+0x972/0x1060 [btrfs]
[10090.397616]  btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
[10090.397652]  btrfs_relocate_chunk+0x9e/0x180 [btrfs]
[10090.397688]  btrfs_balance+0x14e4/0x2fc0 [btrfs]
[10090.397724]  btrfs_ioctl_balance+0x47f/0x640 [btrfs]
[10090.397760]  btrfs_ioctl+0x119d/0x8380 [btrfs]
[10090.397763]  do_vfs_ioctl+0x9f5/0x1060
[10090.397766]  ksys_ioctl+0x67/0x90
[10090.397769]  __x64_sys_ioctl+0x73/0xb0
[10090.397772]  do_syscall_64+0xa5/0x370
[10090.397775]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[10090.397782] The buggy address belongs to the object at ffff88856f671100
                which belongs to the cache kmalloc-4k of size 4096
[10090.397787] The buggy address is located 1552 bytes inside of
                4096-byte region [ffff88856f671100, ffff88856f672100)
[10090.397791] The buggy address belongs to the page:
[10090.397797] page:ffffea0015bd9c00 refcount:1 mapcount:0 mapping:ffff88864400e600 index:0x0 compound_mapcount: 0
[10090.397802] flags: 0x2ffff0000010200(slab|head)
[10090.397808] raw: 02ffff0000010200 dead000000000100 dead000000000200 ffff88864400e600
[10090.397812] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
[10090.397814] page dumped because: kasan: bad access detected

[10090.397819] Memory state around the buggy address:
[10090.397824]  ffff88856f671600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[10090.397829]  ffff88856f671680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[10090.397833] >ffff88856f671700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[10090.397836]                          ^
[10090.397841]  ffff88856f671780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[10090.397845]  ffff88856f671800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[10090.397849] ==================================================================
[10096.840443] BTRFS info (device sdi1): 1 enospc errors during balance
[10096.840447] BTRFS info (device sdi1): balance: ended with status: -28

So, I will be using the offsets from the above report instead of the
report from 5.3-rc8 that you are quoting.

> My config results something doesn't make sense at all.
> 
> > [49294.092645] Write of size 8 at addr ffff8885b4901440 by task kworker/u24:6/10894
> > 
> > [49294.092657] CPU: 8 PID: 10894 Comm: kworker/u24:6 Tainted: P           OE     5.3.0-rc8-rc-kasan #2
> > [49294.092661] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
> > [49294.092726] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
> > [49294.092730] Call Trace:
> > [49294.092743]  dump_stack+0x71/0xa0
> > [49294.092751]  print_address_description+0x67/0x323
> > [49294.092817]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> > [49294.092879]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> > [49294.092884]  __kasan_report.cold+0x1a/0x3d
> > [49294.092945]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
> > [49294.092951]  kasan_report+0xe/0x12
> > [49294.093012]  btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We need code contex of this,

That would be +0x2cd on my 5.2.11 build, which according to GDB is here:

(gdb)  list *(btrfs_init_reloc_root+0x2cd)
0x1dcbdd is in btrfs_init_reloc_root (fs/btrfs/relocation.c:1456).
1451		reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
1452		if (clear_rsv)
1453			trans->block_rsv = rsv;
1454	
1455		ret = __add_reloc_root(reloc_root);
1456		BUG_ON(ret < 0);
1457		root->reloc_root = reloc_root;
1458		return 0;
1459	}
1460

But according to faddr2line, it is at relocation.c:1438.

$ ./scripts/faddr2line fs/btrfs/btrfs.ko btrfs_init_reloc_root+0x2cd
btrfs_init_reloc_root+0x2cd/0x340:
btrfs_init_reloc_root at /path/to/linux/fs/btrfs/relocation.c:1438

That is here:

(gdb) list relocation.c:1438
1433		int clear_rsv = 0;
1434		int ret;
1435	
1436		if (root->reloc_root) {
1437			reloc_root = root->reloc_root;
1438			reloc_root->last_trans = trans->transid;
1439			return 0;
1440		}
1441	
1442		if (!rc || !rc->create_reloc_tree ||

> > [49294.093066]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
> > [49294.093119]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
> > [49294.093170]  start_transaction+0x1c3/0xea0 [btrfs]
> > [49294.093226]  btrfs_finish_ordered_io+0x811/0x1610 [btrfs]
> > [49294.093233]  ? syscall_return_via_sysret+0xf/0x7f
> > [49294.093238]  ? syscall_return_via_sysret+0xf/0x7f
> > [49294.093243]  ? __switch_to_asm+0x40/0x70
> > [49294.093248]  ? __switch_to_asm+0x34/0x70
> > [49294.093300]  ? btrfs_unlink_subvol+0xa30/0xa30 [btrfs]
> > [49294.093307]  ? finish_task_switch+0x1a1/0x760
> > [49294.093312]  ? __switch_to+0x457/0xe90
> > [49294.093317]  ? __switch_to_asm+0x34/0x70
> > [49294.093378]  normal_work_helper+0x15a/0xb90 [btrfs]
> > [49294.093387]  process_one_work+0x706/0x1200
> > [49294.093394]  worker_thread+0x92/0xfb0
> > [49294.093401]  ? __kthread_parkme+0x85/0x100
> > [49294.093406]  ? process_one_work+0x1200/0x1200
> > [49294.093410]  kthread+0x2ba/0x3b0
> > [49294.093414]  ? kthread_park+0x130/0x130
> > [49294.093420]  ret_from_fork+0x35/0x40
> > 
> > [49294.093431] Allocated by task 11689:
> > [49294.093441]  __kasan_kmalloc.part.0+0x3c/0xa0
> > [49294.093493]  btrfs_read_tree_root+0x8f/0x350 [btrfs]
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This,

GDB points here:

(gdb) list *(btrfs_read_tree_root+0x92)
0xb07c2 is in btrfs_read_tree_root (./include/linux/slab.h:742).
737	 * @size: how many bytes of memory are required.
738	 * @flags: the type of memory to allocate (see kmalloc).
739	 */
740	static inline void *kzalloc(size_t size, gfp_t flags)
741	{
742		return kmalloc(size, flags | __GFP_ZERO);
743	}
744	
745	/**
746	 * kzalloc_node - allocate zeroed memory from a particular memory node.

Whereas faddr2line points at slab.h:547, here:

(gdb) list slab.h:547
542			index = kmalloc_index(size);
543	
544			if (!index)
545				return ZERO_SIZE_PTR;
546	
547			return kmem_cache_alloc_trace(
548					kmalloc_caches[kmalloc_type(flags)][index],
549					flags, size);
550	#endif
551		}

btrfs_alloc_root calls kzalloc, so it looks like this is the inlined
result of that. It is called here:

(gdb) list disk-io.c:1434
1429	
1430		path = btrfs_alloc_path();
1431		if (!path)
1432			return ERR_PTR(-ENOMEM);
1433	
1434		root = btrfs_alloc_root(fs_info, GFP_NOFS);
1435		if (!root) {
1436			ret = -ENOMEM;
1437			goto alloc_fail;
1438		}

> > [49294.093542]  btrfs_read_fs_root+0xc/0xc0 [btrfs]
> > [49294.093601]  create_reloc_root+0x445/0x920 [btrfs]
> > [49294.093660]  btrfs_init_reloc_root+0x1da/0x330 [btrfs]
> > [49294.093709]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
> > [49294.093758]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
> > [49294.093806]  start_transaction+0x1c3/0xea0 [btrfs]
> > [49294.093856]  __btrfs_prealloc_file_range+0x1c2/0xa50 [btrfs]
> > [49294.093907]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]
> > [49294.093966]  prealloc_file_extent_cluster+0x24e/0x4a0 [btrfs]
> > [49294.094025]  relocate_file_extent_cluster+0x193/0xc90 [btrfs]
> > [49294.094083]  relocate_data_extent+0x1f2/0x460 [btrfs]
> > [49294.094142]  relocate_block_group+0x5a5/0xf50 [btrfs]
> > [49294.094200]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
> > [49294.094258]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
> > [49294.094315]  btrfs_balance+0x1292/0x2f00 [btrfs]
> > [49294.094373]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
> > [49294.094430]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
> > [49294.094434]  do_vfs_ioctl+0x99f/0xf10
> > [49294.094437]  ksys_ioctl+0x5e/0x90
> > [49294.094440]  __x64_sys_ioctl+0x6f/0xb0
> > [49294.094446]  do_syscall_64+0xa0/0x370
> > [49294.094451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > [49294.094457] Freed by task 11689:
> > [49294.094464]  __kasan_slab_free+0x144/0x1f0
> > [49294.094468]  kfree+0x95/0x2a0
> > [49294.094516]  btrfs_drop_snapshot+0x1529/0x1c40 [btrfs]
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> And this.

(gdb) list *(btrfs_drop_snapshot+0x154c)
0x7643c is in btrfs_drop_snapshot (fs/btrfs/disk-io.h:110).
105	}
106	
107	static inline void btrfs_put_fs_root(struct btrfs_root *root)
108	{
109		if (refcount_dec_and_test(&root->refs))
110			kfree(root);
111	}
112	
113	void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
114	int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,

faddr2line agrees with GDB on this one.

There is one direct call to btrfs_put_fs_root in btrfs_drop_snapshot,
here:

(gdb) list extent-tree.c:9446
9441		if (test_bit(BTRFS_ROOT_IN_RADIX, &root->state)) {
9442			btrfs_add_dropped_root(trans, root);
9443		} else {
9444			free_extent_buffer(root->node);
9445			free_extent_buffer(root->commit_root);
9446			btrfs_put_fs_root(root);
9447		}
9448		root_dropped = true;
9449	out_end_trans:
9450		btrfs_end_transaction_throttle(trans);

> > [49294.094573]  clean_dirty_subvols+0x23f/0x380 [btrfs]
> > [49294.094632]  relocate_block_group+0x95b/0xf50 [btrfs]
> > [49294.094691]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
> > [49294.094748]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
> > [49294.094805]  btrfs_balance+0x1292/0x2f00 [btrfs]
> > [49294.094863]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
> > [49294.094920]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
> > [49294.094923]  do_vfs_ioctl+0x99f/0xf10
> > [49294.094926]  ksys_ioctl+0x5e/0x90
> > [49294.094929]  __x64_sys_ioctl+0x6f/0xb0
> > [49294.094934]  do_syscall_64+0xa0/0x370
> > [49294.094939]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > [49294.094946] The buggy address belongs to the object at ffff8885b4901100
> >                 which belongs to the cache kmalloc-2k of size 2048
> > [49294.094953] The buggy address is located 832 bytes inside of
> >                 2048-byte region [ffff8885b4901100, ffff8885b4901900)
> > [49294.094957] The buggy address belongs to the page:
> > [49294.094962] page:ffffea0016d24000 refcount:1 mapcount:0 mapping:ffff88864400e800 index:0x0 compound_mapcount: 0
> > [49294.094968] flags: 0x2ffff0000010200(slab|head)
> > [49294.094976] raw: 02ffff0000010200 dead000000000100 dead000000000122 ffff88864400e800
> > [49294.094981] raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
> > [49294.094983] page dumped because: kasan: bad access detected
> > 
> > [49294.094987] Memory state around the buggy address:
> > [49294.094992]  ffff8885b4901300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [49294.094997]  ffff8885b4901380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [49294.095002] >ffff8885b4901400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [49294.095006]                                            ^
> > [49294.095010]  ffff8885b4901480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [49294.095015]  ffff8885b4901500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > [49294.095018] ==================================================================
> > [49301.893672] BTRFS info (device sdi1): 1 enospc errors during balance
> > [49301.893675] BTRFS info (device sdi1): balance: ended with status: -28
> > 
> > 
> > Without KASAN, I would eventually get an oops like this:
> > 
> > [...]
> > 
> > I only noticed this bug because I keep an eye on dmesg. In one instance,
> > I ignored it for a few hours, then my graphics driver crashed because of
> > memory allocation failure and/or heap corruption. Aside from that, I
> > have seen no obvious effects.
> > 
> > I have hit this bug at least 5 times over the last two weeks. Every
> > time, it has been caused by a balance on various volumes (typically to
> > balance a single block group). I was able to trigger it somewhat
> > reliably by attempting a balance on a volume with a size of 596.18GiB
> > and 1.68GiB of estimated free space, but that stopped working
> > eventually.
> 
> Is it always that particular fs?
> Have you ever hit it on another fs?
> Furthermore, did you hit it in v5.1?

I usually hit this on a raid0 data volume, but I got the same KASAN
report once while attemtping to balance my raid1 system volume.

I got the data volume into a state where it would consistently trigger
the bug (2.05GiB of free space), and did a few git bisects.

On v5.0, the balance correctly fails with ENOSPC.

As of commit d2311e69857815ae2f728b48e6730f833a617092 ("btrfs:
relocation: Delay reloc tree deletion after merge_reloc_roots"), first
appearing in v5.1-rc1, I get "kernel BUG at fs/btrfs/relocation.c:1413!"
at create_reloc_root+0x6a1/0x920 when attempting a balance.

As of commit 30d40577e322b670551ad7e2faa9570b6e23eb2b ("btrfs: reloc:
Also queue orphan reloc tree for cleanup to avoid BUG_ON()"), first
appearing in v5.2-rc3, I get the KASAN report instead of the BUG_ON.

> I guess there is a chance my previous change of reloc tree lifespan
> screwed up something, but it's introduced in v5.1...
> 
> Thanks,
> Qu
> 
-- 
Cebtenzzre <cebtenzzre@gmail.com>



