Return-Path: <linux-btrfs+bounces-20176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50DCF9900
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 18:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6F2E3035F4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38BE344029;
	Tue,  6 Jan 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggHF8AHZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B4F34321F
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719464; cv=none; b=Shtu51eo5m9GFSo5iasE5rpJN0KVuHAfFatfADYyWBxScoFJ6f+WcfHF+9VAzap88ch9b7eia5Nn+VNuUr7PbGPmVWYcQJ5uf7hNo+J0pFzluwwhPUttjZNCjcjrilqJXGWM87Z39L3azKirHkD83njJSTRKr3vp7vq5unKF/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719464; c=relaxed/simple;
	bh=krVfggCwbLeMkSakJbHxb3X1scxwTKsJlcUoju5Olkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCw0DEF4POdUzLJWcP2C0Em6IL13UKP27thvusuRPDCi9Zuz0QDWe4A41aGXeD/3Afsr+2/aJIJSRoNPxf5C5ndSud9HtfUn/vZqbzfsaQzIQLcl+CCmSWdA/sjvt43+4RIaoO7bkz1mepuN71qgyG5lpMJxIQTlnIxUjXtRDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggHF8AHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD862C19423
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767719461;
	bh=krVfggCwbLeMkSakJbHxb3X1scxwTKsJlcUoju5Olkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ggHF8AHZHpnWe0s1cKWJT+iyFrXciywR6na8j+0VtJ+AUWATqtrzsZtYaePY6zszH
	 644PWvgB2bOg2bPh6NEELTWpqExjIuxV3TndWVdDg1JUqxH6nk6Gg3DAhZ6pDUZwZ8
	 sLrlOWydqhoAkXYCPN+xwF5uXXx2AcFi0m7VpYMK5wubwgZNmEj9Yye7rfnBMNLYOe
	 oef/mCF9RQJ1zQzlmuCQawbx8rBcKknzdDy+a91T2MdV69JNGEG3LJkvXfCGORRP7N
	 eFPd9WdkI2T9j80oBtGP4HQR/SaCFGbfipamMUiTq9ubmS+vCHodffOEiVsLRza2ZB
	 AwrRfbLVdrkbA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b725ead5800so173079566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 09:11:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+9r/kFsVCzBC2McAoaVKTdp5IBcnx1me4EsvNA2LpjTjL/3NWibQufhbRLYCltE61PB9VBhyw2CapGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoc+4EWMxGGUPSBBk0ik8OvsWEviXQfbUmVmD7Ihj/KULMXZFK
	wYmOSeYDz4nCAb4B/7nRfIABeX+j94NaY6xQ04mDG0ZI6eT6EoDX4E/zMa9VdEn3/tlr8ukvtQJ
	KeutpbY0PLdmk8y71vKga39tk0dolc0w=
X-Google-Smtp-Source: AGHT+IHjx81B6iedW1kN7IlPDJZ7jmDMy4Xx+5fn8hOjGEE3dvpB4LVoYk7lBBpDzoBh3NmbG1kTLMwaZXbLNPTvzlo=
X-Received: by 2002:a17:907:1c85:b0:b84:2070:201c with SMTP id
 a640c23a62f3a-b8426c2afcdmr391462366b.54.1767719460420; Tue, 06 Jan 2026
 09:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
 <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com> <CAOmEq9VtNQqC=OHqXwRaZPYXnOW89D+ahgxRSJBg8SCjzwN-6Q@mail.gmail.com>
