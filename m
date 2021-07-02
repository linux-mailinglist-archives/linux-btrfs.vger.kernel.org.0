Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6473BA1DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhGBOE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 10:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhGBOE1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 10:04:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B627C061762
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 07:01:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a4so1497779qkn.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hBZSaWOGPKePoOFcMi/01BLYHusnW96jdYaadEYZfvg=;
        b=gh81vREV4vqYZJ2+kQRUfzGBS+LrOT74Rw7n4fiZ5nY46AhMcw0UQO4goWkg5rIsrn
         PIYScgbD2FZp2WQOqXEPiCllgaShJ4iyIdfuNnjKKNgihGTCF79v4/HXbQYjRhUlWXrG
         wV46k71MP6KDWPYfDwgCOsvMzy3QAtRauG9jhj3HXLSq9cWUy5DBOy6ZfTFg8Yk/Ko4V
         xiB7qYrCU2ypZnPggB9Es0ETv/3k17+JF6PiV/9EWX9kJETTEBsJngncnfCKLpmeFBkf
         RSIJ3MRgxQlSImOD+irkPvKXS8YdYJWp/HR103ubfQcyyUb5376FnL+cYvGWoro89zr6
         nbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hBZSaWOGPKePoOFcMi/01BLYHusnW96jdYaadEYZfvg=;
        b=oyd+W7YFPk9HteFg54093UBuiPup3MW2zDMftrnodvSsB5uZ/UksIGWq3YK+/cTK5U
         5DI2cmYDxL0/Iaj7TG/+UMWBEICgMR3oALbTxKvtZJgexc1FtIIF8jFyXCN5Pn8yKP9S
         Du8481DGQuZOAbmv2uj1t6F+xbmd+6HDk+CIfXb/qkq51STa1nwilpu3M7nTTMhLtbm5
         gevwoQMYKEOQDzz4k9s9wHM0ivMMj68ytxCsit+0o57ITfoagmnAdvVj5MmYBZKoUKFt
         jQtuL4SMKjKLcFAuNNY5CgdHuCQivlw4KZXMFAhkJIDSjScIu5+dhYJ437GWpkkZrHNQ
         UhaA==
X-Gm-Message-State: AOAM533PD3WmxtEd/LZEH8tjW+e0Wx/0Y13Uoa3kDqFIb5ig5Xg0XdBH
        qOmBGS5SWE8PmmBAzBVDDbFfvpDmY1+r1G3sj3Y=
X-Google-Smtp-Source: ABdhPJxXHnRY6Mv2F/HPPvPuJgaAVA4aIK2yKSg104vvxE1Zk1HDFwkxqR9/+RUIk6KHEkclIDbdu8b0ll9c59FVgOc=
X-Received: by 2002:a05:620a:134c:: with SMTP id c12mr12391qkl.0.1625234513482;
 Fri, 02 Jul 2021 07:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210702124740.29711-1-nborisov@suse.com>
In-Reply-To: <20210702124740.29711-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 2 Jul 2021 15:01:42 +0100
Message-ID: <CAL3q7H7tD05e16MDkdaao57AEPmsjda5+CKDTPXTXwsB23g4ag@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Rename btrfs_alloc_chunk to btrfs_create_chunk
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 2, 2021 at 1:50 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> The user facing function used to allocate new chunks is
> btrfs_chunk_alloc, unfortunately recent fixes to the chunk allocation
> machinery required introducing yet another similar sounding function -
> btrfs_alloc_chunk. This creates confusion, especially since the latter

This is not true, both function names, btrfs_chunk_alloc() and
btrfs_alloc_chunk(), already existed before the recent changes.
And it's been like that for many years.

> function can be considered "private" in the sense that it implements
> the first stage of chunk creation and as such is called by
> btrfs_chunk_alloc.
>
> To avoid the awkawrdness that comes with having similarly named but

Typo:   awkawrdness

> distinctly different in their purpose function rename btrfs_alloc_chunk
> to btrfs_create_chunk, given that the main purpose of this functino is

