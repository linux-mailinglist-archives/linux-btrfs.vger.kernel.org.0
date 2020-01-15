Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C513CA99
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAORNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:13:40 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33250 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAORNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:40 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so10905805vsa.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=or6og52WAzcHwbFjGhtwMlGLqMwGhkO0yUxAFAzASuA=;
        b=Q3mJDGZC8ihM0Dw6pek3DJYHRMyGTh5XrWLIq2msciBZzg9lMPrjp922fZ9LcJjWFS
         kh3c2PSEEQpfNlcP96x6G1omF3KSYa40iIICWcfZqaRMol6OXdvyE9BX53uIYti01Xnj
         eyElELWQ3CbuhsPdkZclGhrzZZAI10Um0WuNnKidIMISRT8I7TDImYbWLEt0ve7jBtMd
         YM1+9AKHbk1kepTsTDoff8wxHEIG/nVdixOeXFH3VwWa4QAHgZgM0bcmKSrrgcOiRYzR
         SiCc4xUFs8DOZo2z8u1zOJLB1h8fj4LQXtatIxVWhPj5bDbYQ4LU6tZfnBlIJB81eFPs
         oEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=or6og52WAzcHwbFjGhtwMlGLqMwGhkO0yUxAFAzASuA=;
        b=YfSoOd1XxfOx3ESADoE9aP50HOSsOsCg8/viemJif7ibHknQBWbXxUjXeSn90lFmEM
         a6wE1f2Kv74b9oUYd6bbg21y76ZuAotuVroTX82+r2Tqw9rmKbu19T8co7KhEZBOI/3W
         juuieUOk9L6e1vrWVMW2uBQnvYTGPZPOLDTvyQagdORx8Vmi1D7Nl0uUraRrO5Gi3VMJ
         m4mgldcE9iAsvUoL1Km5FtwLnighqI48fh6fPNjfGMLYLy0zLsP3ntmVUc9wuWpiMozo
         sPa218F3+jQkPTTSs1H4Iu7C9cEz8Viieq7Ckwycm0sdB6rDxqDwE2MTsn91mYBLBmf/
         v3bg==
X-Gm-Message-State: APjAAAW++BtpF6Km92hTRLPgAYa+aCurGkGp1mqajwW+tGYdFFpYwK8+
        aAI+o8sLQ09tc65jfCODtQeAPnfE8YYTCj4VKxU=
X-Google-Smtp-Source: APXvYqydfHcaItgajWb8h6pu83mjIziuurFxwP6ahwHLN7e/Cq6sqOp3q6qzhcPFeTb3a+w33TUBZZDualOCrMDIV6k=
X-Received: by 2002:a67:af11:: with SMTP id v17mr4575542vsl.99.1579108418441;
 Wed, 15 Jan 2020 09:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-5-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-5-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:13:27 +0000
Message-ID: <CAL3q7H7g=zaW-aTp9pekFUepYZSv-zCCzfSEsw0O5=ctQhwkHw@mail.gmail.com>
Subject: Re: [PATCH 4/5] btrfs: replace all uses of btrfs_ordered_update_i_size
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Now that we have a safe way to update the i_size, replace all uses of
> btrfs_ordered_update_i_size with btrfs_inode_safe_disk_i_size_write.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/file.c  |  2 +-
>  fs/btrfs/inode.c | 12 ++++++------
>  fs/btrfs/ioctl.c |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f1c880c06ca2..35fdc5b99804 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2941,7 +2941,7 @@ static int btrfs_fallocate_update_isize(struct inod=
e *inode,
>
>         inode->i_ctime =3D current_time(inode);
>         i_size_write(inode, end);
> -       btrfs_ordered_update_i_size(inode, end, NULL);
> +       btrfs_inode_safe_disk_i_size_write(inode, 0);
>         ret =3D btrfs_update_inode(trans, root, inode);
>         ret2 =3D btrfs_end_transaction(trans);
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5d34007aa7ec..4a3ef3174d73 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3119,7 +3119,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ord=
ered_extent *ordered_extent)
>                  */
>                 btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_=
offset,
>                                        ordered_extent->len);
> -               btrfs_ordered_update_i_size(inode, 0, ordered_extent);
> +               btrfs_inode_safe_disk_i_size_write(inode, 0);
>                 if (freespace_inode)
>                         trans =3D btrfs_join_transaction_spacecache(root)=
;
>                 else
> @@ -3207,7 +3207,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ord=
ered_extent *ordered_extent)
>                 goto out;
>         }
>
> -       btrfs_ordered_update_i_size(inode, 0, ordered_extent);
> +       btrfs_inode_safe_disk_i_size_write(inode, 0);
>         ret =3D btrfs_update_inode_fallback(trans, root, inode);
>         if (ret) { /* -ENOMEM or corruption */
>                 btrfs_abort_transaction(trans, ret);
> @@ -5007,7 +5007,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                 ASSERT(last_size >=3D new_size);
>                 if (!ret && last_size > new_size)
>                         last_size =3D new_size;
> -               btrfs_ordered_update_i_size(inode, last_size, NULL);
> +               btrfs_inode_safe_disk_i_size_write(inode, last_size);
>         }
>
>         btrfs_free_path(path);
> @@ -5337,7 +5337,7 @@ static int btrfs_setsize(struct inode *inode, struc=
t iattr *attr)
>                 }
>
>                 i_size_write(inode, newsize);
> -               btrfs_ordered_update_i_size(inode, i_size_read(inode), NU=
LL);
> +               btrfs_inode_safe_disk_i_size_write(inode, 0);
>                 pagecache_isize_extended(inode, oldsize, newsize);
>                 ret =3D btrfs_update_inode(trans, root, inode);
>                 btrfs_end_write_no_snapshotting(root);
> @@ -9319,7 +9319,7 @@ static int btrfs_truncate(struct inode *inode, bool=
 skip_writeback)
>                         ret =3D PTR_ERR(trans);
>                         goto out;
>                 }
> -               btrfs_ordered_update_i_size(inode, inode->i_size, NULL);
> +               btrfs_inode_safe_disk_i_size_write(inode, 0);
>         }
>
>         if (trans) {
> @@ -10578,7 +10578,7 @@ static int __btrfs_prealloc_file_range(struct ino=
de *inode, int mode,
>                         else
>                                 i_size =3D cur_offset;
>                         i_size_write(inode, i_size);
> -                       btrfs_ordered_update_i_size(inode, i_size, NULL);
> +                       btrfs_inode_safe_disk_i_size_write(inode, 0);
>                 }
>
>                 ret =3D btrfs_update_inode(trans, root, inode);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 291dda3b6547..2a02a21cac59 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3334,7 +3334,7 @@ static int clone_finish_inode_update(struct btrfs_t=
rans_handle *trans,
>                 endoff =3D destoff + olen;
>         if (endoff > inode->i_size) {
>                 i_size_write(inode, endoff);
> -               btrfs_ordered_update_i_size(inode, endoff, NULL);
> +               btrfs_inode_safe_disk_i_size_write(inode, 0);
>         }
>
>         ret =3D btrfs_update_inode(trans, root, inode);
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
