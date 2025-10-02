Return-Path: <linux-btrfs+bounces-17334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A2BB3D94
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A641C6E8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC0F3101AB;
	Thu,  2 Oct 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKXyYlcx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFD29ACC5
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406815; cv=none; b=b5EbsSb/4IHzrnh3/Zo1W+6H1K5FrvFDORXgE/Achet2WBUEtqlnRQ68A2G02y3yI51Ii6vTL/CWxU3nLlkn2lCp3kgPL6ZJ31r03hP/JPQ9diG6OZ/7yE6fKHAzDj/eukDb4EdgM/5g/FQsgdADCpGrAFuienbZlLn8uzz+61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406815; c=relaxed/simple;
	bh=Nbh4wyT8gL/PEoNOfN4VmfCnnvFwDz5Q+0paGDd8VJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myuGsBa6iG9GVq6tdxwTMe+wAR8gV1Wv4mhpRftReZ0i0J2HqciZPvHMTpvOrl695a5ldUOlXxNjg3ThFmSW3TZRKJrBWIfkrf11ZIkdjPWwdohNZ52A9pxLZGQ+fYVVuqjlgbSlHnRftgI57phXWB/YZ0dpydNeXxC7ZVVI+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKXyYlcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D725C4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759406814;
	bh=Nbh4wyT8gL/PEoNOfN4VmfCnnvFwDz5Q+0paGDd8VJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKXyYlcxRYtUcTte2d4U01heyyk6Dt7RpxSQ7v3SA/4rrE+IUV1/cjPZrOmh0d8x/
	 3/ZqXJU7ZRyzsjoGmul38J9G/V7vl20GpDHcDSF+B1QxyqqjIkT11ZvaFYOYGYQWxM
	 yfK6dpTs/xKPPBoyJvSgTIf2EpWKPP5Zujjm0oXPT321bs5q6eT27CPI2qqz/JIkGW
	 JoahqguZiwFG082dT7qDwuv+nS6lm88WF/Hrk2cxEGn1lNed9aARUgcwEk/ohD9+hH
	 SRBZYjv1tUyHL03qKAAzpvHIIL64JiFKZHHQ8NGFZ8vAZ+8NWeZ3fFR/KfIFQjIjNf
	 F6SDbnvo0theQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so2064926a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Oct 2025 05:06:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZg4Kj5zDoGIGrkwwLLaLhn6+l3/6vqE+1SVN8Vdu7D0dylVVHYOUaoey0rwDjwNe6SSIVt5hSmHlu9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEXqOeFWAvqAXXLFNiNvTHclQL/1wkpIS2Zr/8ehN177GpJqa
	WPSHhl4tRvXPTrjKWTf+aXNoilFJsWtaGPBMKlRqYffiyAp8k4tPmBEiq1t6U/Sfc0dcbw8CeZm
	nHwGOxUaZuqt9NCbpcNdMpPWE7RFJYZs=
X-Google-Smtp-Source: AGHT+IEwsH1eW2XPFAIJ+tIHD4UNHb/OtD6V5jnjAa5cgie1ua/AuaGyryFSlOLuWSqSJSvUz1sBdd9TwuoYAiFCKbM=
X-Received: by 2002:a17:907:3f0c:b0:b40:101d:cbc2 with SMTP id
 a640c23a62f3a-b46e603775cmr897782766b.37.1759406813032; Thu, 02 Oct 2025
 05:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002115427.98773-2-rtapadia730@gmail.com>
In-Reply-To: <20251002115427.98773-2-rtapadia730@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 2 Oct 2025 13:06:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6BQpWAtfkA+tnW-fBkdqSDb4udAeJvdgHfKSKfpYWAOA@mail.gmail.com>
X-Gm-Features: AS18NWBKD20MriKUG3vXBdALiQ8TQQKCtMwbpFng_RWeMXejVuGVIAyf1A71Pnk
Message-ID: <CAL3q7H6BQpWAtfkA+tnW-fBkdqSDb4udAeJvdgHfKSKfpYWAOA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: push memalloc_nofs_save/restore() out of alloc_bitmap()
To: rtapadia730@gmail.com
Cc: dsterba@suse.com, clm@fb.com, fdmanana@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, khalid@kernel.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 12:55=E2=80=AFPM <rtapadia730@gmail.com> wrote:
>
> From: Rajeev Tapadia <rtapadia730@gmail.com>
>
> alloc_bitmap() currently wraps its allocation in memalloc_nofs_save
> /restore(), but this hides allocation context from callers. GFP_NOFS is
> required to avoid recursion into the filesystem during transaction commit=
s,

