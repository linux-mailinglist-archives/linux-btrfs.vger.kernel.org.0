Return-Path: <linux-btrfs+bounces-6199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FB927951
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9464FB22844
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A7B1B013E;
	Thu,  4 Jul 2024 14:52:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF921A0B1D
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104742; cv=none; b=lrWRr5/QCz0vQgAAfhUHzMpUjWyjFWwUI0SG9KqrIbIz/+NjhoTt9h5bVbLT51m9ZXzJ2qCeNWQHluB/Jxy9nrRGSQz5n9TvwK+TCVdnQcxacAry7YJ49qztXr/HCivkfmwj2NRI1LjQf5FKytnizQZtsNsbpISSjfcCsrBpxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104742; c=relaxed/simple;
	bh=fh8UaNTe6dJPWG4ExLHR44G/dJQwpFMb7BtOe58jb4U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BisN1t9BvJEvf5y+WhFt0ImTB15JFJg+uj6LLvDWFDdfyXTla6KBUdJIBbmg9CFOIbs2Nos/It3avuFpPtnZyWPUdBxj8/RWtPC+j86Edsn0pwW89oFFzKYjgFAy316ZPKVxKHLJiANrDOjpGCQKjS4hV6bo92ONv4V22dCSDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f439f51960so91498639f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jul 2024 07:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104740; x=1720709540;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU4PWz80KO4L+p2qGiMC26Cz9q9D0r7yngYb7NAbPKo=;
        b=dlBqcfGVgs9bDm9AQCLTlLQm1EFNVZj9yj8FBjpHJDfQcb9lc5QtkrDMgdIcq1B7ej
         BoVKv88tG9rQlSQx/WPQgoJ4eV9lzcoi7CiBr9W5z/zyT+kSYg+1nOQ1Y2xRTy+GS5Sz
         Y0daAZNL5BSWhV+ix8aOAwOoqhqWmGNwR0Tv+TBOTx00n8rDN8cAjxnGCOkvtiNmv6zk
         vAVPJg6kniXp7QRo7hfDuYTZ2LCZsqrXa7Ul51r6AZIgjrg0ZPgpXPaETFD5pKobBGVI
         M0FRsEz47xuQoaHo80hwYPN7e1nN9XYETlrCT7mmEJKtn8Uv+3Artj9VL5r6rXqqVC6S
         Z1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoSDkH5WPRQvmTCZSMOy6RGzTj7amkye5Djz2b4pgEpu03wsShsv9DXUGSz2+dV4IVC8aYyGVOe7mx6AXZfsUNvQR2WY3eqiXnUwA=
X-Gm-Message-State: AOJu0YwcqwbTS14nvzGjFdQh4rNeVBccnCPyCVgk+eEfxjj0pn1NuD9Z
	8EqaR1+tZoVhMjySnIib+HXzG95S4au6hELb/KbIF2TySOEdCN6ixWA2nc0lTtizDrjGa20TP/q
	XYZcff4LDIhdi2X999hXeUndq/4Ydor/pcMkVZRjF+ngA8yNFGZZyxqE=
X-Google-Smtp-Source: AGHT+IHJlAM7Klvz96by5QYCtnob848x0tHqpZQCJYGhtqJUjFgr4PAbO0EuQ/aVtxwz+CvjmxA7itEPIT3KB+5B0r7mhttWA5Aa
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1510:b0:7f6:1f4c:96b6 with SMTP id
 ca18e2360f4ac-7f66df22eb3mr12523939f.3.1720104740155; Thu, 04 Jul 2024
 07:52:20 -0700 (PDT)
Date: Thu, 04 Jul 2024 07:52:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000038144061c6d18f2@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in add_ra_bio_pages (3)
From: syzbot <syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    563a50672d8a Merge tag 'xfs-6.10-fixes-4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121b7c12980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24262d81a9225c6
dashboard link: https://syzkaller.appspot.com/bug?extid=853d80cba98ce1157ae6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-563a5067.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a93ed9769202/vmlinux-563a5067.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0cca71a4aab6/bzImage-563a5067.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in add_ra_bio_pages.constprop.0.isra.0+0xf03/0xfb0 fs/btrfs/compression.c:529
Read of size 8 at addr ffff88805a317178 by task syz-executor.2/12977

