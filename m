Return-Path: <linux-btrfs+bounces-14997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90488AE9E85
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F641C4355C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E728BAB1;
	Thu, 26 Jun 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFx4lCxk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B418C31;
	Thu, 26 Jun 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944122; cv=none; b=KIFzGMpGM7Hd1jocvH4STVtKRU7sPEwPn4pWfgceAgzbyW4nvNWM338lMH+RvsZRi4/8qX1mW54gFle32wujE1Fqk53sGfdB/mT4ux0aSRvx1K5H0kwP4uh7Dkcx1k/GoMxo5eouZDr4XSoHP6+IUGqNfLHhTSnEltTvPY+Djgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944122; c=relaxed/simple;
	bh=qA5wdG9ZWNupdJW+thctxgrkMixOtsU29inIRMRbFFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asyl2E7qdlLKjaxIInXicObj91rvztV/CNB1o0+MY8aDdWNULL5zdBYanUv836RixSS87Qnt/+CUG6xNbnuOTNDrpwwO4BvIBccbHo8CaCP5WggAsKtohEkWX+rViIBW3FkSMkNjoa5zM6iATI00H+tR4ppwr7XSXmb8z1D5sLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFx4lCxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF333C4AF09;
	Thu, 26 Jun 2025 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750944121;
	bh=qA5wdG9ZWNupdJW+thctxgrkMixOtsU29inIRMRbFFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fFx4lCxkEGl0F96TLtFtTKDXG5idl3IWmnP+pQaqKXAyr7eoyRsAVfmhBIwt5h8kw
	 eZ3T50ChcQQmstD8AJ/lLvCLkCt0evxGLPLv65WataVwpfBnBordpxKaEKHhjCisfj
	 JvTAIOq/NrEKxw1XW8VA3dS8laOKyqwZNonleyb/9nFaM8mlmDq+jofnN5s3ql5Bqr
	 ElzPgpXbzHCnlJzL6QtDEpBtbMQVZ9LN/rSAsoK9bZIAtqraGPycNO/et//dJ9b/L6
	 4dNGWP7fpVRC3cTsYAHFG0oNEe1tkCmu9Q6SIOmBEv0kxj5UKbGRljmnSlp+VoYEXT
	 ph7/Q/qSMyCMA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so171503066b.2;
        Thu, 26 Jun 2025 06:22:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLByodLp7jLGp7iYVwAJXpGLrkrL1SO7zhNy4yXw5S+EVzz+cp+TSqdZA8obyLcCfGUtwSXfjuorcUWRtd@vger.kernel.org, AJvYcCXmGSMyrwZTc73rvGtg7UWbRfw8eL6kMGqs6aqmqwREcigrmAMMLWJNxNEGZL27dp0vWwIk1TGypAScqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKjKOYCzzt7CpsnaT1hhL1z3r4r1V6etXlBNSxLeu8EID3g60
	esuUzjOqPjhudWDGKTC0+PTGxfC4tUr1HSZGksQcy7Px0cf7SsJAcO+wqqy6ErQRsK9a1Qm3GR3
	nP+v/b+564YGD6L4iUYalFn4e05RSu1k=
X-Google-Smtp-Source: AGHT+IF9H+zQh7fjQeqFwaK+DlNPSzsvAbTANFmTWLUoPuV0tBHuJ6R+T/kh9A0aRHHZGJBy1QomeqzIP1NLW8wBviQ=
X-Received: by 2002:a17:906:7953:b0:adb:2bee:53c9 with SMTP id
 a640c23a62f3a-ae0be909264mr728091766b.3.1750944120291; Thu, 26 Jun 2025
 06:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com>
In-Reply-To: <CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Jun 2025 14:21:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6p1M5iCgV9RZ=ioSGOf5mrZF-rL_gocPB4hhtoU8Ugbw@mail.gmail.com>
X-Gm-Features: Ac12FXx7LfYnokAnC1EKPMWo9jtIKXHXDCkGLpZTVJ4NkK8Wihonxl9EGvPG2XA
Message-ID: <CAL3q7H6p1M5iCgV9RZ=ioSGOf5mrZF-rL_gocPB4hhtoU8Ugbw@mail.gmail.com>
Subject: Re: [BUG] btrfs: Data race between btrfs_quota_disable and
 btrfs_qgroup_rescan leads to a UAF
