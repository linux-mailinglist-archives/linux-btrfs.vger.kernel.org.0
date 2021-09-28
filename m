Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03441AC64
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhI1J4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbhI1J4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 05:56:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A83AC061575
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 02:54:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x12so6616883qkf.9
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jDe0aBXSsAZKcFoz8KaotPEMmPEw7KS9BZrivpd3czw=;
        b=YswZHIXQTcWhYE8vQdUIXtgRA6ZWqquJVOiH5FyAkH//xuwci47SQPBKa3ZJyCXVjt
         mhZ3zdOBSwnL5wDXCX/VtFXlaXphYXhguxmIZPfVxPXVffzWMrjEu1JFssmRS+01jyaP
         29h+Y6T1jQ15UBKj20GX+0Wax0pOuSzVSFjCJcK2SmTCYt3BBI3UcoJKACHb/p7L6nnQ
         fzKY4WfHDoF+71OdyAMAKf3uIPEed6L+XiyP9sJ51N77vhkDlQub88FmH3UhJLawbu0S
         lqrwpQEGXa13Kcnx0q2jh0TZgGHTw69jxmM5lMgH7V7YHIF9l+PfwC3xEQHV+eAttzYD
         bfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jDe0aBXSsAZKcFoz8KaotPEMmPEw7KS9BZrivpd3czw=;
        b=Cz97d5Gd/qgrNtLjwdo0tdzPugZ7jYlyCttzATuuhv1IPu+iRYJ2DHLujRCZuiuL7j
         Ixm+s4n81GmpMgBDoPpYE9cyArS+zqA4Sz07Nt2ijvrrkU8M92WisJpuPjTznZr0Bt8D
         WmzpHAe+Ip5DGycQ+v4STHBFJmjhUcnvPpQs2GJ/YZohfJkM+mSHPOe/4HU3sMLzBc1K
         TwGR0pKIN9T+0quyomt7u9xn1xkxXA6YzfuGqheLiiKKboUv+9E+qB0n/khAZW7ssAdF
         nW9Lrh2xayDaOkI8dBid/Mf4tDdFhi6PZV+yy5rYzQZLwT7uIe8gn/gFE5eHrxBEnRzi
         RV7g==
X-Gm-Message-State: AOAM531v/mH8fl86AxwrQStfARSy9BrmmZGynTVEBYK4QpO4R9SABBap
        J42nv9FAbdAGFhHtBK5DLbfNcGmHqXduE6SQ6KG3N5ZJKF8=
X-Google-Smtp-Source: ABdhPJyWa5Nm/WGBteib4S8nIDpo1Qe06auYg3xY9N8YLI0skxe/ALML09bn43Ke/rGvC3zqbcZnbMg4YMtvibg7lpA=
X-Received: by 2002:a37:8287:: with SMTP id e129mr4478162qkd.415.1632822866555;
 Tue, 28 Sep 2021 02:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632765815.git.josef@toxicpanda.com> <4df6bd8d64bf81e098101e35a0c7482485ef4e67.1632765815.git.josef@toxicpanda.com>
In-Reply-To: <4df6bd8d64bf81e098101e35a0c7482485ef4e67.1632765815.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 28 Sep 2021 10:53:50 +0100
Message-ID: <CAL3q7H51JuZL1JM-M9BSHq+byTrikj+mwcYKLEa2LkyGDv=+ng@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] btrfs: change error handling for btrfs_delete_*_in_log
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 7:06 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Currently we will abort the transaction if we get a random error (like
> -EIO) while trying to remove the directory entries from the root log
> during rename.
>
> However the log sync stuff doesn't actually honor the transaction abort
> flag, it'll happily commit the log even if we've aborted the transaction
> for reasons related to the log, which is a pretty bad problem.

