Return-Path: <linux-btrfs+bounces-3915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720C898579
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927AD1C23169
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1281AC4;
	Thu,  4 Apr 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql9YZY9G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41980C09
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228188; cv=none; b=LrHxGBMjFg8KJe7Hmc1+DDlIenAQuSiqnERmPkPRsG5Y5sg5hr4/f8dJYTKyq+eXXll77NoVhelGeASe9jCfN++gA7qv/cnT4z7hgK+pXcQDYcwT27ouaauMXjFajmx7fHDotutNpa5bWBVEJrXPQyfXTaWodVuaSeHm2xTvodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228188; c=relaxed/simple;
	bh=2b1tS9so8sFh9MwBxHfOwIvw4t6r/abPX/qfx/JtjJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZnWSQcAHYbhFhhmyBi1VdgZYn11vzKDQqOVC5mB+qW/mI0Cnqj5dfER3lESaQg/H1ReY3ifOOEH/f+WKFlAduYJFfimeEG3iFScNsZwl35BslVq/UpmQo79d6KPSkkWKkAts0/bOJ6TGhY0plaapB6EaHZ5VkuKwhc0hOR599w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql9YZY9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B991AC43390
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712228187;
	bh=2b1tS9so8sFh9MwBxHfOwIvw4t6r/abPX/qfx/JtjJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ql9YZY9GwpRz2zRprYzWuw+eyGs8Q5yHE9iMcrKId10iNZ6Gfw1c+TzhfCM3077wy
	 6VKQVCY39i7DmZS4Sn0GuCHCSHxCeGIxFYZIaiWlppJ8nff1lxJ7mDDaQbd23Ejnpi
	 dedlnxs4Rh2CRqMjo4RxWrTXVJOwiP3AHNGg+dvd3kfNE+E6l8hHTi41XVj0nzm2ba
	 Do+YmNzaR6Ow4IG18KnoXIOlOQNCuFmLYIBr2P+Xmp1ZRG3TNVl+1ExrgCaP+Ct6q2
	 Ws07Ha0fSxKXBKs+UNbMCxk0+PTA1OimsE4S6VK6K2k/UMEyNJDHWQzrS33IocYLBx
	 SKbXnLE/txZAg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1081596a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Apr 2024 03:56:27 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzt7fPgEOXFGe3onHgWMbQGGTAarNAxpZ/4UJ+WCfcZ9vGppvAZ
	jBE87UfpUoLwTE682x4IpWNk7OcADiOrcq6Bx7b2OCS3rpM+hu4EgXPset+/ofoaQ1GShOuKwTl
	DOx2gRfd7CIy7eUNKvAdOUcyAgj8=
X-Google-Smtp-Source: AGHT+IGVGNwW36Ly/08QTDy8wjvDKLz+YkKQnJy3LwyM5XiAtT9GceBtMsIC7mT+mQW/e5OhMb++KmjQaFyIjdmg650=
X-Received: by 2002:a17:906:3c13:b0:a46:d591:873c with SMTP id
 h19-20020a1709063c1300b00a46d591873cmr1287284ejg.18.1712228186300; Thu, 04
 Apr 2024 03:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712187452.git.wqu@suse.com> <6527c36f8fd775cf3ca87e5541cf550537d8e757.1712187452.git.wqu@suse.com>
In-Reply-To: <6527c36f8fd775cf3ca87e5541cf550537d8e757.1712187452.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Apr 2024 11:55:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6gVw9ybP4pw+=rQyFPiZYVjMjV91_qr-WLTVQpTvafOQ@mail.gmail.com>
Message-ID: <CAL3q7H6gVw9ybP4pw+=rQyFPiZYVjMjV91_qr-WLTVQpTvafOQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] btrfs: add extra sanity checks for create_io_em()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:47=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> ---
>  fs/btrfs/inode.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c6f2b5d1dee1..261fafc66533 100644
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
> +       if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
> +               /* Uncompressed extents. */
> +               ASSERT(block_len =3D=3D len);
> +
> +               /* We're only referring part of a larger preallocated ext=
ent. */
> +               ASSERT(block_len <=3D ram_bytes);
> +       }
> +
> +       if (type =3D=3D BTRFS_ORDERED_REGULAR) {
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
> +       }
> +
> +       if (type =3D=3D BTRFS_ORDERED_COMPRESSED) {
> +               /* Must be compressed. */
> +               ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
> +
> +               /*
> +                * Encoded write can make us to refer part of the

refer part -> refer to part

> +                * uncompressed extent.
> +                */
> +               ASSERT(len <=3D ram_bytes);
> +       }

All these if statements to test the type should be combined into if -
else if - else if ... If we match a type, it's pointless to keep
comparing the type again.

Or use a switch statement.

Otherwise it looks good, thanks.

> +
>         em =3D alloc_extent_map();
>         if (!em)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.44.0
>
>

