Return-Path: <linux-btrfs+bounces-9126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EED59AE2C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 12:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4A31F22F8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 10:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418711C4A0D;
	Thu, 24 Oct 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1FghabO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F81C07D8
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766419; cv=none; b=HgwGst4s0W5SLg9v1MsKEolKvKmJbjcyLx4OH+QS6EAMbh6P5ui2m4oFKVHtCBpQ9uaBR4xvbvUkLy8Igo1NMFtLwItMpQSz30tfpM7KY0DfUSicEcQvFYtalbcr8H3ZdCBrCQ4UzaT+j/0ZXvxLknfu3ctV3+2mnj0bYlJRVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766419; c=relaxed/simple;
	bh=9TGzCddfoNG4x6lfq3PdGY3dA3lCuD+zmJoYbz7YEv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC030tlc6Auecwi5RkKscCqi0f9G8IdYlKBLRtzXKg7m4VWZFoEASAE9tYf9r7XVipjnlJgFZF0D8Kqd/PUFjOKkAzj+clL/pNjviWM84dTpjqNcvsWZZgLFJGri8U4SWlTBExR45uXkmLZbex3Ai2AsuzR5eK0x6xgjWpHCtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1FghabO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED572C4CECC
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729766419;
	bh=9TGzCddfoNG4x6lfq3PdGY3dA3lCuD+zmJoYbz7YEv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q1FghabOAcLWwVEuvcd6LxwDV6fAY4Irogd7ksU5ExtKtSIHeDVKVEoGLwwuZo3yK
	 ADtHUsIiMT+G5QiorFW+eCepV5GwQcqyG+vauImjQHMQVqzQndjsoOHLL3W6ol8Cx5
	 Uu0akf1CkUDxv+Y5SrRJH3wOFdzmKwWndwHILBDSaUpgZDOiIHRRjOExUYbjyyzNOI
	 hMlic481ov4yMK/wrmBt+p9fz2/n/YQt5dYP4scmgIWy3AExVop4tT/GdOrkywXO1x
	 AaAHMjVJgxczv5NMMap+UICnQByfXrvLnPy1gHs6xz4EVKEecdCmOynfkke14fBbbI
	 0wZTlHBCMzjYg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso92048966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 03:40:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YxpeNREuebVd+gVEdyBI8wGfv6CNBEQfcO6ftN4/I5hNgG8BO27
	/7khp68d3WtUSpWH4KBcJw9XsWesW7j9GtOvyi9BuR5dex8fUyQmp8wtdtFWpE1BVmyT5FSU3hk
	csMpaWoSfLNaS8Lf4ntDilUlHYOQ=
X-Google-Smtp-Source: AGHT+IHe93WPlaZTEZLCQ02f+DFH7ghZjogWmrBX3PPnpdbmxE3FqqSIOmEBuNi2JbkJFctimM6cUKdxWV5uRQnXe0A=
X-Received: by 2002:a17:907:e88:b0:a99:eb94:3e37 with SMTP id
 a640c23a62f3a-a9ad286c695mr111442666b.58.1729766417375; Thu, 24 Oct 2024
 03:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024023142.25127-1-robbieko@synology.com>
In-Reply-To: <20241024023142.25127-1-robbieko@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 24 Oct 2024 11:39:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4D+A0_GfZCm-FdwPrarmuyP_f8MxvU=re4=uHjnCCHZA@mail.gmail.com>
Message-ID: <CAL3q7H4D+A0_GfZCm-FdwPrarmuyP_f8MxvU=re4=uHjnCCHZA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reduce extent tree lock contention when searching
 for inline backref
To: robbieko <robbieko@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 3:32=E2=80=AFAM robbieko <robbieko@synology.com> wr=
ote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When inserting extent backref, in order to check whether refs other than
> inline refs are used, we always use keep locks for tree search, which
> will increase the lock contention of extent-tree.
>
> We do not need the parent node every time to determine whether normal
> refs are used.
> It is only needed when the extent-item is the last item in a leaf.
>
> Therefore, we change to first use keep_locks=3D0 for search.
> If the extent-item happens to be the last item in the leaf, we then
> change to keep_locks=3D1 for the second search to reduce lock contention.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.


> ---
>  fs/btrfs/extent-tree.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..54d149a41506 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -795,7 +795,6 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>         if (insert) {
>                 extra_size =3D btrfs_extent_inline_ref_size(want);
>                 path->search_for_extension =3D 1;
> -               path->keep_locks =3D 1;
>         } else
>                 extra_size =3D -1;
>
> @@ -946,6 +945,25 @@ int lookup_inline_extent_backref(struct btrfs_trans_=
handle *trans,
>                         ret =3D -EAGAIN;
>                         goto out;
>                 }
> +
> +               if (path->slots[0] + 1 < btrfs_header_nritems(path->nodes=
[0])) {
> +                       struct btrfs_key tmp_key;
> +
> +                       btrfs_item_key_to_cpu(path->nodes[0], &tmp_key, p=
ath->slots[0] + 1);
> +                       if (tmp_key.objectid =3D=3D bytenr &&
> +                               tmp_key.type < BTRFS_BLOCK_GROUP_ITEM_KEY=
) {
> +                               ret =3D -EAGAIN;
> +                               goto out;
> +                       }
> +                       goto enoent;
> +               }
> +
> +               if (!path->keep_locks) {
> +                       btrfs_release_path(path);
> +                       path->keep_locks =3D 1;
> +                       goto again;
> +               }
> +
>                 /*
>                  * To add new inline back ref, we have to make sure
>                  * there is no corresponding back ref item.
> @@ -959,13 +977,15 @@ int lookup_inline_extent_backref(struct btrfs_trans=
_handle *trans,
>                         goto out;
>                 }
>         }
> +enoent:
>         *ref_ret =3D (struct btrfs_extent_inline_ref *)ptr;
>  out:
> -       if (insert) {
> +       if (path->keep_locks) {
>                 path->keep_locks =3D 0;
> -               path->search_for_extension =3D 0;
>                 btrfs_unlock_up_safe(path, 1);
>         }
> +       if (insert)
> +               path->search_for_extension =3D 0;
>         return ret;
>  }
>
> --
> 2.17.1
>
>

