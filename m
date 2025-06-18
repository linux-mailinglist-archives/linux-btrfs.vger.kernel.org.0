Return-Path: <linux-btrfs+bounces-14775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D82ADF026
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 16:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A7177601
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345E19E98C;
	Wed, 18 Jun 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7CvGzMr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6654199947
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258192; cv=none; b=Wlaf1VJdi4+1/BxWHJJh0TySl5swI+G8TgyzijYmajxuOVQxPQ0Jwe0nGg6Ycytm0/s3UKwg5cVLDkdp4xZSROo2Xe2aN0nm9JACJAHrTHAYAUYOhXwyOGRBIe3MxeM2jCHlk9iM659wukFp9PxpdV8IE0UaHQn4CxU2+da6Grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258192; c=relaxed/simple;
	bh=s4mP7nWtQ8LBlVuUPufOSbRvgoAAvtu9IlbQugaeh1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2pwalDaT+6xqXa+F71YHB5fX/UZ1x9c97FNVG86fwkgv5asgU2cN+YbyeRnbuyhGQs4CaQ/64robZ8UOmClCAhChNLtZaejALNL1ROfLDFJVHZjYbfzl9+EvB8+5kyGTjmvXx/JymqaD4pUHnqKvwNnufK5LaF+CMmqviSjWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7CvGzMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AE6C4CEEE
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750258192;
	bh=s4mP7nWtQ8LBlVuUPufOSbRvgoAAvtu9IlbQugaeh1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y7CvGzMrIs3cir0GMD+U+AkMolRDUlGOng9UoIiu3sM+NoTgg7t/EO4nqTqFB0g1N
	 uYzcN2IT30z+OW7FUQrnfwUQEqBeToOC4bykiSDB9+NjEWiL1NgWdXvkl/P/IpVZOc
	 OQg5cejRsLZDfJzRXWzXRfrSfWrD5GEML5j16gf2Cwb/jgJzRt0WlrsV+Adt6EvfKz
	 pOvPxgbZKS4suCF9+2uOtr5bvOCGbF+IzKSfoPvqJ6H6Ak8pnLulx8imY1j5fZpMRN
	 36AEg5ozUkZjie+0mnZ7tMhnvSrX1AxDYtgAbZD7e4rhOPO0KuO7UNoIHhdzMQ5Q1o
	 QqOJ+lzmy1ajg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adf34d5e698so172872366b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 07:49:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzv7MWiajKO7TeYpceAyxIxT0R/z2qM/WwmYDgJ+U9D3pe6n626
	pJVCuQA8e70pPdZduGf8Ug4Es6Lwc/o+PBJGEnrwW9i3Fjz3SMF43kgfGGsPBTrVeouyRjrUngt
	hh/M3OVpWQA6/AH3FmTtSFoEtIiFdiJM=
X-Google-Smtp-Source: AGHT+IHdWcQDop3OEBzlN9Phfn1Pyn79SDyruOIJw2b8U7H0BKa4Hg7gFkP3lF5nRSdEVhWPj08Pj5WBkRCmI/IU16E=
X-Received: by 2002:a17:907:c807:b0:ad8:908d:20f3 with SMTP id
 a640c23a62f3a-ae01f8898demr301126566b.28.1750258190695; Wed, 18 Jun 2025
 07:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083522.24878-1-sunk67188@gmail.com>
In-Reply-To: <20250612083522.24878-1-sunk67188@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Jun 2025 15:49:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4SKyFyADkYPBKCZd2Oqb3hy-8=A18UR3+gJCBUkryKcg@mail.gmail.com>
X-Gm-Features: AX0GCFu0dCPOuH7-WkxIYZhMeCPjXIZsmBPbbH51iBzoqLdUVHUvyRtw4Hx787I
Message-ID: <CAL3q7H4SKyFyADkYPBKCZd2Oqb3hy-8=A18UR3+gJCBUkryKcg@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: fix nonzero lowest level handling in btrfs_search_forward()
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 9:35=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> w=
rote:
>
> Commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
> checksums during truncate") changed the condition from `level =3D=3D 0` t=
o
> `level =3D=3D path->lowest_level`, while its origional purpose is just to=
 do

origional -> original

> some leaf nodes handling (calling btrfs_item_key_to_cpu()) and skip some
> code that doesn't fit leaf nodes.
>
> After changing the condition, the code path

Add a full colon at the end, so "... the code path:"
Plus a blank line for better readability.

> 1. also handle the non-leaf nodes when path->lowest_level is nonzero,

