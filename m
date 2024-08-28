Return-Path: <linux-btrfs+bounces-7619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D553A962871
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836AB283645
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E89187873;
	Wed, 28 Aug 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUSdLDL3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E6175D48
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851084; cv=none; b=uqukUzs7VeqwYuDXpOU9eoyI7Bn3n7XI5d4W5AWPmtmknl57DU2Cw+mFfCddMm+bgMlbkchG6P8eTiTTnsfvPnG36Wt0x/kICfvTGCw3Sjk7CWQRL0gCxTUZxWQeyXf63lsYCE5vYUKc5gtF4Wg/GQUaIiVvA4ZRNjT324XDk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851084; c=relaxed/simple;
	bh=TiklkbBt/F7gJ/xNu4/Is1ZEZiJ8YN5hMCVk3vGsoXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfmdIjYXpU81YldYanbREfCMKr/+eJx5z0cGCqK6PUnQ7KH//9UAK/KO2cogU7ulllnyffjnymINXAv4PqBg5mPuPAd82pJXpiFkWz2Dk6ALUYOK7wQg2RSWIHK0ZJB/fKoTnL33Xv1rrgGWxV8a4aDp2SLhxkTd2Uq8A+AI1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUSdLDL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEF5C98EE5
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851084;
	bh=TiklkbBt/F7gJ/xNu4/Is1ZEZiJ8YN5hMCVk3vGsoXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GUSdLDL3cW9Efzo3an81/QClybGtYAWhUYIalmZXo8Ee3xEJuEtIxkrSKFRyeloeP
	 KYpk39o0Kxscx+ou1H6CYqyl03pCjZViUfyHCObNRa6T4F5Av1uEjNeWuqPTLEx41W
	 7Ryt+2KSvMaXhlGmBMlQincGMGXmMKHQstVe5MAFjIB4yaiYW50bgGbp4jx76nPmpp
	 NPK4uVYv78Nr282NhpC92j5sqhHSU+dQXas3lIHym77dJB1AYXAxC+SRUqeEA/2T55
	 srVXwRyyffZJUby7IZ/uoBo+qa/y+msY3NCzgTYmjyzOqiK9mreOM3nJNt6iiGp/E6
	 DCm3vX4BzIdyw==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371b098e699so5482383f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 06:18:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YxZ7kSJjLwQXcQPmmtlKO1dawi4kSl5Yr/WFnAv1CMyVx4xdyvt
	AxhINgsqPk4JEDUK6aHywlQnJr+SnWeKenTW62e4K3WuwQJ7y3z4HgkDb45yE9ygyFkgCFJ0EiB
	/qz9fD+MXYAo0baC/5l90S18egyo=
X-Google-Smtp-Source: AGHT+IEpsv04+nu4G4c2aKIXCOGVf1kG2vvmY6XltKbKSJD5jZR4RRK+k9rfTjKmms4XFHFwApLpYWMbZbOAUnx6rGU=
X-Received: by 2002:a05:6000:1b92:b0:371:79f0:2cfb with SMTP id
 ffacd0b85a97d-373118c8523mr11787693f8f.46.1724851082549; Wed, 28 Aug 2024
 06:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724847323.git.rgoldwyn@suse.com> <f50af2f3cbcfc390265a09ac1962a8afb1b5c22d.1724847323.git.rgoldwyn@suse.com>
In-Reply-To: <f50af2f3cbcfc390265a09ac1962a8afb1b5c22d.1724847323.git.rgoldwyn@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 28 Aug 2024 14:17:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7VJCzLFT7P+eyDkZsLVcySvO0Yqw0JWAvrf3n=hcVv-A@mail.gmail.com>
Message-ID: <CAL3q7H7VJCzLFT7P+eyDkZsLVcySvO0Yqw0JWAvrf3n=hcVv-A@mail.gmail.com>
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
>
> The inode lock will insure that no other process is writing to this
> file, so we don't need to worry about multiple processes dirtying
> folios.
>
> However, the write has to make sure that there are no ordered extents in
> the range specified. So, call btrfs_wait_ordered_range() before
> initiating the write. In case of nowait, bail if there exists an
> ordered range within the write range.

if there exists an ordered range -> if there exists an ordered extent

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

This is an int. So either assign to 0 or change the type to bool (preferabl=
e).

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

The logic is not correct, the ! should be removed.
I.e. if it's a nowait write and there are ordered extents, we want to
stop because it would make us block waiting for ordered extents.

> +                       btrfs_delalloc_release_extents(BTRFS_I(inode), re=
serve_bytes);
> +                       break;

Before the break we also need a:  ret =3D -EAGAIN

We should also prevent looking up ordered extents if the write starts
at or beyond i_size, just like before this patch.

> +               } else {
> +                       btrfs_wait_ordered_range(BTRFS_I(inode), pos, wri=
te_bytes);
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

We should respect the nowait semantics and do a try_lock_extent() if
we're a nowait write.


> +                       extents_locked =3D true;

Same here, the type is int and not bool.

Thanks.

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

