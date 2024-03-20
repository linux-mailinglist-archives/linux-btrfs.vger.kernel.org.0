Return-Path: <linux-btrfs+bounces-3467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B38811FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F531C210EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9B40BE4;
	Wed, 20 Mar 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnkykipx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DF4084D
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939597; cv=none; b=BRZN1NDz9qC/BNpp9L6FcphFGi7oMckyY86rvtQ9ggMa8TZhoRTsQWZj30Tqt1qnAnL+k0QkwOpXseQMayZ8IZZ9iBt4F6y7u1DfPhGHBAAuNZdY4FgZspt3eBmp8sdu0pVzSJNrkqOJREljXyj50UMfNBQ5f4xkhhGKt/ftJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939597; c=relaxed/simple;
	bh=3hoynfGtRQWYS/E4CPrCK+WlEeYA6uAps62EmeSdHoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9y9K5isnsRXt5UYcxOxRf4Pndaq8FY38+y4f+ba0HZRgHzjR0AXWmIFEFuy/OXi+cmnJFFsjmRoT7Z9wGtu0wpmRyAv4Q5Tm1d0Yfp8Yw3JQPcH0GLbbeaqW4cWUG62Y8wCO8vaRANNBaglE4XQEppKNWne4k/BOebKSLS0nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnkykipx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8DBC433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710939596;
	bh=3hoynfGtRQWYS/E4CPrCK+WlEeYA6uAps62EmeSdHoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NnkykipxDkDEtpq7J49lTWqZrrLWuxVRIUXK2tveXbWDgtnRW3vpnP3OiasC5u2gJ
	 0PYNZ2l2+s9WH3m7E+QGgVHtGLDziGbsxCWqkTehizpM3FZSTvV9oIDZwtXiCeh9NZ
	 GnmvxrYkMadDZcESMf12axIGY322N+oR7PfQml/FTLHtk10iDLVE9DYWyXHSC/LiSt
	 n5e6YzWM63QG2RrZaHTaPK09ahVu+6tI7OEcJoh23W7CQVioPh1oW5e7i1ceLsjNip
	 rnxM5MWVhl6ou+ZlgH+ynPlDXfZ3EY+7YF2oOvMLN7YybdqA++ybXhnNhsJZya5/ns
	 BJtWO/QMp92Dw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso8205584a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 05:59:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3pqBdIZcec7PRbvhHjTdD9erNMGiF/lLmY3FlnywOXrVui5HK
	ngdQffyJXKWy1vm9ka/ZEyBPyMJ9p7RnmXOg19IO3e5XxRR/jfbZeiWNgILTDVXTkxrj7rcmIfh
	sNy8mDbbdel/frX4R4t1Viw+HVLQ=
X-Google-Smtp-Source: AGHT+IHIG6zA8otoP7eDaOrzUIzfsCoap8JUlGBGTeT9HNZPywOH1tXnG/U7Wj06P+dcy4bCuMKO0SAebTuxTHOJJqY=
X-Received: by 2002:a17:906:37d3:b0:a46:f67a:89b with SMTP id
 o19-20020a17090637d300b00a46f67a089bmr1281988ejc.42.1710939594996; Wed, 20
 Mar 2024 05:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710857863.git.anand.jain@oracle.com> <03e43b7538d2a8e8213d491d65bcc02aa9fa437d.1710857863.git.anand.jain@oracle.com>
In-Reply-To: <03e43b7538d2a8e8213d491d65bcc02aa9fa437d.1710857863.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 20 Mar 2024 12:59:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4SHwGDxra7hmROi9bb87+ezaNKn5T8OmJzxban1mZZJw@mail.gmail.com>
Message-ID: <CAL3q7H4SHwGDxra7hmROi9bb87+ezaNKn5T8OmJzxban1mZZJw@mail.gmail.com>
Subject: Re: [PATCH 03/29] btrfs: send_extent_data rename err to ret
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:56=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Simple renaming of the local variable err to ret.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/send.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 50b4a76ac88e..7b67c884b8e1 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5748,10 +5748,10 @@ static int send_extent_data(struct send_ctx *sctx=
, struct btrfs_path *path,
>
>                 sctx->cur_inode =3D btrfs_iget(root->fs_info->sb, sctx->c=
ur_ino, root);
>                 if (IS_ERR(sctx->cur_inode)) {
> -                       int err =3D PTR_ERR(sctx->cur_inode);
> +                       int ret =3D PTR_ERR(sctx->cur_inode);
>
>                         sctx->cur_inode =3D NULL;
> -                       return err;
> +                       return ret;

I think you're taking the consensus of having a return value variable
named 'ret' to the extreme.
That's generally what we should do, especially if the variable is
declared in a function's top level scope, there are many variables and
it's not clear what's used for the return value.

But here?
It's a very short scope for an error path and it's clear enough we are
returning an error and there's no room for confusion here with other
variables.

Doing this type of change causes unnecessary churn and extra work for
future backports of bug fixes for example.

Thanks.

>                 }
>                 memset(&sctx->ra, 0, sizeof(struct file_ra_state));
>                 file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping)=
;
> --
> 2.38.1
>
>

