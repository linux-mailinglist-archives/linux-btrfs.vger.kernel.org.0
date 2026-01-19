Return-Path: <linux-btrfs+bounces-20700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662DD3A959
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C494D310EF2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206935EDB1;
	Mon, 19 Jan 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYxirV7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DF309EFA
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826730; cv=none; b=UvZbqc/ZGN4JwQx+6gSss1Tx+To8XrjbU5Q0Onme3RkIDc97fEAJHhBgVzfME5Gte4Ak1Xq69plVWOx5yALy+bP1w5i28IVY2S9Bm9cDsZB8AT75kbh9BIWUIOrzXNDp4GXiP4iBmsd0Qe3JxxnrMQ5lhRwTzhTElCODzynco58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826730; c=relaxed/simple;
	bh=PHhmG9o0RWjktsHzzfuq+9eURXj5EK4Adrzkk+3LE7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiWPHvmgzMfYWIK/wHAS9P0VQkA0YpYRvWr6EML65kHHqzjNDd/FlcNS+BpnozzAqb44gbOfsrRAsuZ7Bl/9XBwG/oV3tmSG8Atu/rr7G2+BL7dVC6bGT27fKIEmX7qee7hRnna8ZYyFvJ3HmQ0MeEkqz5S8oPbN+RUXBKgfMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYxirV7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8D3C2BC86
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768826729;
	bh=PHhmG9o0RWjktsHzzfuq+9eURXj5EK4Adrzkk+3LE7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aYxirV7zBb0N7GG6EeNHBXAJe/yoxCWiuzFUUxc9TqyJA6KlBrykObECLzKAmUwMD
	 Wy0eOFyu8KhEp0kdejFwK2wO7Wn7flk0sZ0j0J9PYrvJhp1yyefMzGNF0e1jI5EThQ
	 k6Zccx5jMdP+xEr5rf3jKrkb6kQTDCKE+eMhGv6aS9cNSFuXxgGecJkOHAJ4wTfpyw
	 znfunoVJe6yYYY33tshZI4qLpJeRqpvQinWle05Mx7KCwmKFsyHEL04BsnBKCuC8Dr
	 me8KWnYtervjGQZBewNbApTGox4aSgXandbg0yJXnhp3tKgbumVoz0ZHDd5Ev/nLpF
	 99RMrPxqUwfMw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so9202111a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 04:45:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yz5BzH2ka2LkhKMx+6b/EuQnQAhIHyNVhuRVPet+6hs4aGmtayh
	zsSivJkieVH+/ESHuiFfCPfbGluwtFlM4QvUXfJoDKnT0JjpUTnO60/o0FF8Aml/fbvDBZFRKlD
	S6WoxLYSgrzhr2qWSu7ym0qD2xb0Fx54=
X-Received: by 2002:a17:907:3da3:b0:b80:344b:421a with SMTP id
 a640c23a62f3a-b87939dad24mr1294264466b.18.1768826728292; Mon, 19 Jan 2026
 04:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119071750.43226-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260119071750.43226-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 Jan 2026 12:44:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6yEoJEkGa_4YtvRG-k2nzor6UuvMr1Mfjc2hVQ1reyxQ@mail.gmail.com>
X-Gm-Features: AZwV_QgZ_S14sDpgls-r2x2PSEaUuyNzNNd9VnqkGH__aeh_8B4OG2BUQUNGAgM
Message-ID: <CAL3q7H6yEoJEkGa_4YtvRG-k2nzor6UuvMr1Mfjc2hVQ1reyxQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove bogus NULL checks in __btrfs_write_out_cache
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:18=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Dan reported a new smatch warning in free-space-cache.c:
>
> New smatch warnings:
> fs/btrfs/free-space-cache.c:1207 write_pinned_extent_entries() warn: vari=
able dereferenced before check 'block_group' (see line 1203)
>
> But the check if the block_group pointer is NULL is bogus, because to
> get to this point block_group::io_ctl has already been dereferenced
> further up the call-chain when calling __btrfs_write_out_cache() from
> btrfs_write_out_cache().
>
> Remove the bogus checks for block_group =3D=3D NULL in
> __btrfs_write_out_cache() and it's siblings.
>
> Cc: Filipe Manana <fdmanana@suse.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202601170636.WsePMV5H-lkp@intel.com/
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good, thanks.
We can also reduce arguments by passing only the block group, since
the io_ctl is extracted from the block group upper in the call chain.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>
> Note: a full fstests run is still running at the time of submission.

I hope you're running with MKFS_OPTIONS=3D"-O ^free-space-tree" and
MOUNT_OPTIONS=3D"-o space_cache=3Dv1", otherwise it's not testing this
change at all.



>
>  fs/btrfs/free-space-cache.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index f0f72850fab2..20aa9ebe8a6c 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -1079,7 +1079,7 @@ int write_cache_extent_entries(struct btrfs_io_ctl =
*io_ctl,
>         struct btrfs_trim_range *trim_entry;
>
>         /* Get the cluster for this block_group if it exists */
> -       if (block_group && !list_empty(&block_group->cluster_list)) {
> +       if (!list_empty(&block_group->cluster_list)) {
>                 cluster =3D list_first_entry(&block_group->cluster_list,
>                                            struct btrfs_free_cluster, blo=
ck_group_list);
>         }
> @@ -1203,9 +1203,6 @@ static noinline_for_stack int write_pinned_extent_e=
ntries(
>         struct extent_io_tree *unpin =3D NULL;
>         int ret;
>
> -       if (!block_group)
> -               return 0;
> -
>         /*
>          * We want to add any pinned extents to our free space cache
>          * so we don't leak the space
> @@ -1393,7 +1390,7 @@ static int __btrfs_write_out_cache(struct inode *in=
ode,
>         if (ret)
>                 return ret;
>
> -       if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))=
 {
> +       if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
>                 down_write(&block_group->data_rwsem);
>                 spin_lock(&block_group->lock);
>                 if (block_group->delalloc_bytes) {
> @@ -1465,7 +1462,7 @@ static int __btrfs_write_out_cache(struct inode *in=
ode,
>                         goto out_nospc;
>         }
>
> -       if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> +       if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
>                 up_write(&block_group->data_rwsem);
>         /*
>          * Release the pages and unlock the extent, we will flush
> @@ -1500,7 +1497,7 @@ static int __btrfs_write_out_cache(struct inode *in=
ode,
>         cleanup_write_cache_enospc(inode, io_ctl, &cached_state);
>
>  out_unlock:
> -       if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> +       if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
>                 up_write(&block_group->data_rwsem);
>
>  out:
> --
> 2.52.0
>
>

