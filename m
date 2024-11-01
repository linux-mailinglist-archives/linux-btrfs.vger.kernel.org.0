Return-Path: <linux-btrfs+bounces-9274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA49B8992
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 04:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E7C1F22816
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 03:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C913E02E;
	Fri,  1 Nov 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTK3caCy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE813D62B;
	Fri,  1 Nov 2024 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430336; cv=none; b=s67G1AWs9xR6Zmap4xAJMv1wA35MfKQIfcm5bdfQN10A6Yq9DBlVYVzv2JHGvGbCIA0gAW8uSDVC4M4qBtrkVkg0rDsYaprWUrdVKngOlr5agSj/6iJpd6VT4BQLJuAglooGsJ3UBQxDe9QQa2M1mZrjiL5tNPy3agED5IMlIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430336; c=relaxed/simple;
	bh=UMAjIFTxb038mRY/DOqBjPt1qf2e7jUa6X6VeHt6sPM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G//sxyFrUCHy77V4pFyTBnLQEw8hOMaiVmkN5XZsu48Z87Ekz1JMW+vCesvxGNQGgXNB0A/Q7xaFYkwztwBVGUKUqPYy9wXK9jMxn7XbidPIpv1A+C4a0wCPlDSg7iFSysVfPqfd/SxXJGTDXSirE6oMiQ5DhDiihjGuGqG1VTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTK3caCy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720be27db27so1069304b3a.2;
        Thu, 31 Oct 2024 20:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730430333; x=1731035133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMAjIFTxb038mRY/DOqBjPt1qf2e7jUa6X6VeHt6sPM=;
        b=VTK3caCycAttP1VNvf731UWf6CBEZL6WCOM+ig73VDKxSekwuO5AHiuGmcW7y/Wa/r
         uL5Ihg/22pub62tpffNAm9Dwz/tT94yeoMzJljpbrG4DhqXQJoPvSOkzndUSDQlAb406
         oGmTFC7CTbpM+OQ4ds4h3b7qAmS/XTtyKiVi7VxB4PVc8bCFxpQ32uizG1nkwv54h/St
         ZrpOl8lKuUhllCOD76ym14DDneAEkRCc0ep6gOFea3Rl6MByx8Qsex3LnN0D0dCydkmx
         KkMqTgxGUiHFTSe5fxRzoLIr5b832Kz5Akqn4YvmsvvUVoIs6hX8oUYpLUJ2nd+uU2x1
         xAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730430333; x=1731035133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMAjIFTxb038mRY/DOqBjPt1qf2e7jUa6X6VeHt6sPM=;
        b=D83geIsRZrKl3XKLclhf9LOF0OXjgUOX3jjKjKL+0VtG+0aJDU5Qkz3eFqbbYnLsfp
         x14nI7P0t1zRzO2Oowp15Afu91jZvbqlsNovcf1Ro9XzRBjQj7tyIXYN7WeqVDweExHZ
         fi0Y1fh0AjiD4GbwuBk8ib3F7NRy9ZunZdFMjXsBqSwiJPMSjRmxeM01Q9E7kL34ljT7
         6+2I76D73BnwpLkvWJPjhdo3qxsycR8p898wQ3pWKh9Jz6/8vOsc4AahdtwU0t6e9uPp
         tirhER4AmiwZnv4HyYr/EF4iKzpgWGCFpX0prdcDl+NqKXnp5JhMMv2g4ljTYJFZCLZ0
         JCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUKpazSRCSADMWytE5beEQ2B8+VFX9SsniZnLqe9zeFzFAElSaKgKrU6rKxSiVjERaIIgTF6j7bUuhcXw==@vger.kernel.org, AJvYcCUfYAIfHQtd75LHt/KwfQjjHLoUacDRfiv6w6K/KyMX04LJHAxjPqNAUYwJnjnv1K3p/N2FLCn8DgGpd6sD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49uW++3Ldul0z2sbQvGSJbb2UnGiPHoqGI2Z4pGyprKF+TO9X
	VrcivyS3IYcSpUVQqQmXsiC9bJlud+NhmoXoAWJeV4E4m0vqV98N
X-Google-Smtp-Source: AGHT+IFGf6NYKVxemBxfuuMetCcyT8rki2cc+r2rMYoUQlJBeAPgLKLH7yEdLxXuciXLDjEtwEZIBw==
X-Received: by 2002:a05:6a21:1643:b0:1d9:18b7:48c with SMTP id adf61e73a8af0-1d9eeb06596mr11826772637.6.1730430333264;
        Thu, 31 Oct 2024 20:05:33 -0700 (PDT)
