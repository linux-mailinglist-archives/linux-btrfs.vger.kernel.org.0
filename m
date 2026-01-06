Return-Path: <linux-btrfs+bounces-20157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A03CF85A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DC2730F4E8E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D22522A7;
	Tue,  6 Jan 2026 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s93gNUtS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC003271E8
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702585; cv=none; b=TQppJ2/oBxojoF2+cpzJOj15g/qhqObaRsEZzCoAEJmTYLvNorv9sulvUUV42l/Iu1EO9/oFpyZAUj5wI3YMmSowekD70rV5cEZmXRLGN0PT41PBykg58Mcbdsu6o928HqL5buRNkQiPyqTaNqiyKAp/kUfv3usHPxwKqXc7vIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702585; c=relaxed/simple;
	bh=QneoRfr7nxglWmwoQMKXaCINfCvBZJQuJhzclliRWtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ityZXOnAzyJi5wwPhAXr+k3KUqWkm3pHQrnq271fxWkgPQ4sOusQi39EwbbGOiWGzIUUlNpoHlYqPZ+a6NnypEytU81ByR8qkajNndC2c8b6k53aWNGaCvXPOxwhLACHb5a2nrfAyO6STFcD50a9++I/qCGVeYKUux+qcg8jgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s93gNUtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FA0C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702585;
	bh=QneoRfr7nxglWmwoQMKXaCINfCvBZJQuJhzclliRWtI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s93gNUtS7lMcKF6klaGinEbfuBApQt7ZeGQyW6Ko0xvvzGrqx0drCF50ujDSkRgY0
	 NnHCi/q1/fniSpiry74uinIBzjIG6dP7gxoiSkMGP/BqBtPvotvkIc2+x3ZVCU2zuE
	 V7Cn07jNKEG53NR88hY+86zho6kGfeX9T8hlnYc8hPgJm2dvK+FJFbUhyiWos8xq2g
	 vL9c74csvpozceTpKrb++xsJuFQFIFsgZpHDrd8GA6q1a6gzvSbVU1ZAhFsdYQ4YQT
	 YtQoXGW+iHXboVIr6VfaKmdNCUS4E3GaEEYaM79+BBdv0dRp1sPHlJw/FP5hP/NBHf
	 bNOcsd+83QW/w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so162854066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 04:29:45 -0800 (PST)
X-Gm-Message-State: AOJu0YzVT++HqJ7mq+snVPHZPQGWGqBM+OR84Uy74EyK28NO0RrYjg9s
	sFQK5l3DU2abCj1Aj2QBNWjwvG7EWk3PVE/PUC5pkekZfpNQL2N7yHExaywsgVcaasZ2oPm0pmm
	+0eKwBV0wlseEW1R4jxxKdVJaoPdbtQ8=
X-Google-Smtp-Source: AGHT+IEX60izghPep8KKBIWswRfbQ95tywWewtwyOPo2fdaW7UaK6SCGQzWoQdoyhfzvHYLrKYV4OnPswn9ArZ/KfIU=
X-Received: by 2002:a17:907:3daa:b0:b72:70ad:b8f0 with SMTP id
 a640c23a62f3a-b8426bee148mr281118666b.36.1767702584102; Tue, 06 Jan 2026
 04:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
In-Reply-To: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Jan 2026 12:29:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Y1GJr0ZFgf5Dp0vHvap9j3VZU-_E_9n-tR8ZF_WKSsQ@mail.gmail.com>
X-Gm-Features: AQt7F2ounH6a-4y-gIZeJ-9aR2b92L1sypxSNuEFIIFny2DqJ6PQNGapSsRR9Lk
Message-ID: <CAL3q7H4Y1GJr0ZFgf5Dp0vHvap9j3VZU-_E_9n-tR8ZF_WKSsQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reject single block sized compression early
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently for an inode that needs compression, even if there is a delallo=
c
> range that is single fs block sized and can not be inlined, we will
> still go through the compression path.
>
> Then inside compress_file_range(), we have one extra check to reject
> single block sized range, and fall back to regular uncompressed write.
>
> This rejection is in fact a little too late, we have already allocated
> memory to async_chunk, delayed the submission, just to fallback to the
> same uncompressed write.
>
> Change the behavior to reject such cases earlier at
> inode_need_compress(), so for such single block sized range we won't
> even bother trying to go through compress path.
>
> And since the inline small block check is inside inode_need_compress()
> and compress_file_range() also calls that function, we no longer need a
> dedicate check inside compress_file_range().
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> Changelog:
> v2:
> - Remove the duplicated check inside compress_file_range() now
>   As the same check is done inside inode_need_compress() and
>   compress_file_range() also call that function to do the check.
> ---
>  fs/btrfs/inode.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cf452eaf0672..fbb8ad55b589 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_i=
node *inode, u64 start,
>                 return 0;
>         }
>
> +       /*
> +        * If the delalloc range is only one fs block and can not be inli=
ned,
> +        * do not even bother try compression, as there will be no space =
saving
> +        * and will always fallback to regular write later.
> +        */
> +       if (start !=3D 0 && end + 1 - start <=3D fs_info->sectorsize)
> +               return 0;
>         /* Defrag ioctl takes precedence over mount options and propertie=
s. */
>         if (inode->defrag_compress =3D=3D BTRFS_DEFRAG_DONT_COMPRESS)
>                 return 0;
> @@ -953,18 +960,8 @@ static void compress_file_range(struct btrfs_work *w=
ork)
>         if (actual_end <=3D start)
>                 goto cleanup_and_bail_uncompressed;
>
> -       total_compressed =3D actual_end - start;
> -
> -       /*
> -        * Skip compression for a small file range(<=3Dblocksize) that
> -        * isn't an inline extent, since it doesn't save disk space at al=
l.
> -        */
> -       if (total_compressed <=3D blocksize &&
> -          (start > 0 || end + 1 < inode->disk_i_size))
> -               goto cleanup_and_bail_uncompressed;
> -
> -       total_compressed =3D min_t(unsigned long, total_compressed,
> -                       BTRFS_MAX_UNCOMPRESSED);
> +       total_compressed =3D min_t(unsigned long, actual_end - start,
> +                                BTRFS_MAX_UNCOMPRESSED);
>         total_in =3D 0;
>         ret =3D 0;
>
> --
> 2.52.0
>
>

