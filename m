Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECAB293999
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392470AbgJTLGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393449AbgJTLGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 07:06:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB111C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 04:06:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z6so1185760qkz.4
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5yXXYLWZnyh6XMtwapjhTVkesuuBn3kUaJbLKJaUJCY=;
        b=JGTVi7OLHctkvcOopvZbLl4Sbxphpp4z0PBcRqT3CDKUkKhi0sTzP4Fn8v2lZixzhY
         vuAeFPT1JSQrnbr5ENZvG/mKzkCFslkbbrMaGaoPt7+77jVw0I65yY8EQTLW3pVzpswJ
         XkAIpCJwFFRvvBOoYNNnpN/xemgkelszuiI6GP5LZm9ys0HAIYDjgBfefmDJ6YzRxZz7
         1+kIyC9mmpI6GngdqQOgoer+qBKEGByEHFPPb0MzOJU5eo4CDAmbvFvklC+PIqEIT+B/
         EAastKHWofKtcwAVD36JZribErQEXVAT65on7bn1F06cZ8UryOSZOfCK7GdkRBMJC+4y
         BM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5yXXYLWZnyh6XMtwapjhTVkesuuBn3kUaJbLKJaUJCY=;
        b=fSFNb7Z3pRJFFnkZBxWKQUKqLRNAD1oSob76cMf5RDJp9sJpqQntFgv4Gc8Cy4xNkJ
         c2WF3ZFjXTZ95Ro8+1TRU7StUg0+erRSX2vECqIMajf0hYK95GkNt/L4oFt5Hs1+zoIw
         sRpQFXOCZrwMgl8szsO2qEA578DdmvskzBnTearlZhMJ288MGT2vikfnQmqvwJkS53a3
         WbGoA2Kz9thdZX7FuSixoqYb5icerpFwIrxV1mvSxc5tGiMm/R+4ht8xTbezx/8A/gqi
         ZQgpTE6y0PtgAalbDgnlHpUwkqzCiAVnyn0qlrBHCyJkqeJ19LBC0y/jPmHcVXDNA5Ey
         +Bkg==
X-Gm-Message-State: AOAM532zItBETD1kLku5Jnw2ffKcEv5onzt+FRWu6kmzr3JD/AVHe47E
        rLnZ2zuQLccqzENdb6WtVWn0OB7bP+5wIB5WXkM=
X-Google-Smtp-Source: ABdhPJy+jbisR0TcoWYoOPpfwW971K1+smR8moaLloLiG6Rxz9+0quD7mJXah/I7Xoy7QzVFaFJjKRP86UtLxFoaBPg=
X-Received: by 2002:a05:620a:1426:: with SMTP id k6mr2184802qkj.438.1603192006913;
 Tue, 20 Oct 2020 04:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603137558.git.josef@toxicpanda.com> <2402f8ee46e0e080f9c22115b7ba3a02962ded4e.1603137558.git.josef@toxicpanda.com>
