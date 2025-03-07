Return-Path: <linux-btrfs+bounces-12096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F42A56A4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835E1189B0B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3290C21C179;
	Fri,  7 Mar 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9TpBsys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E821C16D
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357513; cv=none; b=ujJYAs2bnF1BXhlprjwNcWmuwR10J+9e0B62BVTRqchsAzn2Oe4qcF3uhI0HdkoKE9p/LeTdXju5B6WjHybhlWVXiRH0V8pims33gyMOzKpwGuEs63Wb0N2msqmu7+mdvfAumPAxoCMOoI4ZAv7EWlwOC0dmJpjKeSwxkRmxIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357513; c=relaxed/simple;
	bh=4rT0dUL0Cb0LUnRezDEPJcvIAQt2q9tS0++I/d6XcKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV3IjmCcR1nGrvPk8qm0kt9zn+d69mTJBgKoofpNrEfVIzkZIpbxfIaBG206ia7V/adCEczapN9GxAj4OzyGvOCZl5gxj/AWlk2/9ckp3ZgbhpfSTHzq5mRctH7tAa/Rz3/4PoBwK2EW+t2vs/GX2J7zsjQQpIBzwOMuAk9IhAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9TpBsys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D558EC4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741357512;
	bh=4rT0dUL0Cb0LUnRezDEPJcvIAQt2q9tS0++I/d6XcKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d9TpBsys1nksQNw5WKO8HYmssf75YeAY2z5aXpIHmUYr61BYectVWaRgRAnGejGap
	 5m3HqMzJcr6JCtDi06zKGMZDgTusHhosArciU6Ny5yEiPjx699cabdMGPLhRaGy0Qd
	 RawuA4/jRtPc8HSSpbCTr2GjfQeRcBWA0v6lG0w4TZp0PJItRkKjR63ASwvLLj5/vP
	 ho5rog7ptdOP94s0XwgtQsPf+5XeIdilQzuKaGJWjio/dYrba5d1Wr44Ba0EKOjQLa
	 Bkl3dqepqC7RjQCbf3qIrViMyF6Ul7Ov6rVg3um9LYzQ/4DGRr8DkI/e+gAWz1DvoT
	 8V5XuzTwGRLQA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac202264f9cso358222866b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 06:25:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7AC+n1wgzIYB/hNQ5EtPfgX9UMupumIpI/wJKJWTpOOgDzSjY
	mM8yb8c5xenhFQUoayUz+gio8yDnfFE2jBvwnoMLZfczn4dkEiBBJuGTuxDaY3e1fcHd8gjanR1
	kfSvv48H2OLXm08Ki0XFsjUMhBeg=
X-Google-Smtp-Source: AGHT+IEbLwfz/iZZpXcdrzDuSSGqRgaBWC3/fvIj6QoCpvh+ZvCc5dhkLb1IIKMx0bUXw+kX2/+gvZVbGOzt/HNJvWE=
X-Received: by 2002:a17:907:2d12:b0:ac1:da0c:f668 with SMTP id
 a640c23a62f3a-ac252f4b179mr370447066b.43.1741357511304; Fri, 07 Mar 2025
 06:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
In-Reply-To: <8ba94e9758ff9d5278ed86fcff2acdd429d5deee.1741306938.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 14:24:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H49V0cbzx0sW__5AY0ZyXnPq15f6eNTa0kGJHvNZEbyOQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpWdmhms1EONaHodfY8ni6JACs-JRAFC1-f2H9uJU6XLWyv3rGGmb-XzOU
Message-ID: <CAL3q7H49V0cbzx0sW__5AY0ZyXnPq15f6eNTa0kGJHvNZEbyOQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: fix bg->bg_list list_del refcount races
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> If there is any chance at all of racing with mark_bg_unused, better safe
> than sorry.
>
> Otherwise we risk the following interleaving (bg_list refcount in parens)
>
> T1 (some random op)                         T2 (mark_bg_unused)

mark_bg_unused -> btrfs_mark_bg_unused

Please use complete names everywhere.

>                                         !list_empty(&bg->bg_list); (1)
> list_del_init(&bg->bg_list); (1)
>                                         list_move_tail (1)
> btrfs_put_block_group (0)
>                                         btrfs_delete_unused_bgs
>                                              bg =3D list_first_entry
>                                              list_del_init(&bg->bg_list);
>                                              btrfs_put_block_group(bg); (=
-1)
>
> Ultimately, this results in a broken ref count that hits zero one deref
> early and the real final deref underflows the refcount, resulting in a WA=
RNING.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent-tree.c | 3 +++
>  fs/btrfs/transaction.c | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5de1a1293c93..80560065cc1b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2868,7 +2868,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_=
handle *trans)
>                                                    block_group->length,
>                                                    &trimmed);
>
> +               spin_lock(&fs_info->unused_bgs_lock);
>                 list_del_init(&block_group->bg_list);
> +               spin_unlock(&fs_info->unused_bgs_lock);

This shouldn't need the lock, because block groups added to the
transaction->deleted_bgs list were made RO only before at
btrfs_delete_unused_bgs().

> +
>                 btrfs_unfreeze_block_group(block_group);
>                 btrfs_put_block_group(block_group);
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index db8fe291d010..c98a8efd1bea 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -160,7 +160,9 @@ void btrfs_put_transaction(struct btrfs_transaction *=
transaction)
>                         cache =3D list_first_entry(&transaction->deleted_=
bgs,
>                                                  struct btrfs_block_group=
,
>                                                  bg_list);
> +                       spin_lock(&transaction->fs_info->unused_bgs_lock)=
;
>                         list_del_init(&cache->bg_list);
> +                       spin_unlock(&transaction->fs_info->unused_bgs_loc=
k);

In the transaction abort path no else should be messing up with the list to=
o.

>                         btrfs_unfreeze_block_group(cache);
>                         btrfs_put_block_group(cache);
>                 }
> @@ -2096,7 +2098,10 @@ static void btrfs_cleanup_pending_block_groups(str=
uct btrfs_trans_handle *trans)
>
>         list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_li=
st) {
>                 btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
> +              spin_lock(&fs_info->unused_bgs_lock);
>                 list_del_init(&block_group->bg_list);
> +              btrfs_put_block_group(block_group);
> +              spin_unlock(&fs_info->unused_bgs_lock);

What's this new btrfs_put_block_group() for? I don't see a matching
ref count increase in the patch.
Or is this fixing a separate bug? Where's the matching ref count
increase in the codebase?

As before, we're in the transaction abort path, no one should be
messing with the list too.

I don't mind adding the locking just to be safe, but leaving a comment
to mention it shouldn't be needed and why there's concurrency expected
in these cases would be nice.

Thanks.

>         }
>  }

>
> --
> 2.48.1
>
>

