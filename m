Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A499A2AB48B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgKIKNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:13:01 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77410C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:13:01 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so4217qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8tJw0rzfgg63w4OuaZJ+NGh/iJt4p0kwI1v5MvszGBg=;
        b=annY9wrBfN+nPD3PLgd7HX1rfx4Wn5f3THtH1S4V6Edd8VTQ0l3fFUqCToP6DH981Y
         KLfJkmPq44VtWjdPSkRV1MstFgVrYBKJBa0Tsvk3qZibIH2cRlj1h39G0w2efQ2+m+Yu
         SoRfSXo0Dwg8QIBUS/p1GpjC4PwvJX5yFVBkc53BLQxUW4iO2JYL5rpYO1vkLvhA/nE6
         IySkTPtONIfZ9PyJN4C9lmcV2p9WaLkGnOOomGlKvPgfewRa4HZSC91+vVBKdJ0/XFqD
         B3zMOkDZxAEZ8DV3gpFFVxu6vN2fmjuBvfMCCBFqtsX+IumG4y/cuVvJJIOltBffvtoR
         NEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8tJw0rzfgg63w4OuaZJ+NGh/iJt4p0kwI1v5MvszGBg=;
        b=K/G6/w7oHwZZOndSkDr+nEvZw9b97hB0zBpIl5ZeOpy4ZsBjI7cJDa214csjs/8rxI
         ovv2EyPzjpyRAx0Co3/4ojCqLIaBf700DkKJus/RoWa+KmKhjiU3V9uHn56G7Lru7HVG
         o1RQ0rhcjwQPo8YyOTkGoS0EoTiFeYysT/gMkfaYhFMwF8kcyLWLvRcTb8JUn/gNRju6
         JPFt6Ffb4PoVfk/2d2mkNLFf42MfQ3ewOUrBffeYtI5F8awcBpG+RB8SATkBg7Z2yg3J
         0dDTIaeSqQ8HnFcrXNFjXQWOo/K4N/KaUk5t4QW/GYhu3ns7PxZ3fqUmalFPMjglNLH+
         aY3A==
X-Gm-Message-State: AOAM532nD9cJjIYdZRi3spsMRrXDyrITOZttzFKnSvqcUwT/1TQ0JAOC
        pMgR/3iOYhKk7nPHUrW62fCWcGqz2R3gziu40l0MGpbq1wLzWg==
X-Google-Smtp-Source: ABdhPJxmcsPuyuqJG0UhLiQsTQoXMVA5QRdYX2bADe1u2nAFX0OOPF8oZMAB9pdfvCyf9YJrIwYAiwG4qx/+fy1oI2o=
X-Received: by 2002:a0c:99e6:: with SMTP id y38mr13449270qve.28.1604916780552;
 Mon, 09 Nov 2020 02:13:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <36b861f262858990f84eda72da6bb2e6762c41b7.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <36b861f262858990f84eda72da6bb2e6762c41b7.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:12:49 +0000
