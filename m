Return-Path: <linux-btrfs+bounces-4933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97E8C4182
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F10F282FA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403A152193;
	Mon, 13 May 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnXWOHBO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602A1514E9
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605813; cv=none; b=tBgarQQBx8IkGcPHL9E03p/ArR81ntrcUrkbC3rmHmZf9Sm/e+GacMoAjRUnWgnJBgD1deNFTjzS0M0oduT5i6Ji4nccFVrEs0hsBVWnKBk7/sPNQgIEA3qtifDGHamxN4Gs1JYPnKu8RItytOFmkMB0H6Qrq5yzqOaXJrv7lA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605813; c=relaxed/simple;
	bh=JPFhZS3sV7yxqR9sop7D7rjuULZhRlXwpu63WTWwGv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ebu8btRcWnnMKG+4FhsejEqbwFtkZRlxxqUQU4yHRrcxkekz/4O9dlfpqxuEfh+huIyW/4glTwNyhHfv7eeEyKXOsNtFHF/mJWxue0JkOcR6BdKFQpovP9PLFrg6LeOAAVoO+zp3PIrtrJhavnVIbREkmtyp1FTeVBkT6DOmDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnXWOHBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B75C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715605813;
	bh=JPFhZS3sV7yxqR9sop7D7rjuULZhRlXwpu63WTWwGv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CnXWOHBO45+4AAxyLRQjGk3ZV1jmmFd79evhVlpOMkqvFArU1ftWzZLcwS6dLvZ6Z
	 ebQz8EB5imMZ4XLltTlJSRaHaGRnZhM1CJxlLBqbwrctjpjqC920mznPF5kjP3oAkM
	 zjkJcR8xSSYEHs7n9mivacPKLlk7Gjaa9YC8IRfbia04kQ9AF3Kif1K/ZVY2M7I4eg
	 2VrmgT1zr+cAV79YcYf5XRsEML9HZOtutYDB2RaOM0bcF4E9CRftZ4CKQR0Rb9OyOK
	 8jymS9yE9UG0Q2wE5Eqlu+K/9Qhm9si+MehTkhdKd8L5ACW8fPTs5Xd8rapcLYmZnj
	 9OEtc0D7qmPRg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51fea3031c3so5642158e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 06:10:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWYxfM8MYdf5uoHsMs7fs+QjImcB/wfre/PjyAGg6rcLrtTgPT
	yVpUZC9xMJeo3WFqGqxNAP6w1TzHvrJwQvMRrSLxfOfH/yH8fwTxNdPz7yIQrQ449iUV/ulFybR
	/xevDWGg3QKKRe7ITsa7fqyHXG74=
X-Google-Smtp-Source: AGHT+IEWAXMCtk5Xa51QTOhpenBsKujI/iDqUfMsQEhRQw4+ZSogcTPC4iIUtXR290Ks5v7d34U3tufY54vy+zgRaUE=
X-Received: by 2002:a05:6512:33cf:b0:51d:9291:6945 with SMTP id
 2adb3069b0e04-522102785abmr9860388e87.44.1715605810807; Mon, 13 May 2024
 06:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <f6a08d8298dc84e72834a9897a75205194d23c6c.1714707707.git.wqu@suse.com>
In-Reply-To: <f6a08d8298dc84e72834a9897a75205194d23c6c.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 May 2024 14:09:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5fTGX0zJzzWepv2LdVYf2Vb_fBbBUhVZhhc4v8cXe8NA@mail.gmail.com>
Message-ID: <CAL3q7H5fTGX0zJzzWepv2LdVYf2Vb_fBbBUhVZhhc4v8cXe8NA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] btrfs: remove extent_map::orig_start member
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Since we have extent_map::offset, the old extent_map::orig_start is just
> extent_map::start - extent_map::offset for non-hole/inline extents.
>
> And since the new extent_map::offset would be verified by

would be -> is already