Not just during transaction commits, but because in every context we
call alloc_bitmap() we are holding a transaction handle open, so if
the memory allocation recurses into the filesystem and triggers the
current transaction's commit, we deadlock - that's why we need NOFS.

> but the correct place to enforce that is at the call sites where we know
> recursion is unsafe.
>
> So now alloc_bitmap() just allocates a bitmap. Also completing the TODO
> comment.

No. Think for a moment...

alloc_bitmap() only has two callers, and in both of them we need a
NOFS allocation since we are holding a transaction handle...
So it only makes sense to leave the setup of NOFS in alloc_bitmap() -
do not move it to the callers and duplicate code...

Just fix the comment, removing the TODO and mention that the reason we
can't recurse is because we are holding a transaction handle open - it
doesn't matter if we are in critical section of a transaction commit
or not - all it matters is that we are holding a transaction handle
open, so a GFP_KERNEL allocation results in a deadlock if it recurses
to the filesystem to commit the transaction.


>
> Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
> ---
>
> The patch was tested by enabling CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> All tests passed while booting the kernel in qemu.

We test btrfs with fstests. The sanity tests aren't enough, they are
mostly to test internal functions.

>
>  fs/btrfs/free-space-tree.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index dad0b492a663..abdbdc74edf8 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -159,8 +159,6 @@ static inline u32 free_space_bitmap_size(const struct=
 btrfs_fs_info *fs_info,
>
>  static unsigned long *alloc_bitmap(u32 bitmap_size)
>  {
> -       unsigned long *ret;
> -       unsigned int nofs_flag;
>         u32 bitmap_rounded_size =3D round_up(bitmap_size, sizeof(unsigned=
 long));
>
>         /*
> @@ -168,13 +166,11 @@ static unsigned long *alloc_bitmap(u32 bitmap_size)
>          * into the filesystem as the free space bitmap can be modified i=
n the
>          * critical section of a transaction commit.
>          *
> -        * TODO: push the memalloc_nofs_{save,restore}() to the caller wh=
ere we
> -        * know that recursion is unsafe.
> +        * This function's caller is responsible for setting the appropri=
ate
> +        * allocation context (e.g., using memalloc_nofs_save/restore())
> +        * to prevent recursion.
>          */
> -       nofs_flag =3D memalloc_nofs_save();
> -       ret =3D kvzalloc(bitmap_rounded_size, GFP_KERNEL);
> -       memalloc_nofs_restore(nofs_flag);
> -       return ret;
> +       return kvzalloc(bitmap_rounded_size, GFP_KERNEL);
>  }
>
>  static void le_bitmap_set(unsigned long *map, unsigned int start, int le=
n)
> @@ -217,7 +213,9 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_=
trans_handle *trans,
>         int ret;
>
>         bitmap_size =3D free_space_bitmap_size(fs_info, block_group->leng=
th);
> +       unsigned int nofs_flag =3D memalloc_nofs_save();

Please don't declare variables in the middle of the code.
We always declare variables at the top of the current scope.

>         bitmap =3D alloc_bitmap(bitmap_size);
> +       memalloc_nofs_restore(nofs_flag);
>         if (unlikely(!bitmap)) {
>                 ret =3D -ENOMEM;
>                 btrfs_abort_transaction(trans, ret);
> @@ -360,7 +358,9 @@ int btrfs_convert_free_space_to_extents(struct btrfs_=
trans_handle *trans,
>         int ret;
>
>         bitmap_size =3D free_space_bitmap_size(fs_info, block_group->leng=
th);
> +       unsigned int nofs_flag =3D memalloc_nofs_save();
>         bitmap =3D alloc_bitmap(bitmap_size);
> +       memalloc_nofs_restore(nofs_flag);
>         if (unlikely(!bitmap)) {
>                 ret =3D -ENOMEM;
>                 btrfs_abort_transaction(trans, ret);
> --
> 2.51.0
>
>

