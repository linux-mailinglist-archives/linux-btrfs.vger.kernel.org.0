Return-Path: <linux-btrfs+bounces-4141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B48A17C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8843C1C22EFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579FDF5C;
	Thu, 11 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIezUnkq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AEDDCB
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846854; cv=none; b=IMb1OGxhUJxsX6QK5V65PhWPuw95Dk4DDFJW2xvQpnu/B0Uk3lH/nWpvcjTsAzPj6o8jX/emQazsHjukP2xowwPc7wTFQSz036tNWFG4EFTwwH0T2ngiJYkwddwAhm/blhcFSPpSSqyAo47qcX877SNXO8Z/gOdGyZqNQj9nbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846854; c=relaxed/simple;
	bh=7YDyI9d4miIcW9oKPRe0P5Uiy2byaFEhIoK5Au7OTB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ogxb9Pm55YMRofywRI8eh1SP9w8y0h/A1gPv/RMk+bDQQ91bWcuGh0jX1bdEmrm/JA0UaNIR5nK5tGX4DlIUP1ScRY+5mfbZYZ1PpsVI8KyzdkLsAwKzwuDAh2XN3y8tHXWS8xnmEdPy/mU4Q+uwBbi+uZZgISJ6B+RKufA3eQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIezUnkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE76C2BD11
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712846854;
	bh=7YDyI9d4miIcW9oKPRe0P5Uiy2byaFEhIoK5Au7OTB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LIezUnkqP2hR5LEH/u3p3M+8Lj9TVZWHCw0UvnZ0G651SXYygxIOXi3Rni/CDrzrW
	 8JVRBIRIDXCHMMUbeSXM49wNDvIbocoPW2GjFeKb9PbHLnw0VgI2WEukaWGn7CsNzF
	 exA2i1PUXDtaSUwHl6mr9OARtH3DvxRMjIq1pTAn3NFxEUR2U2QKWFnbAdQZv082/F
	 8/7CSVvGMlspcSz1Z4jKWL0wERlieSojXEZ7xVLK+TwdOnDzj2A5NXTP+7isVXdW5V
	 o52hIA9tSLB6Lwbxv1JPczkYWFvILMLh1Fj6qhohVHhAT+asUc5Enk3hDBJXrOvEzo
	 Mdo/tS11gNlrg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44f2d894b7so900158266b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 07:47:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwL1kUQwAkhloHxk328S5UXrGYKoSQmHnPGpmumEw+tO0yRMIHo
	aLnf20exNjM12lcMDw8v9HOkFZUPnoZpM+ZZYAcAt3aqvQlK7gdwQgV05c6E74Ycts0QQ109Yzc
	TVEigiNs0MUngqofCKqminaUnxdg=
X-Google-Smtp-Source: AGHT+IHhCozNWvDO0LH0lM00klosfNpA8MrPX0Efn2KvDf7E7qMhlywsYdffLbnPwkQTFuXxbr132gD1tkHFpLMcrQI=
X-Received: by 2002:a17:907:930e:b0:a4e:23a1:9ede with SMTP id
 bu14-20020a170907930e00b00a4e23a19edemr4401039ejc.36.1712846852709; Thu, 11
 Apr 2024 07:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712614770.git.wqu@suse.com> <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
In-Reply-To: <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Apr 2024 15:46:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com>
Message-ID: <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] btrfs: rename members of can_nocow_file_extent_args
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:34=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> The structure can_nocow_file_extent_args is utilized to provide the
> needed info for a NOCOW writes.
>
> However some of its members are pretty confusing.
> For example, @disk_bytenr is not btrfs_file_extent_item::disk_bytenr,
> but with extra offset, thus it works more like extent_map::block_start.
>
> This patch would:
>
> - Rename members directly fetched from btrfs_file_extent_item
>   The new name would have "orig_" prefix, with the same member name from
>   btrfs_file_extent_item.
>
> - For the old @disk_bytenr, rename it to @block_start
>   As it's directly passed into create_io_em() as @block_start.

So I find these new names more confusing actually.

So the existing names reflect fields from struct
btrfs_file_extent_item, because NOCOW checks are always done against
the range of a file extent item, therefore the existing naming.

Sometimes it may be against the whole range of the extent item,
sometimes only a part of it, in which case disk_bytenr is incremented
by offsets.

This is the same logic with struct btrfs_ordered_extent: for a NOCOW
write disk_bytenr may either match the disk_bytenr of an existing file
extent item or it's adjusted by some offset in case it covers only
part of the extent item.

So currently we are both consistent with btrfs_ordered_extent besides
the fact the NOCOW checks are done against a file extent item.

I particularly find block_start not intuitive - block? Is it a block
number? What's the size of the block? Etc.
disk_bytenr is a lot more clear - it's a disk address in bytes.

