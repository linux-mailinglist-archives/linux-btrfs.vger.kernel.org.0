Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E129E3073EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 11:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhA1Kjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 05:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhA1Kji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 05:39:38 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19132C061573;
        Thu, 28 Jan 2021 02:38:58 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l23so3662631qtq.13;
        Thu, 28 Jan 2021 02:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=H95nDMIaG+UWoPVr5potKKIV8AkgNcQcBdQ2TBAk62g=;
        b=j6VZ6GTMC9D25Uxw7u/ypKQk6K7SOXplKhn3k+MIwsINkaP9JhK+5o2PUjcUOGPwKG
         vQTH23CXSbWxUE3djZvtNoKBZsS9xGAHYKwgo7EK/HmBasey2mfpU2K6Qgv+bbu1/jx5
         TAo+EMkBe5RybAr+DlQwgGMl4ZFNKHZffdWwg6oFNKiPtOGtLINBfbUuodm883v5GCd9
         og027PSYHeVeXG31aPLkJMMldezYl5hfdtfuKPJXWKpPKkc6GXt501KhDGa71ehzYnfl
         sRUqWy5V6UAKiukOTRqKvUR98fqyXVQPq24HJXcgTRIcoK8KZdKOKgP663ckMDBtMSqH
         WRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=H95nDMIaG+UWoPVr5potKKIV8AkgNcQcBdQ2TBAk62g=;
        b=A4VOTv5xp9TIVOR1sXNwkebeADiKPFbJPfL5cj127pvcTPrylp8mdhw/Vv1eVpOUsc
         Rt5wBNLUElB1WX8lES01nH4Jt6R+Ebp6tZfkh3m1CTTySfJxhqPjoAB02W0lz6DcCW/B
         G6POkTpN54AfOkc4SF7nyEM2HMp88pq72xg/h6XR8N74g48JymdOmzMx67CNqTqNGLTc
         AK6KpVrIk1xJdHgahEeN/hrYZSN0RMFRKtB1KL06XRClNkhFmQ1ZKvr926j8mSIEUCGF
         1QN+7T9NWp2HI8pPmXwLreWpl9CKw7ncyVKdkTILJtR5kOQGW+6Lrzq+30+BfRjkadIO
         QeQQ==
X-Gm-Message-State: AOAM531MkA97JYIMK16W7nzljxG3vs7u7Dkr3VzdoUmbp5nDviDe+3DS
        I7Sk1hTCjdkQBPsGKmiW/RBQS2FjnJdtrXcaqieRh6yn528=
X-Google-Smtp-Source: ABdhPJwv2OMIwDoUybR4UIQGdao0THK4PQ2sLCfomo3WVOh4lyDUmPGCdC1gdsL3v49Lo+8jdLpGmLYRp+8okFHEM8g=
X-Received: by 2002:ac8:4755:: with SMTP id k21mr13800069qtp.376.1611830337201;
 Thu, 28 Jan 2021 02:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20210127135728.30276-1-mrostecki@suse.de>
In-Reply-To: <20210127135728.30276-1-mrostecki@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 28 Jan 2021 10:38:45 +0000
Message-ID: <CAL3q7H7H93dmmxGKwSiJfG4NaikFLoAxNJAWR-ZazvWN6n5_fw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 28, 2021 at 12:01 AM Michal Rostecki <mrostecki@suse.de> wrote:
>
> From: Michal Rostecki <mrostecki@suse.com>
>
> Before this change, the btrfs_get_io_geometry() function was calling
> btrfs_get_chunk_map() to get the extent mapping, necessary for
> calculating the I/O geometry. It was using that extent mapping only
> internally and freeing the pointer after its execution.
>
> That resulted in calling btrfs_get_chunk_map() de facto twice by the
> __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> first and then calling btrfs_get_chunk_map() directly to get the extent
> mapping, used by the rest of the function.
>
> This change fixes that by passing the extent mapping to the
> btrfs_get_io_geometry() function as an argument.
>
> v2:
> When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
> - Use errno_to_blk_status(PTR_ERR(em)) as the status
> - Set em to NULL
>
> Signed-off-by: Michal Rostecki <mrostecki@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I think this is a fine optimization.
For very large filesystems, i.e. several thousands of allocated
chunks, not only this avoids searching two times the rbtree,
saving time, it may also help reducing contention on the lock that
protects the tree - thinking of writeback starting for multiple
inodes,
other tasks allocating or removing chunks, and anything else that
requires access to the rbtree.