also -> Also, it's the start of a sentence.

>    which is wrong. However, it seems that btrfs_search_forward() is never

Don't say that "it seems" - that gives the idea you are not sure and
haven't checked it.
It's true that it's never called with a path->lowest_level > 0.

>    called with a nonzero path->lowest_level, which makes this bug not
>    found before.

Another blank line here improves readability.

> 2. makes the later if block with the same condition, which is origionally

makes -> Makes
origionally -> originally

>    used to handle non-leaf node (calling btrfs_node_key_to_cpu()) when
>    lowest_level is not zero, dead code.
>
> This changes the behavior when btrfs_search_forward() is called with
> nonzero path->lowest_level. But this never happens in the current code
> base, and the previous behavior is wrong. So the change of behavior will
> not be a problem.

Just say something more straightforward and clear such as:

"Since btrfs_search_forward() is nevel called for a path with a
lowest_level different from zero,
just completely remove the partial support for a non-zero
lowest_level, simplifying a bit the code,
and assert that lowest_level is zero at the start of the function."

>
> Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only =
checksums during truncate")

The correct format is:

Fixes: 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
checksums during truncate")

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a2e7979372cc..56a49d85b2a4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4585,16 +4585,13 @@ int btrfs_del_items(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>
>  /*
>   * A helper function to walk down the tree starting at min_key, and look=
ing
> - * for nodes or leaves that are have a minimum transaction id.
> + * for leaves that are have a minimum transaction id.

Since we are updating the comment, it's a good opportunity to fix the gramm=
ar.
Replace "that are have a minimum..." with just "that have a minimum...".

>   * This is used by the btree defrag code, and tree logging
>   *
>   * This does not cow, but it does stuff the starting key it finds back
>   * into min_key, so you can call btrfs_search_slot with cow=3D1 on the
>   * key and get a writable path.
>   *
> - * This honors path->lowest_level to prevent descent past a given level
> - * of the tree.
> - *
>   * min_trans indicates the oldest transaction that you are interested
>   * in walking through.  Any nodes or leaves older than min_trans are
>   * skipped over (without reading them).
> @@ -4615,6 +4612,7 @@ int btrfs_search_forward(struct btrfs_root *root, s=
truct btrfs_key *min_key,
>         int keep_locks =3D path->keep_locks;
>
>         ASSERT(!path->nowait);
> +       ASSERT(path->lowest_level =3D=3D 0);
>         path->keep_locks =3D 1;
>  again:
>         cur =3D btrfs_read_lock_root_node(root);
> @@ -4636,8 +4634,8 @@ int btrfs_search_forward(struct btrfs_root *root, s=
truct btrfs_key *min_key,
>                         goto out;
>                 }
>
> -               /* at the lowest level, we're done, setup the path and ex=
it */
> -               if (level =3D=3D path->lowest_level) {
> +               /* at the level 0, we're done, setup the path and exit */

Since the comment is being modified, it's a good opportunity to fix
the style for what we prefer nowadays: capitalize the first word and
add ending punctuation.

Finally, answering your question from the reply you made later:

Yes, "Suggested-by: Qu Wenruo <wqu@suse.com>" can be added, but
there's no need to resend a patch just for that.

Also note that the tag is Suggested-by, and not Suggest-by as you typed.

If you agree, I can update the patch with all those changes and add it
to for-next, let me know.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               if (level =3D=3D 0) {
>                         if (slot >=3D nritems)
>                                 goto find_next_key;
>                         ret =3D 0;
> @@ -4678,12 +4676,6 @@ int btrfs_search_forward(struct btrfs_root *root, =
struct btrfs_key *min_key,
>                                 goto out;
>                         }
>                 }
> -               if (level =3D=3D path->lowest_level) {
> -                       ret =3D 0;
> -                       /* Save our key for returning back. */
> -                       btrfs_node_key_to_cpu(cur, min_key, slot);
> -                       goto out;
> -               }
>                 cur =3D btrfs_read_node_slot(cur, slot);
>                 if (IS_ERR(cur)) {
>                         ret =3D PTR_ERR(cur);
> @@ -4699,7 +4691,7 @@ int btrfs_search_forward(struct btrfs_root *root, s=
truct btrfs_key *min_key,
>  out:
>         path->keep_locks =3D keep_locks;
>         if (ret =3D=3D 0)
> -               btrfs_unlock_up_safe(path, path->lowest_level + 1);
> +               btrfs_unlock_up_safe(path, 1);
>         return ret;
>  }
>
> --
> 2.49.0
>
>

