Return-Path: <linux-btrfs+bounces-7428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F395C505
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 07:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA2C284CD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 05:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED655FEE6;
	Fri, 23 Aug 2024 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT7iIHnT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86D48CCC;
	Fri, 23 Aug 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392353; cv=none; b=WuvOyWGQPYMNxnCv0iUwY675KQAA38aVQFWtV6nyi2W5CwkOEkClJZiWi5IQq4wu41gQKsDt6ZXBGHFNKYlwV7S6BUbyJhOyceC2CdQwStZx+iQfgECqWlqP5t3W7mrGPRM0+6aVknAD4P21YxDuzbg1Jd9CreTYezW2Wnr9CPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392353; c=relaxed/simple;
	bh=ASPqAfpw4k1mn/rrFoOXiuJWKvumi8cPTp1F0MmXCEI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dgdz3izUTvI+Jfwc23sWARIzrJ3prDeUJraNrK2xzpbXlr5MCpLhvXew/vtcKUY75fMN2qg92rg7VnR209EYgBGYvEp7eAW6I4b3K9xFfnWFYqQ0flCqF+V25gVrAiGzHCjKLfeq0WpsDduQAukuIvN1MbnvsBXMOQXUOUSzpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT7iIHnT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201e52ca0caso12131265ad.3;
        Thu, 22 Aug 2024 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724392351; x=1724997151; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q5koNjYSJ5zUI7e6KhHzKXYjke1YQ/+V+8w801chQs=;
        b=WT7iIHnTN52vr6m+GB6HW8m0GFQTY+5Dcz65wshv9tDkib6TlgG+4dajPHSo88AgH1
         oXSb/6FfsC1VkpqdtU+IDDLedb65SuDl2pnJR7+wddFCXPQ+pRmiZm50zYK+/A7Vf3/n
         d6ale+PHP4ifvHsXEW8QGWHypDf7VgTUaJdUVEiWmIxZhXS+esoa9J7vcSfsVUhUqxh6
         vBppbTKjHowLiq7VS8tOTmMAhljKTql3F65TlqFytyOKxb5KKJAYwQe3jWmXtZZwoQzA
         4KEyONYe2jBBojziJETmX4oZVrL1cBUFcNu0tUZPKSU7pagXMKDFjRwY9sMF3Ya2/V3H
         rXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724392351; x=1724997151;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8q5koNjYSJ5zUI7e6KhHzKXYjke1YQ/+V+8w801chQs=;
        b=ljRqP/YX7ro0guKj7ypO3aSsTckSCPVKAUYu0f9KimPxWuZjSt4PO7/o3A+XsVzhzr
         i2rO3MMSXPGqhc2m69kli8ma0cfC+vyqub/Yq31SJWdxI6LRIVRjFaXEw4x4JwfWEULS
         XF94PbMlRcpa1eHqBtcq0iYU/sdXHKWrusgMoiV/xfFGEmBcApc1XR4yFfGxWRd2PwXf
         RXUX4nCfMOZ6Iew3pEUw1hijA8UwXO1PcuA8uEwTFo1NYrZxTbVQgqaqn44A0ahgPELn
         uiO1KVVTVYqSNRX1kIn0dZgDq4Q3I/vdCY6WsVZNw6Di+rOmLojZz81bbxEd3tx6YruQ
         u8+g==
X-Forwarded-Encrypted: i=1; AJvYcCXNbpA8ojPabSud63dD6Pr6A4f1rYGW+MN/3pQgbg6ja5kWyRK3cd6fum9moJn363fxHXkTO1TQF8vbOA==@vger.kernel.org, AJvYcCXotYCJ4Xa2yXNwqj4sGVSE1OlnT3CZYfr7qlRPndZTpIOM2QpJfj4hknDiW4jqaxhp+o6D9wBdomuksglo@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVSzh7HubayQGzKtz+eWarf/bgBmfO9pLswIK/F7WOwzCaHH/
	Ew7kNWOTD1ir3Fm3eiC0C6KX5bqhRxYv62ujVrnxGQKeEB2oAzgmIn+ZQfpsPHI7eA==
X-Google-Smtp-Source: AGHT+IGI6szQZcFiceXhH05DRWeoxBbP+W2Eza4ZlfeIOuNk6ZscgRhPqfUMDqjTvvLJOG1xGLRwhQ==
X-Received: by 2002:a17:902:e5cb:b0:202:2cd5:2095 with SMTP id d9443c01a7336-2039e46caecmr10256885ad.18.1724392350707;
        Thu, 22 Aug 2024 22:52:30 -0700 (PDT)
