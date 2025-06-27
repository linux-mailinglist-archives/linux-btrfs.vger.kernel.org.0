Return-Path: <linux-btrfs+bounces-15055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903CFAEC2D3
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jun 2025 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4171C6199A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6403528A1F5;
	Fri, 27 Jun 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLj/7B1Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F521A454;
	Fri, 27 Jun 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064614; cv=none; b=OWkSKHkrVct6Fblme1EZKLZ6Ibnwjw7EEoXKZMPYC21A5dvEBpPQnKcbxyFCQo49sbJr7wDq7QRfXH2tEiVY3flG94W40PewE7jSjtE/DwjBgSpc97bVRUIisjbKg5GkhjQl2xb2ZNwsjy5QxeYqaFE+3PyKKmHBV7z1aTyD9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064614; c=relaxed/simple;
	bh=GZaiObNBAufddyvGuqSi0KLZwPkcPwbC/FLc3SsNciY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESERr8kHxi0KgNJL6dXznkPZirGFAiQL13kjczTMdrwcSP8wfpIfBQboDqtxLsUjae8BsHhbF7YvHMUP3x3uCqfPBmhbey5b7JACiXr4nYtbW4TkNdi1zV/tk7DF7WlP+BIa9hl/OAAVW52U7C9IvNPY+7TwGdOODGmrx9u7+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLj/7B1Q; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e82314f9a51so1856001276.0;
        Fri, 27 Jun 2025 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751064612; x=1751669412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33OpF/2iKjMmzdf/Qax8BTJbz4iEv6TtzGVNslSs1B8=;
        b=ZLj/7B1Qa0BECgDj9YZB1Zr5hWM8VIYn5naPG054GBst+jkHHd7Y8RjiKO5X1pAK+6
         BLW5gddNBQ5+Am18HR/grwqOoFKyPRSvy5FynGBXGo+Ny2dMG+rLxnZijI7Kj3ScJdlU
         FwIATMB4BiiwqKPnJfFNfL5zm1+reorj3VsvUv1Y1NcjPc8PVEeWqqqQpAMtvocscbhg
         e2uvRbS/SKuBv0O2yqm7C0lIQEtycQTHj3poXtmYVWlIF7ZgmUpybLI/AKUzrzXb70xp
         gNjzTUHlX1N+mky2eEpWTO0KfHKte+CQYhx/vIXtCG6oikv8nc9D1DE6/jF+YQVL9jup
         EDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751064612; x=1751669412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33OpF/2iKjMmzdf/Qax8BTJbz4iEv6TtzGVNslSs1B8=;
        b=WPGIjqyFdui8CrHBW2z0ojgGyii/x4cPdwK6e91D3TPDYHGaiLCyxDVet2ER3ivDHf
         yMW3V4X5z2TfSZVH5Xhatbj7jRUf2MauTMRoE6fK12EegOoCMuveURk7yv/qG2EaGVjq
         XRRkO9A4BdFPuYk221HNURvlmEOXvxit+cF1jIQtxZQK7EuAAWAwZBm3kQX2RHrR2bHG
         uHM0s5mdmLj7CCNZjZBN7BD8lrUJgnoDK6p1RCWWan/XAOi0EwyZfcnzGxdyS97hQZwi
         IBhQHNM1Jl+ns39eJjKBu6fxM5wkEGRVeUvdCrEquFldVJBZzmyAx6XbH+MTLALTnyyk
         gbPw==
X-Forwarded-Encrypted: i=1; AJvYcCVInEHXL5DzcGU6p0M0VaKN2Qw2JohVkuD1ercGYZGWvUHbQv7GvtG5eTJzjCR+pR9mNsE3CvbqUlPszkRc@vger.kernel.org, AJvYcCXhz6HvzyBF0QxUrSc2EsbVkTi6K7V5U4SoN6vKzgHlYkFM9tBC7fT4PytUijVlVAx7Ptxer6Mz14a1cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4hVCvbQgax1OzvPtqhMsV01v496DStZPEksuEfh33EOOhe0R
	08+G9N/KjBDPPEXsnD1vGkPGQumC2Zll4DN+8kW2iVNQPtUieIRpC/CbYvcicmpy7jBUJT2nEFV
	kxd7mRcERmfTmauDNAFrcyY3B+wAmHuo=
