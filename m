Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEC3BBAF0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhGEKRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhGEKRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 06:17:43 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9130C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 03:15:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i125so5009068qke.12
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tpmR6QXiIMXpWCl/INNbCLKsTKA1ZXHASgp+T2iFd1g=;
        b=VXiy73q9nE4SM2BiXpSQvQ6/dxJWSiJTMBa4CE98/zoHhIbMyOgJ8PYni0m9yBUnt9
         HREH1buPPAzIJ9eC18PcQhpMKKhvxlvqYC1UqqMC+PhiPCAfvRKkRmgxrAalm3AOdzRp
         KEPMt0VwHCNX3pTzEqyks1wxAQzEVMkqlVX6fR4QDNYumhVEb5AZA7wJSK/cvtaUNcDL
         DdMtutfN61yhRaunJTDCRg6DrVGkYOZuE6vXrG3dIjgOgCL7rSiLVdztvAkRdKCYj7rF
         uvwDDTPzixtY8b4W7xGP0X/lr1CfVVpPYsuzM7mJ+ZvnsqNcuagLyvnU4kp4gaXtvx49
         egYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tpmR6QXiIMXpWCl/INNbCLKsTKA1ZXHASgp+T2iFd1g=;
        b=gOjgB3XBgiBpdMUFD+HE8OU98LizsuHLLJyyDzxO12zlGFgdrwxB8PtLg680owzVab
         D2gO61UvzJWKMYgb7+DFSuV2dqjmY2ldnTFUHBEXiDHWl37ScFL9+V3Q99YYHgMK4Mmm
         zAy3gnhLNeHUCeQCcySno1bchKAvTN9JWy9E/CO+ykr4k65kSihN+QxVyKh2QTmy0olZ
         B7KpeXFOKTtnIr8Aor6hoHKYdL+/OjitdxCE1nkMe9UCI4iKHx9aHCrrxWEjD8+Rhqfk
         OqlaDTfWmsAtMinrJ66+YHUkWnWUBJEHYiOsgkadMczUtmIYk2mZtpLwU/Na1olBADCM
         uBuA==
X-Gm-Message-State: AOAM531CL8Ap0n2wePHhM0LhxPc4h7bQpuNWgb96R1u7DHPP5dI5+s+l
        oULULg3p3McXWwt2UJNh6ixPXzZX3jzEf2oGA7k=
X-Google-Smtp-Source: ABdhPJw/7wCxptqxfK3RQfQrXnz5InDEfq5yWAxzvVKetOf/Ql3LSnsUHn/MRZQB84dWH1+LsgTUZxAC/RCACuN2HrY=
X-Received: by 2002:a05:620a:2217:: with SMTP id m23mr13733229qkh.383.1625480106129;
 Mon, 05 Jul 2021 03:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210705092919.3408670-1-nborisov@suse.com>
