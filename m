Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E124243D7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhJFRTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 13:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFRTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 13:19:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D516C061746
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Oct 2021 10:17:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z40so1864241qko.7
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Oct 2021 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0hKiuiSjH8iYaXvdFeIHYwbnZprBduhul0eoRZjB5k8=;
        b=bs8gN6mGtI+3MlawjwjAYxkFoADtXuX8beedLSC3NlJ00g3khgwhmMUz4oM+K2wuU+
         WNZfFORiJr6MPb2TFgNDSiANJMvijgErxcrINIG8Gtc/4pjKGyvRtMf9LyBSEDd3GdKA
         ih4qALqZsxxsJHyPRBfQpMhefQIymQorI7nlIclremMKF0Ujb7Kk+X6bdBANG2hsBLS5
         2lYf1PJbwd9pC19HqxUUMFw8GU/YDA8l5YjXrXb0Ep2KsLTzFr7cCc3dpB5ZNyfDCgnN
         b0eWyXKFnO4yvbAyQilmzEakNhGnNINl/eNj44KyWFyImy/K9rpu72j8LnTm9ZXhfKTp
         Z0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0hKiuiSjH8iYaXvdFeIHYwbnZprBduhul0eoRZjB5k8=;
        b=THSHcoKB0XLGtTNchq4kyhE5Z09/r08Io2JOsgJgFCkKLH2StVltwG4yJw+xvzkiB0
         sNOeTSbJhm2pSqNSAVRWeuapextWz9OFIBZX86xtZsxOG/9XHxsH4Ba3x2aDf3A2vanu
         ljz9Mr8fmiSNzSSor8Qvja6U+Qi10/RqeOd3qPA4JGi/LaMS/Z5Z/gUB2O/AixNlHmgl
         bbK8CXbtX5PXoGI8riczekQ/JWTalLu4UxAdHpJDRlMA2raTJmd9Jf1LVegDEwVUtF9l
         I9ATX9n3FqoTzQkztsS1wVa9/zZqTmacJIp1NoJzDyReGTsbClfCTa0hIjTjzGIiWkHW
         NiKA==
X-Gm-Message-State: AOAM531d+Sl1lnffZ2PF4XOhuLoUgjGcS44t0dz10JwcLVA2JPAy1emV
        1KspoPAuijgG2cehMxA5K0DaCUhAEm/bgM78BiBDIh8moNc=
X-Google-Smtp-Source: ABdhPJwBliCt/wZZBZGPQjsubbziJSArYzeyKB/1MER2dkvxsh7UAbF1zzIHTyt+Jkys/25GuUm6JW47zhVoE0yRoQY=
X-Received: by 2002:a37:8287:: with SMTP id e129mr21248339qkd.415.1633540677402;
 Wed, 06 Oct 2021 10:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633465964.git.josef@toxicpanda.com> <e26773a5be8c7e52b6379343514c0b7eb46deb0e.1633465964.git.josef@toxicpanda.com>
In-Reply-To: <e26773a5be8c7e52b6379343514c0b7eb46deb0e.1633465964.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 6 Oct 2021 18:17:21 +0100
Message-ID: <CAL3q7H5k_rPczMOL1FzowgvkgbCXLnAWD8biC19jgQ5xv6Dzog@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] btrfs: change error handling for btrfs_delete_*_in_log
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 5, 2021 at 9:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Currently we will abort the transaction if we get a random error (like
> -EIO) while trying to remove the directory entries from the root log
> during rename.
>
> However since these are simply log tree related errors, we can mark the
> trans as needing a full commit.  Then if the error was truly
> catastrophic we'll hit it during the normal commit and abort as
> appropriate.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good, thanks.

> ---
>  fs/btrfs/inode.c    | 16 +++-------------
>  fs/btrfs/tree-log.c | 41 ++++++++++++++---------------------------
>  fs/btrfs/tree-log.h | 16 ++++++++--------
>  3 files changed, 25 insertions(+), 48 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 11ba673d195e..df716d1bd2f1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4116,19 +4116,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans=
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
> index 7a7fe0d74c35..a99aa57b8886 100644
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
