Return-Path: <linux-btrfs+bounces-20117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F058BCF6770
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 03:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B58013031341
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351AE14A60C;
	Tue,  6 Jan 2026 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWBDPwd0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD6202C5C
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666435; cv=none; b=klFug0rxo7JOT9ZgFtGRFuf5g5QRN/d2vIrYWrnnWWssyA+dQv6Bpffg5hM5o+k/UXTgpP2HkBYhWah8UuXgFBod39KaMMlZk+R/bGHqeP3Kvckdy3XE02cYXMYmtSl7rth70kbdl+RMui408hPl5GRYYgOQEvFgE2KkV6nPZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666435; c=relaxed/simple;
	bh=AkTdqTlAbNgghPAZNdbQnJrykMGcjV6vextJRyo2v2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGCntXRZuD7QvoMUddPk8nty5uMhN4m2PomYKRT9aIuU6BEPqhtydLxU9kibsDIWd9aaxbjhvzxN+aSYg0cR0kbZQX8h/x/6NjaP4ZVGvRWxdwlrH3gqv/ZZdi+fygm09o719izEoPMEW0Ip8HwkpKwEo2dlFqEKMOGUUkU1r5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWBDPwd0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so981331a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 18:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767666432; x=1768271232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RlsXGJMO8IblDstpL+JsaPUrEAP5vkLRIsGOWYAc6E=;
        b=jWBDPwd0kQgwZOVOrxVAWTInQrmcxSsRwvtxGW2PbXiq0p2g6Mw5fME5c2CtORIGh4
         MdkRSJ/eQo7jgNFkjYwZPkmg9zcZXp5V9aeNhYdsCVBx0dSuNpxAQ6zJ5K7x0BU/E7yy
         wyzU6lU60DCHuRcvCMgB6eY1qd7yPWUi7xn5o3Z7FVBELm+L/bT0d9KoWYcwi/FspFAo
         w5xbF1ghJOY/uogg1sem9NwnrXVOo6eDoDLWUWH+eVcmPPt08reUAUdp7tBkY6Yoau51
         dyW/AHVzxwjGSRatuB+BBNXcZg9uTR4rLYJ5FHyGraqWQfS4Sp3Abh2mtB3LV0sJ1YUC
         JJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767666432; x=1768271232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RlsXGJMO8IblDstpL+JsaPUrEAP5vkLRIsGOWYAc6E=;
        b=EKMO37MaqPnYHBNXoe/Q4yUCTSGsdvZJ+VrxJbnU+mmu6LQPH40Vm256gdxt5ptnUN
         mx2WLOk1dqdcPlxO53AmlQrBkEna/hmR8GZKi+pcT9WtXvqja1AfilNY81wtiSBBqomh
         Vu/opGa9Os32WhXuwad4hknrBU+p2mP4gD81qWcnnKjg186bQfuDv9sNkFHaAxN2iwjd
         mpiCXxMMPrQaymN83fqSWabP/Y2ewQtvfBIuXXWJz4RvuaUnrloB4AKSXtoMylk7h1iL
         4Il2LXKIlNBjKMM+TmRxYC/Dl6GsF+IR5vBGrSk6u4hmyKLuDka7Lelo5cDF6tif5+r2
         96rg==
X-Forwarded-Encrypted: i=1; AJvYcCX0bb9Odr0YzEKYVQfXGGx5JmYqQWICmMogySvrdMFdne/73ErjKzSLfKkubLnz+jUjgKNxCA+Nj4nZhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjP0I9P26rzN0PsDF8eLq3zajZdiVpnF3BBTUOQiTBLWTuxQC
	RsLXb1TYIjzfO2dIr4evwdfT1MvskHRh+qVI9Ll7/Gl5Aue6GxK5zFqSzU4/t8J7qW3DjnO7dgr
	+lJIjnLSy62fYuDpi/ck2zTyjnuURerA=
X-Gm-Gg: AY/fxX6eJBIynNfLOs+aiRyUBs2gFm4q0ai7iCVPQTyZFXa1dIdir3UJuIXtOwv+8MM
	as0+07Zd0mx7lfAEWmB1vl1tqPIgLYF7qTd1V5dGqUDKfiF0g30HF1S+5olrHsb4DBNZFCAx2Sz
	zMKK+TFqS+hM9TkmQ6lUgzmp1t246wvptAAH6BEclqGAOw1lV/JcR4dbiqCySBU2bCbfx9OGIcQ
	R/FDW7EReNJKoCCpG4EsagOu20tzX0mw0ha4NxyqUoSS4QSkmZP8/IRt33viyMIumXKAgRhaw==