Received: from [10.172.23.36] ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45299f00sm1408292a12.8.2024.10.31.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:05:32 -0700 (PDT)
Message-ID: <dc7a742f3b2a4162f5f0a1f45a20c1fb76ce8eaa.camel@gmail.com>
Subject: Re: [syzbot] kernel BUG in close_ctree
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>, 
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Fri, 01 Nov 2024 11:05:29 +0800
In-Reply-To: <000000000000aeaf5a05ee4e96d7@google.com>
References: <000000000000aeaf5a05ee4e96d7@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2022-11-25 at 09:09 -0800, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> >=20
> > HEAD commit:=C2=A0=C2=A0=C2=A0 c3eb11fbb826 Merge tag 'pci-v6.1-fixes-3=
' of
> > git://git.ker..
> > git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> > console+strace:
> > https://syzkaller.appspot.com/x/log.txt?x=3D115013c5880000
> > kernel config:=C2=A0=20
> > https://syzkaller.appspot.com/x/.config?x=3D8d01b6e3197974dd
> > dashboard link:=20
> > https://syzkaller.appspot.com/bug?extid=3D2665d678fffcc4608e18
> > compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version
> > 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld
> > (GNU Binutils for Debian) 2.35.2
> > syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > https://syzkaller.appspot.com/x/repro.syz?x=3D1360d8e3880000
> > C reproducer:=C2=A0=C2=A0
> > https://syzkaller.appspot.com/x/repro.c?x=3D175f0d53880000
> >=20
> > Downloadable assets:
> > disk image:=20
> > https://storage.googleapis.com/syzbot-assets/d81ac029767f/disk-c3eb11fb=
.raw.xz
> > vmlinux:=20
> > https://storage.googleapis.com/syzbot-assets/b68346b5b73c/vmlinux-c3eb1=
1fb.xz
> > kernel image:=20
> > https://storage.googleapis.com/syzbot-assets/410a61724587/bzImage-c3eb1=
1fb.xz
> > mounted in repro:=20
> > https://storage.googleapis.com/syzbot-assets/f5bd1887114f/mount_0.gz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com
> >=20
> > assertion failed: list_empty(&fs_info->delayed_iputs), in
> > fs/btrfs/disk-io.c:4664
> > ------------[ cut here ]------------
> > kernel BUG at fs/btrfs/ctree.h:3713!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 3632 Comm: syz-executor235 Not tainted
> > 6.1.0-rc6-syzkaller-00015-gc3eb11fbb826 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 10/26/2022
> > RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3713
> > Code: 48 c7 c2 80 aa 38 8b 31 c0 e8 ef e3 ff ff 0f 0b 89 f1 48 89 fe 48
> > c7 c7 60 d9 38 8b 48 c7 c2 50 0a 39 8b 31 c0 e8 d3 e3 ff ff <0f> 0b 55
> > 48
> > 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec
> > RSP: 0018:ffffc90003d7fa58 EFLAGS: 00010246
> > RAX: 0000000000000051 RBX: ffff88807c960d58 RCX: 83509907ab950400
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffc90003d7fbe8 R08: ffffffff816e568d R09: fffff520007aff05
> > R10: fffff520007aff05 R11: 1ffff920007aff04 R12: 0000000000000000
> > R13: ffff88807c960000 R14: dffffc0000000000 R15: dffffc0000000000
> > FS:=C2=A0 00005555573a6300(0000) GS:ffff8880b9900000(0000)
> > knlGS:0000000000000000
> > CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffcab996e28 CR3: 0000000078318000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> > =C2=A0<TASK>
> > =C2=A0close_ctree+0x818/0xbde fs/btrfs/disk-io.c:4664
> > =C2=A0generic_shutdown_super+0x130/0x310 fs/super.c:492
> > =C2=A0kill_anon_super+0x36/0x60 fs/super.c:1086
> > =C2=A0btrfs_kill_super+0x3d/0x50 fs/btrfs/super.c:2441
> > =C2=A0deactivate_locked_super+0xa7/0xf0 fs/super.c:332
> > =C2=A0cleanup_mnt+0x494/0x520 fs/namespace.c:1186
> > =C2=A0task_work_run+0x243/0x300 kernel/task_work.c:179
> > =C2=A0ptrace_notify+0x29a/0x340 kernel/signal.c:2354
> > =C2=A0ptrace_report_syscall include/linux/ptrace.h:420 [inline]
> > =C2=A0ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
> > =C2=A0syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:251
> > =C2=A0syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c=
:278
> > =C2=A0__syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inlin=
e]
> > =C2=A0syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:296
> > =C2=A0do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
> > =C2=A0entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fd3e400af67
> > Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 b8 ff ff ff f7 d8 64
> > 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01
> > f0
> > ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffcab997568 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fd3e400af67
> > RDX: 00007ffcab99762a RSI: 000000000000000a RDI: 00007ffcab997620
> > RBP: 00007ffcab997620 R08: 00000000ffffffff R09: 00007ffcab997400
> > R10: 00005555573a7653 R11: 0000000000000202 R12: 00007ffcab9986e0
> > R13: 00005555573a75f0 R14: 00007ffcab997590 R15: 00007ffcab998700
> > =C2=A0</TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:assertfail+0x1a/0x1c fs/btrfs/ctree.h:3713
> > Code: 48 c7 c2 80 aa 38 8b 31 c0 e8 ef e3 ff ff 0f 0b 89 f1 48 89 fe 48
> > c7 c7 60 d9 38 8b 48 c7 c2 50 0a 39 8b 31 c0 e8 d3 e3 ff ff <0f> 0b 55
> > 48
> > 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec
> > RSP: 0018:ffffc90003d7fa58 EFLAGS: 00010246
> > RAX: 0000000000000051 RBX: ffff88807c960d58 RCX: 83509907ab950400
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffc90003d7fbe8 R08: ffffffff816e568d R09: fffff520007aff05
> > R10: fffff520007aff05 R11: 1ffff920007aff04 R12: 0000000000000000
> > R13: ffff88807c960000 R14: dffffc0000000000 R15: dffffc0000000000
> > FS:=C2=A0 00005555573a6300(0000) GS:ffff8880b9800000(0000)
> > knlGS:0000000000000000
> > CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fd3e405ad48 CR3: 0000000078318000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >=20

#syz test: upstream

--=20
Julian Sun <sunjunchao2870@gmail.com>

--=20
Julian Sun <sunjunchao2870@gmail.com>

