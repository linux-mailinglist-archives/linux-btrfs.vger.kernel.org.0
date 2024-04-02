Return-Path: <linux-btrfs+bounces-3825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBE8958E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB571C24856
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E51350D2;
	Tue,  2 Apr 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtIULnhk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0913175D
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073091; cv=none; b=NQG7jXBc/1K6RxA6bF91LabpvkKDeMS8LqmUmdAuVWjPEd20rSgaKmEUldzXnA5bxG1UZT4C8U9OMBM/51+it1RZOslmgQmSrI+olE7g1rYn8PtiUCieK/r9jl4EJ9VSk38e1Fs+lGyRpxv633cMW9zSMaUum6W2sVOC+VoTzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073091; c=relaxed/simple;
	bh=Wu8mTuSwoyNkd9JQGGCxKVJm/lDcQcp1ULh6laOAPVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw0r4UW0s7e/LipCXuwD8rifp5jKSFFfItSntUX+09Dc2tWuWGqbHmgnVVeT9HJW+yVasD10G5Z1cPS6Z7razMwH9x3dfX6pz6MjZVeBkDwdRuEZGtaHHism7fqKfMxnnKg6bg9hTmRme0AyIWdrQQ8sLlTxT6GGleo7+ycW1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtIULnhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CFEC433F1
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712073091;
	bh=Wu8mTuSwoyNkd9JQGGCxKVJm/lDcQcp1ULh6laOAPVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jtIULnhkIEZAqXnuEZ6yaD593vad/xR/VJjPqMLc8dM8xh6/swZVHspdfwx8se0os
	 sb5d0S2P1SgbxaIiW64j5F3xMuKKnNWMGjVSzpiSYE+9JAwbwQcL9dPYTEQzKBMop2
	 wFtaSkfmTOsM00J4zPWMeIrAEzkxsUdEQQLpq8Z85xF34hhgXOWabhuoPuzajp/hk7
	 fyCrLlpVpBapiVTBqQBXS5nvpHtnE4YR+2ZhmZPaCRQL7xym8bwS1KVVm0QON60sHz
	 4Z3SjbBC0ViAWO0vZ5XqUtWdSd5MLUkrHz2TW/YMsJS24a/fx8+InGIzsFbmeW+nlo
	 SfiNynyp2qi2w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d23be0b6so5850831e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 08:51:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwIukqbT83W3c6P2v/Q5GsWe3rNogoyq15Z0OkCFcC0BXIjG0eY
	fap6iMP8YqSRcr8WwmvbrPYhFUEIGgF+PaH8Szl4zGeqjhH38iIp4JklbDVqj3glMxzD2Kwtj+W
	zmqkDb8RKfgcBnpp6qOD17TyyJdA=
X-Google-Smtp-Source: AGHT+IEn4J9u87KBWS+JYUGfkNLy3vquNEVBygDbsdjOT9G3pT8eQT71PXXFoP7820cD7od/3Ca8zSDM6uIfVN31LJk=
X-Received: by 2002:a05:6512:3284:b0:516:a01c:87ca with SMTP id
 p4-20020a056512328400b00516a01c87camr7198393lfe.12.1712073089439; Tue, 02 Apr
 2024 08:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712038308.git.wqu@suse.com> <da18eebca4fdff1e0be286c18aee0359c074d3f8.1712038308.git.wqu@suse.com>
In-Reply-To: <da18eebca4fdff1e0be286c18aee0359c074d3f8.1712038308.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Apr 2024 15:50:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7V2tzJP3udgEO2zQw=G_yu=M9mKNwO9y_-sybMQTqtOQ@mail.gmail.com>
Message-ID: <CAL3q7H7V2tzJP3udgEO2zQw=G_yu=M9mKNwO9y_-sybMQTqtOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: simplify the inline extent map creation
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 7:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> With the tree-checker ensuring all inline file extents starts at file
> offset 0 and has a length no larger than sectorsize, we can simplify the
> calculation to assigned those fixes values directly.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file-item.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index e58fb5347e65..de3ccee38572 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1265,18 +1265,19 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
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
> +               u64 extent_end =3D btrfs_file_extent_end(path);
> +

This can be made const or better, since it's only used in one place
now and fits within 80 characters, just use the expression directly
instead of using a variable.

>                 em->start =3D extent_start;
>                 em->len =3D extent_end - extent_start;

Which is here:   em->len =3D btrfs_file_extent_end(path) - extent_start;

>                 em->orig_start =3D extent_start -
> @@ -1299,9 +1300,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
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
> @@ -1336,7 +1340,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *=
path)
>
>         if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_INL=
INE) {
>                 end =3D btrfs_file_extent_ram_bytes(leaf, fi);
> -               end =3D ALIGN(key.offset + end, leaf->fs_info->sectorsize=
);
> +               end =3D leaf->fs_info->sectorsize;

So both assignments to "end" should be removed, not just the second
one, as the new one doesn't need the previous and makes it pointless.

Thanks.

>         } else {
>                 end =3D key.offset + btrfs_file_extent_num_bytes(leaf, fi=
);
>         }
> --
> 2.44.0
>
>

