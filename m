Return-Path: <linux-btrfs+bounces-12486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8EA6BA90
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 13:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2F7A5892
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755B225768;
	Fri, 21 Mar 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSP/2+1X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74D1C2DB2
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559680; cv=none; b=dGr8abiHtovOFWQ3+ZmPifcAKxamx2mLjwNuFQKwnxYXwJgRrZ53UdZ/h+a/wR8N8bGSpu0UQVUebNpeRrkFOXZNdIvGwxX54tbnmPDRlyvkcyEPjs2bDAuRGWrQI/qJprMpULLvzf1BCc2PBllaqGub8n28QPNPq9v+e4l0eLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559680; c=relaxed/simple;
	bh=jlS8BAjtcmO0R+QEbtgZ28Mjy4/SI9yzujy/TjmNU9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcvL/TshNAYHueMarUZpEMz2pLj8Miwf/WN20DSSSba+bfcFP/UFlJDUlh9xEDe7fOYkNQ3z5tAXCh+j/AOx/dq1RcZIa2RGOqzK0emQ37QO6S3u9HRrXjYebgoh2vp4iCJo5LvqnWpbxtZizT1tp1zG/EprGwjFj9Oqyc7/SJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSP/2+1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F1C4CEE3
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559679;
	bh=jlS8BAjtcmO0R+QEbtgZ28Mjy4/SI9yzujy/TjmNU9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TSP/2+1Xgt5TOW8t8NQ40wTXWxGEyW1OKYuI0DoCxIcY+Ss57uGiyoK1cWbJSiLYt
	 GDMaWBi12Vn1OEkDrxyLaQvn2Vtrh4SrAURt/7vPZgt8qJb86CTrimDRL7Xal16Eq3
	 ZUKRpJ/PAiBvU6+/Hd6jPDQ9vMKSThYFOz4Qyw+JIMXKX2NKH4bvPFbhN7B+D4UNn9
	 AuNGGLK2fxBONZqeWZ+HIj0dX+aWBFyQSVsU3pL0eAHE1Bkq7fJZsP2ic1vVRsPHqh
	 hUb73bYLE2mJFQCp0zpEmoZzvktcplKway9bgjIQjcJwD1Oak+0Ur09qQUtuDwFcgh
	 aNaIDYDUQvsVQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so88497766b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 05:21:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YySU5QeqjlHkgQ5DR5XuJb9Z3ev254Wo1R66Uc9EQWRsNnL79nz
	M+AkYA8d19QudTIbb9n6ODjDU31VNUgahYKBhzCKUfuRLiJpBV/I0VcVwb97fbTjOiVKPzVY1Xv
	6Jzu+hQrpHyO0bo9m8H/8lQyBqRc=
X-Google-Smtp-Source: AGHT+IHGPXLrCYvWeCa+NhoemrhJgOv/non1INZV50HiHmclZhQKc5mxw0cK+gwi6VbiA5RfNv5BL9vYPpVxKiAdGP8=
X-Received: by 2002:a17:907:968d:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-ac3f252d938mr296747566b.49.1742559678085; Fri, 21 Mar 2025
 05:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742443383.git.wqu@suse.com> <522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com>
