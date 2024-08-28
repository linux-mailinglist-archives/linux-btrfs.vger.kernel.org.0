Return-Path: <linux-btrfs+bounces-7622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A78962A10
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C797A286004
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015618991E;
	Wed, 28 Aug 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnfFRH+/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F472D600
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854923; cv=none; b=YhafeMWeGZVA7xXG5z0dO9JYPfsE/iGIFpO79FhsUaJh00Wz6e5XR/NgcXBrCpoaQkTzHhKpsczBEv2RYSNXHnuYMvnqo4jO1OPxvDIDY0SeWKzJPjgoXE9Nt8yeQYZNasim/8uAl5p+pSmetYzpDMzqkdeKlpJnU+iw+cx36Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854923; c=relaxed/simple;
	bh=SBR3Of/Y1aT9FCy4MHhLP3xuXOa12SKXSMTDaq6L9HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrU7wCCt2/ulYWOmDtWFBjiNbmxFUyb6GFRTi56RuHsFXKtVOyU+WMBNydo5oywbYZSC0MMVqWURlAD5DJOhOsuTVjsyBSy5JfRx13LbOd8mdheQBGciCgukdYz3iZbpZM97FiGXz3uJlGp3IsXqsN9HIKRS/y1xB71vKy/xO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnfFRH+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA99C4FEFB
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724854923;
	bh=SBR3Of/Y1aT9FCy4MHhLP3xuXOa12SKXSMTDaq6L9HA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EnfFRH+/48sBUBmsSpRVRh6W3Mcc5Lp7vZ+1oITqU8YGqdQ89dx+UWqTI48xHE3aJ
	 hn1gOD5j3b1MdsgvRYTdMQBSH0btNQEeIzTKt6voRR6bIEUXHWFm/rLqv/IIdmHArM
	 d+cMd/hNQZb4vS8Rf/3P6oi+94xox1567Ih3wGGHEW0BCI0QgKbljo7ZoMh5dOLFoc
	 kpCZjg+beooYmDTvgZi+22UShrGeAqrHTPZ6xuwxrkhMekRIeVREC5qpmqYRzqMzyf
	 5VzTjDTUFBegpVFwN9fYS3WbumSwHuYDKXX9UjG08O4IZ8iyUgW2cR8ykvjtXu4FIk
	 4xNg96XTZFL4A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86abbd68ffso133187966b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 07:22:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIdIx/etlZ+OHLcwk78u4Nz95BYp1tlNB5rNSd/N/ZAhawC98g
	PXN7581jbPAl+vphvhFKlHLLiekOQWSLlLSGtuiuE7WlEebe+hhiS/+lBhAVCAAr1jZocmBWkxC
	AdDDdVC+xUJpYh6ZGVX3QYlOEWNg=
X-Google-Smtp-Source: AGHT+IEiveQWt7W+H9i+5x33M/Oc8caLg39oXiQv9E5AZlq9isHDXUXwbSb3IqmpgsAMQ6Xc73Xta8O4dufvIYlvovg=
X-Received: by 2002:a17:907:96a6:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a870aaaac94mr286139966b.28.1724854921693; Wed, 28 Aug 2024
 07:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724847323.git.rgoldwyn@suse.com> <f50af2f3cbcfc390265a09ac1962a8afb1b5c22d.1724847323.git.rgoldwyn@suse.com>
In-Reply-To: <f50af2f3cbcfc390265a09ac1962a8afb1b5c22d.1724847323.git.rgoldwyn@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 28 Aug 2024 15:21:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4hASwiFUazGnEwtBpN7fDsdZ_t+wE-VHaMKheXt4F1Xg@mail.gmail.com>
Message-ID: <CAL3q7H4hASwiFUazGnEwtBpN7fDsdZ_t+wE-VHaMKheXt4F1Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: reduce scope of extent locks during buffered write
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:54=E2=80=AFPM Goldwyn Rodrigues <rgoldwyn@suse.de=
> wrote:
>
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> Reduce the scope of locking while performing writes. The scope is
> limited to changing extent bits, which is in btrfs_dirty_pages().
> btrfs_dirty_pages() is also called from __btrfs_write_out_cache(), and
> it expects extent locks held. So, perform extent locking around
> btrfs_dirty_pages() only.

There's one fundamental problem I missed before. Comments inlined below.

>
> The inode lock will insure that no other process is writing to this
> file, so we don't need to worry about multiple processes dirtying
> folios.

Well, there's an exception: memory mapped writes, as they don't take
the inode lock.

So this patch introduces a race, see below.

