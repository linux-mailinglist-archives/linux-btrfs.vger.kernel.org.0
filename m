Return-Path: <linux-btrfs+bounces-15100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7BAEDD49
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321393BDD68
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42D28C002;
	Mon, 30 Jun 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/7hdmgh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD13284670;
	Mon, 30 Jun 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287257; cv=none; b=Rv43T6+eJPx8nLB73Or5p3xlaEV5RNgNVOWS1r8oaEfMA5SUUEVk9fL8mOrTOU4E9URWkqv9y1r+7tFdNcSG8SU0+hwnqwIkL3eZ3jAVY6U7dEpGqUDDGroK2oRcJuWROgFp8bwIXkmho1vsFvGUCrYPrBK54uj0QplllFIRoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287257; c=relaxed/simple;
	bh=wkItz+IDta9Ggr4JWRzZchtWveU3uqAvPMlQwPMBnjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCmyLXmgtlwlHS83gjIYdTK+qvQsIHNTzeN+lnKlh10dwZqE4+beaVYCva7ozkIxS1zTsi2WfKDhNij539tTzDsz/FGQ6nnqQJSYWOwUt5jIiBxqqELuLSO6wvQmZc5te43Q7PVJs8l+1ep9z9WbKZzRVI0D5gT6UhmdF2oz74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/7hdmgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F059C4CEF1;
	Mon, 30 Jun 2025 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287256;
	bh=wkItz+IDta9Ggr4JWRzZchtWveU3uqAvPMlQwPMBnjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R/7hdmghO+MWQcuFfeX6lvJAOaqfN02IIxF3rLQ8XBw4hVg6YICqbSQDVHXAuSjMl
	 S8ED3eZhl4oy6OBnFEF0+fyiuM8ZCGxC0Xm5zhy/NGf6cs4WJR8mtnkota5jgELhuR
	 TSzPZAhTJboRFRMxePco6Salo1me3eFOxXETnkDdZzB4LfSZHFsXdZMYytpHL3zbR/
	 Ei7vBkBx17O6qEf/P0rNGyk0x+zox/W7cw5oE9sla3Mlchtav8GoVZtZjdAuHZNPRb
	 0w2pqIe8RKIX1njmwyY0nnkXCG17L7s4j+b9yGMLTjii2Ze7sstAdNOh4rS9Yq9EP0
	 ZYJZ6Pm2xprvg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0c571f137so883154466b.0;
        Mon, 30 Jun 2025 05:40:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsaDY75UFHdpGVlLTPSLvDd4ocE6Sjdtg458CxMuWXBnTNYqVn6zfu5opa//S0WYMtgL9GQ7qDwRAI+A==@vger.kernel.org, AJvYcCXMDd8YVu4X9OChmQFPSpLYYhoyrIZ2Ykajjq8g69zj3w1DDGdoWZr4nZEhp5CcM2fnHg3AAPbRPWnpBomq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ijTnnmjsqBLUAk56D3b3KYwrqmROdd/RPF+XDEK4UxNo9DnM
	ScjvCYHz1nVG03GD4vgh2KVrsS3C6a6WriJ5NlxUfOUmb9my1H4V8Ih5hpH/ZN0BDEEMaup2lfi
	FVmDV6/0NBvYpCqCPrzG6dpy7dr13T5M=
X-Google-Smtp-Source: AGHT+IFBewGjwb9nMDc7R6lPRR+7PqLOhoGg836V3tRiy9Ldsvpf9vcAAKn7Qhu/MP69ockbLsNeA2iNS4VNmjH+zhY=
X-Received: by 2002:a17:907:3c8f:b0:ad5:5b2e:655b with SMTP id
 a640c23a62f3a-ae34fddf6e9mr1465229866b.25.1751287254771; Mon, 30 Jun 2025
 05:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com>
 <CAL3q7H6p1M5iCgV9RZ=ioSGOf5mrZF-rL_gocPB4hhtoU8Ugbw@mail.gmail.com> <CAFRLqsXdo9YMYS_drZkaBSzeBSPWfAF_3JNr=ng__8SBNe9cyA@mail.gmail.com>
