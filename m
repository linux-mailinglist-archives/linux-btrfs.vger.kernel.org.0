Return-Path: <linux-btrfs+bounces-5952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54640916529
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DFD1C21F46
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4414A0B7;
	Tue, 25 Jun 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+LvUR5r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D36149C61
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310806; cv=none; b=iWo9UX2gomxpVwdo/jBfLEocyBw7TptvilWRtZBvqAa7cbC0KRk3splb4vhlEtAfCtCThJEKshhUMPIa3OlrDXZYe38zKAnt7jbvgm3B1FoeO0m66k0lX2r4a8U2LlgkMLsHCP766cVx0bCxbRbXGRACqTjebxGclPr7vgSsHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310806; c=relaxed/simple;
	bh=jqjRg8i7CNwlhLOnvunvdMKxNwxbTD9Yj/AWvDPSzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnErX61v/HiuLXwk5BfQMuldIxn+OheuO4krf/ih+0F/Ww8S0fd49yOnrsML3qtloM+2Z0tXqfGdDrqkL1sMeC6WjU4C81TRvNHIqWhJ7ZKp9I3+XyUJsuGaRXvMN9LGMQSRvL6/URBEmF9eY3nfBQpHSzJ3B7C/M43XtukN1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+LvUR5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4960AC32781
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719310806;
	bh=jqjRg8i7CNwlhLOnvunvdMKxNwxbTD9Yj/AWvDPSzlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m+LvUR5rBwvJodDc5nnMaovhba7agWF87yuvAMXSCbBMmCgkr7YGbrknoy33fVwXE
	 s5kGSPSu/AlLZYG1IP1nfLTU03zJ1TkHVb6gtkuvg52LmGFkdXANiJ5gPFhoToKFnb
	 aTebTkCC+CnBsYANY86/eHHct4bttEMsd4QW8BJH0YKCCz0BwqAQYw3w10Fa6gOLJS
	 9sLynfM74iN5givQzQmn57/SyZZ0HRhjl+GOmMI1ijpFMelHnJTAg/3W6iZDeWKSrW
	 YkAGhRnJviW4Wfv5wPjQ0v+9r1tUcB75R4Hh86Cy162FXckuWCu/mEjaK5Auw67tNI
	 Qp4B9knNSuxFA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6fe118805dso301396966b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 03:20:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxyvXpEV4sU572kPuWtBozyBMu0JKOsdZR460pD9LEynrJU5DqQ
	K4OhgnUiXVug0/MfqcwgoeRtSQxZNmbbXJmoyMdNbdqC+QL7qL7qxyEpYLbdiglIkd9Sq1gwXqZ
	A82+6jcTihelPXBFhdij8zns90xo=
X-Google-Smtp-Source: AGHT+IFErqtSPLeTOQ0HzLF40HWNmFDb5l1/nfwERKhJ5V1s5v9Z2RnkU14dfT012yKpm1gMe4s3KQCRmuyoBq6iEbo=
X-Received: by 2002:a17:906:2454:b0:a6f:b9f3:8dd0 with SMTP id
 a640c23a62f3a-a7245df5410mr324526866b.73.1719310804865; Tue, 25 Jun 2024
 03:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719291793.git.wqu@suse.com> <a963c3b347e54bc23b9c0b39e8e864ae309dd148.1719291793.git.wqu@suse.com>
In-Reply-To: <a963c3b347e54bc23b9c0b39e8e864ae309dd148.1719291793.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 11:19:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4eayxdogMgJKtPTNZVO-qcsZ9tcQrRGVCoEAzbsa0PEQ@mail.gmail.com>
Message-ID: <CAL3q7H4eayxdogMgJKtPTNZVO-qcsZ9tcQrRGVCoEAzbsa0PEQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: cleanup the bytenr usage inside btrfs_extent_item_to_extent_map()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEMS]

I wouldn't call this "problems", there are no bugs here or anything harmful=
.

> Before commit 85de2be7129c ("btrfs: remove extent_map::block_start
> member"), we utilized @bytenr variable inside
> btrfs_extent_item_to_extent_map() to calculate block_start.
>
> But that commit removed block_start completely, we have no need to
> advance @bytenr at all.
>
> Furthermore with recent enhanced btrfs-progs check for ram_bytes
> mimsatch, it turns out that for truncated ordered extents, their

mimsatch -> mismatch

> ram_bytes can be smaller than disk_num_bytes.
>
> [ENHANCEMENT]
> Thankfully all above problems are not really going to affect end users,
> fix them by:
>
> - Declare @bytenr only inside the if branch and make it const
>   So we can remove the unnecessary advance of @bytenr.
>
> - Manually override extent_map::ram_bytes using disk_num_bytes
>   This is for non-compressed regular/preallocated extents.

I don't see anything in the patch changing ram_bytes.
Perhaps this is from an early patch version never submitted, or from
some other patch?

The code itself looks good.
Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file-item.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 55703c833f3d..2cc61c792ee6 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1281,7 +1281,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_i=
node *inode,
>         const int slot =3D path->slots[0];
>         struct btrfs_key key;
>         u64 extent_start;
> -       u64 bytenr;
>         u8 type =3D btrfs_file_extent_type(leaf, fi);
>         int compress_type =3D btrfs_file_extent_compression(leaf, fi);
>
> @@ -1291,22 +1290,22 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
_inode *inode,
>         em->generation =3D btrfs_file_extent_generation(leaf, fi);
>         if (type =3D=3D BTRFS_FILE_EXTENT_REG ||
>             type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
> +               const u64 disk_bytenr =3D btrfs_file_extent_disk_bytenr(l=
eaf, fi);
> +
>                 em->start =3D extent_start;
>                 em->len =3D btrfs_file_extent_end(path) - extent_start;
> -               bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
> -               if (bytenr =3D=3D 0) {
> +               if (disk_bytenr =3D=3D 0) {
>                         em->disk_bytenr =3D EXTENT_MAP_HOLE;
>                         em->disk_num_bytes =3D 0;
>                         em->offset =3D 0;
>                         return;
>                 }
> -               em->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, f=
i);
> +               em->disk_bytenr =3D disk_bytenr;
>                 em->disk_num_bytes =3D btrfs_file_extent_disk_num_bytes(l=
eaf, fi);
>                 em->offset =3D btrfs_file_extent_offset(leaf, fi);
>                 if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>                         extent_map_set_compression(em, compress_type);
>                 } else {
> -                       bytenr +=3D btrfs_file_extent_offset(leaf, fi);
>                         if (type =3D=3D BTRFS_FILE_EXTENT_PREALLOC)
>                                 em->flags |=3D EXTENT_FLAG_PREALLOC;
>                 }
> --
> 2.45.2
>
>

