Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEA2A6CA6
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgKDS1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 13:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgKDS1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 13:27:19 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43674C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 10:27:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id a65so17986103qkg.13
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wlXDskYBFeMqpODx0Fqifjhpi2TS+M0BjpLUTT70XI4=;
        b=W3enVZXuajR5zGBx13+39sZdNpKKXmnEKndPyzHTtsvCSIdSsVAFksKEIHpf6mcas8
         pcBbLUvdjxQlNcfWp1BoGuTHlRCq3RVfwrfaD8HmLlYUva790LkY97xqTHepfSXQ0NrI
         5truad3eQd1ud70huoF2PrSC5we26p7T8aNVD2tNZ5B3XPGtQUh4wYjbhQFXBTtFgQ1i
         m3jgf2kaUB8Md9hwplUKhKr/lSMaBlRcaMo2oRuEfrKI2gCoKlXUZrazdi53SBI7V9NW
         9qcjvZl40aNAA1a75dCr08EQmwSPaAjAbHBuMSP+zjdZz2E1ZP7MB5h81AVJZnW79ETt
         bfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wlXDskYBFeMqpODx0Fqifjhpi2TS+M0BjpLUTT70XI4=;
        b=k+38ESlwcXcQ4YvGffIUqegKz8m4wCtKE9zVhpSDanYluS4HKHJ4dswjyr7CesHiRB
         nwO8/oKIIHvhRHf/TwPDJ4zaarLZBbZDvyO1Pw4kdsKZEZeCglLg3AWkf/CaXjJwwF1Y
         QFQz05YRqbFQ98VuaT6i8UZPTsQGdYZVuZ9AFje4IthFMdeIssTaXyqcsXu03LPlIfpE
         9o4yCinClZ2dvpcNm4HkRg6FKY7Xg3Jo2Tw/vYNmDsNlPIuC0m2ex2XdKtvilDYXOpMY
         7Snm1DJ9gsffmUQpvH80wjqNy6NqjSBGy2cvIEbHk4aBkZv/Vrj9Znf9UT9NEP0/Yqfn
         dGyA==
X-Gm-Message-State: AOAM531jNHoxNwYk3VSNXjOJK16wYOgNOhl74ZknLaGx++Or26zIyK6R
        JRIDDMrduUwAKzYUfyzujNUAns9pR7yCkVuQ05g=
X-Google-Smtp-Source: ABdhPJyZXpRAJts/bHXTTSAn9FT6ht7mZTlkS3HpHyBWp5Tgjc4yeT6Q4masQUXEzfuOcV+lWpSWGRyfxElfvgoMEi4=
X-Received: by 2002:a37:9cd3:: with SMTP id f202mr26140953qke.479.1604514437883;
 Wed, 04 Nov 2020 10:27:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <7f656118637ade71f45d1a3faca617ccbea9f61f.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <7f656118637ade71f45d1a3faca617ccbea9f61f.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 18:27:06 +0000
