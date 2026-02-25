Return-Path: <linux-btrfs+bounces-21918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AxzHIPpnmk/XwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21918-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:22:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3004019737F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0A753034CB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F953446C3;
	Wed, 25 Feb 2026 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/vVmc0Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60439524A
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022142; cv=none; b=QJX+j6W25OMPXYloQW9CwaI45Pra5MXFZj7eA1izd70aKAcK27q5HjSTt257h/RAqOkciOfs8t9sJubO2vJ1W/6/C0VehWFDN+6XTUD2r/h9PjLk/TZ262+l1yFHvfDx0x9hcBAEPf9lNwUvUb355G3cCOSdyjYzKhgvqpOgLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022142; c=relaxed/simple;
	bh=5fg7SOc/6dG2r5gVGtIOxdZSXaaMX1hbGfdW9bT8HiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pem60uX4f879bqMiTHnxDtrXq74lR9BF6mCRULOltgOg4zixjG73q+Q6oflpg3Lr6w2t6eOJlwzID8mhxRnd53GtZKBs/ATfDBKbZdACqTf+5ckv0YCsf0uPOz7zjBTV5ExYNfIlXXfcEDUj0HVsybNTKnSBp0iApUAFSznuX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/vVmc0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF477C19423
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772022142;
	bh=5fg7SOc/6dG2r5gVGtIOxdZSXaaMX1hbGfdW9bT8HiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m/vVmc0YuQN7eei/gnT4aZFwrEJn+WZa0z0xxczsp3AcBbvjXIP0c37F7mn9WRRYd
	 tfd6Ga4notySgKZ7As8dfWZH/WUXu6qHe+HfM1V8mzsru3hFHSxG7mpi8J3ZhcpiIA
	 pSxAvOMOz4Wm7eOA4usidhQWmOSy2NkIdTvHGK6ahxFaum7mAzBC6BxM9KVpHvUBCb
	 7WV6/rOSJOmG3QfECnxhg+WMlJTcYmR1PpPuGcH3l4bx2oGG2Mubdbj5LEDmMw6i6n
	 n6yzbuKtzNehFcio9q/w0peAADjTGtfeQGdKOvYOZY5keMAiXQsrEy1pLrBk0y9w13
	 B12PtLaS6L//Q==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fb6ad3243so927560166b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 04:22:21 -0800 (PST)
X-Gm-Message-State: AOJu0YyfuYkGeQJ3RTBJyy63BcyEkwToDE9EmvRxDjjD76XXdJQhfvjB
	78c5YudTzHV2iqNo6FOr8iakGEZqvGgDJ52+mOa7o/SUQn8H5ZOMz1MCPMtNtFC/mOJ+DKJ43au
	1i7fC5xVHLFsBiM1AA9K4fUd0WqnzXZU=
X-Received: by 2002:a17:907:1c82:b0:b8e:9d66:f5fb with SMTP id
 a640c23a62f3a-b9081740d0dmr897366966b.0.1772022140395; Wed, 25 Feb 2026
 04:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14fc2404e55d99e9d3a4f95e3e825678dc2422a0.1771971643.git.boris@bur.io>
