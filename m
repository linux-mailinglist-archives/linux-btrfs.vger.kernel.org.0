Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB65F3BBAED
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhGEKRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhGEKRC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 06:17:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925EC061574
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 03:14:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id e14so5591903qkl.9
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0+9w2rnJnJQ1h010ctoWQYiTOnRmDh2mPbsOJBwkQhQ=;
        b=MrjJIRRRR3rCLr8bxZUbn4oBrytc4oP63l9r7RGYWhsfyE4MIAixbBfwX60FJz2NCT
         HZnaGSEEuYtTkREHzO+JvOJnd7wEWjhNSPMwIySUlfB4Ohfq1hsSrB5Lzo4PIWQZQ/Uz
         53plAk5vgzEIo45QtINqGSAubmJnuKQ74BN+o1guA1hOKAMD2rFLbEObcMM0exvBX7Ij
         AKVyDajaU1epOlDnvKzQypsTPxa46bsP4OzqMhKvUfxqaCfwAU1YH7rCoHoK7A7IGO0w
         ndgRJpbsyRPdCPugiT2WhNmG+0qHBneuhdH4Lp38eEhEIpot8LDNfccCa8LUchJWhDWc
         Y0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0+9w2rnJnJQ1h010ctoWQYiTOnRmDh2mPbsOJBwkQhQ=;
        b=Hq7KPVt95e/hRVkCDOG3SuPMJJY/9yLdh07fqa0d5MZ6SyzKQXXP0LQYJref8iw2P+
         dtc6qpzGlc0PfhkfV1pd6oD5LgSxfQ3gVx4nGu3inRzCI4bCofDjfabJenmR4wD0dfqW
         8D4cx6Srbf8SH67FdAokwqjfDImKV7fyCaaikLziFLicCGYEuMChYBrxYSw6pQTt/+GK
         Bc+4riMKz7tA/c4ZgcYmE1VLAdjQUTKasx3wLD84UJ4pOGq8soWABtqAVXa/rQTRPU/b
         pTbhE8xGAaH+UiHjl0vwczu1AgYaq0Trt2Ps9o+301j1E3d3j06ypSVBa/J9a7PCNN8E
         UFew==
X-Gm-Message-State: AOAM532edv8r8AwWY7VOPgK8VAcjvGCyMOERN1u2olYGioGApPXiJT0L
        dcDZiXln2P347jCQLjtwdVMijotkW/2BFwl7QoI=
X-Google-Smtp-Source: ABdhPJxFL0YR+zuAFqPtBUCpaHmpBgTa28Cw77jJth9r+ljOCQF1w670nUDn8EJlpuMEJ/F9NIj+nSfff85vgVT86g0=
X-Received: by 2002:ae9:ec11:: with SMTP id h17mr13217446qkg.438.1625480065050;
 Mon, 05 Jul 2021 03:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210705091643.3404691-1-nborisov@suse.com>
In-Reply-To: <20210705091643.3404691-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 5 Jul 2021 11:14:14 +0100
Message-ID: <CAL3q7H75Hpb6_wYDei8vWR-x2Dvnt1PU-FUf6c1w3NAJvbdwWw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 5, 2021 at 10:19 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> The user facing function used to allocate new chunks is
> btrfs_chunk_alloc, unfortunately there is yet another similar sounding
> function - btrfs_alloc_chunk. This creates confusion, especially since
> the latter function can be considered "private" in the sense that it
> implements the first stage of chunk creation and as such is called by
> btrfs_chunk_alloc.
>
> To avoid the awkwardness that comes with having similarly named but
> distinctly different in their purpose function rename btrfs_alloc_chunk
> to btrfs_create_chunk, given that the main purpose of this function is
> to orchestrate the whole process of allocating a chunk - reserving space
> into devices, deciding on characteristics of the stripe size and
> creating the in-memory structures.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks good now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> V2:
>  * Fix changlog to reflect reality
>
>  fs/btrfs/block-group.c | 6 +++---
>  fs/btrfs/volumes.c     | 8 ++++----
>  fs/btrfs/volumes.h     | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5c2361168363..500a85e4320f 100644
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
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
