Return-Path: <linux-btrfs+bounces-8757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F790997999
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 02:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243E41F22FB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F9BE6F;
	Thu, 10 Oct 2024 00:29:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89B28F1
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520145; cv=none; b=C3LINyxhFwbjTwbLbP0LYE7JPkn5Oj11day7IDuOXnLaY941lltWVfRK1JtlArZ7fu7r9SdtWI/u3LNrIbMmit2Ng/z9FCC8MH4N3gK9RlbDmOgmOymITv4ADVBgQytkOU41lIouGv3WK6Fqklzr/YOMWI5qU3x52bLdgwPHsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520145; c=relaxed/simple;
	bh=CrIuY1z2O47EY9ZXiK6fBtnEvPAyPbApAgb6+54fk9Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sCxqrspUoKe1RxuNZmUKJ6DYtmoGSLmakUTMu3FLDgKPvZhVD+6/o/vbXN9xDB3CQcLGaGDUwxuaTRPgb6H+8XXQqIEHEqc04xVYUVibMr+/HF/GLBcPucUTE6Pqtu0NH2crlZoGoNq98WCnK72nNzDGCtzCk7CZYK57G/Zip+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso3823815ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 17:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728520143; x=1729124943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1TxVT65BFXCYuMbBvsOMesJ1m9NwSOjZLNCeNxe5HY=;
        b=GwCMXgjtUa6HvyHSBhlseZJZEwIPFX+Y/fCOmY2rMGeyYBMjEklu7DZrqu6VNEKhal
         q7nUUGthLQfq4ETP2GvkyQhnyxV8tA3tXE/4otLdQhb8XU0S9S1jVnyLtuLKQRYNLd1L
         O3TxuLwwjLQNTDWYKgVbjy2X5cTKxdd78+jFms+9dValstxRCqxw7GztA5P4iduupixz
         PgCtwDb1uD/UpO+FcbTj0Sa6bO7H7jXsP7OKB7WjcswOqlNYfi7skzRcsLyfv9sNNjQx
         BPn86rdqIHiWPROtjD3Bw1XhYhJqPZd+H86dU/NvW1I9NVIYUn12wM8Z8XbJaB/wkk0C
         nQwg==
X-Forwarded-Encrypted: i=1; AJvYcCXCSzGnev9gFBkegrHa0PfNzCGk5nMR0XDCpYLIEpHmPraMmaEwnRVisIvuyRfIQY5wW8sZg4VFlDvNYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3B/JnzmfCTxzOD3l7Gcl8cMnAx6MIETi6TplkqcChfElvDOe4
	YLLWxvjpNtlqT3bl/dwDQdsUhL7hdb5EDXCHoWQA6yb57f3I5Ok5BoOzq9tzMfoxgZ4Yswvdrpv
	z33T5YZ0X+eBfVx5YKLWHh2KrdfGObvoe2Qwq64fT8HRBlzQTFu25T4M=
X-Google-Smtp-Source: AGHT+IGOXEhmv9FleUOZIxF5i+on3yXbmJNyROKLayw8lALZldteiBQx/alNGkBheTqA4gpilBDDcl5R/eI2dhcjd3JfTlcyBKpM
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3a0:9954:a6fa with SMTP id
 e9e14a558f8ab-3a397ce58abmr34572735ab.9.1728520143261; Wed, 09 Oct 2024
 17:29:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 17:29:03 -0700
In-Reply-To: <abc5e714-53a8-4b23-be5c-966442cbb0c1@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67071fcf.050a0220.1139e6.0013.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in getname_kernel

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 6008 Comm: syz.0.15 Not tainted 6.12.0-rc2-syzkaller-00045-g964c2da72390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
RSP: 0018:ffffc900035af8a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802d46bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff942c58f7 R09: 1ffffffff2858b1e
R10: dffffc0000000000 R11: fffffbfff2858b1f R12: ffffffffffffffff
R13: ffff8880727f8000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f01495d76c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f75ffff CR3: 000000002cffe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 getname_kernel+0x1d/0x2f0 fs/namei.c:232
 kern_path+0x1d/0x50 fs/namei.c:2716
 is_good_dev_path fs/btrfs/volumes.c:760 [inline]
 btrfs_scan_one_device+0x19e/0xd90 fs/btrfs/volumes.c:1492
 btrfs_get_tree_super fs/btrfs/super.c:1841 [inline]
 btrfs_get_tree+0x30e/0x1920 fs/btrfs/super.c:2114
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 fc_mount+0x1b/0xb0 fs/namespace.c:1231
 btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
 btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
 __do_sys_fsconfig fs/fsopen.c:472 [inline]
 __se_sys_fsconfig+0xa1f/0xf70 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f014877dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01495d7038 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f0148935f80 RCX: 00007f014877dff9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007f01487f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0148935f80 R15: 00007ffe7a9c13b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
RSP: 0018:ffffc900035af8a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802d46bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff942c58f7 R09: 1ffffffff2858b1e
R10: dffffc0000000000 R11: fffffbfff2858b1f R12: ffffffffffffffff
R13: ffff8880727f8000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f01495d76c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f75ffff CR3: 000000002cffe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	fa                   	cli
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 54                	push   %r12
   7:	53                   	push   %rbx
   8:	49 89 fe             	mov    %rdi,%r14
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  19:	fc ff df
  1c:	48 89 fb             	mov    %rdi,%rbx
  1f:	49 89 c4             	mov    %rax,%r12
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 12                	jne    0x44
  32:	48 ff c3             	inc    %rbx
  35:	49 8d 44 24 01       	lea    0x1(%r12),%rax
  3a:	43                   	rex.XB
  3b:	80                   	.byte 0x80
  3c:	7c 26                	jl     0x64
  3e:	01                   	.byte 0x1


Tested on:

commit:         964c2da7 btrfs: make buffered write to copy one page a..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=1296b7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

