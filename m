Return-Path: <linux-btrfs+bounces-12656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C2DA74FAD
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEFD16EDB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1791C8615;
	Fri, 28 Mar 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpW1paj2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBA3595A
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183999; cv=none; b=n9SB/226JZ309i+6SlzRtt692OKqdvN9f+t5sQxm4Ka7jk4pVztrWZ1bxTHQs/IUeNBL2y6vbYqjBcTh5YbCtGPBl7SiHHtUtXxrvn7IwIUSaSBKg82ADj4VAg6T9IEkXhLkgYadgAIDaGjPeDXOtCk3Rq0566AYPHOVGsW673s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183999; c=relaxed/simple;
	bh=JZPJd6teUu3Hxqcfgkawy8s8jkrrzPlnnlddnKxFfNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXsLyBn9l69WyayKfZhJ939gBzH6QpV5lvb+bcHtJHRMilMSK3ZTWBg1BsgkHOdHhnJYPjUZZrsq2GpzHfhJb+q3jvlJ8J22G4DU0o8jFvazZhZ3XmE+++Bwvd9JFz44N7CRUbdmuvWP6d4GJPz0A7kbq4laOC9tfp5i3F3B2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpW1paj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B630AC4CEE9
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743183998;
	bh=JZPJd6teUu3Hxqcfgkawy8s8jkrrzPlnnlddnKxFfNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DpW1paj21TTlDycHtuupbkwPW7Ge6XdgG4ofo449iC5Lfq2IgEKopKw0qCGuXBPzB
	 KRkHjwTqUyRtMNJS4Vz12elRe/0x2qDI7HSGCQJToOczVjTlC7Vfc7Ff5Bv2IcVNFM
	 8cCqxN6dOYoc2TV4hjoDM+E5G5yKMjM7ZR9bgzLQcYdzCU5V2kq/DGXh7EMa9zwz4e
	 Cz0CzPWYTZnBu3IfnunH5BpKHTNyLcBD3n/1JEVmxf6bp/2oAbS2eC4M4slkOjNzqP
	 5DB1ECvGMZFwZHZXUPRTQHd8ukIGFOKJn8+Qu3Tc1/zdUEdRGpD7ofhUI9x3FDUOze
	 kuKNihXGHjImw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac298c8fa50so403203066b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 10:46:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQX1N+HBQMJKjZznwhTiGATPvd/nLFZ7D2JIFwShn9JEznmHxv
	F4CTIqOOxx8xrnZpTxzs6HN1TGL4W6feecs4fEro5u/pcoFyqiQNeiinBb02bGvMGMdPEf8WzdL
	/4dIOF2bi/WRK/cMWNc5limKglYo=
X-Google-Smtp-Source: AGHT+IFnN3LbH0MIc9bw6u0x6B5vFU9ae0+77DCpQKlkexfWBu/raQNWueWM8EcmpHpWJvIMMRoIN2QFo004F6SWDzQ=
X-Received: by 2002:a17:907:981:b0:abf:6ebf:5500 with SMTP id
 a640c23a62f3a-ac7389b557dmr5143966b.16.1743183997248; Fri, 28 Mar 2025
 10:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743113694.git.wqu@suse.com> <4baa663dcabe3a542e035ec725586118a78b0971.1743113694.git.wqu@suse.com>
