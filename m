Return-Path: <linux-btrfs+bounces-16792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA099B52F96
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 13:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0753B417D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D9311C2E;
	Thu, 11 Sep 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDzxP1wc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B32D130A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588909; cv=none; b=W4fY5SJR7xMvDDRyzy+TUAy1bVjxb7deXn6QWHBeSIrWBVbsvlaSbISCjiyqrnbgAVn/GxdWIsERuS2t7LXJ+Tdt4xvpuLwsbn2KcfOQUNWKCyJOv3aeiO3DEO3MCuLvz5Sbb85YDbHBmLyQaleo8Zg/La+t0WL15Af63z5GCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588909; c=relaxed/simple;
	bh=ldmh2IMK4pXg13e69lNeRykbPIzhJTO5SVa5K6DdSwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syltvPKXaVlwxAwIYzDaBPISK/jUIaqPGQ3zOqq/u1MFJ+nTg0phE9OI/2DPYahpkDIzRRhykJRZUn2heQKtzgAPKf5D32bkvVRJVcptNzArjJ23hXfBUGLgpppk06PqyF4Rk3EzOs2q9c6r1+Rl0Xfz8jYy8vPWu80MVFKnhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDzxP1wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D55C4AF09
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757588908;
	bh=ldmh2IMK4pXg13e69lNeRykbPIzhJTO5SVa5K6DdSwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HDzxP1wcmKfFsRV6Fa4OkD80UgVTOGssH5gzxkMCF+7d3hGP7xUj/d1nROJxeUSOS
	 agvVKItxjI27SFxDdiEI/7OCpdPG7/tXkw0464jSk9r05NSV8q674SKKwPCeKy0e4N
	 V5FB4IdnZqhNGDG6UQHVjkgGNxkRiLyZWz8o4XZsq9T7LVnXKe+qSNptVexJi38Zad
	 Iu7LFbKSlx/tyVpy/cA7EOv/kTycKzAXdoxn78711z/ZCOwdn9NQ5ntwDSj9LQia2g
	 LJRJW45ueN3LAGwv71yz2R2+iqdtLITd3Zsk0o8pWXiaNbBEEpZ6wA6hvRsuf3+82C
	 sOS1YkL/BGq6A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04770a25f2so76230266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 04:08:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmo8icVR+UhJPLlNkvR+SPqPU4IBdL+ESS4s/yHDqQruW9wcEzK/2yx/nMa8qNpfDaKgL41kT6YlbDCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWff6ZYv5nR6OhS1vaq7zxFpnUKL4uAha6mpQIXpqPIqub6BiM
	og1mf573vp2FswrXRxTpvvfkc28oQqFc0KwpygXJ2pEf98l0Vo53nXaTlz3CMM9lfJSVHdwYemj
	qQ63E7Zv3Qsca7XxipacQEbPFGUIeAP4=
X-Google-Smtp-Source: AGHT+IFqncuvahE3O5ZmegrDX3PxLQnxt9KjDd4wJXBF5NkYI2cdCKl1LMgEpXta9zrUISrx6dzxpUwBx9WgVIZvu1A=
X-Received: by 2002:a17:906:fe46:b0:b04:1a1c:cb5f with SMTP id
 a640c23a62f3a-b04b155a027mr2081286866b.33.1757588906525; Thu, 11 Sep 2025
 04:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911060629.1885670-1-austinchang@synology.com>
In-Reply-To: <20250911060629.1885670-1-austinchang@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Sep 2025 12:07:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7-sDMfYUzNP4HkTCUdrNSo14JkhkkHWL2DuCCasHFLRw@mail.gmail.com>
X-Gm-Features: Ac12FXxxT8yRgKjaAweVPk3_9Pw-El-TC41atkpv5iUX9EkYUM1TYau_pIksZ18
Message-ID: <CAL3q7H7-sDMfYUzNP4HkTCUdrNSo14JkhkkHWL2DuCCasHFLRw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: init file_extent_tree after i_mode has been set
To: austinchang <austinchang@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:07=E2=80=AFAM austinchang <austinchang@synology.c=
om> wrote:
>
> btrfs_init_file_extent_tree() uses S_ISREG() to determine if the file is
> a regular file. In the beginning of btrfs_read_locked_inode(), the i_mode
> hasn't been read from inode item, then file_extent_tree won't be used at
> all in volumes without NO_HOLES.
>
> Fix this by calling btrfs_init_file_extent_tree() after i_mode is
> initialized in btrfs_read_locked_inode().
>
> Signed-off-by: austinchang <austinchang@synology.com>
> ---
> Changelog:
> v2: move the call to btrfs_init_file_extent_tree() under cache_index
> label so that inodes from both delayed and regular inode read path
> get file_extent_tree initialized.
> ---
>  fs/btrfs/delayed-inode.c |  2 --
>  fs/btrfs/inode.c         | 12 ++++++------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 0f8d8e275..d953f7af7 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1864,8 +1864,6 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u32=
 *rdev)
>         i_uid_write(vfs_inode, btrfs_stack_inode_uid(inode_item));
>         i_gid_write(vfs_inode, btrfs_stack_inode_gid(inode_item));
>         btrfs_i_size_write(inode, btrfs_stack_inode_size(inode_item));
> -       btrfs_inode_set_file_extent_range(inode, 0,
> -                       round_up(i_size_read(vfs_inode), fs_info->sectors=
ize));
>         vfs_inode->i_mode =3D btrfs_stack_inode_mode(inode_item);
>         set_nlink(vfs_inode, btrfs_stack_inode_nlink(inode_item));
>         inode_set_bytes(vfs_inode, btrfs_stack_inode_nbytes(inode_item));
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9e4aec733..652c409ee 100644
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
> @@ -3919,9 +3915,8 @@ static int btrfs_read_locked_inode(struct btrfs_ino=
de *inode, struct btrfs_path
>         set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
>         i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
>         i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
> +

Stray and unrelated new line.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I've removed this new line and added back the Fixes tag in the for-next bra=
nch.

Thanks.


>         btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
> -       btrfs_inode_set_file_extent_range(inode, 0,
> -                       round_up(i_size_read(vfs_inode), fs_info->sectors=
ize));
>
>         inode_set_atime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->=
atime),
>                         btrfs_timespec_nsec(leaf, &inode_item->atime));
> @@ -3953,6 +3948,11 @@ static int btrfs_read_locked_inode(struct btrfs_in=
ode *inode, struct btrfs_path
>         btrfs_set_inode_mapping_order(inode);
>
>  cache_index:
> +       ret =3D btrfs_init_file_extent_tree(inode);
> +       if (ret)
> +               goto out;
> +       btrfs_inode_set_file_extent_range(inode, 0,
> +                       round_up(i_size_read(vfs_inode), fs_info->sectors=
ize));
>         /*
>          * If we were modified in the current generation and evicted from=
 memory
>          * and then re-read we need to do a full sync since we don't have=
 any
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

