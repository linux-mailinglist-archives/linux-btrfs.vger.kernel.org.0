Return-Path: <linux-btrfs+bounces-19557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE690CAC6DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 08:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BC2302A39D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEB2D63F2;
	Mon,  8 Dec 2025 07:52:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918126056D
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765180349; cv=none; b=XOibrhCLyUJeZSjElyusPsCUSYOdg0spCuDBOGKSGD8RhtVWv9iiR/iVFFCrl6h2goL01eMChZIrDNRXN3wFMvjMCD7ITiVUTtqJsL/DaougwqoivOBb5QOuWhUsqZCma3U3jI0iCeZG+c51uv6QDD0wvLHYa9ryi8MYZyKHF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765180349; c=relaxed/simple;
	bh=PgKGT4CgWdgN4KZI6XZK4LJPlmiToK0yil7R1lkWaAs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bD4w+bGsrHkLADoNH3MEFAUviuyL9PEPO1WPmD+HquSLgj2DQL+lTmwFW/2s8cnHto4TgxcuIulIjvfBTeSsSzvNcMPciuXkGAMSQRtMr718MNq0AYqAa2wTVcSWge/336ebnBQ2niqNXPabCCPH4oAK9yRxE6W/A4Icq2qITSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c6d3685fadso4233929a34.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Dec 2025 23:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765180347; x=1765785147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqlTZgXUj5NUCTKw8O39U5hGtQEqHcF5ohvB94zKBCo=;
        b=PDrxLcG5VU1tfsE3sw//PKbTLPgpW1/rF0PjoG4unT9ot5QTodYq0KCDVQwCCYKlSw
         CUzHpjkWRMcU90TX/um6/+5PI7i7fRxiooupT6uVq4ULdtrixiJ5KQX0+LzBjc2w174k
         35987M055dh9q8l5byT9jyMpemjG6ilhUD3C8EytsR2R+fno4xakxIJMRsJW+1nHq69j
         PWymzDRZITGEYepxMfTHBrvESM46JCc0h/q5ilUVod6Dbm8v9iIXYchGCoYeq2+R3eMT
         EiyFFUO6v6JFl++Ms98n48fbJuElcEFpaBcoeNo4vKtOqPXwWakI5zXES9nkS4CdaH3y
         kg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWaAuQ2T8FLA6xb+QX48oH5UwGpDoBK3dVYA0c//q/srdC8eFI2V1nPJyw6eknNX/CTtJrPNsOihZaXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgW0TjrTzbTF/L33vGWXcD7yQmY0B2ej2d8LTheWoILAFjJnvN
	M70N89I3NtXEnSTWbk+xr/nP1kQfeU7GBmlWiodFyQ7JQ8PYvv2xyx1cw+JC+/ZzQGsX0faWNWc
	6WOQs6NrSn3zGxKgUhQXDFXIBfviePXiw6+sb0Cb77104b0cemptUyG9JXXM=
X-Google-Smtp-Source: AGHT+IEq+hHd0j1mdwHlG8tRj0iIKYmLJ3osSIKsAcFG72r8xw3V2y0y7CuUFYlxBUoTuhma51FUykbJ4lXLRvs65nw0qhNJ76O/
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:174a:b0:659:9a49:90bd with SMTP id
 006d021491bc7-6599a968357mr2917963eaf.60.1765180346830; Sun, 07 Dec 2025
 23:52:26 -0800 (PST)
Date: Sun, 07 Dec 2025 23:52:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693683ba.a70a0220.38f243.0091.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_qgroup_inherit
From: syzbot <syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    416f99c3b16f Merge tag 'driver-core-6.19-rc1' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ed421a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5a0bcda07a0bfd7
dashboard link: https://syzkaller.appspot.com/bug?extid=b44d4a4885bc82af2a06
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12770eb4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148bbc1a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-416f99c3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb10fdbc0d42/vmlinux-416f99c3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f277b82f7dd0/bzImage-416f99c3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/11aaebf70e5c/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=176f4992580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b44d4a4885bc82af2a06@syzkaller.appspotmail.com

R13: 00007f24f59e5fa0 R14: 00007f24f59e5fa0 R15: 0000000000000003
 </TASK>
assertion failed: prealloc == NULL :: 0, in fs/btrfs/qgroup.c:3529
------------[ cut here ]------------
kernel BUG at fs/btrfs/qgroup.c:3529!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5562 Comm: syz.0.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_qgroup_inherit+0x2892/0x28a0 fs/btrfs/qgroup.c:3529
Code: ff ff e8 d1 1f d4 fd 48 c7 c7 a0 e5 b0 8b 48 c7 c6 00 e6 b0 8b 31 d2 48 c7 c1 20 e2 b0 8b 41 b8 c9 0d 00 00 e8 ef 58 3a fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000cbe7740 EFLAGS: 00010246
RAX: 0000000000000042 RBX: 0000000000000000 RCX: b3bb6c739819f900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000cbe7990 R08: ffffc9000cbe7467 R09: 1ffff9200197ce8c
R10: dffffc0000000000 R11: fffff5200197ce8d R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000fffffff4
FS:  0000555588ca7500(0000) GS:ffff88808d679000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31b63fff CR3: 0000000011fab000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 create_subvol+0x5ad/0x18f0 fs/btrfs/ioctl.c:570
 btrfs_mksubvol+0x6e4/0x12c0 fs/btrfs/ioctl.c:928
 __btrfs_ioctl_snap_create+0x2b2/0x730 fs/btrfs/ioctl.c:1201
 btrfs_ioctl_snap_create+0x131/0x180 fs/btrfs/ioctl.c:1259
 btrfs_ioctl+0xb4d/0xd00 fs/btrfs/ioctl.c:-1
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24f578f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9b4adc18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f24f59e5fa0 RCX: 00007f24f578f7c9
RDX: 0000200000000280 RSI: 000000005000940e RDI: 0000000000000003
RBP: 00007ffc9b4adc70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f24f59e5fa0 R14: 00007f24f59e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_qgroup_inherit+0x2892/0x28a0 fs/btrfs/qgroup.c:3529
Code: ff ff e8 d1 1f d4 fd 48 c7 c7 a0 e5 b0 8b 48 c7 c6 00 e6 b0 8b 31 d2 48 c7 c1 20 e2 b0 8b 41 b8 c9 0d 00 00 e8 ef 58 3a fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000cbe7740 EFLAGS: 00010246
RAX: 0000000000000042 RBX: 0000000000000000 RCX: b3bb6c739819f900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000cbe7990 R08: ffffc9000cbe7467 R09: 1ffff9200197ce8c
R10: dffffc0000000000 R11: fffff5200197ce8d R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000fffffff4
FS:  0000555588ca7500(0000) GS:ffff88808d679000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31b63fff CR3: 0000000011fab000 CR4: 0000000000352ef0


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

