Return-Path: <linux-btrfs+bounces-5906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8896913A71
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F252F1C20928
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882E12FF71;
	Sun, 23 Jun 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL6TKZ24"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162E2BB12
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144970; cv=none; b=Zhv7XmsnZhWVp0rCXYWI6CuNpXdRIlM9pyZXA+4cRZO02lREWNmUxA7Cqc8uFkuZscKsn6ivkriRO8DYD6FF1w79GSXAhuNvkFDpboHWGEn8Ym28jidZug+Q5OxB89FBd0LxCizoMCrT9l/Tiu5bH8Apg4KmI78V/SYVP4yR1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144970; c=relaxed/simple;
	bh=SyePcXaog4FKFgi5bKCMSWmNDMwvP33YIfF4wszhiXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkYlM7j8+71qc81X46/jmQ/yqIDB8s3vJR3jLtDRnq70ny7UA8Hr9COLr4qjdS0IdR2MMjfj1fWun3R3HK7hHz+GfvP4LNLIwG1dpSyHf8RKrn8JgVx57IkPCPvN0IuaB9uUwf/h4FvhH+CDe0NxnnAy19zGuPRhaWAlMeBhGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL6TKZ24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D89AC4AF09
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144970;
	bh=SyePcXaog4FKFgi5bKCMSWmNDMwvP33YIfF4wszhiXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KL6TKZ24UlT4/m0xaHJP0aqJ2k3VI7f3Y3f1/tOliq89ZSFYzH1+ZQD8b5YiQ67Ue
	 HQz+hdUchVI014DmOiDbE138kVgUcA7EYeFAisW9NBtt8C6BchaY4ERx52VFXbxAYJ
	 rzacZDJoTfhDtKP/FwFrq2EXz0xW2QS1aMBref59ZHidi3iq/1Unl3pnsCSPKdSSZv
	 KSSakMMxg6Tsi2FJEgywG1zcim8s8tgpeEIMh5JefuSwDVgK9I4HTcpNCFPeJXjsOz
	 o7cNI0aJNaCnqCVus/5rZl/JNOCFWRCrmtf7u2/+xCrvLW/yFP4XW1/+NSA2VAhzBp
	 NKOL6b7k7FU3g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so7257072a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 05:16:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YzzrszUhj+7AZF75BM4W2SHGk1SnNG9+TgwTPVb207kiuYhNBB6
	AjpCq6MrlGWRfVNR4WbfhZunrgLm0UpCIjG6MfzPYfuhZVydHQZFbTGarqXiDH74aoF9B8lEmqU
	Sx7Uqw5VD8EhQyzu/x6enVfxHMwg=
X-Google-Smtp-Source: AGHT+IHXqhDRkt9lZHgzg+PIqaxF8zECnI0LrwLo6rQ2rQ9QhQusOOREvX7O2bVVyy0WrNS4rHYjqqQ3AkgmHiLLeRs=
X-Received: by 2002:a17:906:c786:b0:a6f:8e53:e981 with SMTP id
 a640c23a62f3a-a7038609040mr190101066b.34.1719144968664; Sun, 23 Jun 2024
 05:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
