Return-Path: <linux-btrfs+bounces-12657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E8A74FE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3569B167114
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6C1E51E9;
	Fri, 28 Mar 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZs4xERu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA361DA10C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184328; cv=none; b=U3Tg7HiI+a1v/8ReAnrUJJojKzKtTvAFlyuZld5nM19HnXEasWYG2FBBToErlV+mf65C+d7aWu/1o9IAvhifemnqaL110iPdMS+iV09X5pgsgCVZygduU8EeYbhaVW5v5SbFhK42M6/dMDB3s29PRBTDdC/CXlr7XqAmQ0b4HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184328; c=relaxed/simple;
	bh=QE+hHEoEhCvqK3PIeSbl9e5IpczxeNOPbCGHVfKowF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPNtxVeHlNja0ulHg4IjLnyjXLx+FXpTZVClkCtg7J3e1FhWaUi0M9vmt3uJJqO5GSbEbWOmC4YeiOQ6dbrgb5avzi++W19j5R+yXJUww2OPi8SPQm2KcvGyPcz5Rzf8SGaAMj5xNRDmonBP3BcavQvXyalzvZolc6U+kBaPIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZs4xERu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0DCC4AF1C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743184327;
	bh=QE+hHEoEhCvqK3PIeSbl9e5IpczxeNOPbCGHVfKowF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lZs4xERuNimETUPH67ZBCGKEXyYmJO0IxR5sj3kgVSD9eR5terUyDLg7ZaTRItl10
	 bFIbkGRogbC0aAjQlfUGZkHeRX/HWd0EhdS73cHmFF31wFIHuW+eg2htv+lqhO8iG+
	 R0BdkMVCrcAykRXNwhDzyGrCsLFtGj6GuHVlegbgJivcYJVsA82hMU43U98IDYiMjs
	 4TiOS0V0aS+v1OxvymQTw5kfGdnCG8HH7Y/JVQzCH7A3rfMf1VwHHD2HiQTR4iAAVG
	 HDHqdqrTDrRx7R1n4a0LgCdG5SVNfhydcSxrtNTtrYtlIwuWB/gZUASuaksrwFbLha
	 ofqdzzFf6WY0g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2963dc379so384511066b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 10:52:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyU89BlwLU7CUS/zr5LfmtVNfhhAkmM5PEQFIBIrBBLFSAVCLmx
	BXnolQRjUNR7gVOVkeZhJspPjK31dKfCyAYR/Pu5PzqfsaH6qvW+r3VDhG6CZKu2Mfm09I+bJll
	4o8928Q5qBKNSuxvJ5sCRdpoN5ek=
X-Google-Smtp-Source: AGHT+IF46m4E7XGwFvxGbeP5Cteps3QIAF0e6wgRpn8VaHCgs+0ncWaMOBY0PSegAeCIH3kweDdZTcxJkP6CAlNhINM=
X-Received: by 2002:a17:907:3f11:b0:ac7:31a4:d4e9 with SMTP id
 a640c23a62f3a-ac73892d538mr6478766b.4.1743184325572; Fri, 28 Mar 2025
 10:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743113694.git.wqu@suse.com> <285fe66e1d13bd9b1aa9b316da12cbaa8cb12c95.1743113694.git.wqu@suse.com>
In-Reply-To: <285fe66e1d13bd9b1aa9b316da12cbaa8cb12c95.1743113694.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Mar 2025 17:51:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4COdxNx9zEE35-iWGkcMv0k=h_s0DiRDy2hqXVqZX5tQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr-UHCyKVeAwAEALyG9RMlpg493J_s0VR1KAJ61k3t_Ab1E6ojpX4QU5N0
Message-ID: <CAL3q7H4COdxNx9zEE35-iWGkcMv0k=h_s0DiRDy2hqXVqZX5tQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: prepare btrfs_buffered_write() for large data folios
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:37=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> This involves the following modifications:
>
> - Set the order flags for __filemap_get_folio() inside
>   prepare_one_folio()
>
>   This will allow __filemap_get_folio() to create a large folio if the
>   address space supports it.
>
> - Limit the initial @write_bytes inside copy_one_range()
>   If the largest folio boundary splits the initial write range, there is
>   no way we can write beyond the largest folio boundary.
>
>   This is done by a simple helper function, calc_write_bytes().
>
> - Release exceeding reserved space if the folio is smaller than expected
>   Which is doing the same handling when short copy happened.
>
> All these preparation should not change the behavior when the largest

preparation -> preparations

> folio order is 0.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 63c7a3294eb2..5d10ae321687 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -861,7 +861,8 @@ static noinline int prepare_one_folio(struct inode *i=
node, struct folio **folio_
>  {
>         unsigned long index =3D pos >> PAGE_SHIFT;
>         gfp_t mask =3D get_prepare_gfp_flags(inode, nowait);
> -       fgf_t fgp_flags =3D (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_W=
RITEBEGIN);
> +       fgf_t fgp_flags =3D (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_W=
RITEBEGIN) |
> +                         fgf_set_order(write_bytes);
>         struct folio *folio;
>         int ret =3D 0;
>
> @@ -1169,6 +1170,16 @@ static void shrink_reserved_space(struct btrfs_ino=
de *inode,
>                                 diff, true);
>  }
>
> +/* Calculate the maximum amount of bytes we can write into one folio. */
> +static size_t calc_write_bytes(const struct btrfs_inode *inode,
> +                              const struct iov_iter *i, u64 start)

This was mentioned by David in a previous review of some other patch,
but please don't name it 'i', we only use such a name for loop index
variables.
Name it something like iter, or iov.

> +{
> +       size_t max_folio_size =3D mapping_max_folio_size(inode->vfs_inode=
.i_mapping);

Can be const.

Anyway, those are minor things, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +       return min(max_folio_size - (start & (max_folio_size - 1)),
> +                  iov_iter_count(i));
> +}
> +
>  /*
>   * Do the heavy-lifting work to copy one range into one folio of the pag=
e cache.
>   *
> @@ -1182,7 +1193,7 @@ static int copy_one_range(struct btrfs_inode *inode=
, struct iov_iter *i,
>  {
>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>         struct extent_state *cached_state =3D NULL;
> -       size_t write_bytes =3D min(iov_iter_count(i), PAGE_SIZE - offset_=
in_page(start));
> +       size_t write_bytes =3D calc_write_bytes(inode, i, start);
>         size_t copied;
>         const u64 reserved_start =3D round_down(start, fs_info->sectorsiz=
e);
>         u64 reserved_len;
> @@ -1227,6 +1238,20 @@ static int copy_one_range(struct btrfs_inode *inod=
e, struct iov_iter *i,
>                               only_release_metadata);
>                 return ret;
>         }
> +       /*
> +        * The reserved range goes beyond the current folio, shrink the r=
eserved
> +        * space to the folio boundary.
> +        */
> +       if (reserved_start + reserved_len > folio_pos(folio) + folio_size=
(folio)) {
> +               const u64 last_block =3D folio_pos(folio) + folio_size(fo=
lio);
> +
> +               shrink_reserved_space(inode, *data_reserved, reserved_sta=
rt,
> +                                     reserved_len, last_block - reserved=
_start,
> +                                     only_release_metadata);
> +               write_bytes =3D folio_pos(folio) + folio_size(folio) - st=
art;
> +               reserved_len =3D last_block - reserved_start;
> +       }
> +
>         extents_locked =3D lock_and_cleanup_extent_if_need(inode,
>                                         folio, start, write_bytes, &locks=
tart,
>                                         &lockend, nowait, &cached_state);
> --
> 2.49.0
>
>

