Return-Path: <linux-btrfs+bounces-4930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C18C409E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBED1C21E98
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6F14F130;
	Mon, 13 May 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwZgpFXc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61214EC5E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602916; cv=none; b=PfA9YF6xl6/5nkvjkMGhZKcqSz8uj0iGqNikLtVkB/iMJFMfwJgIYBa16S53w9BwKttNJ7FJ8/Pv3D1ZVKF3O17KWP0HGN2nsm/U0+A3bepqnWG95eLDSNRaBEGHoeWoLrInoggyN6s2vDnTWpJtS0uUGLUFItMg3ZSQc4uGEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602916; c=relaxed/simple;
	bh=SxPROpFVYHcq9Q9tdjCzFeOu6oXZMbDetxXf2mDv0E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXABWyVGu68Xudio4vyT/bn4xoSUkkC2N64dpaP76izIREgP+hxiUUNor95YX63QrIIKwbEUinAv2UKVDY+G5KSaFjKjtTe6goyuGJjDXNArEQ7T3umpl9cpyIaqJc134fmfL4p92iizvHNrfNJxPt8zTcVPzCoru1F3ZTkJQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwZgpFXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ADCC113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715602915;
	bh=SxPROpFVYHcq9Q9tdjCzFeOu6oXZMbDetxXf2mDv0E4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WwZgpFXcxXiKgtkZBONCn6SjQRbAAr0mRyY8EEn70b1zQX5TXq3XS6lAJ+GUnAvXX
	 OxjFy7GsIQO/tOigeWeM8FGKRsZifirKqEnX1vTt1x9a7IrsTvKTLCne026qUU53vj
	 B47Pc7Dns8dEItVfeBsC7QLALJzzYfFjZEXPm4WvgrmP70kXCVmMIgjKRfB51ewRPz
	 mMHVd47PM9uQAtAqdU/H+UgyGSFCy5jmR/+2Nop0reUgTXELXqQC+2UtVBxw2aWyI8
	 yONfmISPA36GaaaNutxmz8XIg5WBhwTUcpgcXaLj1q6hItt/e6napeW6FUhCajtWW2
	 +uI5KhN7k+4BQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59cf8140d0so978764466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 05:21:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywu/460CbUR1aIcizzwp4eVTtKHxaMRH3GAS/nOopbutDv+3als
	t0PqakA3hAnFK084eGdeD6d8VYf11ZrHyNj+bE+SF5GZLpkdoYr22ji7X5pU9/AM4GLf0DMnhY6
	7kbDMXacbbJPgEyQ+XZKhrTFnvMY=
X-Google-Smtp-Source: AGHT+IF53GVMrnzkEZxMj4pUFQ+TKvNjiHQs3y+bxPZO5Akl+O+dqeUTMIi7Lac7rb4Cy+AU3V7APRewz6LN6ceyDnQ=
X-Received: by 2002:a17:906:8314:b0:a59:a0eb:aeb0 with SMTP id
 a640c23a62f3a-a5a2d5d0a48mr581067266b.36.1715602914077; Mon, 13 May 2024
 05:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714707707.git.wqu@suse.com> <23eef0d1cc8c482121d6958b3c131ba51648cde6.1714707707.git.wqu@suse.com>
In-Reply-To: <23eef0d1cc8c482121d6958b3c131ba51648cde6.1714707707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 May 2024 13:21:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7BPGFcAaqhcAO2vNax8ShhbFm=HcXbvODa-GJshuSs2A@mail.gmail.com>
Message-ID: <CAL3q7H7BPGFcAaqhcAO2vNax8ShhbFm=HcXbvODa-GJshuSs2A@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] btrfs: introduce extra sanity checks for extent maps
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> do such sanity check for compressed extent:
>
> - Only compressed read/encoded write really utilize orig_start
>   This can be proved by the cleanup patch of orig_start.
>
> - Merged data extents can lead to false alerts
>   The problem is, with disk_bytenr/disk_num_bytes, if we're merging
>   two extent maps like this:
>
>     |<- data extent A -->|<-- data extent B -->|
>               |<- em 1 ->|<- em 2 ->|
>
>   Let's assume em2 has orig_offset of 0 and start of 0, and obvisouly
>   offset 0.

