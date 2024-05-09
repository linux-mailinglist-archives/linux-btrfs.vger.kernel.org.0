Return-Path: <linux-btrfs+bounces-4870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F38C1294
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BF31F22447
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006716F851;
	Thu,  9 May 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blJNV+Nb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6EB50A6C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271367; cv=none; b=bTlHuqvarzd4TorK6FaClMARNjQDX3vh6IwC6FVEroahnQNm4z8WE6ayKFFAzHiqFtXo/rCrAQy9GVgwwp1IITdkbb2zOqTyZT8sYHkDrRAMZwG+miC+QfYsQcB0ViZ5TJq6pnnqmSq3d/K1EbM4NicjfCD0R9ugdoxS9CI6byI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271367; c=relaxed/simple;
	bh=BGC7lEim1Sjo+7VDLRGZAu68pnAHrRzIPambLPDsJv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqJ8MN6ZA71S++iXh1ZF4VZU/LzK+HY3e0wcTGCm1zlDlVqWTnbvhMkwIataah4UyDYELYe1wtXqCCfHVDwmMV2higaOtQ3ywJTZG6EpH4Fw9YHXStpjqaNIDiHhaxautDrNgkhsx9ruzJ0r+XiHZ/REHTW1vcHbbdmeOP5oIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blJNV+Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C810BC2BD11
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271366;
	bh=BGC7lEim1Sjo+7VDLRGZAu68pnAHrRzIPambLPDsJv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=blJNV+Nb+f/IyKg9TjoxfT7uoac0q+hAXsa0+6/Va2GATuZkbTt6DfL9P6S7obfXp
	 H6FuFMyUa42AJ+RCB38jO3jM6cgHyN0XuXTgnd+3huRDP/qxsrBd9ZXN+IGKksDBDX
	 uxNkgF1MMRZPP26M+ciPBKEwrVOnAobThZiPHFF05jLbR1R3E3z1R/h1yuWcwvU0D4
	 hmZ38rVVUl7nCwvOnbGK/ao3mSOvpDt82atn/z7rGEttbvBjseZOcZGG2icP1Z2A4M
	 XHCyFfMCeFRWdk3anvc+/34B459DLljc9pwrWAR0fcIw3Iuj40h+slxIWf7JJ1/w7l
	 8EeRJ8yjRQEXQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51fea3031c3so1466105e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:16:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxn3lM0Xjz7f6an5BnbHlp735JGSEltSmZCmSA9pVwF26258xRJ
	bj27+GDfPiIJFeqVlmuuzSLvyxNV9ohHZWgo3remhJDyia9/XIu4jYrl0V1cfNIZHFyNA1tyTbW
	+l73IJN7TSt3PlmAPtlmmz2lTp+E=
X-Google-Smtp-Source: AGHT+IHxPisVt50j9aPgjmvEkfHill3z8nfO+UlgQWERismciPm7daenh1ah3O5wcSaTnlw7SPcQtYBeIqzstno7hj8=
X-Received: by 2002:a19:7716:0:b0:516:c44a:657d with SMTP id
 2adb3069b0e04-5217cf3cd96mr4567509e87.64.1715271365083; Thu, 09 May 2024
 09:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <7721e4ee372d1f2244aeb0c6c2d80070a70d2f5f.1714707707.git.wqu@suse.com>