Message-ID: <CAL3q7H4bxVp_=mfz+5F6pwLuRHferY=o5gytL7cxkU68cqGNaw@mail.gmail.com>
Subject: Re: [PATCH 8/8] btrfs: protect the fs_info->caching_block_groups differently
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:13 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> I got the following lockdep splat
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.9.0+ #101 Not tainted
> ------------------------------------------------------
> btrfs-cleaner/3445 is trying to acquire lock:
> ffff89dbec39ab48 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+=
0x32/0x170
>
> but task is already holding lock:
> ffff89dbeaf28a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_find_=
all_roots+0x41/0x80
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&fs_info->commit_root_sem){++++}-{3:3}:
>        down_write+0x3d/0x70
>        btrfs_cache_block_group+0x2d5/0x510
>        find_free_extent+0xb6e/0x12f0
>        btrfs_reserve_extent+0xb3/0x1b0
>        btrfs_alloc_tree_block+0xb1/0x330
>        alloc_tree_block_no_bg_flush+0x4f/0x60
>        __btrfs_cow_block+0x11d/0x580
>        btrfs_cow_block+0x10c/0x220
>        commit_cowonly_roots+0x47/0x2e0
>        btrfs_commit_transaction+0x595/0xbd0
>        sync_filesystem+0x74/0x90
>        generic_shutdown_super+0x22/0x100
>        kill_anon_super+0x14/0x30
>        btrfs_kill_super+0x12/0x20
>        deactivate_locked_super+0x36/0xa0
>        cleanup_mnt+0x12d/0x190
>        task_work_run+0x5c/0xa0
>        exit_to_user_mode_prepare+0x1df/0x200
>        syscall_exit_to_user_mode+0x54/0x280
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #1 (&space_info->groups_sem){++++}-{3:3}:
>        down_read+0x40/0x130
>        find_free_extent+0x2ed/0x12f0
>        btrfs_reserve_extent+0xb3/0x1b0
>        btrfs_alloc_tree_block+0xb1/0x330
>        alloc_tree_block_no_bg_flush+0x4f/0x60
>        __btrfs_cow_block+0x11d/0x580
>        btrfs_cow_block+0x10c/0x220
>        commit_cowonly_roots+0x47/0x2e0
>        btrfs_commit_transaction+0x595/0xbd0
>        sync_filesystem+0x74/0x90
>        generic_shutdown_super+0x22/0x100
>        kill_anon_super+0x14/0x30
>        btrfs_kill_super+0x12/0x20
>        deactivate_locked_super+0x36/0xa0
>        cleanup_mnt+0x12d/0x190
>        task_work_run+0x5c/0xa0
>        exit_to_user_mode_prepare+0x1df/0x200
>        syscall_exit_to_user_mode+0x54/0x280
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #0 (btrfs-root-00){++++}-{3:3}:
>        __lock_acquire+0x1167/0x2150
>        lock_acquire+0xb9/0x3d0
>        down_read_nested+0x43/0x130
>        __btrfs_tree_read_lock+0x32/0x170
>        __btrfs_read_lock_root_node+0x3a/0x50
>        btrfs_search_slot+0x614/0x9d0
>        btrfs_find_root+0x35/0x1b0
>        btrfs_read_tree_root+0x61/0x120
>        btrfs_get_root_ref+0x14b/0x600
>        find_parent_nodes+0x3e6/0x1b30
>        btrfs_find_all_roots_safe+0xb4/0x130
>        btrfs_find_all_roots+0x60/0x80
>        btrfs_qgroup_trace_extent_post+0x27/0x40
>        btrfs_add_delayed_data_ref+0x3fd/0x460
>        btrfs_free_extent+0x42/0x100
>        __btrfs_mod_ref+0x1d7/0x2f0
>        walk_up_proc+0x11c/0x400
>        walk_up_tree+0xf0/0x180
>        btrfs_drop_snapshot+0x1c7/0x780
>        btrfs_clean_one_deleted_snapshot+0xfb/0x110
>        cleaner_kthread+0xd4/0x140
>        kthread+0x13a/0x150
>        ret_from_fork+0x1f/0x30
>
> other info that might help us debug this:
>
> Chain exists of:
>   btrfs-root-00 --> &space_info->groups_sem --> &fs_info->commit_root_sem
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&fs_info->commit_root_sem);
>                                lock(&space_info->groups_sem);
>                                lock(&fs_info->commit_root_sem);
>   lock(btrfs-root-00);
>
>  *** DEADLOCK ***
>
> 3 locks held by btrfs-cleaner/3445:
>  #0: ffff89dbeaf28838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: cleaner_=
kthread+0x6e/0x140
>  #1: ffff89dbeb6c7640 (sb_internal){.+.+}-{0:0}, at: start_transaction+0x=
40b/0x5c0
>  #2: ffff89dbeaf28a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_=
find_all_roots+0x41/0x80
>
> stack backtrace:
> CPU: 0 PID: 3445 Comm: btrfs-cleaner Not tainted 5.9.0+ #101
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-2.fc32=
 04/01/2014
