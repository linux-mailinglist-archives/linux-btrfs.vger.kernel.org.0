Return-Path: <linux-btrfs+bounces-18772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46610C3AC3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 13:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB461AA4F9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE831BC80;
	Thu,  6 Nov 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjBVURS7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75130E849
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430073; cv=none; b=rmKOQTv2zuwQqtv6vh7unK5lsutc+1UMxyHSmh0DSceuXvBppCkXv14+8C4+4/MKtI4JjbtzxhI15j+mBlV+nhsM7Vj6SH+hFDmyDYjf2B51/VS/z8Uu1nSOOVz1qYaXP3AGOSFonZXO0x77D+7NbPqUb3z00r46S37lJHgOPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430073; c=relaxed/simple;
	bh=vmRx84HLM+7Bkb1i6ucBzdqZPtq1ze7YIvuHXKY9+XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8rTSWa6ysXnB7Ux3K+xGKk1pUI7s8obvgxxUQIykkJKWyQIddUQpM5wxhXB/ng4pxOlzMFrftylK7s2RpCVZTgg+ubeWKAUUi8GIetltO9Z/wX7R3/x5AFeaWs6j1B56rbBO8bE4r4yoSDv79q7bKCCO2nbb/A0qAYFYWbUpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjBVURS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82547C113D0
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 11:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762430072;
	bh=vmRx84HLM+7Bkb1i6ucBzdqZPtq1ze7YIvuHXKY9+XY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qjBVURS7474yucGqSlBB6alZwtaFhC38B3vZOHI7pV/bUZgS0EM4PwoMtozzl7JsC
	 F/vgSDjAw3bjgyZ+Bgqr+WX9RcMW5bBnHNJCfeMN/7hSRiPrFrYqFbQzfn8HBF5JYl
	 yrg0MsLNA53eSATyO8qHfNN6xLoZ7CN5+QuCOTOOEr+bxkcf5Xx1gD9K3rgl/gF7Hu
	 Kf3zHdWluHlAJgpF3NwHWNsLSQY37fjvMHBMNiqK2DAgp5hUrShg7PlXkzT8JdL1qf
	 +8fuaI9mXF/Gx3LanOSPRVrF7HDXRYJtUCeGLefBTYqBUrk8Shxx3yWr3nFHqt/aPx
	 EdTI7mBeLAlHw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b726997b121so280574966b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 03:54:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXg+PI1fOzAOmicetlmfp91JmcqSx274AuIXcSwz6S1pN3sFfVX6qYrnozY7Wo0VNd3SkhD2mR65+Zy1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pzVcROkKbqJw1AwcsQ3ET63m/7GcBTRIKPCLrVbxeIeI0B+1
	QBL8Z8+8dY7rp8bu/KuLY9ADYpkaoPYC+ah0xY/hjMiZbbsUWw9n5fO9gBUfR8A7gG3NSrGNMAN
	nHQA55YAWPabKgecHA71JUPBJTQzbBdM=
X-Google-Smtp-Source: AGHT+IHU73dnQxL6TwgD3QMuBkYLhSTVTuhv5aLiY1DMJ162sVMAaLpfE/fLPEECVkr0ZEeK+RQtD+oDpBIoHXsmmus=
X-Received: by 2002:a17:907:2d94:b0:b70:b161:b9a8 with SMTP id
 a640c23a62f3a-b72892ac5acmr342527266b.2.1762430071056; Thu, 06 Nov 2025
 03:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690bd529.050a0220.baf87.0079.GAE@google.com>
In-Reply-To: <690bd529.050a0220.baf87.0079.GAE@google.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Nov 2025 11:53:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Jc9-NMyk49Dykt291jpuVfWAEDnZtfnC3jjc13FLVcw@mail.gmail.com>
X-Gm-Features: AWmQ_bmvUm7Vjc_TA_T93nKnDtTvimWh09YUVPy4tJdC8dXQoKv6kOZ2P7KRzpw
Message-ID: <CAL3q7H6Jc9-NMyk49Dykt291jpuVfWAEDnZtfnC3jjc13FLVcw@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in reserve_bytes
To: syzbot <syzbot+feba382c68462d76be14@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:54=E2=80=AFPM syzbot
<syzbot+feba382c68462d76be14@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    98bd8b16ae57 Add linux-next specific files for 20251031
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17abfe7c58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D63d09725c93bc=
c1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfeba382c68462d7=
6be14
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/975261746f29/dis=
k-98bd8b16.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ad565c6cf272/vmlinu=
x-98bd8b16.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1816a55a8d5f/b=
zImage-98bd8b16.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+feba382c68462d76be14@syzkaller.appspotmail.com
>
> assertion failed: !(ticket->bytes =3D=3D 0 && ticket->error) :: 0, in fs/=
btrfs/space-info.c:1671
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/space-info.c:1671!

It's a race introduced with the patch: "btrfs: avoid space_info
locking when checking if tickets are served"