To: cen zhang <zzzccc427@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 2:00=E2=80=AFPM cen zhang <zzzccc427@gmail.com> wro=
te:
>
> Hello maintainers,
>
> I've encountered a kernel panic while using Btrfs. The issue appears
> to be a use-after-free (UAF) caused by a data race between the
> btrfs_quota_disable operation and a background btrfs_qgroup_rescan
> task.

You have already reported this yesterday:

https://lore.kernel.org/linux-btrfs/CAFRLqsXQMknPBgYkds=3DARWFC0vj1xAP77USG=
+ZG5GH3rbqB5xQ@mail.gmail.com/

>
> Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
> Environment: QEMU Virtual Machine
>
> Problem Description & Root Cause Analysis:
>
> The issue is triggered by the concurrent execution of the
> btrfs_quota_disable function and the background btrfs_qgroup_rescan
> worker.

That can't happen, for two different reasons:

1) At btrfs_quota_disable() we clear the bit BTRFS_FS_QUOTA_ENABLED
from fs_info and then wait for the rescan worker to complete.
    The rescan worker stops as soon as it sees that bit is not set,
and if anyone tries to queue the rescan worker, the worker won't do
nothing since rescan_should_stop() returns true because the bit is not
set in fs_info anymore;

2) The quota disable and the rescan worker concurrently calling
btrfs_commit_transaction() -> commit_cowonly_roots() ->
btrfs_run_qgroups() is just not possible due to transaction states.
     At btrfs_free_qgroup_config(), besides having ensured early that
the rescan worker is not running and can't run anymore, as said before
there's also this detail:

    btrfs_free_qgroup_config() is called after acquiring a transaction
handle - that means anyone trying to commit a transaction will block
waiting for the task running btrfs_quota_disable() to release its
transaction handle.
    So there's no way the rescan worker could get into
commit_cowonly_roots() since that happens when there is no one else
holding a handle for the transaction, the transaction state is
TRANS_STATE_COMMIT_DOING.

More comments below.


>
> When quotas are disabled via an ioctl call, the btrfs_quota_disable ->
> btrfs_free_qgroup_config path iterates through the qgroup tree and
> frees the memory for each btrfs_qgroup object using kfree.

Yes, while holding a transaction handle open and having waited for the
rescan worker to complete and preventing new runs of the rescan
worker, as just explained above.

>
> Simultaneously, a background qgroup rescan task (btrfs_qgroup_rescan
> -> qgroup_rescan_zero_tracking) may be running, which iterates over
> and accesses the very same qgroup tree.

No, as said before, the rescan worker can just commit a transaction
while the quota disable task is freeing qgroups.

>
> Due to a lack of proper locking to synchronize these two operations,
> the qgroup_rescan_zero_tracking function can access a btrfs_qgroup
> object that has just been freed by btrfs_free_qgroup_config.

There's is proper locking - transaction states and waiting for rescan
worker and making sure it can't start before we start freeing qrgoups.
>
> When it then attempts to modify a member of this dangling pointer
> (e.g., calling list_add in qgroup_dirty), it triggers a
> use-after-free, which ultimately leads to the kernel panic.
>
> We found this bug using our proprietary data-race detector in

Ok, so this is an out of tree thing, and it's buggy for this case.

> conjunction with syzkaller. Our tool first detected a race condition
> and then actively intervened by swapping the execution order of the
> conflicting operations. This controlled reordering directly exposed a
> latent use-after-free (UAF) vulnerability, which was subsequently
> caught and reported by KASAN.

Ok, so your tool is reordering execution into a sequence that is not
possible otherwise as explained before regarding transaction states
and the rescan stop.

Thanks.

