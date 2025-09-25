Return-Path: <linux-btrfs+bounces-17175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F316B9EE37
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F664A4C2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FB2F745B;
	Thu, 25 Sep 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZyZWV+f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC71F5F6
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799122; cv=none; b=V8GREjWcBiK2blCj/5p4o01O9EfBVyZgHIxo8a6GmtpQqP8XGv6G08bq5G4OiYPx8h90oSB1Ai2bE4hM/FaKrs3jYCsJMkPpAq390xxz3tOKs0Nk8/4uImZino3Zu+ryUt6QTj/DUEA6RDQjXmhP5tUY2sIXq2G04ba5Uaxi03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799122; c=relaxed/simple;
	bh=Ag2zV4Uo87wLjdICPWHgzBDeUghyAaMSBp7lPSDS9ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVBcAybKI0sjOuuscJx4grLgBl/byGJCvMOY4gu6EHPW5JCNjXXEYVjl9U6n6dOnIKjQhJhvTeTQjOnxDy7K/M2gBZ/XLRaTHKCoOwxXK1ZMKBPhUxJv98PIYriAgTrUK0xhVnt3FLxBmRucRckh20aN053LYdVLz0g6wyky5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZyZWV+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75569C4CEF0
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758799121;
	bh=Ag2zV4Uo87wLjdICPWHgzBDeUghyAaMSBp7lPSDS9ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QZyZWV+fhumBmBw4wccSsTxlnGJXseejBqpn/6QxcDNIDSTqkTciSxSDrf46qXaE1
	 9UfBiA7ESP4WdWT22KgDKDyMJ8rdf0uGmZshXV3m/gNhxB5QF2QnhCKoD1OfXl+h/f
	 t16F63tOfNdvU8rPNoW2bRdwSBAdgvKq490fVzV1qW2b7z41X8TLhvRSx6We1QvN8l
	 LN38aNQMzSkpdlZXfj1elbm4N5xwkyPkbbSRVqMVjgUTuJeIf8W1mWGOgWxeS8h/jd
	 mNGoOOR/42FdzkVRRrT0Zt8RM9OW/MzKCfoyt9FDeMGn3JJjs5CZy5TB7tjTV5lr11
	 umt6T26xYr1Rg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b33d785db6fso162214066b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 04:18:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9kDJcE9Y5K2KXzxfgU3iilRbMjMPVgFfQ1I6QIMhOZBL4nSYR
	tWxK7jwkxgEmx0uJkFdyz4+av6JeMdwXQsjWFVeCsRqASnv5xNzWJEvPpyZgCj6k/WJqDkrisAU
	HwJOLRYiIS3JNdO5lP7WCioUP80SnFOY=
X-Google-Smtp-Source: AGHT+IG9xZJcRkSYMMVv8/IdtPCL0RR9rA1VOnYSfSrncYNaHKQAA2qTI+pqxoA+0W0vs+m5yNjlzgx5IzcnRfpbYBU=
X-Received: by 2002:a17:906:c106:b0:b34:2942:d96a with SMTP id
 a640c23a62f3a-b34b80b32d7mr341431266b.29.1758799120046; Thu, 25 Sep 2025
 04:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0380625eee35a412417a8780e74255830486f2d6.1758660529.git.boris@bur.io>
In-Reply-To: <0380625eee35a412417a8780e74255830486f2d6.1758660529.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Sep 2025 12:18:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MWkF-XpGqS4iR0vAnqFnopX-2i5XZM26pBOzHf6Ad=Q@mail.gmail.com>
X-Gm-Features: AS18NWBsEWdjlPSCR64PnHujBTmxujoQrD7ksK0S9o9RVoy-9-tuBQdF-DTeumg
Message-ID: <CAL3q7H4MWkF-XpGqS4iR0vAnqFnopX-2i5XZM26pBOzHf6Ad=Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: handle ENOMEM from alloc_bitmap()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:01=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfs_convert_free_space_to_bitmaps() and
> btrfs_convert_free_space_to_extents() both allocate a bitmap struct
> with:
>
>         bitmap_size =3D free_space_bitmap_size(fs_info, block_group->leng=
th);
>         bitmap =3D alloc_bitmap(bitmap_size);
>         if (!bitmap) {
>                 ret =3D -ENOMEM;
>                 btrfs_abort_transaction(trans);
>                 return ret;
>         }
>
> This conversion is done based on a heuristic and the check triggers each
> time we call update_free_space_extent_count() on a block group (each
> time we add/remove an extent or modify a bitmap). Furthermore, nothing
> relies on maintaining some invariant of bitmap density, it's just an
> optimization for space usage. Therefore, it is safe to simply ignore
> any memory allocation errors that occur, rather than aborting the
> transaction and leaving the fs read only.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Btw, I see that you pushed this to for-next already, but forgot to
include the Reviewed-by tag from Qu's review.


> ---
>  fs/btrfs/free-space-tree.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index eba7f22ae49c..18008e288acd 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -218,11 +218,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs=
_trans_handle *trans,
>
>         bitmap_size =3D free_space_bitmap_size(fs_info, block_group->leng=
th);
>         bitmap =3D alloc_bitmap(bitmap_size);
> -       if (!bitmap) {
> -               ret =3D -ENOMEM;
> -               btrfs_abort_transaction(trans, ret);
> -               goto out;
> -       }
> +       if (!bitmap)
> +               return 0;
>
>         start =3D block_group->start;
>         end =3D block_group->start + block_group->length;
> @@ -361,11 +358,8 @@ int btrfs_convert_free_space_to_extents(struct btrfs=
_trans_handle *trans,
>
>         bitmap_size =3D free_space_bitmap_size(fs_info, block_group->leng=
th);
>         bitmap =3D alloc_bitmap(bitmap_size);
> -       if (!bitmap) {
> -               ret =3D -ENOMEM;
> -               btrfs_abort_transaction(trans, ret);
> -               goto out;
> -       }
> +       if (!bitmap)
> +               return 0;
>
>         start =3D block_group->start;
>         end =3D block_group->start + block_group->length;
> --
> 2.50.1
>
>