I'll fold the following diff to patch and push it to the for-next branch.

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 63d14b5dfc6c..85c96b8bef7f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -527,7 +527,12 @@ static void remove_ticket(struct btrfs_space_info
*space_info,
        }

        spin_lock(&ticket->lock);
-       if (error)
+       /*
+        * If we are called from a task waiting on the ticket, it may happe=
n
+        * that before it sets an error on the ticket, a reclaim task was a=
ble
+        * to satisfy the ticket. In that case ignore the error.
+        */
+       if (error && ticket->bytes > 0)
                ticket->error =3D error;
        else
                ticket->bytes =3D 0;

Thanks.


> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 7313 Comm: syz.1.358 Not tainted syzkaller #0 PREEMPT(=
full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:handle_reserve_ticket fs/btrfs/space-info.c:1671 [inline]
> RIP: 0010:reserve_bytes+0x129e/0x1410 fs/btrfs/space-info.c:1864
> Code: 0f 0b e8 15 f0 cc fd 48 c7 c7 60 c9 b0 8b 48 c7 c6 80 d5 b0 8b 31 d=
2 48 c7 c1 40 c6 b0 8b 41 b8 87 06 00 00 e8 f3 f8 33 fd 90 <0f> 0b f3 0f 1e=
 fa 65 8b 1d 59 4a 80 0e bf 07 00 00 00 89 de e8 19
> RSP: 0018:ffffc9000f2ff180 EFLAGS: 00010246
> RAX: 000000000000005c RBX: 0000000000000000 RCX: 6a0e5d27bc457900
> RDX: ffffc9000d29b000 RSI: 00000000000080c9 RDI: 00000000000080ca
> RBP: ffffc9000f2ff3c0 R08: ffffc9000f2feea7 R09: 1ffff92001e5fdd4
> R10: dffffc0000000000 R11: fffff52001e5fdd5 R12: ffff88814e273000
> R13: dffffc0000000000 R14: 00000000fffffffc R15: ffffc9000f2ff220
> FS:  00007f71682106c0(0000) GS:ffff888125ee2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe3d8bb6d60 CR3: 0000000029df0000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  btrfs_reserve_metadata_bytes+0x28/0x150 fs/btrfs/space-info.c:1887
>  btrfs_reserve_trans_metadata fs/btrfs/transaction.c:577 [inline]
>  start_transaction+0x102c/0x1610 fs/btrfs/transaction.c:658
>  btrfs_replace_file_extents+0x2b1/0x1de0 fs/btrfs/file.c:2432
>  insert_prealloc_file_extent fs/btrfs/inode.c:9004 [inline]
>  __btrfs_prealloc_file_range+0x48d/0xcf0 fs/btrfs/inode.c:9071
>  btrfs_prealloc_file_range+0x40/0x60 fs/btrfs/inode.c:9149
>  btrfs_zero_range+0xb9a/0xe00 fs/btrfs/file.c:3073
>  btrfs_fallocate+0xb95/0x1c10 fs/btrfs/file.c:3187
>  vfs_fallocate+0x669/0x7e0 fs/open.c:342
>  ksys_fallocate fs/open.c:366 [inline]
>  __do_sys_fallocate fs/open.c:371 [inline]
>  __se_sys_fallocate fs/open.c:369 [inline]
>  __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f716738efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7168210038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> RAX: ffffffffffffffda RBX: 00007f71675e6090 RCX: 00007f716738efc9
> RDX: 0000000000003ffd RSI: 0000000000000010 RDI: 000000000000000a
> RBP: 00007f7167411f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f71675e6128 R14: 00007f71675e6090 R15: 00007fff6c300678
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:handle_reserve_ticket fs/btrfs/space-info.c:1671 [inline]
> RIP: 0010:reserve_bytes+0x129e/0x1410 fs/btrfs/space-info.c:1864
> Code: 0f 0b e8 15 f0 cc fd 48 c7 c7 60 c9 b0 8b 48 c7 c6 80 d5 b0 8b 31 d=
2 48 c7 c1 40 c6 b0 8b 41 b8 87 06 00 00 e8 f3 f8 33 fd 90 <0f> 0b f3 0f 1e=
 fa 65 8b 1d 59 4a 80 0e bf 07 00 00 00 89 de e8 19
> RSP: 0018:ffffc9000f2ff180 EFLAGS: 00010246
> RAX: 000000000000005c RBX: 0000000000000000 RCX: 6a0e5d27bc457900
> RDX: ffffc9000d29b000 RSI: 00000000000080c9 RDI: 00000000000080ca
> RBP: ffffc9000f2ff3c0 R08: ffffc9000f2feea7 R09: 1ffff92001e5fdd4
> R10: dffffc0000000000 R11: fffff52001e5fdd5 R12: ffff88814e273000
> R13: dffffc0000000000 R14: 00000000fffffffc R15: ffffc9000f2ff220
> FS:  00007f71682106c0(0000) GS:ffff888125ee2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffdaa1f0eb8 CR3: 0000000029df0000 CR4: 00000000003526f0
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

