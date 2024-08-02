Return-Path: <linux-btrfs+bounces-6952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B05945960
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF061C22246
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A941C0DD3;
	Fri,  2 Aug 2024 07:59:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4E1BF30B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585570; cv=none; b=ts0NlvAU5N4ahtJp85VN6LnPC3poP9q9K5gDpB+zcgmo350KAesnSwqh8u3iPbQHt9A4eu5X0dqtzjRTtL1bkUasfNgavSawPF/L7x26unuwyH2Z9ezg4v6T/ndh9VYoQDAoXuMlAJ5O1U7nrHqWphiUBh4BjD92wyq1C0o8xBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585570; c=relaxed/simple;
	bh=WtqK1jAXs9qJxNRu902C3FmS8gPcRTmW3YXjIhCxUtA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i90T9Hd8Ii2gDttgKdB1p4hu3Wqb1rcxA0VPkq5DLJYJ67z8DQVbz2w9/YIIznKjMI5awG6aSKkxTTtM4rt7RScaC6frqZDCMpYUJzYBFb7VvfI8OpDV99+ZaH9Ei6Ow6CECbUVSYrrKCsy8nggqmuGcgRZzv8OMlQ30EYaGKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso123938085ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 00:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585568; x=1723190368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s12r9QREMFveHlbn3rdYzt1ORQUyCoWXBKdX/lCYyXU=;
        b=ByBqlWynwR82gk0oUzWRXYbPhIwFDMeTEjtKSl2BpnRG9DBza8aaIuRCJ96VZnJxCx
         OmxiYOBf4ITL3NZUzqirk6l49UHPu0mTHDFzzw9rDsyLBtfpG0X//wemYODTLDV85s8Q
         zL0pB141VT/Q3KDkVIq0j3BohZygsTZBR/D+UWHfeTVR2eAJpZcZyDQRfASUoce37G4s
         ZhfzjT/fnOJuUex4eY6qDfEUZ3SoWNfc2mi60CYZSGNWPL6bazprgPzVMCpYvvUry4nB
         taJb8boShfpzyvUI3YmIPeDvw1rTSnHNSDLsNzwmbk9VuP2KOaU6LufFhII2h+R/HYEW
         H/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUHd5/C9eLAQk8AyIxlyJMgqaJtUn3RdxM7AM/s08HAqLQlDryYzvxBgcQaYLNHB0TzkTz5GDxKdFWp50St0+jHxJ6BR0NuWWWoGmA=
X-Gm-Message-State: AOJu0YyA3b7DVg4WkPNmdJ2rHHwsLIDSvB5Hu5x5g2C04V/fCrfaucM9
	iSAHZrl2gmjyUbOO+W8jq19323OuH7+6lAX6QU9wo+86/1xSdlZqLLOW+MJOTbwXhBnqUVUl/vN
	BwEki0ov1TL+FsAwV6fSgmKvTlK1PTnihxvZpneX96xYabDd8qQ3ZM0Q=
X-Google-Smtp-Source: AGHT+IHfG1QcfB/ZTH/HhK2IAZHCFsZLHpjHBvcMBXaQhaH1OEBEVsG7w8dxFuIF2vFIZU4/8/tCcZ8Ywc2n2fII0qAXs5vOMqNQ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-39b1fb72b46mr1674775ab.1.1722585567971; Fri, 02 Aug 2024
 00:59:27 -0700 (PDT)
Date: Fri, 02 Aug 2024 00:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfd631061eaeb4bc@google.com>
Subject: [syzbot] [btrfs?] WARNING: bad unlock balance in btrfs_direct_write
From: syzbot <syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, hreitz@redhat.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e4fc196f5ba3 Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=126942d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=7dbbb74af6291b5a5a8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14889175980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d261f9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac353d93e559/disk-e4fc196f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c2d4dacbc40/vmlinux-e4fc196f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/427fd3f8ee36/bzImage-e4fc196f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9d865517e0c9/mount_0.gz

The issue was bisected to:

commit 939b656bc8ab203fdbde26ccac22bcb7f0985be5
Author: Filipe Manana <fdmanana@suse.com>
Date:   Fri Jul 26 10:12:52 2024 +0000

    btrfs: fix corruption after buffer fault in during direct IO append write

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f8316d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f8316d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f8316d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")

=====================================
WARNING: bad unlock balance detected!
6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0 Not tainted
-------------------------------------
syz-executor334/5215 is trying to release lock (&sb->s_type->i_mutex_key) at:
[<ffffffff83d47c3f>] btrfs_direct_write+0x91f/0xb40 fs/btrfs/direct-io.c:920
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor334/5215:
 #0: ffff888025b4c420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2876 [inline]
 #0: ffff888025b4c420 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586

stack backtrace:
CPU: 0 UID: 0 PID: 5215 Comm: syz-executor334 Not tainted 6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5199
 __lock_release kernel/locking/lockdep.c:5436 [inline]
 lock_release+0x5cb/0xa30 kernel/locking/lockdep.c:5780
 up_write+0x79/0x590 kernel/locking/rwsem.c:1631
 btrfs_direct_write+0x91f/0xb40 fs/btrfs/direct-io.c:920
 btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b6c418169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb1dc3c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0073746e6576652e RCX: 00007f5b6c418169
RDX: 0000000000182000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 652e79726f6d656d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb1dc3ce0
R13: 00007ffdb1dc3d20 R14: 0000000001000000 R15: 0000000000000003
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888075c915c8, owner = 0x0, curr 0xffff888025265a00, list empty
WARNING: CPU: 0 PID: 5215 at kernel/locking/rwsem.c:1370 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 0 PID: 5215 at kernel/locking/rwsem.c:1370 up_write+0x502/0x590 kernel/locking/rwsem.c:1632
Modules linked in:
CPU: 0 UID: 0 PID: 5215 Comm: syz-executor334 Not tainted 6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x502/0x590 kernel/locking/rwsem.c:1632
Code: c7 c7 a0 c8 ea 8b 48 c7 c6 20 cb ea 8b 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 d3 9c e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6a fd ff ff 48 c7 c1 00 a9 f6 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc90003507920 EFLAGS: 00010292
RAX: 889b6823d8081400 RBX: ffffffff8beac980 RCX: ffff888025265a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900035079f0 R08: ffffffff81559202 R09: fffffbfff1cb9f80
R10: dffffc0000000000 R11: fffffbfff1cb9f80 R12: 0000000000000000
R13: ffff888075c915c8 R14: 1ffff920006a0f2c R15: dffffc0000000000
FS:  0000555586938380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe3488bd28 CR3: 000000002503c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_direct_write+0x91f/0xb40 fs/btrfs/direct-io.c:920
 btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b6c418169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb1dc3c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0073746e6576652e RCX: 00007f5b6c418169
RDX: 0000000000182000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 652e79726f6d656d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb1dc3ce0
R13: 00007ffdb1dc3d20 R14: 0000000001000000 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

