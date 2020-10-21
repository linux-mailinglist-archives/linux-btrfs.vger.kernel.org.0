Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EAA2950E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502995AbgJUQhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502992AbgJUQhL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 12:37:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25BC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 09:37:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z6so3126129qkz.4
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=y8yvTJKWEUzpwtetLp+HA2VNzWyiC4OHPiwNx9+O0Cg=;
        b=C8TKC95q06KWDqh9D7iAE0blxh5OaMeSya0hw2I69j6Twjht2hYqqYSqVvD/Ud3tMC
         x35O/Gggk+11NWEbdmlmwciKa04eFUw3SedShL3iRPhkapR5oX4kxiyrtBRomoZdzEmw
         wVH9x8pSkTbHLswPorig6NkVyz0bI9OzAaT86uRGvZ2NuC+6WN+M6NMJwV/jSOxVz+az
         7Vc+LqwT8iknuwHn4x7nRHMKubhHoopLHedsQvN0zJNV4olwIVDMJFEzr40xX7q6/wG6
         ejcJNZ4uj12mmOGVayyIos2HXwCv85Y7eY+WFBFMDZ24auAVo4EXiW4nulh7XhTdyOWi
         gGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=y8yvTJKWEUzpwtetLp+HA2VNzWyiC4OHPiwNx9+O0Cg=;
        b=Bm9VshVsj442D1nvdzsiYxbYZRueuWxRGov/epYqUfPBcD5QmDfU/VmKMgx9XXrtup
         r1qstNP0HRjLEqiZmZcFaln+sASQpm9tsNFSWSCjfGe9TFEnJz4o4PaZgAnKu2KJS5iq
         RCxfWJPtq5Xa17T5naYDoKVFRJ9lrYJypUoTJkJV2eJ7391VjO7+jlhxdLkXrqpxrfK9
         Ypw8AiDKbHufFn2efLrht+ANJzChuiMrenqxonkWS6oc3/6FkP8ZCzqIKHlWHZdXKL7t
         3w+3n/JFVs4/SBXhqv0ap4o3cWn/6wPVrsn7i1R07Vr1cQ6mG6veDPI9T0W8pwXHJsqU
         JhIw==
X-Gm-Message-State: AOAM533+Cm4/vaD+qde+MynlQMu7cxwQvUHb6PaDILysEey41k0UZL4S
        5ZQ40C3N6SQs3vaeasZ7Tk2k1kT6gP3UoET1RDH0IvzP
X-Google-Smtp-Source: ABdhPJzrFYtUGLeWerY2LVJpjvCuQsakNg3cVRX4lV0yMmyLTBoD29RAcBDZVYh5cMxOsZoRrWUODqIwtiD9XXVkj4g=
X-Received: by 2002:ae9:f444:: with SMTP id z4mr3863483qkl.338.1603298230308;
 Wed, 21 Oct 2020 09:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603137558.git.josef@toxicpanda.com> <64816a7abd985112ddd7c44998753f72b5775a1a.1603137558.git.josef@toxicpanda.com>
 <CAL3q7H5bbi181sM3=BCtKTM2VgFnc-+tjeqLWZm+H4qOK6CSZw@mail.gmail.com> <a8d95c31-4456-72b4-ec30-daab2fd27569@toxicpanda.com>