In-Reply-To: <20210705092919.3408670-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 11:14:55 +0100
Message-ID: <CAL3q7H5rQO0=oxUcCE2JVT2q7qg99ds_DQ3ZoohrXW-Fu2eQJw@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: make btrfs_finish_chunk_alloc private to block-group.c
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 5, 2021 at 10:32 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> One of the final things that must be done to add a new chunk is
> inserting its device extent items in the device tree. They describe
> the portion of allocated device physical space during phase 1 of
> chunk allocation. This is currently done in btrfs_finish_chunk_alloc
> whose name isn't very informative. What's more, this function is only
> used in block-group.c but is defined as public. There isn't anything
> special about it that would warrant it being defined in volumes.c.
>
> Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
> block-group.c, make the former static and rename both functions to
> insert_dev_extents and insert_dev_extent respectively.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks good now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> V3:
>  * Fixed some typos in changelog and a factual mistake.
>  * Removed 2 extra new lines.
> V2:
>  * Give the 2 moved functions better names.
>  * Improve changelog to correctly reflect reality.
>
>  fs/btrfs/block-group.c | 96 +++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.c     | 92 ----------------------------------------
>  fs/btrfs/volumes.h     |  2 -
>  3 files changed, 94 insertions(+), 96 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c557327b4545..d62760aaf041 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2236,6 +2236,98 @@ static int insert_block_group_item(struct btrfs_tr=
ans_handle *trans,
>         return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
>  }
>
> +static int insert_dev_extent(struct btrfs_trans_handle *trans,
> +                           struct btrfs_device *device, u64 chunk_offset=
,
> +                           u64 start, u64 num_bytes)
> +{
> +       int ret;
> +       struct btrfs_path *path;
> +       struct btrfs_fs_info *fs_info =3D device->fs_info;
> +       struct btrfs_root *root =3D fs_info->dev_root;
> +       struct btrfs_dev_extent *extent;
> +       struct extent_buffer *leaf;
> +       struct btrfs_key key;
> +
> +       WARN_ON(!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_st=
ate));
> +       WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)=
);
> +       path =3D btrfs_alloc_path();
> +       if (!path)
> +               return -ENOMEM;
> +
> +       key.objectid =3D device->devid;
> +       key.offset =3D start;
> +       key.type =3D BTRFS_DEV_EXTENT_KEY;
> +       ret =3D btrfs_insert_empty_item(trans, root, path, &key,
> +                                     sizeof(*extent));
> +       if (ret)
> +               goto out;
> +
> +       leaf =3D path->nodes[0];
> +       extent =3D btrfs_item_ptr(leaf, path->slots[0],
> +                               struct btrfs_dev_extent);
> +       btrfs_set_dev_extent_chunk_tree(leaf, extent,
> +                                       BTRFS_CHUNK_TREE_OBJECTID);
> +       btrfs_set_dev_extent_chunk_objectid(leaf, extent,
> +                                           BTRFS_FIRST_CHUNK_TREE_OBJECT=
ID);
> +       btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
> +
> +       btrfs_set_dev_extent_length(leaf, extent, num_bytes);
> +       btrfs_mark_buffer_dirty(leaf);
> +out:
> +       btrfs_free_path(path);
> +       return ret;
> +}
> +
> +/*
> + * This function belongs to phase 2.
> + *
> + * See the comment at btrfs_chunk_alloc() for details about the chunk al=
location
> + * phases.
> + */
> +static int insert_dev_extents(struct btrfs_trans_handle *trans,
> +                                  u64 chunk_offset, u64 chunk_size)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_device *device;
> +       struct extent_map *em;
> +       struct map_lookup *map;
> +       u64 dev_offset;
> +       u64 stripe_size;
> +       int i;
> +       int ret =3D 0;
> +
> +       em =3D btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
> +       if (IS_ERR(em))
> +               return PTR_ERR(em);
> +
> +       map =3D em->map_lookup;
> +       stripe_size =3D em->orig_block_len;
> +
> +       /*
> +        * Take the device list mutex to prevent races with the final pha=
se of
> +        * a device replace operation that replaces the device object ass=
ociated
> +        * with the map's stripes, because the device object's id can cha=
nge
> +        * at any time during that final phase of the device replace oper=
ation
> +        * (dev-replace.c:btrfs_dev_replace_finishing()), so we could gra=
b the
> +        * replaced device and then see it with an ID of BTRFS_DEV_REPLAC=
E_DEVID,
> +        * resulting in persisting a device extent item with such ID.
> +        */
> +       mutex_lock(&fs_info->fs_devices->device_list_mutex);
> +       for (i =3D 0; i < map->num_stripes; i++) {
> +               device =3D map->stripes[i].dev;
> +               dev_offset =3D map->stripes[i].physical;
> +
> +               ret =3D insert_dev_extent(trans, device, chunk_offset, de=
v_offset,
> +                                      stripe_size);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> +
> +       free_extent_map(em);
> +       return ret;
> +}
> +
>  /*
>   * This function, btrfs_create_pending_block_groups(), belongs to the ph=
ase 2 of
>   * chunk allocation.
> @@ -2270,8 +2362,8 @@ void btrfs_create_pending_block_groups(struct btrfs=
_trans_handle *trans)
>                         if (ret)
>                                 btrfs_abort_transaction(trans, ret);
>                 }
> -               ret =3D btrfs_finish_chunk_alloc(trans, block_group->star=
t,
> -                                       block_group->length);
> +               ret =3D insert_dev_extents(trans, block_group->start,
> +                                             block_group->length);
>                 if (ret)
>                         btrfs_abort_transaction(trans, ret);
>                 add_block_group_free_space(trans, block_group);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c6c14315b1c9..f820c32f4a0d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1758,48 +1758,6 @@ static int btrfs_free_dev_extent(struct btrfs_tran=
s_handle *trans,
>         return ret;
>  }
>
> -static int btrfs_alloc_dev_extent(struct btrfs_trans_handle *trans,
> -                                 struct btrfs_device *device,
> -                                 u64 chunk_offset, u64 start, u64 num_by=
tes)
> -{
> -       int ret;
> -       struct btrfs_path *path;
> -       struct btrfs_fs_info *fs_info =3D device->fs_info;
> -       struct btrfs_root *root =3D fs_info->dev_root;
> -       struct btrfs_dev_extent *extent;
> -       struct extent_buffer *leaf;
> -       struct btrfs_key key;
> -
> -       WARN_ON(!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_st=
ate));
> -       WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)=
);
> -       path =3D btrfs_alloc_path();
> -       if (!path)
> -               return -ENOMEM;
> -
> -       key.objectid =3D device->devid;
> -       key.offset =3D start;
> -       key.type =3D BTRFS_DEV_EXTENT_KEY;
> -       ret =3D btrfs_insert_empty_item(trans, root, path, &key,
> -                                     sizeof(*extent));
> -       if (ret)
> -               goto out;
> -
> -       leaf =3D path->nodes[0];
> -       extent =3D btrfs_item_ptr(leaf, path->slots[0],
> -                               struct btrfs_dev_extent);
> -       btrfs_set_dev_extent_chunk_tree(leaf, extent,
> -                                       BTRFS_CHUNK_TREE_OBJECTID);
> -       btrfs_set_dev_extent_chunk_objectid(leaf, extent,
> -                                           BTRFS_FIRST_CHUNK_TREE_OBJECT=
ID);
> -       btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
> -
> -       btrfs_set_dev_extent_length(leaf, extent, num_bytes);
> -       btrfs_mark_buffer_dirty(leaf);
> -out:
> -       btrfs_free_path(path);
> -       return ret;
> -}
> -
>  static u64 find_next_chunk(struct btrfs_fs_info *fs_info)
>  {
>         struct extent_map_tree *em_tree;
> @@ -5462,56 +5420,6 @@ struct btrfs_block_group *btrfs_alloc_chunk(struct=
 btrfs_trans_handle *trans,
>         return block_group;
>  }
>
> -/*
> - * This function, btrfs_finish_chunk_alloc(), belongs to phase 2.
> - *
> - * See the comment at btrfs_chunk_alloc() for details about the chunk al=
location
> - * phases.
> - */
> -int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
> -                            u64 chunk_offset, u64 chunk_size)
> -{
> -       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -       struct btrfs_device *device;
> -       struct extent_map *em;
> -       struct map_lookup *map;
> -       u64 dev_offset;
> -       u64 stripe_size;
> -       int i;
> -       int ret =3D 0;
> -
> -       em =3D btrfs_get_chunk_map(fs_info, chunk_offset, chunk_size);
> -       if (IS_ERR(em))
> -               return PTR_ERR(em);
> -
> -       map =3D em->map_lookup;
> -       stripe_size =3D em->orig_block_len;
> -
> -       /*
> -        * Take the device list mutex to prevent races with the final pha=
se of
> -        * a device replace operation that replaces the device object ass=
ociated
> -        * with the map's stripes, because the device object's id can cha=
nge
> -        * at any time during that final phase of the device replace oper=
ation
> -        * (dev-replace.c:btrfs_dev_replace_finishing()), so we could gra=
b the
> -        * replaced device and then see it with an ID of BTRFS_DEV_REPLAC=
E_DEVID,
> -        * resulting in persisting a device extent item with such ID.
> -        */
> -       mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -       for (i =3D 0; i < map->num_stripes; i++) {
> -               device =3D map->stripes[i].dev;
> -               dev_offset =3D map->stripes[i].physical;
> -
> -               ret =3D btrfs_alloc_dev_extent(trans, device, chunk_offse=
t,
> -                                            dev_offset, stripe_size);
> -               if (ret)
> -                       break;
> -       }
> -       mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> -
> -       free_extent_map(em);
> -       return ret;
> -}
> -
>  /*
>   * This function, btrfs_chunk_alloc_add_chunk_item(), typically belongs =
to the
>   * phase 1 of chunk allocation. It belongs to phase 2 only when allocati=
ng system
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 55a8ba244716..70c749eee3ad 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -508,8 +508,6 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_i=
nfo,
>                            u64 logical, u64 len);
>  unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
>                                     u64 logical);
> -int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
> -                            u64 chunk_offset, u64 chunk_size);
>  int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
>                                      struct btrfs_block_group *bg);
>  int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offse=
t);
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