In-Reply-To: <2402f8ee46e0e080f9c22115b7ba3a02962ded4e.1603137558.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 20 Oct 2020 12:06:35 +0100
Message-ID: <CAL3q7H6ESjQPYCYwAa-_rQ3bUO67BqLAe8=tg_kYiTzM9FdOCA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: add a helper to read the tree_root commit root
 for backref lookup
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 20, 2020 at 8:37 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> I got the following lockdep splat with my rwsem patches on btrfs/104
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.9.0+ #102 Not tainted
> ------------------------------------------------------
> btrfs-cleaner/903 is trying to acquire lock:
> ffff8e7fab6ffe30 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+=
0x32/0x170
>
> but task is already holding lock:
> ffff8e7fab628a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_find_=
all_roots+0x41/0x80
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (&fs_info->commit_root_sem){++++}-{3:3}:
>        down_read+0x40/0x130
>        caching_thread+0x53/0x5a0
>        btrfs_work_helper+0xfa/0x520
>        process_one_work+0x238/0x540
>        worker_thread+0x55/0x3c0
>        kthread+0x13a/0x150
>        ret_from_fork+0x1f/0x30
>
> -> #2 (&caching_ctl->mutex){+.+.}-{3:3}:
>        __mutex_lock+0x7e/0x7b0
>        btrfs_cache_block_group+0x1e0/0x510
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
>   btrfs-root-00 --> &caching_ctl->mutex --> &fs_info->commit_root_sem
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&fs_info->commit_root_sem);
>                                lock(&caching_ctl->mutex);
>                                lock(&fs_info->commit_root_sem);
>   lock(btrfs-root-00);
>
>  *** DEADLOCK ***
>
> 3 locks held by btrfs-cleaner/903:
>  #0: ffff8e7fab628838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: cleaner_=
kthread+0x6e/0x140
>  #1: ffff8e7faadac640 (sb_internal){.+.+}-{0:0}, at: start_transaction+0x=
40b/0x5c0
>  #2: ffff8e7fab628a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_=
find_all_roots+0x41/0x80
>
> stack backtrace:
> CPU: 0 PID: 903 Comm: btrfs-cleaner Not tainted 5.9.0+ #102
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
> BTRFS info (device sdb): disk space caching is enabled
> BTRFS info (device sdb): has skinny extents
>
> This happens because qgroups does a backref lookup when we create a
> delayed ref.  From here it may have to look up a root from an indirect
> ref, which does a normal lookup on the tree_root, which takes the read
> lock on the tree_root nodes.
>
> To fix this we need to add a variant for looking up roots that searches
> the commit root of the tree_root.  Then when we do the backref search
> using the commit root we are sure to not take any locks on the tree_root
> nodes.  This gets rid of the lockdep splat when running btrfs/104.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good, only the first comment line at the top of the new function
btrfs_get_fs_root_commit_root() doesn't follow the preferred style.

