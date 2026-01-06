Return-Path: <linux-btrfs+bounces-20177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C0CF99FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6192C3061B20
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC922749D5;
	Tue,  6 Jan 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS03is9V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79F336EE5
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719655; cv=none; b=lyjX7GyDLMnUaMDgFYW7IHlzoF5yZZBImonru0Gvs90cJopRkk5y5TRxA8TF0s0Gcsrxyss8YRFqI6TZcJSVdwdbwtviqDeJNsat7g1lRwDRDWgb92PlN9fussgjVpLQevkDGjYZxvVTJcqyiDO7xTObdY2v0/HbJBlaGNo9j9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719655; c=relaxed/simple;
	bh=msUSzllXab4ITg8zbaWS/xBuMGc1jOaKLv1yvcEjhkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hw/DqnvX2DcHQE6cg++/1Vr4szqy85w4UO4YXFs2jJHXeUPTFcxCXkjIgy9JvmyFeRTr+hMmHyL3bojuGkfHLT+L5XUzvyUdzYUVEDJcgIM6rfUeyBP82u7l7GHEQltZYCgwjwcWbhyJcZ7vY3lpgdP0yTEbcOJm3vpJ7dcFM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS03is9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBEBC16AAE
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767719652;
	bh=msUSzllXab4ITg8zbaWS/xBuMGc1jOaKLv1yvcEjhkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YS03is9V9VhhZlkSHNxEC/rggGhs/z1mrUAJjx/YLuHHCL84XNOldiXMWB0Xa93Tl
	 efIboyF/cqUpd6O4dGLjFe807bzsZfttp0eYpFZs7gswS2C4L1sqnS9dCdGMlBXPEc
	 5GdROEobL6V2t6xgxnxeTZ5npO+WSQjRRWF+BKqvMcLFZmKd2KfVMRSjS8ZA9s5gbx
	 qeB0D5Mu2Ig7uN0IVtJCb4tPR5Uh2Aq/LFMDnIahA6/lTqOL5uojHIqwvY9GX+yL9h
	 dusXbA1wlIAJKXrPPtj2PAmuPgnbjZIE0Gv+ETDAYGKYthHpNsX78CNAWDG38T5SX/
	 6/MV4kVZYjQyA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8440cb2dbeso39770866b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 09:14:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzN6POYwd7s2TfAQoGJHl5K7SsXc0PLSyuleUkFvDPMOKpmiu2u
	ZJAM+ZSDNf9OA6nU83mtOSIAmtwXFlnDqYuvNV6gjULsRRpmb7Au0jsRauURBGhzDwDCSlOuYwc
	xxcW+W3cJjqbiLcdZM49NVGa1J/HdtpQ=
X-Google-Smtp-Source: AGHT+IFrxr+VjCIdG9KEk8enFpeF9bKoighO4I4jibLVJF2ppmw9z8Hu4B+FkGEHtCf0dSd9zNUCeF5lI6va90yepxc=
X-Received: by 2002:a17:906:d551:b0:b80:3fb7:84f with SMTP id
 a640c23a62f3a-b8426bb8909mr394725366b.38.1767719651274; Tue, 06 Jan 2026
 09:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cdad50af2ac47b00bc1d81dfc97ad8776528d86.1766874707.git.wqu@suse.com>
 <CAL3q7H5rboRQD0GGAVHtGvcJcUnrOuJQuwEw1WfN6K-jzaT1cg@mail.gmail.com> <4d9ec144-0f04-46d7-8b52-e26b318f2f49@suse.com>