Typo:  functino

> to create the in-memory structures which are part of the bigger "chunk
> allocation" process.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

With the change log fixed,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/block-group.c | 6 +++---
>  fs/btrfs/volumes.c     | 8 ++++----
>  fs/btrfs/volumes.h     | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 2e133ee61d83..3eecbc2b3dae 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3358,7 +3358,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle=
 *trans, u64 flags)
>          */
>         check_system_chunk(trans, flags);
>
> -       bg =3D btrfs_alloc_chunk(trans, flags);
> +       bg =3D btrfs_create_chunk(trans, flags);
>         if (IS_ERR(bg)) {
>                 ret =3D PTR_ERR(bg);
>                 goto out;
> @@ -3419,7 +3419,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle=
 *trans, u64 flags)
>                 const u64 sys_flags =3D btrfs_system_alloc_profile(trans-=
>fs_info);
>                 struct btrfs_block_group *sys_bg;
>
> -               sys_bg =3D btrfs_alloc_chunk(trans, sys_flags);
> +               sys_bg =3D btrfs_create_chunk(trans, sys_flags);
>                 if (IS_ERR(sys_bg)) {
>                         ret =3D PTR_ERR(sys_bg);
>                         btrfs_abort_transaction(trans, ret);
> @@ -3712,7 +3712,7 @@ void check_system_chunk(struct btrfs_trans_handle *=
trans, u64 type)
>                  * could deadlock on an extent buffer since our caller ma=
y be
>                  * COWing an extent buffer from the chunk btree.
>                  */
> -               bg =3D btrfs_alloc_chunk(trans, flags);
> +               bg =3D btrfs_create_chunk(trans, flags);
>                 if (IS_ERR(bg)) {
>                         ret =3D PTR_ERR(bg);
>                 } else if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f820c32f4a0d..4f84b5d871dd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3086,7 +3086,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *t=
rans, u64 chunk_offset)
>                 const u64 sys_flags =3D btrfs_system_alloc_profile(fs_inf=
o);
>                 struct btrfs_block_group *sys_bg;
>
> -               sys_bg =3D btrfs_alloc_chunk(trans, sys_flags);
> +               sys_bg =3D btrfs_create_chunk(trans, sys_flags);
>                 if (IS_ERR(sys_bg)) {
>                         ret =3D PTR_ERR(sys_bg);
>                         btrfs_abort_transaction(trans, ret);
> @@ -5363,7 +5363,7 @@ static struct btrfs_block_group *create_chunk(struc=
t btrfs_trans_handle *trans,
>         return block_group;
>  }
>
> -struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *t=
rans,
> +struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *=
trans,
>                                             u64 type)
>  {
>         struct btrfs_fs_info *info =3D trans->fs_info;
> @@ -5564,12 +5564,12 @@ static noinline int init_first_rw_device(struct b=
trfs_trans_handle *trans)
>          */
>
>         alloc_profile =3D btrfs_metadata_alloc_profile(fs_info);
> -       meta_bg =3D btrfs_alloc_chunk(trans, alloc_profile);
> +       meta_bg =3D btrfs_create_chunk(trans, alloc_profile);
>         if (IS_ERR(meta_bg))
>                 return PTR_ERR(meta_bg);
>
>         alloc_profile =3D btrfs_system_alloc_profile(fs_info);
> -       sys_bg =3D btrfs_alloc_chunk(trans, alloc_profile);
> +       sys_bg =3D btrfs_create_chunk(trans, alloc_profile);
>         if (IS_ERR(sys_bg))
>                 return PTR_ERR(sys_bg);
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 70c749eee3ad..f9e13e8ca703 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -450,7 +450,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_in=
fo, struct extent_map *map,
>                           struct btrfs_io_geometry *io_geom);
>  int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
>  int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
> -struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *t=
rans,
> +struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *=
trans,
>                                             u64 type);
>  void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>  blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bi=
o,
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
