Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EDE2FE7B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 11:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbhAUKfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 05:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbhAUKda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 05:33:30 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435A6C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jan 2021 02:32:49 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id bd6so644915qvb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jan 2021 02:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cM25RxbX8aV/gSmqqSh5bkjFxEYBU7Tr/l2zfNY86Mc=;
        b=J3+RvaSOkt0SVAIblnQocl79m0xF0x8ovpizCGcdaVTB3LPA/xrw7IF8PGu1JL2DYB
         1actk1VmCiPh8Y5kEQY53zghEttjXvTs+rmqCVDR1pQ77jN8rVqroM1PLXB9Eo2nriOm
         HKlyvVm6g0m9NFtlItKQ+OVoMeD2rHmftzpPeoToJbwvw+mcxfzqAA8o5uLjl7QwX4Cv
         w0JwhbGghZGG524VKIku1tzCgC/33xE4gk542jQLAf6ezGzX06AlFMfjULXI+vqQ/42Z
         XOVGA2YXs2vVL1wkYePJQMbMaVhNqlb7hFRvw0oE9ye89J+MioOYfqHifxr1QemGyy+y
         Bh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cM25RxbX8aV/gSmqqSh5bkjFxEYBU7Tr/l2zfNY86Mc=;
        b=Er9yBdnuNdIjCfmy1L5sp4M1RZJMeDJD2JTV94FYyHa/eFlpPtZri1ta4im71gjkvk
         Ho0h27svwNifw5+lSORPsmLpcYAb8cGfCok2H/yovvrd2hFsYJ/0rrcokhvKO08VMLvV
         ZTt7a1i4kk4029A7RlPkKe2kKLbPxbASmhfVV+55IQjcxlI6YAvy3vnf1SxCu0FEpCC6
         rqFXeihsDbewhFCx9OpaoDvM6twd7Q9ZFGZlv0Vz8kvl46znxbU3aj2qX7/wL3xZqAA/
         pQDIYudlJeh9Fxer+8fKGwhKJEIKGU1Qe4QzzA2+EUR7iPTp3Urld0wB2sETUY2y8e8h
         QnKQ==
X-Gm-Message-State: AOAM530TgZn5Bh0fVC0agt0fQeDRi2UO7OO5awoi7UpaILvHWFnOi53+
        a5nKNowPSAH5c7OHdN1vtoOKNj9kALf7r6HFJZI=
X-Google-Smtp-Source: ABdhPJy3sDZK2f2aud5Ik1dVes0TZ4PY7/irp+Kekneqx+QSOlI7YYKvCEKGgPln56XOQkWyp+3eQVTwyFuKPz1JOeI=
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr13497315qvs.62.1611225168424;
 Thu, 21 Jan 2021 02:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20210121061354.61271-1-wqu@suse.com>
