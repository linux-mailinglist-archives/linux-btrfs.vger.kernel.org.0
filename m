Return-Path: <linux-btrfs+bounces-19948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E778CD4BFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 06:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 266E530056D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 05:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD4325495;
	Mon, 22 Dec 2025 05:59:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1435975
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383168; cv=none; b=ecIHBIJurB9kRotVkMFo5GvfglXa9M252ho/+RiXbqbPIkxcyOyVH8dBPIjVzoWQFQKnVm50KCU2ifLE6lADs8UElapjIaUBpQkLrcntolh2oUgix47dNTZT7ArJVtLR5IZvI0FKh1w7VxV6UDMp3KeYqboPJZvivOUlvtXtKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383168; c=relaxed/simple;
	bh=Ol0ULvqI+CY82NUQZAPljrZ3uNHAInt1jvJcG4vITtw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TncNFiBfVD/TX929Dz9JVT3zBIJp9Jy7CPqxN8X/ZZC1lUAHJn5t/7q9o0n1MdHoCoGJld4rl8/LoOGK+V1MizF/V/ZHKz8ebGx8clk0jF82+3Yhcdq5U/w/n9nBU6g/1x6+RVXXpxLsn2t1EWXjpe+mnzYrN31+UzgyWgLKkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6579875eaa2so5897316eaf.3
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 21:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766383166; x=1766987966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8Q9TJLi3tt3NaPecdnBSgwyJmgeL2Dxv41cetZQ8k0=;
        b=aWF/Ikwq5Sm3dZ9/4QASdod0rwLWkCnqkuDi0uNEs2SnZjkl1FXcq+6LM4ilV2bqWb
         yc/DQC2YkT9ci03b6TgI4twzrnBXaCs/tC4fh5wJlrH+kLKMIFDTRdGjXRZdhlQbb5oj
         ILzRcKx59FzL2TCoCv8nxPkt7lmz/Unil5FNDvoZt9BSqlovr3csIH4vVFdBY4w7oTlL
         yCZcrRQB5NmlTtepAyOpiVTY+LMv56nXyYkumoGHJviTmnNj72mJpvzhI9rm/tEttbtZ
         7pq+RfcoEPRJC+Jk7hrm8pQa/IrWVcGWG/pQvd/qPb75HNovSyLFCRQ5e8qzxJhGqufw
         5lag==
X-Forwarded-Encrypted: i=1; AJvYcCXV5fN7gBl6e7Eo+qzn9tKj0BIFcgTCsK/iiljS1tM6oTOLrZ+np6iLrbCA0T8Fzx5xJ+hp0pn0qEe6ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp79OP7lcS5RSZZU0wTshrCILflPxYvbk4TDpyGHSSbn99vLac
	y1cYBdHKo7dOcFa3xTRUyqSJeRn//p75DIsFoqHTlRB6eT+YpEUIoFb36UPXzozsr5tfJJCqdOV
	utnhw36RI+xyUB76sxiKac6tTH29qvmoSTbVRwX/utCdOm63DzPsb357Pr+s=
X-Google-Smtp-Source: AGHT+IFcspNmm35RjZjBpM1QUYW4gqqzxwGAyRnoNGsbjKbhi0JGx+fyMrL7tsViZOhyzlTSXs6t9MgDPuLM7YX5FGNfZahubc47
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2224:b0:659:9a49:8fcd with SMTP id
 006d021491bc7-65d0ebd8a32mr5036275eaf.70.1766383165996; Sun, 21 Dec 2025
 21:59:25 -0800 (PST)
Date: Sun, 21 Dec 2025 21:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6948de3d.a70a0220.25eec0.0085.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btree_csum_one_bio
From: syzbot <syzbot+5340d8f484ed70362a87@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea1013c15392 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10547184580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=5340d8f484ed70362a87
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ea1013c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea4d0b50128d/vmlinux-ea1013c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2e7f1524121/bzImage-ea1013c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5340d8f484ed70362a87@syzkaller.appspotmail.com

 truncate_inode_items fs/btrfs/tree-log.c:4603 [inline]
 btrfs_log_inode+0xa68/0x4290 fs/btrfs/tree-log.c:7005
 btrfs_log_inode_parent+0xa99/0x1190 fs/btrfs/tree-log.c:7514
 btrfs_log_dentry_safe+0x62/0x80 fs/btrfs/tree-log.c:7616
 btrfs_sync_file+0xc33/0x1140 fs/btrfs/file.c:1733
 generic_write_sync include/linux/fs.h:2616 [inline]
 btrfs_do_write_iter+0x689/0x820 fs/btrfs/file.c:1470
