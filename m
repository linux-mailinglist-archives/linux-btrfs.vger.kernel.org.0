Return-Path: <linux-btrfs+bounces-12870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F63A80EF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C61188C4B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14DE2206B8;
	Tue,  8 Apr 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWihu77d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40F20CCD8;
	Tue,  8 Apr 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123873; cv=none; b=PgcmWrW7B5dDleuYOZgbhoCvoL0/rS1Dbg4Ix5VZM7/CBd4IR2fOU6zdVMcd0kNc5TZnp/SwpcGBFgNcagMCYpXTRfV+bCTpkE5KUE8KTf7RPlh4tpajGLd3Mdot7LI2UmjWLujzpm2TFYeMzUv4bxED83IEdzjgl1FMN34PFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123873; c=relaxed/simple;
	bh=DOqP7PC9/CSNxfy0CTzHFxtwwycinrGKWx3ZrNUpVhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZIQ7eC7RqWl+2AD386yfrG1zE3jOGAlRvLKNw3+a0mnELXLWOWrBczavsVQac1dTLOtqYsAu8Vzxxctr/VU2wJFIG5mwD3/kdzf4tfRjRYsQSVZjUlLrmmoS82TEL4eiiyaPjymBu8LmlFyGTb40yZ+OM5XxuVPuS2iGC/b7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWihu77d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66745C4AF09;
	Tue,  8 Apr 2025 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744123872;
	bh=DOqP7PC9/CSNxfy0CTzHFxtwwycinrGKWx3ZrNUpVhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DWihu77diMO7llC4OkgLsMjWI5AeoqVzAzMi1/6AddBKf28/waPOzjsEVP7tO6p/m
	 huhjLJIdEVR0a9PYyJXn/OGSH2WNaDzrG3gNwh+sHjJMUaxN2jfcKe1nL4CIdO3OzE
	 E6sKd9MYw2xjzR5VyKMc5bfcXy0dqZwTCxuw9hk7M6BokbSmhrfh1RSnHpUE5axLX5
	 dKaI3E2iM/zWInmk4VDDTnVubpm7PF1NgJxQ93q3lklIOH3jU6yxzmgoZR9FLiaA7V
	 BWQWIdvGpp9comNUgGkfWUr7IUx4fEZbTWVdo1WI78NrxUCwUHMTjzJUDD5NPCizEK
	 d204DkW4wO1Sw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so10504264a12.1;
        Tue, 08 Apr 2025 07:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEpXnUiDlzCNNFSY40DRocgk4a3WLLX25jf+sTA3o4aIWyQSszhw13fZboYCXmQPZUsW2P+bgABPtoFg==@vger.kernel.org, AJvYcCUTilhAdc9DhAL7P5WkBf0BBIw5azrrO0WYHjDr7NgdE/NMhEwIYvP+tupbxqYr+ZAYz0Mpshl1EwToSngD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln+V4ZdhnuGEE9rlW1yghW4lJqYRt9LQPGTFGHWbxv/4qC1PG
	ekU7o/1bbbFRJ1ufCEVmpcDT0XoyzMkh1TVY7OsGqs3pEAWr/Z2J5uBw4tpAZvQfT8tdYki6VlF
	Ej4GMjKbJCzq4T+1CzcCgfIwKmEw=
X-Google-Smtp-Source: AGHT+IHyOTHcUgbR5sI3csnlG+ZrE4vBezaZ5/r0WwtZIV0n3hWOrhVqf8Jcvj1Tm6qdgRS0W/lR3uBg+dkSgBvD8U0=
X-Received: by 2002:a17:907:d91:b0:ac1:e2be:bab8 with SMTP id
 a640c23a62f3a-ac7d6d52781mr1151445266b.26.1744123870927; Tue, 08 Apr 2025
 07:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <20250408122933.121056-3-frank.li@vivo.com>
In-Reply-To: <20250408122933.121056-3-frank.li@vivo.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Apr 2025 15:50:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7crVYyQrffLWO6Fr8QpFS2B0BjURqrpTYDYbX3ki0imA@mail.gmail.com>
X-Gm-Features: ATxdqUGVhAP8P4HMOZyfWKhfVmxvqYNpgxPoMH5VGQXuQ7gjTeg-GxSSbDwgWuA
Message-ID: <CAL3q7H7crVYyQrffLWO6Fr8QpFS2B0BjURqrpTYDYbX3ki0imA@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: Fix transaction abort during failure in insert_balance_item()
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:22=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:
>
> Handle insert_empty_item errors by adding explicit
> btrfs_abort_transaction/btrfs_end_transaction calls.

But why should we do it?
More below.

>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/volumes.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 375d92720e17..347c475028e0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3733,7 +3733,7 @@ static int insert_balance_item(struct btrfs_fs_info=
 *fs_info,
>         BTRFS_PATH_AUTO_FREE(path);
>         struct extent_buffer *leaf;
>         struct btrfs_key key;
> -       int ret, err;
> +       int ret;
>
>         path =3D btrfs_alloc_path();
>         if (!path)
> @@ -3749,8 +3749,11 @@ static int insert_balance_item(struct btrfs_fs_inf=
o *fs_info,
>
>         ret =3D btrfs_insert_empty_item(trans, root, path, &key,
>                                       sizeof(*item));
> -       if (ret)
> -               goto out;
> +       if (ret) {
> +               btrfs_abort_transaction(trans, ret);
> +               btrfs_end_transaction(trans);

A transaction abort will turn the fs into RO mode, and it's meant to
be used when we can't proceed with changes to the fs after we did
partial changes, to avoid leaving things in an inconsistent state.
Here we don't abort because we haven't done any changes before using
the transaction handle, so an abort is pointless and will turn the fs
into RO mode unnecessarily.

Thanks.

> +               return ret;
> +       }
>
>         leaf =3D path->nodes[0];
>         item =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_balanc=
e_item);
> @@ -3764,11 +3767,8 @@ static int insert_balance_item(struct btrfs_fs_inf=
o *fs_info,
>         btrfs_cpu_balance_args_to_disk(&disk_bargs, &bctl->sys);
>         btrfs_set_balance_sys(leaf, item, &disk_bargs);
>         btrfs_set_balance_flags(leaf, item, bctl->flags);
> -out:
> -       err =3D btrfs_commit_transaction(trans);
> -       if (err && !ret)
> -               ret =3D err;
> -       return ret;
> +
> +       return btrfs_commit_transaction(trans);
>  }
>
>  static int del_balance_item(struct btrfs_fs_info *fs_info)
> --
> 2.39.0
>
>