I'm not seeing how that would happen.
Since your commit 165ea85f14831f ("btrfs: do not write supers if we
have an fs error"), log syncing actually checks if a transaction was
aborted, and skips the log commit.
We're also aborting the transaction while holding the log pinned.
So I don't see how we can end up committing an inconsistent log if any
of the calls to remove dirents from the log fails.

Maybe this patch was prepared before that other patch?

Either way it seems the change log needs to be updated, because log
syncing checks for transaction aborts / fs error state.

>
> Fix this by making these functions void, as we don't actually care if
> this fails.  Instead mark the log as requiring a full commit on error.

This makes sense, there's really no need to abort a transaction,
forcing the next log commit attempt to fallback to a transaction
commit is more than enough.

> This will keep us from committing this bad log, and if we fsync we'll
> force a full transaction commit and have a consistent file system.

Codewise it looks good, I just don't think the part of committing a
bad log can happen after that other commit.

Thanks.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/inode.c    | 16 +++-------------
>  fs/btrfs/tree-log.c | 41 ++++++++++++++---------------------------
>  fs/btrfs/tree-log.h | 16 ++++++++--------
>  3 files changed, 25 insertions(+), 48 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a643be30c18a..03a843b9659b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4108,19 +4108,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans=
_handle *trans,
>                 goto err;
>         }
>
> -       ret =3D btrfs_del_inode_ref_in_log(trans, root, name, name_len, i=
node,
> -                       dir_ino);
> -       if (ret !=3D 0 && ret !=3D -ENOENT) {
> -               btrfs_abort_transaction(trans, ret);
> -               goto err;
> -       }
> -
> -       ret =3D btrfs_del_dir_entries_in_log(trans, root, name, name_len,=
 dir,
> -                       index);
> -       if (ret =3D=3D -ENOENT)
> -               ret =3D 0;
> -       else if (ret)
> -               btrfs_abort_transaction(trans, ret);
> +       btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
> +                                  dir_ino);
> +       btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir, in=
dex);
>
>         /*
>          * If we have a pending delayed iput we could end up with the fin=
al iput
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index e0c2d4c7f939..720723611875 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3500,10 +3500,10 @@ static bool inode_logged(struct btrfs_trans_handl=
e *trans,
>   * This optimizations allows us to avoid relogging the entire inode
>   * or the entire directory.
>   */
> -int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
> -                                struct btrfs_root *root,
> -                                const char *name, int name_len,
> -                                struct btrfs_inode *dir, u64 index)
> +void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
> +                                 struct btrfs_root *root,
> +                                 const char *name, int name_len,
> +                                 struct btrfs_inode *dir, u64 index)
>  {
>         struct btrfs_root *log;
>         struct btrfs_dir_item *di;
> @@ -3513,11 +3513,11 @@ int btrfs_del_dir_entries_in_log(struct btrfs_tra=
ns_handle *trans,
>         u64 dir_ino =3D btrfs_ino(dir);
>
>         if (!inode_logged(trans, dir))
> -               return 0;
> +               return;
>
>         ret =3D join_running_log_trans(root);
>         if (ret)
> -               return 0;
> +               return;
>
>         mutex_lock(&dir->log_mutex);
>
> @@ -3565,49 +3565,36 @@ int btrfs_del_dir_entries_in_log(struct btrfs_tra=
ns_handle *trans,
>         btrfs_free_path(path);
>  out_unlock:
>         mutex_unlock(&dir->log_mutex);
> -       if (err =3D=3D -ENOSPC) {
> +       if (err < 0 && err !=3D -ENOENT)
>                 btrfs_set_log_full_commit(trans);
> -               err =3D 0;
> -       } else if (err < 0 && err !=3D -ENOENT) {
> -               /* ENOENT can be returned if the entry hasn't been fsynce=
d yet */
> -               btrfs_abort_transaction(trans, err);
> -       }
> -
>         btrfs_end_log_trans(root);
> -
> -       return err;
>  }
>
>  /* see comments for btrfs_del_dir_entries_in_log */
> -int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
> -                              struct btrfs_root *root,
> -                              const char *name, int name_len,
> -                              struct btrfs_inode *inode, u64 dirid)
> +void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
> +                               struct btrfs_root *root,
> +                               const char *name, int name_len,
> +                               struct btrfs_inode *inode, u64 dirid)
>  {
>         struct btrfs_root *log;
>         u64 index;
>         int ret;
>
>         if (!inode_logged(trans, inode))
> -               return 0;
> +               return;
>
>         ret =3D join_running_log_trans(root);
>         if (ret)
> -               return 0;
> +               return;
>         log =3D root->log_root;
>         mutex_lock(&inode->log_mutex);
>
>         ret =3D btrfs_del_inode_ref(trans, log, name, name_len, btrfs_ino=
(inode),
>                                   dirid, &index);
>         mutex_unlock(&inode->log_mutex);
> -       if (ret =3D=3D -ENOSPC) {
> +       if (ret < 0 && ret !=3D -ENOENT)
>                 btrfs_set_log_full_commit(trans);
> -               ret =3D 0;
> -       } else if (ret < 0 && ret !=3D -ENOENT)
> -               btrfs_abort_transaction(trans, ret);
>         btrfs_end_log_trans(root);
> -
> -       return ret;
>  }
>
>  /*
> diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
> index 3ce6bdb76009..f6811c3df38a 100644
> --- a/fs/btrfs/tree-log.h
> +++ b/fs/btrfs/tree-log.h
> @@ -70,14 +70,14 @@ int btrfs_recover_log_trees(struct btrfs_root *tree_r=
oot);
>  int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
>                           struct dentry *dentry,
>                           struct btrfs_log_ctx *ctx);
> -int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
> -                                struct btrfs_root *root,
> -                                const char *name, int name_len,
> -                                struct btrfs_inode *dir, u64 index);
> -int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
> -                              struct btrfs_root *root,
> -                              const char *name, int name_len,
> -                              struct btrfs_inode *inode, u64 dirid);
> +void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
> +                                 struct btrfs_root *root,
> +                                 const char *name, int name_len,
> +                                 struct btrfs_inode *dir, u64 index);
> +void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
> +                               struct btrfs_root *root,
> +                               const char *name, int name_len,
> +                               struct btrfs_inode *inode, u64 dirid);
>  void btrfs_end_log_trans(struct btrfs_root *root);
>  void btrfs_pin_log_trans(struct btrfs_root *root);
>  void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