X-Google-Smtp-Source: AGHT+IHyQ36f6AWfjYiWTHwv7TMV6FG8r+vTsMu8+oJln5TruFAMBs+WmCj3kqCkB2Rz/X6crBy9myGHHke4c6LfKPE=
X-Received: by 2002:a17:907:e8c:b0:b7a:6178:2b4a with SMTP id
 a640c23a62f3a-b8426aa1d98mr181020766b.26.1767666431704; Mon, 05 Jan 2026
 18:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
 <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com>
In-Reply-To: <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Tue, 6 Jan 2026 10:28:13 +0800
X-Gm-Features: AQt7F2oLSsYajmPV-3hp65iur-tCroW_vwKvfEYdwD7DAOjxNomRLVvnRs2XVt0
Message-ID: <CAOmEq9VtNQqC=OHqXwRaZPYXnOW89D+ahgxRSJBg8SCjzwN-6Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not sync fs when the fs is not yet fully mounted
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 12:16=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Sat, Dec 27, 2025 at 10:32=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [LOCKDEP WARNING]
> > There is a lockdep warning between qgroup related tree lock and
> > kernfs_rwsem.
> >
> > However the involved call chains show that the fs is being mounted
> > meanwhile the fs is also triggering sync_fs() from unmounting process:
>
> So we can have an unmount during mount?
> That sentence is confusing.
>
> >
> > WARNING: possible circular locking dependency detected
> > 6.18.0-dirty #1 Tainted: G           OE
> > ------------------------------------------------------
> > syz.0.279/4686 is trying to acquire lock:
> > ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> > mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
> > ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> > get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
> > ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> > lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
> >
> > but task is already holding lock:
> > ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
> > kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893
> >
> > which lock already depends on the new lock.
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #7 (&root->kernfs_rwsem){++++}-{4:4}:
> >       down_write+0x91/0x210 kernel/locking/rwsem.c:1590
> >       kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
> >       kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
> >       sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
> >       create_dir lib/kobject.c:73 [inline]
> >       kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
> >       kobject_add_varg lib/kobject.c:374 [inline]
> >       kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
> >       btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
> >       btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
> >       open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
> >       btrfs_fill_super fs/btrfs/super.c:987 [inline]
> >       btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
> >       btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
> >       btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
> >       vfs_get_tree+0x9a/0x370 fs/super.c:1758
> >       fc_mount fs/namespace.c:1199 [inline] <<<<
> >       do_new_mount_fc fs/namespace.c:3642 [inline]
> >       do_new_mount fs/namespace.c:3718 [inline]
> >       path_mount+0x5aa/0x1e90 fs/namespace.c:4028
> >       do_mount fs/namespace.c:4041 [inline]
> >       __do_sys_mount fs/namespace.c:4229 [inline]
> >       __se_sys_mount fs/namespace.c:4206 [inline]
> >       __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
> >       x64_sys_call+0x1a7d/0x26a0
> > arch/x86/include/generated/asm/syscalls_64.h:166
> >       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >       do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
> >       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > -> #6 (btrfs-quota-00){++++}-{4:4}:
> >       down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
> >       btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
> >       btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
> >       btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
> >       btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
> >       btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
> >       update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
> >       btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
> >       commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
> >       btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:245=
9
> >       btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
> >       sync_filesystem fs/sync.c:66 [inline]
> >       sync_filesystem+0x1ba/0x260 fs/sync.c:30
> >       generic_shutdown_super+0x88/0x520 fs/super.c:621 <<<<
> >       kill_anon_super+0x41/0x80 fs/super.c:1288
> >       btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
> >       deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
> >       deactivate_super fs/super.c:506 [inline]
> >       deactivate_super+0xad/0xd0 fs/super.c:502
> >       cleanup_mnt+0x214/0x460 fs/namespace.c:1318
> >       __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
> >       task_work_run+0x16a/0x270 kernel/task_work.c:227
> >       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline=
]
> >       exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
> >       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [i=
nline]
> >       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [=
inline]
> >       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inlin=
e]
> >       do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
> >       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Can you please paste the whole lockdep splat?
> This misses several stack traces and the report at the bottom with the
> detected lock dependencies:

Sure. The full lockdep splat from the original report can be found here:
https://lore.kernel.org/all/CAOmEq9WKw2_Xq4hEMZte=3DZdMiXphWJW7759untUxc19Q=
8iOj5A@mail.gmail.com/

Thanks,
ZhengYuan Huang

