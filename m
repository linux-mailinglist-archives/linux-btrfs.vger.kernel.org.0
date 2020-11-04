Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23F2A6737
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgKDPPl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgKDPPl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 10:15:41 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE6C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 07:15:41 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 63so10047915qva.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=KV31ypVG14i8G50OmIq1qUf1AO/F8JwbqD5OpKu6u/Q=;
        b=ex2XJhkY1ce/Mo+/wvSiqfwWF1pf1NANeX5OL2wSl+ZiHb8eJczI2HN14A37soiVMX
         Pn4CJ7XF/bl/5RE0lb4UIbcRRS1NWvJTyKTtoUE52+JUPPUOuHUlgSq6u0VaLEKSqmoO
         SjyKqhVaSuU+f6mJ+ZVBoCnF5wKq5J+ZEP9OdcE7DdUIXEwisAB3ef7B0KSgYURCzAyQ
         r74zcBo+9oi2r4Hd2iqZ++wPymQfX9hb5g2jqtvYu6p8qVDLEkY/2KPaXKy4ZWCwJb/E
         7AomyZHjF8PyhS3oPFrtNYCpFROmtIffFeXjEeWi1GP/Y5afRKncXWdVAG5lHCOxaPNY
         tA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=KV31ypVG14i8G50OmIq1qUf1AO/F8JwbqD5OpKu6u/Q=;
        b=X0nFzvWFLmrZdzV5RRM/mdYSpMqZBzrKuzsjlWhWzjPDbzl9BLCyrITPVbIzZZhCZS
         AIOvB5Qvd5YXEau4n8HvXkTlVM5ar7PqP8f7V0yOkayIwPQlm1bU8Vbl2EWiIf7aHuyA
         7L6bA+yARdGXUcUPYaaG9sGLqVPS055xaNow6BVbLx6lqBe7M3KLlBnbxi6OeTtOKTQE
         CKlGQanDD9A5+iNqDhiPo4DaijZvJXo3Fk8NfD/BHQXc8Hg/AktHIu1wlVnmwU6lxYWK
         7LIiSxZBuzb1KBZnAUUmdcmIRMtfTnwlc/WFSqlcVkl/IBlXMNPEmF9ZhF/MnYuAMv+k
         cvtA==
X-Gm-Message-State: AOAM531W8Rpj90T23a0V9FJ23PzicvFoqnSgPk8KvPIhwijUFJlRVRP2
        HT5dBbfjaIwzmpJ4sDbtfkRwAc8CCtzB5Hg814Q=
X-Google-Smtp-Source: ABdhPJwfWrQH03v+MtLxTD8lONQe+YWXfvNJadRsdTDYRnzprIKkJ1YT2ucKzuk/qQokzZeyD7Zkm+LkYauicg7w8d8=
X-Received: by 2002:a0c:99e1:: with SMTP id y33mr12835814qve.62.1604502940187;
 Wed, 04 Nov 2020 07:15:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <f31bb86619489274227cae2184283f96a3b7bf36.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <f31bb86619489274227cae2184283f96a3b7bf36.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 15:15:28 +0000
Message-ID: <CAL3q7H54_ANFW6ZQoapzFb0i89zcAemjfxpgy6TsnYzLZdcNJg@mail.gmail.com>
Subject: Re: [PATCH 2/8] btrfs: update last_byte_to_unpin in switch_commit_roots
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While writing an explanation for the need of the commit_root_sem for
> btrfs_prepare_extent_commit, I realized we have a slight hole that could
> result in leaked space if we have to do the old style caching.  Consider
> the following scenario
>
>  commit root
>  +----+----+----+----+----+----+----+
>  |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
>  +----+----+----+----+----+----+----+
>  0    1    2    3    4    5    6    7
>
>  new commit root
>  +----+----+----+----+----+----+----+
>  |    |    |    |\\\\|    |    |\\\\|
>  +----+----+----+----+----+----+----+
>  0    1    2    3    4    5    6    7
>
> Prior to this patch, we run btrfs_prepare_extent_commit, which updates
> the last_byte_to_unpin, and then we subsequently run
> switch_commit_roots.  In this example lets assume that
> caching_ctl->progress =3D=3D 1 at btrfs_prepare_extent_commit() time, whi=
ch
> means that cache->last_byte_to_unpin =3D=3D 1.  Then we go and do the
> switch_commit_roots(), but in the meantime the caching thread has made
> some more progress, because we drop the commit_root_sem and re-acquired
> it.  Now caching_ctl->progress =3D=3D 3.  We swap out the commit root and
> carry on to unpin.

Ok, to unpin at btrfs_finish_extent_commit().

So it took me a while to see the race:

1) The caching thread was running using the old commit root when it
found the extent for [2, 3);

2) Then it released the commit_root_sem because it was in the last
item of a leaf and the semaphore was contended, and set ->progress to
3 (value of 'last'), as the last extent item in the current leaf was
for the extent for range [2, 3);

3) Next time it gets the commit_root_sem, will start using the new
commit root and search for a key with offset 3, so it never finds the
hole for [2, 3).

