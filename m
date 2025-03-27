Return-Path: <linux-btrfs+bounces-12612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65341A73687
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D0217D630
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75019E819;
	Thu, 27 Mar 2025 16:15:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DA15687D
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092128; cv=none; b=JvW5uZp9RT4yRLcR3Hl/Xdqo3SWDMBDjvskD0Kieyx5Qt3ekXvLDoyN6lYVjm2OIvON4s6Uj0eCia8mHWsPW2b841Vfth2G58boMRv6dT0O7A9VL7KQUPhA1oDgjLMPQyYPqzMpAgCoM7TOTv9w7GJnWu2gAQUtokhsPUcqcih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092128; c=relaxed/simple;
	bh=NlkzNk6GORuJORKSxBEhPi7InKFoidbJ9MGaGc15eWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LwAKW17SrNbhR7g8pHetIdhlNwgKu2Z/LDRHRNfoiFWQ8EPERgjypVFymeHyRolF3unwrtJR1IE54A5AFC310ZI9Lu0DjHJ5zhN8hc4/suHqiOASuDk7gx+qjW3DnsqYU2sO2TWij7Wpa2bpb8yUa7maSjXRnoNq2K33jaLyatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85dad58e80fso232578139f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 09:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092126; x=1743696926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8V3dGI9iSS4mdw+3/NMPpbQmQt3q1vTp00ADiOczxe8=;
        b=Gw40EIl1q/aY/wDTJ5aW0pflOC2dqHduN/jUkr0AR1lyOUn+CAtNQ2+LS9++dkn5wN
         RJ29noq/EthZ3pk8oOg0E3BiYSn8SECfizqof49MfcrqYheNPTZbhYsYKlQ+JzV7kTTJ
         8qB44Xx25EHVHZD96PnPXIr2eMhVYlon738Eq8WDnz+kTlTabY1/WTlM+v4NnyCsogJO
         PW1DML0mcJ8g2adrtUhvsDz5+jjnY2EUAduA67nLXgOXo69N3xbMocVLDUVjbS3r3eMC
         Ex5gMe020stx2JAntkMkbR3Vlk/he0cNhr13Sk73tr3JsoyH7glb/Qg1Re1tYn091+dy
         2mBA==
X-Forwarded-Encrypted: i=1; AJvYcCV9JbEIdo56d5trjM9TO008torogokSgJV22jPApmKYgraOP9X+xAnvJUdNw3IrykojdOmrnMBgerhdag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMVuDvxKJEhnn/pAJolehrSdiguwRYX8vY5YPLcIn3hE9CWRu
	r2W4enKln/n+u7OvGxK5UlChaWjHHQOdFjJir5pLlMDLhS8gzt+KcQ/ed+gcj/SakUbB0yRIQYt
	vASvkoybxqFRAT6G/5FvTQv7ud7Nze85iwE7YRLHytpAmUjz56guRens=
X-Google-Smtp-Source: AGHT+IFm7s1Xn/EPosDrJ91/AtSCxYFb7ynGw3U/md7gEh8Yw51IOnDCsDkjzUYj46Vv3ZpylX8ujEchV8xIkb66xUtBrhfns3cq
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c84:b0:3d3:fdcc:8fb0 with SMTP id
 e9e14a558f8ab-3d5cce2c4bcmr48237995ab.20.1743092126127; Thu, 27 Mar 2025
 09:15:26 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:15:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e5799e.050a0220.2f068f.0032.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in write_all_supers
From: syzbot <syzbot+34122898a11ab689518a@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1405d804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46a07195688b794b
dashboard link: https://syzkaller.appspot.com/bug?extid=34122898a11ab689518a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d7abb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d76198580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f6e0150b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ade4c34c9b1/vmlinux-f6e0150b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fe37b97ec9d/bzImage-f6e0150b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1f4c759fe772/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1757abb0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34122898a11ab689518a@syzkaller.appspotmail.com

BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): using free-space-tree
assertion failed: folio_order(folio) == 0, in fs/btrfs/disk-io.c:3858
------------[ cut here ]------------
kernel BUG at fs/btrfs/disk-io.c:3858!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6730 Comm: syz-executor378 Not tainted 6.14.0-syzkaller-03565-gf6e0150b2003 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:write_dev_supers fs/btrfs/disk-io.c:3858 [inline]
RIP: 0010:write_all_supers+0x400f/0x4090 fs/btrfs/disk-io.c:4155
Code: 21 fe 90 0f 0b e8 01 ff d5 fd 48 c7 c7 00 3f 6c 8c 48 c7 c6 40 88 6c 8c 48 c7 c2 80 3f 6c 8c b9 12 0f 00 00 e8 92 8c 39 fd 90 <0f> 0b e8 da fe d5 fd 4c 89 f7 48 c7 c6 c0 72 6c 8c e8 6b 4d 21 fe
RSP: 0018:ffffc9000d7df580 EFLAGS: 00010246
RAX: 0000000000000045 RBX: 0000000000000002 RCX: 0e7dfa980dce5500
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000d7df950 R08: ffffffff81a2ae7c R09: 1ffff92001afbe4c
R10: dffffc0000000000 R11: fffff52001afbe4d R12: ffffea0001395708
R13: 1ffffd4000272ae1 R14: 1ffffd4000272ae0 R15: ffffea0001395700
FS:  00007f5ad16c86c0(0000) GS:ffff88808c824000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004039a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x1eda/0x3750 fs/btrfs/transaction.c:2528
 btrfs_quota_enable+0xfcc/0x21a0 fs/btrfs/qgroup.c:1226
 btrfs_ioctl_quota_ctl+0x144/0x1c0 fs/btrfs/ioctl.c:3677
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ad1f20289
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5ad16c8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5ad1fa7728 RCX: 00007f5ad1f20289
RDX: 00002000000000c0 RSI: 00000000c0109428 RDI: 0000000000000003
RBP: 00007f5ad1fa7720 R08: 00007f5ad16c86c0 R09: 0000000000000000
R10: 0000000000005598 R11: 0000000000000246 R12: 00007f5ad1fa772c
R13: 000000000000000b R14: 00007ffcbc9201a0 R15: 00007ffcbc920288
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_dev_supers fs/btrfs/disk-io.c:3858 [inline]
RIP: 0010:write_all_supers+0x400f/0x4090 fs/btrfs/disk-io.c:4155
Code: 21 fe 90 0f 0b e8 01 ff d5 fd 48 c7 c7 00 3f 6c 8c 48 c7 c6 40 88 6c 8c 48 c7 c2 80 3f 6c 8c b9 12 0f 00 00 e8 92 8c 39 fd 90 <0f> 0b e8 da fe d5 fd 4c 89 f7 48 c7 c6 c0 72 6c 8c e8 6b 4d 21 fe
RSP: 0018:ffffc9000d7df580 EFLAGS: 00010246
RAX: 0000000000000045 RBX: 0000000000000002 RCX: 0e7dfa980dce5500
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000d7df950 R08: ffffffff81a2ae7c R09: 1ffff92001afbe4c
R10: dffffc0000000000 R11: fffff52001afbe4d R12: ffffea0001395708
R13: 1ffffd4000272ae1 R14: 1ffffd4000272ae0 R15: ffffea0001395700
FS:  00007f5ad16c86c0(0000) GS:ffff88808c824000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5aca0e8000 CR3: 000000004039a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