page last free pid 5316 tgid 5316 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 __slab_free+0x21b/0x2a0 mm/slub.c:6004
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0x3cf/0x800 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x142/0x860 net/ipv6/route.c:3809
 ip6_route_add+0x49/0x1b0 net/ipv6/route.c:3938
 addrconf_add_mroute net/ipv6/addrconf.c:2552 [inline]
 addrconf_add_dev+0x23f/0x320 net/ipv6/addrconf.c:2570
 addrconf_dev_config net/ipv6/addrconf.c:3479 [inline]
 addrconf_init_auto_addrs+0x511/0xa00 net/ipv6/addrconf.c:3567
 addrconf_notify+0xb1e/0x1050 net/ipv6/addrconf.c:3740
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9802
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3158
BTRFS critical (device loop0): corrupt leaf: root=18446744073709551610 block=6459392 slot=4, csum end range (5730304) goes beyond the start range (5722112) of the next csum item
BTRFS info (device loop0): leaf 6459392 gen 12 total ptrs 6 free space 3222 owner 18446744073709551610
	item 0 key (263 INODE_ITEM 0) itemoff 3835 itemsize 160
		inode generation 11 transid 12 size 1048820 nbytes 11022913622198796681
		block group 0 mode 100000 links 1 uid 0 gid 0
		rdev 0 sequence 172 flags 0x10
		atime 1765950047.506420937
		ctime 1765950048.16420937
		mtime 1765950048.16420937
		otime 1765950047.506420937
	item 1 key (263 INODE_REF 256) itemoff 3822 itemsize 13
		index 7 name_len 3
	item 2 key (263 EXTENT_DATA 0) itemoff 3769 itemsize 53
		generation 12 type 1
		extent data disk bytenr 5382144 nr 1052672
		extent data offset 0 nr 348160 ram 1052672
		extent compression 0
	item 3 key (263 EXTENT_DATA 348160) itemoff 3716 itemsize 53
		generation 12 type 2
		extent data disk bytenr 5382144 nr 1052672
		extent data offset 348160 nr 704512 ram 1052672
		extent compression 0
	item 4 key (18446744073709551606 EXTENT_CSUM 5382144) itemoff 3376 itemsize 340
		range start 5382144 end 5730304 length 348160
	item 5 key (18446744073709551606 EXTENT_CSUM 5722112) itemoff 3372 itemsize 4
		range start 5722112 end 5726208 length 4096
BTRFS error (device loop0): block=6459392 write time tree block corruption detected
------------[ cut here ]------------
WARNING: fs/btrfs/disk-io.c:336 at btree_csum_one_bio+0x942/0xc90 fs/btrfs/disk-io.c:335, CPU#0: syz.0.0/5339
Modules linked in:
CPU: 0 UID: 0 PID: 5339 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btree_csum_one_bio+0x942/0xc90 fs/btrfs/disk-io.c:335
Code: ff 89 c6 e8 50 40 f1 fd 45 85 f6 75 07 e8 06 3c f1 fd eb 42 80 3d f1 b7 bb 0b 01 75 15 e8 f6 3b f1 fd eb 32 e8 ef 3b f1 fd 90 <0f> 0b 90 e9 61 fc ff ff e8 e1 3b f1 fd c6 05 ce b7 bb 0b 01 48 c7
RSP: 0018:ffffc9000ad1e5e0 EFLAGS: 00010246
RAX: ffffffff83d08601 RBX: fffffffffffffffa RCX: 0000000000100000
RDX: ffffc90020f72000 RSI: 00000000000fffff RDI: 0000000000100000
RBP: ffffc9000ad1e6d0 R08: ffffffff8fa24077 R09: 1ffffffff1f4480e
R10: dffffc0000000000 R11: fffffbfff1f4480f R12: ffffffff83d082d2
R13: 00000000ffffff8b R14: ffff88800016a05f R15: dffffc0000000000
FS:  00007f02f34c46c0(0000) GS:ffff88808d22a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612c43ffae8 CR3: 00000000379c8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 btrfs_bio_csum fs/btrfs/bio.c:584 [inline]
 btrfs_submit_chunk fs/btrfs/bio.c:835 [inline]
 btrfs_submit_bbio+0x1458/0x1dc0 fs/btrfs/bio.c:907
 btree_write_cache_pages+0xab7/0x1150 fs/btrfs/extent_io.c:2356
 do_writepages+0x32e/0x550 mm/page-writeback.c:2598
 filemap_writeback mm/filemap.c:387 [inline]
 filemap_fdatawrite_range+0x1a5/0x250 mm/filemap.c:412
 btrfs_write_marked_extents+0x18c/0x2d0 fs/btrfs/transaction.c:1164
 btrfs_sync_log+0x8d1/0x2a10 fs/btrfs/tree-log.c:3379
 btrfs_sync_file+0xce9/0x1140 fs/btrfs/file.c:1771
 generic_write_sync include/linux/fs.h:2616 [inline]
 btrfs_do_write_iter+0x689/0x820 fs/btrfs/file.c:1470
 iter_file_splice_write+0x972/0x10b0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f02f258f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02f34c4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f02f27e5fa0 RCX: 00007f02f258f7c9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000008
RBP: 00007f02f2613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000200201005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f02f27e6038 R14: 00007f02f27e5fa0 R15: 00007ffd3fc08a98
 </TASK>


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

