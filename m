Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA227E163D
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjKEUMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 15:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKEUMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 15:12:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B2D8
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1699215122; x=1699819922; i=quwenruo.btrfs@gmx.com;
        bh=2wl/dVcqKwkf0vEDPYGE0jbkH5qqCQtlDJw9Pwh2yqo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=onbMm8xzdjJt8u0laIq46XR+h+ecEB9mun7PnMb3ylIyycj3OZeTdAnRBtrZ4bKa
         yOUnbkdXdarU+PxTwKp2eET1akvkvMcbEYkzdAnfXMZuFje2k8v1u8diDIQIyf9cI
         QKmNByKHJmGVgC8b4P1FU9il0zsnm9Z2qxGnzVwY+2YcwneQpj3n5F+L1AdkMfCfd
         C8v2+1Go3XokEx3PJ3kc0HN2ZIlQA02fjIoNcbf6VbdXTuwzaN5Vp/3M5DTtpqaKz
         UKwsdNnP3A+kr7hnJSf2eizpooGl9Ucqbykb2dinBysurqorZcsEvM6/+9uqymsJ0
         mPazfE3iLlYsZ3dy2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1rAQjA0g6D-00BHwj; Sun, 05
 Nov 2023 21:12:02 +0100
Message-ID: <08c1668a-8652-421b-b6d4-179f7d31f1cd@gmx.com>
Date:   Mon, 6 Nov 2023 06:41:57 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix race between accounting qgroup extents and
 removing a qgroup
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <c339c5643ceba67771b559ffae0fb4c169426cef.1699014305.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <c339c5643ceba67771b559ffae0fb4c169426cef.1699014305.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PhTXT7hdAxYSXsF/T1v/LtjP6LKbk2CW6DkdWACyYIe1D0aOuol
 9dhuKU50A4snISWOkofwXzULcEcHBmvgN6K/VgGMhB7CtfGm3tl/eqdhPXOQp9e9zTMkY5b
 LNp8+mK5YU0qeEJ43zJl+2mXyBFo/aQSEJEuvF4b/pn4b8UfAc0QUB+pdm6CGURwKIQP3+b
 bQsJDdHsZ5mJmGLskvq6w==
UI-OutboundReport: notjunk:1;M01:P0:0fmsHwr/tDc=;gm9V24CzD8mQ4lgBdw15gkW/Sk4
 Ofh+Qqnp9DC0pfHqJXrJoyf/YpKJibEVZrOGEzXXqDQdgtK4HXos7tPJH+pPPCUg+LIpCnSlD
 0klgkpYucE4ToBL083ACu84Hlu4SfDZqxrhl3UWx0KfKolF2VaLj6wPEm66IthS11tzf1Wlbp
 l411M46cZ8x/JcvqWlPZw+gAjFpULV3lbOhkxdejNktZJ6G2MV5f3BQfMGkEaOCugjdnapQ7T
 C78i3GCDaLXjvBRGV0XygczXoap/M8xEdBRtZGVVu63VegUkJLI3t8qRPJXLyl8vaRlgc2N/M
 opOzi73BKuthW/S0IpM+MN5r8rNKCulOJDOznrM//FoNRr9d7N7EMwbhgd7QfyebSfiJ386ex
 djIXT02M49ZodCfLOLbNJPBrk03AjHFX1rPscW/GhvHBOWOOgtlciwOKxUVZ+9/Fj1C67B2l1
 7DYshFKn9q7xXCk53cDVsxrJdzMxC2RnszpUaqSs2Io1fekacOC9xkYltS55/BCt22Om/cBzi
 1r0o7MYmhMfo+1eSGTBbk1D1ABIm6H+eZrWTME44LfSGMoTc3sXGnsBpgs6vSdUJmn4NMMtkB
 aeJ4QSWFvKqjyzSZHK+niLl7zZOkRuv+k/xUn36Po+eqi4aAtS+pRGBXfZo3+fCm62Gw8vRg5
 HYRJacK1EtPCugPFlMIUhhkWr7NGiRvhkEQ2yw34lebqfYnzeUpMRgNKarDmkmbJkAjJRQ1l1
 XT/2T1WlfDELQMIiT/OEp412WVrm7rCReUt5A4QcOHp64mpkwUMX/K/QaTdFfgYs0jkiYDwmI
 xOdN4wm4AZvLCe7WMKcFaw9p+cmZWMkjzWFnUMPsKa+NXQeCmZ0rYTPKYi/Jvm9W9oqCyBRKk
 kv2cUTY+dxDbUPrWgDreDALhHt5KOiSZvHIBcx2zYXJQNQjKX8Wy/FkVB6oaDizzHOMiINePM
 TrzrFQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 22:56, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When doing qgroup accounting for an extent, we take the spinlock
