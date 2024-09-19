Return-Path: <linux-btrfs+bounces-8125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F897CAEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152471F2166E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6B19FA66;
	Thu, 19 Sep 2024 14:28:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B4194083
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756104; cv=none; b=kEtNcZ4YNKzSwYoIq7pad4GfBeO/ref4L4J5CY0QrgD7PkJVZj+j7LLvJdvcRO8yXibD1V5YuzvapTaRZOyGcgNSwW+sCT8hzOK3cynNkymkCDDCmhlWPKg7XoyKSDDs83ZccqJH5YhqJMYOskJmyeyWwwAbq15IFraOHFYgRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756104; c=relaxed/simple;
	bh=7U5vYZzV54AyYA/vKVGKNPoOAoAMp6ZBinjfFSCdxpU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uX/ERYugY04JW8gON66JG67qbf9dxqxs/GYQHRJCSoBRNtWjviwTMvK9DM8jm+ZAJeLmViEXFXEhKJQat0RUHU7T2CY2ps5Zp6H0tZt44v5WWaj7pTObpKU9aax3y3WRk9KXZx6TvHEo5ImfAO0muaD+nFFVCWNGWEWN1gNVPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0629ed658so10433945ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 07:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726756102; x=1727360902;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QaJe9sLoOeEHAHhkg+3eDQ78D6b0RIwb5ZRhM8fcqY=;
        b=T13ysuz+bZ47PjEauFNQotmAp8lluWO33Gp7eW+oSUdBU5QXtc8Yl2wq9vaY3QirbY
         C0qFs8dy7cbyNZ4/l7FD7nlSRqdSJDxBtcIH13ZyUyyaQZTgjef9kkMM5KAHPqoE1SFT
         itT3agyR+esn3dcTrJVg14Cs2nvPwtsu7if3FaNrKoyH7ByVtQK905gBFWCOY5sHroMw
         oKTQFp7FcmrWk9IH9qkNgZevTzkPo6dGTShLRc8G4ZlMEIwU7SeoTl1ge+ukZq7vBIfd
         zKK0I20xmU0oJ5JT9wn6b3DAy720tcIsAqT8zRejCMJ8f8DyI/mFuxphjnmyaMZOQZ+o
         tVBg==
X-Forwarded-Encrypted: i=1; AJvYcCXWocuK6xD24zLlIDFhycjhpCJAUQ76OeAAc79UhSmY4aHQ0QnQxpkTMUAWsJlxpviBc6f0eIKim9WsAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9D6J9i4vtQAXeyLV+kBft3R+azT1unGQDNVeRV1fX7EctWyVp
	pMWCUjtAoWZ6mD6DvKzN8wG+O6Bp4ARecflioCp6G+LOe697qIIh/35ZOcWmNJ8O477F6I+cZNP
	znXO5kHgWB4ZB3MG2Tbia1SSJ4XegjQCXt6QncqDQXWIBK1efxMym0aY=
X-Google-Smtp-Source: AGHT+IGnTQO/xvQwB5qAqhjlfR5Z1Gj8ZHnZRXzwHgfhCw3ClsstrKYKFykpnBdimdDJ0uxNfkEQeiC3vfVRlZ5Rw3+KNYRMxK5U
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8d:b0:39f:797a:65f8 with SMTP id
 e9e14a558f8ab-3a084929ebdmr226524215ab.19.1726756102130; Thu, 19 Sep 2024
 07:28:22 -0700 (PDT)
Date: Thu, 19 Sep 2024 07:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec3506.050a0220.29194.002b.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_recover_relocation
From: syzbot <syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=141de407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=4be543bf197a0325c7d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125748a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14440c9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b879ea3b7dd4/disk-d42f7708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/812a7fb7bfcc/vmlinux-d42f7708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/806a22d4adbf/bzImage-d42f7708.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/06797c3a4d01/mount_0.gz

The issue was bisected to:

commit ad21f15b0f795daf8723dddbcb61797d4f1c2aed
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:50 2023 +0000

    btrfs: switch to the new mount API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17725407980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f25407980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f25407980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com
Fixes: ad21f15b0f79 ("btrfs: switch to the new mount API")

BTRFS info (device loop0 state MC): resize thread pool 2097158 -> 4
assertion failed: fs_root, in fs/btrfs/relocation.c:4375
------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:4375!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5226 Comm: syz-executor261 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:btrfs_recover_relocation+0x1b6f/0x1ba0 fs/btrfs/relocation.c:4375
Code: 40 d1 fd eb 05 e8 c1 40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 e0 52 2d 8c 48 c7 c2 e0 51 2d 8c b9 17 11 00 00 e8 02 ce eb 07 90 <0f> 0b e8 9a 40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 00 52 2d 8c 48
RSP: 0018:ffffc900033e76a0 EFLAGS: 00010246
RAX: 0000000000000038 RBX: ffff88802918c048 RCX: 8c13e04592c8c800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900033e7830 R08: ffffffff8174016c R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc900033e77a0 R15: ffff888027a8d160
FS:  000055557fadc380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200011c8 CR3: 00000000693e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_start_pre_rw_mount+0xe15/0x1300 fs/btrfs/disk-io.c:3048
 btrfs_remount_rw fs/btrfs/super.c:1309 [inline]
 btrfs_reconfigure+0xae6/0x2d40 fs/btrfs/super.c:1534
 btrfs_reconfigure_for_mount fs/btrfs/super.c:2020 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2079 [inline]
 btrfs_get_tree+0x918/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc59f9fed9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff486e20c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efc59f9fed9
RDX: 0000000020001240 RSI: 0000000020001200 RDI: 00000000200011c0
RBP: 00007efc5a0195f0 R08: 0000000000000000 R09: 000055557fadd4c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff486e20f0
R13: 00007fff486e2318 R14: 431bde82d7b634db R15: 00007efc59fe903b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_recover_relocation+0x1b6f/0x1ba0 fs/btrfs/relocation.c:4375
Code: 40 d1 fd eb 05 e8 c1 40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 e0 52 2d 8c 48 c7 c2 e0 51 2d 8c b9 17 11 00 00 e8 02 ce eb 07 90 <0f> 0b e8 9a 40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 00 52 2d 8c 48
RSP: 0018:ffffc900033e76a0 EFLAGS: 00010246
RAX: 0000000000000038 RBX: ffff88802918c048 RCX: 8c13e04592c8c800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900033e7830 R08: ffffffff8174016c R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffc900033e77a0 R15: ffff888027a8d160
FS:  000055557fadc380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556f055030d8 CR3: 00000000693e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

