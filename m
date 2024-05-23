Return-Path: <linux-btrfs+bounces-5257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7B8CD8CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCBE1C2155A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27C47A6C;
	Thu, 23 May 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4IVqTyS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7ED36B17
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483514; cv=none; b=H/aMMgi17TiYmDRgfV8xU0tpoDUOtSYf6cjiB41uMxup2I8rQtaHwKbu8x+GmG6LemOBKP2BLyzxIiEKJdBt9m0wW/MbpCPy3cxltmPiqqX1fPm/lmHVVSSXcj3V1zvF6WqjhQ14ofKhJdsPyOSmHovM81xMZuX5racNM1hvAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483514; c=relaxed/simple;
	bh=y2UlxNSEfhXurSW2ScTbwpCNNWqaGCNPEfpvUiGM63w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwgeDuN+rFDi9yd+ayTzwhZyMBx4kDyZs+94q2C2R6UMVRFKuVDz73GSJ/zYC6IpoF8rIzK07wkgo4/VEC+95Tnx0jeGWrhBB3k1t99R3VZs7tTmIkCYfnoIuc80J01Tfe0Gq/4xv1obM/P2PxMjY98NvDzEjoPaLxCd0c17qLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4IVqTyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB17C2BD10
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716483514;
	bh=y2UlxNSEfhXurSW2ScTbwpCNNWqaGCNPEfpvUiGM63w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W4IVqTySN8goV3DduhX7fkmY+go8zH1fAKjlhJpvb11lRGr5M+LwAHNGc6Lkyk1/c
	 1sQI2iG/1BoONF+6umU7obyRzW/yT6CfulwLfGXKzdzEqTGa1L85MUTvkS8KmsZK9b
	 apzjt4xyinE+0JD+oZV3kwn/+Dtcbly12rCpUCVnu0QJbcGI82bG3/qVUF+zFVDVr1
	 yj7Ad7XnolaRecag/gzpiwIOArjTHh3/EgILNB41F3MLOaCnnpC7PqUNLxBeW+B3nI
	 ihaNIonAeEl1FXaY0w4M9540Sta0RVzlJpFiOJH+X1hzelYakYQsR9+oNZ1wM1MVNq
	 q3fasQ6UuB/5w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a599a298990so1219733466b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:58:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLwLat3ILcsSIENAYJ+b90D2Kr9eZ+AhkLr/QQkX5MAyJQt8mI
	0YosaI1JiskgVEtoMlPkbi+pCayBlSAWC9QMi3v9yMe+ZpRWal6AV0FgTviUagaQaWZB+gmjZaO
	+YOGhoKxjxj1U21vKtlzhRu25aHg=
X-Google-Smtp-Source: AGHT+IF5U7P+gEdHDveEQd4r3eA0F+WGCdIaYulEDXp8MWZHvHyhrHz3yY6X8USoMpak+ZJHGrlR9BhZL3MrMtfrSBI=
X-Received: by 2002:a17:906:9c41:b0:a59:c39b:6bc3 with SMTP id
 a640c23a62f3a-a622816340amr318407466b.49.1716483512634; Thu, 23 May 2024
 09:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716440169.git.wqu@suse.com> <a9fa2b3ca93da520f65410ce9fc5ef7d626227d5.1716440169.git.wqu@suse.com>
