Return-Path: <linux-btrfs+bounces-14112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E2ABBA66
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77D0171B3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7AB26D4D8;
	Mon, 19 May 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkbhaLM8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF0268FC8
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648516; cv=none; b=PgZuMqX/Hn5iskf9LeeTdZ435Q+Awhy+SCh3EuHCWWfnv6YkIx5p4Yoi7NnLnrh58RyhvFrz4UUNDcgYOuXnAWytpL7kjS/FlMbiKj2A0WfsPy/o22WlVtKDT++m2Sw+3pVeXTSrYFr800ACXid7WWJR9DZtWwtZYOZNUF3I8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648516; c=relaxed/simple;
	bh=l9a8mqgJYkrtkiIjMJwpd/5je6zXAz5XilVEO+7cuuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXgcqcxKpvYSMfH3bnmo0Ft7ssmmR/PgM/Q5b8Z6G5W+gTq6eKL+QGRc+D8FGI1MRl4JpUM4WP2v0dc415AAfhHffrVOPknh5cU6XqysSFuMaTE+tJ1lCCpsvDpXTU3MQxYKBnAEeJgyoD3eld1phlfs6ZgOCpJO9Q7Yd0xPvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkbhaLM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0883C4CEE4
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 09:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648516;
	bh=l9a8mqgJYkrtkiIjMJwpd/5je6zXAz5XilVEO+7cuuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OkbhaLM8Et1zvcWA6KoImR630mnN65EQdiYHy/d0T0LZiBta1qtWLxCxV8Ko7QxrC
	 l+/k9nDLReO10sX/wcAAYa9hoblT3JdwnbQvR9KfLMmBnrozLjEgONQjnI+wi8B5qd
	 EcudhvBgHHtvHanhKvXs1PrCU0Ae8qX57obw6GVFNlwc47ZGQRRNsmhoXBhRGB7BOm
	 99xEnp322ExcNcacw+/oOnB18oS6gC+yHW+4RxXe2kKFFWH276l2+8NYMlL52N+pvd
	 DrnJZcqtfGpUHw+5ChD08KqzSsyJ8wQpSvkSXNTsCo5fVYhN82WtwELjtzaA8ozQ43
	 zKgjnx2xN2XnQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad5273c1fd7so684088466b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 02:55:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+i5IAN9BFsdmIRC1TBgmtELDMsRmI6QEcnJzNRXEgjGxla1uV
	b8YFV4uu2zcSPqMwu/rfZY5OL6LI/PET68oNB19R068lzK93YeF5xcPJR/wgCK7/KWURpuTONfm
	Xv/A+Jpd8ZeYQDcI8AasI5NKK5nfA4kw=
X-Google-Smtp-Source: AGHT+IHwG5Wwj4RzdnqxPcL/Kzo8PpkfDjYJG4nHhANz/f/rWLenCDBPj6NnmvaqRMUbySCZy7g5/+ioDBHCs37SNHU=
X-Received: by 2002:a17:907:c04:b0:ad2:2569:697c with SMTP id
 a640c23a62f3a-ad536b7c8d0mr987707866b.8.1747648515232; Mon, 19 May 2025
 02:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517190410.3027963-1-dsterba@suse.com>
In-Reply-To: <20250517190410.3027963-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 May 2025 10:54:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5BsSO1zaXpvMjFQHt_cR9O4c2vKXmLWU5VfwuvXYHKMg@mail.gmail.com>
X-Gm-Features: AX0GCFvtk1CJLKw-1d73jzTWWyHqLurQ_UM2MUhDMBQQgRgjsuUR9zGdM8yZBqA
Message-ID: <CAL3q7H5BsSO1zaXpvMjFQHt_cR9O4c2vKXmLWU5VfwuvXYHKMg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: move transaction aborts to the error site in remove_block_group_free_space()
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 8:04=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> Transaction aborts should be done next to the place the error happens,
> which was not done in remove_block_group_free_space().
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/free-space-tree.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 6cbdb578e66c1f..af51cf784a5bd7 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1444,6 +1444,7 @@ int remove_block_group_free_space(struct btrfs_tran=
s_handle *trans,
>         path =3D btrfs_alloc_path();
>         if (!path) {
>                 ret =3D -ENOMEM;
> +               btrfs_abort_transaction(trans, ret);
>                 goto out;
>         }
>
> @@ -1456,8 +1457,10 @@ int remove_block_group_free_space(struct btrfs_tra=
ns_handle *trans,
>
>         while (!done) {
>                 ret =3D btrfs_search_prev_slot(trans, root, &key, path, -=
1, 1);
> -               if (ret)
> +               if (ret) {
> +                       btrfs_abort_transaction(trans, ret);
>                         goto out;
> +               }
>
>                 leaf =3D path->nodes[0];
>                 nr =3D 0;
> @@ -1485,16 +1488,16 @@ int remove_block_group_free_space(struct btrfs_tr=
ans_handle *trans,
>                 }
>
>                 ret =3D btrfs_del_items(trans, root, path, path->slots[0]=
, nr);
> -               if (ret)
> +               if (ret) {
> +                       btrfs_abort_transaction(trans, ret);
>                         goto out;
> +               }
>                 btrfs_release_path(path);
>         }
>
>         ret =3D 0;
>  out:
>         btrfs_free_path(path);
> -       if (ret)
> -               btrfs_abort_transaction(trans, ret);
>         return ret;
>  }
>
> --
> 2.49.0
>
>