>
> However, the write has to make sure that there are no ordered extents in
> the range specified. So, call btrfs_wait_ordered_range() before
> initiating the write. In case of nowait, bail if there exists an
> ordered range within the write range.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 109 +++++++-----------------------------------------
>  1 file changed, 16 insertions(+), 93 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 76f4cc686af9..6c5f712bfa0f 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -976,83 +976,6 @@ static noinline int prepare_pages(struct inode *inod=
e, struct page **pages,
>
>  }
>
> -/*
> - * This function locks the extent and properly waits for data=3Dordered =
extents
> - * to finish before allowing the pages to be modified if need.
> - *
> - * The return value:
> - * 1 - the extent is locked
> - * 0 - the extent is not locked, and everything is OK
> - * -EAGAIN - need re-prepare the pages
> - * the other < 0 number - Something wrong happens
> - */
> -static noinline int
> -lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page *=
*pages,
> -                               size_t num_pages, loff_t pos,
> -                               size_t write_bytes,
> -                               u64 *lockstart, u64 *lockend, bool nowait=
,
> -                               struct extent_state **cached_state)
> -{
> -       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -       u64 start_pos;
> -       u64 last_pos;
> -       int i;
> -       int ret =3D 0;
> -
> -       start_pos =3D round_down(pos, fs_info->sectorsize);
> -       last_pos =3D round_up(pos + write_bytes, fs_info->sectorsize) - 1=
;
> -
> -       if (start_pos < inode->vfs_inode.i_size) {
> -               struct btrfs_ordered_extent *ordered;
> -
> -               if (nowait) {
> -                       if (!try_lock_extent(&inode->io_tree, start_pos, =
last_pos,
> -                                            cached_state)) {
> -                               for (i =3D 0; i < num_pages; i++) {
> -                                       unlock_page(pages[i]);
> -                                       put_page(pages[i]);
> -                                       pages[i] =3D NULL;
> -                               }
> -
> -                               return -EAGAIN;
> -                       }
> -               } else {
> -                       lock_extent(&inode->io_tree, start_pos, last_pos,=
 cached_state);
> -               }
> -
> -               ordered =3D btrfs_lookup_ordered_range(inode, start_pos,
> -                                                    last_pos - start_pos=
 + 1);
> -               if (ordered &&
> -                   ordered->file_offset + ordered->num_bytes > start_pos=
 &&
> -                   ordered->file_offset <=3D last_pos) {
> -                       unlock_extent(&inode->io_tree, start_pos, last_po=
s,
> -                                     cached_state);
> -                       for (i =3D 0; i < num_pages; i++) {
> -                               unlock_page(pages[i]);
> -                               put_page(pages[i]);
> -                       }
> -                       btrfs_start_ordered_extent(ordered);
> -                       btrfs_put_ordered_extent(ordered);
> -                       return -EAGAIN;
> -               }
> -               if (ordered)
> -                       btrfs_put_ordered_extent(ordered);
> -
> -               *lockstart =3D start_pos;
> -               *lockend =3D last_pos;
> -               ret =3D 1;
> -       }
> -
> -       /*
> -        * We should be called after prepare_pages() which should have lo=
cked
> -        * all pages in the range.
> -        */
> -       for (i =3D 0; i < num_pages; i++)
> -               WARN_ON(!PageLocked(pages[i]));
> -
> -       return ret;
> -}
> -
>  /*
>   * Check if we can do nocow write into the range [@pos, @pos + @write_by=
tes)
>   *
> @@ -1246,7 +1169,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, st=
ruct iov_iter *i)
>                 size_t copied;
>                 size_t dirty_sectors;
>                 size_t num_sectors;
> -               int extents_locked;
> +               int extents_locked =3D false;
>
>                 /*
>                  * Fault pages before locking them in prepare_pages
> @@ -1310,13 +1233,19 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, =
struct iov_iter *i)
>                 }
>
>                 release_bytes =3D reserve_bytes;
> -again:
>                 ret =3D balance_dirty_pages_ratelimited_flags(inode->i_ma=
pping, bdp_flags);
>                 if (ret) {
>                         btrfs_delalloc_release_extents(BTRFS_I(inode), re=
serve_bytes);
>                         break;
>                 }
>
> +               if (nowait && !btrfs_has_ordered_extent(BTRFS_I(inode), p=
os, write_bytes)) {
> +                       btrfs_delalloc_release_extents(BTRFS_I(inode), re=
serve_bytes);
> +                       break;
> +               } else {
> +                       btrfs_wait_ordered_range(BTRFS_I(inode), pos, wri=
te_bytes);

So after waiting for ordered extents, we call prepare_pages() below,
which is what gets and locks the pages.

But after this wait and before we lock the pages, a mmap write can
happen, it dirties pages and if after it completes and before we lock
the pages at prepare_pages(), delalloc is flushed, an ordered extent
for the range is created - and we will miss it here and not wait for
it to complete.

Before this patch that couldn't happen, as we always lock the extent
range before locking pages.

Thanks.


> +               }
> +
>                 /*
>                  * This is going to setup the pages array with the number=
 of
>                  * pages we want, so we don't really need to worry about =
the
> @@ -1330,20 +1259,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, s=
truct iov_iter *i)
>                         break;
>                 }
>
> -               extents_locked =3D lock_and_cleanup_extent_if_need(
> -                               BTRFS_I(inode), pages,
> -                               num_pages, pos, write_bytes, &lockstart,
> -                               &lockend, nowait, &cached_state);
> -               if (extents_locked < 0) {
> -                       if (!nowait && extents_locked =3D=3D -EAGAIN)
> -                               goto again;
> -
> -                       btrfs_delalloc_release_extents(BTRFS_I(inode),
> -                                                      reserve_bytes);
> -                       ret =3D extents_locked;
> -                       break;
> -               }
> -
>                 copied =3D btrfs_copy_from_user(pos, write_bytes, pages, =
i);
>
>                 num_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, reserve_byte=
s);
> @@ -1389,6 +1304,14 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, s=
truct iov_iter *i)
>                 release_bytes =3D round_up(copied + sector_offset,
>                                         fs_info->sectorsize);
>
> +               if (pos < inode->i_size) {
> +                       lockstart =3D round_down(pos, fs_info->sectorsize=
);
> +                       lockend =3D round_up(pos + copied, fs_info->secto=
rsize);
> +                       lock_extent(&BTRFS_I(inode)->io_tree, lockstart,
> +                                     lockend, &cached_state);
> +                       extents_locked =3D true;
> +               }
> +
>                 ret =3D btrfs_dirty_pages(BTRFS_I(inode), pages,
>                                         dirty_pages, pos, copied,
>                                         &cached_state, only_release_metad=
ata);
> --
> 2.46.0
>
>