X-Gm-Gg: ASbGncupCaMjHxRTbyJx0TCedHwIupBBmnqzdM2m/M5KKO/0a//++ho55H0WmMTWrnK
	69pTuVZN1HY66jm0lCn1NPYs/rKi5j1X2mQACf84BI4pN+sDDRKar3kSJSsQgwIfQ6XBVUWLr1I
	Z3Rf5t2pGDt3fPc1M7pAO0ybvg8SXvdScBiCBilm/o5A==
X-Google-Smtp-Source: AGHT+IHzVsy+S6NAVGHlRxMmTuQ/WJGHnA+lAOv2upjZ2TP7VPTPiJgBHTwpAINNACWra8vnGA+AK6UPL659epNmH2g=
X-Received: by 2002:a05:6902:2005:b0:e7d:d830:4208 with SMTP id
 3f1490d57ef6-e87a7aff73fmr6743184276.1.1751064611403; Fri, 27 Jun 2025
 15:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com>
 <CAL3q7H6p1M5iCgV9RZ=ioSGOf5mrZF-rL_gocPB4hhtoU8Ugbw@mail.gmail.com>
In-Reply-To: <CAL3q7H6p1M5iCgV9RZ=ioSGOf5mrZF-rL_gocPB4hhtoU8Ugbw@mail.gmail.com>
From: cen zhang <zzzccc427@gmail.com>
Date: Sat, 28 Jun 2025 06:49:56 +0800
X-Gm-Features: Ac12FXw0D_LCaAfyxYBVdUcq6fgKuj_UZ_ZUPUCfnfUFf7nXDdan4qvqfBCGSfM
Message-ID: <CAFRLqsXdo9YMYS_drZkaBSzeBSPWfAF_3JNr=ng__8SBNe9cyA@mail.gmail.com>
Subject: Re: [BUG] btrfs: Data race between btrfs_quota_disable and
 btrfs_qgroup_rescan leads to a UAF
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Btrfs maintainers,

Thank you for your detailed response to our previous report again. We
have carefully studied the two synchronization mechanisms you
mentioned and fully understand their design intent.

After a more in-depth analysis, we have confirmed a specific timing
window where both of these synchronization mechanisms can be bypassed,
leading to a Use-After-Free (UAF) issue. This email aims to elaborate
on this scenario and explain why we believe it is a race condition
that needs to be fixed.

The core of the problem is that there is a data race between
qgroup_rescan_zero_tracking(), called during the preparation phase of
the btrfs_qgroup_rescan function, and btrfs_free_qgroup_config(),
called by btrfs_quota_disable. The two key synchronization mechanisms
fail to cover this specific conflict point.

We try to explain why the tow synchronization mechanisms will fail:

 You mentioned that btrfs_quota_disable first clears the
BTRFS_FS_QUOTA_ENABLED flag and then calls
btrfs_qgroup_wait_for_completion to wait for the rescan worker to
stop. This is intended to ensure a graceful shutdown.But the
effectiveness of this mechanism relies on
btrfs_qgroup_wait_for_completion correctly determining if a rescan
task is running. The function checks the
fs_info->qgroup_rescan_running flag to do this. However, in the
btrfs_qgroup_rescan function, the qgroup_rescan_running flag is set to
true only after all preparation work (including the call to
qgroup_rescan_zero_tracking) is complete. This creates a window where
a rescan task has started its setup but is not yet marked as
"running." If btrfs_quota_disable executes during this window, it will
see qgroup_rescan_running as false, incorrectly skip the wait, and
proceed directly to the cleanup process.