In-Reply-To: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 23 Jun 2024 13:15:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H72qeAGqDEFgf1NLY2j3V3izfQ4bvVHP+ptGb69Y8GvLA@mail.gmail.com>
Message-ID: <CAL3q7H72qeAGqDEFgf1NLY2j3V3izfQ4bvVHP+ptGb69Y8GvLA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: preallocate ulist memory for qgroup rsv
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:41=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> When qgroups are enabled, during data reservation, we allocate the
> ulist_nodes that track the exact reserved extents with GFP_ATOMIC
> unconditionally. This is unnecessary, and we can follow the model
> already employed by the struct extent_state we preallocate in the non
> qgroups case, which should reduce the risk of allocation failures with
> GFP_ATOMIC.
>
> Add a prealloc node to struct ulist which ulist_add will grab when it is
> present, and try to allocate it before taking the tree lock while we can
> still take advantage of a less strict gfp mask. The lifetime of that
> node belongs to the new prealloc field, until it is used, at which point
> it belongs to the ulist linked list.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent-io-tree.c |  4 ++++
>  fs/btrfs/extent_io.h      |  5 +++++
>  fs/btrfs/ulist.c          | 21 ++++++++++++++++++---
>  fs/btrfs/ulist.h          |  2 ++
>  4 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index ed2cfc3d5d8a..c54c5d7a5cd5 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -4,6 +4,7 @@
>  #include <trace/events/btrfs.h>
>  #include "messages.h"
>  #include "ctree.h"
> +#include "extent_io.h"
>  #include "extent-io-tree.h"
>  #include "btrfs_inode.h"
>
> @@ -1084,6 +1085,9 @@ static int __set_extent_bit(struct extent_io_tree *=
tree, u64 start, u64 end,
>                  */
>                 prealloc =3D alloc_extent_state(mask);
>         }
> +       /* Optimistically preallocate the extent changeset ulist node. */
> +       if (changeset)
> +               extent_changeset_prealloc(changeset, mask);
>
>         spin_lock(&tree->lock);
>         if (cached_state && *cached_state) {
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 96c6bbdcd5d6..8b33cfea6b75 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -215,6 +215,11 @@ static inline struct extent_changeset *extent_change=
set_alloc(void)
>         return ret;
>  }
>
> +static inline void extent_changeset_prealloc(struct extent_changeset *ch=
angeset, gfp_t gfp_mask)
> +{
> +       ulist_prealloc(&changeset->range_changed, gfp_mask);
> +}
> +
>  static inline void extent_changeset_release(struct extent_changeset *cha=
ngeset)
>  {
>         if (!changeset)
> diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> index 183863f4bfa4..f35d3e93996b 100644
> --- a/fs/btrfs/ulist.c
> +++ b/fs/btrfs/ulist.c
> @@ -50,6 +50,7 @@ void ulist_init(struct ulist *ulist)
>         INIT_LIST_HEAD(&ulist->nodes);
>         ulist->root =3D RB_ROOT;
>         ulist->nnodes =3D 0;
> +       ulist->prealloc =3D NULL;
>  }
>
>  /*
> @@ -68,6 +69,8 @@ void ulist_release(struct ulist *ulist)
>         list_for_each_entry_safe(node, next, &ulist->nodes, list) {
>                 kfree(node);
>         }
> +       kfree(ulist->prealloc);
> +       ulist->prealloc =3D NULL;
>         ulist->root =3D RB_ROOT;
>         INIT_LIST_HEAD(&ulist->nodes);
>  }
> @@ -105,6 +108,12 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
>         return ulist;
>  }
>
> +void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> +{
> +       if (ulist && !ulist->prealloc)

Btw, why the non-NULL ulist check?
There are no callers that pass a NULL ulist, and that pattern/check is
only used for free functions.

Otherwise it looks fine. Thanks.


> +               ulist->prealloc =3D kzalloc(sizeof(*ulist->prealloc), gfp=
_mask);
> +}
> +
>  /*
>   * Free dynamically allocated ulist.
>   *
> @@ -206,9 +215,15 @@ int ulist_add_merge(struct ulist *ulist, u64 val, u6=
4 aux,
>                         *old_aux =3D node->aux;
>                 return 0;
>         }
> -       node =3D kmalloc(sizeof(*node), gfp_mask);
> -       if (!node)
> -               return -ENOMEM;
> +
> +       if (ulist->prealloc) {
> +               node =3D ulist->prealloc;
> +               ulist->prealloc =3D NULL;
> +       } else {
> +               node =3D kmalloc(sizeof(*node), gfp_mask);
> +               if (!node)
> +                       return -ENOMEM;
> +       }
>
>         node->val =3D val;
>         node->aux =3D aux;
> diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
> index 8e200fe1a2dd..c62a372f1462 100644
> --- a/fs/btrfs/ulist.h
> +++ b/fs/btrfs/ulist.h
> @@ -41,12 +41,14 @@ struct ulist {
>
>         struct list_head nodes;
>         struct rb_root root;
> +       struct ulist_node *prealloc;
>  };
>
>  void ulist_init(struct ulist *ulist);
>  void ulist_release(struct ulist *ulist);
>  void ulist_reinit(struct ulist *ulist);
>  struct ulist *ulist_alloc(gfp_t gfp_mask);
> +void ulist_prealloc(struct ulist *ulist, gfp_t mask);
>  void ulist_free(struct ulist *ulist);
>  int ulist_add(struct ulist *ulist, u64 val, u64 aux, gfp_t gfp_mask);
>  int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
> --
> 2.45.2
>
>

