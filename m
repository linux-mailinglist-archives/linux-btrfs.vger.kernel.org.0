Return-Path: <linux-btrfs+bounces-3961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAB899CE0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E43F1F23171
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CC816C862;
	Fri,  5 Apr 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb1fgdvl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FD16C847
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320071; cv=none; b=I3e98CqAa3rub2zFO76ubpsgi2Qn6NpBZS+06tuWSfPplAdyANcS6+HouetQCvcffZESxS9LjqXKr5+8/leQ7GApr/TmDcquWGod/jaREma03NeCijZcTISaBiiYvR0zZ1Fcyum2xi7jwZEkGtu5Bq2tx18U05Ln5IHRUJ5u8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320071; c=relaxed/simple;
	bh=DKT1Zg5AyGXKG1/GBjvyofXowrsM1uVw5gOdMqIUbls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRbQM28Y+K7PNaONQ0U+m/f5RTg/zs9GX0xaTO5p3uEH4E7DHsdcN3YkOYEZkX9UEUgApw/89rz+pUUjRkSBniDs9qkri42EBd0co7Hr46ZTjQmwI22jyIOxyZFY5lcagJTCduK5D/wv/5ZgGRikTjl4NS1nZjBOrIyggGoByi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb1fgdvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE08DC43390
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712320070;
	bh=DKT1Zg5AyGXKG1/GBjvyofXowrsM1uVw5gOdMqIUbls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gb1fgdvlIW0VDRwxZT9fBnmXj9s8Gfqb4WGFlJKmSrORTe10C2vEXkwrTBmRhT7Pj
	 vNmFAy0/LDGtGouKC9lzSllqFx1YeQL7Z3jI1tnTT9J43SRMasHe6cn8r1/4De2Yii
	 Rp559nf9fIreGprYdUqrPzT0eOntupZ0LIjdvIZOpU0rUsEa2Wz0yKK3eKmypx0W0U
	 td0w/BDbDbUX2dlkT+Mypitd2q3v2GPQJlKOZeBrLhlHxK+2CpCTO6AAdeQjvw0BlB
	 4wukVMxCGYMeJenQFpEiLa2guOe+cQU3qdtgH7yc5LeYHre4cLJUbKsKj63BEB1f/d
	 3tbzWuW3eNpLg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d47ce662so1041874e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 05:27:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YwXC71LL73s8nHpJ0OAbonjnLA0276l7xBkVgADcuouKHL5iIKk
	HqH9HfJANILyyZKnvl3iBjZ52d03W3fZpqhsVanI5/Vaz0TsnBSW07iqbZf6FlrBzx7ZFMGDjVO
	pSd1HcoPrN6V6DiimDGWw3oPbkxA=
X-Google-Smtp-Source: AGHT+IHi0+64GCUdLpQe9E0JzRZM9ObtJzCA0O6jMVB11IVJTPkIKxdCA0l7iTexe71IqIHDBaEhCeMurzpF6o5TYZU=
X-Received: by 2002:a19:ca1e:0:b0:516:d4ce:d826 with SMTP id
 a30-20020a19ca1e000000b00516d4ced826mr1263240lfg.51.1712320069023; Fri, 05
 Apr 2024 05:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712287421.git.wqu@suse.com> <86cb1590afda8ea8659aa40009b35aa5130fa214.1712287421.git.wqu@suse.com>
In-Reply-To: <86cb1590afda8ea8659aa40009b35aa5130fa214.1712287421.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 5 Apr 2024 13:27:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Tr0cWez-xWxKYhR9ng+Eyfo8uv5NsoiJ=z7ysdJRdAQ@mail.gmail.com>
Message-ID: <CAL3q7H6Tr0cWez-xWxKYhR9ng+Eyfo8uv5NsoiJ=z7ysdJRdAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] btrfs: add extra sanity checks for create_io_em()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The function create_io_em() is called before we submit an IO, to update
> the in-memory extent map for the involved range.
>
> This patch changes the following aspects:
>
> - Does not allow BTRFS_ORDERED_NOCOW type
>   For real NOCOW (excluding NOCOW writes into preallocated ranges)
>   writes, we never call create_io_em(), as we does not need to update
>   the extent map at all.
>
>   So remove the sanity check allowing BTRFS_ORDERED_NOCOW type.
>
> - Add extra sanity checks
>   * PREALLOC
>     - @block_len =3D=3D len
>       For uncompressed writes.
>
>   * REGULAR
>     - @block_len =3D=3D @orig_block_len =3D=3D @ram_bytes =3D=3D @len
>       We're creating a new uncompressed extent, and referring all of it.
>
>     - @orig_start =3D=3D @start
>       We haven no offset inside the extent.
>
>   * COMPRESSED
>     - valid @compress_type
>     - @len <=3D @ram_bytes
>       This is to co-operate with encoded writes, which can cause a new
>       file extent referring only part of a uncompressed extent.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/inode.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c6f2b5d1dee1..ced916f42bab 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7320,11 +7320,49 @@ static struct extent_map *create_io_em(struct btr=
fs_inode *inode, u64 start,
>         struct extent_map *em;
>         int ret;
>
> +       /*
> +        * Note the missing of NOCOW type.
> +        *
> +        * For pure NOCOW writes, we should not create an io extent map,
> +        * but just reusing the existing one.
> +        * Only PREALLOC writes (NOCOW write into preallocated range) can
> +        * create io extent map.
> +        */
>         ASSERT(type =3D=3D BTRFS_ORDERED_PREALLOC ||
>                type =3D=3D BTRFS_ORDERED_COMPRESSED ||
> -              type =3D=3D BTRFS_ORDERED_NOCOW ||
>                type =3D=3D BTRFS_ORDERED_REGULAR);
>
> +       switch (type) {
> +       case BTRFS_ORDERED_PREALLOC:
> +               /* Uncompressed extents. */
> +               ASSERT(block_len =3D=3D len);
> +
> +               /* We're only referring part of a larger preallocated ext=
ent. */
> +               ASSERT(block_len <=3D ram_bytes);
> +               break;
> +       case BTRFS_ORDERED_REGULAR:
> +               /* Uncompressed extents. */
> +               ASSERT(block_len =3D=3D len);
> +
> +               /* COW results a new extent matching our file extent size=
. */
> +               ASSERT(orig_block_len =3D=3D len);
> +               ASSERT(ram_bytes =3D=3D len);
> +
> +               /* Since it's a new extent, we should not have any offset=
. */
> +               ASSERT(orig_start =3D=3D start);
> +               break;
> +       case BTRFS_ORDERED_COMPRESSED:
> +               /* Must be compressed. */
> +               ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
> +
> +               /*
> +                * Encoded write can make us to refer to part of the
> +                * uncompressed extent.
> +                */
> +               ASSERT(len <=3D ram_bytes);
> +               break;
> +       }
> +
>         em =3D alloc_extent_map();
>         if (!em)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.44.0
>
>

