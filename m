Return-Path: <linux-btrfs+bounces-10192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804429EB010
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 12:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213A318884CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3400210F6D;
	Tue, 10 Dec 2024 11:42:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEE2080D2
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830946; cv=none; b=fIEwknZbowS4iZBer3XxlFeTeDGQhsYP3FvSo0avAhf+taov637OcWt6mSzRbHyinTLEtG5bvInsYyt/UVctMxtaZ+gmbIINWvdyMgjYEz3bxi2yaA2JSSss+wtbUcg204Vx/Yz0ERSoGJRqbE6ooSm9nNqe3x7k1SzV4SehX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830946; c=relaxed/simple;
	bh=UW7nVJgMSDsCk5nhpkvy5y90xLmpM24XXSYiM05EBhc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h+CMXuBVOAP9v3yh/a3z01s/UeVKrsmSmzHDsUviXs7iqnOej+UnNs6u17jl4JulcOncLQLMAPIbxVuVEGjOdx2CZTZnqq8H8ixN5moNtFrQvPSsV3k7XbU1UKHw2Fbo85ZuZET+3Zw7CwsFci3+2opNvG47InUM5uMBdshGxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9cf5b47f8so27883905ab.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 03:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830944; x=1734435744;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5m2IMBwyvKGjD4ASF9enDVMm3TnL+MXwspx2kXIXm4k=;
        b=j13DkKwbe6Fhh6dPm9Ec++7iPDE9/QJ7uj79AiqnQsFIREa+QOFZemeSup0MhMWDEA
         Dsmj5hQW34LanzN4dQCOnG0VWrCnfVwNxIIUfi+z1dyAGwpNL111zs0rRdwTwOb7+q+2
         M6D8Rgcg+1vRf142MzRA5QnooT0kNbX9Vr431LcbwS8Yv0VyJiN9Z+IqAqXUDxgRFuoY
         udI1ozNUn1R7rMbaRmx/2gljuav+Iles6BdFGq0Dy4OV2G1+Iu8vV17MWwwUtKs5SVKE
         CvYOyzrDYY3KjTMt/ZxrZK96iZkz34gjF/EnuGlda9C3VbklZBuWhUEhChF4RcHbXqzg
         bi2A==
X-Forwarded-Encrypted: i=1; AJvYcCX9rydwxJpnldlQg52oGKVjPLPu9j0prNvhnB+nR+TRf2i02OBP44q9dmGZMmSwXFpTxJQOb5MyWPyqNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YymN+i9Xdv0QH9RNzyju77IEX90y2MWO2cX1elKKXnrGfNg1QpW
	KOgT7AL0/BPbgeJxTscuwwf7RunQ7m6xIeKpxHuqou8XBVm6zMetk9Z9+uCq/xQmnqVBsk16HS2
	NQgdAHdE9GNjo7ve92ED0Pv8GbCYONRlq2V+OyTOP2dTpmoPD2oTMgHU=
X-Google-Smtp-Source: AGHT+IGBQssi01htYmZEm14m55mxtFLRLISagzgoDQduMbwA+tF8VeW+YEPZThfeQGhlh05jVAPdusLO3m/3pIufPA3yEt7k0nn9
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:3a7:7e0f:777d with SMTP id
 e9e14a558f8ab-3a9dbac727amr36369765ab.11.1733830943814; Tue, 10 Dec 2024
 03:42:23 -0800 (PST)
Date: Tue, 10 Dec 2024 03:42:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6758291f.050a0220.a30f1.01ce.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in create_pending_snapshot (2)
From: syzbot <syzbot+76f08f4610b770486522@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5076001689e4 Merge tag 'loongarch-fixes-6.13-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ead0f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=76f08f4610b770486522
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-50760016.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76ef343a98c8/vmlinux-50760016.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e42b3235bcc3/bzImage-50760016.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76f08f4610b770486522@syzkaller.appspotmail.com

