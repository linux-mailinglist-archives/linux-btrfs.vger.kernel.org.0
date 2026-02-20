Return-Path: <linux-btrfs+bounces-21799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGr0HAM3mGkkDAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21799-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 11:27:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676A166CFE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 11:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E1D30484FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421133CEAA;
	Fri, 20 Feb 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwG+BrYz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248C336EE9
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583224; cv=none; b=LfafbauzNHq6ay2DSaLPqBCLIXVL9mXYOvb8K9kKUaTmtXnNSgGm85f1KAYaQEsZ8PlIeTfFMN2ld1jf59XUbbTDwTvX+dS4k9tBwA1USI6wq8Ls5QoJmPMqabeJoJeO/t4k8C716nmRaqKoU2wb+e2KXUPRoU3Cc47di9q7QCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583224; c=relaxed/simple;
	bh=aVvul8cP9KSae0wFnc275b4kprejmgSWdfzbu2FiXYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZZP+kn7ebTX6+ETpx/omkAdzF/tziE0z1RtJnrSoGKrfoPIYBddk+koOhxaNOlG0hV8Nk8ElIuGGdpL+q+HmBtrB7FFvfA7yOdr15Xl0ky3DVwAwnZtNAP0lVtMnQuEU0q+BAJOSGgtm3Fh5ncGBHfSh0zzFvcSU+egADyzlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwG+BrYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C080C116D0
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771583224;
	bh=aVvul8cP9KSae0wFnc275b4kprejmgSWdfzbu2FiXYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PwG+BrYznpY3xdDzPOhPdjcXCAQBwwQJActxmcsEMT37N+1DgJnHRFwYzfOdk0VJD
	 kSVPsRy1NRRkZem0b1yVaQHIoL/ZwN0pTyrM4/bLKlfVYEhvKGBWo8j5dCnzqahk/Z
	 4A+uJfXhTeOukEM46b0bC0FCUq9APImrvb4c1gMEGt5dxjsgOFiTS70r4CIejaJ5G+
	 3MKRZeeszvcXUlAqap4C6h34vbYOZCdOOKeenNA/chhpYP6yG13Sr6SuxJL92MoLwm
	 htQg2S25PD6HXwwtfcyPUXwIsDzti+IoHMPWriz9VAOtxZg+0Plg00qsxrU9gihxCi
	 mGIEmNlFlM+/w==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so326093366b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 02:27:04 -0800 (PST)
X-Gm-Message-State: AOJu0YwLFQa9IIlmg/3D44MGItfezoNAZnwPHv4f2+ETxEIyQmh8hgCS
	N6/S+pGe0CbXjFZ3TBmDe8OqtK6kCmQoOsK/4WRFf0L9E1r4/nle8LS5czgSptL1puIpo/zXQ1W
	rXtW1ZBTo8YlkJmUZuuix4xd09qkYyWw=
X-Received: by 2002:a17:907:980e:b0:b88:20c0:d378 with SMTP id
 a640c23a62f3a-b903da966d3mr589050966b.20.1771583222528; Fri, 20 Feb 2026
 02:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <718a3b0c2275324b9e287af7e4434f55a4a45901.1771529877.git.boris@bur.io>
In-Reply-To: <718a3b0c2275324b9e287af7e4434f55a4a45901.1771529877.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 20 Feb 2026 10:26:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4+3T0sXEy3q11Zo+mbw7cu-eo1DoBbkoOsgAwYjhRQSQ@mail.gmail.com>
X-Gm-Features: AaiRm53LnVcYoPo7ibZNv9opJ5euv9PyXXbUag0OD9ziBKEFCyg2ySLe3WpUkGw
Message-ID: <CAL3q7H4+3T0sXEy3q11Zo+mbw7cu-eo1DoBbkoOsgAwYjhRQSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21799-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bur.io:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1676A166CFE
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 7:38=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
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

Please include the stack trace in the changelog.

>
> After some detailed inspection of the internal state, it became clear
> that:
> - there are no orphan items for the subvol
> - the subvol is otherwise healthy looking, it is not half-deleted or
>   anything, there is no drop progress, etc.
> - the subvol was created a while ago and first does orphan_cleanup()

What do you mean by "first does"? The first call to btrfs_orphan_cleanup()?

Also please use full function name, orphan_cleanup() -> btrfs_orphan_cleanu=
p()

>   much later
> - after orphan_cleanup fails, btrfs_lookup_dentry() returns -ENOENT,

orphan_cleanup -> btrfs_orphan_cleanup()

>   which results in a negative dentry for the subvolume via
>   d_splice_alias(NULL, dentry), leading to the observed behavior. The
>   bug can be mitigated by dropping the dentry cache, at which point we
>   can successfully delete the subvolume if we want.
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
> parts, the following two diagrams show the complete picture. The first
> sets us up in a condition where we can evict the subvol dentry and there
> is a delayed iput on the inode:
>
> T1 (task)                    T2 (writeback)                   T3 (OE work=
queue)
>
> write() // dirty pages
>                               btrfs_writepages()
>                                 btrfs_run_delalloc_range()
>                                   cow_file_range()
>                                     btrfs_alloc_ordered_extent()
>                                       igrab() // i_count: 1 -> 1+N

I find this confusing:   1 -> 1 + N ?

Shouldn't it be 1 -> 2, meaning the igrab() increased i_count from 1 to 2?

> btrfs_unlink_inode()
>   btrfs_orphan_add()
> close()
>   __dentry_kill()
>     dentry_unlink_inode()
>       iput() // 1+N -> N
>     --parent->d_lockref.count

Where does this decrement of parent->d_lockref.count happens exactly?
I don't see it immediately in iput(), or iput_final(). Please put the
full call chain.


>     // count -> 0
>                                                                 finish_or=
dered_fn()
>                                                                   btrfs_f=
inish_ordered_io()
>                                                                     btrfs=
_put_ordered_extent()
>                                                                       btr=
fs_add_delayed_iput()
>
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

Looks reasonable to me.

Thanks!

>
> Signed-off-by: Boris Burkov <boris@bur.io>
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