CPU: 0 PID: 12977 Comm: syz-executor.2 Not tainted 6.10.0-rc4-syzkaller-00283-g563a50672d8a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 add_ra_bio_pages.constprop.0.isra.0+0xf03/0xfb0 fs/btrfs/compression.c:529
 btrfs_submit_compressed_read+0x5fb/0x930 fs/btrfs/compression.c:617
 submit_one_bio+0x15c/0x1c0 fs/btrfs/extent_io.c:118
 btrfs_readahead+0x132b/0x15c0 fs/btrfs/extent_io.c:2318
 read_pages+0x1a8/0xd80 mm/readahead.c:160
 page_cache_ra_unbounded+0x2d8/0x5a0 mm/readahead.c:273
 do_page_cache_ra mm/readahead.c:303 [inline]
 page_cache_ra_order+0x6e5/0xae0 mm/readahead.c:547
 ondemand_readahead+0x520/0x1140 mm/readahead.c:669
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:696
 page_cache_sync_readahead include/linux/pagemap.h:1306 [inline]
 filemap_get_pages+0xc01/0x1830 mm/filemap.c:2529
 filemap_read+0x3af/0xd10 mm/filemap.c:2625
 btrfs_file_read_iter+0x1dc/0x840 fs/btrfs/file.c:4025
 copy_splice_read+0x615/0xb80 fs/splice.c:365
 do_splice_read fs/splice.c:984 [inline]
 do_splice_read+0x2cf/0x380 fs/splice.c:959
 splice_direct_to_actor+0x2a4/0xa40 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x17e/0x250 fs/splice.c:1233
 do_sendfile+0xb1e/0xe50 fs/read_write.c:1295
 __do_compat_sys_sendfile fs/read_write.c:1383 [inline]
 __se_compat_sys_sendfile fs/read_write.c:1366 [inline]
 __ia32_compat_sys_sendfile+0x1e7/0x230 fs/read_write.c:1366
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72b9579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5e8a5ac EFLAGS: 00000292 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000000004
RDX: 0000000000000000 RSI: 0000000000201005 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 12977:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4008
 alloc_extent_map+0x1c/0x100 fs/btrfs/extent_map.c:48
 btrfs_get_extent+0x223/0x1aa0 fs/btrfs/inode.c:6826
 btrfs_dio_iomap_begin+0x6e9/0x1e40 fs/btrfs/inode.c:7617
 iomap_iter+0x61f/0x1080 fs/iomap/iter.c:91
 __iomap_dio_rw+0x6ba/0x1c70 fs/iomap/direct-io.c:659
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:749
 btrfs_dio_read+0xb1/0xf0 fs/btrfs/inode.c:7881
 btrfs_direct_read fs/btrfs/file.c:3980 [inline]
 btrfs_file_read_iter+0x5c4/0x840 fs/btrfs/file.c:4019
 copy_splice_read+0x615/0xb80 fs/splice.c:365
 do_splice_read fs/splice.c:984 [inline]
 do_splice_read+0x2cf/0x380 fs/splice.c:959
 splice_direct_to_actor+0x2a4/0xa40 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x17e/0x250 fs/splice.c:1233
 do_sendfile+0xb1e/0xe50 fs/read_write.c:1295
 __do_compat_sys_sendfile fs/read_write.c:1383 [inline]
 __se_compat_sys_sendfile fs/read_write.c:1366 [inline]
 __ia32_compat_sys_sendfile+0x1e7/0x230 fs/read_write.c:1366
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 12977:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4512
 free_extent_map fs/btrfs/extent_map.c:68 [inline]
 free_extent_map+0xeb/0x140 fs/btrfs/extent_map.c:61
 add_ra_bio_pages.constprop.0.isra.0+0x772/0xfb0 fs/btrfs/compression.c:517
 btrfs_submit_compressed_read+0x5fb/0x930 fs/btrfs/compression.c:617
 submit_one_bio+0x15c/0x1c0 fs/btrfs/extent_io.c:118
 btrfs_readahead+0x132b/0x15c0 fs/btrfs/extent_io.c:2318
 read_pages+0x1a8/0xd80 mm/readahead.c:160
 page_cache_ra_unbounded+0x2d8/0x5a0 mm/readahead.c:273
 do_page_cache_ra mm/readahead.c:303 [inline]
 page_cache_ra_order+0x6e5/0xae0 mm/readahead.c:547
 ondemand_readahead+0x520/0x1140 mm/readahead.c:669
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:696
 page_cache_sync_readahead include/linux/pagemap.h:1306 [inline]
 filemap_get_pages+0xc01/0x1830 mm/filemap.c:2529
 filemap_read+0x3af/0xd10 mm/filemap.c:2625
 btrfs_file_read_iter+0x1dc/0x840 fs/btrfs/file.c:4025
 copy_splice_read+0x615/0xb80 fs/splice.c:365
 do_splice_read fs/splice.c:984 [inline]
 do_splice_read+0x2cf/0x380 fs/splice.c:959
 splice_direct_to_actor+0x2a4/0xa40 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x17e/0x250 fs/splice.c:1233
 do_sendfile+0xb1e/0xe50 fs/read_write.c:1295
 __do_compat_sys_sendfile fs/read_write.c:1383 [inline]
 __se_compat_sys_sendfile fs/read_write.c:1366 [inline]
 __ia32_compat_sys_sendfile+0x1e7/0x230 fs/read_write.c:1366
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff88805a317160
 which belongs to the cache btrfs_extent_map of size 112
