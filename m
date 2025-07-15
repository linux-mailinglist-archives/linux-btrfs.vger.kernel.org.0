Return-Path: <linux-btrfs+bounces-15504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A7B06214
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C5B4A0984
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83381F4606;
	Tue, 15 Jul 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxbcpylG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84911DF26B
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591159; cv=none; b=dAbomXZs1S11LWrOXFPRbkkc8DfH4kcAccb077CxakL3OGL2P2ROHf0hbM716qkuHLaTvyayfFKnm74dvFFwgi4Oot6sHRq7wWsLMS8aReLZS6IngwhFIKW8LXRIqqxqZEjYDY1egbuiFuHuhbFxXzT2B1P0Vhk0gm07TSiMEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591159; c=relaxed/simple;
	bh=Muxy0znOkyDYh/1TbjhZDx9jVD9NuJ1pSwQdVcHmq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkkZnuO+yjD2Ixm5GNwNZa4udjADmkieKwEXgdKUvYyTe7prBwZl4MT5RZqcic7O7LKqp6Wdv0kE/Ebdi/ZidOiokiWxwk8WrmNKG8eOYKBNM/FHGzcaBS01lszLdgFP5kWkvwotO6P839AcYSY8pMaMarKDBrIvZ5E7c6tktLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxbcpylG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67975C4CEF8
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591159;
	bh=Muxy0znOkyDYh/1TbjhZDx9jVD9NuJ1pSwQdVcHmq8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SxbcpylGY/dfQadAJxX3CkzhL/htUkQWuRWEsrLKc3fU2kq2lnV0HGhUwGZ0ozMqv
	 Rej+vnvkwq//Cx/Cd2QENnFmDf5qFdYmJni1BVIw+xcUEGWbVWBErbIMrpGf5uadrf
	 UM8/AfOW7r4SYASjTQOV7ORlaIYcax6KzLU1o6ckel5/zz2XAPB5e0uSfPGB68XhUo
	 0u7VaIVqFSEhZIXK4nHzagD0QHT8HOGD6be3Ba08TCwXAGDU3dAzjvwt0oCs9gghS5
	 urB6/K2Xu7HvwgXOMTKiTDJ4nVYE67mmfZKwxarogFyV92qAnOizEyVjizQibPKseH
	 jlmqs38wOd1jw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1123993466b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 07:52:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwA0Bid0R/x2ApyTQyUYb6Uo/eOyY3N7u3V91tjpofzpwAJ3NZv
	WRwA4qNwgy/vo/2fjarGQ71QelKXWHCVMjOQdeeerrPwoe84eoiMzo9J+hnDZhv9nE8K6VbBpkS
	4cUnfpJyofA7FtfGTyIBq8WnLD2eEO/E=
X-Google-Smtp-Source: AGHT+IGwqP24J5Hx9g2yQCK3rDdfTq0b2jPmDSCxuaxTz2NNPS3OoX1mXssT62NxDae89A/XHpTlNhF8ZuNfd3euXt8=
X-Received: by 2002:a17:907:2d2b:b0:ae6:e32c:9544 with SMTP id
 a640c23a62f3a-ae6fcc2143dmr1937426666b.43.1752591157941; Tue, 15 Jul 2025
 07:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22b101fdabce832fc954622fcc0d49793d2070f2.1752540760.git.boris@bur.io>
In-Reply-To: <22b101fdabce832fc954622fcc0d49793d2070f2.1752540760.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 15 Jul 2025 15:52:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7MCSLiZc-KipzGWcybBM7+Y2SD9B-tw0=07Rzg+spdrw@mail.gmail.com>
X-Gm-Features: Ac12FXyQHdEOFCgC0NboU8QvL-IhXNsxM--ij1taCjwaLS5-ioIKdZ01roZ2SII
Message-ID: <CAL3q7H7MCSLiZc-KipzGWcybBM7+Y2SD9B-tw0=07Rzg+spdrw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix ssd_spread overallocation
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:52=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> If the ssd_spread mount option is enabled, then we run the so called
> clustered allocator for data block groups. In practice, this results in
> creating a btrfs_free_cluster which caches a block_group and borrows its
> free extents for allocation.
>
> Since the introduction of allocation size classes, there has been a bug
> in the interaction between that feature and ssd_spread. find_free_extent(=
)
> has a number of nested loops. The loop going over the allocation stages,
> stored in ffe_ctl->loop and managed by find_free_extent_update_loop(),
> the loop over the raid levels, and the loop over all the block_groups in
> a space_info. The size class feature relies on the block_group loop to
> ensure it gets a chance to see a block_group of a given size class.
> However, the clustered allocator uses the cached cluster block_group and
> breaks that loop. Each call to do_allocation() will really just go back
> to the same cached block_group. Normally, this is OK, as the allocation
> either succeeds and we don't want to loop any more or it fails, and we
> clear the cluster and return its space to the block_group.
>
> But with size classes, the allocation can succeed, then later fail,
> outside of do_allocation() due to size class mismatch. That latter
> failure is not properly handled due to the highly complex multi loop
> logic. The result is a painful loop where we continue to allocate the
> same num_bytes from the cluster in a tight loop until it fails and
> releases the cluster and lets us try a new block_group. But by then, we
> have skipped great swaths of the available block_groups and are likely
> to fail to allocate, looping the outer loop. In pathological cases like
> the reproducer below, the cached block_group is often the very last one,
> in which case we don't perform this tight bg loop but instead rip
> through the ffe stages to LOOP_CHUNK_ALLOC and allocate a chunk, which
> is now the last one, and we enter the tight inner loop until an
> allocation failure. Then allocation succeeds on the final block_group
> and if the next allocation is a size mismatch, the exact same thing
> happens again.
>
> Triggering this is as easy as mounting with -o ssd_spread and then
> running:
>
> mount -o ssd_spread $dev $mnt
> dd if=3D/dev/zero of=3D$mnt/big bs=3D16M count=3D1 &>/dev/null
> dd if=3D/dev/zero of=3D$mnt/med bs=3D4M count=3D1 &>/dev/null
> sync
>
> if you do the two writes + sync in a loop, you can force btrfs to spin
> an excessive amount on semi-successful clustered allocations, before
> ultimately failing and advancing to the stage where we force a chunk
> allocation. This results in 2G of data allocated per iteration, despite
> only using ~20M of data. By using a small size classed extent, the inner
> loop takes longer and we can spin for longer.
>
> The simplest, shortest term fix to unbreak this is to make the clustered
> allocator size_class aware in the dumbest way, where it fails on size
> class mismatch. This may hinder the operation of the clustered
> allocator, but better hindered than completely broken and terribly
> overallocating.
>
> Further re-design improvements are also in the works.
>
> Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocato=
r")
> Reported-by: Dave Sterba <dsterba@suse.com>

I think you should probably use David and not Dave, since that's the form h=
e
always uses in his SoB tags, RB tags, etc.

> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.




> ---
>  fs/btrfs/extent-tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 85833bf216de..ca54fbb0231c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3672,7 +3672,8 @@ static int find_free_extent_clustered(struct btrfs_=
block_group *bg,
>         if (!cluster_bg)
>                 goto refill_cluster;
>         if (cluster_bg !=3D bg && (cluster_bg->ro ||
> -           !block_group_bits(cluster_bg, ffe_ctl->flags)))
> +           !block_group_bits(cluster_bg, ffe_ctl->flags) ||
> +           ffe_ctl->size_class !=3D cluster_bg->size_class))
>                 goto release_cluster;
>
>         offset =3D btrfs_alloc_from_cluster(cluster_bg, last_ptr,
> --
> 2.50.0
>
>

