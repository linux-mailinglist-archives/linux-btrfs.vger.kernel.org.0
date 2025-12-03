Return-Path: <linux-btrfs+bounces-19480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B94DC9EC4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 250BD4E3749
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346082EE262;
	Wed,  3 Dec 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwGr8GFk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C842DAFBD
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759056; cv=none; b=sjzMcmLh3Cf44J6LV4OA8zSLHISzTWG1SIb4vfjpRSeRFZL7P0DUvdXbu02zCLKgQJTVOgSIy8U1qP1SVKdSB6Li2Zvv2mSvnm0fDHOmllWv63M0wIxyvU6ARliSpUr87puwZhHZfDjosUNqyqRxEhuEB9lFQRjSuN/HVbw+u8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759056; c=relaxed/simple;
	bh=ohHztI+cRImVBcyEucmAp47b0uWH1g3RAyE0B15SbHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOvofOg2vO9urYWB30j/QSXb7BkNg80b3UZjt0iOBngeP/m2c8urBXdNKtyYcIn3CrSLoQnVpInCsDZoetLV/CNgJ58ghXET7Uwd5Va/Qk/cQpg3Z/fqXnkPHcD02AkTmM6LB1SYpj8SPY8QF1tXXzkX6B8CJ+O/2ip28mRnxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwGr8GFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB11C19421
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764759055;
	bh=ohHztI+cRImVBcyEucmAp47b0uWH1g3RAyE0B15SbHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pwGr8GFk8tCDV1IIYtiMWjCaYYFSDY7oQIrSqz8TJYUuQTiChsmpdJrQmJB4nZko0
	 J5Ll/gZEu0ZpxZWFdWpIFaXTmW6IIOr2wRkGc+jlLSwlHpbkLVBzoy0v6YTX7XLR4Q
	 MnzlHNM+VoWo2V8UrPy4DrAqb+RjrcW/Y8mdku6R8xq0VnQ2ecx1qe0FCystotDkPl
	 3+B4lhmCJABC9cICQm6jf1YWNIP+zgmdRyoiB762Mn+L/LHjdwbg44wivQB/tskZnE
	 EoYzhQ7rwWJ1uRks7OHerqEX+tXlNry0qrztOBU1zgJA+j/JyiQVcFBVcPy1mxvMxW
	 dW9pNecyXYaRQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b727f452fffso121935366b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 02:50:55 -0800 (PST)
X-Gm-Message-State: AOJu0YwKeyYIU33ujsFW99AB2ExQrP+iGRzAM5ZIRZcLSrT+ClSgQqY6
	9SR5rxi/8K5qQa8WmwbQr4wAqK0VqHx8nsnpr8JMsUHHZmO+TMD+dqCPP3PD0WVg+AZJ/1ewRCp
	ncORshM+qguE9fBViHw/q0Sp7IetWQjg=
X-Google-Smtp-Source: AGHT+IFDlcqB85f0yS/aB2VpY+J6CJY56N7oLwHGnMyOtVtPdI5QLOHgG7ABg1k6OFgaUiRNQ5sFIaQ3IB7r7y1Ul1U=
X-Received: by 2002:a17:906:794b:b0:b5c:6e0b:3706 with SMTP id
 a640c23a62f3a-b79d61d25aemr269132466b.13.1764759054480; Wed, 03 Dec 2025
 02:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <678e357c7c7f87e6382ba6da048c2af1a3a2e02b.1764696103.git.loemra.dev@gmail.com>
In-Reply-To: <678e357c7c7f87e6382ba6da048c2af1a3a2e02b.1764696103.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Dec 2025 10:50:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6_9wZeTOti72jpM=6iCCpQa-U5pNyekToEq0AfCfWmqQ@mail.gmail.com>
X-Gm-Features: AWmQ_bn4DskkF2MCzwLhBPgUvAPSzU9YAydlzZ82IXHOqn8wH1shl2PRafpd2IU
Message-ID: <CAL3q7H6_9wZeTOti72jpM=6iCCpQa-U5pNyekToEq0AfCfWmqQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:21=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> w=
rote:
>
> Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> refcount before acquiring the root->delayed_nodes lock.
> Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> moves refcount_set inside the critical section which means
> there is no longer a memory barrier between setting the refcount and
> setting btrfs_inode->delayed_node =3D node.
>
> This allows btrfs_get_or_create_delayed_node to set
> btrfs_inode->delayed_node before setting the refcount.
> A different thread is then able to read and increase the refcount
> of btrfs_inode->delayed_node leading to a refcounting bug and
> a use-after-free warning.
>
> The fix is to move refcount_set back to where it was to take
> advantage of the implicit memory barrier provided by lock
> acquisition.
>
> Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.co=
m
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 364814642a91..81922556379d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_crea=
te_delayed_node(
>                 return ERR_PTR(-ENOMEM);
>         btrfs_init_delayed_node(node, root, ino);
>
> +       /* Cached in the inode and can be accessed. */
> +       refcount_set(&node->refs, 2);
> +       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> +       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tra=
cker, GFP_ATOMIC);

Now that we do these allocations outside the spinlock (xarray's lock),
we can stop using GFP_ATOMIC and use GFP_NOFS.

Otherwise it looks good, thanks.

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

