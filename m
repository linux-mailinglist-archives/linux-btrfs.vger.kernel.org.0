Return-Path: <linux-btrfs+bounces-7306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB98955B13
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 08:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CE31C2108E
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 06:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFBDF59;
	Sun, 18 Aug 2024 06:06:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE445C8C7
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Aug 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961186; cv=none; b=ZuM7rnHBpnvUqjF8iLx1oFeNadZLBApEnj+jymgA0PbjVIHGZJ1ZazETZ/35IXrdE5t7VpRX/0en8oiRbUAnn2sKzP/1gOrSvR/W79IVxNbJJCiP9zSFJ0oLzq1eQ7PU6+nsXtK62Ay6Wb3AIGwDtivNzuiTPYZwQNdh3AbmqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961186; c=relaxed/simple;
	bh=jz7twpM+7+6ff0ALSulET3mW0nfeOe/+biy+TCNXhCE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b1ECFp5IIQJpvHJJpTFRLYfby+b34bK0Sk7eyQG37MKhqYGtsukNZw3NS5aGYACu9mUskRd11/NZGD+cAEMe533zLsK2M3rS2mjX3GEi/MWyqn2wGv3iK2/ZS15fJzau9xDM7ulOCeC7t3T5xCWg3UTlQ7xMxNzTjENX1ZPo2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f81da0972so350672839f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2024 23:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723961184; x=1724565984;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLeaX4ZYCJfD/qs4gb+GcXtjCSYeyQ791Oq5hIK8L+0=;
        b=AhjBhBbEHikeBQmlZhjTsLVZrFwPLLfFj8opoFNZBPGsDoZDX2SaW2O/8rHTP/FPfb
         nBqSBA0OtwdwFIPKYAMSQpknzM4uxHsSex2jo75HP6Xw7Xr5+fPKyAvVzPSLnjO7hcqw
         RGaMshYbHpGbpsdiGgpL8EPbwth29TdCG3064U2xlRnyjxTULLkexbDJTIYxAamfCzdy
         1J9gvhWNncfZ/p7VUmRycINnahh88IRinjhGsoWfTkfYcgnmPFytEH04Loy6zxEN1EIb
         hoGrEXaaiGTe8XqDEBzkD/lMwNbCM2BBJ07LG1Ehulgng0y0T+p5mcsSt+qaJ+HqHm7L
         NWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoZwPIr3zfY+4Qa1/w09XKCDeVQjk1iAXAvaGyJ+dtx4PNlAsKw+ZpRyQtkXMmaG7ad6O2njnHEZZxwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztfaptunhbQgvOsFh07K4AtjTflgktekNncDPQDrU2ECwI0ARt
	SS2CnOaoeJhY+MciqVB5HSu0e9U9t26DF9wDMGz+f0LXI5YTDiptDnonPKQZfDP+Qa1OnRadyWW
	jxPFpSEa9yCC6TuvJvT3gQXf8mHl+I2juTIimcf+FVnlIJ6jULE+J6Vk=
X-Google-Smtp-Source: AGHT+IEJCxuzGlogMXXEg0BKd1mVFe9tR628QCFxjm2ZeAqwHWmde9T2H0ftSQH48Qf95vFDQzngikaGTvkQFhSvC0+uiv2WRMGG
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9807:b0:4c0:a90d:4a78 with SMTP id
 8926c6da1cb9f-4cce173107cmr474656173.6.1723961183755; Sat, 17 Aug 2024
 23:06:23 -0700 (PDT)
Date: Sat, 17 Aug 2024 23:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6f09e061feefd16@google.com>
Subject: [syzbot] [btrfs?] general protection fault in __alloc_workqueue
From: syzbot <syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, clm@fb.com, davem@davemloft.net, dsterba@suse.com, 
	edumazet@google.com, josef@toxicpanda.com, kuba@kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D12aa95f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee546=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9fd43bb1ae7b5d924=
0c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b868dd98000=
0

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-=
367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-=
367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzI=
mage-367b5c3d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com

workqueue: Failed to create a rescuer kthread for wq "wg-crypt-=18": -EINTR
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5585 Comm: syz-executor Not tainted 6.11.0-rc3-next-2024=
0816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 08/06/2024
RIP: 0010:__lock_acquire+0x69/0x2040 kernel/locking/lockdep.c:5010
Code: b6 04 30 84 c0 0f 85 87 16 00 00 45 31 f6 83 3d b8 08 a9 0e 00 0f 84 =
ac 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 1=
2 4c 89 ff e8 49 5c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000306ec30 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: ffff88802c88bc00
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555563814500(0000) GS:ffff8880b9000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ead045000 CR3: 0000000061be2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
 touch_wq_lockdep_map kernel/workqueue.c:3876 [inline]
 __flush_workqueue+0x1e3/0x1770 kernel/workqueue.c:3918
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4082
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5830
 __alloc_workqueue+0x1c30/0x1fb0 kernel/workqueue.c:5745
 alloc_workqueue+0xd6/0x210 kernel/workqueue.c:5758
 wg_newlink+0x260/0x640 drivers/net/wireguard/device.c:343
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1591/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a8/0x500 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f943557bd0c
Code: 2a 5a 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b =
54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff f=
f 77 34 89 ef 48 89 44 24 08 e8 70 5a 02 00 48 8b
RSP: 002b:00007ffd6d464f30 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f9436244620 RCX: 00007f943557bd0c
RDX: 000000000000003c RSI: 00007f9436244670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd6d464f84 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f9436244670 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x2040 kernel/locking/lockdep.c:5010
Code: b6 04 30 84 c0 0f 85 87 16 00 00 45 31 f6 83 3d b8 08 a9 0e 00 0f 84 =
ac 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 1=
2 4c 89 ff e8 49 5c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000306ec30 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: ffff88802c88bc00
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555563814500(0000) GS:ffff8880b9000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ead045000 CR3: 0000000061be2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 87 16 	xor    %al,0x1687850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d b8 08 a9 0e 00 	cmpl   $0x0,0xea908b8(%rip)        # 0xea908cd
  15:	0f 84 ac 13 00 00    	je     0x13c7
  1b:	89 54 24 54          	mov    %edx,0x54(%rsp)
  1f:	89 5c 24 68          	mov    %ebx,0x68(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruct=
ion
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 49 5c 8c 00       	call   0x8c5c81
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