So the caching thread never saw [2, 3) as free space in any of the
commit roots, and by the time finish_extent_commit() was called for
the range [0, 3), ->last_byte_to_unpin was 1, so it only returned the
subrange [0, 1) to the free space cache, skipping [2, 3).

>
> In the unpin code we have last_byte_to_unpin =3D=3D 1, so we unpin [0,1),
> but do not unpin [2,3).
> However because caching_ctl->progress =3D=3D 3 we
> do not see the newly free'd section of [2,3), and thus do not add it to
> our free space cache.  This results in us missing a chunk of free space
> in memory.

In memory and on disk too, unless we have a power failure before
writing the free space cache to disk.

>
> Fix this by making sure the ->last_byte_to_unpin is set at the same time
> that we swap the commit roots, this ensures that we will always be
> consistent.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.h       |  1 -
>  fs/btrfs/extent-tree.c | 25 -------------------------
>  fs/btrfs/transaction.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8a83bce3225c..41c76db65c8e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2592,7 +2592,6 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info=
 *fs_info,
>                                u64 start, u64 len, int delalloc);
>  int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 star=
t,
>                               u64 len);
> -void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info);
>  int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
>  int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>                          struct btrfs_ref *generic_ref);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a98f484a2fc1..ee7bceace8b3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2730,31 +2730,6 @@ btrfs_inc_block_group_reservations(struct btrfs_bl=
ock_group *bg)
>         atomic_inc(&bg->reservations);
>  }
>
> -void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
> -{
> -       struct btrfs_caching_control *next;
> -       struct btrfs_caching_control *caching_ctl;
> -       struct btrfs_block_group *cache;
> -
> -       down_write(&fs_info->commit_root_sem);
> -
> -       list_for_each_entry_safe(caching_ctl, next,
> -                                &fs_info->caching_block_groups, list) {
> -               cache =3D caching_ctl->block_group;
> -               if (btrfs_block_group_done(cache)) {
> -                       cache->last_byte_to_unpin =3D (u64)-1;
> -                       list_del_init(&caching_ctl->list);
> -                       btrfs_put_caching_control(caching_ctl);
> -               } else {
> -                       cache->last_byte_to_unpin =3D caching_ctl->progre=
ss;
> -               }
> -       }
> -
> -       up_write(&fs_info->commit_root_sem);
> -
> -       btrfs_update_global_block_rsv(fs_info);
> -}
> -
>  /*
>   * Returns the free cluster for the given space info and sets empty_clus=
ter to
>   * what it should be based on the mount options.
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 52ada47aff50..9ef6cba1eb59 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -155,6 +155,7 @@ static noinline void switch_commit_roots(struct btrfs=
_trans_handle *trans)
>         struct btrfs_transaction *cur_trans =3D trans->transaction;
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_root *root, *tmp;
> +       struct btrfs_caching_control *caching_ctl, *next;
>
>         down_write(&fs_info->commit_root_sem);
>         list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
> @@ -180,6 +181,44 @@ static noinline void switch_commit_roots(struct btrf=
s_trans_handle *trans)
>                 spin_lock(&cur_trans->dropped_roots_lock);
>         }
>         spin_unlock(&cur_trans->dropped_roots_lock);
> +
> +       /*
> +        * We have to update the last_byte_to_unpin under the commit_root=
_sem,
> +        * at the same time we swap out the commit roots.
> +        *
> +        * This is because we must have a real view of the last spot the =
caching
> +        * kthreads were while caching.  Consider the following views of =
the
> +        * extent tree for a block group
> +        *
> +        * commit root
> +        * +----+----+----+----+----+----+----+
> +        * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> +        * +----+----+----+----+----+----+----+
> +        * 0    1    2    3    4    5    6    7
> +        *
> +        * new commit root
> +        * +----+----+----+----+----+----+----+
> +        * |    |    |    |\\\\|    |    |\\\\|
> +        * +----+----+----+----+----+----+----+
> +        * 0    1    2    3    4    5    6    7
> +        *
> +        * If the cache_ctl->progress was at 3, then we are only allowed =
to
> +        * unpin [0,1) and [2,3], because the caching thread has already
> +        * processed those extents.  We are not allowed to unpin [5,6), b=
ecause
> +        * the caching thread will re-start it's search from 3, and thus =
find
> +        * the hole from [4,6) to add to the free space cache.
> +        */
> +       list_for_each_entry_safe(caching_ctl, next,
> +                                &fs_info->caching_block_groups, list) {
> +               struct btrfs_block_group *cache =3D caching_ctl->block_gr=
oup;
> +               if (btrfs_block_group_done(cache)) {
> +                       cache->last_byte_to_unpin =3D (u64)-1;
> +                       list_del_init(&caching_ctl->list);
> +                       btrfs_put_caching_control(caching_ctl);
> +               } else {
> +                       cache->last_byte_to_unpin =3D caching_ctl->progre=
ss;
> +               }
> +       }
>         up_write(&fs_info->commit_root_sem);
>  }
>
> @@ -2293,8 +2332,6 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans)
>                 goto unlock_tree_log;
>         }
>
> -       btrfs_prepare_extent_commit(fs_info);
> -
>         cur_trans =3D fs_info->running_transaction;
>
>         btrfs_set_root_node(&fs_info->tree_root->root_item,
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
