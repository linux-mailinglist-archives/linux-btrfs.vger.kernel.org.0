Return-Path: <linux-btrfs+bounces-9948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110D9DB7CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81B3163A3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6919DF5F;
	Thu, 28 Nov 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or1EFYZe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96E1E4BE
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797509; cv=none; b=pOA9pUmKTu8b9s1Zh7Pbr4cdRUd8G3XDHZVEOSTCLrXDtLe0bop6y7nPNQWyBs5bXKtbdzGtNGEOOtqMINMX9V7xWzwvSPdduCV6EsGuOKcfPGixT6tX5KNtj6Km/8nKlZGOCiUkbqXi3uEdrWXRqvQFA1Zli7orcBHo5Ybp0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797509; c=relaxed/simple;
	bh=RS/bR9WSC3MRyBE8rDRXSergm0NkhFYHZEBAcrBiWR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA9Wutv/m+2joPm5Gb7p3VQQWhRdaSlWyJo23EtzdVRJ92hBwk1cyogseqzVOASliNBWmTugrVtD7jhXsPlSk3vGpGddkChqoGxR5JEx9Moy+uRFNyXSxjli12M0eDh4S6a/F4qgxVXGTEYeE9VCLUXP+QR9lcnXbGKsRv+Z0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or1EFYZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7214FC4CECE
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797509;
	bh=RS/bR9WSC3MRyBE8rDRXSergm0NkhFYHZEBAcrBiWR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Or1EFYZeA5NrwQO+tLrTJ4zjvOgSFgECGdWXUkFudrcS4ukOn4aLaPkAwhhST/GtZ
	 O+G3jt2AMkMelYfLxAtwDu7KmQtRcrRMp3XgjiIevbaRV4szrRo2U0GLJtoPq7AJ7N
	 Otq3sAQx75qDqDg5QM+qxSJdWsKM9rKaEfxxnQcAZ4MoQeXqzGgwImHiCotqITmUZ+
	 zdZLtw+8m/kuNTIvodvHu/VgdBFCEz87femyH2+pQmWE82c7qdLrYPPGEO6TlIhahQ
	 ukHSF21AWy5FemdGHH0uSX+TuJZ2gXKiQy9J02dSyq5nSXsNFdQcmtyLXKuyLJUvVj
	 saxsYPr3SnuGQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so916790a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 04:38:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yw14S4S4dE+nrp3x6/mQub17YYdyw/vp9MY0IwGrSVNUJCh6pVB
	++HANgTZRa1LWbN/DAL4/M3yPdmp3OTvBiyOFReaD5R765UIsIZIH096qovdzncI386EQmRSNnb
	5sfAUofwzBlOUa9t+riamVan1rUk=
X-Google-Smtp-Source: AGHT+IFhFngKLnx4f2v1XyqEkUxmIGGnNs3EWbINroMurFv+jbyxpKFhEIPGnUPpaBXt8UuIrojxO4IyHGdx+QQ77NA=
X-Received: by 2002:a17:907:61a2:b0:aa5:4d72:6dd7 with SMTP id
 a640c23a62f3a-aa580f58471mr483519166b.29.1732797507953; Thu, 28 Nov 2024
 04:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128093428.21485-1-jth@kernel.org>
In-Reply-To: <20241128093428.21485-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Nov 2024 12:37:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5gy1wd-07a8rGdo2=AYHioPO1FXp3CD-5yBYDzSwL6DA@mail.gmail.com>
Message-ID: <CAL3q7H5gy1wd-07a8rGdo2=AYHioPO1FXp3CD-5yBYDzSwL6DA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't BUG_ON() in btrfs_drop_extents()
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 9:34=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
> extents is greater than 0 in two code paths. But both of these code paths
> can handle errors, so there's no need to crash the kernel, but gracefully
> bail out.
>
> For developer builds with CONFIG_BTRFS_ASSERT turned on, ASSERT() that
> this conditon is never met.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/file.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fbb753300071..33f0de10df5b 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -245,7 +245,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>  next_slot:
>                 leaf =3D path->nodes[0];
>                 if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> -                       BUG_ON(del_nr > 0);
> +                       ASSERT(del_nr =3D=3D 0);
> +                       if (del_nr > 0) {
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
>                         ret =3D btrfs_next_leaf(root, path);
>                         if (ret < 0)
>                                 break;
> @@ -321,7 +325,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>                  *  | -------- extent -------- |
>                  */
>                 if (args->start > key.offset && args->end < extent_end) {
> -                       BUG_ON(del_nr > 0);
> +                       ASSERT(del_nr =3D=3D 0);
> +                       if (del_nr > 0) {
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }

Why only these 2 BUG_ON()'s?

There's another BUG_ON(del_nr > 0) below.

There's also a similar one further below:

BUG_ON(del_slot + del_nr !=3D path->slots[0]);

Also, I'd rather have a WARN_ON() in the if statements, so that in
case assertions are disabled (and they are disabled on some distros by
default),
we get better chances of the issue getting noticed and reported by users.

Thanks.


>                         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) =
{
>                                 ret =3D -EOPNOTSUPP;
>                                 break;
> --
> 2.47.0
>
>