> fs_info->qgroup_lock and then add qgroups to the local list (iterator)
> named "qgroups". These qgroups are found in the fs_info->qgroup_tree
> rbtree. After we're done, we unlock fs_info->qgroup_lock and then call
> qgroup_iterator_nested_clean(), which will iterate over all the qgroups
> added to the local list "qgroups" and then delete them from the list.
> Deleting a qgroup from the list can however result in a use-after-free
> if a qgroup remove operation happens after we unlock fs_info->qgroup_loc=
k
> and before or while we are at qgroup_iterator_nested_clean().
>
> Fix this by calling qgroup_iterator_nested_clean() while still holding
> the lock fs_info->qgroup_lock - we don't need it under the 'out' label
> since before taking the lock the "qgroups" list is always empty. This
> guarantees safety because btrfs_remove_qgroup() takes that lock before
> removing a qgroup from the rbtree fs_info->qgroup_tree.
>
> This was reported by syzbot with the following stack traces:
>
>     BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+=
0x2f/0x130 lib/list_debug.c:49
>     Read of size 8 at addr ffff888027e420b0 by task kworker/u4:3/48
>
>     CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.6.0-syzkaller-10396-=
g4652b8e4f3ff #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 10/09/2023
>     Workqueue: btrfs-qgroup-rescan btrfs_work_helper
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:88 [inline]
>      dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>      print_address_description mm/kasan/report.c:364 [inline]
>      print_report+0x163/0x540 mm/kasan/report.c:475
>      kasan_report+0x175/0x1b0 mm/kasan/report.c:588
>      __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
>      __list_del_entry_valid include/linux/list.h:124 [inline]
>      __list_del_entry include/linux/list.h:215 [inline]
>      list_del_init include/linux/list.h:287 [inline]
>      qgroup_iterator_nested_clean fs/btrfs/qgroup.c:2623 [inline]
>      btrfs_qgroup_account_extent+0x18b/0x1150 fs/btrfs/qgroup.c:2883
>      qgroup_rescan_leaf fs/btrfs/qgroup.c:3543 [inline]
>      btrfs_qgroup_rescan_worker+0x1078/0x1c60 fs/btrfs/qgroup.c:3604
>      btrfs_work_helper+0x37c/0xbd0 fs/btrfs/async-thread.c:315
>      process_one_work kernel/workqueue.c:2630 [inline]
>      process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>      worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>      kthread+0x2d3/0x370 kernel/kthread.c:388
>      ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>      </TASK>
>
>     Allocated by task 6355:
>      kasan_save_stack mm/kasan/common.c:45 [inline]
>      kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>      ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>      __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>      kmalloc include/linux/slab.h:600 [inline]
>      kzalloc include/linux/slab.h:721 [inline]
>      btrfs_quota_enable+0xee9/0x2060 fs/btrfs/qgroup.c:1209
>      btrfs_ioctl_quota_ctl+0x143/0x190 fs/btrfs/ioctl.c:3705
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:871 [inline]
>      __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>     Freed by task 6355:
>      kasan_save_stack mm/kasan/common.c:45 [inline]
>      kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>      kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
>      ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>      kasan_slab_free include/linux/kasan.h:164 [inline]
>      slab_free_hook mm/slub.c:1800 [inline]
>      slab_free_freelist_hook mm/slub.c:1826 [inline]
>      slab_free mm/slub.c:3809 [inline]
>      __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
>      btrfs_remove_qgroup+0x764/0x8c0 fs/btrfs/qgroup.c:1787
>      btrfs_ioctl_qgroup_create+0x185/0x1e0 fs/btrfs/ioctl.c:3811
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:871 [inline]
>      __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>     Last potentially related work creation:
>      kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
>      __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
>      __call_rcu_common kernel/rcu/tree.c:2667 [inline]
>      call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
>      kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
>      kthread+0x2d3/0x370 kernel/kthread.c:388
>      ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>
>     Second to last potentially related work creation:
>      kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
>      __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
>      __call_rcu_common kernel/rcu/tree.c:2667 [inline]
>      call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
>      kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
>      kthread+0x2d3/0x370 kernel/kthread.c:388
>      ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>
>     The buggy address belongs to the object at ffff888027e42000
>      which belongs to the cache kmalloc-512 of size 512
>     The buggy address is located 176 bytes inside of
>      freed 512-byte region [ffff888027e42000, ffff888027e42200)
>
>     The buggy address belongs to the physical page:
>     page:ffffea00009f9000 refcount:1 mapcount:0 mapping:0000000000000000=
 index:0x0 pfn:0x27e40
