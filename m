Return-Path: <linux-btrfs+bounces-9093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7F49AC80D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925FC1F24917
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25491A08C5;
	Wed, 23 Oct 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBZT3HcD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D241CA84
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679739; cv=none; b=RXl7zTi2w4fexcfkiEsq15CaAwEdjoCW7iwUhgqKEyXFhrwgVBETbTs0I1AfpsnCrP3OtXcUJvUsLL9+XwDgSv+vOHpJbnCMJ50EwiNilmEsx8wzKPOd8nJz3cXbvNugceZlqueod92h4dQMWnQs8Fs9jpKw1aaxoeENpC3Hypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679739; c=relaxed/simple;
	bh=xRkRHzqPPIh0KFttv6uoNARaRiHNXW9oxqiIijC3We8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3x8UUu7FjL4oZT2sq/K5isFL9moL6XSuBp8roZ0tHEX3RCuhOmonAsp9Ga6JA50qMMwJeA5thvQZbUlWlZkc05Q1B7PxROEkC+TA72YVhg8UaD1CC8IY4kZ5watrBXfSglR6TizUrBWnRP6Jgpdjll5Hkp9uWFhr6yLMiRTtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBZT3HcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E329C4CEC6
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729679738;
	bh=xRkRHzqPPIh0KFttv6uoNARaRiHNXW9oxqiIijC3We8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gBZT3HcD7tjBlDFLmXDGaZfZEXCu+13pgqoj6fYgo9sm0UCM0LLtB3klchviGBeP8
	 5HHN8hi/gqR7nzO4rmuPmWJWczoP+ntnAzm8HvLXtEhN3ud0+Mj4Sb4L/W2fZ4DyaN
	 M/o1Ow4VYU1wy/2VM4gRSh9eLap98L/Q2sS8EH16/pGnszW5bs+7WODh79/CTo70Gx
	 ig/WzLOVRwwT/Zwt7z0KFhLy/Hd41+HBu10QmaDXlYPwiaXsKK+jwCJy1nMFodlMrD
	 znEZyDmdp2v0pwYLnaRDQU5tdGicp36aKpNfvC1AFQOJf7Nvmyi7hJwSraNUSp8DYh
	 uKAsAUExvaLxQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9acafdb745so4213166b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 03:35:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuL7In6JP3LhVHhhQEqRN+SxNz+skEXmZNZby6GXgGUN1lFCOw
	XPWAe/cZMpN1o4XnnIoOXNtL/lrYAZWf+xPuSXvrO+GFD02I42fIY/ArMV640ZCm/LY9tRhrh3f
	292HPEBVnA3wGlVYnnp7P3sBYvAA=
X-Google-Smtp-Source: AGHT+IHwizeijxyLwplkhC3/zue1bYJBA4Rhcr3+rLMWtXYyj5Z5HV2xCRVWUydi+gFT/lG3gZXgLFa+e9dEOYLjWzY=
X-Received: by 2002:a17:906:52c9:b0:a9a:c651:e7c7 with SMTP id
 a640c23a62f3a-a9ac651ea5cmr100552866b.12.1729679737168; Wed, 23 Oct 2024
 03:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023063818.11438-1-robbieko@synology.com>
In-Reply-To: <20241023063818.11438-1-robbieko@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Oct 2024 11:34:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7T4QY0mP_mFQOaQarY+h70mksgiMvnQ8VxKN9CohNZ-Q@mail.gmail.com>
Message-ID: <CAL3q7H7T4QY0mP_mFQOaQarY+h70mksgiMvnQ8VxKN9CohNZ-Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reduce lock contention with not always use keep
 locks when insert extent backref
To: robbieko <robbieko@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 7:39=E2=80=AFAM robbieko <robbieko@synology.com> wr=
ote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When inserting extent backref, in order to check whether
> refs other than inline refs are used, we always use keep
> locks for tree search, which will increase the lock
> contention of extent-tree.

The line length limit is 75, you're using about 50 characters per line.
You can make the lines use more characters which makes things a bit
easier to read.

On the other hand the subject is kind of too long and phrased a bit oddly:

btrfs: reduce lock contention with not always use keep locks when
insert extent backref

I would suggest something like:

btrfs: reduce extent tree lock contention when searching for inline backref

>
> We do not need the parent node every time to determine
> whether normal refs are used.
> It is only needed when the extent-item is the last item in leaf.

in leaf -> in a leaf

>
> Therefore, we change to first use keep_locks=3D0 for search.
> If the extent-item happens to be the last item in leaf,

in leaf -> in the leaf

> we then change to keep_locks=3D1 for the second search to
> slow down lock contention.

slow down -> reduce

>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/extent-tree.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..7d5033b20a40 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -786,6 +786,8 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>         int ret;
>         bool skinny_metadata =3D btrfs_fs_incompat(fs_info, SKINNY_METADA=
TA);
>         int needed;
> +       bool keep_locks =3D false;

There's no need to use this variable, we can use path->keep_locks directly.

> +       struct btrfs_key tmp_key;

Please move the declaration of tmp_key to the block where it's used, see be=
low.

>
>         key.objectid =3D bytenr;
>         key.type =3D BTRFS_EXTENT_ITEM_KEY;
> @@ -795,7 +797,6 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>         if (insert) {
>                 extra_size =3D btrfs_extent_inline_ref_size(want);
>                 path->search_for_extension =3D 1;
> -               path->keep_locks =3D 1;
>         } else
>                 extra_size =3D -1;
>
> @@ -946,6 +947,24 @@ int lookup_inline_extent_backref(struct btrfs_trans_=
handle *trans,
>                         ret =3D -EAGAIN;
>                         goto out;
>                 }
> +
> +               if (path->slots[0] + 1 < btrfs_header_nritems(path->nodes=
[0])) {

Here place the declaration of tmp_key, since it's not used outside this blo=
ck.

Everything else looks good, thanks.

> +                       btrfs_item_key_to_cpu(path->nodes[0], &tmp_key, p=
ath->slots[0] + 1);
> +                       if (tmp_key.objectid =3D=3D bytenr &&
> +                               tmp_key.type < BTRFS_BLOCK_GROUP_ITEM_KEY=
) {
> +                               ret =3D -EAGAIN;
> +                               goto out;
> +                       }
> +                       goto enoent;
> +               }
> +
> +               if (!keep_locks) {
> +                       btrfs_release_path(path);
> +                       path->keep_locks =3D 1;
> +                       keep_locks =3D true;
> +                       goto again;
> +               }
> +
>                 /*
>                  * To add new inline back ref, we have to make sure
>                  * there is no corresponding back ref item.
> @@ -959,13 +978,15 @@ int lookup_inline_extent_backref(struct btrfs_trans=
_handle *trans,
>                         goto out;
>                 }
>         }
> +enoent:
>         *ref_ret =3D (struct btrfs_extent_inline_ref *)ptr;
>  out:
> -       if (insert) {
> +       if (keep_locks) {
>                 path->keep_locks =3D 0;
> -               path->search_for_extension =3D 0;
>                 btrfs_unlock_up_safe(path, 1);
>         }
> +       if (insert)
> +               path->search_for_extension =3D 0;
>         return ret;
>  }
>
> --
> 2.17.1
>
>