In-Reply-To: <CAFRLqsXdo9YMYS_drZkaBSzeBSPWfAF_3JNr=ng__8SBNe9cyA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 30 Jun 2025 13:40:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Q0aG3tWrHCM0VxHHDFxbTO14tmMUz9xN_ZhyG=-K2+A@mail.gmail.com>
X-Gm-Features: Ac12FXxctAcEISuWGzzhyrLkqiL-Xu84HpOu03J6eG6P6OxhkK7My4jBjj8ESxw
Message-ID: <CAL3q7H6Q0aG3tWrHCM0VxHHDFxbTO14tmMUz9xN_ZhyG=-K2+A@mail.gmail.com>
Subject: Re: [BUG] btrfs: Data race between btrfs_quota_disable and
 btrfs_qgroup_rescan leads to a UAF
To: cen zhang <zzzccc427@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 11:50=E2=80=AFPM cen zhang <zzzccc427@gmail.com> wr=
ote:
>
> Hello Btrfs maintainers,
>
> Thank you for your detailed response to our previous report again. We
> have carefully studied the two synchronization mechanisms you
> mentioned and fully understand their design intent.
>
> After a more in-depth analysis, we have confirmed a specific timing
> window where both of these synchronization mechanisms can be bypassed,
> leading to a Use-After-Free (UAF) issue. This email aims to elaborate
> on this scenario and explain why we believe it is a race condition
> that needs to be fixed.
>
> The core of the problem is that there is a data race between
> qgroup_rescan_zero_tracking(), called during the preparation phase of
> the btrfs_qgroup_rescan function, and btrfs_free_qgroup_config(),
> called by btrfs_quota_disable. The two key synchronization mechanisms
> fail to cover this specific conflict point.
>
> We try to explain why the tow synchronization mechanisms will fail:
>
>  You mentioned that btrfs_quota_disable first clears the
> BTRFS_FS_QUOTA_ENABLED flag and then calls
> btrfs_qgroup_wait_for_completion to wait for the rescan worker to
> stop. This is intended to ensure a graceful shutdown.But the
> effectiveness of this mechanism relies on
> btrfs_qgroup_wait_for_completion correctly determining if a rescan
> task is running. The function checks the
> fs_info->qgroup_rescan_running flag to do this. However, in the
> btrfs_qgroup_rescan function, the qgroup_rescan_running flag is set to
> true only after all preparation work (including the call to
> qgroup_rescan_zero_tracking) is complete. This creates a window where
> a rescan task has started its setup but is not yet marked as
> "running." If btrfs_quota_disable executes during this window, it will
> see qgroup_rescan_running as false, incorrectly skip the wait, and
> proceed directly to the cleanup process.
>
> And regarding the second synchronization mechanism you proposed, you
> mentioned that btrfs_quota_disable acquires a transaction handle
> before calling btrfs_free_qgroup_config. Since the background rescan
> worker also needs to commit transactions, the inherent mutual
> exclusion of the transaction system should block the worker, thus
> preventing concurrent modifications.But this mechanism protects
> operations that require a Btrfs transaction. However, the problematic
> function, qgroup_rescan_zero_tracking, is a memory-only operation. It
> traverses and modifies the in-memory qgroup red-black tree, a process
> that does not require or hold a Btrfs transaction handle. In the
> execution flow of btrfs_qgroup_rescan, it first completes a
> btrfs_commit_current_transaction, at which point it no longer holds a
> transaction handle. It then calls qgroup_rescan_zero_tracking.
> Therefore, even if btrfs_quota_disable holds a transaction handle, it
> cannot block the execution of qgroup_rescan_zero_tracking, as the
> latter does not compete for the transaction lock.

In the other thread you mentioned something different, a race about
the rescan worker and not the rescan ioctl:

https://lore.kernel.org/linux-btrfs/CAFRLqsXQMknPBgYkds=3DARWFC0vj1xAP77USG=
+ZG5GH3rbqB5xQ@mail.gmail.com/

That is, one of the stack traces:

Workqueue: btrfs-qgroup-rescan btrfs_work_helper
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:218 [inline]
RIP: 0010:list_del_init include/linux/list.h:287 [inline]
RIP: 0010:btrfs_run_qgroups+0x4a8/0x1ec0 fs/btrfs/qgroup.c:3132
Code: 89 df e8 0b 30 23 ff 4c 8b 3b 4d 8d 67 08 4c 89 e3 48 c1 eb 03
48 b9 00 00 00 00 00 fc ff df 4c 8d 34 0b 4c 89 f0 48 c1 e8 03 <0f> b6
04 08 84 c0 0f 85 0c 0f 00 00 41 80 3e 00 74 22 e8 91 82 f1
RSP: 0018:ffff888119bcf388 EFLAGS: 00010212
RAX: 1f7ab38000000004 RBX: 1bd5a00000000021 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88813e2c2488
RBP: 1ffff11027c58491 R08: ffff888119bcf347 R09: 1ffff11023379e68
R10: dffffc0000000000 R11: ffffed1023379e69 R12: dead000000000108
R13: ffff88813c4409c0 R14: fbd59c0000000021 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8883fbf1b000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4485380c0 CR3: 0000000166ff6000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 commit_cowonly_roots+0x67c/0x1c10 fs/btrfs/transaction.c:1354
 btrfs_commit_transaction+0x2a5b/0xc800 fs/btrfs/transaction.c:2457
 btrfs_qgroup_rescan_worker+0xa23/0x4220 fs/btrfs/qgroup.c:3852
 btrfs_work_helper+0x7ea/0x2a80 fs/btrfs/async-thread.c:312
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0x720/0xf10 kernel/workqueue.c:3321
 worker_thread+0xb66/0x11a0 kernel/workqueue.c:3402
 kthread+0x351/0x780 kernel/kthread.c:464
 ret_from_fork+0x10e/0x1c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

For that the transaction semantics prevent such a thing.

>
> Detailed Execution Trace Triggering the UAF
>
> Consider the precise steps showing how the two threads can interleave
> to trigger the UAF:
>
> TID 1 (Rescan Thread): Executes btrfs quota rescan, entering
> btrfs_qgroup_rescan(). After successfully executing
> btrfs_commit_current_transaction() but before calling
> qgroup_rescan_zero_tracking(), it gets preempted by the OS or delay by
> our tools.And now qgroup_rescan_running is still false. TID 1 does not
> hold a transaction handle.
>
> TID 2 (Disable Thread): Executes btrfs quota disable, entering
> btrfs_quota_disable().
>
> It calls btrfs_qgroup_wait_for_completion(). Since
> qgroup_rescan_running is false, the wait is skipped.
> It successfully starts a new transaction (btrfs_start_transaction).
> It calls btrfs_free_qgroup_config(). This function, without taking a
> lock, loops through calls to rb_erase and kfree, freeing all nodes and
> memory of the qgroup red-black tree.
>
> TID 1 (Rescan Thread): Resumes execution.
> It calls qgroup_rescan_zero_tracking().
> Inside this function, the for (n =3D rb_first(&fs_info->qgroup_tree);
> ...) attempts to access the memory just freed by TID 2. rb_first
> returns a dangling pointer n.
> qgroup =3D rb_entry(n, ...) results in an access to freed memory.
> Finally, the call to list_add(&qgroup->dirty, ...) inside
> qgroup_dirty() causes a kernel panic due to the illegal memory access.

This is valid. A race between quota disable and a task calling the
rescan ioctl (and not the rescan worker).

I've sent a patch to fix that:

https://lore.kernel.org/linux-btrfs/cover.1751286816.git.fdmanana@suse.com/

Thanks.

>
> Thank you again for your patience and time.
>
> Best regards,
> Cen Zhang
>
> Filipe Manana <fdmanana@kernel.org> =E4=BA=8E2025=E5=B9=B46=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:22=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jun 26, 2025 at 2:00=E2=80=AFPM cen zhang <zzzccc427@gmail.com>=
 wrote:
> > >
> > > Hello maintainers,
> > >
> > > I've encountered a kernel panic while using Btrfs. The issue appears
> > > to be a use-after-free (UAF) caused by a data race between the
> > > btrfs_quota_disable operation and a background btrfs_qgroup_rescan
> > > task.
> >
> > You have already reported this yesterday:
> >
> > https://lore.kernel.org/linux-btrfs/CAFRLqsXQMknPBgYkds=3DARWFC0vj1xAP7=
7USG+ZG5GH3rbqB5xQ@mail.gmail.com/
> >
> > >
> > > Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
> > > Environment: QEMU Virtual Machine
> > >
> > > Problem Description & Root Cause Analysis:
> > >
> > > The issue is triggered by the concurrent execution of the
> > > btrfs_quota_disable function and the background btrfs_qgroup_rescan
> > > worker.
> >
> > That can't happen, for two different reasons:
> >
> > 1) At btrfs_quota_disable() we clear the bit BTRFS_FS_QUOTA_ENABLED
> > from fs_info and then wait for the rescan worker to complete.
> >     The rescan worker stops as soon as it sees that bit is not set,
> > and if anyone tries to queue the rescan worker, the worker won't do
> > nothing since rescan_should_stop() returns true because the bit is not
> > set in fs_info anymore;
> >
> > 2) The quota disable and the rescan worker concurrently calling
> > btrfs_commit_transaction() -> commit_cowonly_roots() ->
> > btrfs_run_qgroups() is just not possible due to transaction states.
> >      At btrfs_free_qgroup_config(), besides having ensured early that
> > the rescan worker is not running and can't run anymore, as said before
> > there's also this detail:
> >
> >     btrfs_free_qgroup_config() is called after acquiring a transaction
> > handle - that means anyone trying to commit a transaction will block
> > waiting for the task running btrfs_quota_disable() to release its
> > transaction handle.
> >     So there's no way the rescan worker could get into
> > commit_cowonly_roots() since that happens when there is no one else
> > holding a handle for the transaction, the transaction state is
> > TRANS_STATE_COMMIT_DOING.
> >
> > More comments below.
> >
> >
> > >
> > > When quotas are disabled via an ioctl call, the btrfs_quota_disable -=
>
> > > btrfs_free_qgroup_config path iterates through the qgroup tree and
> > > frees the memory for each btrfs_qgroup object using kfree.
> >
> > Yes, while holding a transaction handle open and having waited for the
> > rescan worker to complete and preventing new runs of the rescan
> > worker, as just explained above.
> >
> > >
> > > Simultaneously, a background qgroup rescan task (btrfs_qgroup_rescan
> > > -> qgroup_rescan_zero_tracking) may be running, which iterates over
> > > and accesses the very same qgroup tree.
> >
> > No, as said before, the rescan worker can just commit a transaction
> > while the quota disable task is freeing qgroups.
> >
> > >
> > > Due to a lack of proper locking to synchronize these two operations,
> > > the qgroup_rescan_zero_tracking function can access a btrfs_qgroup
> > > object that has just been freed by btrfs_free_qgroup_config.
> >
> > There's is proper locking - transaction states and waiting for rescan
> > worker and making sure it can't start before we start freeing qrgoups.
> > >
> > > When it then attempts to modify a member of this dangling pointer
> > > (e.g., calling list_add in qgroup_dirty), it triggers a
> > > use-after-free, which ultimately leads to the kernel panic.
> > >
> > > We found this bug using our proprietary data-race detector in
> >
> > Ok, so this is an out of tree thing, and it's buggy for this case.
> >
> > > conjunction with syzkaller. Our tool first detected a race condition
> > > and then actively intervened by swapping the execution order of the
> > > conflicting operations. This controlled reordering directly exposed a
> > > latent use-after-free (UAF) vulnerability, which was subsequently
> > > caught and reported by KASAN.
> >
> > Ok, so your tool is reordering execution into a sequence that is not
> > possible otherwise as explained before regarding transaction states
> > and the rescan stop.
> >
> > Thanks.
> >
> > >
> > > I believe this issue could be fixed by adding an appropriate
> > > synchronization mechanism (e.g., a mutex) between the
> > > btrfs_quota_disable path and the background qgroup scanning tasks.
> > >
> > > Full kernel panic log is attached below:
> > >
> > > var addr ffff888168296888, addr masked 888168296888
> > > Kernel panic: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D DATARACE =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > VarName 2268446652518064666, BlockLineNumber 9, IrLineNumber 1, is wr=
ite 1
> > > Function: found_watchpoint kernel/kccwf/wp_checker.c:75 [inline]
> > > Function: watchpoints_monitor+0x1237/0x19a0 kernel/kccwf/wp_checker.c=
:155
> > > Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
> > > Function: list_del include/linux/list.h:230 [inline]
> > > Function: __del_qgroup_rb+0x2c2/0x17c0 fs/btrfs/qgroup.c:233
> > > Function: btrfs_free_qgroup_config+0xa1/0x2b0 fs/btrfs/qgroup.c:645
> > > Function: btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
> > > Function: btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
> > > Function: btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> > > Function: vfs_ioctl fs/ioctl.c:51 [inline]
> > > Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
> > > Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> > > Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> > > Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > Function: 0x0
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > VarName 18129403906671370250, BlockLineNumber 22, IrLineNumber 1,
> > > watchpoint index 19991
> > > Function: set_report_info+0xa6/0x1f0 kernel/kccwf/report.c:49
> > > Function: setup_watchpoint kernel/kccwf/wp_checker.c:102 [inline]
> > > Function: watchpoints_monitor+0x7eb/0x19a0 kernel/kccwf/wp_checker.c:=
167
> > > Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
> > > Function: __list_add include/linux/list.h:155 [inline]
> > > Function: list_add include/linux/list.h:169 [inline]
> > > Function: qgroup_dirty fs/btrfs/qgroup.c:1434 [inline]
> > > Function: qgroup_rescan_zero_tracking fs/btrfs/qgroup.c:4005 [inline]
> > > Function: btrfs_qgroup_rescan+0x4dc/0xa30 fs/btrfs/qgroup.c:4036
> > > Function: btrfs_ioctl_quota_rescan+0x42a/0x530 fs/btrfs/ioctl.c:3943
> > > Function: btrfs_ioctl+0x1187/0x1480 fs/btrfs/ioctl.c:5331
> > > Function: vfs_ioctl fs/ioctl.c:51 [inline]
> > > Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
> > > Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> > > Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> > > Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEND=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Found watch_point 19991
> > > BTRFS info (device sdb): balance: start -s
> > > BTRFS info (device sdb): balance: ended with status: 0
> > > BTRFS warning (device sdb): get dev_stats failed, device not found
> > > [...]
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in __list_del_entry
> > > include/linux/list.h:218 [inline]
> > > BUG: KASAN: slab-use-after-free in list_del_init
> > > include/linux/list.h:287 [inline]
> > > BUG: KASAN: slab-use-after-free in btrfs_run_qgroups+0x3cd/0x1ec0
> > > fs/btrfs/qgroup.c:3132
> > > Read of size 8 at addr ffff888168296890 by task btrfs-transacti/228
> > >
> > > CPU: 0 UID: 0 PID: 228 Comm: btrfs-transacti Not tainted
> > > 6.16.0-rc1-g7f6432600434-dirty #52 PREEMPT(voluntary)
> > > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> > > 1.16.3-debian-1.16.3-2 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x108/0x150 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:408 [inline]
> > >  print_report+0x191/0x5b0 mm/kasan/report.c:521
> > >  kasan_report+0x139/0x170 mm/kasan/report.c:634
> > >  __list_del_entry include/linux/list.h:218 [inline]
> > >  list_del_init include/linux/list.h:287 [inline]
> > >  btrfs_run_qgroups+0x3cd/0x1ec0 fs/btrfs/qgroup.c:3132
> > >  commit_cowonly_roots+0x67c/0x1c10 fs/btrfs/transaction.c:1354
> > >  btrfs_commit_transaction+0x2a5b/0xc800 fs/btrfs/transaction.c:2457
> > >  transaction_kthread+0x5b7/0xcc0 fs/btrfs/disk-io.c:1590
> > >  kthread+0x351/0x780 kernel/kthread.c:464
> > >  ret_from_fork+0x10e/0x1c0 arch/x86/kernel/process.c:148
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >  </TASK>
> > >
> > > Allocated by task 127769:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> > >  __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:394
> > >  kmalloc_noprof include/linux/slab.h:905 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> > >  btrfs_quota_enable+0x2d07/0x5d10 fs/btrfs/qgroup.c:1201
> > >  btrfs_ioctl_quota_ctl+0x36c/0x4e0 fs/btrfs/ioctl.c:3673
> > >  btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> > >  __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Freed by task 127948:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> > >  poison_slab_object mm/kasan/common.c:247 [inline]
> > >  __kasan_slab_free+0x36/0x50 mm/kasan/common.c:264
> > >  kasan_slab_free include/linux/kasan.h:233 [inline]
> > >  slab_free_hook mm/slub.c:2388 [inline]
> > >  slab_free mm/slub.c:4670 [inline]
> > >  kfree+0xfd/0x340 mm/slub.c:4869
> > >  btrfs_free_qgroup_config+0xcd/0x2b0 fs/btrfs/qgroup.c:647
> > >  btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
> > >  btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
> > >  btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> > >  __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > The buggy address belongs to the object at ffff888168296800
> > >  which belongs to the cache kmalloc-512 of size 512
> > > The buggy address is located 144 bytes inside of
> > >  freed 512-byte region [ffff888168296800, ffff888168296a00)
> > > [...]
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Hope this helps in tracking down and fixing the issue.
> > >
> > > Here is the detail:
> > >
> > > Thank you for your attention to this matter.
> > >
> > > Best regards,
> > > Cen Zhang
> > >

