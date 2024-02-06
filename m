Return-Path: <linux-btrfs+bounces-2165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DAD84BB8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A697C1C23F27
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FFE560;
	Tue,  6 Feb 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTQ+VvgH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454DDF5B
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239050; cv=none; b=jtB0uKYoTG+SMKzt0I3wsoYkygelSMSO/uNJwPB53cIqA6zxT7maCDInjTh0HecfMVvkZ6ZZDvFjpz1txPKZLxrl6F19MsyDWGME7a/hR4+VHyZjRkAWggtgT5qi1xhMjPWfwK4SsDNvGJW+LJPCzEOqxOaJq2KPc3/PG+Fq4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239050; c=relaxed/simple;
	bh=+JPCL1vDrrJxAoc6vBcMPtTeiRRi2Q2rwN5MsNY5h/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=An6RCa5IZGAnaTOfh2xVcwffBBp3/sVMXWBRsUnByew8K2cAj/xQh70YplDvmcwJPCBhViIlxu0MS9DkJhQEDQZz8dJz9V9oxxRQqlpKyI+THcAVlKiZjFrP7R5+x64Ip65wTzZncU+q9RbiK5lr0hjANdWu4u/Y92ppYkg6wkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTQ+VvgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4CCC43390
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707239050;
	bh=+JPCL1vDrrJxAoc6vBcMPtTeiRRi2Q2rwN5MsNY5h/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KTQ+VvgHNgYwtkvZxOJZIc2TuAtJecLuZmsjmuT2z2yiKqgLvtKkbmBQUtDXNxR+C
	 qzp6hSrDhT0RzEXjt8AzMKoNn8w13g1FKcioZj/uWusiJi0nxk7vX4RxQYrgp2TZYu
	 rI1pZedCTe8F5pSorpEgozRvbjsAWXtkUS1J7tKIdogo1tdzwmqWcJYVmCZW1mc5VF
	 8bTbxKyS3lS5vopR68kPMdAJbRLcyX2Iq2N8ErfTxj0qVldZNRs79xwSZYWGdxzMbs
	 YYE9wxuEMz7tkh7qVrD6JhRierzGL5HN/NA2KBZWeniQ4FuiFWTTlX3IZ7+of3GWVF
	 9oyf4WBGbf6nQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so6864860a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 09:04:10 -0800 (PST)
X-Gm-Message-State: AOJu0Ywld+NyEXMl5xXJRBcqWOCVN65VsJBv/cbsf2PUj5TGbLzTtGK0
	QyM+8zn5FgM9EVeqRxFZ2BNkC1r/d5VMa9ke+EIoFefvEj7QeMW5wh0aY6S92f38KdJTdhlzQ9o
	3Ie8PI570+aggp3DT/U/HwrlqcyE=
X-Google-Smtp-Source: AGHT+IGOUI7LO/QMm3ikiV0Vm2/xV0f/CfmUG9n9WVXgr40EgYl34yLlB+kNhkV1nr2sDTRpetGVZObOwm4aUQ0hEGU=
X-Received: by 2002:a17:906:3108:b0:a37:2652:28bd with SMTP id
 8-20020a170906310800b00a37265228bdmr2077985ejx.35.1707239048648; Tue, 06 Feb
 2024 09:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707172743.git.wqu@suse.com> <1e862826f30ce2de104b66572ddfbfd6e2d398a5.1707172743.git.wqu@suse.com>
In-Reply-To: <1e862826f30ce2de104b66572ddfbfd6e2d398a5.1707172743.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Feb 2024 17:03:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5OcYGdoriDdOissUntv1+6orr6-JM2s6HjXDCqNvk6qw@mail.gmail.com>
Message-ID: <CAL3q7H5OcYGdoriDdOissUntv1+6orr6-JM2s6HjXDCqNvk6qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: defrag: allow fine-tuning on lone extent
 defrag behavior
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Previously we're using a fixed ratio and fixed bytes for lone extents
> defragging, which may not fit all situations.
>
> This patch would enhance the behavior by allowing fine-tuning using some
> extra members inside btrfs_ioctl_defrag_range_args.
>
> This would introduce two flags and two new members:
>
> - BTRFS_DEFRAG_RANGE_LONE_RATIO and BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES
>   With these flags set, defrag would consider lone extents with their
>   utilization ratio and wasted bytes as a defrag condition.
>
> - lone_ratio
>   This is a u32 value, but only [0, 65536] is allowed (still beyond u16
>   range, thus have to go u32).
>   0 means disable lone ratio detection.
>   [1, 65536] means the ratio. If a lone extent is utilizing less than
>   (lone_ratio / 65536) * on-disk size of an extent, it would be
>   considered as a defrag target.
>
> - lone_wasted_bytes
>   This is a u32 value.
>   If we free the lone extent, and can free up to @lone_wasted_bytes
>   (excluding the extent itself), then it would be considered as a defrag
>   target.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/defrag.c          | 40 ++++++++++++++++++++++++--------------
>  fs/btrfs/ioctl.c           |  9 +++++++++
>  include/uapi/linux/btrfs.h | 28 +++++++++++++++++++++-----
>  3 files changed, 57 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 85c6e45d0cd4..3566845ee3e6 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -958,26 +958,28 @@ struct defrag_target_range {
>   * any adjacent ones), but we may still want to defrag them, to free up
>   * some space if possible.
>   */
> -static bool should_defrag_under_utilized(struct extent_map *em)
> +static bool should_defrag_under_utilized(struct extent_map *em, u32 lone=
_ratio,
> +                                        u32 lone_wasted_bytes)
>  {
>         /*
>          * Ratio based check.
>          *
> -        * If the current extent is only utilizing 1/16 of its on-disk si=
ze,
> +        * If the current extent is only utilizing less than
> +        * (%lone_ratio/65536) of its on-disk size,

I really don't understand what this notation "(%lone_ratio/65536)" means...

>          * it's definitely under-utilized, and defragging it may free up
>          * the whole extent.
>          */
> -       if (em->len < em->orig_block_len / 16)
> +       if (lone_ratio && em->len < em->orig_block_len * lone_ratio / 655=
36)

Why don't you use SZ_64K everywhere instead of 65536?

>                 return true;
>
>         /*
>          * Wasted space based check.
>          *
> -        * If we can free up at least 16MiB, then it may be a good idea
> -        * to defrag.
> +        * If we can free up at least @lone_wasted_bytes, then it may be =
a
> +        * good idea to defrag.
>          */
>         if (em->len < em->orig_block_len &&
> -           em->orig_block_len - em->len > SZ_16M)
> +           em->orig_block_len - em->len > lone_wasted_bytes)

