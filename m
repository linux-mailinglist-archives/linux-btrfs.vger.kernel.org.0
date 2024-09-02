Return-Path: <linux-btrfs+bounces-7731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE622968489
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFB01C21A6D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83313D539;
	Mon,  2 Sep 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCf4vy/g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739813B284
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272599; cv=none; b=vB/ERWUpralZqzjpgaIg81JjVqoTMXLJ2LIgww1WogYHbRwJvX6JcNTPHcQTSR2Lnxj3EhWHS9g7qMMKcJB52n6Q/4wm6Fb/Qg9PHoPPn2yjwXGD+h3JDKjH57DLpJ07gOtG94uJXfUHV2r5K5U9SNbJkxeknOYOIuLdC2Dtqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272599; c=relaxed/simple;
	bh=nylZygN7c1hxcs97Q57IOZiTTRsJndCnfTNwz5SY13o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHZMku/aTPHMu6JjxHNfiivEJxH+m9pf8YU7oBmMo302GU6vFaUDlYc9evOwmiCW8mE/kuQl3vgHaeLSqubQcTYCbfnBpDN0RPwWNCkD05gytFnZ4c3ay9zoiLz1mbPBVyLELE+5G4wTOsbwTmqIdTnl0vksLlkwjZdiYQKpqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCf4vy/g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20230059241so31796145ad.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725272597; x=1725877397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1FHFO1Uf2HHK2ZwXhrKhsNjTlSKNNTYGI4AM0WO6Mk=;
        b=hCf4vy/gb7YgzsarYGK6NuTTTd/2g9BLSE97hIKTNXmWg+qZMepKjOH/eqBOqJkHgM
         oQOhLdI6IKV2xY3PpFoNVNlEtNyQ6lh3AMfVYbC9Pai8OXaFRAv1nOzNwLI19iXHfVKA
         203SS4ZSsMN5HeZde4ugHGzJnLkaFPhttm2Bk+yqT//Agl3O4nyl9IcEGlwl8GrIUkWv
         CG6cBZoTy4kM8NWtEqMVRR9tWlhW96p6Q6O+AWOROh+OJniOVsIGfSiQMD5X1gx8ECqd
         4WqPZ6mO5r7B3kJZmPvv3pzgUdtOf2UwhiDLuQ/fg7pRKb4aFdSHldy3ZbOGMJFDse0h
         NHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272597; x=1725877397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1FHFO1Uf2HHK2ZwXhrKhsNjTlSKNNTYGI4AM0WO6Mk=;
        b=pWGrpvsWmYGWJfeScOO4+2Ril28H37a/m2Toz+QVm1+NcVubIZrVvacwQq0NodlZ7u
         N3Npcl85dvwZ17sZv3uo6MfQhPl3ELAuz40fJbgXlyzfkFNa2iX/OsfAdJUnXPsXIjdg
         R6+WikHlE6zpDV5eY6+qERzr4IJqbrF3yj3nQcQDNC8LRDOKqKkX/nvBWaCBvA1t+xxx
         4t/FHu/KF8zVYb7wUK9Srph4vJIvbjmCl3PZkkRdQQf8O2AjxrsYnq9aK4YTrwNWhAJH
         kuUHfifNeum29EXuC4S9sL6EvbDWVUlRQtcD9fh0xl3COBaWxrGqIBo0GiHeJYe9a8Rt
         jSCw==
X-Forwarded-Encrypted: i=1; AJvYcCUQrZVEemUipAqiybDAzezoLTVzPr9cIuQ7KG0zIiu2lQ/Av9FpZeZ0IbNVCBSiSnzY2xZspybIflo7rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSB0805aRqBjIQ1aO8uk0+Wf58WiRZrP8Nhy/IIPYv/R7eyDsY
	Rsgoo+nJ9kVgrxkSc4wdrJBcOqd8sufgFktcfr1/0Gq1slO3aM6EmzEQgGzQISOI9q8mc6nXroM
	SYtGbMB1NzqBvC406sJ3gy3G/PbEEdINQj7eE
