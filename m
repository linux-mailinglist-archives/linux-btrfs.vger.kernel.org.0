Return-Path: <linux-btrfs+bounces-13866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA53CAB275C
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 May 2025 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1992D1766E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 May 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A41BD9F0;
	Sun, 11 May 2025 08:46:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296551A2387
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746953187; cv=none; b=OLJZCol0A/eQsybGCSMFmDqUXQJD+FEGOtk+sRxlNjU2m7WF4s15RMZpwQ3Ij9xQ4CA94wPx7rosO+UMhZ5EPjTjN4VJER10UYcs3b+L5Yby1E0L5tIA0t6NWFtv6FvHvV0jUaum1Us4pCytrNH/+S5tzzN+nkZFH3A/r3yZsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746953187; c=relaxed/simple;
	bh=tdwV9uMJEf4NMRgTSEOT3PiGCISiiyNTBOB3ugi872c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hbfLP0NgdMxMBRX9ZVWSjb93PjVvTt69Z9g49r9ecugde6l85BbsE6z4yFGk+VenClwSRThEaPAvDit9Hb5vxCNOMHCWJNyLJAc5qUfKH0iLca97Mhy8O6yEbs3zd90sxped5NX/wq7Yd4auHQLj5fiBSXDLnB9Krq49IEkQZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d8eda6c48cso45586525ab.0
        for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 01:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746953185; x=1747557985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QSPiADpLuqs4nC4D6n6vms9x4J46qbiGQAZeQ4r3S8=;
        b=wFyDdJhohWtpNxe99JQ7Pf7I3gvhJPtqGGMBoTmY+da4xcKbSw1qqsmcNjmEvkb1kc
         4tc/7GSEXwk/ukO128/zSL12TmfEHHqzxqCsr1wZSCFIsR2uqUHHIjaVhqAztWjiVCGF
         0/X/zLq4UaeuGqk8XB7M4QhWlvQ2OY3J0e802u6nJRP0zNKFeIPSpzueWzRzm6pX4ldS
         KhsLY351k1NdVyZMJfTkrdK19cRwfn46L6nEV4rsrv/hOcE/cM9ciIEYN0UGzQ8u8baV
         yly1CvUMBku4Oah3IjDgJ78M2NB6xJn5xpzn16Ie6QHsmb6P5kSyUeMOr17HeqxWgMzA
         50Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVNJDrt4CyPOD9BsoHoOg/aaDcgXZ8l0uV6LZBa44Rym/CzGYStpMp6Hg9FRfHwGk//C2MmmMfZFyWcuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3RtQTpuie0DgJG4O7SHrJDGMj4DPn7Ibdihi6z2vRMYlL706
	etj99qd66hZt4BYXS5EO4Pa97UzsleV6vKd3zuVpe5dppEj8uycve3UbDEw9fbqSPgx+PtsmMnT
	gXUqHCEEctrDXJxTnKvEZ2Kk/nvcPtpb92rN8WK13jpIBldmEDRax73o=
X-Google-Smtp-Source: AGHT+IEryGv/28ms8Lmi8Al5fWjAYkjejyNHiM9Dz5hl5tu930d9/HXVCxAxpTuFOaQH7O4JwCWfLmY6uL3j8Im256Sc3s/fp2qp
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1293:b0:3d3:de5f:af25 with SMTP id
 e9e14a558f8ab-3da78494c5cmr129873055ab.0.1746953185207; Sun, 11 May 2025
 01:46:25 -0700 (PDT)
Date: Sun, 11 May 2025 01:46:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682063e1.050a0220.f2294.002a.GAE@google.com>
Subject: [syzbot] [btrfs?] VFS: Busy inodes after unmount (use-after-free) (2)
From: syzbot <syzbot+1134d3a5b062e9665a7a@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0f4c8dd9d2d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1481fb68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=868079b7b8989c3c
dashboard link: https://syzkaller.appspot.com/bug?extid=1134d3a5b062e9665a7a
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10edfa70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a84d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/463c704c2ee6/disk-e0f4c8dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bb99dd967d9/vmlinux-e0f4c8dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/505fe552b9a8/Image-e0f4c8dd.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3eef91541df5/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=176dfa70580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1134d3a5b062e9665a7a@syzkaller.appspotmail.com

BTRFS info (device loop0): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
VFS: Busy inodes after unmount of loop0 (btrfs)
------------[ cut here ]------------
kernel BUG at fs/super.c:652!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6484 Comm: syz-executor107 Not tainted 6.15.0-rc4-syzkaller-ge0f4c8dd9d2d #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : generic_shutdown_super+0x2b4/0x2b8 fs/super.c:650
lr : generic_shutdown_super+0x2b4/0x2b8 fs/super.c:650
sp : ffff8000a43f7ba0
x29: ffff8000a43f7ba0 x28: 00007dfe9b1ba808 x27: ffff80008f301de8
x26: ffffffffffffffff x25: dfff800000000000 x24: 1fffe00018b9bcf0
x23: ffff80008b2817e0 x22: dfff800000000000 x21: 0000000000000000
x20: ffff80008fa4d4c0 x19: ffff0000c5cde000 x18: 1fffe00036711a76
x17: ffff80008f2fe000 x16: ffff80008ada5d6c x15: 0000000000000001
x14: 1ffff0001487eee0 x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001487eee1 x10: 0000000000ff0100 x9 : 9c3427ac6e3c7500
x8 : 9c3427ac6e3c7500 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a43f7538 x4 : ffff80008f3f4fa0 x3 : ffff800082faeee4
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000000000000002f
Call trace:
 generic_shutdown_super+0x2b4/0x2b8 fs/super.c:650 (P)
 kill_anon_super+0x4c/0x7c fs/super.c:1237
 btrfs_kill_super+0x40/0x58 fs/btrfs/super.c:2099
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1435
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1442
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x16c/0x1ec arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xb0/0x150 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: b0051160 91350000 9119a261 97cfbb64 (d4210000) 
---[ end trace 0000000000000000 ]---


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