In-Reply-To: <20210121061354.61271-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 21 Jan 2021 10:32:37 +0000
Message-ID: <CAL3q7H4Pa1P71EVGQBV+sXiXN62obRbA8b-8WMhgarjLaYk7zA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: rework the order of btrfs_ordered_extent::flags
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 6:27 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a long existing bug in the last parameter of
> btrfs_add_ordered_extent(), in commit 771ed689d2cd ("Btrfs: Optimize
> compressed writeback and reads") back to 2008.
>
> In that ancient commit btrfs_add_ordered_extent() expects the @type
> parameter to be one of the following:
> - BTRFS_ORDERED_REGULAR
> - BTRFS_ORDERED_NOCOW
> - BTRFS_ORDERED_PREALLOC
> - BTRFS_ORDERED_COMPRESSED
>
> But we pass 0 in cow_file_range(), which means BTRFS_ORDERED_IO_DONE.
>
> Ironically extra check in __btrfs_add_ordered_extent() won't set the bit
> if we're seeing (type =3D=3D IO_DONE || type =3D=3D IO_COMPLETE), and avo=
id any
> obvious bug.
>
> But this still leads to regular COW ordered extent having no bit to
> indicate its type in various trace events, rendering REGULAR bit
> useless.
>
> [FIX]
> This patch will change the following aspects to avoid such problem:
> - Reorder btrfs_ordered_extent::flags
>   Now the type bits go first (REGULAR/NOCOW/PREALLCO/COMPRESSED), then
>   DIRECT bit, finally extra status bits like IO_DONE/COMPLETE/IOERR.
>
> - Add extra ASSERT() for btrfs_add_ordered_extent_*()
>
> - Remove @type parameter for btrfs_add_ordered_extent_compress()
>   As the only valid @type here is BTRFS_ORDERED_COMPRESSED.
>
> - Remove the unnecessary special check for IO_DONE/COMPLETE in
>   __btrfs_add_ordered_extent()
>   This is just to make the code work, with extra ASSERT(), there are
>   limited values can be passed in.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c             |  4 ++--
>  fs/btrfs/ordered-data.c      | 18 +++++++++++++-----
>  fs/btrfs/ordered-data.h      | 37 +++++++++++++++++++++++-------------
>  include/trace/events/btrfs.h |  7 ++++---
>  4 files changed, 43 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ef6cb7b620d0..ea9056cc5559 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -917,7 +917,6 @@ static noinline void submit_compressed_extents(struct=
 async_chunk *async_chunk)
>                                                 ins.objectid,
>                                                 async_extent->ram_size,
>                                                 ins.offset,
> -                                               BTRFS_ORDERED_COMPRESSED,
>                                                 async_extent->compress_ty=
pe);
>                 if (ret) {
>                         btrfs_drop_extent_cache(inode, async_extent->star=
t,
> @@ -1127,7 +1126,8 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                 free_extent_map(em);
>
>                 ret =3D btrfs_add_ordered_extent(inode, start, ins.object=
id,
> -                                              ram_size, cur_alloc_size, =
0);
> +                                              ram_size, cur_alloc_size,
> +                                              BTRFS_ORDERED_REGULAR);
>                 if (ret)
>                         goto out_drop_extent_cache;
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index d5d326c674b1..bd7e187d9b16 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -199,8 +199,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_i=
node *inode, u64 file_offset
>         entry->compress_type =3D compress_type;
>         entry->truncated_len =3D (u64)-1;
>         entry->qgroup_rsv =3D ret;
> -       if (type !=3D BTRFS_ORDERED_IO_DONE && type !=3D BTRFS_ORDERED_CO=
MPLETE)
> -               set_bit(type, &entry->flags);
> +
> +       ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
> +              type =3D=3D BTRFS_ORDERED_PREALLOC ||
> +              type =3D=3D BTRFS_ORDERED_COMPRESSED);
> +       set_bit(type, &entry->flags);
>
>         if (dio) {
>                 percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
> @@ -256,6 +259,8 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inod=
e, u64 file_offset,
>                              u64 disk_bytenr, u64 num_bytes, u64 disk_num=
_bytes,
>                              int type)
>  {
> +       ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
> +              type =3D=3D BTRFS_ORDERED_PREALLOC);
>         return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr=
,
>                                           num_bytes, disk_num_bytes, type=
, 0,
>                                           BTRFS_COMPRESS_NONE);
> @@ -265,6 +270,8 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *=
inode, u64 file_offset,
>                                  u64 disk_bytenr, u64 num_bytes,
>                                  u64 disk_num_bytes, int type)
>  {
> +       ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
> +              type =3D=3D BTRFS_ORDERED_PREALLOC);
>         return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr=
,
>                                           num_bytes, disk_num_bytes, type=
, 1,
>                                           BTRFS_COMPRESS_NONE);
> @@ -272,11 +279,12 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode=
 *inode, u64 file_offset,