In-Reply-To: <14fc2404e55d99e9d3a4f95e3e825678dc2422a0.1771971643.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Feb 2026 12:21:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H51BA98vD0VZYYEu+tdzLhHm6H69dTSCHeED17wNC8D2A@mail.gmail.com>
X-Gm-Features: AaiRm50Iyuxko7eQw9kBqVofW5MxeqLafT32drA3T8eCfgjFskrNx1ARhkLELxM
Message-ID: <CAL3q7H51BA98vD0VZYYEu+tdzLhHm6H69dTSCHeED17wNC8D2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21918-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3004019737F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:25=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> We have recently observed a number of subvolumes with broken dentries.
> ls-ing the parent dir looks like:
>
> drwxrwxrwt 1 root root 16 Jan 23 16:49 .
> drwxr-xr-x 1 root root 24 Jan 23 16:48 ..
> d????????? ? ?    ?     ?            ? broken_subvol
>
> and similarly stat-ing the file fails.
>
> In this state, deleting the subvol fails with ENOENT, but attempting to
> create a new file or subvol over it errors out with EEXIST and even
> aborts the fs. Which leaves us a bit stuck.
>
> dmesg contains a single notable error message reading:
> "could not do orphan cleanup -2"
>
> 2 is ENOENT and the error comes from the failure handling path of
> btrfs_orphan_cleanup(), with the stack leading back up to
> btrfs_lookup().
>
> btrfs_lookup
> btrfs_lookup_dentry
> btrfs_orphan_cleanup // prints that message and returns -ENOENT
>
> After some detailed inspection of the internal state, it became clear
> that:
> - there are no orphan items for the subvol
> - the subvol is otherwise healthy looking, it is not half-deleted or
>   anything, there is no drop progress, etc.
> - the subvol was created a while ago and does the meaningful first
>   btrfs_orphan_cleanup() call that sets BTRFS_ROOT_ORPHAN_CLEANUP much
>   later.
> - after btrfs_orphan_cleanup() fails, btrfs_lookup_dentry() returns -ENOE=
NT,
>   which results in a negative dentry for the subvolume via
>   d_splice_alias(NULL, dentry), leading to the observed behavior. The
>   bug can be mitigated by dropping the dentry cache, at which point we
>   can successfully delete the subvolume if we want.
>
> i.e.,
> btrfs_lookup()
>   btrfs_lookup_dentry()
>     if (!sb_rdonly(inode->vfs_inode)->vfs_inode)
>     btrfs_orphan_cleanup(sub_root)
>       test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP)
>       btrfs_search_slot() // finds orphan item for inode N
>       ...
>       prints "could not do orphan cleanup -2"
>   if (inode =3D=3D ERR_PTR(-ENOENT))
>     inode =3D NULL;
>   return d_splice_alias(NULL, dentry) // NEGATIVE DENTRY for valid subvol=
ume
>
> btrfs_orphan_cleanup() does test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP)
> on the root when it runs, so it cannot run more than once on a given
> root, so something else must run concurrently. However, the obvious
> routes to deleting an orphan when nlinks goes to 0 should not be able to
> run without first doing a lookup into the subvolume, which should run
> btrfs_orphan_cleanup() and set the bit.
>
> The final important observation is that create_subvol() calls
> d_instantiate_new() but does not set BTRFS_ROOT_ORPHAN_CLEANUP, so if
> the dentry cache gets dropped, the next lookup into the subvolume will
> make a real call into btrfs_orphan_cleanup() for the first time. This
> opens up the possibility of concurrently deleting the inode/orphan items
> but most typical evict() paths will be holding a reference on the parent
> dentry (child dentry holds parent->d_lockref.count via dget in
> d_alloc(), released in __dentry_kill()) and prevent the parent from
> being removed from the dentry cache.
>
> The one exception is delayed iputs. Ordered extent creation calls
> igrab() on the inode. If the file is unlinked and closed while those
> refs are held, iput() in __dentry_kill() decrements i_count but does
> not trigger eviction (i_count > 0). The child dentry is freed and the
> subvol dentry's d_lockref.count drops to 0, making it evictable while
> the inode is still alive.
>
> Since there are two races (the race between writeback and unlink and
> the race between lookup and delayed iputs), and there are too many moving
> parts, the following three diagrams show the complete picture.
> (Only the second and third are races)
>
> Phase 1:
> Create Subvol in dentry cache without BTRFS_ROOT_ORPHAN_CLEANUP set
>
> btrfs_mksubvol()
>   lookup_one_len()
>     __lookup_slow()
>       d_alloc_parallel()
>         __d_alloc() // d_lockref.count =3D 1
>   create_subvol(dentry)
>     // doesn't touch the bit..
>     d_instantiate_new(dentry, inode) // dentry in cache with d_lockref.co=
unt =3D=3D 1
>
> Phase 2:
> Create a delayed iput for a file in the subvol but leave the subvol in
> state where its dentry can be evicted (d_lockref.count =3D=3D 0)
>
> T1 (task)                    T2 (writeback)                   T3 (OE work=
queue)
>
> write() // dirty pages
>                               btrfs_writepages()
>                                 btrfs_run_delalloc_range()
>                                   cow_file_range()
>                                     btrfs_alloc_ordered_extent()
>                                       igrab() // i_count: 1 -> 2
> btrfs_unlink_inode()
>   btrfs_orphan_add()
> close()
>   __fput()
>     dput()
>       finish_dput()
>         __dentry_kill()
>           dentry_unlink_inode()
>             iput() // 2 -> 1
>           --parent->d_lockref.count // 1 -> 0; evictable

