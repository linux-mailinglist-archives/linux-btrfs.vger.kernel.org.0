Return-Path: <linux-btrfs+bounces-18747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3AC3843D
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 23:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87693A7476
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 22:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0A2F1FCB;
	Wed,  5 Nov 2025 22:52:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC912D47E8
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383148; cv=none; b=HVqhJ1n7Zpw3Oyqhiu4NI2RURjEuq1vvOXwy+0jFoxFFYPepdn8yAXlzWNpAV09PQG1RwDdS2n3KDCWYww0HA53SS13NKgtXirhc9bwsP78m43iOb4k+n8foNDCY85kCXchfgeHtsD9fL5EUzpbbnWnX3bXHlpkcOaHPBfXGyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383148; c=relaxed/simple;
	bh=E84jzNhg13WZ9bIISgKkmAZYtstHgmEFFuunaL/mAG8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GUKQRnxgoXBudQwonCqP9LrQPp7+56r7LoWL8GlwIgHJWyEb/uP60WJq/kJWR92pxTFc1NIYM7qBZrEBBYqQYLlVPj+Ya9RGYbcBmUWNgmqJXAhkUTmHtWf4Q7z2+UVcLiheAXTalCq8ejaq1HzPP4+1mzl6pfiz5/FTBPwbS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-940f9efd090so66076339f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 14:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383145; x=1762987945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KbXaJ3kX42ZpPo9dnlXTI1wxuyuZ2N42Y5pBaHMR5o=;
        b=lo45yld/Wnsj0eRgV3WSHl52FKl0hJUZRb9LUu37x2+X+WWKzDQCBF9o1RFmy3WnIy
         m75AWp9GviyTe76KsA7NPUQdBv1hWdw6ac8YWgV9SePI+UJY/WTg+KAubpBDbTflm6gV
         EayzJFqvUEqUY4KJIwLcKSRYg8DirzbPbt31WMeErlw1oaNlJ8Gx9HZK9VlWhQMaoB48
         MlJaGpJ68m2z0i/MID0W/GSa67kmMC2CemoBL1jMK2rlU0qcpzVaarLmA+2aJkqQb3NY
         I41vdwSbLC03U6MKCKNuyF8qfV+tKh+YY1u/fS1myvOiRw480SEDa6JIHvKsl3Qr9Gfe
         rQvw==
X-Forwarded-Encrypted: i=1; AJvYcCVihRQdh+WPOgRUy0Z8i47dBMVCSwjAN7Op28irIRwOtWn12g8EaR7LKBxX4AwpchXGRnR//G+IyUbUPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIuEoY0OVnlCgQ3yFcf0GueK/vjb+NIMn28ZJTFBAZgL3POHU
	1ENor7bhE3And028ZLOn+KnGfz6T3v8k/vW1o+H1bt8VVtb2NLAtix5Ltan3LTYEkkrX5+Mfe5p
	+oJvJyGW+abJ21C/BF/+TzLFrxXN+38b20zxnwM7F/OeszgI3RNTVJd+13LA=
X-Google-Smtp-Source: AGHT+IE8GD0zqnJD3kd/UsmBfw0hgp7Np/JLjD4bUq0pgRAL3OEuVhx9I0pGKvIMNpqvEbOwcJle6YbDJ4OrgTLEjULw+8m7Utvl
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c3:b0:945:ab4f:6732 with SMTP id
 ca18e2360f4ac-94869ce5974mr712921239f.2.1762383145508; Wed, 05 Nov 2025
 14:52:25 -0800 (PST)
Date: Wed, 05 Nov 2025 14:52:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bd529.050a0220.baf87.0079.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in reserve_bytes
From: syzbot <syzbot+feba382c68462d76be14@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98bd8b16ae57 Add linux-next specific files for 20251031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17abfe7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63d09725c93bcc1c
dashboard link: https://syzkaller.appspot.com/bug?extid=feba382c68462d76be14
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/975261746f29/disk-98bd8b16.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad565c6cf272/vmlinux-98bd8b16.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1816a55a8d5f/bzImage-98bd8b16.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+feba382c68462d76be14@syzkaller.appspotmail.com

