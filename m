Return-Path: <linux-btrfs+bounces-15538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0EB0874E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF7A42B2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621625393E;
	Thu, 17 Jul 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui9gdqjo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337B17E0
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738367; cv=none; b=ofCWsNrFTzrH25DEqvxfPNi1aRu87ZdUFKI1pzRVwERQFEVv3g2mAe6N8ew8qU5MQ8W2ICcPzC7rAWSliKS6IzaPCfQM2s7zYR29QIggGU0vQ/+N/yI54v9xoxQKQ4qAbTcGqvWFlnHJq7oWVEhmll8f/CE4L+LzBoCSNy00uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738367; c=relaxed/simple;
	bh=xR4Y+641YLCYjJ2whCdtUqHmJWGs8B12SNggoqGAiQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyO6X9HX2IlOQXJYKYbjDRybAvGC7XzlIr9o8bWXBnuriZMvsVGLK0VrfqK/hFf13hJHoz75nT0Btq7W9CaxxH8CcJt12bhoKfDtBC5BNLzdL5hcJFC6VDIdegCMs6+uVveo/wulqqAt5PNJFLbjPvqVMX+8UPuk+75UgbfiPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui9gdqjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87654C4CEED
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738365;
	bh=xR4Y+641YLCYjJ2whCdtUqHmJWGs8B12SNggoqGAiQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ui9gdqjoxjXyOlZ/gYN4YCizoXCZ5jrK1WRnC9VI/ht3iqndO5/XN8qL6AZFaBpMM
	 htY8m8BJbSsRo7Tn20Fwvoc04Z2GmRLnOGHHu3WAm9x6vqgbprBFXwHOvWEbsTvYp/
	 yrWpkqgAAsJLlkg3kHzcH9PynvciGvaxPgvHYsxXF7SZl9fva7pCd4vtNVwjQ12qMD
	 b4zl1cR0Ja/FVuLXZC3sg4z4eS/EPKDUlp3GrW5IvIKy9z6HdS8nA3sFjNY9JXt+1Y
	 kQ6Sx/WeRlFkaA4+YjH7La6k/Ym0PV49k8kUcCpqxMzQ5GLMNrztWHSaCzEWkfDSvg
	 oy+60lCB6ZTTA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso127981666b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 00:46:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywb8nrOpPsZcD3o/4PTkvErvbgNziIoLUJwGjMgEYZPBYJtpTtT
	AAIBZesdiRopI0o9TyGCcgWsgCc38bSaULqC44apEd9+VKfukKRWZiug94Gmkv9m3ukJQJigNwR
	1X28gcTU4Fr296/4bor0deZfqVhodJAg=
X-Google-Smtp-Source: AGHT+IGmepSY3h/IFLL4SmFXrHbgTKDiooHUzJW5IpcNplloZX3weZa9TMun3WN9GfA0cB0ukhJ9mcKSiKFOt0oche8=
X-Received: by 2002:a17:907:3cc6:b0:ae0:b847:435 with SMTP id
 a640c23a62f3a-ae9ce14a734mr610752866b.49.1752738364114; Thu, 17 Jul 2025
 00:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6624547086a52fd70e6ab651372f35a05ee7b65.1752701770.git.boris@bur.io>
In-Reply-To: <c6624547086a52fd70e6ab651372f35a05ee7b65.1752701770.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 17 Jul 2025 08:45:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7ZfXzfXqKdWecSoFS9iqOVm=h39Sedsg7bqVVjk4n0CQ@mail.gmail.com>
X-Gm-Features: Ac12FXxrgW4kn85He3l9T4MAsTxikLZFVhL5jndRw0gtt1Sa8VjHR8i_GKhi04E
Message-ID: <CAL3q7H7ZfXzfXqKdWecSoFS9iqOVm=h39Sedsg7bqVVjk4n0CQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use find_free_extent_check_size_class() in
 clustered check
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:35=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> Metadata block groups will not set their size class, while the ffe_ctl
> will just go off the size of the request (nodesize), so this will mess
> up the proper function of the clustered allocator for metadata.
>
> Fix it by using the appropriate helper that is aware of data vs.
> metadata
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent-tree.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index ca54fbb0231c..c93d91235dc5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3651,6 +3651,21 @@ btrfs_release_block_group(struct btrfs_block_group=
 *cache,
>         btrfs_put_block_group(cache);
>  }
>
> +static bool find_free_extent_check_size_class(struct find_free_extent_ct=
l *ffe_ctl,
> +                                             struct btrfs_block_group *b=
g)

It's a good opportunity to make both arguments const.

Anyway, the change looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +{
> +       if (ffe_ctl->policy =3D=3D BTRFS_EXTENT_ALLOC_ZONED)
> +               return true;
> +       if (!btrfs_block_group_should_use_size_class(bg))
> +               return true;
> +       if (ffe_ctl->loop >=3D LOOP_WRONG_SIZE_CLASS)
> +               return true;
> +       if (ffe_ctl->loop >=3D LOOP_UNSET_SIZE_CLASS &&
> +           bg->size_class =3D=3D BTRFS_BG_SZ_NONE)
> +               return true;
> +       return ffe_ctl->size_class =3D=3D bg->size_class;
> +}
> +
>  /*
>   * Helper function for find_free_extent().
>   *
> @@ -3673,7 +3688,7 @@ static int find_free_extent_clustered(struct btrfs_=
block_group *bg,
>                 goto refill_cluster;
>         if (cluster_bg !=3D bg && (cluster_bg->ro ||
>             !block_group_bits(cluster_bg, ffe_ctl->flags) ||
> -           ffe_ctl->size_class !=3D cluster_bg->size_class))
> +           !find_free_extent_check_size_class(ffe_ctl, cluster_bg)))
>                 goto release_cluster;
>
>         offset =3D btrfs_alloc_from_cluster(cluster_bg, last_ptr,
> @@ -4230,21 +4245,6 @@ static int find_free_extent_update_loop(struct btr=
fs_fs_info *fs_info,
>         return -ENOSPC;
>  }
>
> -static bool find_free_extent_check_size_class(struct find_free_extent_ct=
l *ffe_ctl,
> -                                             struct btrfs_block_group *b=
g)
> -{
> -       if (ffe_ctl->policy =3D=3D BTRFS_EXTENT_ALLOC_ZONED)
> -               return true;
> -       if (!btrfs_block_group_should_use_size_class(bg))
> -               return true;
> -       if (ffe_ctl->loop >=3D LOOP_WRONG_SIZE_CLASS)
> -               return true;
> -       if (ffe_ctl->loop >=3D LOOP_UNSET_SIZE_CLASS &&
> -           bg->size_class =3D=3D BTRFS_BG_SZ_NONE)
> -               return true;
> -       return ffe_ctl->size_class =3D=3D bg->size_class;
> -}
> -
>  static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
>                                         struct find_free_extent_ctl *ffe_=
ctl,
>                                         struct btrfs_space_info *space_in=
fo,
> --
> 2.50.1
>
>

