Return-Path: <linux-btrfs+bounces-12797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A505A7C137
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3561F17AF9C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB5202C41;
	Fri,  4 Apr 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN04cmtU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2358F40
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782690; cv=none; b=hComJHY2eMpdanh5ptzJw4qnPJzYS0Xc6gN+UaGka1RG0Lu2b79kV8dvax49PgMV346pt58yBYpbnWksqTjLa+bvlKGSAY0TbdlPZxcmtV3m1ptCsNmrTRwVhEIIvlQhHJnO3/tyq6ojJKgzqVWhz4mGe6ta+XTuzLqZTy6wFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782690; c=relaxed/simple;
	bh=XomAFwhYGurDf0qwhf1xYc79ZPryqnI3Q/Mj5oy60+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ8ymwbZgwu7EvAvuBVd1vNa2vR9znyeg2UYOcicVQmqAummrGxTPzJXEKtcyXJl2X72vxa9ns6ZnZf/qk6E05/ZykIyRcZJIumKT7ufVr6gfJZnfUyQwEdXajnz5aF5quOG84gTC3UyrMHUC6bn+nTD1wQoWwq8R+V/2DvD8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN04cmtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A900C4CEEA
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782690;
	bh=XomAFwhYGurDf0qwhf1xYc79ZPryqnI3Q/Mj5oy60+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sN04cmtURODYuSvqHmBrh0JHwYNSG/8Om3mTKMd2jlzBp1ic721zkNptG+oQAUA47
	 Wr28G/9aSL3U8/jmG7pyozo0LAIUktG7Bxko4wZbjm+At/ChdP5kMoWRKejihZslkp
	 lobUSnlV2rux5nwRfeIfh/rIe0OqDdr6QNoYGvQ7jpJ8rT0x7Am7kXO64H6GXFiVrA
	 HsutJxWZzlrigyaXQfjeetlJTt8MJA9VI4crFjQHMUOmK6uQxfWSWHmg7sSNBugBAj
	 98qEPAtaEk7pFCoZrRm54ZwS70twF+3Vm/M/6nTPqLXjuo1ZWNLzju659k+aohpb9b
	 6/isxP++jOCSg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so290970366b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 09:04:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YxO6GZCICTDmFtoTk9vp15nAzBWF4bg3RBfGjFBir7DIyJevDqc
	FR/O5FVQKdS4uYo7l+eDgFA5iQ8IhIai6jtcj6/1BeWEd49ni3diPAI8/SS9a7vaeLmbtoAykHO
	ifhNrelPQyZOcRMQ1KFTrBmMNL+8=
X-Google-Smtp-Source: AGHT+IGmv6rq5TDfy1mnwg+Un1Z2Tjyefb5avpgmzwRdgwB2PhIgc3O8pUwGE9ojzXzxN+Ygt29E3R8Qco5sKAJxr6U=
X-Received: by 2002:a17:907:7214:b0:ac6:b811:e65b with SMTP id
 a640c23a62f3a-ac7d1821920mr374249766b.36.1743782688615; Fri, 04 Apr 2025
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743731232.git.wqu@suse.com> <39d3966f896f04c3003eb9a954ce84ff33d51345.1743731232.git.wqu@suse.com>
In-Reply-To: <39d3966f896f04c3003eb9a954ce84ff33d51345.1743731232.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 4 Apr 2025 16:04:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5vSyG3zpCZ5hbPT8aR2-xODazLwcKhWGhJYUUMLTus1w@mail.gmail.com>
X-Gm-Features: ATxdqUGiAiKIjBDQS9yFuUM4ubZUTdIL4ZJBYbylU7OkwtantHL0kr79XW8MP5o
Message-ID: <CAL3q7H5vSyG3zpCZ5hbPT8aR2-xODazLwcKhWGhJYUUMLTus1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: remove unnecessary early exits in delalloc
 folio lock and unlock
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 2:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside function unlock_delalloc_folio() and lock_delalloc_folios(), we

function -> functions

> have the following early exist:

exist -> exit

>
>         if (index =3D=3D locked_folio->index && end_index =3D=3D index)
>                 return;
>
> This allows us to exist early if the range are inside the same locked

exist -> exit
the range are inside -> the range is inside

> folio.
>
> But even without the above early check, the existing code can handle it
> well, as both __process_folios_contig() and lock_delalloc_folios() will
> skip any folio page lock/unlock if it's on the locked folio.
>
> Just remove those unnecessary early exits.

It looks good to me from a functional point of view.

But without this early exits there's a bit of work done, from function
calls to initializing and releasing folio batches, calling
filemap_get_folios_contig()  which
will search the mapping's xarray and always grab one folio and add it
to the batch, etc.

It's not uncommon to do IO on a range not spanning more than one
folio, especially when supporting large folios, which will be more
likely.
I understand the goal here is to remove some code, but this code is
cheaper compared to all that unnecessary overhead.

Have you considered that?

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8b29eeac3884..013268f70621 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -224,12 +224,7 @@ static noinline void unlock_delalloc_folio(const str=
uct inode *inode,
>                                            const struct folio *locked_fol=
io,
>                                            u64 start, u64 end)
>  {
> -       unsigned long index =3D start >> PAGE_SHIFT;
> -       unsigned long end_index =3D end >> PAGE_SHIFT;
> -
>         ASSERT(locked_folio);
> -       if (index =3D=3D locked_folio->index && end_index =3D=3D index)
> -               return;
>
>         __process_folios_contig(inode->i_mapping, locked_folio, start, en=
d,
>                                 PAGE_UNLOCK);
> @@ -246,9 +241,6 @@ static noinline int lock_delalloc_folios(struct inode=
 *inode,
>         u64 processed_end =3D start;
>         struct folio_batch fbatch;
>
> -       if (index =3D=3D locked_folio->index && index =3D=3D end_index)
> -               return 0;
> -
>         folio_batch_init(&fbatch);
>         while (index <=3D end_index) {
>                 unsigned int found_folios, i;
> --
> 2.49.0
>
>