In-Reply-To: <4d9ec144-0f04-46d7-8b52-e26b318f2f49@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Jan 2026 17:13:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6MSe3U4RBOWBzvwq8res-ZwKXDrG8CnTmyXeo4WeFWAQ@mail.gmail.com>
X-Gm-Features: AQt7F2rebRmHQECHxxueGOB_EUPcAhzwLBvZc2Uecyui9Qpay3Qg_V3QsoqeMjE
Message-ID: <CAL3q7H6MSe3U4RBOWBzvwq8res-ZwKXDrG8CnTmyXeo4WeFWAQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not sync fs when the fs is not yet fully mounted
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, ZhengYuan Huang <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:43=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/1/6 02:45, Filipe Manana =E5=86=99=E9=81=93:
> > On Sat, Dec 27, 2025 at 10:32=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> [LOCKDEP WARNING]
> >> There is a lockdep warning between qgroup related tree lock and
> >> kernfs_rwsem.
> >>
> >> However the involved call chains show that the fs is being mounted
> >> meanwhile the fs is also triggering sync_fs() from unmounting process:
> >
> > So we can have an unmount during mount?
> > That sentence is confusing.
> >
> >>
> >> WARNING: possible circular locking dependency detected
> >> 6.18.0-dirty #1 Tainted: G           OE
> >> ------------------------------------------------------
> >> syz.0.279/4686 is trying to acquire lock:
> >> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> >> mmap_read_lock_killable include/linux/mmap_lock.h:377 [inline]
> >> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> >> get_mmap_lock_carefully mm/mmap_lock.c:378 [inline]
> >> ffff888014b4d7e0 (&mm->mmap_lock){++++}-{4:4}, at:
> >> lock_mm_and_find_vma+0x146/0x630 mm/mmap_lock.c:429
> >>
> >> but task is already holding lock:
> >> ffff88800aa8c188 (&root->kernfs_rwsem){++++}-{4:4}, at:
> >> kernfs_fop_readdir+0x146/0x860 fs/kernfs/dir.c:1893
> >>
> >> which lock already depends on the new lock.
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #7 (&root->kernfs_rwsem){++++}-{4:4}:
> >>        down_write+0x91/0x210 kernel/locking/rwsem.c:1590
> >>        kernfs_add_one+0x39/0x700 fs/kernfs/dir.c:791
> >>        kernfs_create_dir_ns+0x103/0x1a0 fs/kernfs/dir.c:1093
> >>        sysfs_create_dir_ns+0x143/0x2b0 fs/sysfs/dir.c:59
> >>        create_dir lib/kobject.c:73 [inline]
> >>        kobject_add_internal+0x24d/0xad0 lib/kobject.c:240
> >>        kobject_add_varg lib/kobject.c:374 [inline]
> >>        kobject_init_and_add+0x114/0x1a0 lib/kobject.c:457
> >>        btrfs_sysfs_add_one_qgroup+0xe2/0x170 fs/btrfs/sysfs.c:2599
> >>        btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
> >>        open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
> >>        btrfs_fill_super fs/btrfs/super.c:987 [inline]
> >>        btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
> >>        btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
> >>        btrfs_get_tree+0x114c/0x22e0 fs/btrfs/super.c:2128
> >>        vfs_get_tree+0x9a/0x370 fs/super.c:1758
> >>        fc_mount fs/namespace.c:1199 [inline] <<<<
> >>        do_new_mount_fc fs/namespace.c:3642 [inline]
> >>        do_new_mount fs/namespace.c:3718 [inline]
> >>        path_mount+0x5aa/0x1e90 fs/namespace.c:4028
> >>        do_mount fs/namespace.c:4041 [inline]
> >>        __do_sys_mount fs/namespace.c:4229 [inline]
> >>        __se_sys_mount fs/namespace.c:4206 [inline]
> >>        __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
> >>        x64_sys_call+0x1a7d/0x26a0
> >> arch/x86/include/generated/asm/syscalls_64.h:166
> >>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>        do_syscall_64+0x91/0xa90 arch/x86/entry/syscall_64.c:94
> >>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> -> #6 (btrfs-quota-00){++++}-{4:4}:
> >>        down_read_nested+0xa0/0x4d0 kernel/locking/rwsem.c:1662
> >>        btrfs_tree_read_lock_nested+0x32/0x1d0 fs/btrfs/locking.c:145
> >>        btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
> >>        btrfs_read_lock_root_node+0x73/0xb0 fs/btrfs/locking.c:266
> >>        btrfs_search_slot_get_root fs/btrfs/ctree.c:1742 [inline]
> >>        btrfs_search_slot+0x3e0/0x3580 fs/btrfs/ctree.c:2066
> >>        update_qgroup_info_item fs/btrfs/qgroup.c:882 [inline]
> >>        btrfs_run_qgroups+0x4f3/0x870 fs/btrfs/qgroup.c:3112
> >>        commit_cowonly_roots+0x1f3/0x8f0 fs/btrfs/transaction.c:1354
> >>        btrfs_commit_transaction+0x1c64/0x3f70 fs/btrfs/transaction.c:2=
459
> >>        btrfs_sync_fs+0xf2/0x660 fs/btrfs/super.c:1057
> >>        sync_filesystem fs/sync.c:66 [inline]
> >>        sync_filesystem+0x1ba/0x260 fs/sync.c:30
> >>        generic_shutdown_super+0x88/0x520 fs/super.c:621 <<<<
> >>        kill_anon_super+0x41/0x80 fs/super.c:1288
> >>        btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
> >>        deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
> >>        deactivate_super fs/super.c:506 [inline]
> >>        deactivate_super+0xad/0xd0 fs/super.c:502
> >>        cleanup_mnt+0x214/0x460 fs/namespace.c:1318
> >>        __cleanup_mnt+0x1b/0x30 fs/namespace.c:1325
> >>        task_work_run+0x16a/0x270 kernel/task_work.c:227
> >>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inli=
ne]
> >>        exit_to_user_mode_loop+0x147/0x190 kernel/entry/common.c:43
> >>        exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 =
[inline]
> >>        syscall_exit_to_user_mode_work include/linux/entry-common.h:175=
 [inline]
