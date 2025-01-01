Return-Path: <linux-btrfs+bounces-10661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FB9FF47D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 17:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A07A10DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8E1E2823;
	Wed,  1 Jan 2025 16:11:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D951E1C30
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735747896; cv=none; b=o59KWrJW7fqh5WrAdo9CQ5aGq1KTmrSkZAHiP3yUBnJBb+IQpu5Xb0jN+m/O+XLscrtnZYc/aDFwtHedYqZuqmWDmnVcOCYPOvQcAVmSFjCeuR5V5NyJDeSGL8pNnHFGJH9Y+zoDh91Ncs2+VtwiUbkTnImo4J5fQHliLudXSLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735747896; c=relaxed/simple;
	bh=GLBO1faOFAB/t57Pj7FUjW1IgMyEzp4PtMDZlIdI17k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WKNrmMzTY830KDQDvXn8MqJlMtfpumUzZ0IMYEs/DD1zOpeFNtwZ1erI1XFFRYGNirhI1fBPIK8zJVFqCuRxwMcj3YQxUaCf6bfYM8jG8Y9SpTuwE0oePQtAQsChK66/6lrgOUeoRqJazcv9OHnxbIwk5hORba8+79+SI9CvgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so217111445ab.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jan 2025 08:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735747893; x=1736352693;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeHsEsChOy4dOtdJbwX97/0fVpqRfeWlw4SUPaV342w=;
        b=jPZ1znz+57ukwtjzewibFhogx9VjPDp/v+AYpia1pKDRJmlsq5t/sHpWKmGzfKfF4U
         pYJlZi1LldQu9rYHOg0KhHckAIGyqMp2FOgglwE6PR56rbJfegpzKlUqytrBHN6gYzX3
         2rCm6oP94yYjQTY3vAMVcL7VYMm8AHMw03FdNOhJMobIkFnQ9zV5IY9Sy0GNb2E6yw6Z
         jL70CfmPRd+8A78pyhj3RYHAXt4/j5iN2nsy8ZCCun3wzTj+G4zDza4vICAjMhtJw5Ip
         zF431YYnEajJzv2SUoACsTcvtQQswW7HSp0s2yB5+QZEiEzJ7+F5GeN34MTK/R5y9c0h
         mkPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdilpQdCrTWywVH6CXF9G7I9yH0WpBnycXEmBRMmYPwTLlfD2vxqfvlE+qNHp2DkuzP+phlXTXyj5MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZQ73Ed0Dwx1+1JZEr3xdaDVcjG1utE8NUOC61qBlMqK0Rl7W
	so9W3wdExiDZEy+8P9UOo0pofMtXhhEf4Dxt/YwfbQbVGpicUwoOesffc4uGUmti6vl397Zqy+T
	nOiYZHM60qQy8nP4NOdMg6rYSFel85Npx+jVrFBVuMpzICGdXeNI80xM=
X-Google-Smtp-Source: AGHT+IE0TLfX0EEeNdkY3bDZx7CtfydsRFyoLxrxFogeJxtCMNBcTrKCcc/2HOKhHtQjk5EWys+C/B8h/86gPGSpJT4K8wjcXsBC
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c8:b0:3a7:d84c:f2b0 with SMTP id
 e9e14a558f8ab-3c2d277f25cmr434967685ab.8.1735747893750; Wed, 01 Jan 2025
 08:11:33 -0800 (PST)
Date: Wed, 01 Jan 2025 08:11:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67756935.050a0220.25abdd.0a12.GAE@google.com>
Subject: [syzbot] [btrfs?] BUG: unable to handle kernel paging request in find_first_extent_item
From: syzbot <syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1256d0b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7202b56d469648
dashboard link: https://syzkaller.appspot.com/bug?extid=339e9dbe3a2ca419b85d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1254c818580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172486df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d3b5c855aa0/disk-573067a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c06fc1ead83/vmlinux-573067a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3390e59b9e4b/Image-573067a5.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0d8dc2ed77bb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com

BTRFS info (device loop0): scrub: started on devid 1
Unable to handle kernel paging request at virtual address dfff800000000041
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000041] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6417 Comm: syz-executor153 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : find_first_extent_item+0xac/0x674 fs/btrfs/scrub.c:1375
lr : find_first_extent_item+0xa4/0x674 fs/btrfs/scrub.c:1374
sp : ffff8000a5be6e60
x29: ffff8000a5be6f80 x28: dfff800000000000 x27: 0000000000000000
x26: 0000000000400000 x25: 0000000000400000 x24: 1fffe0001848ab0a
x23: 0000000000000208 x22: ffff8000a5be6f20 x21: ffff0000c2455858
x20: ffff8000a5be6ec0 x19: ffff0000db072010 x18: ffff0000db072010
x17: 000000000000e32c x16: ffff80008b5fea08 x15: 0000000000000004
x14: 1fffe0001b60c031 x13: 0000000000000000 x12: ffff700014b7cdd8
x11: ffff80008257f234 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000041 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000008 x3 : 0000000000400000
x2 : 0000000000100000 x1 : ffff0000db072010 x0 : 0000000000000000
Call trace:
 find_first_extent_item+0xac/0x674 fs/btrfs/scrub.c:1375 (P)
 scrub_find_fill_first_stripe+0x2c0/0xab8 fs/btrfs/scrub.c:1551
 queue_scrub_stripe fs/btrfs/scrub.c:1921 [inline]
 scrub_simple_mirror+0x440/0x7e4 fs/btrfs/scrub.c:2152
 scrub_stripe+0x7e4/0x2174 fs/btrfs/scrub.c:2317
 scrub_chunk+0x268/0x41c fs/btrfs/scrub.c:2443
 scrub_enumerate_chunks+0xd38/0x1784 fs/btrfs/scrub.c:2707
 btrfs_scrub_dev+0x5a8/0xb34 fs/btrfs/scrub.c:3029
 btrfs_ioctl_scrub+0x1f4/0x3e8 fs/btrfs/ioctl.c:3248
 btrfs_ioctl+0x6a8/0xb04 fs/btrfs/ioctl.c:5246
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: b900118a 97847832 91082377 d343fee8 (387c6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b900118a 	str	w10, [x12, #16]
   4:	97847832 	bl	0xfffffffffe11e0cc
   8:	91082377 	add	x23, x27, #0x208
   c:	d343fee8 	lsr	x8, x23, #3
* 10:	387c6908 	ldrb	w8, [x8, x28] <-- trapping instruction


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