In-Reply-To: <CAOmEq9VtNQqC=OHqXwRaZPYXnOW89D+ahgxRSJBg8SCjzwN-6Q@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Jan 2026 17:10:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5=e1MveCGr6dfS553HQj7842_hPZfesZ3Df0u7pq1Hww@mail.gmail.com>
X-Gm-Features: AQt7F2oIY33xFC9HW4G9hedSioGUSt_I5Phm__YG-0G-SAaKHG5ucc-vSIN5_Yk
Message-ID: <CAL3q7H5=e1MveCGr6dfS553HQj7842_hPZfesZ3Df0u7pq1Hww@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not sync fs when the fs is not yet fully mounted
To: ZhengYuan Huang <gality369@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:27=E2=80=AFAM ZhengYuan Huang <gality369@gmail.com=
> wrote:
>
> On Tue, Jan 6, 2026 at 12:16=E2=80=AFAM Filipe Manana <fdmanana@kernel.or=
g> wrote:
> >
> > On Sat, Dec 27, 2025 at 10:32=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> > >
> > > [LOCKDEP WARNING]
> > > There is a lockdep warning between qgroup related tree lock and
> > > kernfs_rwsem.
> > >
> > > However the involved call chains show that the fs is being mounted
> > > meanwhile the fs is also triggering sync_fs() from unmounting process=
:
> >
> > So we can have an unmount during mount?
> > That sentence is confusing.
> >
> > >
> > > WARNING: possible circular locking dependency detected
> > > 6.18.0-dirty #1 Tainted: G           OE
> > > ------------------------------------------------------
> > > syz.0.279/4686 is trying to acquire lock:
> > > ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> > > mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
> > > ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> > > get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
> > > ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> > > lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
> > >
> > > but task is already holding lock:
> > > ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
> > > kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893
> > >
> > > which lock already depends on the new lock.
> > >
> > > the existing dependency chain (in reverse order) is:
> > >
> > > -> #7 (&root->kernfs_rwsem){++++}-{4:4}:
> > >       down_write+0x91/0x210 kernel/locking/rwsem.c:1590
> > >       kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
> > >       kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
> > >       sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
> > >       create_dir lib/kobject.c:73 [inline]
> > >       kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
> > >       kobject_add_varg lib/kobject.c:374 [inline]
> > >       kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
> > >       btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
> > >       btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
> > >       open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
> > >       btrfs_fill_super fs/btrfs/super.c:987 [inline]
> > >       btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
> > >       btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
> > >       btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
> > >       vfs_get_tree+0x9a/0x370 fs/super.c:1758
> > >       fc_mount fs/namespace.c:1199 [inline] <<<<
> > >       do_new_mount_fc fs/namespace.c:3642 [inline]
> > >       do_new_mount fs/namespace.c:3718 [inline]
> > >       path_mount+0x5aa/0x1e90 fs/namespace.c:4028
> > >       do_mount fs/namespace.c:4041 [inline]
> > >       __do_sys_mount fs/namespace.c:4229 [inline]
> > >       __se_sys_mount fs/namespace.c:4206 [inline]
> > >       __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
> > >       x64_sys_call+0x1a7d/0x26a0
> > > arch/x86/include/generated/asm/syscalls_64.h:166
> > >       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >       do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
> > >       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > -> #6 (btrfs-quota-00){++++}-{4:4}:
> > >       down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
> > >       btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
> > >       btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
> > >       btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
> > >       btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
> > >       btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
> > >       update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
> > >       btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
> > >       commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
> > >       btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:2=
459
> > >       btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
> > >       sync_filesystem fs/sync.c:66 [inline]
> > >       sync_filesystem+0x1ba/0x260 fs/sync.c:30
> > >       generic_shutdown_super+0x88/0x520 fs/super.c:621 <<<<
> > >       kill_anon_super+0x41/0x80 fs/super.c:1288
> > >       btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
> > >       deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
> > >       deactivate_super fs/super.c:506 [inline]
> > >       deactivate_super+0xad/0xd0 fs/super.c:502
> > >       cleanup_mnt+0x214/0x460 fs/namespace.c:1318
> > >       __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
> > >       task_work_run+0x16a/0x270 kernel/task_work.c:227
> > >       resume_user_mode_work include/linux/resume_user_mode.h:50 [inli=
ne]
> > >       exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
> > >       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 =
[inline]
> > >       syscall_exit_to_user_mode_work include/linux/entry-common.h:175=
 [inline]
> > >       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inl=
ine]
> > >       do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
> > >       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Can you please paste the whole lockdep splat?
> > This misses several stack traces and the report at the bottom with the
> > detected lock dependencies:
>
> Sure. The full lockdep splat from the original report can be found here:

Yes, I know it can be found there. There's a Link tag at the bottom of
the changelog.
That's how I got one of the important parts of the lockdep splat that
I pasted in the reply.

I'm asking to paste the whole thing in the changelog for completeness,
so that every time anyone reads the change log does not have to open a
link. This is a best practice we have.

> https://lore.kernel.org/all/CAOmEq9WKw2_Xq4hEMZte=3DZdMiXphWJW7759untUxc1=
9Q8iOj5A@mail.gmail.com/
>
> Thanks,
> ZhengYuan Huang