Received: from [127.0.0.1] ([174.139.202.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556655dsm21415295ad.20.2024.08.22.22.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 22:52:30 -0700 (PDT)
Message-ID: <d6c8db71ce8d64d93c21811a0b7490cfc1abf16f.camel@gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Date: Fri, 23 Aug 2024 13:52:25 +0800
In-Reply-To: <00000000000097e583061a45bfcf@google.com>
References: <00000000000097e583061a45bfcf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 22:05 -0700, syzbot wrote:

#syz test: upstream d30d0e49da71

diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..011f630777d0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -723,6 +723,10 @@ void evict_inodes(struct super_block *sb)
                        continue;
=20
                spin_lock(&inode->i_lock);
+               if (atomic_read(&inode->i_count)) {
+                       spin_unlock(&inode->i_lock);
+                       continue;
+               }
                if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))
{
                        spin_unlock(&inode->i_lock);
                        continue;


> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 d30d0e49da71 Merge tag 'net-6.10-rc3' of
> git://git.kernel...
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D1736820a980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D399230c250e8119c
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D67ba3c42bcbb4665d3ad
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gcc (Debian 12.2.0-14) 12.2=
.0, GNU ld (GNU Binutils
> for Debian) 2.40
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D11a9aa22980000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D14c57f16980000
>=20
> Downloadable assets:
> disk image (non-bootable):
> https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_di=
sk-d30d0e49.raw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/f1276023ed77/vmlinux-d30d0e4=
9.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/a33f372d4fb8/bzImage-d30d0e4=
9.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/7fc863ff127d/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
>=20
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:626!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 5273 Comm: syz-executor331 Not tainted 6.10.0-rc2-
> syzkaller-00222-gd30d0e49da71 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-
> debian-1.16.2-1 04/01/2014
> RIP: 0010:clear_inode+0x15b/0x190 fs/inode.c:626
> Code: 00 00 00 5b 5d 41 5c c3 cc cc cc cc e8 5e c1 8c ff 90 0f 0b e8
> 56 c1 8c ff 90 0f 0b e8 4e c1 8c ff 90 0f 0b e8 46 c1 8c ff 90 <0f>
> 0b e8 3e c1 8c ff 90 0f 0b e8 e6 92 e8 ff e9 d2 fe ff ff e8 dc
> RSP: 0018:ffffc900036f7ac0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888030369e90 RCX: ffffffff82012340
> RDX: ffff888024190000 RSI: ffffffff820123aa RDI: 0000000000000007
> RBP: 0000000000000040 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000020
> R13: ffff88802f942000 R14: 0000000000000000 R15: ffff888030369e90
> FS:=C2=A0 000055556268d380(0000) GS:ffff88806b100000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555562697708 CR3: 000000001e888000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> =C2=A0<TASK>
> =C2=A0btrfs_evict_inode+0x529/0xe80 fs/btrfs/inode.c:5262
> =C2=A0evict+0x2ed/0x6c0 fs/inode.c:667
> =C2=A0dispose_list+0x117/0x1e0 fs/inode.c:700
> =C2=A0evict_inodes+0x34e/0x450 fs/inode.c:750
> =C2=A0generic_shutdown_super+0xb5/0x3d0 fs/super.c:627
> =C2=A0kill_anon_super+0x3a/0x60 fs/super.c:1226
> =C2=A0btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
> =C2=A0deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
> =C2=A0deactivate_super+0xde/0x100 fs/super.c:506
> =C2=A0cleanup_mnt+0x222/0x450 fs/namespace.c:1267
> =C2=A0task_work_run+0x14e/0x250 kernel/task_work.c:180
> =C2=A0resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> =C2=A0exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> =C2=A0exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> =C2=A0__syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> =C2=A0syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
> =C2=A0do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2ba3059777
> Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66
> 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48>
> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
> RSP: 002b:00007fff42f9ee78 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f2ba3059777
> RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff42f9ef30
> RBP: 00007fff42f9ef30 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000206 R12: 00007fff42f9ffa0
> R13: 000055556268f6d0 R14: 431bde82d7b634db R15: 00007fff42f9ffc0
> =C2=A0</TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:clear_inode+0x15b/0x190 fs/inode.c:626
> Code: 00 00 00 5b 5d 41 5c c3 cc cc cc cc e8 5e c1 8c ff 90 0f 0b e8
> 56 c1 8c ff 90 0f 0b e8 4e c1 8c ff 90 0f 0b e8 46 c1 8c ff 90 <0f>
> 0b e8 3e c1 8c ff 90 0f 0b e8 e6 92 e8 ff e9 d2 fe ff ff e8 dc
> RSP: 0018:ffffc900036f7ac0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888030369e90 RCX: ffffffff82012340
> RDX: ffff888024190000 RSI: ffffffff820123aa RDI: 0000000000000007
> RBP: 0000000000000040 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000020
> R13: ffff88802f942000 R14: 0000000000000000 R15: ffff888030369e90
> FS:=C2=A0 000055556268d380(0000) GS:ffff88806b100000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555562697708 CR3: 000000001e888000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>=20
>=20
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before
> testing.

--=20
Julian Sun <sunjunchao2870@gmail.com>