>
> I believe this issue could be fixed by adding an appropriate
> synchronization mechanism (e.g., a mutex) between the
> btrfs_quota_disable path and the background qgroup scanning tasks.
>
> Full kernel panic log is attached below:
>
> var addr ffff888168296888, addr masked 888168296888
> Kernel panic: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D DATARACE =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> VarName 2268446652518064666, BlockLineNumber 9, IrLineNumber 1, is write =
1
> Function: found_watchpoint kernel/kccwf/wp_checker.c:75 [inline]
> Function: watchpoints_monitor+0x1237/0x19a0 kernel/kccwf/wp_checker.c:155
> Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
> Function: list_del include/linux/list.h:230 [inline]
> Function: __del_qgroup_rb+0x2c2/0x17c0 fs/btrfs/qgroup.c:233
> Function: btrfs_free_qgroup_config+0xa1/0x2b0 fs/btrfs/qgroup.c:645
> Function: btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
> Function: btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
> Function: btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
> Function: vfs_ioctl fs/ioctl.c:51 [inline]
> Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
> Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Function: 0x0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> VarName 18129403906671370250, BlockLineNumber 22, IrLineNumber 1,
> watchpoint index 19991
> Function: set_report_info+0xa6/0x1f0 kernel/kccwf/report.c:49
> Function: setup_watchpoint kernel/kccwf/wp_checker.c:102 [inline]
> Function: watchpoints_monitor+0x7eb/0x19a0 kernel/kccwf/wp_checker.c:167
> Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
> Function: __list_add include/linux/list.h:155 [inline]
> Function: list_add include/linux/list.h:169 [inline]
> Function: qgroup_dirty fs/btrfs/qgroup.c:1434 [inline]
> Function: qgroup_rescan_zero_tracking fs/btrfs/qgroup.c:4005 [inline]
> Function: btrfs_qgroup_rescan+0x4dc/0xa30 fs/btrfs/qgroup.c:4036
> Function: btrfs_ioctl_quota_rescan+0x42a/0x530 fs/btrfs/ioctl.c:3943
> Function: btrfs_ioctl+0x1187/0x1480 fs/btrfs/ioctl.c:5331
> Function: vfs_ioctl fs/ioctl.c:51 [inline]
> Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
> Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
> Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
> Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEND=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> Found watch_point 19991
> BTRFS info (device sdb): balance: start -s
> BTRFS info (device sdb): balance: ended with status: 0
> BTRFS warning (device sdb): get dev_stats failed, device not found
> [...]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in __list_del_entry
> include/linux/list.h:218 [inline]
> BUG: KASAN: slab-use-after-free in list_del_init
> include/linux/list.h:287 [inline]
> BUG: KASAN: slab-use-after-free in btrfs_run_qgroups+0x3cd/0x1ec0
> fs/btrfs/qgroup.c:3132
> Read of size 8 at addr ffff888168296890 by task btrfs-transacti/228
>
> CPU: 0 UID: 0 PID: 228 Comm: btrfs-transacti Not tainted
> 6.16.0-rc1-g7f6432600434-dirty #52 PREEMPT(voluntary)
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x108/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0x191/0x5b0 mm/kasan/report.c:521
>  kasan_report+0x139/0x170 mm/kasan/report.c:634
>  __list_del_entry include/linux/list.h:218 [inline]
>  list_del_init include/linux/list.h:287 [inline]
>  btrfs_run_qgroups+0x3cd/0x1ec0 fs/btrfs/qgroup.c:3132
>  commit_cowonly_roots+0x67c/0x1c10 fs/btrfs/transaction.c:1354
>  btrfs_commit_transaction+0x2a5b/0xc800 fs/btrfs/transaction.c:2457
>  transaction_kthread+0x5b7/0xcc0 fs/btrfs/disk-io.c:1590
>  kthread+0x351/0x780 kernel/kthread.c:464
>  ret_from_fork+0x10e/0x1c0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> Allocated by task 127769:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:394
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  btrfs_quota_enable+0x2d07/0x5d10 fs/btrfs/qgroup.c:1201
>  btrfs_ioctl_quota_ctl+0x36c/0x4e0 fs/btrfs/ioctl.c:3673
>  btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 127948:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x36/0x50 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2388 [inline]
>  slab_free mm/slub.c:4670 [inline]
>  kfree+0xfd/0x340 mm/slub.c:4869
>  btrfs_free_qgroup_config+0xcd/0x2b0 fs/btrfs/qgroup.c:647
>  btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
>  btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
>  btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888168296800
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 144 bytes inside of
>  freed 512-byte region [ffff888168296800, ffff888168296a00)
> [...]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Hope this helps in tracking down and fixing the issue.
>
> Here is the detail:
>
> Thank you for your attention to this matter.
>
> Best regards,
> Cen Zhang
>