>
>  int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 fil=
e_offset,
>                                       u64 disk_bytenr, u64 num_bytes,
> -                                     u64 disk_num_bytes, int type,
> -                                     int compress_type)
> +                                     u64 disk_num_bytes, int compress_ty=
pe)
>  {
> +       ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
>         return __btrfs_add_ordered_extent(inode, file_offset, disk_bytenr=
,
> -                                         num_bytes, disk_num_bytes, type=
, 0,
> +                                         num_bytes, disk_num_bytes,
> +                                         BTRFS_ORDERED_COMPRESSED, 0,
>                                           compress_type);
>  }
>
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 46194c2c05d4..151ec6bba405 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
>  };
>
>  /*
> - * bits for the flags field:
> + * Bits for btrfs_ordered_extent::flags.
>   *
>   * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
>   * It is used to make sure metadata is inserted into the tree only once
> @@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
>   * IO is done and any metadata is inserted into the tree.
>   */
>  enum {
> +       /*
> +        * Different types for direct io, one and only one of the 4 type =
can

Different types for both buffered and direct IO (except the compressed type=
).

Also "4 type" -> "4 types".

Other than that, it looks good, thanks.

> +        * be set when creating ordered extent.
> +        *
> +        * REGULAR:     For regular non-compressed COW write
> +        * NOCOW:       For NOCOW write into existing non-hole extent
> +        * PREALLOC:    For NOCOW write into preallocated extent
> +        * COMPRESSED:  For compressed COW write
> +        */
> +       BTRFS_ORDERED_REGULAR,
> +       BTRFS_ORDERED_NOCOW,
> +       BTRFS_ORDERED_PREALLOC,
> +       BTRFS_ORDERED_COMPRESSED,
> +
> +       /*
> +        * Extra bit for DirectIO, can only be set for
> +        * REGULAR/NOCOW/PREALLOC. No DIO for compressed extent.
> +        */
> +       BTRFS_ORDERED_DIRECT,
> +
> +       /* Extra status bits for ordered extents */
> +
>         /* set when all the pages are written */
>         BTRFS_ORDERED_IO_DONE,
>         /* set when removed from the tree */
>         BTRFS_ORDERED_COMPLETE,
> -       /* set when we want to write in place */
> -       BTRFS_ORDERED_NOCOW,
> -       /* writing a zlib compressed extent */
> -       BTRFS_ORDERED_COMPRESSED,
> -       /* set when writing to preallocated extent */
> -       BTRFS_ORDERED_PREALLOC,
> -       /* set when we're doing DIO with this extent */
> -       BTRFS_ORDERED_DIRECT,
>         /* We had an io error when writing this out */
>         BTRFS_ORDERED_IOERR,
>         /* Set when we have to truncate an extent */
>         BTRFS_ORDERED_TRUNCATED,
> -       /* Regular IO for COW */
> -       BTRFS_ORDERED_REGULAR,
>         /* Used during fsync to track already logged extents */
>         BTRFS_ORDERED_LOGGED,
>         /* We have already logged all the csums of the ordered extent */
> @@ -167,8 +179,7 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode *=
inode, u64 file_offset,
>                                  u64 disk_num_bytes, int type);
>  int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 fil=
e_offset,
>                                       u64 disk_bytenr, u64 num_bytes,
> -                                     u64 disk_num_bytes, int type,
> -                                     int compress_type);
> +                                     u64 disk_num_bytes, int compress_ty=
pe);
>  void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>                            struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_in=
ode *inode,
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index ecd24c719de4..b9896fc06160 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -499,12 +499,13 @@ DEFINE_EVENT(
>
>  #define show_ordered_flags(flags)                                       =
  \
>         __print_flags(flags, "|",                                        =
  \
> -               { (1 << BTRFS_ORDERED_IO_DONE),         "IO_DONE"       }=
, \
> -               { (1 << BTRFS_ORDERED_COMPLETE),        "COMPLETE"      }=
, \
> +               { (1 << BTRFS_ORDERED_REGULAR),         "REGULAR"       }=
, \
>                 { (1 << BTRFS_ORDERED_NOCOW),           "NOCOW"         }=
, \
> -               { (1 << BTRFS_ORDERED_COMPRESSED),      "COMPRESSED"    }=
, \
>                 { (1 << BTRFS_ORDERED_PREALLOC),        "PREALLOC"      }=
, \
> +               { (1 << BTRFS_ORDERED_COMPRESSED),      "COMPRESSED"    }=
, \
>                 { (1 << BTRFS_ORDERED_DIRECT),          "DIRECT"        }=
, \
> +               { (1 << BTRFS_ORDERED_IO_DONE),         "IO_DONE"       }=
, \
> +               { (1 << BTRFS_ORDERED_COMPLETE),        "COMPLETE"      }=
, \
>                 { (1 << BTRFS_ORDERED_IOERR),           "IOERR"         }=
, \
>                 { (1 << BTRFS_ORDERED_TRUNCATED),       "TRUNCATED"     }=
)
>
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
