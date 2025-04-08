Return-Path: <linux-btrfs+bounces-12868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469CA80EDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2762B4239CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305922171A;
	Tue,  8 Apr 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN4noQEL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8D209F35;
	Tue,  8 Apr 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123537; cv=none; b=A7NohdlF8bdpR9iQD3inBa16JE0k/xrtaldfY8CSuEp4fsEyQaIaeezuQwFmxesy5ecMJ11AX++1KknC5ekiCX77HZxgIM66ZduRuqdFBp7mbx1davYSiFKUGbcUfZTHkZgJHbi+jKo4mLH7hXDq3RnYLKyZU092abTKPJ4yzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123537; c=relaxed/simple;
	bh=olBuiJK/AJrMVquWfmLMhUENwZCRAys6goiG98vJrIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZGr5EMCusXuLjb2XtxuXP8qmAj31XowkpfzUN0sgJHRrj5LC/nJBwFBnZJKgVmWqWV2QJtQHizkoE05onPe/wZMDxTbwcSXdXMFysQvKIRFICCSCOIcKIrNj3BFmmGDRDbVm66MqQpdHWBb7HXzRdsYSjuJyUMrhGvjSkI5ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN4noQEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274BCC4CEEB;
	Tue,  8 Apr 2025 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744123537;
	bh=olBuiJK/AJrMVquWfmLMhUENwZCRAys6goiG98vJrIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MN4noQELJlVCGbmapAOBZNc9a0AhCwy4boJHS1dY2p0x2b1ax+9ygIJOXZiACVc9W
	 +uo0h+MIHBKsSgpTPrfZ//6P1iZCbg6UVGPjYEM1GT92MWNuOpaYrjquY4Dy5H9DKo
	 HDjxsICuOUzv0TGnDUI7UmDBG2Nzl/f51m5yDAE1rM9yFeNt8q2QRRobSF7jWm3lXX
	 E8UaYmuW6rZyd9/7HDwjrWHpLk8jsRfhlG4pj5kQgpRUvo9Ez9E5qwu/dy9Sy2bEFW
	 pxZ2wdToQYssYDyxJVIKW7x8QcYxPpMih2a2AznniJf7GuZZhXkbOS1UXiolmsGZcC
	 Uu77sXK/6B1Jw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso10949855a12.2;
        Tue, 08 Apr 2025 07:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd1ls5Qtw1ADG9g3fAys08ALptfylPwI4Sui0cUE4b5TJ3hM0rfB2CWCkFOF1I8nS9FSjGBI20oMAeD+ie@vger.kernel.org, AJvYcCWkxbU19hO9/cprG6H/N6Q99lb4Nm0L3H1Nbgpr6zit8tFgGJVy0ZmvBIYQCGEYnVE2pjqZ6WiXIYD3Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzveICzyES6w7e8C88D5vRErx22i6OuuehzEk0TbGRvhhBWst
	r0rv4CMLyqiAjw7c2X5fYKSc+k7Joh5rsr104ZZ81wyhYLsuzPt4w6BlBPVcDePPdCwKLUdAkDH
	0gMVRQv8XWLiy0S1vuG0WcRAyTM0=
X-Google-Smtp-Source: AGHT+IHIQJTKxSzv99WAVBSrjH88jTQ3hCttlWSr1BdKS16DYWVyqrJ0NrTLPyTSrFEhjS5P6C3KLL9d+s7h7ivUiwA=
X-Received: by 2002:a17:906:ec9:b0:ac8:196f:7441 with SMTP id
 a640c23a62f3a-ac8196f76c0mr336351266b.7.1744123535760; Tue, 08 Apr 2025
 07:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com>
In-Reply-To: <20250408122933.121056-1-frank.li@vivo.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Apr 2025 15:44:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
X-Gm-Features: ATxdqUH41vmqeMmhUtaSpwreauFnjDIoBgYjKMbPB_v5Ynl0O1ppha_HdEk1e1s
Message-ID: <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
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
> index c8c21c55be53..a962efaec4ea 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_fs_info=
 *fs_info,
>         struct btrfs_trans_handle *trans;
>         struct btrfs_balance_item *item;
>         struct btrfs_disk_balance_args disk_bargs;
> -       struct btrfs_path *path;
> +       BTRFS_PATH_AUTO_FREE(path);
>         struct extent_buffer *leaf;
>         struct btrfs_key key;
>         int ret, err;
> @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_fs_inf=
o *fs_info,
>                 return -ENOMEM;
>
>         trans =3D btrfs_start_transaction(root, 0);
> -       if (IS_ERR(trans)) {
> -               btrfs_free_path(path);
> +       if (IS_ERR(trans))
>                 return PTR_ERR(trans);
> -       }
>
>         key.objectid =3D BTRFS_BALANCE_OBJECTID;
>         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_fs_info=
 *fs_info,
>         btrfs_set_balance_sys(leaf, item, &disk_bargs);
>         btrfs_set_balance_flags(leaf, item, bctl->flags);
>  out:
> -       btrfs_free_path(path);
>         err =3D btrfs_commit_transaction(trans);

This isn't a good idea at all.
We're now committing a transaction while holding a write lock on some
leaf of the tree root - this can result in a deadlock as the
transaction commit needs to update the tree root (see
update_cowonly_root()).

Thanks.


>         if (err && !ret)
>                 ret =3D err;
> --
> 2.39.0
>
>