> validate_extent_map() already meanwhile the old orig_start is not, let's
> just remove the old member from all call sites.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h            |  2 +-
>  fs/btrfs/compression.c            |  2 +-
>  fs/btrfs/defrag.c                 |  1 -
>  fs/btrfs/extent_map.c             | 29 +----------
>  fs/btrfs/extent_map.h             |  9 ----
>  fs/btrfs/file-item.c              |  5 +-
>  fs/btrfs/file.c                   |  3 +-
>  fs/btrfs/inode.c                  | 37 +++++---------
>  fs/btrfs/relocation.c             |  1 -
>  fs/btrfs/tests/extent-map-tests.c |  9 ----
>  fs/btrfs/tests/inode-tests.c      | 84 +++++++++++++------------------
>  fs/btrfs/tree-log.c               |  2 +-
>  include/trace/events/btrfs.h      | 14 ++----
>  13 files changed, 60 insertions(+), 138 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 18678762615a..f30afce4f6ca 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -461,7 +461,7 @@ struct btrfs_file_extent {
>  };
>
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> -                             u64 *orig_start, u64 *orig_block_len,
> +                             u64 *orig_block_len,
>                               u64 *ram_bytes, struct btrfs_file_extent *f=
ile_extent,
>                               bool nowait, bool strict);
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 6441e47d8a5e..a4cd0e743027 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -590,7 +590,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *b=
bio)
>         cb =3D alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
>                                   end_bbio_comprssed_read);
>
> -       cb->start =3D em->orig_start;
> +       cb->start =3D em->start - em->offset;
>         em_len =3D em->len;
>         em_start =3D em->start;
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 242c5469f4ba..025e7f853a68 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -707,7 +707,6 @@ static struct extent_map *defrag_get_extent(struct bt=
rfs_inode *inode,
>                  */
>                 if (key.offset > start) {
>                         em->start =3D start;
> -                       em->orig_start =3D start;
>                         em->block_start =3D EXTENT_MAP_HOLE;
>                         em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         em->disk_num_bytes =3D 0;
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 8d0e257fc113..dc73b8a81271 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -288,9 +288,9 @@ static void dump_extent_map(const char *prefix, struc=
t extent_map *em)
>  {
>         if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
>                 return;
> -       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu orig_start=3D%llu block_start=
=3D%llu block_len=3D%llu flags=3D0x%x\n",
> +       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu block_start=3D%llu block_len=3D=
%llu flags=3D0x%x\n",
>                 prefix, em->start, em->len, em->disk_bytenr, em->disk_num=
_bytes,
> -               em->ram_bytes, em->offset, em->orig_start, em->block_star=
t,
> +               em->ram_bytes, em->offset, em->block_start,
>                 em->block_len, em->flags);
>         ASSERT(0);
>  }
> @@ -316,23 +316,6 @@ static void validate_extent_map(struct extent_map *e=
m)
>                         if (em->disk_num_bytes !=3D em->block_len)
>                                 dump_extent_map(
>                                 "mismatch disk_num_bytes/block_len", em);
> -                       /*
> -                        * Here we only check the start/orig_start/offset=
 for
> -                        * compressed extents.
> -                        * This is because em::offset is always based on =
the
> -                        * referred data extent, which can be merged.
> -                        *
> -                        * In that case, @offset would no longer match
> -                        * em::start - em::orig_start, and cause false al=
ert.
> -                        *
> -                        * Thankfully only compressed extent read/encoded=
 write
> -                        * really bothers @orig_start, so we can skip
> -                        * the check for non-compressed extents.
> -                        */
> -                       if (em->orig_start !=3D em->start - em->offset)
> -                               dump_extent_map(
> -                               "mismatch orig_start/offset/start", em);
> -
>                 } else {
>                         if (em->block_start !=3D em->disk_bytenr + em->of=
fset)
>                                 dump_extent_map(
> @@ -370,7 +353,6 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                         merge =3D rb_entry(rb, struct extent_map, rb_node=
);
>                 if (rb && can_merge_extent_map(merge) && mergeable_maps(m=
erge, em)) {
>                         em->start =3D merge->start;
> -                       em->orig_start =3D merge->orig_start;
>                         em->len +=3D merge->len;
>                         em->block_len +=3D merge->block_len;
>                         em->block_start =3D merge->block_start;
> @@ -900,7 +882,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                         split->len =3D start - em->start;
>
>                         if (em->block_start < EXTENT_MAP_LAST_BYTE) {
> -                               split->orig_start =3D em->orig_start;
>                                 split->block_start =3D em->block_start;
>
>                                 if (compressed)
> @@ -913,7 +894,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode, u64 start, u64 end,
>                                 split->offset =3D em->offset;
>                                 split->ram_bytes =3D em->ram_bytes;
>                         } else {
> -                               split->orig_start =3D split->start;
>                                 split->block_len =3D 0;
>                                 split->block_start =3D em->block_start;
>                                 split->disk_bytenr =3D em->disk_bytenr;
> @@ -950,19 +930,16 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>                                 split->ram_bytes =3D em->ram_bytes;
>                                 if (compressed) {
>                                         split->block_len =3D em->block_le=
n;
> -                                       split->orig_start =3D em->orig_st=
art;
>                                 } else {
>                                         const u64 diff =3D end - em->star=
t;
>
>                                         split->block_len =3D split->len;
>                                         split->block_start +=3D diff;
> -                                       split->orig_start =3D em->orig_st=
art;
>                                 }
>                         } else {
>                                 split->disk_num_bytes =3D 0;
>                                 split->offset =3D 0;
>                                 split->ram_bytes =3D split->len;
> -                               split->orig_start =3D split->start;
>                                 split->block_len =3D 0;
>                         }
>
> @@ -1120,7 +1097,6 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>         split_pre->disk_bytenr =3D new_logical;
>         split_pre->disk_num_bytes =3D split_pre->len;
>         split_pre->offset =3D 0;
> -       split_pre->orig_start =3D split_pre->start;
>         split_pre->block_start =3D new_logical;
>         split_pre->block_len =3D split_pre->len;
>         split_pre->disk_num_bytes =3D split_pre->block_len;
> @@ -1141,7 +1117,6 @@ int split_extent_map(struct btrfs_inode *inode, u64=
 start, u64 len, u64 pre,
>         split_mid->disk_bytenr =3D em->block_start + pre;
>         split_mid->disk_num_bytes =3D split_mid->len;
>         split_mid->offset =3D 0;
> -       split_mid->orig_start =3D split_mid->start;
>         split_mid->block_start =3D em->block_start + pre;
>         split_mid->block_len =3D split_mid->len;
>         split_mid->ram_bytes =3D split_mid->len;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index cc9c8092b704..454a4bb08d95 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -61,15 +61,6 @@ struct extent_map {
>          */
>         u64 len;
>
> -       /*
> -        * The file offset of the original file extent before splitting.
> -        *
> -        * This is an in-memory only member, matching
> -        * extent_map::start - btrfs_file_extent_item::offset for
> -        * regular/preallocated extents. EXTENT_MAP_HOLE otherwise.
> -        */
> -       u64 orig_start;
> -
>         /*
>          * The bytenr for of the full on-disk extent.
>          *
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 47bd4fe0a44b..08d608f0ae5d 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1292,8 +1292,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_i=
node *inode,
>             type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
>                 em->start =3D extent_start;
>                 em->len =3D btrfs_file_extent_end(path) - extent_start;
> -               em->orig_start =3D extent_start -
> -                       btrfs_file_extent_offset(leaf, fi);
>                 bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>                 if (bytenr =3D=3D 0) {
>                         em->block_start =3D EXTENT_MAP_HOLE;
> @@ -1326,10 +1324,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                 em->len =3D fs_info->sectorsize;
>                 em->offset =3D 0;
>                 /*
> -                * Initialize orig_start and block_len with the same valu=
es
> +                * Initialize block_len with the same values
>                  * as in inode.c:btrfs_get_extent().
>                  */
> -               em->orig_start =3D EXTENT_MAP_HOLE;
>                 em->block_len =3D (u64)-1;
>                 extent_map_set_compression(em, compress_type);
>         } else {
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 8931eeee199d..be4e6acb08f3 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1104,7 +1104,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inod=
e, loff_t pos,
>                                                    &cached_state);
>         }
>         ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes=
,
> -                       NULL, NULL, NULL, NULL, nowait, false);
> +                       NULL, NULL, NULL, nowait, false);
>         if (ret <=3D 0)
>                 btrfs_drew_write_unlock(&root->snapshot_lock);
>         else
> @@ -2334,7 +2334,6 @@ static int fill_holes(struct btrfs_trans_handle *tr=
ans,
>                 hole_em->start =3D offset;
>                 hole_em->len =3D end - offset;
>                 hole_em->ram_bytes =3D hole_em->len;
> -               hole_em->orig_start =3D offset;
>
>                 hole_em->block_start =3D EXTENT_MAP_HOLE;
>                 hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 42fea12d509f..d1c948ea1421 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -138,7 +138,7 @@ static noinline int run_delalloc_cow(struct btrfs_ino=
de *inode,
>                                      u64 end, struct writeback_control *w=
bc,
>                                      bool pages_dirty);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
> -                                      u64 len, u64 orig_start, u64 block=
_start,
> +                                      u64 len, u64 block_start,
>                                        u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
> @@ -1209,7 +1209,6 @@ static void submit_one_async_extent(struct async_ch=
unk *async_chunk,
>
>         em =3D create_io_em(inode, start,
>                           async_extent->ram_size,       /* len */
> -                         start,                        /* orig_start */
>                           ins.objectid,                 /* block_start */
>                           ins.offset,                   /* block_len */
>                           ins.offset,                   /* orig_block_len=
 */
> @@ -1453,7 +1452,6 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                             &cached);
>
>                 em =3D create_io_em(inode, start, ins.offset, /* len */
> -                                 start, /* orig_start */
>                                   ins.objectid, /* block_start */
>                                   ins.offset, /* block_len */
>                                   ins.offset, /* orig_block_len */
> @@ -2192,11 +2190,9 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>
>                 is_prealloc =3D extent_type =3D=3D BTRFS_FILE_EXTENT_PREA=
LLOC;
>                 if (is_prealloc) {
> -                       u64 orig_start =3D found_key.offset - nocow_args.=
extent_offset;
>                         struct extent_map *em;
>
>                         em =3D create_io_em(inode, cur_offset, nocow_args=
.num_bytes,
> -                                         orig_start,
>                                           nocow_args.disk_bytenr, /* bloc=
k_start */
>                                           nocow_args.num_bytes, /* block_=
len */
>                                           nocow_args.disk_num_bytes, /* o=
rig_block_len */
> @@ -4999,7 +4995,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, lo=
ff_t oldsize, loff_t size)
>                         }
>                         hole_em->start =3D cur_offset;
>                         hole_em->len =3D hole_size;
> -                       hole_em->orig_start =3D cur_offset;
>
>                         hole_em->block_start =3D EXTENT_MAP_HOLE;
>                         hole_em->disk_bytenr =3D EXTENT_MAP_HOLE;
> @@ -6862,7 +6857,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>                 goto out;
>         }
>         em->start =3D EXTENT_MAP_HOLE;
> -       em->orig_start =3D EXTENT_MAP_HOLE;
>         em->disk_bytenr =3D EXTENT_MAP_HOLE;
>         em->len =3D (u64)-1;
>         em->block_len =3D (u64)-1;
> @@ -6955,7 +6949,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>
>                 /* New extent overlaps with existing one */
>                 em->start =3D start;
> -               em->orig_start =3D start;
>                 em->len =3D found_key.offset - start;
>                 em->block_start =3D EXTENT_MAP_HOLE;
>                 goto insert;
> @@ -6991,7 +6984,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>         }
>  not_found:
>         em->start =3D start;
> -       em->orig_start =3D start;
>         em->len =3D len;
>         em->block_start =3D EXTENT_MAP_HOLE;
>  insert:
> @@ -7024,7 +7016,6 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>                                                   struct btrfs_dio_data *=
dio_data,
>                                                   const u64 start,
>                                                   const u64 len,
> -                                                 const u64 orig_start,
>                                                   const u64 block_start,
>                                                   const u64 block_len,
>                                                   const u64 orig_block_le=
n,
> @@ -7036,7 +7027,7 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>         struct btrfs_ordered_extent *ordered;
>
>         if (type !=3D BTRFS_ORDERED_NOCOW) {
> -               em =3D create_io_em(inode, start, len, orig_start, block_=
start,
> +               em =3D create_io_em(inode, start, len, block_start,
>                                   block_len, orig_block_len, ram_bytes,
>                                   BTRFS_COMPRESS_NONE, /* compress_type *=
/
>                                   file_extent, type);
> @@ -7095,7 +7086,7 @@ static struct extent_map *btrfs_new_extent_direct(s=
truct btrfs_inode *inode,
>         file_extent.ram_bytes =3D ins.offset;
>         file_extent.offset =3D 0;
>         file_extent.compression =3D BTRFS_COMPRESS_NONE;
> -       em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
, start,
> +       em =3D btrfs_create_dio_extent(inode, dio_data, start, ins.offset=
,
>                                      ins.objectid, ins.offset, ins.offset=
,
>                                      ins.offset, BTRFS_ORDERED_REGULAR,
>                                      &file_extent);
> @@ -7141,7 +7132,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_i=
nfo *fs_info, u64 bytenr)
>   *      any ordered extents.
>   */
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> -                             u64 *orig_start, u64 *orig_block_len,
> +                             u64 *orig_block_len,
>                               u64 *ram_bytes, struct btrfs_file_extent *f=
ile_extent,
>                               bool nowait, bool strict)
>  {
> @@ -7228,8 +7219,6 @@ noinline int can_nocow_extent(struct inode *inode, =
u64 offset, u64 *len,
>                 }
>         }
>
> -       if (orig_start)
> -               *orig_start =3D key.offset - nocow_args.extent_offset;
>         if (orig_block_len)
>                 *orig_block_len =3D nocow_args.disk_num_bytes;
>         if (file_extent)
> @@ -7338,7 +7327,7 @@ static int lock_extent_direct(struct inode *inode, =
u64 lockstart, u64 lockend,
>
>  /* The callers of this must take lock_extent() */
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
> -                                      u64 len, u64 orig_start, u64 block=
_start,
> +                                      u64 len, u64 block_start,
>                                        u64 block_len, u64 disk_num_bytes,
>                                        u64 ram_bytes, int compress_type,
>                                        struct btrfs_file_extent *file_ext=
ent,
> @@ -7376,7 +7365,7 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>                 ASSERT(ram_bytes =3D=3D len);
>
>                 /* Since it's a new extent, we should not have any offset=
. */
> -               ASSERT(orig_start =3D=3D start);
> +               ASSERT(file_extent->offset =3D=3D 0);
>                 break;
>         case BTRFS_ORDERED_COMPRESSED:
>                 /* Must be compressed. */
> @@ -7395,7 +7384,6 @@ static struct extent_map *create_io_em(struct btrfs=
_inode *inode, u64 start,
>                 return ERR_PTR(-ENOMEM);
>
>         em->start =3D start;
> -       em->orig_start =3D orig_start;
>         em->len =3D len;
>         em->block_len =3D block_len;
>         em->block_start =3D block_start;
> @@ -7430,7 +7418,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>         struct btrfs_file_extent file_extent =3D { 0 };
>         struct extent_map *em =3D *map;
>         int type;
> -       u64 block_start, orig_start, orig_block_len, ram_bytes;
> +       u64 block_start, orig_block_len, ram_bytes;
>         struct btrfs_block_group *bg;
>         bool can_nocow =3D false;
>         bool space_reserved =3D false;
> @@ -7457,7 +7445,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 len =3D min(len, em->len - (start - em->start));
>                 block_start =3D em->block_start + (start - em->start);
>
> -               if (can_nocow_extent(inode, start, &len, &orig_start,
> +               if (can_nocow_extent(inode, start, &len,
>                                      &orig_block_len, &ram_bytes,
>                                      &file_extent, false, false) =3D=3D 1=
) {
>                         bg =3D btrfs_inc_nocow_writers(fs_info, block_sta=
rt);
> @@ -7485,7 +7473,7 @@ static int btrfs_get_blocks_direct_write(struct ext=
ent_map **map,
>                 space_reserved =3D true;
>
>                 em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data,=
 start, len,
> -                                             orig_start, block_start,
> +                                             block_start,
>                                               len, orig_block_len,
>                                               ram_bytes, type,
>                                               &file_extent);
> @@ -9636,7 +9624,6 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,
>                 }
>
>                 em->start =3D cur_offset;
> -               em->orig_start =3D cur_offset;
>                 em->len =3D ins.offset;
>                 em->block_start =3D ins.objectid;
>                 em->disk_bytenr =3D ins.objectid;
> @@ -10145,7 +10132,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, st=
ruct iov_iter *iter,
>                 disk_io_size =3D em->block_len;
>                 count =3D em->block_len;
>                 encoded->unencoded_len =3D em->ram_bytes;
> -               encoded->unencoded_offset =3D iocb->ki_pos - em->orig_sta=
rt;
> +               encoded->unencoded_offset =3D iocb->ki_pos - em->start + =
em->offset;

Probably simpler to reason doing instead:

->ki_pos - (em->start - em->offset)

As that's what is used everywhere.

>                 ret =3D btrfs_encoded_io_compression_from_extent(fs_info,
>                                                                extent_map=
_compression(em));
>                 if (ret < 0)
> @@ -10390,7 +10377,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>         file_extent.offset =3D encoded->unencoded_offset;
>         file_extent.compression =3D compression;
>         em =3D create_io_em(inode, start, num_bytes,
> -                         start - encoded->unencoded_offset, ins.objectid=
,
> +                         ins.objectid,
>                           ins.offset, ins.offset, ram_bytes, compression,
>                           &file_extent, BTRFS_ORDERED_COMPRESSED);
>         if (IS_ERR(em)) {
> @@ -10722,7 +10709,7 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>                 free_extent_map(em);
>                 em =3D NULL;
>
> -               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL, NULL, false, true);
> +               ret =3D can_nocow_extent(inode, start, &len, NULL, NULL, =
NULL, false, true);
>                 if (ret < 0) {
>                         goto out;
>                 } else if (ret) {
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 0eb737507d12..33662b3aad38 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2911,7 +2911,6 @@ static noinline_for_stack int setup_relocation_exte=
nt_mapping(struct inode *inod
>                 return -ENOMEM;
>
>         em->start =3D start;
> -       em->orig_start =3D start;
>         em->len =3D end + 1 - start;
>         em->block_len =3D em->len;
>         em->block_start =3D block_start;
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index 8c683eed9f27..bd56efe37f02 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -99,7 +99,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, s=
truct btrfs_inode *inode)
>         }
>
>         em->start =3D SZ_16K;
> -       em->orig_start =3D SZ_16K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_32K; /* avoid merging */
>         em->block_len =3D SZ_4K;
> @@ -124,7 +123,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>
>         /* Add [0, 8K), should return [0, 16K) instead. */
>         em->start =3D start;
> -       em->orig_start =3D start;
>         em->len =3D len;
>         em->block_start =3D start;
>         em->block_len =3D len;
> @@ -206,7 +204,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         }
>
>         em->start =3D SZ_4K;
> -       em->orig_start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_4K;
>         em->block_len =3D SZ_4K;
> @@ -283,7 +280,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_inf=
o,
>
>         /* Add [4K, 8K) */
>         em->start =3D SZ_4K;
> -       em->orig_start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_4K;
>         em->block_len =3D SZ_4K;
> @@ -421,7 +417,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>
>         /* Add [8K, 32K) */
>         em->start =3D SZ_8K;
> -       em->orig_start =3D SZ_8K;
>         em->len =3D 24 * SZ_1K;
>         em->block_start =3D SZ_16K; /* avoid merging */
>         em->block_len =3D 24 * SZ_1K;
> @@ -445,7 +440,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         }
>         /* Add [0K, 32K) */
>         em->start =3D 0;
> -       em->orig_start =3D 0;
>         em->len =3D SZ_32K;
>         em->block_start =3D 0;
>         em->block_len =3D SZ_32K;
> @@ -533,7 +527,6 @@ static int add_compressed_extent(struct btrfs_inode *=
inode,
>         }
>
>         em->start =3D start;
> -       em->orig_start =3D start;
>         em->len =3D len;
>         em->block_start =3D block_start;
>         em->block_len =3D SZ_4K;
> @@ -758,7 +751,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         }
>
>         em->start =3D SZ_4K;
> -       em->orig_start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_16K;
>         em->block_len =3D SZ_16K;
> @@ -840,7 +832,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>
>         /* [32K, 48K), not pinned */
>         em->start =3D SZ_32K;
> -       em->orig_start =3D SZ_32K;
>         em->len =3D SZ_16K;
>         em->block_start =3D SZ_32K;
>         em->block_len =3D SZ_16K;
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index 0895c6e06812..1b8c39edfc18 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -358,9 +358,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -386,9 +385,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         disk_bytenr =3D em->block_start;
> @@ -437,9 +435,9 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D orig_start) {
> -               test_err("wrong orig offset, want %llu, have %llu",
> -                        orig_start, em->orig_start);
> +       if (em->start - em->offset !=3D orig_start) {
> +               test_err("wrong offset, want %llu, have %llu",
> +                        em->start - orig_start, em->offset);

Should the first argument be:

orig_start

And the second one:

em->start - em->offset

Otherwise that is confusing.
Maybe print something like:

test_err("wrong offset, em->start=3D%llu em->offset=3D%llu
orig_start=3D%llu", em->start, em->offset, orig_start);



>                 goto out;
>         }
>         disk_bytenr +=3D (em->start - orig_start);
> @@ -472,9 +470,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          prealloc_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -501,9 +498,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          prealloc_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         disk_bytenr =3D em->block_start;
> @@ -530,15 +526,14 @@ static noinline int test_btrfs_get_extent(u32 secto=
rsize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D orig_start) {
> -               test_err("unexpected orig offset, wanted %llu, have %llu"=
,
> -                        orig_start, em->orig_start);
> +       if (em->start - em->offset !=3D orig_start) {
> +               test_err("unexpected offset, wanted %llu, have %llu",
> +                        em->start - orig_start, em->offset);

Same here.

>                 goto out;
>         }
> -       if (em->block_start !=3D (disk_bytenr + (em->start - em->orig_sta=
rt))) {
> +       if (em->block_start !=3D disk_bytenr + em->offset) {
>                 test_err("unexpected block start, wanted %llu, have %llu"=
,
> -                        disk_bytenr + (em->start - em->orig_start),
> -                        em->block_start);
> +                        disk_bytenr + em->offset, em->block_start);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -564,15 +559,14 @@ static noinline int test_btrfs_get_extent(u32 secto=
rsize, u32 nodesize)
>                          prealloc_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D orig_start) {
> -               test_err("wrong orig offset, want %llu, have %llu", orig_=
start,
> -                        em->orig_start);
> +       if (em->start - em->offset !=3D orig_start) {
> +               test_err("wrong offset, want %llu, have %llu",
> +                        em->start - orig_start, em->offset);

Same.

>                 goto out;
>         }
> -       if (em->block_start !=3D (disk_bytenr + (em->start - em->orig_sta=
rt))) {
> +       if (em->block_start !=3D disk_bytenr + em->offset) {
>                 test_err("unexpected block start, wanted %llu, have %llu"=
,
> -                        disk_bytenr + (em->start - em->orig_start),
> -                        em->block_start);
> +                        disk_bytenr + em->offset, em->block_start);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -599,9 +593,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          compressed_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu",
> -                        em->start, em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         if (extent_map_compression(em) !=3D BTRFS_COMPRESS_ZLIB) {
> @@ -633,9 +626,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          compressed_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu",
> -                        em->start, em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         if (extent_map_compression(em) !=3D BTRFS_COMPRESS_ZLIB) {
> @@ -667,9 +659,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -696,9 +687,9 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          compressed_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D orig_start) {
> -               test_err("wrong orig offset, want %llu, have %llu",
> -                        em->start, orig_start);
> +       if (em->start - em->offset !=3D orig_start) {
> +               test_err("wrong offset, want %llu, have %llu",
> +                        em->start - orig_start, em->offset);

Same.

>                 goto out;
>         }
>         if (extent_map_compression(em) !=3D BTRFS_COMPRESS_ZLIB) {
> @@ -729,9 +720,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -762,9 +752,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                          vacancy_only, em->flags);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong offset, want 0, have %llu", em->offset);
>                 goto out;
>         }
>         offset =3D em->start + em->len;
> @@ -789,9 +778,8 @@ static noinline int test_btrfs_get_extent(u32 sectors=
ize, u32 nodesize)
>                 test_err("unexpected flags set, want 0 have %u", em->flag=
s);
>                 goto out;
>         }
> -       if (em->orig_start !=3D em->start) {
> -               test_err("wrong orig offset, want %llu, have %llu", em->s=
tart,
> -                        em->orig_start);
> +       if (em->offset !=3D 0) {
> +               test_err("wrong orig offset, want 0, have %llu", em->offs=
et);
>                 goto out;
>         }
>         ret =3D 0;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 83dff4b06c84..c9e8c5f96b1c 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4688,7 +4688,7 @@ static int log_one_extent(struct btrfs_trans_handle=
 *trans,
>         struct extent_buffer *leaf;
>         struct btrfs_key key;
>         enum btrfs_compression_type compress_type;
> -       u64 extent_offset =3D em->start - em->orig_start;
> +       u64 extent_offset =3D em->offset;
>         u64 block_len;
>         int ret;
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index d2d94d7c3fb5..6dacdc1fb63e 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -291,7 +291,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>                 __field(        u64,  ino               )
>                 __field(        u64,  start             )
>                 __field(        u64,  len               )
> -               __field(        u64,  orig_start        )
>                 __field(        u64,  block_start       )
>                 __field(        u64,  block_len         )
>                 __field(        u32,  flags             )
> @@ -303,7 +302,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>                 __entry->ino            =3D btrfs_ino(inode);
>                 __entry->start          =3D map->start;
>                 __entry->len            =3D map->len;
> -               __entry->orig_start     =3D map->orig_start;
>                 __entry->block_start    =3D map->block_start;
>                 __entry->block_len      =3D map->block_len;
>                 __entry->flags          =3D map->flags;
> @@ -311,13 +309,11 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>         ),
>
>         TP_printk_btrfs("root=3D%llu(%s) ino=3D%llu start=3D%llu len=3D%l=
lu "
> -                 "orig_start=3D%llu block_start=3D%llu(%s) "
> -                 "block_len=3D%llu flags=3D%s refs=3D%u",
> +                 "block_start=3D%llu(%s) block_len=3D%llu flags=3D%s ref=
s=3D%u",
>                   show_root_type(__entry->root_objectid),
>                   __entry->ino,
>                   __entry->start,
>                   __entry->len,
> -                 __entry->orig_start,
>                   show_map_type(__entry->block_start),
>                   __entry->block_len,
>                   show_map_flags(__entry->flags),
> @@ -861,7 +857,7 @@ TRACE_EVENT(btrfs_add_block_group,
>                 { BTRFS_DROP_DELAYED_REF,   "DROP_DELAYED_REF" },       \
>                 { BTRFS_ADD_DELAYED_EXTENT, "ADD_DELAYED_EXTENT" },     \
>                 { BTRFS_UPDATE_DELAYED_HEAD, "UPDATE_DELAYED_HEAD" })
> -
> +

Unrelated white space change. Please avoid that.

Thanks.

>
>  DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>
> @@ -873,7 +869,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>         TP_STRUCT__entry_btrfs(
>                 __field(        u64,  bytenr            )
>                 __field(        u64,  num_bytes         )
> -               __field(        int,  action            )
> +               __field(        int,  action            )
>                 __field(        u64,  parent            )
>                 __field(        u64,  ref_root          )
>                 __field(        int,  level             )
> @@ -930,7 +926,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>         TP_STRUCT__entry_btrfs(
>                 __field(        u64,  bytenr            )
>                 __field(        u64,  num_bytes         )
> -               __field(        int,  action            )
> +               __field(        int,  action            )
>                 __field(        u64,  parent            )
>                 __field(        u64,  ref_root          )
>                 __field(        u64,  owner             )
> @@ -992,7 +988,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
>         TP_STRUCT__entry_btrfs(
>                 __field(        u64,  bytenr            )
>                 __field(        u64,  num_bytes         )
> -               __field(        int,  action            )
> +               __field(        int,  action            )
>                 __field(        int,  is_data           )
>         ),
>
> --
> 2.45.0
>
>

