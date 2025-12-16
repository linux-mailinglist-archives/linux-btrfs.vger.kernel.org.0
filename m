Return-Path: <linux-btrfs+bounces-19805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D6CC5388
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C83305655B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFE33B95D;
	Tue, 16 Dec 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdLV1MkW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415733AD89
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920872; cv=none; b=lNOm5HKQVff4WoyhVlVh/eGtdZMVQHLNiq32RZJtV/BYibBUlVrcZWlwH0+gxpSmm0O0GRFIncDzyIoYwaTxyO2oGIKZQJrNj/JKnmc0OAAkE+6T2GMiP4yGO2IyJOlJtR+sVlKc/exNBRQ2pBt1sftimYtM5j6PCw42AMzgyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920872; c=relaxed/simple;
	bh=vaW9OkMq91qfKcP1XJkYiBnfabC2Am11faRU3vZxcF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCadloJyY8IlpQrN5IEJqjsevaZZ/Tj7ZwKCU3k+ET/xnYTL8N4oLrx4sxI45QAFQ3YHhIOpoPqvhY7hQDGnZGW9HkSKHqi/9e+xk5rPHHrLg1cUG7UFhPdytGVLwyGoQvBnsxnS8qdJWrLoBpZ5oOuNL4uTeG7OCktB/voG43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdLV1MkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E51BC113D0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 21:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765920868;
	bh=vaW9OkMq91qfKcP1XJkYiBnfabC2Am11faRU3vZxcF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mdLV1MkWQ6dGcUeXwroMjx6XNPeTuna81pYAAM8qUyygttMXrKyJ5TPWsM3QjwQ19
	 l7k7srwixaLYRRmdkFnzzYN1qv0WHCUWW9nNr8EqmfHHeazLT+2rLiBsUsdjHZggvo
	 v70caKTIHEdrU3Arj9UWW0AbKJjZok3OxOIkDG2azBTKoKc8GpjMlt2UZzvqLTRYCF
	 N7/94iF8h4DW03PdwwO29u3+WU3vIQQYfhhV3m9dX8R7k0yMaWMs+JtJd5G8pUcp0A
	 lHIegdMqBHIOJarmTOCUUnNaWpfTVcXvaHYKuTReXwQv7kO2kbmWS/5Hqudh1XISpK
	 RC5270/ody+rg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6496a8dc5a7so6922070a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 13:34:28 -0800 (PST)
X-Gm-Message-State: AOJu0YxXB181mR7dGPkFA/ZRcQHJqkwAlj+yOEtlNcH8N81hwRl9SAML
	6n51alNMEnBZRk0JWiQ2mF3lPqELru4MKXFExVmRgEfZoSjVHN2UI1PNCkzibFnZJ4Q2GH1v0OU
	9MQbQ4WrPGoMUlGn9dpmae/Viabhetek=
X-Google-Smtp-Source: AGHT+IEFAokDZXl4938HLpsjU+wdR/ju0ubprLkYVK5LYCyRA+2blhZR7Ymgm0Lg7MuYROO4wdvqNdYpDNm3ny5eneY=
X-Received: by 2002:a17:907:9408:b0:b7d:1cbb:5d23 with SMTP id
 a640c23a62f3a-b7d235c9cacmr1585590766b.2.1765920866895; Tue, 16 Dec 2025
 13:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3b2797ff1161a809b1935ed0e1ce31d6110cc33.1765897890.git.fdmanana@suse.com>
 <58390da3-ae35-49c6-929e-dd313c4fc62c@suse.com>
In-Reply-To: <58390da3-ae35-49c6-929e-dd313c4fc62c@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Dec 2025 21:33:49 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7wD64foqiuHqizaxivf+bKryueyBaf4ao_Bgao9-00oA@mail.gmail.com>
X-Gm-Features: AQt7F2qCMeuODbbPtPNbKSnMHCyXHVL0UJbBSswft4bPdhgvpkbXb74ZrViDJk4
Message-ID: <CAL3q7H7wD64foqiuHqizaxivf+bKryueyBaf4ao_Bgao9-00oA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: release path before initializing extent tree in btrfs_read_locked_inode()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/12/17 01:42, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > In btrfs_read_locked_inode() we are calling btrfs_init_file_extent_tree=
()
> > while holding a path with a read locked leaf from a subvolume tree, and
> > btrfs_init_file_extent_tree() may do a GFP_KERNEL allocation, which can
> > trigger reclaim.
> >
> > This can create a circular lock dependency which lockdep warns about wi=
th
> > the following splat:
> >
> >     [27386.164433] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     [27386.164574] WARNING: possible circular locking dependency detect=
ed
> >     [27386.164583] 6.18.0+ #4 Tainted: G     U
> >     [27386.164591] ----------------------------------------------------=
--
> >     [27386.164599] kswapd0/117 is trying to acquire lock:
> >     [27386.164606] ffff8d9b6333c5b8 (&delayed_node->mutex){+.+.}-{3:3},=
 at:
> >     __btrfs_release_delayed_node.part.0+0x39/0x2f0
> >     [27386.164625]
> >                    but task is already holding lock:
> >     [27386.164633] ffffffffa4ab8ce0 (fs_reclaim){+.+.}-{0:0}, at:
> >     balance_pgdat+0x195/0xc60
> >     [27386.164646]
> >                    which lock already depends on the new lock.
> >
> >     [27386.164657]
> >                    the existing dependency chain (in reverse order) is:
> >     [27386.164667]
> >                    -> #2 (fs_reclaim){+.+.}-{0:0}:
> >     [27386.164677]        fs_reclaim_acquire+0x9d/0xd0
> >     [27386.164685]        __kmalloc_cache_noprof+0x59/0x750
> >     [27386.164694]        btrfs_init_file_extent_tree+0x90/0x100
> >     [27386.164702]        btrfs_read_locked_inode+0xc3/0x6b0
> >     [27386.164710]        btrfs_iget+0xbb/0xf0
> >     [27386.164716]        btrfs_lookup_dentry+0x3c5/0x8e0
> >     [27386.164724]        btrfs_lookup+0x12/0x30
> >     [27386.164731]        lookup_open.isra.0+0x1aa/0x6a0
> >     [27386.164739]        path_openat+0x5f7/0xc60
> >     [27386.164746]        do_filp_open+0xd6/0x180
> >     [27386.164753]        do_sys_openat2+0x8b/0xe0
> >     [27386.164760]        __x64_sys_openat+0x54/0xa0
> >     [27386.164768]        do_syscall_64+0x97/0x3e0
> >     [27386.164776]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >     [27386.164784]
> >                    -> #1 (btrfs-tree-00){++++}-{3:3}:
> >     [27386.164794]        lock_release+0x127/0x2a0
> >     [27386.164801]        up_read+0x1b/0x30
> >     [27386.164808]        btrfs_search_slot+0x8e0/0xff0
> >     [27386.164817]        btrfs_lookup_inode+0x52/0xd0
> >     [27386.164825]        __btrfs_update_delayed_inode+0x73/0x520
> >     [27386.164833]        btrfs_commit_inode_delayed_inode+0x11a/0x120
> >     [27386.164842]        btrfs_log_inode+0x608/0x1aa0
> >     [27386.164849]        btrfs_log_inode_parent+0x249/0xf80
> >     [27386.164857]        btrfs_log_dentry_safe+0x3e/0x60
> >     [27386.164865]        btrfs_sync_file+0x431/0x690
> >     [27386.164872]        do_fsync+0x39/0x80
> >     [27386.164879]        __x64_sys_fsync+0x13/0x20
> >     [27386.164887]        do_syscall_64+0x97/0x3e0
> >     [27386.164894]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >     [27386.164903]
> >                    -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
> >     [27386.164913]        __lock_acquire+0x15e9/0x2820
> >     [27386.164920]        lock_acquire+0xc9/0x2d0
> >     [27386.164927]        __mutex_lock+0xcc/0x10a0
> >     [27386.164934]        __btrfs_release_delayed_node.part.0+0x39/0x2f=
0
> >     [27386.164944]        btrfs_evict_inode+0x20b/0x4b0
> >     [27386.164952]        evict+0x15a/0x2f0
> >     [27386.164958]        prune_icache_sb+0x91/0xd0
> >     [27386.164966]        super_cache_scan+0x150/0x1d0
> >     [27386.164974]        do_shrink_slab+0x155/0x6f0
> >     [27386.164981]        shrink_slab+0x48e/0x890
> >     [27386.164988]        shrink_one+0x11a/0x1f0
> >     [27386.164995]        shrink_node+0xbfd/0x1320
> >     [27386.165002]        balance_pgdat+0x67f/0xc60
> >     [27386.165321]        kswapd+0x1dc/0x3e0
> >     [27386.165643]        kthread+0xff/0x240
> >     [27386.165965]        ret_from_fork+0x223/0x280
> >     [27386.166287]        ret_from_fork_asm+0x1a/0x30
> >     [27386.166616]
> >                    other info that might help us debug this:
> >
> >     [27386.167561] Chain exists of:
> >                      &delayed_node->mutex --> btrfs-tree-00 --> fs_recl=
aim
> >
> >     [27386.168503]  Possible unsafe locking scenario:
> >
> >     [27386.169110]        CPU0                    CPU1
> >     [27386.169411]        ----                    ----
> >     [27386.169707]   lock(fs_reclaim);
> >     [27386.169998]                                lock(btrfs-tree-00);
> >     [27386.170291]                                lock(fs_reclaim);
> >     [27386.170581]   lock(&delayed_node->mutex);
> >     [27386.170874]
> >                     *** DEADLOCK ***
> >
> >     [27386.171716] 2 locks held by kswapd0/117:
> >     [27386.171999]  #0: ffffffffa4ab8ce0 (fs_reclaim){+.+.}-{0:0}, at:
> >     balance_pgdat+0x195/0xc60
> >     [27386.172294]  #1: ffff8d998344b0e0 (&type->s_umount_key#40){++++}=
-
> >     {3:3}, at: super_cache_scan+0x37/0x1d0
> >     [27386.172596]
> >                    stack backtrace:
> >     [27386.173183] CPU: 11 UID: 0 PID: 117 Comm: kswapd0 Tainted: G    =
 U