obvisouly -> obviously

I'm confused. How can em2 have a "start" of 0?
By "start" you mean file offset I suppose, since that's what it is
before this patchset. That would mean em 1 would have a negative
"start".

And by "offset" you mean extent offset?

>
>   But after merging, the merged em would have offset of em1, screwing up

But this suggests that by "offset" you mean file offset and not the
offset within an extent's range.
So did you mean "start" here?

>   whatever the @orig_start cross check against @start.
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
> Since the check is way more strict than before, the following code has
> to be modified to pass the check:
>
> - extent-map-tests
>   Previously the test case never populate ram_bytes, not to mention the
>   newly introduced disk_bytenr/disk_num_bytes.
>   Populate the involved numbers mostly to follow the existing
>   block_start/block_len values.
>
>   There are two special cases worth mentioning:
>   - test_case_3()
>     The test case is already way too invalid that tree-checker will
>     reject almost all extents.
>
>     And there is a special unaligned regular extent which has mismatch
>     disk_num_bytes (4096) and ram_bytes (4096 - 1).
>     Fix it by all assigned the disk_num_bytes and ram_bytes to 4096 - 1.

Looking at the diff for test_case_3(), I don't see any assignment of
4096 - 1 anywhere.
All the assignments I see have a value of SZ_4K or SZ_16K.

>
>   - test_case_7()
>     An extent is inserted with 16K length, but on-disk extent size is
>     only 4K.
>     This means it must be a compressed extent, so set the compressed flag
>     for it.
>
> - setup_relocation_extent_mapping()
>   This is mostly utilized by relocation code to read the chunk like an
>   inode.

Not "mostly" - it's exclusively used by the relocation code.

>   So populate the extent map using a regular non-compressed extent.

Isn't that what we already do? I'm confused.
We are already creating a regular non-compressed extent, and all the
diff does is to initialize some fields unrelated to that.

>
> In fact, the new cross checks already exposed a bug in
> btrfs_drop_extent_map_range(), and caught tons of bugs in the new
> members assignment.

I remember one bug in btrfs_drop_extent_map_range(), which fortunately
didn't have any consequences.
Those tons of bugs you mention are only in the code added by the
patchset if I understand you correctly.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_map.c             | 66 +++++++++++++++++++++++++++++++
>  fs/btrfs/relocation.c             |  4 ++
>  fs/btrfs/tests/extent-map-tests.c | 56 +++++++++++++++++++++++++-
>  fs/btrfs/tests/inode-tests.c      |  2 +-
>  4 files changed, 126 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 4d4ac9fc43e2..8d0e257fc113 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -284,6 +284,66 @@ static void merge_ondisk_extents(struct extent_map *=
prev, struct extent_map *nex
>         next->offset =3D new_offset;
>  }
>
> +static void dump_extent_map(const char *prefix, struct extent_map *em)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +               return;
> +       pr_crit("%s, start=3D%llu len=3D%llu disk_bytenr=3D%llu disk_num_=
bytes=3D%llu ram_bytes=3D%llu offset=3D%llu orig_start=3D%llu block_start=
=3D%llu block_len=3D%llu flags=3D0x%x\n",
> +               prefix, em->start, em->len, em->disk_bytenr, em->disk_num=
_bytes,
> +               em->ram_bytes, em->offset, em->orig_start, em->block_star=
t,
> +               em->block_len, em->flags);

Instead of pr_crit() please use btrfs_crit(), in the call chain we
have access to the fs_info at try_merge_map().

