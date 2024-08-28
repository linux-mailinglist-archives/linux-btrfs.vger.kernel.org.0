Return-Path: <linux-btrfs+bounces-7620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249459628A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535C81C214E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19A186E4C;
	Wed, 28 Aug 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVtny9vx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721816BE30
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851767; cv=none; b=Ga3cWMGl6Bb+SMca7pCAfeyTZzySJm8k3eA5KkymBZaQzkVtgnYdI9xDFHH4mcnFWgPtgJ51IULtWKO9FgRtVC4/i4X1wmdHq+TzHOCE+8OBX9kiNRjvlZj16XOgmMOWOm4PztWJ+zchxP542N2rJI4+5IsyOODdzHVSRnSfMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851767; c=relaxed/simple;
	bh=mOgAVcPQDmBpXLGaLDFzEGqd5+dt2WndZHwOlC/AzlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcB5scQphutsp3bFut773Ow4IXsXnUm6MiWj+HSipn07Xu065B9W7c7N5SundSpeKNZzAQJYhGrlI6i2TSLueFMZstWA5zuQ9rH+OeygPubdpT5boKpcoAQT8IjjoeLQw7HoVgRfArHRPvKG9pqvoZoh2HLJ03o8rERiYxJDXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVtny9vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0B0C4FEFE
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851767;
	bh=mOgAVcPQDmBpXLGaLDFzEGqd5+dt2WndZHwOlC/AzlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iVtny9vxqNN7z8S26Rziwm2BfnSUiXmkQcGIUmrg09RyFQ9/hKsjVgffG1XT/0yaM
	 JajzBiVOKociG3U+uSkDRDMMscBV3qJb7MbnNfFWbrEklu4QTx+LV34vNYbLVwzLuD
	 HyF76mKiPmtLaeeXUC8MhJx/sFp9zoA9bQ5uktqsGX+vo1CvcnYC6CYIr7hMLfWoSE
	 Hr9XtRtb5e15p9VAIj3L01cQknMoS0zUitwSvg5GTSM+wtHUMI6LAikXt0YW5c6h1w
	 PEPm0P9NcsELw3vFVDO0XDLtjAOQIoDlXRuK5/8DUSJnPXD6/+NWGCqSxX0G3/nuxB
	 TCxcyxbW/0fyg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so3806168a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 06:29:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YyKxXDlXJ5U9ltTYvmPCKLlNyK3p9T8K0uUzoP78uWrh0qr+Z7E
	DZFD7WHWbIqT3Z1QZA3X34KuqOWGZff2MRGhdyIjexdL4jfQRZVy97mCN+7UFk9WXYUmkzzaKnN
	lM8l4M5drXIrNizhcLhqILijBRSA=
X-Google-Smtp-Source: AGHT+IGVOUVv/ZO45bpsRokAf3svCtvLebTvXsi+/PL6JiYrEgHBEVlTHZb6oA1w89zmwezeXPw2ikKFd6PXo35nCaY=
X-Received: by 2002:a17:907:6d0c:b0:a80:f80a:d0b0 with SMTP id
 a640c23a62f3a-a870a9095acmr180023666b.10.1724851765910; Wed, 28 Aug 2024
 06:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724847323.git.rgoldwyn@suse.com> <c252c360e04767f25698f0c6b85031c380a8a31d.1724847323.git.rgoldwyn@suse.com>
In-Reply-To: <c252c360e04767f25698f0c6b85031c380a8a31d.1724847323.git.rgoldwyn@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 28 Aug 2024 14:28:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4EqthmT6bsNit4EC0e-HobP6+ac9m1JmwKQ2mDzQ+HfQ@mail.gmail.com>
Message-ID: <CAL3q7H4EqthmT6bsNit4EC0e-HobP6+ac9m1JmwKQ2mDzQ+HfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: btrfs_has_ordered_extent() to check for
 ordered extent in range
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:53=E2=80=AFPM Goldwyn Rodrigues <rgoldwyn@suse.de=
> wrote:
>
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> A simple function which checks if there are ordered extent in range
> supplied.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ordered-data.c | 11 +++++++++++
>  fs/btrfs/ordered-data.h |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index eb9b32ffbc0c..ea8b5fa42454 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1006,6 +1006,17 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_=
range(
>         return entry;
>  }
>
> +bool btrfs_has_ordered_extent(struct btrfs_inode *inode, u64 file_offset=
, u64 len)
> +{
> +       struct btrfs_ordered_extent *oe =3D NULL;

There's no point in this assignment, as we don't ever use the variable
before assigning it below.
Stuff like this has resulted in warnings from tools (and therefore
reports and patches), see for example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D966de47ff0c9e64d74e1719e4480b7c34f6190fa

Thanks.

> +
> +       oe =3D btrfs_lookup_ordered_range(inode, file_offset, len);
> +       if (!oe)
> +               return false;
> +       btrfs_put_ordered_extent(oe);
> +       return true;
> +}
> +
>  /*
>   * Adds all ordered extents to the given list. The list ends up sorted b=
y the
>   * file_offset of the ordered extents.
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 4e152736d06c..0c715c2a01ac 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -201,6 +201,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_ran=
ge(
>                 struct btrfs_inode *inode,
>                 u64 file_offset,
>                 u64 len);
> +bool btrfs_has_ordered_extent(struct btrfs_inode *inode, u64 file_offset=
, u64 len);
>  void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
>                                            struct list_head *list);
>  u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
> --
> 2.46.0
>
>