So my previous comment from v1 still stands:

"Where does this decrement of parent->d_lockref.count happens exactly?

I don't see it immediately in iput(), or iput_final(). Please put the
full call chain."

Thanks.



>                                                                 finish_or=
dered_fn()
>                                                                   btrfs_f=
inish_ordered_io()
>                                                                     btrfs=
_put_ordered_extent()
>                                                                       btr=
fs_add_delayed_iput()
>
> Phase 3:
> Once the delayed iput is pending and the subvol dentry is evictable,
> the shrinker can free it, causing the next lookup to go through
> btrfs_lookup() and call btrfs_orphan_cleanup() for the first time.
> If the cleaner kthread processes the delayed iput concurrently, the
> two race:
>
>   T1 (shrinker)              T2 (cleaner kthread)                        =
  T3 (lookup)
>
>   super_cache_scan()
>     prune_dcache_sb()
>       __dentry_kill()
>       // subvol dentry freed
>                               btrfs_run_delayed_iputs()
>                                 iput()  // i_count -> 0
>                                   evict()  // sets I_FREEING
>                                     btrfs_evict_inode()
>                                       // truncation loop
>                                                                          =
   btrfs_lookup()
>                                                                          =
     btrfs_lookup_dentry()
>                                                                          =
       btrfs_orphan_cleanup()
>                                                                          =
         // first call (bit never set)
>                                                                          =
         btrfs_iget()
>                                                                          =
           // blocks on I_FREEING
>
>                                       btrfs_orphan_del()
>                                       // inode freed
>                                                                          =
           // returns -ENOENT
>                                                                          =
         btrfs_del_orphan_item()
>                                                                          =
           // -ENOENT
>                                                                          =
       // "could not do orphan cleanup -2"
>                                                                          =
   d_splice_alias(NULL, dentry)
>                                                                          =
   // negative dentry for valid subvol
>
> The most straightforward fix is to ensure the invariant that a dentry
> for a subvolume can exist if and only if that subvolume has
> BTRFS_ROOT_ORPHAN_CLEANUP set on its root (and is known to have no
> orphans or ran btrfs_orphan_cleanup()).
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - fixed some typographical errors in the commit message.
> - improved the commit message with more callstacks / details.
>
> ---
>  fs/btrfs/ioctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b8db877be61cc..77f7db18c6ca5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -672,6 +672,13 @@ static noinline int create_subvol(struct mnt_idmap *=
idmap,
>                 goto out;
>         }
>
> +       /*
> +        * Subvolumes have orphans cleaned on first dentry lookup. A new
> +        * subvolume cannot have any orphans, so we should set the bit be=
fore we
> +        * add the subvolume dentry to the dentry cache, so that it is in=
 the
> +        * same state as a subvolume after first lookup.
> +        */
> +       set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &new_root->state);
>         d_instantiate_new(dentry, new_inode_args.inode);
>         new_inode_args.inode =3D NULL;
>
> --
> 2.47.3
>
>