> +       ASSERT(0);
> +}
> +
> +/* Internal sanity checks for btrfs debug builds. */
> +static void validate_extent_map(struct extent_map *em)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +               return;
> +       if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
> +               if (em->disk_num_bytes =3D=3D 0)
> +                       dump_extent_map("zero disk_num_bytes", em);
> +               if (em->offset + em->len > em->ram_bytes)
> +                       dump_extent_map("ram_bytes too small", em);
> +               if (em->offset + em->len > em->disk_num_bytes &&
> +                   !extent_map_is_compressed(em))
> +                       dump_extent_map("disk_num_bytes too small", em);
> +
> +               if (extent_map_is_compressed(em)) {
> +                       if (em->block_start !=3D em->disk_bytenr)
> +                               dump_extent_map(
> +                               "mismatch block_start/disk_bytenr/offset"=
, em);
> +                       if (em->disk_num_bytes !=3D em->block_len)
> +                               dump_extent_map(
> +                               "mismatch disk_num_bytes/block_len", em);
> +                       /*
> +                        * Here we only check the start/orig_start/offset=
 for
> +                        * compressed extents.
> +                        * This is because em::offset is always based on =
the
> +                        * referred data extent, which can be merged.
> +                        *
> +                        * In that case, @offset would no longer match
> +                        * em::start - em::orig_start, and cause false al=
ert.
> +                        *
> +                        * Thankfully only compressed extent read/encoded=
 write
> +                        * really bothers @orig_start, so we can skip

really bothers -> care about

> +                        * the check for non-compressed extents.
> +                        */
> +                       if (em->orig_start !=3D em->start - em->offset)
> +                               dump_extent_map(
> +                               "mismatch orig_start/offset/start", em);
> +
> +               } else {
> +                       if (em->block_start !=3D em->disk_bytenr + em->of=
fset)

You can combine this as:

} else if (em->block_start !=3D em->disk_bytenr + em->offset) {

Which is clear and helps reduce indentation.

> +                               dump_extent_map(
> +                               "mismatch block_start/disk_bytenr/offset"=
, em);
> +               }
> +       } else {
> +               if (em->offset)

Same here, can be combined.

> +                       dump_extent_map("non-zero offset for hole/inline"=
, em);
> +       }
> +}
> +
>  static void try_merge_map(struct btrfs_inode *inode, struct extent_map *=
em)
>  {
>         struct extent_map_tree *tree =3D &inode->extent_tree;
> @@ -320,6 +380,7 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                                 merge_ondisk_extents(merge, em);
>                         em->flags |=3D EXTENT_FLAG_MERGED;
>
> +                       validate_extent_map(em);
>                         rb_erase_cached(&merge->rb_node, &tree->map);
>                         RB_CLEAR_NODE(&merge->rb_node);
>                         free_extent_map(merge);
> @@ -335,6 +396,7 @@ static void try_merge_map(struct btrfs_inode *inode, =
struct extent_map *em)
>                 em->block_len +=3D merge->block_len;
>                 if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>                         merge_ondisk_extents(em, merge);
> +               validate_extent_map(em);
>                 rb_erase_cached(&merge->rb_node, &tree->map);
>                 RB_CLEAR_NODE(&merge->rb_node);
>                 em->generation =3D max(em->generation, merge->generation)=
;
> @@ -446,6 +508,7 @@ static int add_extent_mapping(struct btrfs_inode *ino=
de,
>
>         lockdep_assert_held_write(&tree->lock);
>
> +       validate_extent_map(em);
>         ret =3D tree_insert(&tree->map, em);
>         if (ret)
>                 return ret;
> @@ -553,6 +616,9 @@ static void replace_extent_mapping(struct btrfs_inode=
 *inode,
>
>         lockdep_assert_held_write(&tree->lock);
>
> +       validate_extent_map(cur);

Why validate the extent map we are throwing away?
We have already validated it when we inserted it or after we merged it.

Thanks.

> +       validate_extent_map(new);
> +
>         WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
>         ASSERT(extent_map_in_tree(cur));
>         if (!(cur->flags & EXTENT_FLAG_LOGGING))
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8b24bb5a0aa1..0eb737507d12 100644
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
> index ba36794ba2d5..8c683eed9f27 100644
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
> 2.45.0
>
>