> >>        syscall_exit_to_user_mode include/linux/entry-common.h:210 [inl=
ine]
> >>        do_syscall_64+0x3a0/0xa90 arch/x86/entry/syscall_64.c:100
> >>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Can you please paste the whole lockdep splat?
> > This misses several stack traces and the report at the bottom with the
> > detected lock dependencies:
> >
> >
> > Chain exists of:
> > &mm->mmap_lock --> btrfs-quota-00 --> &root->kernfs_rwsem
> >
> > Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> > rlock(&root->kernfs_rwsem);
> >                                lock(btrfs-quota-00);
> >                                lock(&root->kernfs_rwsem);
> > rlock(&mm->mmap_lock);
> >
> >>
> >> [CAUSE]
> >> At btrfs_sync_fs() we always assume the fs is already fully mounted, b=
ut
> >> if it's not the case we have more problems to bother other than just
> >> lockdep warnings.
> >
> > But how did you arrive at the conclusion that the fs is not already
> > fully mounted?
> > There are stack traces of mmap writes, which suggests the fs is fully
> > mounted (otherwise how could they happen?).
>
> The #7 call chain shows that we're still inside a mounting process:
>
>         ...
>          btrfs_read_qgroup_config+0x86f/0x1310 fs/btrfs/qgroup.c:488
>          open_ctree+0x3bda/0x6d60 fs/btrfs/disk-io.c:3592
>          btrfs_fill_super fs/btrfs/super.c:987 [inline]
>         ...
>
> But the #6 call chain shows it's during unmount.
>
>         sync_filesystem+0x1ba/0x260 fs/sync.c:30
>         generic_shutdown_super+0x88/0x520 fs/super.c:621
>         kill_anon_super+0x41/0x80 fs/super.c:1288
>         btrfs_kill_super+0x41/0x60 fs/btrfs/super.c:2134
>         deactivate_locked_super+0xb5/0x1a0 fs/super.c:473
>         deactivate_super fs/super.c:506 [inline]
>         deactivate_super+0xad/0xd0 fs/super.c:502
>         cleanup_mnt+0x214/0x460 fs/namespace.c:1318
>
> >
> > We may have a nested mount going on (like mounting the subvolume of an
> > already mounted fs into another mount point).
>
> That won't explain the lockdep report of lock chain #7.
>
> If we're mounting a subvolume of an already mounted btrfs, at the
> sget_fc() call inside btrfs_get_tree_super() would return an existing
> super block with s_root populated.
>
> And in that case we won't go through btrfs_fill_super().
>
> I'm even starting wondering if the original reporter has even modified
> their kernel to do something tricky on the VFS front.

I'm confused because there's the unmount triggering the sync, but on
the other hand one stack trace indicates we are doing a mount.
There's also the stack traces of mmap writes, which should only happen
for a fully mounted fs.


>
> Thanks,
> Qu
>
> >
> > To me it seems the best would be to call btrfs_sysfs_add_one_qgroup()
> > in btrfs_read_qgroup_config() after releasing the path, and then
> > search again in the quota tree for the next qgroup.
> >
> > Thanks.
> >
> >
> >>
> >> [FIX]
> >> Check if the target fs is fully mounted, if not skip btrfs_sync_fs()
> >> completely.
> >
> >
> >
> >>
> >> Reported-by: ZhengYuan Huang <gality369@gmail.com>
> >> Link: https://lore.kernel.org/linux-btrfs/CAOmEq9XdTN64=3DoE7na3J+vCG+=
fV2bFHSpprHswcE_wEfk_edNg@mail.gmail.com/
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/super.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >> index c141b7e1ee81..af98f622023f 100644
> >> --- a/fs/btrfs/super.c
> >> +++ b/fs/btrfs/super.c
> >> @@ -1013,6 +1013,9 @@ int btrfs_sync_fs(struct super_block *sb, int wa=
it)
> >>          struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> >>          struct btrfs_root *root =3D fs_info->tree_root;
> >>
> >> +       if (unlikely(!test_bit(BTRFS_FS_OPEN, &fs_info->flags)))
> >> +               return 0;
> >> +
> >>          trace_btrfs_sync_fs(fs_info, wait);
> >>
> >>          if (!wait) {
> >> --
> >> 2.52.0
> >>
> >>
>

