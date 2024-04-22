Return-Path: <linux-btrfs+bounces-4472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDCC8AD0A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12A21F23041
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48154153823;
	Mon, 22 Apr 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAgxud/O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E72152E04
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799685; cv=none; b=IxODJKTLTfbKaHR4LdoFN7TURiuLW92KEtMdz8FjV/GKiDkwawH08JodAeWp+jMrnOq854983S4Tc04i6nRV3GhHsEgDnmllLHIKLnV5waUY1pTlGnQrlTOvxP1Z96F//IzuIs/ntHERMSoZDsA51QAtQGDgp2Iu6MD1y+JNVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799685; c=relaxed/simple;
	bh=EVUXWUc1bhb7ukoQhsC5Lo8229688WZtpt+HdWIbvGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWyD0oRsdiGFCtXfEu2Oli7+ZpFhSpqaQt5gwDQ/iav3xzszbtVtOcBnhHR/yHRACHK+4mUvIf/cGh+ZoYkMpNjl+Qorvt6nB8mYpweMnBcy2yRVobpeJZtPXgMmGx31Ixi/45evQw82X5+EAwHCa8yLf+0OhX10+nA5Dofd2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAgxud/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F6C32783
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799685;
	bh=EVUXWUc1bhb7ukoQhsC5Lo8229688WZtpt+HdWIbvGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vAgxud/O66PnqlZfcFk9tIe9xGMX16UBIDWVjqgkwhpkjkab2SFGeJclC2BOVpP3D
	 DDUMKkn57c1tbPxDStFnvsmbwXw2HFJ0Bs5gKjltTNp2qAXVNjgY/8LVZyfe+qILOJ
	 PJ3OF8NC7Fdd1fGWClDNb4vqUd1aUpLC1KObDm0fBPlwqPP97tmo5cCOjx3tWZPm1w
	 Fk1VBfzoaStdTJ2/xhsK7ZswCHJM5gfPqS685wJHEYrYkQg96NZJ9XaT6Uu8qGbk6l
	 Ex2/VsH39HhFo3/DQOz3uin9XIf9DnrSHVE1Y/+hEYf7QwXYNnfcCdXuoY8GtL/xkW
	 GtDPts/RvG5gA==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34b029296f5so1263104f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 08:28:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWxQnuZA2WyD1S7WWDoFPYUIN8vSfJEd/IEVIfIJnLrbfn2OW5
	JRvPVcoys0kw8RUY85SAOXkTKeGeCgUbknq9arXBtzrvAwVlxfC7XNe5pzT2rbfn3mwvpIWpne8
	lXlbcqGoiAlt9Vuf1DjcXjBpUQCQ=
X-Google-Smtp-Source: AGHT+IEGHJFd2jVRddx85xNxhe46K63thhd0iiwaoDWVHyD+VYQr5XXyOy6LacQXMO/Vlp9gsBKaVWxI/6IIDO8U+Tc=
X-Received: by 2002:adf:b197:0:b0:349:f83f:9ebf with SMTP id
 q23-20020adfb197000000b00349f83f9ebfmr8625043wra.5.1713799683483; Mon, 22 Apr
 2024 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a78874868a1d3d8d78e6b0fdbb97debc88923734.1713573156.git.josef@toxicpanda.com>