Thanks, it looks good to me now.

> ---
>  fs/btrfs/inode.c   | 38 +++++++++++++++++++++++++++++---------
>  fs/btrfs/volumes.c | 39 ++++++++++++++++-----------------------
>  fs/btrfs/volumes.h |  5 +++--
>  3 files changed, 48 insertions(+), 34 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0dbe1aaa0b71..e2ee3a9c1140 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2183,9 +2183,10 @@ int btrfs_bio_fits_in_stripe(struct page *page, si=
ze_t size, struct bio *bio,
>         struct inode *inode =3D page->mapping->host;
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>         u64 logical =3D bio->bi_iter.bi_sector << 9;
> +       struct extent_map *em;
>         u64 length =3D 0;
>         u64 map_length;
> -       int ret;
> +       int ret =3D 0;
>         struct btrfs_io_geometry geom;
>
>         if (bio_flags & EXTENT_BIO_COMPRESSED)
> @@ -2193,14 +2194,21 @@ int btrfs_bio_fits_in_stripe(struct page *page, s=
ize_t size, struct bio *bio,
>
>         length =3D bio->bi_iter.bi_size;
>         map_length =3D length;
> -       ret =3D btrfs_get_io_geometry(fs_info, btrfs_op(bio), logical, ma=
p_length,
> -                                   &geom);
> +       em =3D btrfs_get_chunk_map(fs_info, logical, map_length);
> +       if (IS_ERR(em))
> +               return PTR_ERR(em);
> +       ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical=
,
> +                                   map_length, &geom);
>         if (ret < 0)
> -               return ret;
> +               goto out;
>
> -       if (geom.len < length + size)
> -               return 1;
> -       return 0;
> +       if (geom.len < length + size) {
> +               ret =3D 1;
> +               goto out;
> +       }
> +out:
> +       free_extent_map(em);
> +       return ret;
>  }
>
>  /*
> @@ -7941,10 +7949,12 @@ static blk_qc_t btrfs_submit_direct(struct inode =
*inode, struct iomap *iomap,
>         u64 submit_len;
>         int clone_offset =3D 0;
>         int clone_len;
> +       int logical;
>         int ret;
>         blk_status_t status;
>         struct btrfs_io_geometry geom;
>         struct btrfs_dio_data *dio_data =3D iomap->private;
> +       struct extent_map *em;
>
>         dip =3D btrfs_create_dio_private(dio_bio, inode, file_offset);
>         if (!dip) {
> @@ -7970,11 +7980,18 @@ static blk_qc_t btrfs_submit_direct(struct inode =
*inode, struct iomap *iomap,
>         }
>
>         start_sector =3D dio_bio->bi_iter.bi_sector;
> +       logical =3D start_sector << 9;
>         submit_len =3D dio_bio->bi_iter.bi_size;
>
>         do {
> -               ret =3D btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
> -                                           start_sector << 9, submit_len=
,
> +               em =3D btrfs_get_chunk_map(fs_info, logical, submit_len);
> +               if (IS_ERR(em)) {
> +                       status =3D errno_to_blk_status(PTR_ERR(em));
> +                       em =3D NULL;
> +                       goto out_err;
> +               }
> +               ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_b=
io),
> +                                           logical, submit_len,
>                                             &geom);
>                 if (ret) {
>                         status =3D errno_to_blk_status(ret);
> @@ -8030,12 +8047,15 @@ static blk_qc_t btrfs_submit_direct(struct inode =
*inode, struct iomap *iomap,
>                 clone_offset +=3D clone_len;
>                 start_sector +=3D clone_len >> 9;
>                 file_offset +=3D clone_len;
> +
> +               free_extent_map(em);
>         } while (submit_len > 0);
>         return BLK_QC_T_NONE;
>
>  out_err:
>         dip->dio_bio->bi_status =3D status;
>         btrfs_dio_private_put(dip);
> +       free_extent_map(em);
>         return BLK_QC_T_NONE;
>  }
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a8ec8539cd8d..4c753b17c0a2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5940,23 +5940,24 @@ static bool need_full_stripe(enum btrfs_map_op op=
)
>  }
>
>  /*
> - * btrfs_get_io_geometry - calculates the geomery of a particular (addre=
ss, len)
> + * btrfs_get_io_geometry - calculates the geometry of a particular (addr=
ess, len)
>   *                    tuple. This information is used to calculate how b=
ig a
>   *                    particular bio can get before it straddles a strip=
e.
>   *
> - * @fs_info - the filesystem
> - * @logical - address that we want to figure out the geometry of
> - * @len            - the length of IO we are going to perform, starting =
at @logical
> - * @op      - type of operation - write or read
> - * @io_geom - pointer used to return values
> + * @fs_info: the filesystem
> + * @em:      mapping containing the logical extent
> + * @op:      type of operation - write or read
> + * @logical: address that we want to figure out the geometry of
> + * @len:     the length of IO we are going to perform, starting at @logi=
cal
> + * @io_geom: pointer used to return values
>   *
>   * Returns < 0 in case a chunk for the given logical address cannot be f=
ound,
>   * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
>   */
> -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_=
op op,
> -                       u64 logical, u64 len, struct btrfs_io_geometry *i=
o_geom)
> +int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_m=
ap *em,
> +                         enum btrfs_map_op op, u64 logical, u64 len,
> +                         struct btrfs_io_geometry *io_geom)
>  {
> -       struct extent_map *em;
>         struct map_lookup *map;
>         u64 offset;
>         u64 stripe_offset;
> @@ -5964,14 +5965,9 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs=
_info, enum btrfs_map_op op,
>         u64 stripe_len;
>         u64 raid56_full_stripe_start =3D (u64)-1;
>         int data_stripes;
> -       int ret =3D 0;
>
>         ASSERT(op !=3D BTRFS_MAP_DISCARD);
>
> -       em =3D btrfs_get_chunk_map(fs_info, logical, len);
> -       if (IS_ERR(em))
> -               return PTR_ERR(em);
> -
>         map =3D em->map_lookup;
>         /* Offset of this logical address in the chunk */
>         offset =3D logical - em->start;
> @@ -5985,8 +5981,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_=
info, enum btrfs_map_op op,
>                 btrfs_crit(fs_info,
>  "stripe math has gone wrong, stripe_offset=3D%llu offset=3D%llu start=3D=
%llu logical=3D%llu stripe_len=3D%llu",
>                         stripe_offset, offset, em->start, logical, stripe=
_len);
> -               ret =3D -EINVAL;
> -               goto out;
> +               return -EINVAL;
>         }
>
>         /* stripe_offset is the offset of this block in its stripe */
> @@ -6033,10 +6028,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs=
_info, enum btrfs_map_op op,
>         io_geom->stripe_offset =3D stripe_offset;
>         io_geom->raid56_stripe_offset =3D raid56_full_stripe_start;
>
> -out:
> -       /* once for us */
> -       free_extent_map(em);
> -       return ret;
> +       return 0;
>  }
>
>  static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
> @@ -6069,12 +6061,13 @@ static int __btrfs_map_block(struct btrfs_fs_info=
 *fs_info,
>         ASSERT(bbio_ret);
>         ASSERT(op !=3D BTRFS_MAP_DISCARD);
>
> -       ret =3D btrfs_get_io_geometry(fs_info, op, logical, *length, &geo=
m);
> +       em =3D btrfs_get_chunk_map(fs_info, logical, *length);
> +       ASSERT(!IS_ERR(em));
> +
> +       ret =3D btrfs_get_io_geometry(fs_info, em, op, logical, *length, =
&geom);
>         if (ret < 0)
>                 return ret;
>
> -       em =3D btrfs_get_chunk_map(fs_info, logical, *length);
> -       ASSERT(!IS_ERR(em));
>         map =3D em->map_lookup;
>
>         *length =3D geom.len;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index c43663d9c22e..04e2b26823c2 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -440,8 +440,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, en=
um btrfs_map_op op,
>  int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op=
,
>                      u64 logical, u64 *length,
>                      struct btrfs_bio **bbio_ret);
> -int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_=
op op,
> -               u64 logical, u64 len, struct btrfs_io_geometry *io_geom);
> +int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_m=
ap *map,
> +                         enum btrfs_map_op op, u64 logical, u64 len,
> +                         struct btrfs_io_geometry *io_geom);
>  int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
>  int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
>  int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
