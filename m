Return-Path: <linux-btrfs+bounces-1993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB484565F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3581F2706A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491015D5CE;
	Thu,  1 Feb 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvaB3kg2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94B15B964
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787585; cv=none; b=BAIInFaG8pxHwKxOXgerEjj28gvFeNiM50DeKJXnAqdQfv2dXXXagQdIrWxOi04c0rl+6Z1KsRxa7SQcpRNfqINOG9nFOZYzJmtta77ihDYaiGVxqVdpGVgCkGFMApLadIZ0XbUI8rlh+Z6IloFUhmdPd3XJ6jqzgXLR5BoKtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787585; c=relaxed/simple;
	bh=6KSHgcZgDXZYrbLY+ypoqxPUiYBNZVHwcU8WQGtlI+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLIUOlUqN7yCt+nfC6eyqee5XjQAmeq5EXkBty7lG8WHK8TrYX+UwYb3P58pJzrrTxG7R0bPAIGP8Mhu2M1AlIrzqyHnC91J8nS3m+GstBcVl+wmvtHK+rYw9n1eo0wA1bsi0HSGeU96VvbgLWaRCN8YpFaw25OxSbPmlou0wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvaB3kg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CEFC43394
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706787584;
	bh=6KSHgcZgDXZYrbLY+ypoqxPUiYBNZVHwcU8WQGtlI+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZvaB3kg2AaPShUV3X6yVuzmDNjjRQ/PILrEeviio+0khW+vBOznAmgIp8s7Ryt7Ni
	 xRBqqrrgcYLd6Bz5OQ8MEaUO/YGejnIhKCiGj8yBaMN64qSn9aUKCqZpmYVo8DZiXQ
	 fbVIqppkQL6X+TtZO3cnhNhF0E4fWpVXv5sZFJffLtcKcDNvsjiT1zN5Yim5bX+nnF
	 RbDCGD0uc3V7/rhC6LcfCwHnkr/I37d3eu2FLPLtLn+q9UnHdgN0TmuRamjtvbG+ia
	 JL5SMk/POa5aHfO9n5Y6TN6fbL8EmMBk5inBp0jW7I5J0y59WJzprKEOxI1Crh4C2y
	 FMxwear0wurfg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3122b70439so108143566b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Feb 2024 03:39:44 -0800 (PST)
X-Gm-Message-State: AOJu0Yxp2BEaLKcL0bu+leEdpZ6DSL1KLapf9EH2IeDfaG4D+mTylzjJ
	Eb3mcgpzBFaiVOPo64exYP0bjW7pB1bpXkQsDeSoITEw9V7o/vVAyP4MmMo6S4H6C8Df6ExjgYY
	hxbDt2NuYP6hbSqYn2Ox6gufuL3Q=
X-Google-Smtp-Source: AGHT+IFneJvPHu4jGpjlXxz3HPly40N9yRhAhZ9Di32ijkDU8KsC2BE1NMi8afSPpHTQVEpEsIiwL/yc9Egi6s8YX5o=
X-Received: by 2002:a17:906:22c8:b0:a35:6438:a935 with SMTP id
 q8-20020a17090622c800b00a356438a935mr3369354eja.55.1706787582866; Thu, 01 Feb
 2024 03:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <280a4b489f58586b20bd195c84cf396098a784d5.1706729623.git.josef@toxicpanda.com>
In-Reply-To: <280a4b489f58586b20bd195c84cf396098a784d5.1706729623.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 1 Feb 2024 11:39:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Le1xgCKCAezK5xuTKMp9MPVYnZg56j66BnY+OdnUKFw@mail.gmail.com>
Message-ID: <CAL3q7H4Le1xgCKCAezK5xuTKMp9MPVYnZg56j66BnY+OdnUKFw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't drop extent_map for free space inode on
 write error
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:34=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> While running the CI for an unrelated change I hit the following panic
> with generic/648 on btrfs_holes_spacecache.
>
> assertion failed: block_start !=3D EXTENT_MAP_HOLE, in fs/btrfs/extent_io=
.c:1385
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/extent_io.c:1385!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 2695096 Comm: fsstress Kdump: loaded Tainted: G        W     =
     6.8.0-rc2+ #1
> RIP: 0010:__extent_writepage_io.constprop.0+0x4c1/0x5c0
> Call Trace:
>  <TASK>
>  extent_write_cache_pages+0x2ac/0x8f0
>  extent_writepages+0x87/0x110
>  do_writepages+0xd5/0x1f0
>  filemap_fdatawrite_wbc+0x63/0x90
>  __filemap_fdatawrite_range+0x5c/0x80
>  btrfs_fdatawrite_range+0x1f/0x50
>  btrfs_write_out_cache+0x507/0x560
>  btrfs_write_dirty_block_groups+0x32a/0x420
>  commit_cowonly_roots+0x21b/0x290
>  btrfs_commit_transaction+0x813/0x1360
>  btrfs_sync_file+0x51a/0x640
>  __x64_sys_fdatasync+0x52/0x90
>  do_syscall_64+0x9c/0x190
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> This happens because we fail to write out the free space cache in one
> instance, come back around and attempt to write it again.  However on
> the second pass through we go to call btrfs_get_extent() on the inode to
> get the extent mapping.  Because this is a new block group, and with the
> free space inode we always search the commit root to avoid deadlocking
> with the tree, we find nothing and return a EXTENT_MAP_HOLE for the
> requested range.
>
> This happens because the first time we try to write the space cache out
> we hit an error, and on an error we drop the extent mapping.  This is
> normal for normal files, but the free space cache inode is special.  We
> always expect the extent map to be correct.  Thus the second time
> through we end up with a bogus extent map.
>
> Since we're deprecating this feature, the most straightforward way to
> fix this is to simply skip dropping the extent map range for this failed
> range.
>
> I shortened the test by using error injection to stress the area to make
> it easier to reproduce.  With this patch in place we no longer panic
> with my error injection test.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6734717350e3..ca26e2c267f2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3182,8 +3182,23 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>                         unwritten_start +=3D logical_len;
>                 clear_extent_uptodate(io_tree, unwritten_start, end, NULL=
);
>
> -               /* Drop extent maps for the part of the extent we didn't =
write. */
> -               btrfs_drop_extent_map_range(inode, unwritten_start, end, =
false);
> +               /*
> +                * Drop extent maps for the part of the extent we didn't =
write.
> +                *
> +                * We have an exception here for the free_space_inode, th=
is is
> +                * because when we do btrfs_get_extent() on the free spac=
e inode
> +                * we will search the commit root.  If this is a new bloc=
k group
> +                * we won't find anything, and we will trip over the asse=
rt in
> +                * writepage where we do ASSERT(em->block_start !=3D
> +                * EXTENT_MAP_HOLE).
> +                *
> +                * Theoretically we could also skip this for any NOCOW ex=
tent as
> +                * we don't mess with the extent map tree in the NOCOW ca=
se, but
> +                * for now simply skip this if we are the free space inod=
e.
> +                */
> +               if (!btrfs_is_free_space_inode(inode))
> +                       btrfs_drop_extent_map_range(inode, unwritten_star=
t,
> +                                                   end, false);
>
>                 /*
>                  * If the ordered extent had an IOERR or something else w=
ent
> --
> 2.43.0
>
>

