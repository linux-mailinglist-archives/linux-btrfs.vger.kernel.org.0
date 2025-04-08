Return-Path: <linux-btrfs+bounces-12869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B6CA80ED9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396D1173BFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BA221D88;
	Tue,  8 Apr 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi94VhYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CA1E492D;
	Tue,  8 Apr 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123676; cv=none; b=eEnWaTiJaVBxy42iFPwjUcfnOrbB6Lst8ODfJ8XK32ouD/K+rWzXbJPyEL8eW5P8ctmAollYaplsArlJrbxdAZKuraUDVqxgeHPX3MpXM/3RoR1cYwQkNCsY9ud9Ru4du31kTLRF0SzibilwcW5XspE+P3wBAm63FmF8PC8SS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123676; c=relaxed/simple;
	bh=usQhtcH6jA5FdQGsV4FOYvB1Efo86g26nJbuRYtXQUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzA8m9KOY5ACGvcnwrswYzsq7qoiMVKhP+Rz+rC/WAO3iYTYBFtofC/SxIpd2mbq8X8VWg4VUC9EEU1EhGz9xw792oVlFSYz9jn0yf8Z9yNmJ0nScjAtmEmZYyYPwvCUqB98RvlcLe7pTMV2q2K2qdYwEsZV6C+WcQCCDMIR1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi94VhYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A4CC4CEEC;
	Tue,  8 Apr 2025 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744123675;
	bh=usQhtcH6jA5FdQGsV4FOYvB1Efo86g26nJbuRYtXQUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hi94VhYaSB4nc+NnNOCdvIwuggGNziI7EfCyGD54XDel2LGw6SC0j5AsCBx8leLJk
	 ZyqW5W1vSpYuT4H+x/W1Wr0J7YN+WoKNHgMGoSgynm5p8nZX59aFoLa+SxCOtfsGzn
	 bTZPH1KCh/HhnsYQV929dCqiNiW3t74JBgSyPWH0wzHDvjYrCJ5z+tsUP4ALdEaB4a
	 3PMIWhk7OUFNwKWvsX4WoIl7KKYpfuYBLxl4fJiU4auUqthZ2DxQBCbFx39etEjV4A
	 Zn1rNWz/HeWmm2dWIBNmrwbOAMEC4k24em+zVrI/87WgCPo11f3X8ae/RssxkRr+0q
	 Br3wNq9VZCTbA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso117017a12.3;
        Tue, 08 Apr 2025 07:47:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3i9R05Jf7UdOwj79XBBX52aUM888EZeYgCs0XnzA8kv8QPjgslO+kNdlmHco3bWK3dVgSBnu9YGlsa+Hy@vger.kernel.org, AJvYcCUEN59s0iNQv30AXEOmXdGIPHoifYv8bzAeY0dOrwk3PbbJY1F2bnI8buHqDl8HPWrEPUfMz1tEXR0v/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0H2xapToIls680QUzzqFzjCorJqNyO0Dq5nOiYh/Hd/yx3sT
	9mTV6Lm3rey/+LDFUxoJ0+HPOOkDHUrvIzhYTMxvwBUjbTBrRt9EraOUtKB8xDTDxecFx13ySKn
	hZIVhtuXlDsn6hGrVadr/BYhRq08=
X-Google-Smtp-Source: AGHT+IFKarbmy5vtxCDZ6llpj67T/aMPampQuo8nCcWFOkuuQHMKMENxG4s8H5HL0UtxEjm2ZPz23AhuJCBfwkMJ+Aw=
X-Received: by 2002:a17:907:6d20:b0:ac3:446f:20cb with SMTP id
 a640c23a62f3a-ac7d1b280ccmr1578532566b.43.1744123674230; Tue, 08 Apr 2025
 07:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <20250408122933.121056-2-frank.li@vivo.com>
In-Reply-To: <20250408122933.121056-2-frank.li@vivo.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Apr 2025 15:47:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5NxJkSz9FSarixZjpVvTibO6ugYrGB3AFZJAuoWT_BMQ@mail.gmail.com>
X-Gm-Features: ATxdqUF92VfmLSVi8DchQVkVvDfweGaKkPYkwybaD2shvY6fzx7LI1WeAMCSwhk
Message-ID: <CAL3q7H5NxJkSz9FSarixZjpVvTibO6ugYrGB3AFZJAuoWT_BMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: use BTRFS_PATH_AUTO_FREE in del_balance_item()
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:18=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:
>
> All cleanup paths lead to btrfs_path_free so we can define path with the
> automatic free callback.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/volumes.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a962efaec4ea..375d92720e17 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3775,7 +3775,7 @@ static int del_balance_item(struct btrfs_fs_info *f=
s_info)
>  {
>         struct btrfs_root *root =3D fs_info->tree_root;
>         struct btrfs_trans_handle *trans;
> -       struct btrfs_path *path;
> +       BTRFS_PATH_AUTO_FREE(path);
>         struct btrfs_key key;
>         int ret, err;
>
> @@ -3784,10 +3784,8 @@ static int del_balance_item(struct btrfs_fs_info *=
fs_info)
>                 return -ENOMEM;
>
>         trans =3D btrfs_start_transaction_fallback_global_rsv(root, 0);
> -       if (IS_ERR(trans)) {
> -               btrfs_free_path(path);
> +       if (IS_ERR(trans))
>                 return PTR_ERR(trans);
> -       }
>
>         key.objectid =3D BTRFS_BALANCE_OBJECTID;
>         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> @@ -3803,7 +3801,6 @@ static int del_balance_item(struct btrfs_fs_info *f=
s_info)
>
>         ret =3D btrfs_del_item(trans, root, path);
>  out:
> -       btrfs_free_path(path);
>         err =3D btrfs_commit_transaction(trans);

Exactly the same comment as for the previous patch -
https://lore.kernel.org/linux-btrfs/CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv=
-34Q+Qf6PZTQ@mail.gmail.com/
This can result in a deadlock.

Thanks.


>         if (err && !ret)
>                 ret =3D err;
> --
> 2.39.0
>
>

