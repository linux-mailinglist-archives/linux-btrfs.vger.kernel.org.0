Return-Path: <linux-btrfs+bounces-16432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC73B37E14
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573DB1B61628
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E562F60DF;
	Wed, 27 Aug 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2WoqCGu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F91F7586
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284393; cv=none; b=i0+6n6rsJyz+5FbNtRV0DbLkSDhE/lDvHV/9TRpShZAzJ7C4frejOpWIjMGikb5OKccLqvXh1c68BNCTikhJKfxk4cECa6NBgroPOGsz3o0w12gIOqXdACHx3XWQv6c7D7mU3BSkSuxNCRchEgQT0zJuUyy2sdocPzym283ri1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284393; c=relaxed/simple;
	bh=SdS2bkznW+ttQQvbVukkC4JVEuG+/1DeBBq9ad4+zEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVY1gFnxZgpRPKr/HrBSB2zQwJHbqAb34SnM8LcHyj4oq3PJyZwPflOHz9CO3iz4fpMZ1iCYRQ0gHRDmNmS8prA66Qa3f2yI/Zell0/xy2rUlsLLZxoyyeR/ZTv76otkO8iq77/ZESCGx16gKYzI2aH2F/p5XC6Z2lkES/X10T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2WoqCGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6576CC4AF09
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756284393;
	bh=SdS2bkznW+ttQQvbVukkC4JVEuG+/1DeBBq9ad4+zEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I2WoqCGuTP7ew+RW36uSJJERr9P0EFsaAM08YGlDACWRLmatBMYJuml0PVn3DWFGO
	 hPrl4HeJCh41pEKB3jrLu86xvBdsSf0t42bhc6Fw8q9Sb389ZUuI5ohf3ZRnBNJVXL
	 7ZjiW3w/YmeQMS1iGKCPWLW27+FIJeJy3ZeWfCWsCrIl36KhcQ8fctWiXXXIlmTVUN
	 +AC9uslIfg0c5/aYHuAPMwk2Ju5eML7w6zJGMWczcdPRXHtzWQcAcVUGtmmpuhyszy
	 Dg+2iJA4b6ClK9U5xkyaXpD8bSPUOVRGJTK/UFM1uBu11LKsagi3651hYhVpb1Xkoa
	 PWoiYg5PssroA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afec56519c4so46474366b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 01:46:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxeVcz+JrEysjQBjhTQZABcYlJyNo+8h76mn4pcqTE6FfRr8sXs
	cXf5fww76OMBIk9DDY0StwiFKJGlF7tPuObxju6OuUMXXGHxu6DrWaS1bhoxY3A4QxN7uKS7Ob6
	i8lEij0FJRuXPZl3kEHSCzGFhRIeYKtU=
X-Google-Smtp-Source: AGHT+IHWorFAXHRLNyJZXzpcezjkhUXYWaxrdWYO1GH734dCJ/95unwubwISwnPAHaiWULb6yGobfFKxojIe+BRVhEs=
X-Received: by 2002:a17:907:940a:b0:ae8:4776:fbb1 with SMTP id
 a640c23a62f3a-afe28fd3a7dmr1981941466b.11.1756284391894; Wed, 27 Aug 2025
 01:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