In-Reply-To: <a8d95c31-4456-72b4-ec30-daab2fd27569@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 21 Oct 2020 17:36:59 +0100
Message-ID: <CAL3q7H7aq9omPHwXYcqK+Cqt5L_deAi-6GLF1Z7ExxX7gPo99Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: protect the fs_info->caching_block_groups differently
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 3:05 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 10/20/20 6:10 AM, Filipe Manana wrote:
> > On Tue, Oct 20, 2020 at 8:36 AM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> I got the following lockdep splat
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >> WARNING: possible circular locking dependency detected
> >> 5.9.0+ #101 Not tainted
> >> ------------------------------------------------------
> >> btrfs-cleaner/3445 is trying to acquire lock:
> >> ffff89dbec39ab48 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lo=
ck+0x32/0x170
> >>
> >> but task is already holding lock:
> >> ffff89dbeaf28a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_fi=
nd_all_roots+0x41/0x80
> >>
> >> which lock already depends on the new lock.
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #2 (&fs_info->commit_root_sem){++++}-{3:3}:
> >>         down_write+0x3d/0x70
> >>         btrfs_cache_block_group+0x2d5/0x510
> >>         find_free_extent+0xb6e/0x12f0
> >>         btrfs_reserve_extent+0xb3/0x1b0
> >>         btrfs_alloc_tree_block+0xb1/0x330
> >>         alloc_tree_block_no_bg_flush+0x4f/0x60
> >>         __btrfs_cow_block+0x11d/0x580
> >>         btrfs_cow_block+0x10c/0x220
> >>         commit_cowonly_roots+0x47/0x2e0
> >>         btrfs_commit_transaction+0x595/0xbd0
> >>         sync_filesystem+0x74/0x90
> >>         generic_shutdown_super+0x22/0x100
> >>         kill_anon_super+0x14/0x30
> >>         btrfs_kill_super+0x12/0x20
> >>         deactivate_locked_super+0x36/0xa0
> >>         cleanup_mnt+0x12d/0x190
> >>         task_work_run+0x5c/0xa0
> >>         exit_to_user_mode_prepare+0x1df/0x200
> >>         syscall_exit_to_user_mode+0x54/0x280
> >>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> -> #1 (&space_info->groups_sem){++++}-{3:3}:
> >>         down_read+0x40/0x130
> >>         find_free_extent+0x2ed/0x12f0
> >>         btrfs_reserve_extent+0xb3/0x1b0
> >>         btrfs_alloc_tree_block+0xb1/0x330
> >>         alloc_tree_block_no_bg_flush+0x4f/0x60
> >>         __btrfs_cow_block+0x11d/0x580
> >>         btrfs_cow_block+0x10c/0x220
> >>         commit_cowonly_roots+0x47/0x2e0
> >>         btrfs_commit_transaction+0x595/0xbd0
> >>         sync_filesystem+0x74/0x90
> >>         generic_shutdown_super+0x22/0x100
> >>         kill_anon_super+0x14/0x30
> >>         btrfs_kill_super+0x12/0x20
> >>         deactivate_locked_super+0x36/0xa0
> >>         cleanup_mnt+0x12d/0x190
> >>         task_work_run+0x5c/0xa0
> >>         exit_to_user_mode_prepare+0x1df/0x200
> >>         syscall_exit_to_user_mode+0x54/0x280
> >>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> -> #0 (btrfs-root-00){++++}-{3:3}:
> >>         __lock_acquire+0x1167/0x2150
> >>         lock_acquire+0xb9/0x3d0
> >>         down_read_nested+0x43/0x130
> >>         __btrfs_tree_read_lock+0x32/0x170
> >>         __btrfs_read_lock_root_node+0x3a/0x50
> >>         btrfs_search_slot+0x614/0x9d0
> >>         btrfs_find_root+0x35/0x1b0
> >>         btrfs_read_tree_root+0x61/0x120
> >>         btrfs_get_root_ref+0x14b/0x600
> >>         find_parent_nodes+0x3e6/0x1b30
> >>         btrfs_find_all_roots_safe+0xb4/0x130
> >>         btrfs_find_all_roots+0x60/0x80
> >>         btrfs_qgroup_trace_extent_post+0x27/0x40
> >>         btrfs_add_delayed_data_ref+0x3fd/0x460
> >>         btrfs_free_extent+0x42/0x100
> >>         __btrfs_mod_ref+0x1d7/0x2f0
> >>         walk_up_proc+0x11c/0x400
> >>         walk_up_tree+0xf0/0x180
> >>         btrfs_drop_snapshot+0x1c7/0x780
> >>         btrfs_clean_one_deleted_snapshot+0xfb/0x110
> >>         cleaner_kthread+0xd4/0x140
> >>         kthread+0x13a/0x150
> >>         ret_from_fork+0x1f/0x30
> >>
> >> other info that might help us debug this:
> >>
> >> Chain exists of:
> >>    btrfs-root-00 --> &space_info->groups_sem --> &fs_info->commit_root=
_sem
> >>
> >>   Possible unsafe locking scenario:
> >>
> >>         CPU0                    CPU1
> >>         ----                    ----
> >>    lock(&fs_info->commit_root_sem);
> >>                                 lock(&space_info->groups_sem);
> >>                                 lock(&fs_info->commit_root_sem);
> >>    lock(btrfs-root-00);
> >>
> >>   *** DEADLOCK ***
> >>
> >> 3 locks held by btrfs-cleaner/3445:
> >>   #0: ffff89dbeaf28838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: clea=
ner_kthread+0x6e/0x140
> >>   #1: ffff89dbeb6c7640 (sb_internal){.+.+}-{0:0}, at: start_transactio=
n+0x40b/0x5c0
> >>   #2: ffff89dbeaf28a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: bt=
rfs_find_all_roots+0x41/0x80
> >>
> >> stack backtrace:
> >> CPU: 0 PID: 3445 Comm: btrfs-cleaner Not tainted 5.9.0+ #101
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-2.f=
c32 04/01/2014
> >> Call Trace:
> >>   dump_stack+0x8b/0xb0
> >>   check_noncircular+0xcf/0xf0
> >>   __lock_acquire+0x1167/0x2150
> >>   ? __bfs+0x42/0x210
> >>   lock_acquire+0xb9/0x3d0
> >>   ? __btrfs_tree_read_lock+0x32/0x170
> >>   down_read_nested+0x43/0x130
> >>   ? __btrfs_tree_read_lock+0x32/0x170
> >>   __btrfs_tree_read_lock+0x32/0x170
> >>   __btrfs_read_lock_root_node+0x3a/0x50
> >>   btrfs_search_slot+0x614/0x9d0
> >>   ? find_held_lock+0x2b/0x80
> >>   btrfs_find_root+0x35/0x1b0
> >>   ? do_raw_spin_unlock+0x4b/0xa0
> >>   btrfs_read_tree_root+0x61/0x120
> >>   btrfs_get_root_ref+0x14b/0x600
> >>   find_parent_nodes+0x3e6/0x1b30
> >>   btrfs_find_all_roots_safe+0xb4/0x130
> >>   btrfs_find_all_roots+0x60/0x80
> >>   btrfs_qgroup_trace_extent_post+0x27/0x40
> >>   btrfs_add_delayed_data_ref+0x3fd/0x460
> >>   btrfs_free_extent+0x42/0x100
> >>   __btrfs_mod_ref+0x1d7/0x2f0
> >>   walk_up_proc+0x11c/0x400
> >>   walk_up_tree+0xf0/0x180
> >>   btrfs_drop_snapshot+0x1c7/0x780
> >>   ? btrfs_clean_one_deleted_snapshot+0x73/0x110
> >>   btrfs_clean_one_deleted_snapshot+0xfb/0x110
> >>   cleaner_kthread+0xd4/0x140
> >>   ? btrfs_alloc_root+0x50/0x50
> >>   kthread+0x13a/0x150
> >>   ? kthread_create_worker_on_cpu+0x40/0x40
> >>   ret_from_fork+0x1f/0x30
> >>
> >> while testing another lockdep fix.  This happens because we're using t=
he
> >> commit_root_sem to protect fs_info->caching_block_groups, which create=
s
> >> a dependency on the groups_sem -> commit_root_sem, which is problemati=
c
> >> because we will allocate blocks while holding tree roots.  Fix this by
> >> making the list itself protected by the fs_info->block_group_cache_loc=
k.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/block-group.c | 12 ++++++------
> >>   fs/btrfs/extent-tree.c |  2 ++
> >>   2 files changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index 3ba6f3839d39..a8240913e6fc 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -796,10 +796,10 @@ int btrfs_cache_block_group(struct btrfs_block_g=
roup *cache, int load_cache_only
> >>                  return 0;
> >>          }
> >>
> >> -       down_write(&fs_info->commit_root_sem);
> >> +       spin_lock(&fs_info->block_group_cache_lock);
> >>          refcount_inc(&caching_ctl->count);
> >>          list_add_tail(&caching_ctl->list, &fs_info->caching_block_gro=
ups);
> >> -       up_write(&fs_info->commit_root_sem);
> >> +       spin_unlock(&fs_info->block_group_cache_lock);
> >>
> >>          btrfs_get_block_group(cache);
> >>
> >> @@ -1043,7 +1043,7 @@ int btrfs_remove_block_group(struct btrfs_trans_=
handle *trans,
> >>          if (block_group->cached =3D=3D BTRFS_CACHE_STARTED)
> >>                  btrfs_wait_block_group_cache_done(block_group);
> >>          if (block_group->has_caching_ctl) {
> >> -               down_write(&fs_info->commit_root_sem);
> >> +               spin_lock(&fs_info->block_group_cache_lock);
> >>                  if (!caching_ctl) {
> >>                          struct btrfs_caching_control *ctl;
> >>
> >> @@ -1057,7 +1057,7 @@ int btrfs_remove_block_group(struct btrfs_trans_=
handle *trans,
> >>                  }
> >>                  if (caching_ctl)
> >>                          list_del_init(&caching_ctl->list);
> >> -               up_write(&fs_info->commit_root_sem);
> >> +               spin_unlock(&fs_info->block_group_cache_lock);
> >>                  if (caching_ctl) {
> >>                          /* Once for the caching bgs list and once for=
 us. */
> >>                          btrfs_put_caching_control(caching_ctl);
> >> @@ -3307,14 +3307,14 @@ int btrfs_free_block_groups(struct btrfs_fs_in=
fo *info)
> >>          struct btrfs_caching_control *caching_ctl;
> >>          struct rb_node *n;
> >>
> >> -       down_write(&info->commit_root_sem);
> >> +       spin_lock(&info->block_group_cache_lock);
> >>          while (!list_empty(&info->caching_block_groups)) {
> >>                  caching_ctl =3D list_entry(info->caching_block_groups=
.next,
> >>                                           struct btrfs_caching_control=
, list);
> >>                  list_del(&caching_ctl->list);
> >>                  btrfs_put_caching_control(caching_ctl);
> >>          }
> >> -       up_write(&info->commit_root_sem);
> >> +       spin_unlock(&info->block_group_cache_lock);
> >>
> >>          spin_lock(&info->unused_bgs_lock);
> >>          while (!list_empty(&info->unused_bgs)) {
> >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> >> index 5fd60b13f4f8..ff2b5c132a70 100644
> >> --- a/fs/btrfs/extent-tree.c
> >> +++ b/fs/btrfs/extent-tree.c
> >> @@ -2738,6 +2738,7 @@ void btrfs_prepare_extent_commit(struct btrfs_fs=
_info *fs_info)
> >>
> >>          down_write(&fs_info->commit_root_sem);
> >>
> >> +       spin_lock(&fs_info->block_group_cache_lock);
> >
> > Why are we still doing the down_write on the commit_root_sem? It
> > doesn't seem necessary anymore (only for switching the commit roots
> > now).
>
> Because the commit_root_sem is doing something else here, it's protecting=
 the
> ->last_byte_to_unpin field.  We have to coordinate the end of the transac=
tion
> with the caching threads, but the list itself just needs to be protected =
with a
> spin_lock.  Thanks,

It's not clear what protects last_byte_to_unpin.
We have several places where we read or write to it without locking
commit_root_sem.

unpin_extent_range() reads it, called from finish_extent_commit(), but
doesn't take the lock - even though it's very unlikely to have races
in this case.
read_on_block_group() also reads it without commit_root_sem, however
this is only called during mount time, so it should be safe.
btrfs_cache_block_group() sets it without holding commit_root_sem, but
while holding the block group's spinlock.

It seems more intuitive to use the block group's spinlock to protect it.
And having a comment on top of the declaration of 'last_byte_to_unpin'
mentioning which lock protects it would be nice to have, or a comment
on top of the lock mentioning what it protects (or both), even if that
isn't strictly related to this patch.

We're highly inconsistent writing to and reading from
block_group->last_byte_to_unpin.

Why can't we just always use the block group's spinlock?

Anyway, it's not like there's something wrong that this patch is
introducing, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