X-Google-Smtp-Source: AGHT+IHhQYK+RV8c/ZNd2hZwqQPhMZIfp0IoyKsMhoU6aF+N1If9wNjdIL6ERdohPAhzs4ryJ4AFUwo9MQjSJvA0rDA=
X-Received: by 2002:a17:902:ce8e:b0:1fb:75b6:a40b with SMTP id
 d9443c01a7336-2054bc90992mr57657495ad.2.1725272596491; Mon, 02 Sep 2024
 03:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e93ea70620fe777a@google.com> <aa2e3dba-9729-4b6b-94a5-36075d57ca7f@gmx.com>
In-Reply-To: <aa2e3dba-9729-4b6b-94a5-36075d57ca7f@gmx.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 2 Sep 2024 12:23:04 +0200
Message-ID: <CANp29Y5edqzjYyXEgeU8i9mrrfOkPBMWYd8yMnhrozePFuWhkA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (3)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: syzbot <syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 12:33=E2=80=AFAM 'Qu Wenruo' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/1 03:29, syzbot =E5=86=99=E9=81=93:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D109f1425980=
000
>
> I was checking the console and trying to find out what's before the
> transaction abort.
>
> The error number means it's ENOENT thus it seems to be a missing extent
> item or whatever.
>
> But the console output contains not even the WARNING line, is the
> console output trimmed or whatever?

Yes, that output log was indeed too big and was just trimmed to fit in
the limits :/
I'll take a look into how we can handle it better on the syzbot side.

In the meanwhile, there are a few other console logs on the dashboard
[1] that were not trimmed and that contain the WARNING line. E.g.
https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D174d4215980000

[1] https://syzkaller.appspot.com/bug?extid=3D480676efc0c3a76b5214

--=20
Aleksandr

>
> Thanks,
> Qu
>
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da0455552d0b=
27491
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D480676efc0c3a=
76b5214
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/87692913ef45/d=
isk-86987d84.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a27da6973d7f/vmli=
nux-86987d84.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2e28d02ce725=
/bzImage-86987d84.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > BTRFS: Transaction aborted (error -2)
> > WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 do_free_extent_a=
ccounting fs/btrfs/extent-tree.c:2972 [inline]
> > WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 __btrfs_free_ext=
ent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 63 Comm: kworker/u8:4 Not tainted 6.11.0-rc5-syzkall=
er-00057-g86987d84b968 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
> > Workqueue: events_unbound btrfs_async_reclaim_metadata_space
> > RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2972 [inline=
]
> > RIP: 0010:__btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
> > Code: e8 24 a4 ae fd 90 0f 0b 90 90 e9 3c f3 ff ff e8 35 80 ec fd 90 48=
 c7 c7 00 79 2b 8c 44 8b 6c 24 18 44 89 ee e8 00 a4 ae fd 90 <0f> 0b 90 90 =
4c 8b 24 24 e9 4f f3 ff ff e8 0d 80 ec fd 90 48 c7 c7
> > RSP: 0018:ffffc900015e6f80 EFLAGS: 00010246
> > RAX: ec2b4374561a8400 RBX: ffff88805d790001 RCX: ffff888015581e00
> > RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > RBP: ffffc900015e7150 R08: ffffffff8155b212 R09: fffffbfff1cba0e0
> > R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
> > R13: 00000000fffffffe R14: 0000000000000000 R15: ffff88805d3be5c8
> > FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f3dca9f0270 CR3: 000000002dd02000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   run_delayed_tree_ref fs/btrfs/extent-tree.c:1724 [inline]
> >   run_one_delayed_ref fs/btrfs/extent-tree.c:1750 [inline]
> >   btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2015 [inline]
> >   __btrfs_run_delayed_refs+0x112e/0x4680 fs/btrfs/extent-tree.c:2085
> >   btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2197
> >   btrfs_commit_transaction+0x4be/0x3740 fs/btrfs/transaction.c:2198
> >   flush_space+0x19c/0xd00 fs/btrfs/space-info.c:835
> >   btrfs_async_reclaim_metadata_space+0x6dc/0x840 fs/btrfs/space-info.c:=
1106
> >   process_one_work kernel/workqueue.c:3231 [inline]
> >   process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> >   worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
> >   kthread+0x2f0/0x390 kernel/kthread.c:389
> >   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >   </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
>