In-Reply-To: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 27 Aug 2025 09:45:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H48SkgXFEikNX0Kuh722b0CRduKW5a9rQgT9afs3Am1SA@mail.gmail.com>
X-Gm-Features: Ac12FXx5b9EIu1PS_mSHcbksVkA-9uEqbO5OmpzV3XFbcLLD2njWCbvRcmTKONQ
Message-ID: <CAL3q7H48SkgXFEikNX0Kuh722b0CRduKW5a9rQgT9afs3Am1SA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes
 xarray race
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Filipe Manana <fdmanana@suse.com>, Leo Martins <loemra.dev@gmail.com>, Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:01=E2=80=AFPM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> There is a race condition between inode eviction and inode caching that
> can cause a live struct btrfs_inode to be missing from the root->inodes
> xarray. Specifically, there is a window during evict() between the inode
> being unhashed and deleted from the xarray. If btrfs_iget() is called
> for the same inode in that window, it will be recreated and inserted
> into the xarray, but then eviction will delete the new entry, leaving
> nothing in the xarray:
>
> Thread 1                          Thread 2
> ---------------------------------------------------------------
> evict()
>   remove_inode_hash()
>                                   btrfs_iget_path()
>                                     btrfs_iget_locked()
>                                     btrfs_read_locked_inode()
>                                       btrfs_add_inode_to_root()
>   destroy_inode()
>     btrfs_destroy_inode()
>       btrfs_del_inode_from_root()
>         __xa_erase
>
> In turn, this can cause issues for subvolume deletion. Specifically, if
> an inode is in this lost state, and all other inodes are evicted, then
> btrfs_del_inode_from_root() will call btrfs_add_dead_root() prematurely.
> If the lost inode has a delayed_node attached to it, then when
> btrfs_clean_one_deleted_snapshot() calls btrfs_kill_all_delayed_nodes(),
> it will loop forever because the delayed_nodes xarray will never become
> empty (unless memory pressure forces the inode out). We saw this
> manifest as soft lockups in production.
>
> Fix it by only deleting the xarray entry if it matches the given inode
> (using __xa_cmpxchg()).
>
> Fixes: 310b2f5d5a94 ("btrfs: use an xarray to track open inodes in a root=
")
> Cc: stable@vger.kernel.org # 6.11+
> Co-authored-by: Leo Martins <loemra.dev@gmail.com>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Based on for-next. This reproduces the soft lockup on a kernel with
> CONFIG_PREEMPT_NONE=3Dy:
>
>         #!/bin/bash
>
>         set -e
>
>         dev=3D/dev/vdb
>
>         mkfs.btrfs -f "$dev"
>         tmp=3D"$(mktemp -d)"
>         trap 'umount "$dev"; rm -rf "$tmp"' EXIT
>         mnt=3D"$tmp/mnt"
>         mkdir "$mnt"
>         mount "$dev" "$mnt"
>         cleaner_pid=3D"$(pgrep -n btrfs-cleaner)"
>
>         subvol=3D"$mnt/subvol"
>
>         while true; do
>                 echo -n .
>
>                 btrfs -q subvolume create "$subvol"
>
>                 # Stat hard links of the same inode repeatedly.
>                 touch "$subvol/file"
>                 for ((i =3D 0; i < 4; i++)); do
>                         mkdir "$subvol/dir$i"
>                         ln "$subvol/file" "$subvol/dir$i/file"
>                         while [ -f "$subvol/dir$i/file" ]; do
>                                 :
>                         done &
>                 done
>
>                 # Drop dentry and inode caches. Along with the parallel
>                 # stats, this may trigger the race when the inode is
>                 # recached.
>                 echo 2 > /proc/sys/vm/drop_caches
>
>                 # Hold a reference on the inode (but not any of its
>                 # dentries) by creating an inotify watch.
>                 inotifywatch -e unmount "$subvol/file" > "$tmp/log" 2>&1 =
&
>                 inotifypid=3D$!
>                 tail -f "$tmp/log" | grep -q "Finished establishing watch=
es"
>
>                 # Hold a reference on another file.
>                 exec 3> "$subvol/dummy"
>
>                 btrfs -q subvolume delete "$subvol"
>
>                 echo 2 > /proc/sys/vm/drop_caches
>
>                 # After deleting the subvolume and dropping caches, only
>                 # the lost inode and the dummy file should be cached,
>                 # and only the dummy file is in the inodes xarray.
>
>                 # Closing the dummy file will mark the subvolume as dead
>                 # even though the lost inode is still cached.
>                 exec 3>&-
>
>                 # Remounting kicks the cleaner thread.
>                 mount -o remount,rw "$mnt"
>                 # Loop until the cleaner thread stops running. If we
>                 # reproduced the race, it will never stop. Otherwise, we
>                 # will clean up and try again.
>                 while true; do
>                         if ! grep 'State:\s*R' "/proc/$cleaner_pid/status=
"; then
>                                 kill "$inotifypid"
>                                 mount -o remount,rw "$mnt"
>                         fi
>                         if ! btrfs subvolume list -d "$mnt" | grep -q .; =
then
>                                 break
>                         fi
>                         sleep 1
>                 done
>         done
>
>  fs/btrfs/inode.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f91c62146982..3cd9b505bd25 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5697,7 +5697,17 @@ static void btrfs_del_inode_from_root(struct btrfs=
_inode *inode)
>         bool empty =3D false;
>
>         xa_lock(&root->inodes);
> -       entry =3D __xa_erase(&root->inodes, btrfs_ino(inode));
> +       /*
> +        * This btrfs_inode is being freed and has already been unhashed =
at this
> +        * point. It's possible that another btrfs_inode has already been
> +        * allocated for the same inode and inserted itself into the root=
, so
> +        * don't delete it in that case.
> +        *
> +        * Note that this shouldn't need to allocate memory, so the gfp f=
lags
> +        * don't really matter.
> +        */
> +       entry =3D __xa_cmpxchg(&root->inodes, btrfs_ino(inode), inode, NU=
LL,
> +                            GFP_ATOMIC);
>         if (entry =3D=3D inode)
>                 empty =3D xa_empty(&root->inodes);
>         xa_unlock(&root->inodes);
> --
> 2.51.0
>
>