In-Reply-To: <a9fa2b3ca93da520f65410ce9fc5ef7d626227d5.1716440169.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 23 May 2024 17:57:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5mSYvwBEwSpbqO_jxKs=HQEYTVePiEr0g7O+cwEXYdDg@mail.gmail.com>
Message-ID: <CAL3q7H5mSYvwBEwSpbqO_jxKs=HQEYTVePiEr0g7O+cwEXYdDg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] btrfs: introduce extra sanity checks for extent maps
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 6:04=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Since extent_map structure has the all the needed members to represent a
> file extent directly, we can apply all the file extent sanity checks to a=
n extent
> map.
>
> The new sanity checks would cross check both the old members
> (block_start/block_len/orig_start) and the new members
> (disk_bytenr/disk_num_bytes/offset).
>
> There is a special case for offset/orig_start/start cross check, we only
> do such sanity check for compressed extent, as only compressed
> read/encoded write really utilize orig_start.
> This can be proved by the cleanup patch of orig_start.
>
> The checks happens at the following timing:
>
> - add_extent_mapping()
>   This is for newly added extent map
>
> - replace_extent_mapping()
>   This is for btrfs_drop_extent_map_range() and split_extent_map()
>
> - try_merge_map()
>
> For a lot of call sites we have to properly populate all the members to
> pass the sanity check, meanwhile the following code needs extra
> modification:
>
> - setup_file_extents() from inode-tests
>   The file extents layout of setup_file_extents() is already too invalid
>   that tree-checker would reject most of them in real world.
>
>   However there is just a special unaligned regular extent which has
>   mismatched disk_num_bytes (4096) and ram_bytes (4096 - 1).
>   So instead of dropping the whole test case, here we just unify
>   disk_num_bytes and ram_bytes to 4096 - 1.
>
> - test_case_7() from extent-map-tests
>   An extent is inserted with 16K length, but on-disk extent size is
>   only 4K.
>   This means it must be a compressed extent, so set the compressed flag
>   for it.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_map.c             | 60 +++++++++++++++++++++++++++++++
>  fs/btrfs/relocation.c             |  4 +++
>  fs/btrfs/tests/extent-map-tests.c | 56 ++++++++++++++++++++++++++++-
>  fs/btrfs/tests/inode-tests.c      |  2 +-
>  4 files changed, 120 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index c7d2393692e6..b157f30ac241 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -283,8 +283,62 @@ static void merge_ondisk_extents(struct extent_map *=
prev, struct extent_map *nex
>         next->offset =3D new_offset;
>  }
>
> +static void dump_extent_map(struct btrfs_fs_info *fs_info,
> +                           const char *prefix, struct extent_map *em)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +               return;
> +       btrfs_crit(fs_info, "%s, start=3D%llu len=3D%llu disk_bytenr=3D%l=
lu disk_num_bytes=3D%llu ram_bytes=3D%llu offset=3D%llu orig_start=3D%llu b=
lock_start=3D%llu block_len=3D%llu flags=3D0x%x\n",
> +               prefix, em->start, em->len, em->disk_bytenr, em->disk_num=
_bytes,
> +               em->ram_bytes, em->offset, em->orig_start, em->block_star=
t,
> +               em->block_len, em->flags);
> +       ASSERT(0);
> +}
> +
> +/* Internal sanity checks for btrfs debug builds. */
> +static void validate_extent_map(struct btrfs_fs_info *fs_info,
> +                               struct extent_map *em)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +               return;
> +       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
> +               if (em->disk_num_bytes =3D=3D 0)
> +                       dump_extent_map(fs_info, "zero disk_num_bytes", e=
m);
> +               if (em->offset + em->len > em->ram_bytes)
> +                       dump_extent_map(fs_info, "ram_bytes too small", e=
m);
> +               if (em->offset + em->len > em->disk_num_bytes &&
> +                   !extent_map_is_compressed(em))
> +                       dump_extent_map(fs_info, "disk_num_bytes too smal=
l", em);
> +
> +               if (extent_map_is_compressed(em)) {
> +                       if (em->block_start !=3D em->disk_bytenr)
> +                               dump_extent_map(fs_info,
> +                               "mismatch block_start/disk_bytenr/offset"=
, em);
> +                       if (em->disk_num_bytes !=3D em->block_len)
> +                               dump_extent_map(fs_info,
> +                               "mismatch disk_num_bytes/block_len", em);
> +                       /*
> +                        * Here we only check the start/orig_start/offset=
 for
> +                        * compressed extents as that's the only case whe=
re
> +                        * orig_start is utilized.
> +                        */
> +                       if (em->orig_start !=3D em->start - em->offset)
> +                               dump_extent_map(fs_info,
> +                               "mismatch orig_start/offset/start", em);
> +
> +               } else if (em->block_start !=3D em->disk_bytenr + em->off=
set) {
> +                       dump_extent_map(fs_info,
> +                               "mismatch block_start/disk_bytenr/offset"=
, em);
> +               }
> +       } else if (em->offset) {
> +               dump_extent_map(fs_info,
> +                               "non-zero offset for hole/inline", em);
> +       }

