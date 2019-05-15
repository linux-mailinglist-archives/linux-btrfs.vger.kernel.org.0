Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D441F94C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEORZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 13:25:07 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41749 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfEORZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 13:25:07 -0400
Received: by mail-ua1-f65.google.com with SMTP id s30so151508uas.8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CmNq7CSjqm5dDYXi/UeZdFa2zW7OEXS67rpggyP0dJM=;
        b=emavolL/yA9Vzmkg1Xt8Q2rmurno6LyMSzSknFyABADKbvPV+kjWXV206QOYFkwgVK
         PKWmZvL9BGOkGkIvoc9Brcb/Bv9J9To18aY2edJ9xX4+MfckHeBNk/KZTpva7EvtxVo0
         yeXEQi8gSm9eCuz8qWqOyLposhs8PUgAAsIdIJ2N54xf0BxFJxO1a828MoRRYiYjPauz
         YimwLxZ5zWRKQOitYbkVTNZVKQRVJEEh+3CL6qMVQaozkQOQixsRKyUSEFLQ9l6b4AfI
         Dwfb0+reNcuHYxoJcv8lMif+5OhLKuI/bTgeKYd1mhxbIEOvtT25oPdeFROl2PpXb23k
         cowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CmNq7CSjqm5dDYXi/UeZdFa2zW7OEXS67rpggyP0dJM=;
        b=mfXSBnhVACrQzY06gNBWFxfGZAnbHVo79JmLPZ5UNOrhSFDyRJeSoccRbtmZzA1Gdi
         McwTmJD8CPOtAIO5vVPZRzGcNf3IAw3gtoOGpbqMDJCUuWl9y2EDGp794TXfkpt3+sKB
         KSkFritKL8Igq4XmNwJ/noLXfpLsmSmvohK0nZUQnrspHdK3vb/xomw7HhaMzVHRHD/R
         HEXnkbbHkv0K7qwt1XkQDnnxWBuCpyR2PL6YfsBjOpdEBmgaxqlpxRsufrH9Z7iLQx9S
         ne267CJRfnWbhIB0c24QiCQ8ivBMBWWzhgeGOQ+m89E/IIU0sJ4pkckcFFHoUR9WGi9S
         VYzg==
X-Gm-Message-State: APjAAAVizWN/CGMsfWO0D3HUa8BrbkUebX/bbf6p5ss6SqlD5VLgUqaa
        h2+tcRQJeJcinGa0Owc5vClF0DMBlvb8KHtxVYo=
X-Google-Smtp-Source: APXvYqyqg+YH9M5xg1rzx0dX/n2X3XArYZ1FpMwQPiIScP8i83ChdfQ72dUyNY7MJ+3mrRcI/3eFEskWn1U+UjPB47A=
X-Received: by 2002:ab0:1e2:: with SMTP id 89mr8286187ual.0.1557941105475;
 Wed, 15 May 2019 10:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190515133104.1364-1-dsterba@suse.com>
In-Reply-To: <20190515133104.1364-1-dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 May 2019 18:24:54 +0100
Message-ID: <CAL3q7H44DfhLcvXEFY6gmfGQ9LEusDpJiM6b77kvRMQiO1ynZA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fiemap: preallocate ulists for btrfs_check_shared
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 15, 2019 at 2:31 PM David Sterba <dsterba@suse.com> wrote:
>
> btrfs_check_shared looks up parents of a given extent and uses ulists
> for that. These are allocated and freed repeatedly. Preallocation in the
> caller will avoid the overhead and also allow us to use the GFP_KERNEL
> as it is happens before the extent locks are taken.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/backref.c   | 17 ++++++-----------
>  fs/btrfs/backref.h   |  3 ++-
>  fs/btrfs/extent_io.c | 15 +++++++++++++--
>  3 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 982152d3f920..89116afda7a2 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1465,12 +1465,11 @@ int btrfs_find_all_roots(struct btrfs_trans_handl=
e *trans,
>   *
>   * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
>   */
> -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
> +int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> +               struct ulist *roots, struct ulist *tmp)
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct btrfs_trans_handle *trans;
> -       struct ulist *tmp =3D NULL;
> -       struct ulist *roots =3D NULL;
>         struct ulist_iterator uiter;
>         struct ulist_node *node;
>         struct seq_list elem =3D SEQ_LIST_INIT(elem);
> @@ -1481,12 +1480,8 @@ int btrfs_check_shared(struct btrfs_root *root, u6=
4 inum, u64 bytenr)
>                 .share_count =3D 0,
>         };
>
> -       tmp =3D ulist_alloc(GFP_NOFS);
> -       roots =3D ulist_alloc(GFP_NOFS);
> -       if (!tmp || !roots) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       ulist_init(roots);
> +       ulist_init(tmp);
>
>         trans =3D btrfs_attach_transaction(root);
>         if (IS_ERR(trans)) {
> @@ -1527,8 +1522,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64=
 inum, u64 bytenr)
>                 up_read(&fs_info->commit_root_sem);
>         }
>  out:
> -       ulist_free(tmp);
> -       ulist_free(roots);
> +       ulist_release(roots);
> +       ulist_release(tmp);
>         return ret;
>  }
>
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 54d58988483a..777f61dc081e 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -57,7 +57,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 =
inode_objectid,
>                           u64 start_off, struct btrfs_path *path,
>                           struct btrfs_inode_extref **ret_extref,
>                           u64 *found_off);
> -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr);
> +int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> +               struct ulist *roots, struct ulist *tmp_ulist);
>
>  int __init btrfs_prelim_ref_init(void);
>  void __cold btrfs_prelim_ref_exit(void);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 13fca7bfc1f2..d70a602a5d48 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4557,6 +4557,13 @@ int extent_fiemap(struct inode *inode, struct fiem=
ap_extent_info *fieinfo,
>                 return -ENOMEM;
>         path->leave_spinning =3D 1;
>
> +       roots =3D ulist_alloc(GFP_KERNEL);
> +       tmp_ulist =3D ulist_alloc(GFP_KERNEL);
> +       if (!roots || !tmp_ulist) {
> +               ret =3D -ENOMEM;
> +               goto out_free_ulist;
> +       }
> +
>         start =3D round_down(start, btrfs_inode_sectorsize(inode));
>         len =3D round_up(max, btrfs_inode_sectorsize(inode)) - start;
>
> @@ -4568,7 +4575,7 @@ int extent_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
>                         btrfs_ino(BTRFS_I(inode)), -1, 0);
>         if (ret < 0) {
>                 btrfs_free_path(path);
> -               return ret;
> +               goto out_free_ulist;
>         } else {
>                 WARN_ON(!ret);
>                 if (ret =3D=3D 1)
> @@ -4677,7 +4684,7 @@ int extent_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
>                          */
>                         ret =3D btrfs_check_shared(root,
>                                                  btrfs_ino(BTRFS_I(inode)=
),
> -                                                bytenr);
> +                                                bytenr, roots, tmp_ulist=
);
>                         if (ret < 0)
>                                 goto out_free;
>                         if (ret)
> @@ -4723,6 +4730,10 @@ int extent_fiemap(struct inode *inode, struct fiem=
ap_extent_info *fieinfo,
>         btrfs_free_path(path);
>         unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len=
 - 1,
>                              &cached_state);
> +
> +out_free_ulist:
> +       ulist_free(roots);
> +       ulist_free(tmp_ulist);
>         return ret;
>  }
>
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
