Return-Path: <linux-btrfs+bounces-10913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD61A0A166
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 08:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF1A188DEC2
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294116F851;
	Sat, 11 Jan 2025 07:04:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210D1547E7
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579071; cv=none; b=kdt5k9PLnZJieLxcFQnTwp+Wggpzh2ZhxnV/Movnc9VsAsGePj0zSYoouMiYZMYbzIgfRLRjXM/59ERTlQ0ywXf+AQ32qYXUr4UpntyeUDHp9Bo/xes90wYdJXk9C41uZZ2FrZymRRze2+1b+Ll6Q7CV39J9WQxF0nyIbBUZKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579071; c=relaxed/simple;
	bh=xpHDXCkpIE/t9PSfH/wuLxZ8WUbRTk5tKafaVuN4VeU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ls4SeBflg2ZBHaQuHvL3wtxhBH+M5rECO6CHQWGswwznbDnXOG+wHJuzaGVR5FRORBm/Lsd7WWm7UjJzJE1h64JFF7vaig5NtBG8c0jP8mIPGIDFQTZx5dJDHb0mKZA8EAFI/yjJNYJS0URx3JuHSL6YKVCu12zVi+bmNSuIdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so23180635ab.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 23:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736579069; x=1737183869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpzgNqC5MsfUKOMian7qB4Fduxwpdg5GDldIDvqyUIo=;
        b=Svo4247etr1GWvRVuO+1WLfTedCoJ6w5fOjUCGDlRV2si1S3g8PY6hIJdJ0k1GbwZd
         aVx2sfdYamXpXRTtjZBn+slx4vvIRNeiEtom++44QbgQ1SnyGbeGiUyRpCQLtd0RyARB
         KJijjkgmBn64IvTpFKTq4/ErPWrrXD/eRD0NPkA7ghL6nb25h2xXa5s7Z6+T6g/lnVyD
         TbYpzJVP2F27IuC9lrWHv8sWgAmBVAlrX/LtiQ+cUSCVDVh5QbuMqOjVu8oc0Urg9HTT
         uWKNdS6KBLI2z/S/RlV3Ycb60UkvLfQUwgf5GRt7X+lpm5a38AKbERf5UsaIdqgwjj7l
         xPKA==
X-Forwarded-Encrypted: i=1; AJvYcCU1/rCNBw9ON5HATXwOWcRL/Zc7ICmtMmeFWwB3eBcXV9gH6L+DbBuurlSoqzV7NyknrooN/mGXEqLqHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Tt/ajY7geHe7B6z6S8Jj18Qlv3CF8N5Y6/zW8EsIf1UboVWP
	974YhAC1PCiSgI7/ncjvAMJVoLChcdUVosukzozv95mIiOFa34MSfD8FgR3c0E1LgLDsIlO4Ruz
	YUdXTLFihr1szTmETIPbmAQ2fba7Uo1OTY0nKU9gcvQLe4oeiB0irvsU=
X-Google-Smtp-Source: AGHT+IF15UtVaebEbRP5XoNL+umGrDcQsLxwCMmgeFGOUJsQuZwqhlw3AhYj6CweMtHdkwbvjz+sm90IZ7CjsrvXvKFmQIcqN2Ix
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1948:b0:3a7:e4c7:ad18 with SMTP id
 e9e14a558f8ab-3ce3aa540d2mr89325485ab.18.1736579069461; Fri, 10 Jan 2025
 23:04:29 -0800 (PST)
Date: Fri, 10 Jan 2025 23:04:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678217fd.050a0220.d0267.003f.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING: ODEBUG bug in btrfs_free_stale_devices
From: syzbot <syzbot+c2d267b16d6e52226d9e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=119eb4b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
dashboard link: https://syzkaller.appspot.com/bug?extid=c2d267b16d6e52226d9e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159eb4b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151393c4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c179cc0c7a3c/disk-7b4b9bf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdea80f2ec16/vmlinux-7b4b9bf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a277fcaff608/bzImage-7b4b9bf2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dcff07befc9d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2d267b16d6e52226d9e@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88807d1259f8 object type: percpu_counter hint: 0x0
WARNING: CPU: 1 PID: 5838 at lib/debugobjects.c:615 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 5838 Comm: udevd Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:612
Code: e8 7b 14 39 fd 4c 8b 0b 48 c7 c7 00 0e 60 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 cb 7f 93 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 b8 87 2e 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90003c87a58 EFLAGS: 00010282
RAX: ac00c60cb060fa00 RBX: ffffffff8c626760 RCX: ffff88807ce51e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c600f80 R08: ffffffff817ff732 R09: fffffbfff1cfa188
R10: dffffc0000000000 R11: fffffbfff1cfa188 R12: 0000000000000000
R13: ffffffff8c600e98 R14: dffffc0000000000 R15: ffff88807d1259f8
FS:  00007f98c056ac80(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f98c00c2723 CR3: 0000000077450000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x45b/0x580 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2284 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x115/0x430 mm/slub.c:4757
 btrfs_free_stale_devices+0x55b/0x5f0 fs/btrfs/volumes.c:562
 btrfs_scan_one_device+0xae4/0xdb0
 btrfs_control_ioctl+0x165/0x410 fs/btrfs/super.c:2243
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f98c011ad49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007fff6cbc0e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f98c011ad49
RDX: 00007fff6cbc0e28 RSI: 0000000090009427 RDI: 0000000000000009
RBP: 0000000000000009 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff6cbc1e68 R14: 000056187570f1a0 R15: 00007fff6cbc2b88
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

