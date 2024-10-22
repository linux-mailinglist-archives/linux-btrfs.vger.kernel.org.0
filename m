Return-Path: <linux-btrfs+bounces-9048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA09A953D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 03:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4614B1F23C19
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 01:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0CD7E59A;
	Tue, 22 Oct 2024 01:03:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43634A35
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559012; cv=none; b=sMFXve2nojkpW0vi40TweVIFAVxgBEzSmcQmVU57vrjWLF920cr7waXaK8KMr0pEvIrWAREGdfwrizBoJDHf+jqAOuBt3adqk7Wcw87BNdV7pn1TusqW5ZbiJk479/niR7AYe/wT7U9EEWaQmXpOhm/fbno4rUGKQL4/nZMqskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559012; c=relaxed/simple;
	bh=EaeHWISn1cOME7j2ZxUWwoUcH4UqC8Ij7hr25rMWswg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FMjN+tuRx9fBs6PAuHSahT2dpw6OyHdl/5Wj2odewzLz/RDObFWGw1qke1Pc8sXcF4/SyJmTXbvGmNjW15guVTLTTP//VcvY3faqSWQXfECSIatUGc7ebBhxJnhgO1ekkmulRBCQMXDnR63WMTdOBhpLwdxB18zWuqFhT+MhElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so29254315ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 18:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729559010; x=1730163810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzxZsfm2IDcVs092UIwNqZotbjszFdKSKjIKGExOKHQ=;
        b=QgPFW3z7TVcWE0y92I8mbw0zFNbO7ol1rYJLlm0iFBdjzhoMM5ZbQW48jSiL/PCxBc
         8u3q7ChrC8T5RuSaZdNirb/j9DWT2KY3Ad048aj40d0SYLTrXDql080ezU1cdwKViLJV
         AgJoJTNNY0BQh53zlJ+eFZv3oQMHw1Esf6gfCcyu/7UnaAiadE7gGIHrXW12yBrjKruj
         BgpO1pE/yGjYCP8iSoQltGJa8RPBJpFEkRYeYh2v3v9+HlSaTTCciN3R1FjXSSxEtZuB
         7HkYjOTzX4a9azKRhgPG1zgxixr+lNmAiuRwu+neuLw4ksLNZ87iJPBtHoLSO/CWjaEx
         r3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWX602Nbw3V9p8/W4ApMickbOc9BvQR/zZY+7nDvSrzNGCIftHVOUMRnZPsG6+kiF7yKdyekIMCv7JD5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGbH9hJQ4IVy2QLAPjVD/avO/HQnTiks6am5unvxT0i9FYy8z
	vq4mB/DJpuagV4iDwVFtB5rCwUBO6RFfnUAxG+LrjgPUD/hLguV0E4AroiMEWqaHvJ8lj6DXV3q
	gGdNlrcFbRIi6Cv/63BoqWWtVIGrx5OPJxd6u3w4NZ1XVivel0I/gBMY=
X-Google-Smtp-Source: AGHT+IGJaiI+3CeH6B/sc5zINJNVNKuTkHyLjV2ol/JP/x/cS6QMfQEZb2cI4vgewyw3WSJTREG6IkvB1ezhtvebiU3Dz31jXgfK
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a3f40474d0mr105674435ab.1.1729559010044; Mon, 21 Oct 2024
 18:03:30 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:03:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716f9e2.050a0220.1e4b4d.0068.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in extent_writepage_io
From: syzbot <syzbot+9295d5153c44d86af0aa@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6efbea77b390 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0c240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=9295d5153c44d86af0aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c18c5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12186f27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5dbbf0b1a9a5/disk-6efbea77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd272a84cc09/vmlinux-6efbea77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfcfcf079289/bzImage-6efbea77.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/504c13bf000c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9295d5153c44d86af0aa@syzkaller.appspotmail.com

assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1303
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:1303!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5258 Comm: syz-executor179 Not tainted 6.12.0-rc3-syzkaller-00183-g6efbea77b390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:submit_one_sector fs/btrfs/extent_io.c:1303 [inline]
RIP: 0010:extent_writepage_io+0xca2/0xd20 fs/btrfs/extent_io.c:1388
Code: fe 07 90 0f 0b e8 1e 28 d9 fd 48 c7 c7 80 0d 4d 8c 48 c7 c6 60 1b 4d 8c 48 c7 c2 20 0d 4d 8c b9 17 05 00 00 e8 5f f7 fe 07 90 <0f> 0b e8 f7 27 d9 fd eb 5f e8 f0 27 d9 fd 48 c7 c7 80 0d 4d 8c 48
RSP: 0018:ffffc90003eb6ec0 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000001000 RCX: 9c772e8b3e6d6f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003eb7030 R08: ffffffff8174af9c R09: 1ffff920007d6d74
R10: dffffc0000000000 R11: fffff520007d6d75 R12: fffffffffffffffd
R13: 0000000000007000 R14: dffffc0000000000 R15: ffffea0001c3a740
FS:  00007f6de66216c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020948000 CR3: 0000000076e7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 extent_writepage fs/btrfs/extent_io.c:1460 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2130 [inline]
 btrfs_writepages+0x11c4/0x2370 fs/btrfs/extent_io.c:2261
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 filemap_fdatawrite_range+0x11a/0x180 mm/filemap.c:449
 btrfs_fdatawrite_range+0x53/0xe0 fs/btrfs/file.c:3827
 btrfs_direct_write+0x565/0xa70 fs/btrfs/direct-io.c:961
 btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1505
 do_iter_readv_writev+0x600/0x880
 vfs_writev+0x376/0xba0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1215
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6de66ad5d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6de6621158 EFLAGS: 00000212 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f6de673a6e8 RCX: 00007f6de66ad5d9
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f6de673a6e0 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000007800 R11: 0000000000000212 R12: 00007f6de673a6ec
R13: 000000000000006e R14: 00007fffacb4cff0 R15: 00007fffacb4d0d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:submit_one_sector fs/btrfs/extent_io.c:1303 [inline]
RIP: 0010:extent_writepage_io+0xca2/0xd20 fs/btrfs/extent_io.c:1388
Code: fe 07 90 0f 0b e8 1e 28 d9 fd 48 c7 c7 80 0d 4d 8c 48 c7 c6 60 1b 4d 8c 48 c7 c2 20 0d 4d 8c b9 17 05 00 00 e8 5f f7 fe 07 90 <0f> 0b e8 f7 27 d9 fd eb 5f e8 f0 27 d9 fd 48 c7 c7 80 0d 4d 8c 48
RSP: 0018:ffffc90003eb6ec0 EFLAGS: 00010246
RAX: 000000000000004e RBX: 0000000000001000 RCX: 9c772e8b3e6d6f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003eb7030 R08: ffffffff8174af9c R09: 1ffff920007d6d74
R10: dffffc0000000000 R11: fffff520007d6d75 R12: fffffffffffffffd
R13: 0000000000007000 R14: dffffc0000000000 R15: ffffea0001c3a740
FS:  00007f6de66216c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005646f9cff0b8 CR3: 0000000076e7c000 CR4: 00000000003526f0
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

