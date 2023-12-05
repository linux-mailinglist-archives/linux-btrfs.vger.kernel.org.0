Return-Path: <linux-btrfs+bounces-669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF32805EBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC23281F6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC516ABA4;
	Tue,  5 Dec 2023 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7pfo2vf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F06AB85
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 19:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDCC433C8
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701805221;
	bh=U4+0J7BG7gdEBLkGrYyiOgc29bJtoQawcvf84e1DziI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B7pfo2vfQ+NP6EF6cKrah7hWJnUQl7OqyrhXqygmnlgaMjQ93pBCWVBYuoHaVPyJn
	 Wh1lD0wvJ2FdsCmQ7Dd2woBWFiCl0jJcszmFPTj4Qcl9djn4sOuXTfysuleqB7GsF8
	 8PwS4BxNXoMQ5OB9PcjNOmFyBuFFK+hUM8EbaEkyrsA/sq8IKPh/bb3V4RfphgeSFN
	 PJknMf0a4zyxMgqoN3EwClaoKOeP7qXvdDzofDMBQv0TGbtYIshiss22s1Uq4aE0WR
	 I07je9yVGmlhK2Sfcw9EV+sXxFM+O/PijymDpR9veKPWMV81oQMQumirBwQsLnVf0d
	 mnRI2ZtrOyvaA==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c09dfa03cso30963965e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Dec 2023 11:40:21 -0800 (PST)
X-Gm-Message-State: AOJu0YzBDx23t+ZiNBolzrE8tDbZloYm5uUYFBavVbExIlncGSRYraHj
	gLKkIme0flhlqBvfDhuUQQ/M5l1vcDwHPSVx6IM=
X-Google-Smtp-Source: AGHT+IGwAfVcuAYoPk6pcQakHDnRAzRFqRAs+XRYvktN26mv/UCdVQfEBGX9k0/3NxupRTOELOLXbzE/5iMoaItd8q4=
X-Received: by 2002:a05:600c:3ac7:b0:40b:5e59:c585 with SMTP id
 d7-20020a05600c3ac700b0040b5e59c585mr881598wms.175.1701805220032; Tue, 05 Dec
 2023 11:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701384168.git.dsterba@suse.com> <e283f8d460c7b3288e8eb1d8974d6b5842210167.1701384168.git.dsterba@suse.com>
 <CAL3q7H7a0nu8xa6dNZeBzzez1D3e8dr2tUkOcaUNNnPbFJ_YLA@mail.gmail.com>
 <20231204154934.GA2205@twin.jikos.cz> <20231204160731.GB2205@twin.jikos.cz> <20231205190459.GQ2751@twin.jikos.cz>
In-Reply-To: <20231205190459.GQ2751@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Dec 2023 19:39:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4XuCHo66yrViMWnuySAVn-8k-OGdQc65Pn7wsjqcXu0g@mail.gmail.com>
Message-ID: <CAL3q7H4XuCHo66yrViMWnuySAVn-8k-OGdQc65Pn7wsjqcXu0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: use xarray for btrfs_root::delayed_nodes_tree
 instead of radix-tree
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:11=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Dec 04, 2023 at 05:07:31PM +0100, David Sterba wrote:
> > On Mon, Dec 04, 2023 at 04:49:34PM +0100, David Sterba wrote:
> > > On Fri, Dec 01, 2023 at 11:03:25AM +0000, Filipe Manana wrote:
> > > > On Thu, Nov 30, 2023 at 10:56=E2=80=AFPM David Sterba <dsterba@suse=
.com> wrote:
>
> > It the lock conversion would not be the right way, the xa_reserve can b=
e
> > done but it it's not as simple as the preload, it inserts a reserved
> > entry to the tree which is NULL upon read so we'd have to handle that
> > everywhere.
>
> Seems that xa_reserve can emulate the preload. It takes the GFP flags
> and will insert a reserved entry, btrfs_get_delayed_node() expects a
> NULL and there's no other xa_load() except
> btrfs_get_or_create_delayed_node() that's doing the insert.
>
> The insertion is done to the reserved slot by xa_store() and serialized
> by the spin lock, the slot reservation can race, xarray handles that.
> xa_store() also takes the GFP flags but they should not be needed.
>
> I'm running the code below with manual error injection (xa_reserve()
> fails every 100th time), so far fstests continue, reporting either
> enomem or transaction aborts.

Oh, that's perfect and seems very promising. Thanks.

>
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -122,6 +122,8 @@ static struct btrfs_delayed_node *btrfs_get_or_create=
_delayed_node(
>         int ret;
>
>         do {
> +               void *ptr;
> +
>                 node =3D btrfs_get_delayed_node(btrfs_inode);
>                 if (node)
>                         return node;
> @@ -134,15 +136,25 @@ static struct btrfs_delayed_node *btrfs_get_or_crea=
te_delayed_node(
>                 /* Cached in the inode and can be accessed. */
>                 refcount_set(&node->refs, 2);
>
> +               ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> +               if (ret =3D=3D -ENOMEM) {
> +                       kmem_cache_free(delayed_node_cache, node);
> +                       return ERR_PTR(-ENOMEM);
> +               }
>                 spin_lock(&root->inode_lock);
> -               ret =3D xa_insert(&root->delayed_nodes, ino, node, GFP_AT=
OMIC);
> -               if (ret < 0) {
> +               ptr =3D xa_load(&root->delayed_nodes, ino);
> +               if (ptr) {
> +                       /* Somebody inserted it. */
>                         spin_unlock(&root->inode_lock);
>                         kmem_cache_free(delayed_node_cache, node);
> -                       if (ret !=3D -EBUSY)
> -                               return ERR_PTR(ret);
> -                       /* Otherwise it's ENOMEM. */
> +                       ret =3D -EEXIST;
> +                       continue;
>                 }
> +               ptr =3D xa_store(&root->delayed_nodes, ino, node, GFP_ATO=
MIC);
> +               ASSERT(xa_err(ptr) !=3D -EINVAL);
> +               ASSERT(xa_err(ptr) !=3D -ENOMEM);
> +               ASSERT(ptr =3D=3D NULL);
> +               ret =3D 0;
>         } while (ret < 0);
>         btrfs_inode->delayed_node =3D node;
>         spin_unlock(&root->inode_lock);