In-Reply-To: <a78874868a1d3d8d78e6b0fdbb97debc88923734.1713573156.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 22 Apr 2024 16:27:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7it7OhnC=AHYS7s=V0UZTPUPiZQBZ11AixmQqAqPnDUQ@mail.gmail.com>
Message-ID: <CAL3q7H7it7OhnC=AHYS7s=V0UZTPUPiZQBZ11AixmQqAqPnDUQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: take the cleaner_mutex earlier in qgroup disable
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 1:33=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> One of my CI runs popped the following lockdep splat
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.9.0-rc4+ #1 Not tainted
> ------------------------------------------------------
> btrfs/471533 is trying to acquire lock:
> ffff92ba46980850 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_quota_d=
isable+0x54/0x4c0
>
> but task is already holding lock:
> ffff92ba46980bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x1c=
8f/0x2600
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&fs_info->subvol_sem){++++}-{3:3}:
>        down_read+0x42/0x170
>        btrfs_rename+0x607/0xb00
>        btrfs_rename2+0x2e/0x70
>        vfs_rename+0xaf8/0xfc0
>        do_renameat2+0x586/0x600
>        __x64_sys_rename+0x43/0x50
>        do_syscall_64+0x95/0x180
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> -> #1 (&sb->s_type->i_mutex_key#16){++++}-{3:3}:
>        down_write+0x3f/0xc0
>        btrfs_inode_lock+0x40/0x70
>        prealloc_file_extent_cluster+0x1b0/0x370
>        relocate_file_extent_cluster+0xb2/0x720
>        relocate_data_extent+0x107/0x160
>        relocate_block_group+0x442/0x550
>        btrfs_relocate_block_group+0x2cb/0x4b0
>        btrfs_relocate_chunk+0x50/0x1b0
>        btrfs_balance+0x92f/0x13d0
>        btrfs_ioctl+0x1abf/0x2600
>        __x64_sys_ioctl+0x97/0xd0
>        do_syscall_64+0x95/0x180
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> -> #0 (&fs_info->cleaner_mutex){+.+.}-{3:3}:
>        __lock_acquire+0x13e7/0x2180
>        lock_acquire+0xcb/0x2e0
>        __mutex_lock+0xbe/0xc00
>        btrfs_quota_disable+0x54/0x4c0
>        btrfs_ioctl+0x206b/0x2600
>        __x64_sys_ioctl+0x97/0xd0
>        do_syscall_64+0x95/0x180
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> other info that might help us debug this:
>
> Chain exists of:
>   &fs_info->cleaner_mutex --> &sb->s_type->i_mutex_key#16 --> &fs_info->s=
ubvol_sem
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&fs_info->subvol_sem);
>                                lock(&sb->s_type->i_mutex_key#16);
>                                lock(&fs_info->subvol_sem);
>   lock(&fs_info->cleaner_mutex);
>
>  *** DEADLOCK ***
>
> 2 locks held by btrfs/471533:
>  #0: ffff92ba4319e420 (sb_writers#14){.+.+}-{0:0}, at: btrfs_ioctl+0x3b5/=
0x2600
>  #1: ffff92ba46980bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl=
+0x1c8f/0x2600
>
> stack backtrace:
> CPU: 1 PID: 471533 Comm: btrfs Kdump: loaded Not tainted 6.9.0-rc4+ #1
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x77/0xb0
>  check_noncircular+0x148/0x160
>  ? lock_acquire+0xcb/0x2e0
>  __lock_acquire+0x13e7/0x2180
>  lock_acquire+0xcb/0x2e0
>  ? btrfs_quota_disable+0x54/0x4c0
>  ? lock_is_held_type+0x9a/0x110
>  __mutex_lock+0xbe/0xc00
>  ? btrfs_quota_disable+0x54/0x4c0
>  ? srso_return_thunk+0x5/0x5f
>  ? lock_acquire+0xcb/0x2e0
>  ? btrfs_quota_disable+0x54/0x4c0
>  ? btrfs_quota_disable+0x54/0x4c0
>  btrfs_quota_disable+0x54/0x4c0
>  btrfs_ioctl+0x206b/0x2600
>  ? srso_return_thunk+0x5/0x5f
>  ? __do_sys_statfs+0x61/0x70
>  __x64_sys_ioctl+0x97/0xd0
>  do_syscall_64+0x95/0x180
>  ? srso_return_thunk+0x5/0x5f
>  ? reacquire_held_locks+0xd1/0x1f0
>  ? do_user_addr_fault+0x307/0x8a0
>  ? srso_return_thunk+0x5/0x5f
>  ? lock_acquire+0xcb/0x2e0
>  ? srso_return_thunk+0x5/0x5f
>  ? srso_return_thunk+0x5/0x5f
>  ? find_held_lock+0x2b/0x80
>  ? srso_return_thunk+0x5/0x5f
>  ? lock_release+0xca/0x2a0
>  ? srso_return_thunk+0x5/0x5f
>  ? do_user_addr_fault+0x35c/0x8a0
>  ? srso_return_thunk+0x5/0x5f
>  ? trace_hardirqs_off+0x4b/0xc0
>  ? srso_return_thunk+0x5/0x5f
>  ? lockdep_hardirqs_on_prepare+0xde/0x190
>  ? srso_return_thunk+0x5/0x5f
>
> This happens because when we call rename we already have the inode mutex
> held, and then we acquire the subvol_sem if we are a subvolume.  This
> makes the dependency
>
> inode lock -> subvol sem
>
> When we're running data relocation we will preallocate space for the
> data relocation inode, and we always run the relocation under the
> ->cleaner_mutex.  This now creates the dependency of
>
> cleaner_mutex -> inode lock (from the prealloc) -> subvol_sem
>
> Qgroup delete is doing this in the opposite order, it is acquiring the
> subvol_sem and then it is acquiring the cleaner_mutex, which results in
> this lockdep splat.  This deadlock can't happen in reality, because we
> won't ever rename the data reloc inode, nor is the data reloc inode a
> subvolume.
>
> However this is fairly easy to fix, simply take the cleaner mutex in the
> case where we are disabling qgroups before we take the subvol_sem.  This
> resolves the lockdep splat.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c  | 20 +++++++++++++++++---
>  fs/btrfs/qgroup.c | 21 ++++++++-------------
>  2 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0c977b7cc253..494f4d1dc38d 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3758,15 +3758,30 @@ static long btrfs_ioctl_quota_ctl(struct file *fi=
le, void __user *arg)
>                 goto drop_write;
>         }
>
> -       down_write(&fs_info->subvol_sem);
> -
>         switch (sa->cmd) {
>         case BTRFS_QUOTA_CTL_ENABLE:
>         case BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA:
> +               down_write(&fs_info->subvol_sem);
>                 ret =3D btrfs_quota_enable(fs_info, sa);
> +               up_write(&fs_info->subvol_sem);
>                 break;
>         case BTRFS_QUOTA_CTL_DISABLE:
> +               /*
> +                * Lock the cleaner mutex to prevent races with concurren=
t
> +                * relocation, because relocation may be building backref=
s for
> +                * blocks of the quota root while we are deleting the roo=
t. This
> +                * is like dropping fs roots of deleted snapshots/subvolu=
mes, we
> +                * need the same protection.
> +                *
> +                * This also prevents races between concurrent tasks tryi=
ng to
> +                * disable quotas, because we will unlock and relock
> +                * qgroup_ioctl_lock across BTRFS_FS_QUOTA_ENABLED change=
s.
> +                */
> +               mutex_lock(&fs_info->cleaner_mutex);
> +               down_write(&fs_info->subvol_sem);

Everything is correct and makes sense.

I'm afraid in the future someone looking into this code after the
patch is merged, will wonder why we have this duplicated locking of
the
subvol_sem in each case of the switch statement and then decide "ah
let's get rid of this duplicated code and make the locking before the
switch and the unlocking after".

So just a comment saying we must lock the cleaner_mutex before
subvol_sem to avoid a lockdep splat would be enough to discourage
that.
Just a suggestion.

Anyway, it looks good so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                 ret =3D btrfs_quota_disable(fs_info);
> +               up_write(&fs_info->subvol_sem);
> +               mutex_unlock(&fs_info->cleaner_mutex);
>                 break;
>         default:
>                 ret =3D -EINVAL;
> @@ -3774,7 +3789,6 @@ static long btrfs_ioctl_quota_ctl(struct file *file=
, void __user *arg)
>         }
>
>         kfree(sa);
> -       up_write(&fs_info->subvol_sem);
>  drop_write:
>         mnt_drop_write_file(file);
>         return ret;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9a9f84c4d3b8..7d48ecf9ee7f 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1342,16 +1342,10 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_=
info)
>         lockdep_assert_held_write(&fs_info->subvol_sem);
>
>         /*
> -        * Lock the cleaner mutex to prevent races with concurrent reloca=
tion,
> -        * because relocation may be building backrefs for blocks of the =
quota
> -        * root while we are deleting the root. This is like dropping fs =
roots
> -        * of deleted snapshots/subvolumes, we need the same protection.
> -        *
> -        * This also prevents races between concurrent tasks trying to di=
sable
> -        * quotas, because we will unlock and relock qgroup_ioctl_lock ac=
ross
> -        * BTRFS_FS_QUOTA_ENABLED changes.
> +        * Relocation will mess with backrefs, so make sure we have the
> +        * cleaner_mutex held to protect us from relocate.
>          */
> -       mutex_lock(&fs_info->cleaner_mutex);
> +       lockdep_assert_held(&fs_info->cleaner_mutex);
>
>         mutex_lock(&fs_info->qgroup_ioctl_lock);
>         if (!fs_info->quota_root)
> @@ -1373,9 +1367,13 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_i=
nfo)
>         clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
>         btrfs_qgroup_wait_for_completion(fs_info, false);
>
> +       /*
> +        * We have nothing held here and no trans handle, just return the=
 error
> +        * if there is one.
> +        */
>         ret =3D flush_reservations(fs_info);
>         if (ret)
> -               goto out_unlock_cleaner;
> +               return ret;
>
>         /*
>          * 1 For the root item
> @@ -1439,9 +1437,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_in=
fo)
>                 btrfs_end_transaction(trans);
>         else if (trans)
>                 ret =3D btrfs_commit_transaction(trans);
> -out_unlock_cleaner:
> -       mutex_unlock(&fs_info->cleaner_mutex);
> -
>         return ret;
>  }
>
> --
> 2.43.0
>
>

