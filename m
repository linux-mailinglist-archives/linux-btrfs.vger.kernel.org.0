Return-Path: <linux-btrfs+bounces-10467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C099F4662
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC37188774D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC51DED4E;
	Tue, 17 Dec 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1X99q8k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1651DD9D1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425149; cv=none; b=Ue7hqBm6WLOz4SJ6nPzds3lOZan3YMe+4QbMTVqulmYb3TvRWSKxODb5oBQq4h8eF3bjI3pSAk/TpK+PfVRiyfGoHCLjVZex3dNKYdHdz2Mm5FoakWXMVDu77XuNgnEOo/jgATiOx2cnnSoff8u7K4Q9p5ZrGDk+EArlD8Rx6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425149; c=relaxed/simple;
	bh=AKpnzysVNICFFGrqz8YjaQeif0dAdrwqGAl0AlY8L8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thrG3Au9ccRd4WKUSHvTomzNbEmitw7AwBfpaSoz8uad7r1E8EiKef6AlYl1jLuK7GeKDmtXV8gvGjLo+E8Romad+Y7GcXzE1PRl61txKZbu8eBTPJDXOsCt0KStaSw4Z6DegGFnJnQhv9Joe5kw6UiRl9CMfiCtsxzd8eVYOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1X99q8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32FEC4CED7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425148;
	bh=AKpnzysVNICFFGrqz8YjaQeif0dAdrwqGAl0AlY8L8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W1X99q8kGukPDQ3QW/6NjenhHDZJmZAyzT351QK9uL3hEOTvvMl2xI0wmf9oN/7Ws
	 vykdHaZAPmsjszP7Lviri2fHod3JeIVfBHx7pFJqLffR/kijYS2TyqUq93V4Gt1VC7
	 AQ4EJb+sk0vhtplA6m6vtLJSJPuQQpI9AThNCArd8jMBHCEhE5g/v/6uUTxUaPKfBJ
	 r2luGDcUl0AHlFhT/RkVzBWbLeAYxnXsQ74w9pq6GrhNDgmVc2Hrak9xr42NuwcQGW
	 XnV4ZkEsXFbQMhmZAQ5sEXgAQGRsUjVrnQ5+67OgjP0u7lUt4DREJ3BotJxS0viZym
	 sgPYPNU4nK3wQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6a92f863cso1007799766b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 00:45:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yz7PoXMbOL0j0RPoqhBNJATvtMe7ET4j46jTfbz/3dIr9bT6WMr
	ikNTsVdzDZ8LUcS3fwBk0GRBLhUWtEHp+k1UiNQhfBdLS4SfYQYXf8Ys5fqORlFz24tjo69EdMI
	dyGc7s0SwJIflxFUwrnKCNJerIMc=
X-Google-Smtp-Source: AGHT+IFUNx6AHi1Sgp0Kk9mwrL+ICij9bAVu9EY+VZb7cj1r/EOzYKLuDgWmEBSmLYSxENZzelD5c3k+9z0p4N1QjK8=
X-Received: by 2002:a17:906:8ce:b0:aa6:abb2:be12 with SMTP id
 a640c23a62f3a-aab77e7b8e7mr1233026566b.37.1734425147272; Tue, 17 Dec 2024
 00:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
In-Reply-To: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 08:45:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
Message-ID: <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: handle free space tree rebuild in multiple transactions
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> During free space tree rebuild, we're holding on transaction handler for
> the whole rebuild process.
>
> This will cause blocked task warning for btrfs-transaction kernel
> thread, as during the rebuild, btrfs-transaction kthread has to wait for
> the running transaction we're holding for free space tree rebuild.

Do you have a stack trace?
Does that happen where exactly, in the btrfs_attach_transaction() call
chain, while waiting on a wait queue?

>
> On a large enough btrfs, we have thousands of block groups to go
> through, thus it will definitely take over 120s and trigger the blocked
> task warning.
>
> Fix the problem by handling 32 block groups in one transaction, and end
> the transaction when we hit the 32 block groups threshold.
>
> This will allow the btrfs-transaction kthread to commit the transaction
> when needed.
>
> And even if during the rebuild the system lost its power, we are still
> fine as we didn't set FREE_SPACE_TREE_VALID flag, thus on next RW mount
> we will still rebuild the tree, without utilizing the half built one.

What about if a crash happens and we already processed some block
groups and the transaction got committed?

On the next mount, when we call populate_free_space_tree() for the
same block groups, because we always start from the first one, won't
we get an -EEXIST and fail the mount?
For example, add_new_free_space_info() doesn't ignore an -EEXIST when
it calls btrfs_insert_empty_item(), so we will fail the mount when
trying to build the tree.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/free-space-tree.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 7ba50e133921..d8f334724092 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1312,6 +1312,8 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_in=
fo *fs_info)
>         return btrfs_commit_transaction(trans);
>  }
>
> +/* How many block groups can be handled in one transaction. */
> +#define FREE_SPACE_TREE_REBUILD_BATCH  (32)
>  int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)

Please put a blank line after the macro declaration and place the
macro at the top of the file before the C code.

>  {
>         struct btrfs_trans_handle *trans;
> @@ -1322,6 +1324,7 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_i=
nfo *fs_info)
>         };
>         struct btrfs_root *free_space_root =3D btrfs_global_root(fs_info,=
 &key);
>         struct rb_node *node;
> +       unsigned int handled =3D 0;
>         int ret;
>
>         trans =3D btrfs_start_transaction(free_space_root, 1);
> @@ -1350,6 +1353,15 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_=
info *fs_info)
>                         btrfs_end_transaction(trans);
>                         return ret;
>                 }
> +               handled++;
> +               handled %=3D FREE_SPACE_TREE_REBUILD_BATCH;
> +               if (!handled) {
> +                       btrfs_end_transaction(trans);
> +                       trans =3D btrfs_start_transaction(free_space_root=
,
> +                                       FREE_SPACE_TREE_REBUILD_BATCH);

This is a fundamental change here, we are no longer reserving 1 unit
but 32 instead.
Plus the first call to btrfs_start_transaction(), before entering the
loop, uses 1.
For consistency, both places should reserve the same amount.

But I think that changing the amount of reserved space should be a
separate change with its own changelog,
providing a rationale for it.

It's odd indeed that only 1 item is being reserved, but on the other
hand the block reserve associated with the free space tree root is the
delayed refs reserve (see btrfs_init_root_block_rsv()),
so changing the number of units passed to btrfs_start_transaction()
shouldn't make much difference because the space reserved by a
transaction goes to the transaction block reserve
(fs_info->trans_block_rsv).

And given that free space tree build/rebuild only touches the free
space tree root, I don't see how that makes any difference, or at
least it's not trivial, hence the separate change only for the space
reservation
amount and an explanation about why we are doing it.

Thanks.


> +                       if (IS_ERR(trans))
> +                               return PTR_ERR(trans);
> +               }
>                 node =3D rb_next(node);
>         }
>
> --
> 2.47.1
>
>

