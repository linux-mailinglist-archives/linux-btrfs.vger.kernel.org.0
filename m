Return-Path: <linux-btrfs+bounces-16756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C6AB4FFB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC84E2F60
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35D34321F;
	Tue,  9 Sep 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBRlI7MC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F72322A07
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428858; cv=none; b=Ji7vd/BBB4tpyDMoHjv9G5IQOSVStwVP2juDgO7upworIxgBnKEJs7X5NMzVHUB1KIp51zMKN2GMXJnStwjtKehmdcWi5ERtyOEh9r6i8iflpbEIq/5RFxByzpqczW0M56gaRMT7AswPNRD2sFsrHXkJ0eI+hYqDVej5EFLy3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428858; c=relaxed/simple;
	bh=i650lJFVQJ7K3/BRol/giHQ4uid9XpfwJMlemuCAPQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9WRc9KLABdT/fbsZPoCenS2tCIB+MHkqDROvC5ppWmvJInwye02xtu75/YM7Efs6VMiMmO/eQNsgqIbaESWbw0V5d2DhqAmJQxPsBTckthgTSnqQ2TRMDTipyAZy5fVIsieNf9fnj5C7ZHukJBWOQqOAtScfHLxLeGi5H75Lc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBRlI7MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE3BC4CEF4
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428857;
	bh=i650lJFVQJ7K3/BRol/giHQ4uid9XpfwJMlemuCAPQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VBRlI7MCMPrx4Ue2Rvg3C5ryf+XgX8y3H3J1d22npnCNtYh0gBq/9kBBqJi1GJRpR
	 yHJEPSMPIdIFYB3QPwU/F7un7RXZkHTclS+NGwsiL2WS/tweyN7uTy+w7cFaJy5QaB
	 2HoGDOCg18R1sfB772zCJ98+YmWPEFNQ26ykuAyeJmX/74EFrZu9k6lJz4BA4YuwOa
	 yGbKPIHWB3wcKmkr2KVMea2zKk7eJfcxBpXjxYbuSsagSVdat01Cu0btBwZVillbbe
	 Om6uPEtGd/0mIUrM1YtHeHY8+zzNOB5pYmuetuPJD6plz8PWGxcdqCJVSU0tqA+sap
	 ULAOclEsbJyRw==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-729c10746edso44271296d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 07:40:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJK+Z71wdFy2cPx9cf/dRTc0cnrELUX8FbGFsPRhSpglVVlyfj3b3Bc2Br4gJkmxX11q8b11RMLYbr+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBz5n4g0hyhI9xBxKE25DOePGysbKDKmkcxYidYlGKSS0O0ne
	owF08CAapgwOhZSBM7buJa3aVpOZzw3sEeU/2aln46VRlAFwvVeJ5F9NdPT3FC1yTKAz5IOnzhm
	XRAcvuGHoRryv0MvqBtOY3f+bjFfxcms=
X-Google-Smtp-Source: AGHT+IHhETfQ40GRzk2EC7WrZqttaWQVNWQni3gayDDbLXwS0Hbm3f8UNL95t5QdM9azvbDRi6ivy2yKLttTPbI7qpc=
X-Received: by 2002:a05:6214:404:b0:721:7a6a:b703 with SMTP id
 6a1803df08f44-7393ca9c898mr139252716d6.53.1757428856933; Tue, 09 Sep 2025
 07:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905095503.1812090-1-austinchang@synology.com>
In-Reply-To: <20250905095503.1812090-1-austinchang@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 9 Sep 2025 15:40:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5M2LM4jDd9e=21SVANTkpU-9HC6r5Y-neCw6c-bALyCA@mail.gmail.com>
X-Gm-Features: AS18NWAr6zHrHr7-2MK7HzTZo9J_2BotgQhFT8Ap9_6Tce2iKZ81tmxwUL8r_uo
Message-ID: <CAL3q7H5M2LM4jDd9e=21SVANTkpU-9HC6r5Y-neCw6c-bALyCA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: init file_extent_tree after i_mode has been set
To: austinchang <austinchang@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:01=E2=80=AFAM austinchang <austinchang@synology.c=
om> wrote:
>
> btrfs_init_file_extent_tree uses S_ISREG() to determine if the file is a

Please use () after a function name, not only makes it more clear,
it's also more consistent  with what we do and what you did below.

> regular file. In the beginning of btrfs_read_locked_inode(), the i_mode

Here you placed the ().

> hasn't been read from inode item, then file_extent_tree won't be used at
> all in volumes without NO_HOLES.
>
> This patch is based on version 6.17-rc4.

There's no need to mention on which version it's based, it's useless
to have this in the changelog.
If there's really a need for that, place it under --- below so that
it's not included.

> It moves the initialization to
> where i_mode has been set and before the first time file_extent_tree is
> used(btrfs_inode_set_file_extent_range).

I have replaced this paragraph with:

Fix this by calling btrfs_init_file_extent_tree() after i_mode is
initialized in btrfs_read_locked_inode().

>
> Signed-off-by: austinchang <austinchang@synology.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I've pushed the patch to github's for-next branch and made those
corrections and added a Fixes tag.

Thanks.

> ---
>  fs/btrfs/inode.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9e4aec733..5731cd296 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3885,10 +3885,6 @@ static int btrfs_read_locked_inode(struct btrfs_in=
ode *inode, struct btrfs_path
>         bool filled =3D false;
>         int first_xattr_slot;
>
> -       ret =3D btrfs_init_file_extent_tree(inode);
> -       if (ret)
> -               goto out;
> -
>         ret =3D btrfs_fill_inode(inode, &rdev);
>         if (!ret)
>                 filled =3D true;
> @@ -3919,6 +3915,11 @@ static int btrfs_read_locked_inode(struct btrfs_in=
ode *inode, struct btrfs_path
>         set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
>         i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
>         i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
> +
> +       ret =3D btrfs_init_file_extent_tree(inode);
> +       if (ret)
> +               goto out;
> +
>         btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
>         btrfs_inode_set_file_extent_range(inode, 0,
>                         round_up(i_size_read(vfs_inode), fs_info->sectors=
ize));
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.
>

