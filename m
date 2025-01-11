Return-Path: <linux-btrfs+bounces-10925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7CA0A493
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E729D188AC85
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7506B1B3932;
	Sat, 11 Jan 2025 16:08:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C31B0F22
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736611703; cv=none; b=e/CqVaMHb1qqCTKJkaaw+R67v/YDXik1V1BB/fHP/Eq4XP00AEHqO2vgCN/hsF/2Alm8L5KbX35MTPNkgc7EPVU0kKPiZg1CmBE8Y7QEzz6+OeI/Eld1/XFHQzVWcx16Iz8X70QCQMDJfVrbkMu+USsQVPEN8wvAN7aLhGrTDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736611703; c=relaxed/simple;
	bh=HJvE5S90V6ZJadEJuEaBEMgIkd9Q+8zx2ASx6m41ri0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bgNESq7OydEs8ABoyKvgbbrLBuFpL+ShctT2mS/amOGLsGOojsPfK8NQpeuc3KHUQtqH6jy+uhWTQwBwogjpc2A3zRBfWap9pQ0LEodX7uJwZkrUM4m0CU++sXW6bQfLZASwAZg+evFB4PhUn3jIMmpWVN/O79BPE8hF2pAcBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844e7f9d37dso482570939f.2
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 08:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736611700; x=1737216500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rXwui5ddJcXYwsQoDC/NmNH6xGVLAUt2oATQD5e19E=;
        b=uRMCgBkSrR8aLHBGhycLNylq+6PjqNj1nF8ZCo7hR1Eh+f1DlzjKTBMlLRcXxVscBP
         5bBZZBWoNhm4WTyF/UDT+74EcBsdur3qnX671Oh5GGgzhQVbM7TT3ciPpCKg0Om3OFfz
         aGl6zDqs+G0SYoPXcx7Y1C2EI4rJn3hVcO3BANUed52Rs1SK5lQ+oxXn1XjnBpSXplw8
         hUoh6d2UHpu9RNwt564C/KDF+SG7LMqSHVfsvGzJtjd/b4J2YncQ8aN5TPF9638NHY8X
         MrQ9tHd9Az6gHCdZtpJ1phMPqmGNSJaZSEwn+7fMpIqGSwiS/zmwQ2eHRuOXx43bSwZg
         iUHg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqhSd6oGTtkY3Sx5CrNGm2k0ZpIL6JlesR3iT7RcB9vKgvTA6fqe0qkrYQdn/5nt1F1a6ECMkdWlWbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6JvwuEpv/eGZolyG3JglOosIGR54Tlg8y5BjYuQwoq7chCk4
	vUWE9VZfuplc6R3ASHEnnj+2meWnVc9GgzfTzcEsCVSeUoeZLvcn8glbeAyR7MQ0cdPLPnrlfbF
	ROcADL+5nDAZCMBEjv/mbGE6x90DWrkVHxF3xnMx5x2EE6+GFxvmOU1s=
X-Google-Smtp-Source: AGHT+IF5D3AL4CyM0y6sXjTKft6NcON2LEX/7kG6wtTx86cRxyutNNfhzxh3c9+iNcy9EJnNDfgCm8iKFI/DtfoVSa59Lv+z2fXd
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:3a7:e103:3c46 with SMTP id
 e9e14a558f8ab-3ce3a8ba404mr109589365ab.16.1736611700528; Sat, 11 Jan 2025
 08:08:20 -0800 (PST)
Date: Sat, 11 Jan 2025 08:08:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67829774.050a0220.216c54.0022.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING: ODEBUG bug in open_fs_devices
From: syzbot <syzbot+70e85051171b982ffd90@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105ef6f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
dashboard link: https://syzkaller.appspot.com/bug?extid=70e85051171b982ffd90
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104ddedf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c179cc0c7a3c/disk-7b4b9bf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdea80f2ec16/vmlinux-7b4b9bf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a277fcaff608/bzImage-7b4b9bf2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3c7dbd714b28/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70e85051171b982ffd90@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 262144
------------[ cut here ]------------
ODEBUG: init active (active state 0) object: ffff88807e9bb1f8 object type: percpu_counter hint: 0x0
WARNING: CPU: 0 PID: 6292 at lib/debugobjects.c:615 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 6292 Comm: syz.0.92 Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:612
Code: e8 7b 14 39 fd 4c 8b 0b 48 c7 c7 00 0e 60 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 cb 7f 93 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 b8 87 2e 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90002fa76b8 EFLAGS: 00010286
RAX: cf4427ebace36800 RBX: ffffffff8c626760 RCX: ffff88807d66bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c600f80 R08: ffffffff817ff732 R09: fffffbfff1cfa188
R10: dffffc0000000000 R11: fffffbfff1cfa188 R12: 0000000000000000
R13: ffffffff8c600e98 R14: dffffc0000000000 R15: ffff88807e9bb1f8
FS:  00007fe1f73f56c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5800c0d000 CR3: 0000000032d7e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_object_init+0x2b9/0x470 lib/debugobjects.c:763
 debug_percpu_counter_activate lib/percpu_counter.c:43 [inline]
 __percpu_counter_init_many+0x1c2/0x390 lib/percpu_counter.c:214
 open_fs_devices+0xb5/0x12b0 fs/btrfs/volumes.c:1307
 btrfs_get_tree_super fs/btrfs/super.c:1857 [inline]
 btrfs_get_tree+0x552/0x1a30 fs/btrfs/super.c:2093
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 fc_mount+0x1b/0xb0 fs/namespace.c:1271
 btrfs_get_tree_subvol fs/btrfs/super.c:2051 [inline]
 btrfs_get_tree+0x6b1/0x1a30 fs/btrfs/super.c:2094
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1f65874ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1f73f4e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe1f73f4ef0 RCX: 00007fe1f65874ca
RDX: 0000000020022240 RSI: 0000000020022280 RDI: 00007fe1f73f4eb0
RBP: 0000000020022240 R08: 00007fe1f73f4ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020022280
R13: 00007fe1f73f4eb0 R14: 0000000000022211 R15: 00000000200222c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

