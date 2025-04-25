Return-Path: <linux-btrfs+bounces-13412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF4A9C323
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C838C1BA3347
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E282343BE;
	Fri, 25 Apr 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0qIZ/fy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076181D63CF
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572757; cv=none; b=mtjvEmpB9JGGyYhH9LO7ohbVBAyYjO59wNQ2c7j7VJ3gL25A6qOL6GGksD8D3UrUJtb9YaN+nOBjDNYePamJAFm2QqNpYaNIEF4TTuDOKrzeEiJzToX/WzDxILVnyrayn2hPyJPrNJxKuBkZVpY8gqw7lFVOChuyOt0hCWzBbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572757; c=relaxed/simple;
	bh=A1qJt2Jg860VqeCHkTTNyQHo+e/fyhmEGtx+4G0UXaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At2PRw44if33Dv3MqtME/hmgzuZf/cGC6XWwZZZOwDBSoAt69TkVsAYE2/L8Z95wworeluNUp1ch4l/dkarNzI5WKqF26zi1C3lYeSZObFbU0rx9NQCaOgW60i3ufqliMjtjaX9DpngeJonvGjXWxsWYzS0dd9ZbdenXwmMZptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0qIZ/fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4757C4CEEA
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745572756;
	bh=A1qJt2Jg860VqeCHkTTNyQHo+e/fyhmEGtx+4G0UXaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0qIZ/fya4uXqOon0EQuzZ/3QrwwVaqubVvAkOD/TgLBwEleKLCmRkmGWEX9FLvQH
	 mPY9d5e3NaZIObbw61v8Q/VT1XBGeX26lkwPrwmuXZ0s/nkPchUb2mErNPAwqi240b
	 Qbkv2ymkCtwGucq7w+gD2jjngHAa4an8UF8Z02N1BTjXMPrB8JbSsgkCyjeg2RfPCJ
	 TCzrXKn+MsK7nKpKfzd1FpdvQFaNchh/CMtnQnsA8eTOjRr5a/tSVbzhFJ7fmZR58k
	 NXmhh7SNKfOl0Yd8c+dEN+36iu/9ezC9RYPRaZRp5wqcngXkUF8m0IT0tsn5/y/61D
	 oYdJmjuqyKjSg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ace3b03c043so309943266b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 02:19:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/AeHOVL2z3fBivpnsYU+T6OtH++NDjqQArwzn+Rub+5KGREUb
	UBG3Twwt+n+8c+pQkJ7anWzK/MVgDNoMtL/QpGXk/Pqkd7bdR05sN6k4MBkI28/G0+Vnx/c1hHV
	TcGETA9mpo/c+VAw58acOwQY9eVc=
X-Google-Smtp-Source: AGHT+IE79qFxytDWdS8RtiyvqfGCfxEMIAVaJaZ0/bZM46lvzJHFP/79VhiUWDdF9BHtYqVkXRUfoXnmVOqKx7Qhzao=
X-Received: by 2002:a17:907:d22:b0:ac6:fcdd:5a97 with SMTP id
 a640c23a62f3a-ace71399b7emr158361166b.48.1745572755223; Fri, 25 Apr 2025
 02:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
In-Reply-To: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Apr 2025 10:18:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
X-Gm-Features: ATxdqUGUu2Af9AnhIYJ5y1QF6bS9KsGCqYvl-v_Py_M7gG4LA19KXdxjCK5rt5Y
Message-ID: <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 10:54=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> If btrfs_clone_extent_buffer() hits an error halfway through attaching
> the folios, it will not call folio_put() on its folios.
>
> Unify its error handling behavior with alloc_dummy_extent_buffer() under
> a new function 'cleanup_extent_buffer_folios()'

So this misses any indication that this fixes a bug introduced by:

"btrfs: fix broken drop_caches on extent buffer folios"

With a subject and description like this, it's almost sure this patch
will be automatically picked for stable backports, and if it gets
backported it will break things unless that other patch is backported
too.

Also, since the bug was introduced by the other patch and it's not yet
in Linus' tree, it would be better to update that patch with this
one's content.
That's normally what we do - I know both patches are already in
github's for-next (I didn't even get a chance to review this one since
it all happened during my evening), and it's ok to rebase and squash
patches.

For the record:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 152bf042eb0f..99f03cad997f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2829,6 +2829,22 @@ static struct extent_buffer *__alloc_extent_buffer=
(struct btrfs_fs_info *fs_info
>         return eb;
>  }
>
> +/*
> + * Detach folios and folio_put() them.
> + *
> + * For use in eb allocation error cleanup paths, as btrfs_release_extent=
_buffer()
> + * does not call folio_put().
> + */
> +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> +{
> +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> +               ASSERT(eb->folios[i]);
> +               detach_extent_buffer_folio(eb, eb->folios[i]);
> +               folio_put(eb->folios[i]);
> +               eb->folios[i] =3D NULL;
> +       }
> +}
> +
>  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buff=
er *src)
>  {
>         struct extent_buffer *new;
> @@ -2846,26 +2862,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>
>         ret =3D alloc_eb_folio_array(new, false);
> -       if (ret) {
> -               btrfs_release_extent_buffer(new);
> -               return NULL;
> -       }
> +       if (ret)
> +               goto release_eb;
>
>         for (int i =3D 0; i < num_extent_folios(src); i++) {
>                 struct folio *folio =3D new->folios[i];
>
>                 ret =3D attach_extent_buffer_folio(new, folio, NULL);
> -               if (ret < 0) {
> -                       btrfs_release_extent_buffer(new);
> -                       return NULL;
> -               }
> +               if (ret < 0)
> +                       goto cleanup_folios;
>                 WARN_ON(folio_test_dirty(folio));
> -               folio_put(folio);
>         }
> +       for (int i =3D 0; i < num_extent_folios(src); i++)
> +               folio_put(new->folios[i]);
> +
>         copy_extent_buffer_full(new, src);
>         set_extent_buffer_uptodate(new);
>
>         return new;
> +
> +cleanup_folios:
> +       cleanup_extent_buffer_folios(new);
> +release_eb:
> +       btrfs_release_extent_buffer(new);
> +       return NULL;
>  }
>
>  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs=
_info,
> @@ -2880,12 +2900,12 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>
>         ret =3D alloc_eb_folio_array(eb, false);
>         if (ret)
> -               goto out;
> +               goto release_eb;
>
>         for (int i =3D 0; i < num_extent_folios(eb); i++) {
>                 ret =3D attach_extent_buffer_folio(eb, eb->folios[i], NUL=
L);
>                 if (ret < 0)
> -                       goto out_detach;
> +                       goto cleanup_folios;
>         }
>         for (int i =3D 0; i < num_extent_folios(eb); i++)
>                 folio_put(eb->folios[i]);
> @@ -2896,15 +2916,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>
>         return eb;
>
> -out_detach:
> -       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> -               if (eb->folios[i]) {
> -                       detach_extent_buffer_folio(eb, eb->folios[i]);
> -                       folio_put(eb->folios[i]);
> -               }
> -       }
> -out:
> -       kmem_cache_free(extent_buffer_cache, eb);
> +cleanup_folios:
> +       cleanup_extent_buffer_folios(eb);
> +release_eb:
> +       btrfs_release_extent_buffer(eb);
>         return NULL;
>  }
>
> --
> 2.49.0
>
>

