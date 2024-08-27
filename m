Return-Path: <linux-btrfs+bounces-7547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E696060F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DADE1C2240E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262661A01DA;
	Tue, 27 Aug 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npe9Ryil"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C919D8A2;
	Tue, 27 Aug 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751773; cv=none; b=QYk4Wg+LGVKZ+585RydFG4x2gB0cIoGHlaPxHJ0jf+tZFvCaKUlrr4Gc1eLaqQod1atNhNcbACMHr8zIkG8Xumaj7rVtI+cAhLr3XiqdWRPeorpgcCPMdMMfovX0Q6N9A0moeMo06L/xfPhMcES0T2B7kyQvsBRcZLdaLbljDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751773; c=relaxed/simple;
	bh=9Vh+/kkN/kF6bdSbAdTVGytqEz8xw37S4L54KoUT2rI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APZvvm9kJyR1hIyuppYcTM+NonFyt6iDn2lofCCMGRXSMoWyP72ItJs2uQ8VP+S3px3hnOrAKRnvnxjlyDHKOJCMRrYZszMBZcvwUEZLRr0Y/uXb9dOeX79MaVjWqdVH4khSaNWq4D5pLviiNj3z34H75WaW22hl1fTOlkq3ZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npe9Ryil; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093ba310b0so3129947a34.2;
        Tue, 27 Aug 2024 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724751771; x=1725356571; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vh+/kkN/kF6bdSbAdTVGytqEz8xw37S4L54KoUT2rI=;
        b=npe9Ryil+oAinDxrsPrQITC2G6CyICeP8uRMgxRTO7BUUaBie+rqwhi1P6cvYJY0Zm
         ZlyEHWak2dk3/Ry4iSnHxEMbbD8+xdM4Q8hmb7D3dpH8ZJgsfOCiMntxnqsOg7vbFeLp
         u4zG+x0hBFFH9GjGWt/X2yZzvmZUwWKwy7g7x98Zr6w/Y2igUHp27AVcRQoXdtx61HEC
         XMbCOoLETlW2hWn4kGtIxygCK3/SiPw3JScIA2z1R4SlE0RQjF6fscHNkrd9fe1X8Duh
         nYfKZIesj+qYWRtvXDtabe+Pd3pnQYzpepcXf7d6xMCfsWeOmB6swlfuxbUTrXrrAnGn
         0wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724751771; x=1725356571;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Vh+/kkN/kF6bdSbAdTVGytqEz8xw37S4L54KoUT2rI=;
        b=MN92ocbNbx/PFqaMvMM6KTv6jDSj7DG3y3an0wEJp8fzSAv6fMcJPm+ElEwgz49Z4F
         Gys5zQ+GNfVD8dyijWyDZATjgUFHFdPmwN4twDdPNyLyPz9GBK/Vtk022dtWAPbPuE44
         1K/2bhCTHXXuGCCqI/i4D0UipBJ1nD0HH8Ev8pQLy5EWFTjA6I5MK6wgdy0PhUiOZvRV
         oF6H7ShuXcshHHXo11hwmGSgxa8OemBCmnKyBT7V26gyW6yADaLk/2SM2Rr72gnxeovv
         FYppw8Vil9eqDwKHo9V6kmLIiidRHgn0nrox7So8RZachGxT2dFyJ/SFcJqeJZj96D/x
         S42w==
X-Forwarded-Encrypted: i=1; AJvYcCVZnovRBuIxM5+zyWSfagYf7Oy0mn6YcK2qt52KM+Je7on8HiC8RqdcX2+9WIkR9oUejfNCc2KmfilBRg==@vger.kernel.org, AJvYcCXt38YaRxmU3uTwQIZgKBoYQRm2YKfbiEQJ7OqiaZh2YMyvMEqYUza2CTgWyJVngH8++cw97Wpm/S5C+ru/@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnJKTYdRp2AdwJxkpxoRr4IjiojxbtcsF1tsu4En+SpqA080H
	jVdFTZmtokwpLyHP+vQS6iqnH/Yqf3pR7gMYw/4Uhcf6yd4YVY34
