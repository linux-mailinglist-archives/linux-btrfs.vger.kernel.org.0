Return-Path: <linux-btrfs+bounces-9598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F63A9C776A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C611F2B15C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85591205ABB;
	Wed, 13 Nov 2024 15:32:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75833167D83
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511945; cv=none; b=PzziklUHMJsX7ky07Vi+/PR5Ndla2LyjxwAsIbCX4DIlRPrwrsl4LPB6jRmhMAXi8IdoCAYX3TCG7ws+MgUZxBQ5CmM3j2E5eWMGbJSOiHg9Ur/+7OrlqshVIk6WcbLrdsSibSJEE4p1FxWxqfxtdHBaEON4gACbu6OzV1KulhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511945; c=relaxed/simple;
	bh=cz4X2Ul+jZf2d9ttecwCoIMytroncE3J6S0B76MBUXo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s+Qw3/OFp5LyJoIidLCwiuiNSpkHrKl6nsklRV4DmC6u1+qWbxEBiJHnXbdBm0NXNTPEjBp7XTrVW+rSJS4NO120XIHDxQQfBg2TDL2xkXG21dDt1duqnV6cHpU1TQktEuarO32b2khdg3JhVK4BKjLmv/IfjijCc4ZDrKXzVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a719b7325aso6081635ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 07:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511942; x=1732116742;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUMXG3lbjeeWyC9tFJxlOYCguJIJWlyOxeQSFXRndY4=;
        b=DCVLh7aT7z9cURxUEDlv5VJ/5BtSKjTvat4AEkF2P7aagEDVr7M8oHoiyzHFJfP28l
         9I6RZeXziFS//yawXeHBptVB8ezaoCxZbAL1xwGEQDpBwqLD0UpuUc3Roa2mFrBKbIfz
         TZH5RfoPVaOazofUsJ7qpxppm+dbDUeJAYqi4Z5G0RVmuxF8bEz4w2oSINKR9L3eUq6U
         e+InbMtN0z2G7Sltx7mVuVYvSecdlUM/JH7GrTVlJ7jjQHZe7fA/WiXhFHbNHU5YLzDp
         ahirm1Y8skeI4NxIAE1+kReslclk/CgDZ5HYF11nKubqrHSEsaoWhHG21rWJbC9kKII9
         QxCw==
X-Forwarded-Encrypted: i=1; AJvYcCWkIZ7KD8799mMMb+N6iFQ6nzLMU3Swx0zvx6G7ORhM5cWoE38AFjCFx8Mlb1jksXEWIHx/hGsgIZmxuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+J1itzQ6yFLbgpvyMm8C3+mJ+828Z9iSlhnaBJeLjpx1YA25
	TWOW+xbw3VFF75NhCgregmperYEMY1JXuDASKTxUgwGD117yQmhw7RVtbS6I/bMQz8+RPOxHpCN
	N/r6MRkGBqkDszrCATUQu1WFqUYEyDVgxcBNyrwVcXzHCYtOMtZSnm8w=
X-Google-Smtp-Source: AGHT+IGEDF33haZV9iQlj5U0rmVP006qyv92A1JcU3EUNHH2DfHy/JNrdzoWqJ8DDSmbhqxPNd4GwsT0ifVWoEfbw5y54g7EbP/R
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ef:b0:3a6:c493:7395 with SMTP id
 e9e14a558f8ab-3a6f199ff2dmr250705525ab.5.1731511942581; Wed, 13 Nov 2024
 07:32:22 -0800 (PST)
Date: Wed, 13 Nov 2024 07:32:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734c686.050a0220.2a2fcc.002b.GAE@google.com>
Subject: [syzbot] [btrfs?] BUG: unable to handle kernel paging request in btrfs_stop_all_workers
From: syzbot <syzbot+828d8ee1e5e42c37d573@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    baa007e8da32 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12df8130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce37d357fac206c
dashboard link: https://syzkaller.appspot.com/bug?extid=828d8ee1e5e42c37d573
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/091805c67446/disk-baa007e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/853803d703a2/vmlinux-baa007e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65373a9a8186/Image-baa007e8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+828d8ee1e5e42c37d573@syzkaller.appspotmail.com

BTRFS info (device loop2): last unmount of filesystem 3a492a15-ac49-4ce6-945e-cef7a687c6c9
Unable to handle kernel paging request at virtual address f2ff9fffe0001824
KASAN: maybe wild-memory-access in range [0x9800ffff0000c120-0x9800ffff0000c127]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[f2ff9fffe0001824] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6432 Comm: syz-executor Not tainted 6.12.0-rc7-syzkaller-gbaa007e8da32 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0xfc/0x77c8 kernel/locking/lockdep.c:5065
lr : lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
sp : ffff8000a2b47280
x29: ffff8000a2b47540 x28: ffff80008025cf24 x27: 0000000000000000
x26: ffff0001b365a4c0 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: 1ffff00011f020ba x21: 9800ffff0000c120
x20: 0000000000000001 x19: 0000000000000000 x18: 1fffe000366cb476
x17: ffff80008f80d000 x16: ffff8000830cd010 x15: 0000000000000001
x14: ffff80008f8105d8 x13: dfff800000000000 x12: ffff700014568e78
x11: ffff800080359190 x10: ffff80008f8105d4 x9 : 00000000000000f3
x8 : 13001fffe0001824 x7 : ffff80008025cf24 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 9800ffff0000c120
Call trace:
 __lock_acquire+0xfc/0x77c8 kernel/locking/lockdep.c:5065 (P)
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825 (L)
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x58/0x70 kernel/locking/spinlock.c:170
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 destroy_workqueue+0x8d8/0xdc0 kernel/workqueue.c:5883
 btrfs_stop_all_workers+0x10c/0x240 fs/btrfs/disk-io.c:1787
 close_ctree+0x598/0xb3c fs/btrfs/disk-io.c:4362
 btrfs_put_super+0x70/0x80 fs/btrfs/super.c:75
 generic_shutdown_super+0x12c/0x2bc fs/super.c:642
 kill_anon_super+0x4c/0x7c fs/super.c:1237
 btrfs_kill_super+0x40/0x58 fs/btrfs/super.c:2114
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1373
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1380
 task_work_run+0x230/0x2e0 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0x4ec/0x1ad0 kernel/exit.c:939
 do_group_exit+0x194/0x22c kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 pid_child_should_wake+0x0/0x1dc kernel/exit.c:1097
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: f007a5a8 b945d508 34008c88 d343fea8 (386d6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f007a5a8 	adrp	x8, 0xf4b7000
   4:	b945d508 	ldr	w8, [x8, #1492]
   8:	34008c88 	cbz	w8, 0x1198
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	386d6908 	ldrb	w8, [x8, x13] <-- trapping instruction


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

