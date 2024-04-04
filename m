Return-Path: <linux-btrfs+bounces-3914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7985189853B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3DB1F253A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6137FBA7;
	Thu,  4 Apr 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj1PiU2J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608E7F7C8
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227263; cv=none; b=DsGLgNvohSTUAscG366CVH4qetFHfk56VolVgkR4yQIHTHD7QB67p1E2ktg1isXlzaOk1iKElQbv8rkQCwmUU7y23DtPSnC61+kLzGEG9L3eIyw+cchc0NGNzRuSSKHHjQXElohTku0NdPfzZL9l4mNy/vl6UBWuhXv90rLDmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227263; c=relaxed/simple;
	bh=7EpBYNU8vVMKtqXU1AyJu+/VYOFIUM16jg8ZVYtDmP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ8JjbTG23Q5AP1jMEiy2WETJukUR2ANOhAAgCT6WG8voGKpPF4upd4S+rzR42++CLlEko9HNeWCpuxUoJqP5SjZzvgvaEVC44EzmuKNf0lsyh10TWpRMsAiaUBdw7t/e1zNwS6d7Zfst/vKHBdrj42ZoOlPGU5kEeSpzmI0n5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj1PiU2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ADFC433C7
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712227262;
	bh=7EpBYNU8vVMKtqXU1AyJu+/VYOFIUM16jg8ZVYtDmP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zj1PiU2JWKxpAHcOTNl0O+mJVznj4tuSVQSZOJk4xP/yr6Z36z4ZmpzaZ8fUz6Jn8
	 pl345lx58wDJbEqxzMmQKjUcAQtE2tLndSsWc53vueXAhNQBcseOh7Yy+0VgSAaD+I
	 i3PZGEzzEXTKFkYCB4wfz5gsC5ujcrf7//VCmkToG3u+6o7tm7Xk/ESSzrMgtSsYZn
	 U23ICjVbhLS1yJ7LvHvpDEzk4Fjgl0lPAirA/hMNv7fAr1xObZMMKJ453GKAnGDTBO
	 /Q+xWPczIzGe7XG3fAOXewHLRc4c496Xc7v5cs216DwgnV9zC2NI5pG1OdSIH+inba
	 i9HZ0otYAAQDg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5193f879easo23834266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Apr 2024 03:41:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YyT3MuKuzuo4epoxvz91dtCa+J9y10Zry+4I5FlyePIN2aXK2mW
	kOVSGfSOLfIWPwBYMoqGZnEDM28sbK3RYDf1Frfa+gCUewWZkKJGlcQsa9CPGyQ+nLV5YfwjDW6
	RpmRTBFZOmvOKFVul8RyqKTL1G2c=
X-Google-Smtp-Source: AGHT+IHwFO/ouPreSnOoIGNuUb7fLCEw97HdfisYsGaLSloFYvvaALBfoeWedkx+y1+E4VGy2H3LXH6YVHB6/gR3h4A=
X-Received: by 2002:a17:906:a28c:b0:a4e:46df:bae9 with SMTP id
 i12-20020a170906a28c00b00a4e46dfbae9mr1247837ejz.20.1712227261154; Thu, 04
 Apr 2024 03:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712187452.git.wqu@suse.com> <5ed85f144e50f7a1e159ebd1748ef1e8be9c0bd2.1712187452.git.wqu@suse.com>
In-Reply-To: <5ed85f144e50f7a1e159ebd1748ef1e8be9c0bd2.1712187452.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Apr 2024 11:40:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6o7ZQeVZskFOGqaocgcmppzU_ek0os6irMS_akTqzr0g@mail.gmail.com>
Message-ID: <CAL3q7H6o7ZQeVZskFOGqaocgcmppzU_ek0os6irMS_akTqzr0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] btrfs: simplify the inline extent map creation
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:55=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> With the tree-checker ensuring all inline file extents starts at file
> offset 0 and has a length no larger than sectorsize, we can simplify the
> calculation to assigned those fixes values directly.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file-item.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index e58fb5347e65..ad4761192d59 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1265,20 +1265,19 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
_inode *inode,
>         struct extent_buffer *leaf =3D path->nodes[0];
>         const int slot =3D path->slots[0];
>         struct btrfs_key key;
> -       u64 extent_start, extent_end;
> +       u64 extent_start;
>         u64 bytenr;
>         u8 type =3D btrfs_file_extent_type(leaf, fi);
>         int compress_type =3D btrfs_file_extent_compression(leaf, fi);
>
>         btrfs_item_key_to_cpu(leaf, &key, slot);
>         extent_start =3D key.offset;
> -       extent_end =3D btrfs_file_extent_end(path);
>         em->ram_bytes =3D btrfs_file_extent_ram_bytes(leaf, fi);
>         em->generation =3D btrfs_file_extent_generation(leaf, fi);
>         if (type =3D=3D BTRFS_FILE_EXTENT_REG ||
>             type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
>                 em->start =3D extent_start;
> -               em->len =3D extent_end - extent_start;
> +               em->len =3D btrfs_file_extent_end(path) - extent_start;
>                 em->orig_start =3D extent_start -
>                         btrfs_file_extent_offset(leaf, fi);
>                 em->orig_block_len =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
> @@ -1299,9 +1298,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                                 em->flags |=3D EXTENT_FLAG_PREALLOC;
>                 }
>         } else if (type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> +               /* Tree-checker has ensured this. */
> +               ASSERT(extent_start =3D=3D 0);
> +
>                 em->block_start =3D EXTENT_MAP_INLINE;
> -               em->start =3D extent_start;
> -               em->len =3D extent_end - extent_start;
> +               em->start =3D 0;
> +               em->len =3D fs_info->sectorsize;
>                 /*
>                  * Initialize orig_start and block_len with the same valu=
es
>                  * as in inode.c:btrfs_get_extent().
> @@ -1335,8 +1337,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *=
path)
>         fi =3D btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
>
>         if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_INL=
INE) {
> -               end =3D btrfs_file_extent_ram_bytes(leaf, fi);
> -               end =3D ALIGN(key.offset + end, leaf->fs_info->sectorsize=
);
> +               end =3D leaf->fs_info->sectorsize;

After this, to follow the code style (and checkpatch.pl should
complain about it IIRC), the curly braces should go away, as there's a
single statement in the if and else branches.

Otherwise it looks good, thanks.


>         } else {
>                 end =3D key.offset + btrfs_file_extent_num_bytes(leaf, fi=
);
>         }
> --
> 2.44.0
>
>