In-Reply-To: <4baa663dcabe3a542e035ec725586118a78b0971.1743113694.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 17:45:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6VnE2T=6t41Prf4wZPKSYim44UmCJwC26ykregdZnCJg@mail.gmail.com>
X-Gm-Features: AQ5f1Jov_lsfP_Ap-cj86MtwzfROm-0yLiXg4qp_HGnMES0KRFsrMp6jpKrgYrs
Message-ID: <CAL3q7H6VnE2T=6t41Prf4wZPKSYim44UmCJwC26ykregdZnCJg@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: refactor how we handle reserved space inside copy_one_range()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:36=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> There are several things not ideal inside copy_one_range():
>
> - Unnecessary temporary variables
>   * block_offset
>   * reserve_bytes
>   * dirty_blocks
>   * num_blocks
>   * release_bytes
>   These are utilized to handle short-copy cases.
>
> - Inconsistent handling of btrfs_delalloc_release_extents()
>   There is a hidden behavior that, after reserving metadata for X bytes
>   of data write, we have to call btrfs_delalloc_release_extents() with X
>   once and only once.
>
>   Calling btrfs_delalloc_release_extents(X - 4K) and
>   btrfs_delalloc_release_extents(4K) will cause outstanding extents
>   accounting to go wrong.
>
>   This is because the outstanding extents mechanism is not designed to
>   handle shrink of reserved space.
>
> Improve above situations by:
>
> - Use a single @reserved_start and @reserved_len pair
>   Now we reserved space for the initial range, and if a short copy
>   happened and we need to shrink the reserved space, we can easily
>   calculate the new length, and update @reserved_len.
>
> - Introduce helpers to shrink reserved data and metadata space
>   This is done by two new helper, shrink_reserved_space() and
>   btrfs_delalloc_shrink_extents().
>
>   The later will do a better calculation on if we need to modify the
>   outstanding extents, and the first one will be utlized inside
>   copy_one_range().
>
> - Manually unlock, release reserved space and return if no byte is
>   copied
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/delalloc-space.c |  25 +++++++++
>  fs/btrfs/delalloc-space.h |   3 +-
>  fs/btrfs/file.c           | 104 ++++++++++++++++++++++----------------
>  3 files changed, 88 insertions(+), 44 deletions(-)
>
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index 88e900e5a43d..916b62221dde 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -439,6 +439,31 @@ void btrfs_delalloc_release_extents(struct btrfs_ino=
de *inode, u64 num_bytes)
>         btrfs_inode_rsv_release(inode, true);
>  }
>
> +/* Shrink a previously reserved extent to a new length. */
> +void btrfs_delalloc_shrink_extents(struct btrfs_inode *inode, u64 reserv=
ed_len,
> +                                  u64 new_len)
> +{
> +       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +       const u32 reserved_num_extents =3D count_max_extents(fs_info, res=
erved_len);
> +       const u32 new_num_extents =3D count_max_extents(fs_info, new_len)=
;
> +       u32 diff_num_extents;
> +
> +       ASSERT(new_len <=3D reserved_len);
> +       if (new_num_extents =3D=3D reserved_num_extents)
> +               return;
> +
> +       spin_lock(&inode->lock);
> +       diff_num_extents =3D reserved_num_extents - new_num_extents;

This doesn't need to be done while holding the lock, and in fact
should be done outside to reduce time spent in a critical section.
It's a simple expression that can be done when declaring the variable
and also make it const.

> +       btrfs_mod_outstanding_extents(inode, -diff_num_extents);

We can also make the sign change when declaring the variable, something lik=
e:

const int diff_num_extents =3D -((int)(reserved_num_extents - new_num_exten=
ts));

The way it is, turning an unsigned into a negative is also a bit odd
to read, I think it makes it more clear if we have a signed type.

> +       btrfs_calculate_inode_block_rsv_size(fs_info, inode);
> +       spin_unlock(&inode->lock);
> +
> +       if (btrfs_is_testing(fs_info))
> +               return;
> +
> +       btrfs_inode_rsv_release(inode, true);
> +}
> +
>  /*
>   * Reserve data and metadata space for delalloc
>   *
> diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
> index 3f32953c0a80..c61580c63caf 100644
> --- a/fs/btrfs/delalloc-space.h
> +++ b/fs/btrfs/delalloc-space.h
> @@ -27,5 +27,6 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *in=
ode,
>  int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_b=
ytes,
>                                     u64 disk_num_bytes, bool noflush);
>  void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_b=
ytes);
> -
> +void btrfs_delalloc_shrink_extents(struct btrfs_inode *inode, u64 reserv=
ed_len,
> +                                  u64 new_len);
>  #endif /* BTRFS_DELALLOC_SPACE_H */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index b72fc00bc2f6..63c7a3294eb2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1151,6 +1151,24 @@ static ssize_t reserve_space(struct btrfs_inode *i=
node,
>         return reserve_bytes;
>  }
>
> +/* Shrink the reserved data and metadata space from @reserved_len to @ne=
w_len. */
> +static void shrink_reserved_space(struct btrfs_inode *inode,
> +                                 struct extent_changeset *data_reserved,
> +                                 u64 reserved_start, u64 reserved_len,
> +                                 u64 new_len, bool only_release_metadata=
)
> +{
> +       u64 diff =3D reserved_len - new_len;

Can be made const.

> +
> +       ASSERT(new_len <=3D reserved_len);
> +       btrfs_delalloc_shrink_extents(inode, reserved_len, new_len);
> +       if (only_release_metadata)
> +               btrfs_delalloc_release_metadata(inode, diff, true);
> +       else
> +               btrfs_delalloc_release_space(inode, data_reserved,
> +                               reserved_start + new_len,
> +                               diff, true);

This could fit in 2 lines instead of 3.

Anyway those are minor things, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +}
> +
>  /*
>   * Do the heavy-lifting work to copy one range into one folio of the pag=
e cache.
>   *
> @@ -1164,14 +1182,11 @@ static int copy_one_range(struct btrfs_inode *ino=
de, struct iov_iter *i,
>  {
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct extent_state *cached_state =3D NULL;
> -       const size_t block_offset =3D start & (fs_info->sectorsize - 1);
>         size_t write_bytes =3D min(iov_iter_count(i), PAGE_SIZE - offset_=
in_page(start));
> -       size_t reserve_bytes;
>         size_t copied;
> -       size_t dirty_blocks;
> -       size_t num_blocks;
> +       const u64 reserved_start =3D round_down(start, fs_info->sectorsiz=
e);
> +       u64 reserved_len;
>         struct folio *folio =3D NULL;
> -       u64 release_bytes;
>         int extents_locked;
>         u64 lockstart;
>         u64 lockend;
> @@ -1190,23 +1205,25 @@ static int copy_one_range(struct btrfs_inode *ino=
de, struct iov_iter *i,
>                             &only_release_metadata);
>         if (ret < 0)
>                 return ret;
> -       reserve_bytes =3D ret;
> -       release_bytes =3D reserve_bytes;
> +       reserved_len =3D ret;
> +       /* Write range must be inside the reserved range. */
> +       ASSERT(reserved_start <=3D start);
> +       ASSERT(start + write_bytes <=3D reserved_start + reserved_len);
>
>  again:
>         ret =3D balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_=
mapping,
>                                                     bdp_flags);
>         if (ret) {
> -               btrfs_delalloc_release_extents(inode, reserve_bytes);
> -               release_space(inode, *data_reserved, start, release_bytes=
,
> +               btrfs_delalloc_release_extents(inode, reserved_len);
> +               release_space(inode, *data_reserved, reserved_start, rese=
rved_len,
>                               only_release_metadata);
>                 return ret;
>         }
>
>         ret =3D prepare_one_folio(&inode->vfs_inode, &folio, start, write=
_bytes, false);
>         if (ret) {
> -               btrfs_delalloc_release_extents(inode, reserve_bytes);
> -               release_space(inode, *data_reserved, start, release_bytes=
,
> +               btrfs_delalloc_release_extents(inode, reserved_len);
> +               release_space(inode, *data_reserved, reserved_start, rese=
rved_len,
>                               only_release_metadata);
>                 return ret;
>         }
> @@ -1217,8 +1234,8 @@ static int copy_one_range(struct btrfs_inode *inode=
, struct iov_iter *i,
>                 if (!nowait && extents_locked =3D=3D -EAGAIN)
>                         goto again;
>
> -               btrfs_delalloc_release_extents(inode, reserve_bytes);
> -               release_space(inode, *data_reserved, start, release_bytes=
,
> +               btrfs_delalloc_release_extents(inode, reserved_len);
> +               release_space(inode, *data_reserved, reserved_start, rese=
rved_len,
>                               only_release_metadata);
>                 ret =3D extents_locked;
>                 return ret;
> @@ -1228,42 +1245,43 @@ static int copy_one_range(struct btrfs_inode *ino=
de, struct iov_iter *i,
>                         offset_in_folio(folio, start), write_bytes, i);
>         flush_dcache_folio(folio);
>
> -       /*
> -        * If we get a partial write, we can end up with partially uptoda=
te
> -        * page. Although if sector size < page size we can handle it, bu=
t if
> -        * it's not sector aligned it can cause a lot of complexity, so m=
ake
> -        * sure they don't happen by forcing retry this copy.
> -        */
>         if (unlikely(copied < write_bytes)) {
> +               u64 last_block;
> +
> +               /*
> +                * The original write range doesn't need an uptodate foli=
o as
> +                * the range is block aligned. But now a short copy happe=
ned.
> +                * We can not handle it without an uptodate folio.
> +                *
> +                * So just revert the range and we will retry.
> +                */
>                 if (!folio_test_uptodate(folio)) {
>                         iov_iter_revert(i, copied);
>                         copied =3D 0;
>                 }
> -       }
>
> -       num_blocks =3D BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
> -       dirty_blocks =3D round_up(copied + block_offset, fs_info->sectors=
ize);
> -       dirty_blocks =3D BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
> -
> -       if (copied =3D=3D 0)
> -               dirty_blocks =3D 0;
> -
> -       if (num_blocks > dirty_blocks) {
> -               /* Release everything except the sectors we dirtied. */
> -               release_bytes -=3D dirty_blocks << fs_info->sectorsize_bi=
ts;
> -               if (only_release_metadata) {
> -                       btrfs_delalloc_release_metadata(inode,
> -                                               release_bytes, true);
> -               } else {
> -                       const u64 release_start =3D round_up(start + copi=
ed,
> -                                                          fs_info->secto=
rsize);
> -
> -                       btrfs_delalloc_release_space(inode,
> -                                       *data_reserved, release_start,
> -                                       release_bytes, true);
> +               /* No copied byte, unlock, release reserved space and exi=
t. */
> +               if (copied =3D=3D 0) {
> +                       if (extents_locked)
> +                               unlock_extent(&inode->io_tree, lockstart,=
 lockend,
> +                                     &cached_state);
> +                       else
> +                               free_extent_state(cached_state);
> +                       btrfs_delalloc_release_extents(inode, reserved_le=
n);
> +                       release_space(inode, *data_reserved, reserved_sta=
rt, reserved_len,
> +                                     only_release_metadata);
> +                       btrfs_drop_folio(fs_info, folio, start, copied);
> +                       return 0;
>                 }
> +
> +               /* Release the reserved space beyond the last block. */
> +               last_block =3D round_up(start + copied, fs_info->sectorsi=
ze);
> +
> +               shrink_reserved_space(inode, *data_reserved, reserved_sta=
rt,
> +                                     reserved_len, last_block - reserved=
_start,
> +                                     only_release_metadata);
> +               reserved_len =3D last_block - reserved_start;
>         }
> -       release_bytes =3D round_up(copied + block_offset, fs_info->sector=
size);
>
>         ret =3D btrfs_dirty_folio(inode, folio, start, copied,
>                                 &cached_state, only_release_metadata);
> @@ -1280,10 +1298,10 @@ static int copy_one_range(struct btrfs_inode *ino=
de, struct iov_iter *i,
>         else
>                 free_extent_state(cached_state);
>
> -       btrfs_delalloc_release_extents(inode, reserve_bytes);
> +       btrfs_delalloc_release_extents(inode, reserved_len);
>         if (ret) {
>                 btrfs_drop_folio(fs_info, folio, start, copied);
> -               release_space(inode, *data_reserved, start, release_bytes=
,
> +               release_space(inode, *data_reserved, reserved_start, rese=
rved_len,
>                               only_release_metadata);
>                 return ret;
>         }
> --
> 2.49.0
>
>