assertion failed: !(ticket->bytes == 0 && ticket->error) :: 0, in fs/btrfs/space-info.c:1671
------------[ cut here ]------------
kernel BUG at fs/btrfs/space-info.c:1671!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 7313 Comm: syz.1.358 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:handle_reserve_ticket fs/btrfs/space-info.c:1671 [inline]
RIP: 0010:reserve_bytes+0x129e/0x1410 fs/btrfs/space-info.c:1864
Code: 0f 0b e8 15 f0 cc fd 48 c7 c7 60 c9 b0 8b 48 c7 c6 80 d5 b0 8b 31 d2 48 c7 c1 40 c6 b0 8b 41 b8 87 06 00 00 e8 f3 f8 33 fd 90 <0f> 0b f3 0f 1e fa 65 8b 1d 59 4a 80 0e bf 07 00 00 00 89 de e8 19
RSP: 0018:ffffc9000f2ff180 EFLAGS: 00010246
RAX: 000000000000005c RBX: 0000000000000000 RCX: 6a0e5d27bc457900
RDX: ffffc9000d29b000 RSI: 00000000000080c9 RDI: 00000000000080ca
RBP: ffffc9000f2ff3c0 R08: ffffc9000f2feea7 R09: 1ffff92001e5fdd4
R10: dffffc0000000000 R11: fffff52001e5fdd5 R12: ffff88814e273000
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffffc9000f2ff220
FS:  00007f71682106c0(0000) GS:ffff888125ee2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3d8bb6d60 CR3: 0000000029df0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 btrfs_reserve_metadata_bytes+0x28/0x150 fs/btrfs/space-info.c:1887
 btrfs_reserve_trans_metadata fs/btrfs/transaction.c:577 [inline]
 start_transaction+0x102c/0x1610 fs/btrfs/transaction.c:658
 btrfs_replace_file_extents+0x2b1/0x1de0 fs/btrfs/file.c:2432
 insert_prealloc_file_extent fs/btrfs/inode.c:9004 [inline]
 __btrfs_prealloc_file_range+0x48d/0xcf0 fs/btrfs/inode.c:9071
 btrfs_prealloc_file_range+0x40/0x60 fs/btrfs/inode.c:9149
 btrfs_zero_range+0xb9a/0xe00 fs/btrfs/file.c:3073
 btrfs_fallocate+0xb95/0x1c10 fs/btrfs/file.c:3187
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f716738efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7168210038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f71675e6090 RCX: 00007f716738efc9
RDX: 0000000000003ffd RSI: 0000000000000010 RDI: 000000000000000a
RBP: 00007f7167411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f71675e6128 R14: 00007f71675e6090 R15: 00007fff6c300678
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:handle_reserve_ticket fs/btrfs/space-info.c:1671 [inline]
RIP: 0010:reserve_bytes+0x129e/0x1410 fs/btrfs/space-info.c:1864
Code: 0f 0b e8 15 f0 cc fd 48 c7 c7 60 c9 b0 8b 48 c7 c6 80 d5 b0 8b 31 d2 48 c7 c1 40 c6 b0 8b 41 b8 87 06 00 00 e8 f3 f8 33 fd 90 <0f> 0b f3 0f 1e fa 65 8b 1d 59 4a 80 0e bf 07 00 00 00 89 de e8 19
RSP: 0018:ffffc9000f2ff180 EFLAGS: 00010246
RAX: 000000000000005c RBX: 0000000000000000 RCX: 6a0e5d27bc457900
RDX: ffffc9000d29b000 RSI: 00000000000080c9 RDI: 00000000000080ca
RBP: ffffc9000f2ff3c0 R08: ffffc9000f2feea7 R09: 1ffff92001e5fdd4
R10: dffffc0000000000 R11: fffff52001e5fdd5 R12: ffff88814e273000
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffffc9000f2ff220
FS:  00007f71682106c0(0000) GS:ffff888125ee2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdaa1f0eb8 CR3: 0000000029df0000 CR4: 00000000003526f0


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