I think I mentioned this before, but since these are all unexpected to
happen and we're in a critical section that can have a lot of
concurrency, adding unlikely() here would be good to have.
You can do that afterwards in a separate patch. I know some of these
checks get removed in later patches.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +}
> +
>  static void try_merge_map(struct btrfs_inode *inode, struct extent_map *=
em)
>  {
> +       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct extent_map_tree *tree =3D &inode->extent_tree;
>         struct extent_map *merge =3D NULL;
>         struct rb_node *rb;
> @@ -319,6 +373,7 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                                 merge_ondisk_extents(merge, em);
>                         em->flags |=3D EXTENT_FLAG_MERGED;
>
> +                       validate_extent_map(fs_info, em);
>                         rb_erase(&merge->rb_node, &tree->root);
>                         RB_CLEAR_NODE(&merge->rb_node);
>                         free_extent_map(merge);
> @@ -334,6 +389,7 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                 em->block_len +=3D merge->block_len;
>                 if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>                         merge_ondisk_extents(em, merge);
> +               validate_extent_map(fs_info, em);
>                 rb_erase(&merge->rb_node, &tree->root);
>                 RB_CLEAR_NODE(&merge->rb_node);
>                 em->generation =3D max(em->generation, merge->generation)=
;
> @@ -445,6 +501,7 @@ static int add_extent_mapping(struct btrfs_inode *ino=
de,
>
>         lockdep_assert_held_write(&tree->lock);
>
> +       validate_extent_map(fs_info, em);
>         ret =3D tree_insert(&tree->root, em);
>         if (ret)
>                 return ret;
> @@ -548,10 +605,13 @@ static void replace_extent_mapping(struct btrfs_ino=
de *inode,
>                                    struct extent_map *new,
>                                    int modified)
>  {
> +       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct extent_map_tree *tree =3D &inode->extent_tree;
>
>         lockdep_assert_held_write(&tree->lock);
>
> +       validate_extent_map(fs_info, new);
> +
>         WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
>         ASSERT(extent_map_in_tree(cur));
>         if (!(cur->flags & EXTENT_FLAG_LOGGING))
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5f1a909a1d91..151ed1ebd291 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2911,9 +2911,13 @@ static noinline_for_stack int setup_relocation_ext=
ent_mapping(struct inode *inod
>                 return -ENOMEM;
>
>         em->start =3D start;
> +       em->orig_start =3D start;
>         em->len =3D end + 1 - start;
>         em->block_len =3D em->len;
>         em->block_start =3D block_start;
> +       em->disk_bytenr =3D block_start;
> +       em->disk_num_bytes =3D em->len;
> +       em->ram_bytes =3D em->len;
>         em->flags |=3D EXTENT_FLAG_PINNED;
>
>         lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index c511a1297956..e73ac7a0869c 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -78,6 +78,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info, s=
truct btrfs_inode *inode)
>         em->len =3D SZ_16K;
>         em->block_start =3D 0;
>         em->block_len =3D SZ_16K;
> +       em->disk_bytenr =3D 0;
> +       em->disk_num_bytes =3D SZ_16K;
> +       em->ram_bytes =3D SZ_16K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -96,9 +99,13 @@ static int test_case_1(struct btrfs_fs_info *fs_info, =
struct btrfs_inode *inode)
>         }
>
>         em->start =3D SZ_16K;
> +       em->orig_start =3D SZ_16K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_32K; /* avoid merging */
>         em->block_len =3D SZ_4K;
> +       em->disk_bytenr =3D SZ_32K; /* avoid merging */
> +       em->disk_num_bytes =3D SZ_4K;
> +       em->ram_bytes =3D SZ_4K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -117,9 +124,13 @@ static int test_case_1(struct btrfs_fs_info *fs_info=
, struct btrfs_inode *inode)
>
>         /* Add [0, 8K), should return [0, 16K) instead. */
>         em->start =3D start;
> +       em->orig_start =3D start;
>         em->len =3D len;
>         em->block_start =3D start;
>         em->block_len =3D len;
> +       em->disk_bytenr =3D start;
> +       em->disk_num_bytes =3D len;
> +       em->ram_bytes =3D len;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -174,6 +185,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->len =3D SZ_1K;
>         em->block_start =3D EXTENT_MAP_INLINE;
>         em->block_len =3D (u64)-1;
> +       em->disk_bytenr =3D EXTENT_MAP_INLINE;
> +       em->disk_num_bytes =3D 0;
> +       em->ram_bytes =3D SZ_1K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -192,9 +206,13 @@ static int test_case_2(struct btrfs_fs_info *fs_info=
, struct btrfs_inode *inode)
>         }
>
>         em->start =3D SZ_4K;
> +       em->orig_start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_4K;
>         em->block_len =3D SZ_4K;
> +       em->disk_bytenr =3D SZ_4K;
> +       em->disk_num_bytes =3D SZ_4K;
> +       em->ram_bytes =3D SZ_4K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -216,6 +234,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>         em->len =3D SZ_1K;
>         em->block_start =3D EXTENT_MAP_INLINE;
>         em->block_len =3D (u64)-1;
> +       em->disk_bytenr =3D EXTENT_MAP_INLINE;
> +       em->disk_num_bytes =3D 0;
> +       em->ram_bytes =3D SZ_1K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -262,9 +283,13 @@ static int __test_case_3(struct btrfs_fs_info *fs_in=
fo,
>
>         /* Add [4K, 8K) */
>         em->start =3D SZ_4K;
> +       em->orig_start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_4K;
>         em->block_len =3D SZ_4K;
> +       em->disk_bytenr =3D SZ_4K;
> +       em->disk_num_bytes =3D SZ_4K;
> +       em->ram_bytes =3D SZ_4K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -286,6 +311,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_inf=
o,
>         em->len =3D SZ_16K;
>         em->block_start =3D 0;
>         em->block_len =3D SZ_16K;
> +       em->disk_bytenr =3D 0;
> +       em->disk_num_bytes =3D SZ_16K;
> +       em->ram_bytes =3D SZ_16K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, start, len);
>         write_unlock(&em_tree->lock);
> @@ -372,6 +400,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_inf=
o,
>         em->len =3D SZ_8K;
>         em->block_start =3D 0;
>         em->block_len =3D SZ_8K;
> +       em->disk_bytenr =3D 0;
> +       em->disk_num_bytes =3D SZ_8K;
> +       em->ram_bytes =3D SZ_8K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -390,9 +421,13 @@ static int __test_case_4(struct btrfs_fs_info *fs_in=
fo,
>
>         /* Add [8K, 32K) */
>         em->start =3D SZ_8K;
> +       em->orig_start =3D SZ_8K;
>         em->len =3D 24 * SZ_1K;
>         em->block_start =3D SZ_16K; /* avoid merging */
>         em->block_len =3D 24 * SZ_1K;
> +       em->disk_bytenr =3D SZ_16K; /* avoid merging */
> +       em->disk_num_bytes =3D 24 * SZ_1K;
> +       em->ram_bytes =3D 24 * SZ_1K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -410,9 +445,13 @@ static int __test_case_4(struct btrfs_fs_info *fs_in=
fo,
>         }
>         /* Add [0K, 32K) */
>         em->start =3D 0;
> +       em->orig_start =3D 0;
>         em->len =3D SZ_32K;
>         em->block_start =3D 0;
>         em->block_len =3D SZ_32K;
> +       em->disk_bytenr =3D 0;
> +       em->disk_num_bytes =3D SZ_32K;
> +       em->ram_bytes =3D SZ_32K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, start, len);
>         write_unlock(&em_tree->lock);
> @@ -494,9 +533,13 @@ static int add_compressed_extent(struct btrfs_inode =
*inode,
>         }
>
>         em->start =3D start;
> +       em->orig_start =3D start;
>         em->len =3D len;
>         em->block_start =3D block_start;
>         em->block_len =3D SZ_4K;
> +       em->disk_bytenr =3D block_start;
> +       em->disk_num_bytes =3D SZ_4K;
> +       em->ram_bytes =3D len;
>         em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
> @@ -715,9 +758,13 @@ static int test_case_6(struct btrfs_fs_info *fs_info=
, struct btrfs_inode *inode)
>         }
>
>         em->start =3D SZ_4K;
> +       em->orig_start =3D SZ_4K;
>         em->len =3D SZ_4K;
>         em->block_start =3D SZ_16K;
>         em->block_len =3D SZ_16K;
> +       em->disk_bytenr =3D SZ_16K;
> +       em->disk_num_bytes =3D SZ_16K;
> +       em->ram_bytes =3D SZ_16K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, 0, SZ_8K);
>         write_unlock(&em_tree->lock);
> @@ -771,7 +818,10 @@ static int test_case_7(struct btrfs_fs_info *fs_info=
, struct btrfs_inode *inode)
>         em->len =3D SZ_16K;
>         em->block_start =3D 0;
>         em->block_len =3D SZ_4K;
> -       em->flags |=3D EXTENT_FLAG_PINNED;
> +       em->disk_bytenr =3D 0;
> +       em->disk_num_bytes =3D SZ_4K;
> +       em->ram_bytes =3D SZ_16K;
> +       em->flags |=3D (EXTENT_FLAG_PINNED | EXTENT_FLAG_COMPRESS_ZLIB);
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> @@ -790,9 +840,13 @@ static int test_case_7(struct btrfs_fs_info *fs_info=
, struct btrfs_inode *inode)
>
>         /* [32K, 48K), not pinned */
>         em->start =3D SZ_32K;
> +       em->orig_start =3D SZ_32K;
>         em->len =3D SZ_16K;
>         em->block_start =3D SZ_32K;
>         em->block_len =3D SZ_16K;
> +       em->disk_bytenr =3D SZ_32K;
> +       em->disk_num_bytes =3D SZ_16K;
> +       em->ram_bytes =3D SZ_16K;
>         write_lock(&em_tree->lock);
>         ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len);
>         write_unlock(&em_tree->lock);
> diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
> index 99da9d34b77a..0895c6e06812 100644
> --- a/fs/btrfs/tests/inode-tests.c
> +++ b/fs/btrfs/tests/inode-tests.c
> @@ -117,7 +117,7 @@ static void setup_file_extents(struct btrfs_root *roo=
t, u32 sectorsize)
>
>         /* Now for a regular extent */
>         insert_extent(root, offset, sectorsize - 1, sectorsize - 1, 0,
> -                     disk_bytenr, sectorsize, BTRFS_FILE_EXTENT_REG, 0, =
slot);
> +                     disk_bytenr, sectorsize - 1, BTRFS_FILE_EXTENT_REG,=
 0, slot);
>         slot++;
>         disk_bytenr +=3D sectorsize;
>         offset +=3D sectorsize - 1;
> --
> 2.45.1
>
>