In-Reply-To: <7721e4ee372d1f2244aeb0c6c2d80070a70d2f5f.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 May 2024 17:15:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4qQz27+h6AriT1BSaCHtzqvk1iure+BA+++K81wQ_fbQ@mail.gmail.com>
Message-ID: <CAL3q7H4qQz27+h6AriT1BSaCHtzqvk1iure+BA+++K81wQ_fbQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] btrfs: rename extent_map::orig_block_len to disk_num_bytes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> This would make it very obvious that the member just matches
> btrfs_file_extent_item::disk_num_bytes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_map.c | 16 ++++++++--------
>  fs/btrfs/extent_map.h |  2 +-
>  fs/btrfs/file-item.c  |  4 ++--
>  fs/btrfs/file.c       |  2 +-
>  fs/btrfs/inode.c      | 10 +++++-----
>  fs/btrfs/tree-log.c   |  6 +++---
>  6 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 744e8952abb0..4230dd0f34cc 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -783,14 +783,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                                         split->block_len =3D em->block_le=
n;
>                                 else
>                                         split->block_len =3D split->len;
> -                               split->orig_block_len =3D max(split->bloc=
k_len,
> -                                               em->orig_block_len);
> +                               split->disk_num_bytes =3D max(split->bloc=
k_len,
> +                                                           em->disk_num_=
bytes);
>                                 split->ram_bytes =3D em->ram_bytes;
>                         } else {
>                                 split->orig_start =3D split->start;
>                                 split->block_len =3D 0;
>                                 split->block_start =3D em->block_start;
> -                               split->orig_block_len =3D 0;
> +                               split->disk_num_bytes =3D 0;
>                                 split->ram_bytes =3D split->len;
>                         }
>
> @@ -815,8 +815,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                         split->generation =3D gen;
>
>                         if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> -                               split->orig_block_len =3D max(em->block_l=
en,
> -                                                   em->orig_block_len);
> +                               split->disk_num_bytes =3D max(em->block_l=
en,
> +                                                           em->disk_num_=
bytes);
>
>                                 split->ram_bytes =3D em->ram_bytes;
>                                 if (compressed) {
> @@ -833,7 +833,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                                 split->ram_bytes =3D split->len;
>                                 split->orig_start =3D split->start;
>                                 split->block_len =3D 0;
> -                               split->orig_block_len =3D 0;
> +                               split->disk_num_bytes =3D 0;
>                         }
>
>                         if (extent_map_in_tree(em)) {
> @@ -990,7 +990,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 s=
tart, u64 len, u64 pre,
>         split_pre->orig_start =3D split_pre->start;
>         split_pre->block_start =3D new_logical;
>         split_pre->block_len =3D split_pre->len;
> -       split_pre->orig_block_len =3D split_pre->block_len;
> +       split_pre->disk_num_bytes =3D split_pre->block_len;
>         split_pre->ram_bytes =3D split_pre->len;
>         split_pre->flags =3D flags;
>         split_pre->generation =3D em->generation;
> @@ -1008,7 +1008,7 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>         split_mid->orig_start =3D split_mid->start;
>         split_mid->block_start =3D em->block_start + pre;
>         split_mid->block_len =3D split_mid->len;
> -       split_mid->orig_block_len =3D split_mid->block_len;
> +       split_mid->disk_num_bytes =3D split_mid->block_len;
>         split_mid->ram_bytes =3D split_mid->len;
>         split_mid->flags =3D flags;
>         split_mid->generation =3D em->generation;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 6d587111f73a..6ea0287b0d61 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -74,7 +74,7 @@ struct extent_map {
>          * The full on-disk extent length, matching
>          * btrfs_file_extent_item::disk_num_bytes.
>          */
> -       u64 orig_block_len;
> +       u64 disk_num_bytes;
>
>         /*
>          * The decompressed size of the whole on-disk extent, matching
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index bce95f871750..2197cfe5443b 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1294,7 +1294,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_i=
node *inode,
>                 em->len =3D btrfs_file_extent_end(path) - extent_start;
>                 em->orig_start =3D extent_start -
>                         btrfs_file_extent_offset(leaf, fi);
> -               em->orig_block_len =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
> +               em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
>                 bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>                 if (bytenr =3D=3D 0) {
>                         em->block_start =3D EXTENT_MAP_HOLE;
> @@ -1303,7 +1303,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_i=
node *inode,
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                         extent_map_set_compression(em, compress_type);
>                         em->block_start =3D bytenr;
> -                       em->block_len =3D em->orig_block_len;
> +                       em->block_len =3D em->disk_num_bytes;
>                 } else {
>                         bytenr +=3D btrfs_file_extent_offset(leaf, fi);
>                         em->block_start =3D bytenr;
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0c7c1b42028e..d3cbd161cd90 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2338,7 +2338,7 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>
>                 hole_em->block_start =3D EXTENT_MAP_HOLE;
>                 hole_em->block_len =3D 0;
> -               hole_em->orig_block_len =3D 0;
> +               hole_em->disk_num_bytes =3D 0;
>                 hole_em->generation =3D trans->transid;
>
>                 ret =3D btrfs_replace_extent_map_range(inode, hole_em, tr=
ue);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d0274324c75a..0e5d4517af0e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4971,7 +4971,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>
>                         hole_em->block_start =3D EXTENT_MAP_HOLE;
>                         hole_em->block_len =3D 0;
> -                       hole_em->orig_block_len =3D 0;
> +                       hole_em->disk_num_bytes =3D 0;
>                         hole_em->ram_bytes =3D hole_size;
>                         hole_em->generation =3D btrfs_get_fs_generation(f=
s_info);
>
> @@ -7292,7 +7292,7 @@ static int lock_extent_direct(struct inode *inode, =
u64 lockstart, u64 lockend,
>  /* The callers of this must take lock_extent() */
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
>                                        u64 len, u64 orig_start, u64 block=
_start,
> -                                      u64 block_len, u64 orig_block_len,
> +                                      u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        int type)
>  {
> @@ -7324,7 +7324,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>                 ASSERT(block_len =3D=3D len);
>
>                 /* COW results a new extent matching our file extent size=
. */
> -               ASSERT(orig_block_len =3D=3D len);
> +               ASSERT(disk_num_bytes =3D=3D len);
>                 ASSERT(ram_bytes =3D=3D len);
>
>                 /* Since it's a new extent, we should not have any offset=
. */
> @@ -7351,7 +7351,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>         em->len =3D len;
>         em->block_len =3D block_len;
>         em->block_start =3D block_start;
> -       em->orig_block_len =3D orig_block_len;
> +       em->disk_num_bytes =3D disk_num_bytes;
>         em->ram_bytes =3D ram_bytes;
>         em->generation =3D -1;
>         em->flags |=3D EXTENT_FLAG_PINNED;
> @@ -9587,7 +9587,7 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>                 em->len =3D ins.offset;
>                 em->block_start =3D ins.objectid;
>                 em->block_len =3D ins.offset;
> -               em->orig_block_len =3D ins.offset;
> +               em->disk_num_bytes =3D ins.offset;
>                 em->ram_bytes =3D ins.offset;
>                 em->flags |=3D EXTENT_FLAG_PREALLOC;
>                 em->generation =3D trans->transid;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 5146387b416b..83dff4b06c84 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2874,7 +2874,7 @@ static inline void btrfs_remove_log_ctx(struct btrf=
s_root *root,
>         mutex_unlock(&root->log_mutex);
>  }
>
> -/*
> +/*

Unrelated white space only changed. This was pointed out before IIRC.

Other than that it looks fine, but I have to read the rest of the patchset.

Thanks.

>   * Invoked in log mutex context, or be sure there is no other task which
>   * can access the list.
>   */
> @@ -4648,7 +4648,7 @@ static int log_extent_csums(struct btrfs_trans_hand=
le *trans,
>         /* If we're compressed we have to save the entire range of csums.=
 */
>         if (extent_map_is_compressed(em)) {
>                 csum_offset =3D 0;
> -               csum_len =3D max(em->block_len, em->orig_block_len);
> +               csum_len =3D max(em->block_len, em->disk_num_bytes);
>         } else {
>                 csum_offset =3D mod_start - em->start;
>                 csum_len =3D mod_len;
> @@ -4698,7 +4698,7 @@ static int log_one_extent(struct btrfs_trans_handle=
 *trans,
>         else
>                 btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_R=
EG);
>
> -       block_len =3D max(em->block_len, em->orig_block_len);
> +       block_len =3D max(em->block_len, em->disk_num_bytes);
>         compress_type =3D extent_map_compression(em);
>         if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                 btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_st=
art);
> --
> 2.45.0
>
>