According to the comment it should be >=3D. So either fix the comment,
or the comparison.

>                 return true;
>         return false;
>  }
> @@ -998,7 +1000,8 @@ static bool should_defrag_under_utilized(struct exte=
nt_map *em)
>   */
>  static int defrag_collect_targets(struct btrfs_inode *inode,
>                                   u64 start, u64 len, u32 extent_thresh,
> -                                 u64 newer_than, bool do_compress,
> +                                 u64 newer_than, u32 lone_ratio,
> +                                 u32 lone_wasted_bytes, bool do_compress=
,
>                                   bool locked, struct list_head *target_l=
ist,
>                                   u64 *last_scanned_ret)
>  {
> @@ -1109,7 +1112,7 @@ static int defrag_collect_targets(struct btrfs_inod=
e *inode,
>                          * But if we may free up some space, it is still =
worth
>                          * defragging.
>                          */
> -                       if (should_defrag_under_utilized(em))
> +                       if (should_defrag_under_utilized(em, lone_ratio, =
lone_wasted_bytes))
>                                 goto add;
>
>                         /* Empty target list, no way to merge with last e=
ntry */
> @@ -1240,7 +1243,8 @@ static int defrag_one_locked_target(struct btrfs_in=
ode *inode,
>  }
>
>  static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 le=
n,
> -                           u32 extent_thresh, u64 newer_than, bool do_co=
mpress,
> +                           u32 extent_thresh, u64 newer_than,
> +                           u32 lone_ratio, u32 lone_wasted_bytes, bool d=
o_compress,
>                             u64 *last_scanned_ret)
>  {
>         struct extent_state *cached_state =3D NULL;
> @@ -1286,7 +1290,8 @@ static int defrag_one_range(struct btrfs_inode *ino=
de, u64 start, u32 len,
>          * so that we won't relock the extent range and cause deadlock.
>          */
>         ret =3D defrag_collect_targets(inode, start, len, extent_thresh,
> -                                    newer_than, do_compress, true,
> +                                    newer_than, lone_ratio, lone_wasted_=
bytes,
> +                                    do_compress, true,
>                                      &target_list, last_scanned_ret);
>         if (ret < 0)
>                 goto unlock_extent;
> @@ -1318,7 +1323,9 @@ static int defrag_one_range(struct btrfs_inode *ino=
de, u64 start, u32 len,
>  static int defrag_one_cluster(struct btrfs_inode *inode,
>                               struct file_ra_state *ra,
>                               u64 start, u32 len, u32 extent_thresh,
> -                             u64 newer_than, bool do_compress,
> +                             u64 newer_than, u32 lone_ratio,
> +                             u32 lone_wasted_bytes,
> +                             bool do_compress,
>                               unsigned long *sectors_defragged,
>                               unsigned long max_sectors,
>                               u64 *last_scanned_ret)
> @@ -1330,8 +1337,8 @@ static int defrag_one_cluster(struct btrfs_inode *i=
node,
>         int ret;
>
>         ret =3D defrag_collect_targets(inode, start, len, extent_thresh,
> -                                    newer_than, do_compress, false,
> -                                    &target_list, NULL);
> +                                    newer_than, lone_ratio, lone_wasted_=
bytes,
> +                                    do_compress, false, &target_list, NU=
LL);
>         if (ret < 0)
>                 goto out;
>
> @@ -1369,7 +1376,8 @@ static int defrag_one_cluster(struct btrfs_inode *i=
node,
>                  * accounting.
>                  */
>                 ret =3D defrag_one_range(inode, entry->start, range_len,
> -                                      extent_thresh, newer_than, do_comp=
ress,
> +                                      extent_thresh, newer_than, lone_ra=
tio,
> +                                      lone_wasted_bytes, do_compress,
>                                        last_scanned_ret);
>                 if (ret < 0)
>                         break;
> @@ -1495,7 +1503,9 @@ int btrfs_defrag_file(struct inode *inode, struct f=
ile_ra_state *ra,
>                         BTRFS_I(inode)->defrag_compress =3D compress_type=
;
>                 ret =3D defrag_one_cluster(BTRFS_I(inode), ra, cur,
>                                 cluster_end + 1 - cur, extent_thresh,
> -                               newer_than, do_compress, &sectors_defragg=
ed,
> +                               newer_than, range->lone_ratio,
> +                               range->lone_wasted_bytes, do_compress,
> +                               &sectors_defragged,
>                                 max_to_defrag, &last_scanned);
>
>                 if (sectors_defragged > prev_sectors_defragged)
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 46f9a6645bf6..d2d9b6d440b3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2616,6 +2616,15 @@ static int btrfs_ioctl_defrag(struct file *file, v=
oid __user *argp)
>                                 range.flags |=3D BTRFS_DEFRAG_RANGE_START=
_IO;
>                                 range.extent_thresh =3D (u32)-1;
>                         }
> +
> +                       if (!(range.flags & BTRFS_DEFRAG_RANGE_LONE_RATIO=
))
> +                               range.lone_ratio =3D 0;
> +                       else if (range.lone_ratio > 65536) {
> +                               ret =3D -EINVAL;
> +                               goto out;
> +                       }
> +                       if (!(range.flags & BTRFS_DEFRAG_RANGE_LONE_RATIO=
))
> +                               range.lone_wasted_bytes =3D U32_MAX;
>                 } else {
>                         /* the rest are all set to zero by kzalloc */
>                         range.len =3D (u64)-1;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index f8bc34a6bcfa..3d5517c33f42 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -612,10 +612,14 @@ struct btrfs_ioctl_clone_range_args {
>   * Used by:
>   * struct btrfs_ioctl_defrag_range_args.flags
>   */
> -#define BTRFS_DEFRAG_RANGE_COMPRESS 1
> -#define BTRFS_DEFRAG_RANGE_START_IO 2
> -#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP  (BTRFS_DEFRAG_RANGE_COMPRESS |   =
       \
> -                                        BTRFS_DEFRAG_RANGE_START_IO)
> +#define BTRFS_DEFRAG_RANGE_COMPRESS            (1ULL << 0)
> +#define BTRFS_DEFRAG_RANGE_START_IO            (1ULL << 1)
> +#define BTRFS_DEFRAG_RANGE_LONE_RATIO          (1ULL << 2)
> +#define BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES   (1ULL << 3)
> +#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP  (BTRFS_DEFRAG_RANGE_COMPRESS |  \
> +                                        BTRFS_DEFRAG_RANGE_START_IO |  \
> +                                        BTRFS_DEFRAG_RANGE_LONE_RATIO |\
> +                                        BTRFS_DEFRAG_RANGE_LONE_WASTED_B=
YTES)
>
>  struct btrfs_ioctl_defrag_range_args {
>         /* start of the defrag operation */
> @@ -644,8 +648,22 @@ struct btrfs_ioctl_defrag_range_args {
>          */
>         __u32 compress_type;
>
> +       /*
> +        * If a lone extent (has no adjacent file extent) is utilizing le=
ss
> +        * than the ratio (0 means 0%, while 65536 means 100%) of the on-=
disk
> +        * space, it would be considered as a defrag target.
> +        */
> +       __u32 lone_ratio;
> +
> +       /*
> +        * If we defrag a lone extent (has no adjacent file extent) can f=
ree

Using this term "lone" is confusing for me, and this description also
suggests it's about a file with only one extent.
I would call it wasted_ratio, and the other one wasted_bytes, without
the "lone" in the name.

Because a case like this:

xfs_io -f -c "pwrite 0 4K" $MNT/foobar
sync
xfs_io -c "pwrite 8K 128M" $MNT/foobar
sync
xfs_io -c "truncate 16K" $MNT/foobar
btrfs filesystem defrag $MNT/foobar

There's an adjacent extent, it's simply not mergeable, but we want to
rewrite the second extent to avoid pinning 128M - 8K of data space.
A similar example with a next extent that is not mergeable is also
doable, or examples with previous and next extents that aren't
mergeable.

And I still don't get the logic of using 65536... Why not have the
ratio as an integer between 0 and 99? That's a lot more intuitive
IMO...

Thanks.

> +        * up more space than this value (in bytes), it would be consider=
ed
> +        * as a defrag target.
> +        */
> +       __u32 lone_wasted_bytes;
> +
>         /* spare for later */
> -       __u32 unused[4];
> +       __u32 unused[2];
>  };
>
>
> --
> 2.43.0
>
>

