Return-Path: <linux-btrfs+bounces-5905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB8913A2D
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B51F21847
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2024 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADBB17FAC3;
	Sun, 23 Jun 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEaX1Zi7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CC17FAB6
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143532; cv=none; b=VJfRsse2Kr2xrNckfVLbz9PlCeNMxBlxucojNQV43cOpA7DgbNoAeYZsY/T8uiXedAEtB5hmb9LZ6RN2MXVHxk5X4V48qZ7sWH8xHcwvIqHbYOPRY+n1DfMc8/L6kUMv1H8UOJl9vX6cbG0r5/YJVcG5D7gWcZfmiobU0AXnqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143532; c=relaxed/simple;
	bh=Mr9d9F09t7aJRbYLzJpM3aR2adQt3IMidqjCqkQu5bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8DFu8eFpJ2j2wgTQUpxoAJfRU7HcEQYFyPRlj1leBNKsQ+/ctqnSvlO2GowDK55X1u2+cBWm4C2FmhMnvD1wr11W9JnTmI5RXtLkWcre4hcqERL9G7qbRVz0Pg+1C0JIXbWWfxgicNGvqvjVIheRCEVKhXpzhqGPpizLftchv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEaX1Zi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A20C32782
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719143531;
	bh=Mr9d9F09t7aJRbYLzJpM3aR2adQt3IMidqjCqkQu5bY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GEaX1Zi72amEKPCiL3TqrA7vc62ysGEg+Pwa+yQnNuA5LOAjwicpHLit4iEb7I1yu
	 V61byaphfy5nVbRV9DmvHKLRFdlufA6kuII3RJ06AO7GM2HE0aatri26gCZqGh9IP+
	 qnkU6whWo94EQnFjWjyWcD7XFJXDwrKJm2yNSr69x91f66Ek4dfo5MY67uwy7w43SS
	 Fh6kgw/aiYEZqQ8RXo2DmT+UDBL60Ies7WsKe7tQ/QGvkdEEwF0Vt+jrzXBF9WxO6v
	 xxfCMu7aVTj32oQBMwSvZ97uJ4S/19MlrnJQ1LPJU9eqlsKf46M7UpW1MBLyFPbsTR
	 ZKZ8gWCH75yfw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso49232801fa.1
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2024 04:52:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YxL5RHFRyu9cg5Xb7ao47O/fOEGzzAu2/RIh4RHk/8ippW4UpXM
	fjWviC79l0qVWflSEc7N97yY5u5HTFQx2yMyD4tlLUVGdqLTJx2upnxtSza4qxINYy3Kh3OLz8P
	BmGPtHygbg5hdQc8Cst8hUSdljBs=
X-Google-Smtp-Source: AGHT+IGl80nYJCDuHnbGUAs/55fpHQLjvX7dwG01XIhiq/WStokjWj2KsMT5o2oI6vTbPuzpw1WqdXCjd6UUBTrQYA4=
X-Received: by 2002:a2e:9590:0:b0:2ec:550e:24f5 with SMTP id
 38308e7fff4ca-2ec5b2c4dc8mr14227021fa.8.1719143529918; Sun, 23 Jun 2024
 04:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
In-Reply-To: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 23 Jun 2024 12:51:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H50CCpzN068YB4TdW1-8NOgWCgcsUN+WP5gMBxZ==c9kw@mail.gmail.com>
Message-ID: <CAL3q7H50CCpzN068YB4TdW1-8NOgWCgcsUN+WP5gMBxZ==c9kw@mail.gmail.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

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