> >     6.18.0+ #4 PREEMPT(lazy)
> >     [27386.173185] Tainted: [U]=3DUSER
> >     [27386.173186] Hardware name: ASUS System Product Name/PRIME B560M-=
A
> >     AC, BIOS 2001 02/01/2023
> >     [27386.173187] Call Trace:
> >     [27386.173187]  <TASK>
> >     [27386.173189]  dump_stack_lvl+0x6e/0xa0
> >     [27386.173192]  print_circular_bug.cold+0x17a/0x1c0
> >     [27386.173194]  check_noncircular+0x175/0x190
> >     [27386.173197]  __lock_acquire+0x15e9/0x2820
> >     [27386.173200]  lock_acquire+0xc9/0x2d0
> >     [27386.173201]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> >     [27386.173204]  __mutex_lock+0xcc/0x10a0
> >     [27386.173206]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> >     [27386.173208]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> >     [27386.173211]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> >     [27386.173213]  __btrfs_release_delayed_node.part.0+0x39/0x2f0
> >     [27386.173215]  btrfs_evict_inode+0x20b/0x4b0
> >     [27386.173217]  ? lock_acquire+0xc9/0x2d0
> >     [27386.173220]  evict+0x15a/0x2f0
> >     [27386.173222]  prune_icache_sb+0x91/0xd0
> >     [27386.173224]  super_cache_scan+0x150/0x1d0
> >     [27386.173226]  do_shrink_slab+0x155/0x6f0
> >     [27386.173228]  shrink_slab+0x48e/0x890
> >     [27386.173229]  ? shrink_slab+0x2d2/0x890
> >     [27386.173231]  shrink_one+0x11a/0x1f0
> >     [27386.173234]  shrink_node+0xbfd/0x1320
> >     [27386.173236]  ? shrink_node+0xa2d/0x1320
> >     [27386.173236]  ? shrink_node+0xbd3/0x1320
> >     [27386.173239]  ? balance_pgdat+0x67f/0xc60
> >     [27386.173239]  balance_pgdat+0x67f/0xc60
> >     [27386.173241]  ? finish_task_switch.isra.0+0xc4/0x2a0
> >     [27386.173246]  kswapd+0x1dc/0x3e0
> >     [27386.173247]  ? __pfx_autoremove_wake_function+0x10/0x10
> >     [27386.173249]  ? __pfx_kswapd+0x10/0x10
> >     [27386.173250]  kthread+0xff/0x240
> >     [27386.173251]  ? __pfx_kthread+0x10/0x10
> >     [27386.173253]  ret_from_fork+0x223/0x280
> >     [27386.173255]  ? __pfx_kthread+0x10/0x10
> >     [27386.173257]  ret_from_fork_asm+0x1a/0x30
> >     [27386.173260]  </TASK>
> >
> > This is because:
> >
> > 1) The fsync task is holding an inode's delayed node mutex (for a
> >     directory) while calling __btrfs_update_delayed_inode() and that ne=
eds
> >     to do a search on the subvolume's btree (therefore read lock some
> >     extent buffers);
> >
> > 2) The lookup task, at btrfs_lookup(), triggered reclaim with the
> >     GFP_KERNEL allocation done by btrfs_init_file_extent_tree() while
> >     holding a read lock on a subvolume leaf;
> >
> > 3) The reclaim triggered kswapd which is doing inode eviction for the
> >     directory inode the fsync task is using as an argument to
> >     btrfs_commit_inode_delayed_inode() - but in that call chain we are
> >     trying to read lock the same leaf that the lookup task is holding
> >     while calling btrfs_init_file_extent_tree() and doing the GFP_KERNE=
L
> >     allocation.
> >
> > Fix this by calling btrfs_init_file_extent_tree() after we don't need t=
he
> > path anymore and release it in btrfs_read_locked_inode().
> >
> > Reported-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Link: https://lore.kernel.org/linux-btrfs/6e55113a22347c3925458a5d840a1=
8401a38b276.camel@linux.intel.com/
> > Fixes: 8679d2687c35 ("btrfs: initialize inode::file_extent_tree after i=
_mode has been set")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/inode.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 457624de84a0..a8ce2bf53b82 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4043,11 +4043,6 @@ static int btrfs_read_locked_inode(struct btrfs_=
inode *inode, struct btrfs_path
> >       btrfs_set_inode_mapping_order(inode);
> >
> >   cache_index:
> > -     ret =3D btrfs_init_file_extent_tree(inode);
> > -     if (ret)
> > -             goto out;
> > -     btrfs_inode_set_file_extent_range(inode, 0,
> > -                     round_up(i_size_read(vfs_inode), fs_info->sectors=
ize));
> >       /*
> >        * If we were modified in the current generation and evicted from=
 memory
> >        * and then re-read we need to do a full sync since we don't have=
 any
> > @@ -4158,6 +4153,20 @@ static int btrfs_read_locked_inode(struct btrfs_=
inode *inode, struct btrfs_path
> >               break;
> >       }
> >
> > +     /*
> > +      * We don't need the path anymore, so release it to avoid holding=
 a read
> > +      * lock on a leaf while calling btrfs_init_file_extent_tree(), wh=
ich can
> > +      * allocate memory that triggers reclaim (GFP_KERNEL) and cause a=
 locking
> > +      * dependency.
> > +      */
> > +     btrfs_release_path(path);
>
> We can release the path earlier, the last path usage is
> btrfs_load_inode_props(), we can release the path after that "if
> (first_xattr_slot !=3D -1) {}" check.

Yes, but there isn't anything heavy between that and where I placed
btrfs_release_path(), just some assignments.
I can move it a bit more above before pushing to for-next, but it's
not like we'll get any major or observable performance gain.

>
> Other than that looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
>
> BTW, it doesn't looks a good practice of passing btrfs_path pointer
> around for btrfs_read_locked_inode().

Why? We have so many places where we pass an unpopulated path as a paramete=
r.

>
> Either it's btrfs_iget(), which allocates a path only for this call and
> immediately free it, or it's btrfs_iget_path() which is only utilized by
> free-space-cache and no one is really utilizing the path anyway.

It exists to avoid two path allocations in the free space cache code,
which is a valid reason, to avoid using more memory and a potential
allocation failure.

>
> Thus it's better to just allocate the path inside
> btrfs_read_locked_inode() to minimize the lifespan.
> Of course this should be another dedicated cleanup.

Let's not go over things that are unrelated to the problem being fixed
here please.

Thanks.

>
> Thanks,
> Qu
>
> > +
> > +     ret =3D btrfs_init_file_extent_tree(inode);
> > +     if (ret)
> > +             goto out;
> > +     btrfs_inode_set_file_extent_range(inode, 0,
> > +                       round_up(i_size_read(vfs_inode), fs_info->secto=
rsize));
> > +
> >       btrfs_sync_inode_flags_to_i_flags(inode);
> >
> >       ret =3D btrfs_add_inode_to_root(inode, true);
>

