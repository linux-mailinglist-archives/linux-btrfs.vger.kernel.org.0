Return-Path: <linux-btrfs+bounces-7327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683B95785B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 01:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F6B21D43
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 23:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958A1E2116;
	Mon, 19 Aug 2024 23:06:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B21DD384
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108787; cv=none; b=jr8xPa/BhNWKV37OEVC66QKqjRsMi1PGeD6Ly9sO3BNeEFM7kfdg1dsyF5RvW3M1fugw2KdRKpjRmTaqJ4JYJbJEIG9zcijc4BnOdWsv1BCemmH89nNoXYcPDQ4oP7GvKMpmmjT7R+YxbdHnN2SNq1z7iQDDiiOWhBS4e4EGfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108787; c=relaxed/simple;
	bh=u1njAj6+UfJ0WpyQt66qhpI6ohoE7RApXFZkn6BxuUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c75WBiEPdmQbMFrottnO6KymFAC1TUcBBGo4CJEV9jYhVZ1vvw8vsmGpbnrUTJ6s4O2HoP06JKiXgTEgwo+ypALaUjKTKd00566QRpRojvUEutMriM92urv+lDRCpxQ8CsjuzoM1X0vcD8UdQ3QVPA9QFS/ZSojgYyuibf7ZMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2dee9722so39593885ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 16:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724108785; x=1724713585;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcqLAn/0WxmaTOn+9QeeAyIEyPR9eYIH/vhup2t6WV4=;
        b=BYOug7tbtI8gM2puGed14FrwN+vvvuhDQS5NkRF5rHZHSFZGk/eZXycTiI9scKdm0n
         yKl8osq3dGNthJzmrPUl56tjjPCymVpHgiFZ2WgEkS44H/zV8WKHM+5kNLLVSsc/0B0q
         6IlCwI8MUf1TsA4FfJdr/QOHVo9HPg+2vt6FqO1AiGBkOD6Hp56alRinj3Rr7MtxZ++q
         YvmTargY8XrrCE5UlxPgYdMasAKYX6rRW31MslcQVt3TLXEnrLdF3pOtpZubfiRtnOAX
         AAMhPCWd+Na7+fgY8KQijDNLH05y4awVeVhgyJOizsj1xoSN4azE64o6CrtsJRW46knx
         Zr3g==
X-Forwarded-Encrypted: i=1; AJvYcCXANbZV3FwojWFL4jAMaPcOQPZjC2fKTXuFXwupuT6um0W+CO09JnPolJEbQUc9YaO15UnfGiou6IQHDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ohu7theOGPC7GXInVVr90XhNBXiWholQqSPj7vUK5GIIqqlB
	rNDZox4pyR7hw6lcdnFZDGHfSIqguPwHIpzvAVK4mAcNgIIaHfzv6v5MaUrin4LT9+NBPdNDGt+
	M4Ivd5ztS3L3kKMgR6krpm7dpv6r9/gcjdyHdEcmFJAmp1xsW6bbxo24=
X-Google-Smtp-Source: AGHT+IFpdZ7oC/bG0cCQW9emo025+pIVRewECDg57asvxq3GaGoe7xmu6MGqkKYgdt98fl0AkpR9w1JYF9yoBi+ohv/pcIsMqrlA
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3106:b0:39d:300f:e911 with SMTP id
 e9e14a558f8ab-39d300fec7fmr7563125ab.2.1724108784919; Mon, 19 Aug 2024
 16:06:24 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:06:24 -0700
In-Reply-To: <000000000000f6f09e061feefd16@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adfbb70620115bdc@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in __alloc_workqueue
From: syzbot <syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com>
To: clm@fb.com, davem@davemloft.net, dsterba@suse.com, edumazet@google.com, 
	hdanton@sina.com, jason@zx2c4.com, josef@toxicpanda.com, kuba@kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16ef69f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee546=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9fd43bb1ae7b5d924=
0c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17582fbb98000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1060bfc5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-=
367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-=
367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzI=
mage-367b5c3d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/af299b68d869=
/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com

workqueue: Failed to create a rescuer kthread for wq "btrfs-=18": -EINTR
Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 8040 Comm: syz-executor149 Not tainted 6.11.0-rc3-next-2=
0240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 08/06/2024
RIP: 0010:__lock_acquire+0x69/0x2040 kernel/locking/lockdep.c:5010
Code: b6 04 30 84 c0 0f 85 87 16 00 00 45 31 f6 83 3d b8 08 a9 0e 00 0f 84 =
ac 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 1=
2 4c 89 ff e8 49 5c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000e68f030 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: ffff88802b298000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fbb7be9e6c0(0000) GS:ffff8880b9000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055df1c2ef668 CR3: 000000002e318000 CR4: 00000000003506f0
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
 btrfs_alloc_workqueue+0x1c8/0x2a0 fs/btrfs/async-thread.c:112
 btrfs_init_workqueues+0x3af/0x740 fs/btrfs/disk-io.c:2004
 open_ctree+0x122c/0x2a10 fs/btrfs/disk-io.c:3364
 btrfs_fill_super fs/btrfs/super.c:965 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1888 [inline]
 btrfs_get_tree+0xe7a/0x1920 fs/btrfs/super.c:2114
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 fc_mount+0x1b/0xb0 fs/namespace.c:1231
 btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
 btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb7bf1346a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 1e 09 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb7be9e088 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fbb7be9e0a0 RCX: 00007fbb7bf1346a
RDX: 0000000020005100 RSI: 0000000020005140 RDI: 00007fbb7be9e0a0
RBP: 0000000000000004 R08: 00007fbb7be9e0e0 R09: 0000000000005106
R10: 0000000000000012 R11: 0000000000000282 R12: 00007fbb7be9e0e0
R13: 0000000000000012 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x2040 kernel/locking/lockdep.c:5010
Code: b6 04 30 84 c0 0f 85 87 16 00 00 45 31 f6 83 3d b8 08 a9 0e 00 0f 84 =
ac 13 00 00 89 54 24 54 89 5c 24 68 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 1=
2 4c 89 ff e8 49 5c 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc9000e68f030 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff20318b6 R12: ffff88802b298000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fbb7be9e6c0(0000) GS:ffff8880b9000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055df1c2ef668 CR3: 000000002e318000 CR4: 00000000003506f0
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
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