>     head:ffffea00009f9000 order:2 entire_mapcount:0 nr_pages_mapped:0 pi=
ncount:0
>     flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7=
ff)
>     page_type: 0xffffffff()
>     raw: 00fff00000000840 ffff888012c41c80 ffffea0000a5ba00 dead00000000=
0002
>     raw: 0000000000000000 0000000080100010 00000001ffffffff 000000000000=
0000
>     page dumped because: kasan: bad access detected
>     page_owner tracks the page as allocated
>     page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd=
20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMAL=
LOC), pid 4514, tgid 4514 (udevadm), ts 24598439480, free_ts 23755696267
>      set_page_owner include/linux/page_owner.h:31 [inline]
>      post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
>      prep_new_page mm/page_alloc.c:1543 [inline]
>      get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
>      __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
>      alloc_slab_page+0x6a/0x160 mm/slub.c:1870
>      allocate_slab mm/slub.c:2017 [inline]
>      new_slab+0x84/0x2f0 mm/slub.c:2070
>      ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
>      __slab_alloc mm/slub.c:3322 [inline]
>      __slab_alloc_node mm/slub.c:3375 [inline]
>      slab_alloc_node mm/slub.c:3468 [inline]
>      __kmem_cache_alloc_node+0x19d/0x270 mm/slub.c:3517
>      kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
>      kmalloc include/linux/slab.h:600 [inline]
>      kzalloc include/linux/slab.h:721 [inline]
>      kernfs_fop_open+0x3e7/0xcc0 fs/kernfs/file.c:670
>      do_dentry_open+0x8fd/0x1590 fs/open.c:948
>      do_open fs/namei.c:3622 [inline]
>      path_openat+0x2845/0x3280 fs/namei.c:3779
>      do_filp_open+0x234/0x490 fs/namei.c:3809
>      do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
>      do_sys_open fs/open.c:1455 [inline]
>      __do_sys_openat fs/open.c:1471 [inline]
>      __se_sys_openat fs/open.c:1466 [inline]
>      __x64_sys_openat+0x247/0x290 fs/open.c:1466
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>     page last free stack trace:
>      reset_page_owner include/linux/page_owner.h:24 [inline]
>      free_pages_prepare mm/page_alloc.c:1136 [inline]
>      free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
>      free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
>      discard_slab mm/slub.c:2116 [inline]
>      __unfreeze_partials+0x1dc/0x220 mm/slub.c:2655
>      put_cpu_partial+0x17b/0x250 mm/slub.c:2731
>      __slab_free+0x2b6/0x390 mm/slub.c:3679
>      qlink_free mm/kasan/quarantine.c:166 [inline]
>      qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:185
>      kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
>      __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
>      kasan_slab_alloc include/linux/kasan.h:188 [inline]
>      slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
>      slab_alloc_node mm/slub.c:3478 [inline]
>      slab_alloc mm/slub.c:3486 [inline]
>      __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>      kmem_cache_alloc+0x104/0x2c0 mm/slub.c:3502
>      getname_flags+0xbc/0x4f0 fs/namei.c:140
>      do_sys_openat2+0xd2/0x1d0 fs/open.c:1434
>      do_sys_open fs/open.c:1455 [inline]
>      __do_sys_openat fs/open.c:1471 [inline]
>      __se_sys_openat fs/open.c:1466 [inline]
>      __x64_sys_openat+0x247/0x290 fs/open.c:1466
>      do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>      do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>      entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>     Memory state around the buggy address:
>      ffff888027e41f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff888027e42000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     >ffff888027e42080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                          ^
>      ffff888027e42100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff888027e42180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
> Fixes: dce28769a33a ("btrfs: qgroup: use qgroup_iterator_nested to in qg=
roup_update_refcnt()")
> Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000091a5b2060936bf6d@g=
oogle.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index edb84cc03237..e48eba7e9379 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2874,13 +2874,19 @@ int btrfs_qgroup_account_extent(struct btrfs_tra=
ns_handle *trans, u64 bytenr,
>   	qgroup_update_counters(fs_info, &qgroups, nr_old_roots, nr_new_roots,
>   			       num_bytes, seq);
>
> +	/*
> +	 * We're done using the iterator, release all its qgroups while holdin=
g
> +	 * fs_info->qgroup_lock so that we don't race with btrfs_remove_qgroup=
()
> +	 * and trigger use-after-free accesses to qgroups.
> +	 */
> +	qgroup_iterator_nested_clean(&qgroups);
> +
>   	/*
>   	 * Bump qgroup_seq to avoid seq overlap
>   	 */
>   	fs_info->qgroup_seq +=3D max(nr_old_roots, nr_new_roots) + 1;
>   	spin_unlock(&fs_info->qgroup_lock);
>   out_free:
> -	qgroup_iterator_nested_clean(&qgroups);
>   	ulist_free(old_roots);
>   	ulist_free(new_roots);
>   	return ret;