X-Google-Smtp-Source: AGHT+IFKqbtifrDFrWjEDH4eJ39U/2LefoMSkQz/GfI+WJhm4raLscZYR+WK1i2RsIZjoQesEZtZ/A==
X-Received: by 2002:a05:6808:2e9b:b0:3d9:27fc:158f with SMTP id 5614622812f47-3def3f65f91mr2409843b6e.29.1724751770592;
        Tue, 27 Aug 2024 02:42:50 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb54asm8972313a12.42.2024.08.27.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:42:49 -0700 (PDT)
Message-ID: <b65a238dd9852158d381156aa6db92c0ef09562e.camel@gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_run_defrag_inodes (2)
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot <syzbot+5833b186650f87c5b7c4@syzkaller.appspotmail.com>, 
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Tue, 27 Aug 2024 17:42:46 +0800
In-Reply-To: <0000000000009e7183061ee0a25f@google.com>
References: <0000000000009e7183061ee0a25f@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-04 at 12:33 -0700, syzbot wrote:

#syz dup: kernel BUG in clear_inode

As mentioned in fix[1], there are two threads simultaneously evicting
the same inode, which may trigger the BUG(inode->i_state & I_CLEAR)
statement both within clear_inode() and iput().
So this report specifically triggered the BUG(inode->i_state & I_CLEAR)
statement in iput(). And I did encounter this issue when I attempted to
reproduce and fix it.

[1]:https://lore.kernel.org/linux-btrfs/20240823130730.658881-1-sunjunchao2=
870@gmail.com/

> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 e4fc196f5ba3 Merge tag 'for-6.11-rc1-tag' =
of
> git://git.ker..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D133acef9980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D8b0cca2f3880513d
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D5833b186650f87c5b7c4
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0.6=
, GNU ld (GNU Binutils for
> Debian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/c4bed4c74b59/disk-e4fc196f.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/f90c5ef25b80/vmlinux-e4fc196=
f.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/3a4dad9a7e8e/bzImage-e4fc196=
f.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+5833b186650f87c5b7c4@syzkaller.appspotmail.com
>=20
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:1819!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 10710 Comm: btrfs-cleaner Not tainted 6.11.0-rc1-
> syzkaller-00062-ge4fc196f5ba3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 06/27/2024
> RIP: 0010:iput+0x928/0x930 fs/inode.c:1819
> Code: ff e9 a7 fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 45 fe
> ff ff 4c 89 f7 e8 33 aa e7 ff e9 38 fe ff ff e8 29 71 80 ff 90 <0f>
> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900041ffc50 EFLAGS: 00010293
> RAX: ffffffff8212f547 RBX: 0000000000000040 RCX: ffff888023d05a00
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
> RBP: ffff88805e4f48e0 R08: ffffffff8212ec80 R09: 1ffffffff202f495
> R10: dffffc0000000000 R11: fffffbfff202f496 R12: ffff88805e4f49b0
> R13: ffff88806c102028 R14: 0000000000000005 R15: ffff888068e60350
> FS:=C2=A0 0000000000000000(0000) GS:ffff8880b9300000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1c9b094108 CR3: 000000005d542000 CR4: 0000000000350ef0
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__btrfs_run_defrag_inode fs/btrfs/defrag.c:281 [inline]
> =C2=A0btrfs_run_defrag_inodes+0xa80/0xdf0 fs/btrfs/defrag.c:327
> =C2=A0cleaner_kthread+0x28c/0x3d0 fs/btrfs/disk-io.c:1527
> =C2=A0kthread+0x2f2/0x390 kernel/kthread.c:389
> =C2=A0ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =C2=A0</TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:iput+0x928/0x930 fs/inode.c:1819
> Code: ff e9 a7 fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 45 fe
> ff ff 4c 89 f7 e8 33 aa e7 ff e9 38 fe ff ff e8 29 71 80 ff 90 <0f>
> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900041ffc50 EFLAGS: 00010293
> RAX: ffffffff8212f547 RBX: 0000000000000040 RCX: ffff888023d05a00
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
> RBP: ffff88805e4f48e0 R08: ffffffff8212ec80 R09: 1ffffffff202f495
> R10: dffffc0000000000 R11: fffffbfff202f496 R12: ffff88805e4f49b0
> R13: ffff88806c102028 R14: 0000000000000005 R15: ffff888068e60350
> FS:=C2=A0 0000000000000000(0000) GS:ffff8880b9300000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1c9b094108 CR3: 000000006b99e000 CR4: 0000000000350ef0
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

