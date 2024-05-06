Return-Path: <linux-btrfs+bounces-4775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D158BCED9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 15:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7784D1C222C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80A7603A;
	Mon,  6 May 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEDI6/HN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279415A5
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001635; cv=none; b=kUbHIL22jh6wXZHWS4uH8Fc2xxN6YI/3wAFx1NOwv7pAc9AD/YeUQNlUJnCSL2S2jzy5qPO9VyaP2KGBFrbH095awd3oGOaqA4598VpmDZuVlujY3+m6Si6ENY7WBlDEZAouOnBbgut+kX/YPsUWggAQ4v/JDlN1mEPLzEVY2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001635; c=relaxed/simple;
	bh=aFBxkDV7hcWa0dMmGzYsvp1/AJZUTxLnqJDlBDZCd4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD4Qoypfi4YsTM4U7DPBmY5Wh/qVL+WnLmndMsAWrLoNKBxdZnajmKB8nC7X2++sHLX7OSx/wzPNjKGhFoFIs/Xagtvdk2IbMk1/v5RHxLcoiFrIblrcSRQXDgXjkU7wtTk4uUMG3osaXYm4yPNK+OdUmkG232zz8HVzJFkOQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEDI6/HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FC1C4AF63
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715001634;
	bh=aFBxkDV7hcWa0dMmGzYsvp1/AJZUTxLnqJDlBDZCd4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pEDI6/HNUFHZTLcYlGPT1FSlNz4nG3zh11FuBJL1WR698SwUVwABzR3XVTdCcaGjY
	 m6mNc91BhKhY6F/+c1rhFB9qioBMLQezksBRE2l7qcF3dtfVVyZkFbuocana+QSAuo
	 hwFkX2knBZg4WNDGuae6Z5wgAahSIO3AJO76HXUcdlaB8HteDf8Ql1qZUiFS8OyxSH
	 MujIDIbUzG1cCw4wGIfV+6702Iea/a/VW6qeD9waDunvqr3gqQq8VS+EwMgvZC3S/k
	 IQR3sFg367PYUsOpn8FRZR/rxITyHM5lKQKCZdX8uggCd9w4oCZW6j2ZAT8i+sgARy
	 UU9/YrgKzMBPw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59cf8140d0so194753066b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 May 2024 06:20:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwVYqPqkXsEQIiSN6QBwxyl0cG1NOmz7+mCGR0CmK6gUYSh25I0
	b9flNNdBnm3LvDA+qyd/BV3ustqI+T7DhPYsaoisxFDDAWM0scDpe4BbSKmtDCEFF1QJOaZi3LF
	heapbzrKht9dCDIKETO8j0FNLD1E=
X-Google-Smtp-Source: AGHT+IElkxmuKk4jk5+dH1X1hl0td9SEtDc+zy6yLsIhHEZ6zli0iQ4I7hP9FOlVjcpNWk1BR/lnM9TOBa6qH/c5CSw=
X-Received: by 2002:a17:906:af91:b0:a59:9ef3:f6df with SMTP id
 mj17-20020a170906af9100b00a599ef3f6dfmr5038929ejb.22.1715001633004; Mon, 06
 May 2024 06:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2454cd4eb1694d37056e492af32b23743c63202b.1714663442.git.jth@kernel.org>
In-Reply-To: <2454cd4eb1694d37056e492af32b23743c63202b.1714663442.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 6 May 2024 14:19:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7m_Sy4Hwt6T_QymN7mBjE2bNZ-i6SP=1JFgwCLjwPRQA@mail.gmail.com>
Message-ID: <CAL3q7H7m_Sy4Hwt6T_QymN7mBjE2bNZ-i6SP=1JFgwCLjwPRQA@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:35=E2=80=AFAM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().
>
> It is only needed to protect
> a) calls to find_live_mirror() and
> b) calling into handle_ops_on_dev_replace().
>
> But there is no need to hold the rwsem for any kind of set_io_stripe()
> calls.
>
> So relax taking the dev_replace rwsem to only protect both cases and chec=
k
> if the device replace status has changed in the meantime, for which we ha=
ve
> to re-do the find_live_mirror() calls.
>
> This fixes a deadlock on raid-stripe-tree where device replace performs a
> scrub operation, which in turn calls into btrfs_map_block() to find the
> physical location of the block.

Do you have a stack trace you can paste to the changelog?
That helps make it more clear and greppable.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a3dc88e420d1..3a842b9960b2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6649,14 +6649,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>         *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
>
> +again:
>         down_read(&dev_replace->rwsem);
>         dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_repla=
ce);
> -       /*
> -        * Hold the semaphore for read during the whole operation, write =
is
> -        * requested at commit time but must wait.
> -        */
> -       if (!dev_replace_is_ongoing)
> -               up_read(&dev_replace->rwsem);
>
>         switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>         case BTRFS_BLOCK_GROUP_RAID0:
> @@ -6689,6 +6684,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                 map_blocks_single(map, &io_geom);
>                 break;
>         }
> +
> +       up_read(&dev_replace->rwsem);
> +
>         if (io_geom.stripe_index >=3D map->num_stripes) {
>                 btrfs_crit(fs_info,
>                            "stripe index math went horribly wrong, got st=
ripe_index=3D%u, num_stripes=3D%u",
> @@ -6784,10 +6782,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>         if (op !=3D BTRFS_MAP_READ)
>                 io_geom.max_errors =3D btrfs_chunk_max_errors(map);
>
> +       /*
> +        * Check if something changed the dev_replace state since
> +        * we've checked it for the last time and if redo the whole
> +        * mapping operation.
> +        */
> +       down_read(&dev_replace->rwsem);
> +       if (!dev_replace_is_ongoing &&
> +           btrfs_dev_replace_is_ongoing(dev_replace)) {
> +               up_read(&dev_replace->rwsem);
> +               goto again;

What about the case where we found device replace was running but it's
not running anymore?
I would change the if condition to:  if (dev_replace_is_ongoing !=3D
btrfs_dev_replace_is_ongoing(dev_replace))

> +       }
> +       up_read(&dev_replace->rwsem);
> +
>         if (dev_replace_is_ongoing && dev_replace->tgtdev !=3D NULL &&

So here we also need to be under the protection of the rwsem before
checking ->tgtdev.
The device replace might finish just after the check, and then we call
handle_ops_on_dev_replace() and use a NULL tgtdev which is not
expected.

Why not remove the up_read() right above, and...

>             op !=3D BTRFS_MAP_READ) {
> +               down_read(&dev_replace->rwsem);
>                 handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
>                                           &io_geom.num_stripes, &io_geom.=
max_errors);
> +               up_read(&dev_replace->rwsem);

Stop doing here the down_read() + up_read().

>         }

And then do the up_read() here.

Thanks.

>
>         *bioc_ret =3D bioc;
> @@ -6796,11 +6809,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         bioc->mirror_num =3D io_geom.mirror_num;
>
>  out:
> -       if (dev_replace_is_ongoing) {
> -               lockdep_assert_held(&dev_replace->rwsem);
> -               /* Unlock and let waiting writers proceed */
> -               up_read(&dev_replace->rwsem);
> -       }
>         btrfs_free_chunk_map(map);
>         return ret;
>  }
> --
> 2.35.3
>
>