And regarding the second synchronization mechanism you proposed, you
mentioned that btrfs_quota_disable acquires a transaction handle
before calling btrfs_free_qgroup_config. Since the background rescan
worker also needs to commit transactions, the inherent mutual
exclusion of the transaction system should block the worker, thus
preventing concurrent modifications.But this mechanism protects
operations that require a Btrfs transaction. However, the problematic
function, qgroup_rescan_zero_tracking, is a memory-only operation. It
traverses and modifies the in-memory qgroup red-black tree, a process
that does not require or hold a Btrfs transaction handle. In the
execution flow of btrfs_qgroup_rescan, it first completes a
btrfs_commit_current_transaction, at which point it no longer holds a
transaction handle. It then calls qgroup_rescan_zero_tracking.
Therefore, even if btrfs_quota_disable holds a transaction handle, it
cannot block the execution of qgroup_rescan_zero_tracking, as the
latter does not compete for the transaction lock.

Detailed Execution Trace Triggering the UAF

Consider the precise steps showing how the two threads can interleave
to trigger the UAF:

TID 1 (Rescan Thread): Executes btrfs quota rescan, entering
btrfs_qgroup_rescan(). After successfully executing
btrfs_commit_current_transaction() but before calling
qgroup_rescan_zero_tracking(), it gets preempted by the OS or delay by
our tools.And now qgroup_rescan_running is still false. TID 1 does not
hold a transaction handle.

TID 2 (Disable Thread): Executes btrfs quota disable, entering
btrfs_quota_disable().

It calls btrfs_qgroup_wait_for_completion(). Since
qgroup_rescan_running is false, the wait is skipped.
It successfully starts a new transaction (btrfs_start_transaction).
It calls btrfs_free_qgroup_config(). This function, without taking a
lock, loops through calls to rb_erase and kfree, freeing all nodes and
memory of the qgroup red-black tree.

TID 1 (Rescan Thread): Resumes execution.
It calls qgroup_rescan_zero_tracking().
Inside this function, the for (n =3D rb_first(&fs_info->qgroup_tree);
...) attempts to access the memory just freed by TID 2. rb_first
returns a dangling pointer n.
qgroup =3D rb_entry(n, ...) results in an access to freed memory.
Finally, the call to list_add(&qgroup->dirty, ...) inside
qgroup_dirty() causes a kernel panic due to the illegal memory access.

Thank you again for your patience and time.

Best regards,
Cen Zhang