Message-ID: <CAL3q7H6KVTMJiu-=m=JM21anxgM6EFjsT1cC9=Kn8sFmg8LAZg@mail.gmail.com>
Subject: Re: [PATCH 2/8] btrfs: unlock to current level in btrfs_next_old_leaf
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Filipe reported the following lockdep splat
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.10.0-rc2-btrfs-next-71 #1 Not tainted
> ------------------------------------------------------
> find/324157 is trying to acquire lock:
> ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_l=
ock+0x32/0x1a0 [btrfs]
>
> but task is already holding lock:
> ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+=
0x32/0x1a0 [btrfs]
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (btrfs-tree-00){++++}-{3:3}:
>        lock_acquire+0xd8/0x490
>        down_write_nested+0x44/0x120
>        __btrfs_tree_lock+0x27/0x120 [btrfs]
>        btrfs_search_slot+0x2a3/0xc50 [btrfs]
>        btrfs_insert_empty_items+0x58/0xa0 [btrfs]
>        insert_with_overflow+0x44/0x110 [btrfs]
>        btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
>        btrfs_setxattr+0xd6/0x4c0 [btrfs]
>        btrfs_setxattr_trans+0x68/0x100 [btrfs]
>        __vfs_setxattr+0x66/0x80
>        __vfs_setxattr_noperm+0x70/0x200
>        vfs_setxattr+0x6b/0x120
>        setxattr+0x125/0x240
>        path_setxattr+0xba/0xd0
>        __x64_sys_setxattr+0x27/0x30
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
>        check_prev_add+0x91/0xc60
>        __lock_acquire+0x1689/0x3130
>        lock_acquire+0xd8/0x490
>        down_read_nested+0x45/0x220
>        __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>        btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>        btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>        iterate_dir+0x170/0x1c0
>        __x64_sys_getdents64+0x83/0x140
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-tree-00);
>                                lock(btrfs-tree-01#2/3);
>                                lock(btrfs-tree-00);
>   lock(btrfs-tree-01#2/3);
>
>  *** DEADLOCK ***
>
> 5 locks held by find/324157:
>  #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/=
0x60
>  #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterat=
e_dir+0x52/0x1c0
>  #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_rea=
d_lock+0x32/0x1a0 [btrfs]
>  #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_rea=
d_lock+0x32/0x1a0 [btrfs]
>  #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_=
lock+0x32/0x1a0 [btrfs]
>
> stack backtrace:
> CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-=
gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x8d/0xb5
>  check_noncircular+0xff/0x110
>  ? mark_lock.part.0+0x468/0xe90
>  check_prev_add+0x91/0xc60
>  __lock_acquire+0x1689/0x3130
>  ? kvm_clock_read+0x14/0x30
>  ? kvm_sched_clock_read+0x5/0x10
>  lock_acquire+0xd8/0x490
>  ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  down_read_nested+0x45/0x220
>  ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>  btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>  iterate_dir+0x170/0x1c0
>  __x64_sys_getdents64+0x83/0x140
>  ? filldir+0x1d0/0x1d0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> This happens because btrfs_next_old_leaf searches down to our current
> key, and then walks up the path until we can move to the next slot, and
> then reads back down the path so we get the next leaf.
>
> However it doesn't unlock any lower levels until it replaces them with
> the new extent buffer.  This is technically fine, but of course causes
> lockdep to complain, because we could be holding locks on lower levels
> while locking upper levels.
>
> Fix this by dropping all nodes below the level that we use as our new
> starting point before we start reading back down the path.  This also
> allows us to drop the NESTED magic, because we're no longer locking two
> nodes at the same level anymore.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks. It also survived a full weekend of tests and
didn't trigger the splat anymore.

> ---
>  fs/btrfs/ctree.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3a01e6e048c0..dcd17f7167d1 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -5327,6 +5327,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, st=
ruct btrfs_path *path,
>         struct btrfs_key key;
>         u32 nritems;
>         int ret;
> +       int i;
>
>         nritems =3D btrfs_header_nritems(path->nodes[0]);
>         if (nritems =3D=3D 0)
> @@ -5398,9 +5399,19 @@ int btrfs_next_old_leaf(struct btrfs_root *root, s=
truct btrfs_path *path,
>                         continue;
>                 }
>
> -               if (next) {
> -                       btrfs_tree_read_unlock(next);
> -                       free_extent_buffer(next);
> +
> +               /*
> +                * Our current level is where we're going to start from, =
and to
> +                * make sure lockdep doesn't complain we need to drop our=
 locks
> +                * and nodes from 0 to our current level.
> +                */
> +               for (i =3D 0; i < level; i++) {
> +                       if (path->locks[level]) {
> +                               btrfs_tree_read_unlock(path->nodes[i]);
> +                               path->locks[i] =3D 0;
> +                       }
> +                       free_extent_buffer(path->nodes[i]);
> +                       path->nodes[i] =3D NULL;
>                 }
>
>                 next =3D c;
> @@ -5429,22 +5440,14 @@ int btrfs_next_old_leaf(struct btrfs_root *root, =
struct btrfs_path *path,
>                                 cond_resched();
>                                 goto again;
>                         }
> -                       if (!ret) {
> -                               __btrfs_tree_read_lock(next,
> -                                                      BTRFS_NESTING_RIGH=
T,
> -                                                      path->recurse);
> -                       }
> +                       if (!ret)
> +                               btrfs_tree_read_lock(next);
>                 }
>                 break;
>         }
>         path->slots[level] =3D slot;
>         while (1) {
>                 level--;
> -               c =3D path->nodes[level];
> -               if (path->locks[level])
> -                       btrfs_tree_read_unlock(c);
> -
> -               free_extent_buffer(c);
>                 path->nodes[level] =3D next;
>                 path->slots[level] =3D 0;
>                 if (!path->skip_locking)
> @@ -5463,8 +5466,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, st=
ruct btrfs_path *path,
>                 }
>
>                 if (!path->skip_locking)
> -                       __btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
> -                                              path->recurse);
> +                       btrfs_tree_read_lock(next);
>         }
>         ret =3D 0;
>  done:
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