Other than that, it's fine as far as I can see.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/backref.c | 14 +++++++-
>  fs/btrfs/disk-io.c | 79 ++++++++++++++++++++++++++++++++++------------
>  fs/btrfs/disk-io.h |  3 ++
>  3 files changed, 74 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index b3268f4ea5f3..cacba965c535 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -544,7 +544,19 @@ static int resolve_indirect_ref(struct btrfs_fs_info=
 *fs_info,
>         int level =3D ref->level;
>         struct btrfs_key search_key =3D ref->key_for_search;
>
> -       root =3D btrfs_get_fs_root(fs_info, ref->root_id, false);
> +       /*
> +        * If we're search_commit_root we could possibly be holding locks=
 on
> +        * other tree nodes.  This happens when qgroups does backref walk=
s when
> +        * adding new delayed refs.  To deal with this we need to look in=
 cache
> +        * for the root, and if we don't find it then we need to search t=
he
> +        * tree_root's commit root, thus the btrfs_get_fs_root_commit_roo=
t usage
> +        * here.
> +        */
> +       if (path->search_commit_root)
> +               root =3D btrfs_get_fs_root_commit_root(fs_info, path,
> +                                                    ref->root_id);
> +       else
> +               root =3D btrfs_get_fs_root(fs_info, ref->root_id, false);
>         if (IS_ERR(root)) {
>                 ret =3D PTR_ERR(root);
>                 goto out_free;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 81e7b1880b5b..3972f16b333d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1281,32 +1281,26 @@ int btrfs_add_log_tree(struct btrfs_trans_handle =
*trans,
>         return 0;
>  }
>
> -struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
> -                                       struct btrfs_key *key)
> +static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_ro=
ot,
> +                                             struct btrfs_path *path,
> +                                             struct btrfs_key *key)
>  {
>         struct btrfs_root *root;
>         struct btrfs_fs_info *fs_info =3D tree_root->fs_info;
> -       struct btrfs_path *path;
>         u64 generation;
>         int ret;
>         int level;
>
> -       path =3D btrfs_alloc_path();
> -       if (!path)
> -               return ERR_PTR(-ENOMEM);
> -
>         root =3D btrfs_alloc_root(fs_info, key->objectid, GFP_NOFS);
> -       if (!root) {
> -               ret =3D -ENOMEM;
> -               goto alloc_fail;
> -       }
> +       if (!root)
> +               return ERR_PTR(-ENOMEM);
>
>         ret =3D btrfs_find_root(tree_root, key, path,
>                               &root->root_item, &root->root_key);
>         if (ret) {
>                 if (ret > 0)
>                         ret =3D -ENOENT;
> -               goto find_fail;
> +               goto fail;
>         }
>
>         generation =3D btrfs_root_generation(&root->root_item);
> @@ -1317,21 +1311,30 @@ struct btrfs_root *btrfs_read_tree_root(struct bt=
rfs_root *tree_root,
>         if (IS_ERR(root->node)) {
>                 ret =3D PTR_ERR(root->node);
>                 root->node =3D NULL;
> -               goto find_fail;
> +               goto fail;
>         } else if (!btrfs_buffer_uptodate(root->node, generation, 0)) {
>                 ret =3D -EIO;
> -               goto find_fail;
> +               goto fail;
>         }
>         root->commit_root =3D btrfs_root_node(root);
> -out:
> -       btrfs_free_path(path);
>         return root;
> -
> -find_fail:
> +fail:
>         btrfs_put_root(root);
> -alloc_fail:
> -       root =3D ERR_PTR(ret);
> -       goto out;
> +       return ERR_PTR(ret);
> +}
> +
> +struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
> +                                       struct btrfs_key *key)
> +{
> +       struct btrfs_root *root;
> +       struct btrfs_path *path;
> +
> +       path =3D btrfs_alloc_path();
> +       if (!path)
> +               return ERR_PTR(-ENOMEM);
> +       root =3D read_tree_root_path(tree_root, path, key);
> +       btrfs_free_path(path);
> +       return root;
>  }
>
>  /*
> @@ -1621,6 +1624,40 @@ struct btrfs_root *btrfs_get_new_fs_root(struct bt=
rfs_fs_info *fs_info,
>         return btrfs_get_root_ref(fs_info, objectid, anon_dev, true);
>  }
>
> +/* btrfs_get_fs_root_commit_root - return a root for the given objectid
> + * @fs_info - the fs_info.
> + * @objectid =3D the objectid we need to lookup.
> + *
> + * This is exclusively used for backref walking, and exists specifically=
 because
> + * of how qgroups does lookups.  Qgroups will do a backref lookup at del=
ayed ref
> + * creation time, which means we may have to read the tree_root in order=
 to look
> + * up a fs root that is not in memory.  If the root is not in memory we =
will
> + * read the tree root commit root and look up the fs root from there.  T=
his is a
> + * temporary root, it will not be inserted into the radix tree as it doe=
sn't
> + * have the most uptodate information, it'll simply be discarded once th=
e
> + * backref code is finished using the root.
> + */
> +struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *f=
s_info,
> +                                                struct btrfs_path *path,
> +                                                u64 objectid)
> +{
> +       struct btrfs_root *root;
> +       struct btrfs_key key;
> +
> +       ASSERT(path->search_commit_root && path->skip_locking);
> +
> +       root =3D btrfs_lookup_fs_root(fs_info, objectid);
> +       if (root)
> +               return root;
> +
> +       key.objectid =3D objectid;
> +       key.type =3D BTRFS_ROOT_ITEM_KEY;
> +       key.offset =3D (u64)-1;
> +       root =3D read_tree_root_path(fs_info->tree_root, path, &key);
> +       btrfs_release_path(path);
> +       return root;
> +}
> +
>  /*
>   * called by the kthread helper functions to finally call the bio end_io
>   * functions.  This is where read checksum verification actually happens
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index fee69ced58b4..182540bdcea0 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -69,6 +69,9 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_in=
fo *fs_info,
>                                      u64 objectid, bool check_ref);
>  struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
>                                          u64 objectid, dev_t anon_dev);
> +struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *f=
s_info,
> +                                                struct btrfs_path *path,
> +                                                u64 objectid);
>
>  void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
>  int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