In-Reply-To: <522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Mar 2025 12:20:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7gSwqY08x4oJOAfX_Fa7NCsB26k9cGcpKBQdeaju8UKQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jqvjoblc4p4vshDiEsbFV8vkOogfprkniImktmSv51rxfkuOJpGs4rciFk
Message-ID: <CAL3q7H7gSwqY08x4oJOAfX_Fa7NCsB26k9cGcpKBQdeaju8UKQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: extract the space reservation code from btrfs_buffered_write()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:37=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside the main loop of btrfs_buffered_write(), we have a complex data
> and metadata space reservation code, which tries to reserve space for
> a COW write, if failed then fallback to check if we can do a NOCOW
> write.
>
> Extract that part of code into a dedicated helper, reserve_space(), to
> make the main loop a little easier to read.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 108 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 63 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f68846c14ed5..99580ef906a6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1095,6 +1095,64 @@ static void release_space(struct btrfs_inode *inod=
e,
>         }
>  }
>
> +/*
> + * Reserve data and metadata space for the this buffered write range.

"for the this" -> for this

> + *
> + * Return >0 for the number of bytes reserved, which is always block ali=
gned.
> + * Return <0 for error.
> + */
> +static ssize_t reserve_space(struct btrfs_inode *inode,
> +                        struct extent_changeset **data_reserved,
> +                        u64 start, size_t *len, bool nowait,
> +                        bool *only_release_metadata)
> +{
> +       const struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +       unsigned int block_offset =3D start & (fs_info->sectorsize - 1);

block_offset can also be const.

> +       size_t reserve_bytes;
> +       int ret;
> +
> +       ret =3D btrfs_check_data_free_space(inode, data_reserved, start, =
*len,
> +                                         nowait);
> +       if (ret < 0) {
> +               int can_nocow;
> +
> +               if (nowait && (ret =3D=3D -ENOSPC || ret =3D=3D -EAGAIN))
> +                       return -EAGAIN;
> +
> +               /*
> +                * If we don't have to COW at the offset, reserve
> +                * metadata only. write_bytes may get smaller than
> +                * requested here.

While here, we can make the line width closer to the 80 characters
limit, as these are a bit too short.

> +                */
> +               can_nocow =3D btrfs_check_nocow_lock(inode, start, len, n=
owait);
> +               if (can_nocow < 0)
> +                       ret =3D can_nocow;
> +               if (can_nocow > 0)
> +                       ret =3D 0;
> +               if (ret)
> +                       return ret;
> +               *only_release_metadata =3D true;
> +       }
> +
> +       reserve_bytes =3D round_up(*len + block_offset,
> +                                fs_info->sectorsize);

There's no need for line splitting here, it all fits within 75 characters.

Otherwise it looks good, and with these minor changes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       WARN_ON(reserve_bytes =3D=3D 0);
> +       ret =3D btrfs_delalloc_reserve_metadata(inode, reserve_bytes,
> +                                             reserve_bytes, nowait);
> +       if (ret) {
> +               if (!*only_release_metadata)
> +                       btrfs_free_reserved_data_space(inode,
> +                                       *data_reserved, start, *len);
> +               else
> +                       btrfs_check_nocow_unlock(inode);
> +
> +               if (nowait && ret =3D=3D -ENOSPC)
> +                       ret =3D -EAGAIN;
> +               return ret;
> +       }
> +       return reserve_bytes;
> +}
> +
>  ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -1160,52 +1218,12 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, =
struct iov_iter *i)
>                 sector_offset =3D pos & (fs_info->sectorsize - 1);
>
>                 extent_changeset_release(data_reserved);
> -               ret =3D btrfs_check_data_free_space(BTRFS_I(inode),
> -                                                 &data_reserved, pos,
> -                                                 write_bytes, nowait);
> -               if (ret < 0) {
> -                       int can_nocow;
> -
> -                       if (nowait && (ret =3D=3D -ENOSPC || ret =3D=3D -=
EAGAIN)) {
> -                               ret =3D -EAGAIN;
> -                               break;
> -                       }
> -
> -                       /*
> -                        * If we don't have to COW at the offset, reserve
> -                        * metadata only. write_bytes may get smaller tha=
n
> -                        * requested here.
> -                        */
> -                       can_nocow =3D btrfs_check_nocow_lock(BTRFS_I(inod=
e), pos,
> -                                                          &write_bytes, =
nowait);
> -                       if (can_nocow < 0)
> -                               ret =3D can_nocow;
> -                       if (can_nocow > 0)
> -                               ret =3D 0;
> -                       if (ret)
> -                               break;
> -                       only_release_metadata =3D true;
> -               }
> -
> -               reserve_bytes =3D round_up(write_bytes + sector_offset,
> -                                        fs_info->sectorsize);
> -               WARN_ON(reserve_bytes =3D=3D 0);
> -               ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
> -                                                     reserve_bytes,
> -                                                     reserve_bytes, nowa=
it);
> -               if (ret) {
> -                       if (!only_release_metadata)
> -                               btrfs_free_reserved_data_space(BTRFS_I(in=
ode),
> -                                               data_reserved, pos,
> -                                               write_bytes);
> -                       else
> -                               btrfs_check_nocow_unlock(BTRFS_I(inode));
> -
> -                       if (nowait && ret =3D=3D -ENOSPC)
> -                               ret =3D -EAGAIN;
> +               ret =3D reserve_space(BTRFS_I(inode), &data_reserved, pos=
,
> +                                   &write_bytes, nowait,
> +                                   &only_release_metadata);
> +               if (ret < 0)
>                         break;
> -               }
> -
> +               reserve_bytes =3D ret;
>                 release_bytes =3D reserve_bytes;
>  again:
>                 ret =3D balance_dirty_pages_ratelimited_flags(inode->i_ma=
pping, bdp_flags);
> --
> 2.49.0
>
>