> Call Trace:
>  dump_stack+0x8b/0xb0
>  check_noncircular+0xcf/0xf0
>  __lock_acquire+0x1167/0x2150
>  ? __bfs+0x42/0x210
>  lock_acquire+0xb9/0x3d0
>  ? __btrfs_tree_read_lock+0x32/0x170
>  down_read_nested+0x43/0x130
>  ? __btrfs_tree_read_lock+0x32/0x170
>  __btrfs_tree_read_lock+0x32/0x170
>  __btrfs_read_lock_root_node+0x3a/0x50
>  btrfs_search_slot+0x614/0x9d0
>  ? find_held_lock+0x2b/0x80
>  btrfs_find_root+0x35/0x1b0
>  ? do_raw_spin_unlock+0x4b/0xa0
>  btrfs_read_tree_root+0x61/0x120
>  btrfs_get_root_ref+0x14b/0x600
>  find_parent_nodes+0x3e6/0x1b30
>  btrfs_find_all_roots_safe+0xb4/0x130
>  btrfs_find_all_roots+0x60/0x80
>  btrfs_qgroup_trace_extent_post+0x27/0x40
>  btrfs_add_delayed_data_ref+0x3fd/0x460
>  btrfs_free_extent+0x42/0x100
>  __btrfs_mod_ref+0x1d7/0x2f0
>  walk_up_proc+0x11c/0x400
>  walk_up_tree+0xf0/0x180
>  btrfs_drop_snapshot+0x1c7/0x780
>  ? btrfs_clean_one_deleted_snapshot+0x73/0x110
>  btrfs_clean_one_deleted_snapshot+0xfb/0x110
>  cleaner_kthread+0xd4/0x140
>  ? btrfs_alloc_root+0x50/0x50
>  kthread+0x13a/0x150
>  ? kthread_create_worker_on_cpu+0x40/0x40
>  ret_from_fork+0x1f/0x30
>
> while testing another lockdep fix.  This happens because we're using the
> commit_root_sem to protect fs_info->caching_block_groups, which creates
> a dependency on the groups_sem -> commit_root_sem, which is problematic
> because we will allocate blocks while holding tree roots.  Fix this by
> making the list itself protected by the fs_info->block_group_cache_lock.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c | 12 ++++++------
>  fs/btrfs/transaction.c |  2 ++
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index ba6564f67d9a..f19fabae4754 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -747,10 +747,10 @@ int btrfs_cache_block_group(struct btrfs_block_grou=
p *cache, int load_cache_only
>         cache->has_caching_ctl =3D 1;
>         spin_unlock(&cache->lock);
>
> -       down_write(&fs_info->commit_root_sem);
> +       spin_lock(&fs_info->block_group_cache_lock);
>         refcount_inc(&caching_ctl->count);
>         list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups)=
;
> -       up_write(&fs_info->commit_root_sem);
> +       spin_unlock(&fs_info->block_group_cache_lock);
>
>         btrfs_get_block_group(cache);
>
> @@ -999,7 +999,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handl=
e *trans,
>         if (block_group->cached =3D=3D BTRFS_CACHE_STARTED)
>                 btrfs_wait_block_group_cache_done(block_group);
>         if (block_group->has_caching_ctl) {
> -               down_write(&fs_info->commit_root_sem);
> +               spin_lock(&fs_info->block_group_cache_lock);
>                 if (!caching_ctl) {
>                         struct btrfs_caching_control *ctl;
>
> @@ -1013,7 +1013,7 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
>                 }
>                 if (caching_ctl)
>                         list_del_init(&caching_ctl->list);
> -               up_write(&fs_info->commit_root_sem);
> +               spin_unlock(&fs_info->block_group_cache_lock);
>                 if (caching_ctl) {
>                         /* Once for the caching bgs list and once for us.=
 */
>                         btrfs_put_caching_control(caching_ctl);
> @@ -3311,14 +3311,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info =
*info)
>         struct btrfs_caching_control *caching_ctl;
>         struct rb_node *n;
>
> -       down_write(&info->commit_root_sem);
> +       spin_lock(&info->block_group_cache_lock);
>         while (!list_empty(&info->caching_block_groups)) {
>                 caching_ctl =3D list_entry(info->caching_block_groups.nex=
t,
>                                          struct btrfs_caching_control, li=
st);
>                 list_del(&caching_ctl->list);
>                 btrfs_put_caching_control(caching_ctl);
>         }
> -       up_write(&info->commit_root_sem);
> +       spin_unlock(&info->block_group_cache_lock);
>
>         spin_lock(&info->unused_bgs_lock);
>         while (!list_empty(&info->unused_bgs)) {
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 9ef6cba1eb59..a0cf0e0c4085 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -208,6 +208,7 @@ static noinline void switch_commit_roots(struct btrfs=
_trans_handle *trans)
>          * the caching thread will re-start it's search from 3, and thus =
find
>          * the hole from [4,6) to add to the free space cache.
>          */
> +       spin_lock(&fs_info->block_group_cache_lock);
>         list_for_each_entry_safe(caching_ctl, next,
>                                  &fs_info->caching_block_groups, list) {
>                 struct btrfs_block_group *cache =3D caching_ctl->block_gr=
oup;
> @@ -219,6 +220,7 @@ static noinline void switch_commit_roots(struct btrfs=
_trans_handle *trans)
>                         cache->last_byte_to_unpin =3D caching_ctl->progre=
ss;
>                 }
>         }
> +       spin_unlock(&fs_info->block_group_cache_lock);
>         up_write(&fs_info->commit_root_sem);
>  }
>
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