BTRFS error (device loop0): allocation failed flags 12, wanted 4096 tree-log 0, relocation: 0
BTRFS info (device loop0): space_info DATA+METADATA has 8323072 free, is full
BTRFS info (device loop0): space_info total=11534336, used=1114112, pinned=0, reserved=0, may_use=2097152, readonly=0 zone_unusable=0
BTRFS info (device loop0): global_block_rsv: size 1441792 reserved 1441792
BTRFS info (device loop0): trans_block_rsv: size 0 reserved 0
BTRFS info (device loop0): chunk_block_rsv: size 0 reserved 0
BTRFS info (device loop0): delayed_block_rsv: size 0 reserved 0
BTRFS info (device loop0): delayed_refs_rsv: size 0 reserved 0
BTRFS info (device loop0): block group 5242880 has 1638400 bytes, 1114112 used 0 pinned 0 reserved 0 delalloc 0 super 0 zone_unusable (524288 bytes available) 
BTRFS critical (device loop0): entry offset 5251072, bytes 36864, bitmap no
BTRFS critical (device loop0): entry offset 5308416, bytes 4096, bitmap no
BTRFS critical (device loop0): entry offset 5316608, bytes 45056, bitmap no
BTRFS critical (device loop0): entry offset 6443008, bytes 438272, bitmap no
BTRFS info (device loop0): block group has cluster?: no
BTRFS info (device loop0): 4 free space entries at or bigger than 4096 bytes
BTRFS info (device loop0): block group 6881280 has 1638400 bytes, 0 used 0 pinned 0 reserved 0 delalloc 0 super 0 zone_unusable (1638400 bytes available) 
BTRFS critical (device loop0): entry offset 6881280, bytes 1638400, bitmap no
BTRFS info (device loop0): block group has cluster?: no
BTRFS info (device loop0): 1 free space entries at or bigger than 4096 bytes
BTRFS info (device loop0): block group 8519680 has 8257536 bytes, 0 used 0 pinned 0 reserved 0 delalloc 0 super 0 zone_unusable (8257536 bytes available) 
BTRFS critical (device loop0): entry offset 8519680, bytes 8257536, bitmap no
BTRFS info (device loop0): block group has cluster?: no
BTRFS info (device loop0): 1 free space entries at or bigger than 4096 bytes
BTRFS info (device loop0): 10420224 bytes available across all block groups
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 5319 at fs/btrfs/transaction.c:1787 create_pending_snapshot+0x2502/0x2a10 fs/btrfs/transaction.c:1787
Modules linked in:
CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00036-g5076001689e4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:create_pending_snapshot+0x2502/0x2a10 fs/btrfs/transaction.c:1787
Code: 4b 8c 44 89 fe e8 0e 16 9d fd 90 0f 0b 90 90 e9 55 f9 ff ff e8 af 6e dc fd 90 48 c7 c7 e0 57 4b 8c 44 89 fe e8 ef 15 9d fd 90 <0f> 0b 90 90 e9 5b f9 ff ff e8 90 6e dc fd 90 48 c7 c7 e0 57 4b 8c
RSP: 0018:ffffc9000d3bf540 EFLAGS: 00010246
RAX: d3c4d91482e22a00 RBX: ffff88803f5f4001 RCX: ffff88801f728000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000d3bf830 R08: ffffffff81601c02 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: dffffc0000000000
R13: ffff88800068e000 R14: 0000000000000000 R15: 00000000ffffffe4
FS:  00007f02809dd6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000011c06000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1919
 btrfs_commit_transaction+0xf11/0x3720 fs/btrfs/transaction.c:2398
 create_snapshot+0x655/0x990 fs/btrfs/ioctl.c:875
 btrfs_mksubvol+0x58f/0x710 fs/btrfs/ioctl.c:1029
 btrfs_mksnapshot+0xae/0xf0 fs/btrfs/ioctl.c:1073
 __btrfs_ioctl_snap_create+0x37d/0x4b0 fs/btrfs/ioctl.c:1337
 btrfs_ioctl_snap_create_v2+0x1ef/0x390 fs/btrfs/ioctl.c:1418
 btrfs_ioctl+0xa07/0xcc0
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0280f7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02809dd058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0281146080 RCX: 00007f0280f7ff19
RDX: 0000000020001480 RSI: 0000000050009417 RDI: 0000000000000006
RBP: 00007f0280ff3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0281146080 R15: 00007ffc49e40d48
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

