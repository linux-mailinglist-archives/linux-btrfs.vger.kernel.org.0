Return-Path: <linux-btrfs+bounces-19745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448ECBD6FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 12:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81760303BE17
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98CA2848A4;
	Mon, 15 Dec 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9ycHVcE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FA327219
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796415; cv=none; b=f3qap/0AKXH89IhW/2av57RneuIsJEJ+1YBCdYSby4WrlDAnT80M7h6ebctZWPdlj3ZZQG+LG8Wl3XYnTBAhNMySul5XgKbwgD4n9z1IqUm4wX7+1ZFJhBVZ9zXvbvuj9HeuCzRi6MsBNUGQgMxaOJQWJRSgqWhs8L56h/7Qa3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796415; c=relaxed/simple;
	bh=fdQbsxFW9vmOw6OqRw94w2ZzRKIuwohH/cTf6t+sFt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkMLa+E+8zD0CCY9VTg8pbg80TTnhJAVKzCzZgV9xhtOXTVf9w9IJLSy87AMlusUjzVmqzdiwrFK8R3wubvfVX771OAGzT78qNt62tC0rBgicCEqKPqyeTIORkkHcCHyd9H6UAdzCqj/ZFZYdU+3CBhvpoGahqI6jKgnhrOVpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9ycHVcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFDAC4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765796414;
	bh=fdQbsxFW9vmOw6OqRw94w2ZzRKIuwohH/cTf6t+sFt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q9ycHVcE4z8+nCMWgTjXBRt+mCFDvsIKJLN2De1m2YokyBjwebNMsXWba+1SbamrZ
	 Fd0V/UGLn3PYbM3gSpVLjdN9E3jJ5asw7l56tbTj1r4JyB8tLGL3EepMjHqU+U/S+L
	 CVyOV9EkZqh0XrkXsqs3+2/3WaJKatxmGIABBHjMzWWIr3gCCPO7IqEesfbOtwVrJU
	 4EUE2t6JrwCzmuiccIeQmD1uOUeGWMiX4aM2f3co1DBpeK1eoqiq03v2nOpmzwGnc7
	 dwzY1Lz7h2uCjcOwCH8nOvIq/mgT9qeSE+qrtJMPCpNKMTQX6/UT0YRHymdWkb6l8L
	 HY99lQ4Zvm9kA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so559975066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 03:00:14 -0800 (PST)
X-Gm-Message-State: AOJu0YzerbjDEYX11oBkf0njLIjYFC8hIi4jyS7iiEd/AvYbXM9TQDm2
	U1IyYqi4WXH0l9A8Ck2uXWbuNU07or44TnErkyESIhvn+WW8Ho1phdESfIlFuKz1qKssEOJqNvo
	KHFUYkayDrtG3GB9edQgaSFSC+7ZvrVY=
X-Google-Smtp-Source: AGHT+IFgRPI76PIKgCfd+REKLe+2qbOF6gl8ICTJuFpQL1EtlhJGZRkWwQCmykscazInGwhBfxP9iZGZAs6UJ+ZUVGQ=
X-Received: by 2002:a17:907:7292:b0:b73:398c:c5a7 with SMTP id
 a640c23a62f3a-b7d2377554cmr990241866b.41.1765796413003; Mon, 15 Dec 2025
 03:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c89417ac3352ce3cb0a6373a1746155c1e2754d.1765588168.git.loemra.dev@gmail.com>
In-Reply-To: <7c89417ac3352ce3cb0a6373a1746155c1e2754d.1765588168.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Dec 2025 10:59:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4GnjuaYQP9uKW-cC1hqeLXqexxSfzBAtPF-m31E3aKew@mail.gmail.com>
X-Gm-Features: AQt7F2oriUdZ9rmgH8s-Qy_VhQkR9_UYJ9-OHP41LPPgHGa3ncY2Wzp76erIMH8
Message-ID: <CAL3q7H4GnjuaYQP9uKW-cC1hqeLXqexxSfzBAtPF-m31E3aKew@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 1:26=E2=80=AFAM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> Previously, btrfs_get_or_create_delayed_node set the delayed_node's
> refcount before acquiring the root->delayed_nodes lock.
> Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> moved refcount_set inside the critical section, which means there is
> no longer a memory barrier between setting the refcount and setting
> btrfs_inode->delayed_node.
>
> Without that barrier, the stores to node->refs and
> btrfs_inode->delayed_node may become visible out of order. Another
> thread can then read btrfs_inode->delayed_node and attempt to
> increment a refcount that hasn't been set yet, leading to a
> refcounting bug and a use-after-free warning.
>
> The fix is to move refcount_set back to where it was to take
> advantage of the implicit memory barrier provided by lock
> acquisition.
>
> Because the allocations now happen outside of the lock's critical
> section, they can use GFP_NOFS instead of GFP_ATOMIC.
>
> Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.co=
m
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Pushed to for-next, thanks.

> ---
>  fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 364814642a91..8f8ce43d18b8 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_crea=
te_delayed_node(
>                 return ERR_PTR(-ENOMEM);
>         btrfs_init_delayed_node(node, root, ino);
>
> +       /* Cached in the inode and can be accessed. */
> +       refcount_set(&node->refs, 2);
> +       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_NOFS);
> +       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tra=
cker, GFP_NOFS);
> +
>         /* Allocate and reserve the slot, from now it can return a NULL f=
rom xa_load(). */
>         ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> -       if (ret =3D=3D -ENOMEM) {
> -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> -               kmem_cache_free(delayed_node_cache, node);
> -               return ERR_PTR(-ENOMEM);
> -       }
> +       if (ret =3D=3D -ENOMEM)
> +               goto cleanup;
> +
>         xa_lock(&root->delayed_nodes);
>         ptr =3D xa_load(&root->delayed_nodes, ino);
>         if (ptr) {
>                 /* Somebody inserted it, go back and read it. */
>                 xa_unlock(&root->delayed_nodes);
> -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> -               kmem_cache_free(delayed_node_cache, node);
> -               node =3D NULL;
> -               goto again;
> +               goto cleanup;
>         }
>         ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
>         ASSERT(xa_err(ptr) !=3D -EINVAL);
>         ASSERT(xa_err(ptr) !=3D -ENOMEM);
>         ASSERT(ptr =3D=3D NULL);
> -
> -       /* Cached in the inode and can be accessed. */
> -       refcount_set(&node->refs, 2);
> -       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> -       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tra=
cker, GFP_ATOMIC);
> -
>         btrfs_inode->delayed_node =3D node;
>         xa_unlock(&root->delayed_nodes);
>
>         return node;
> +cleanup:
> +       btrfs_delayed_node_ref_tracker_free(node, tracker);
> +       btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_trac=
ker);
> +       btrfs_delayed_node_ref_tracker_dir_exit(node);
> +       kmem_cache_free(delayed_node_cache, node);
> +       if (ret)
> +               return ERR_PTR(ret);
> +       goto again;
>  }
>
>  /*
> --
> 2.47.3
>
>