The buggy address is located 24 bytes inside of
 freed 112-byte region [ffff88805a317160, ffff88805a3171d0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5a317
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 04fff00000000000 ffff888025885900 ffffea0001570100 0000000000000006
raw: 0000000000000000 0000000080170017 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 40, tgid 40 (kworker/u32:2), ts 494044152115, free_ts 493554824903
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4008
 alloc_extent_map fs/btrfs/extent_map.c:48 [inline]
 btrfs_drop_extent_map_range+0xb7/0x13d0 fs/btrfs/extent_map.c:719
 btrfs_replace_extent_map_range+0xfb/0x1b0 fs/btrfs/extent_map.c:932
 create_io_em+0x22c/0x760 fs/btrfs/inode.c:7361
 cow_file_range+0x530/0xeb0 fs/btrfs/inode.c:1438
 run_delalloc_cow+0xa7/0x150 fs/btrfs/inode.c:1751
 submit_uncompressed_range.isra.0+0x124/0x350 fs/btrfs/inode.c:1128
 submit_one_async_extent fs/btrfs/inode.c:1179 [inline]
 submit_compressed_extents+0x732/0x13a0 fs/btrfs/inode.c:1641
 run_ordered_work fs/btrfs/async-thread.c:245 [inline]
 btrfs_work_helper+0x2d2/0xc90 fs/btrfs/async-thread.c:324
page last free pid 12763 tgid 12762 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 __folio_put+0x239/0x360 mm/swap.c:129
 folio_put include/linux/mm.h:1508 [inline]
 put_page include/linux/mm.h:1580 [inline]
 skb_page_unref include/linux/skbuff_ref.h:44 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:57 [inline]
 skb_release_data+0x5df/0x980 net/core/skbuff.c:1102
 skb_release_all net/core/skbuff.c:1173 [inline]
 __kfree_skb+0x4f/0x70 net/core/skbuff.c:1187
 tcp_wmem_free_skb include/net/tcp.h:306 [inline]
 tcp_write_queue_purge+0x188/0xd60 net/ipv4/tcp.c:3000
 tcp_v4_destroy_sock+0xfa/0x590 net/ipv4/tcp_ipv4.c:2524
 inet_csk_destroy_sock+0x1a3/0x450 net/ipv4/inet_connection_sock.c:1225
 __tcp_close+0xbfc/0xfe0 net/ipv4/tcp.c:2947
 tcp_close+0x28/0x130 net/ipv4/tcp.c:2959
 inet_release+0x13c/0x280 net/ipv4/af_inet.c:437
 __sock_release+0xb0/0x270 net/socket.c:659
 sock_close+0x1c/0x30 net/socket.c:1421
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 get_signal+0x1d3/0x2670 kernel/signal.c:2681
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310

Memory state around the buggy address:
 ffff88805a317000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88805a317080: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
>ffff88805a317100: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
                                                                ^
 ffff88805a317180: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
 ffff88805a317200: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