>
> - Add extra comments explaining those members
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 51 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2e0156943c7c..4d207c3b38d9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1847,11 +1847,20 @@ struct can_nocow_file_extent_args {
>          */
>         bool free_path;
>
> -       /* Output fields. Only set when can_nocow_file_extent() returns 1=
. */
> +       /*
> +        * Output fields. Only set when can_nocow_file_extent() returns 1=
.
> +        *
> +        * @block_start:        The bytenr of the new nocow write should =
be at.
> +        * @orig_disk_bytenr:   The original data extent's disk_bytenr.

This orig_disk_bytenr field is not defined anywhere in this patch.

Thanks.

> +        * @orig_disk_num_bytes:The original data extent's disk_num_bytes=
.
> +        * @orig_offset:        The original offset inside the old data e=
xtent.
> +        *                      Caller should calculate their own
> +        *                      btrfs_file_extent_item::offset base on th=
is.
> +        */
>
> -       u64 disk_bytenr;
> -       u64 disk_num_bytes;
> -       u64 extent_offset;
> +       u64 block_start;
> +       u64 orig_disk_num_bytes;
> +       u64 orig_offset;
>         /* Number of bytes that can be written to in NOCOW mode. */
>         u64 num_bytes;
>  };
> @@ -1887,9 +1896,9 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>                 goto out;
>
>         /* Can't access these fields unless we know it's not an inline ex=
tent. */
> -       args->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> -       args->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(leaf, f=
i);
> -       args->extent_offset =3D btrfs_file_extent_offset(leaf, fi);
> +       args->block_start =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> +       args->orig_disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(le=
af, fi);
> +       args->orig_offset =3D btrfs_file_extent_offset(leaf, fi);
>
>         if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
>             extent_type =3D=3D BTRFS_FILE_EXTENT_REG)
> @@ -1906,7 +1915,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>                 goto out;
>
>         /* An explicit hole, must COW. */
> -       if (args->disk_bytenr =3D=3D 0)
> +       if (args->block_start =3D=3D 0)
>                 goto out;
>
>         /* Compressed/encrypted/encoded extents must be COWed. */
> @@ -1925,8 +1934,8 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>         btrfs_release_path(path);
>
>         ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
> -                                   key->offset - args->extent_offset,
> -                                   args->disk_bytenr, args->strict, path=
);
> +                                   key->offset - args->orig_offset,
> +                                   args->block_start, args->strict, path=
);
>         WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>         if (ret !=3D 0)
>                 goto out;
> @@ -1947,15 +1956,15 @@ static int can_nocow_file_extent(struct btrfs_pat=
h *path,
>             atomic_read(&root->snapshot_force_cow))
>                 goto out;
>
> -       args->disk_bytenr +=3D args->extent_offset;
> -       args->disk_bytenr +=3D args->start - key->offset;
> +       args->block_start +=3D args->orig_offset;
> +       args->block_start +=3D args->start - key->offset;
>         args->num_bytes =3D min(args->end + 1, extent_end) - args->start;
>
>         /*
>          * Force COW if csums exist in the range. This ensures that csums=
 for a
>          * given extent are either valid or do not exist.
>          */
> -       ret =3D csum_exist_in_range(root->fs_info, args->disk_bytenr, arg=
s->num_bytes,
> +       ret =3D csum_exist_in_range(root->fs_info, args->block_start, arg=
s->num_bytes,
>                                   nowait);
>         WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>         if (ret !=3D 0)
> @@ -2112,7 +2121,7 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>                         goto must_cow;
>
>                 ret =3D 0;
> -               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_args.=
disk_bytenr);
> +               nocow_bg =3D btrfs_inc_nocow_writers(fs_info, nocow_args.=
block_start);
>                 if (!nocow_bg) {
>  must_cow:
>                         /*
> @@ -2151,14 +2160,14 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>                 nocow_end =3D cur_offset + nocow_args.num_bytes - 1;
>                 is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTENT_PREA=
LLOC;
>                 if (is_prealloc) {
> -                       u64 orig_start =3D found_key.offset - nocow_args.=
extent_offset;
> +                       u64 orig_start =3D found_key.offset - nocow_args.=
orig_offset;
>                         struct extent_map *em;
>
>                         em =3D create_io_em(inode, cur_offset, nocow_args=
.num_bytes,
>                                           orig_start,
> -                                         nocow_args.disk_bytenr, /* bloc=
k_start */
> +                                         nocow_args.block_start, /* bloc=
k_start */
>                                           nocow_args.num_bytes, /* block_=
len */
> -                                         nocow_args.disk_num_bytes, /* o=
rig_block_len */
> +                                         nocow_args.orig_disk_num_bytes,=
 /* orig_block_len */
>                                           ram_bytes, BTRFS_COMPRESS_NONE,
>                                           BTRFS_ORDERED_PREALLOC);
>                         if (IS_ERR(em)) {
> @@ -2171,7 +2180,7 @@ static noinline int run_delalloc_nocow(struct btrfs=
_inode *inode,
>
>                 ordered =3D btrfs_alloc_ordered_extent(inode, cur_offset,
>                                 nocow_args.num_bytes, nocow_args.num_byte=
s,
> -                               nocow_args.disk_bytenr, nocow_args.num_by=
tes, 0,
> +                               nocow_args.block_start, nocow_args.num_by=
tes, 0,
>                                 is_prealloc
>                                 ? (1 << BTRFS_ORDERED_PREALLOC)
>                                 : (1 << BTRFS_ORDERED_NOCOW),
> @@ -7189,7 +7198,7 @@ noinline int can_nocow_extent(struct inode *inode, =
u64 offset, u64 *len,
>         }
>
>         ret =3D 0;
> -       if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
> +       if (btrfs_extent_readonly(fs_info, nocow_args.block_start))
>                 goto out;
>
>         if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
> @@ -7206,9 +7215,9 @@ noinline int can_nocow_extent(struct inode *inode, =
u64 offset, u64 *len,
>         }
>
>         if (orig_start)
> -               *orig_start =3D key.offset - nocow_args.extent_offset;
> +               *orig_start =3D key.offset - nocow_args.orig_offset;
>         if (orig_block_len)
> -               *orig_block_len =3D nocow_args.disk_num_bytes;
> +               *orig_block_len =3D nocow_args.orig_disk_num_bytes;
>
>         *len =3D nocow_args.num_bytes;
>         ret =3D 1;
> --
> 2.44.0
>
>