Filipe Manana <fdmanana@kernel.org> =E4=BA=8E2025=E5=B9=B46=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 26, 2025 at 2:00=E2=80=AFPM cen zhang <zzzccc427@gmail.com> w=
rote:
> >
> > Hello maintainers,
> >
> > I've encountered a kernel panic while using Btrfs. The issue appears
> > to be a use-after-free (UAF) caused by a data race between the
> > btrfs_quota_disable operation and a background btrfs_qgroup_rescan
> > task.
>
> You have already reported this yesterday:
>
> https://lore.kernel.org/linux-btrfs/CAFRLqsXQMknPBgYkds=3DARWFC0vj1xAP77U=
SG+ZG5GH3rbqB5xQ@mail.gmail.com/
>
> >
> > Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
> > Environment: QEMU Virtual Machine
> >
> > Problem Description & Root Cause Analysis:
> >
> > The issue is triggered by the concurrent execution of the
> > btrfs_quota_disable function and the background btrfs_qgroup_rescan
> > worker.
>
> That can't happen, for two different reasons:
>
> 1) At btrfs_quota_disable() we clear the bit BTRFS_FS_QUOTA_ENABLED
> from fs_info and then wait for the rescan worker to complete.
>     The rescan worker stops as soon as it sees that bit is not set,
> and if anyone tries to queue the rescan worker, the worker won't do
> nothing since rescan_should_stop() returns true because the bit is not
> set in fs_info anymore;
>
> 2) The quota disable and the rescan worker concurrently calling
> btrfs_commit_transaction() -> commit_cowonly_roots() ->
> btrfs_run_qgroups() is just not possible due to transaction states.
>      At btrfs_free_qgroup_config(), besides having ensured early that
> the rescan worker is not running and can't run anymore, as said before
> there's also this detail:
>
>     btrfs_free_qgroup_config() is called after acquiring a transaction
> handle - that means anyone trying to commit a transaction will block
> waiting for the task running btrfs_quota_disable() to release its
> transaction handle.
>     So there's no way the rescan worker could get into
> commit_cowonly_roots() since that happens when there is no one else
> holding a handle for the transaction, the transaction state is
> TRANS_STATE_COMMIT_DOING.
>
> More comments below.
>
>
> >
> > When quotas are disabled via an ioctl call, the btrfs_quota_disable ->
> > btrfs_free_qgroup_config path iterates through the qgroup tree and
> > frees the memory for each btrfs_qgroup object using kfree.
>
> Yes, while holding a transaction handle open and having waited for the
> rescan worker to complete and preventing new runs of the rescan
> worker, as just explained above.
>
> >
> > Simultaneously, a background qgroup rescan task (btrfs_qgroup_rescan
> > -> qgroup_rescan_zero_tracking) may be running, which iterates over
> > and accesses the very same qgroup tree.
>
> No, as said before, the rescan worker can just commit a transaction
> while the quota disable task is freeing qgroups.
>
> >
> > Due to a lack of proper locking to synchronize these two operations,
> > the qgroup_rescan_zero_tracking function can access a btrfs_qgroup
> > object that has just been freed by btrfs_free_qgroup_config.
>
> There's is proper locking - transaction states and waiting for rescan
> worker and making sure it can't start before we start freeing qrgoups.
> >
> > When it then attempts to modify a member of this dangling pointer
> > (e.g., calling list_add in qgroup_dirty), it triggers a
> > use-after-free, which ultimately leads to the kernel panic.
> >
> > We found this bug using our proprietary data-race detector in
>
> Ok, so this is an out of tree thing, and it's buggy for this case.
>
> > conjunction with syzkaller. Our tool first detected a race condition
> > and then actively intervened by swapping the execution order of the
> > conflicting operations. This controlled reordering directly exposed a
> > latent use-after-free (UAF) vulnerability, which was subsequently
> > caught and reported by KASAN.
>
> Ok, so your tool is reordering execution into a sequence that is not
> possible otherwise as explained before regarding transaction states
> and the rescan stop.
>
> Thanks.
>
> >
> > I believe this issue could be fixed by adding an appropriate
> > synchronization mechanism (e.g., a mutex) between the
> > btrfs_quota_disable path and the background qgroup scanning tasks.
> >
> > Full kernel panic log is attached below:
> >
> > var addr ffff888168296888, addr masked 888168296888
> > Kernel panic: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D DATARACE =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > VarName 2268446652518064666, BlockLineNumber 9, IrLineNumber 1, is writ=
e 1
> > Function: found_watchpoint kernel/kccwf/wp_checker.c:75 [inline]
> > Function: watchpoints_monitor+0x1237/0x19a0 kernel/kccwf/wp_checker.c:1=
55
> > Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
> > Function: list_del include/linux/list.h:230 [inline]
> > Function: __del_qgroup_rb+0x2c2/0x17c0 fs/btrfs/qgroup.c:233
> > Function: btrfs_free_qgroup_config+0xa1/0x2b0 fs/btrfs/qgroup.c:645
> > Function: btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
> > Function: btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
> > Function: btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> > Function: vfs_ioctl fs/ioctl.c:51 [inline]
> > Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
> > Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> > Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> > Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Function: 0x0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > VarName 18129403906671370250, BlockLineNumber 22, IrLineNumber 1,
> > watchpoint index 19991
> > Function: set_report_info+0xa6/0x1f0 kernel/kccwf/report.c:49
> > Function: setup_watchpoint kernel/kccwf/wp_checker.c:102 [inline]
> > Function: watchpoints_monitor+0x7eb/0x19a0 kernel/kccwf/wp_checker.c:16=
7
> > Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
> > Function: __list_add include/linux/list.h:155 [inline]
> > Function: list_add include/linux/list.h:169 [inline]
> > Function: qgroup_dirty fs/btrfs/qgroup.c:1434 [inline]
> > Function: qgroup_rescan_zero_tracking fs/btrfs/qgroup.c:4005 [inline]
> > Function: btrfs_qgroup_rescan+0x4dc/0xa30 fs/btrfs/qgroup.c:4036
> > Function: btrfs_ioctl_quota_rescan+0x42a/0x530 fs/btrfs/ioctl.c:3943
> > Function: btrfs_ioctl+0x1187/0x1480 fs/btrfs/ioctl.c:5331
> > Function: vfs_ioctl fs/ioctl.c:51 [inline]
> > Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
> > Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> > Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> > Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEND=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Found watch_point 19991
> > BTRFS info (device sdb): balance: start -s
> > BTRFS info (device sdb): balance: ended with status: 0
> > BTRFS warning (device sdb): get dev_stats failed, device not found
> > [...]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in __list_del_entry
> > include/linux/list.h:218 [inline]
> > BUG: KASAN: slab-use-after-free in list_del_init
> > include/linux/list.h:287 [inline]
> > BUG: KASAN: slab-use-after-free in btrfs_run_qgroups+0x3cd/0x1ec0
> > fs/btrfs/qgroup.c:3132
> > Read of size 8 at addr ffff888168296890 by task btrfs-transacti/228
> >
> > CPU: 0 UID: 0 PID: 228 Comm: btrfs-transacti Not tainted
> > 6.16.0-rc1-g7f6432600434-dirty #52 PREEMPT(voluntary)
> > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> > 1.16.3-debian-1.16.3-2 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x108/0x150 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:408 [inline]
> >  print_report+0x191/0x5b0 mm/kasan/report.c:521
> >  kasan_report+0x139/0x170 mm/kasan/report.c:634
> >  __list_del_entry include/linux/list.h:218 [inline]
> >  list_del_init include/linux/list.h:287 [inline]
> >  btrfs_run_qgroups+0x3cd/0x1ec0 fs/btrfs/qgroup.c:3132
> >  commit_cowonly_roots+0x67c/0x1c10 fs/btrfs/transaction.c:1354
> >  btrfs_commit_transaction+0x2a5b/0xc800 fs/btrfs/transaction.c:2457
> >  transaction_kthread+0x5b7/0xcc0 fs/btrfs/disk-io.c:1590
> >  kthread+0x351/0x780 kernel/kthread.c:464
> >  ret_from_fork+0x10e/0x1c0 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 127769:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >  __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:394
> >  kmalloc_noprof include/linux/slab.h:905 [inline]
> >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >  btrfs_quota_enable+0x2d07/0x5d10 fs/btrfs/qgroup.c:1201
> >  btrfs_ioctl_quota_ctl+0x36c/0x4e0 fs/btrfs/ioctl.c:3673
> >  btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >  __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 127948:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x36/0x50 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2388 [inline]
> >  slab_free mm/slub.c:4670 [inline]
> >  kfree+0xfd/0x340 mm/slub.c:4869
> >  btrfs_free_qgroup_config+0xcd/0x2b0 fs/btrfs/qgroup.c:647
> >  btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
> >  btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
> >  btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >  __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff888168296800
> >  which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 144 bytes inside of
> >  freed 512-byte region [ffff888168296800, ffff888168296a00)
> > [...]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Hope this helps in tracking down and fixing the issue.
> >
> > Here is the detail:
> >
> > Thank you for your attention to this matter.
> >
> > Best regards,
> > Cen Zhang
> >

