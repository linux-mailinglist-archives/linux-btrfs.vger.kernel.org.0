Return-Path: <linux-btrfs+bounces-21928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GSrLO8sn2lzZQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21928-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 18:10:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C195B19B495
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 18:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D1FC30440F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB23D646B;
	Wed, 25 Feb 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="xu5dQAMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aeWXtp2V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7333AE6E5
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039335; cv=none; b=kNf3JWhoV7zbATMyTFr+TrQ/v8Pw038flF8zxnNPFPeX8889n4DqvB4g0gIi+s15oto/+a+noz6mze5B8bpy0puKFveW55F1jQYbT8MILce/5cyPo9K3IihVkgPHEhGXzEq2xItjpqs/I5r7w7Q4wOVkcRc7Q9yBF55vIlChFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039335; c=relaxed/simple;
	bh=PMEUfYvnXI47dzDVtG4ApirLVWj9MzrA0xvLyQgfVEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTzM4WLz4Zqpamyg5mU5YsmZPcisS+F2VXaibhlwTFqH7RGsVn9k9ODcmuAE7ZEsAwEVxWsc+VhR3bvHkd3FM6rtxBBymp7ZbJPiOa4nExAjHr7fe1Y8PtPjEzPVffeKwzzLbplfgSJg2V0SWMbqZ7ZOkya0eIbSlDx1w8z7saU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=xu5dQAMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aeWXtp2V; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E38A7A00F4;
	Wed, 25 Feb 2026 12:08:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Feb 2026 12:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772039332;
	 x=1772125732; bh=KfooI87chwFpSHvHQTZ0geb9ekkKWf8toaJcreK6pLY=; b=
	xu5dQAMupTS9eDD9bNsSKFqdmj+2ooUaHCy+ryg5+PXyqSWNg3Cd5xHeiHiFSINg
	YP+o1FF8szdiQjA+QN7uf4Y/W1jrgP4n7ubYuIFsl0JQTDyZST3qXRycMA7VXWo7
	mCBC7JSRIDH2nBNV+489r/Nuax+lTXDzUsJEDAsGRoHn3YxEC8kChap1hBNKL96+
	dLPZObDv3X6SNLXAKvEsSvreo/gs+C5YR7PdwMmV71fxin6+le1czuyZ90PPnonD
	lu9ISuOfzNgGvJKXPJO3gVCKc4vmEYjcuHRO85G9sQd+WnzUfq1647dfD94qPl9f
	YPHO99pwn6HDfFzbWpFNcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772039332; x=
	1772125732; bh=KfooI87chwFpSHvHQTZ0geb9ekkKWf8toaJcreK6pLY=; b=a
	eWXtp2VcuDaYbbuCCzue7mkxvMbwC3cIRvBnLRufBz+8WZxph1Jp56l2If2gjbXi
	2+T1GzEtfjir2/E3ZTb1gEfowiPn2io0JRx10I/1NokckDBs3O6gUXQAEKOsTiy5
	2c+RfsnsDL0YIAFDJxVtlCxCYhHsdVoc5Btvg8h8LP+NCd4vr0wBfe0VrCC3wTUF
	Ah6vY2lFCphZTJExMQBD+AcIsLlFs24swhxgJ/X5ubro9lv/pXSmVnpe7UOp60l6
	ulS652CRrT49WDLXO0X9AApb0sokpnYiyff5jki8i6HumpuB6CNvKEM39TqGk6Q/
	hB4viNOK0uN8kSyGl5+mw==
X-ME-Sender: <xms:pCyfaTRcUmdkNxF7kCVdNeYhiu7_Qf75YqzBr1Ncgg6KRyfC_ciW-A>
    <xme:pCyfacPxqcaeVopJAZuMVo6PSmDzvaQtyhLX2UGkq3Ern8LsEPa2UzxNgHnPuFII1
    JyprudlWOcp-zllImtpOPVYY5-H-QFskex4gb8keCK0ZaftSPnhuA>
X-ME-Received: <xmr:pCyfaWMq03OJAE2cigXIhOkypf1sO1WZGJBG_lYe-ZGQ_ZQxafAfg_WczpKb7AqGFkCKKcYp3WSw2bEuq8tb4djIjhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgv
    lhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:pCyfacuBDN9avo6Tb3AfGHag5IgMANfjEcQuojjXv-oCnDnuaSt3lQ>
    <xmx:pCyfaQUhdVCKFyw4cmf1Q4MisQahyss41Qt5UKeNKyIOJ7UiNEwJDA>
    <xmx:pCyfaUsOt06tabQZ6kP4jmIhyDHC_pj_YIO81JOc0h3DCZ6skWM3YQ>
    <xmx:pCyfacWBv59vc0cJz1xSXvvUs81ZcRWXi2h_MK3n5zJaMVhVqPBSNg>
    <xmx:pCyfaQO29YJc0WbXmkYaHnzOXZxva0NSRHkFpI_iC-9qSXYEzODNE37A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 12:08:52 -0500 (EST)
Date: Wed, 25 Feb 2026 09:09:46 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/1] btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during
 subvol create
Message-ID: <20260225170921.GA682210@zen.localdomain>
References: <14fc2404e55d99e9d3a4f95e3e825678dc2422a0.1771971643.git.boris@bur.io>
 <CAL3q7H51BA98vD0VZYYEu+tdzLhHm6H69dTSCHeED17wNC8D2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H51BA98vD0VZYYEu+tdzLhHm6H69dTSCHeED17wNC8D2A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-21928-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: C195B19B495
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:21:43PM +0000, Filipe Manana wrote:
> On Tue, Feb 24, 2026 at 10:25 PM Boris Burkov <boris@bur.io> wrote:
> >
> > We have recently observed a number of subvolumes with broken dentries.
> > ls-ing the parent dir looks like:
> >
> > drwxrwxrwt 1 root root 16 Jan 23 16:49 .
> > drwxr-xr-x 1 root root 24 Jan 23 16:48 ..
> > d????????? ? ?    ?     ?            ? broken_subvol
> >
> > and similarly stat-ing the file fails.
> >
> > In this state, deleting the subvol fails with ENOENT, but attempting to
> > create a new file or subvol over it errors out with EEXIST and even
> > aborts the fs. Which leaves us a bit stuck.
> >
> > dmesg contains a single notable error message reading:
> > "could not do orphan cleanup -2"
> >
> > 2 is ENOENT and the error comes from the failure handling path of
> > btrfs_orphan_cleanup(), with the stack leading back up to
> > btrfs_lookup().
> >
> > btrfs_lookup
> > btrfs_lookup_dentry
> > btrfs_orphan_cleanup // prints that message and returns -ENOENT
> >
> > After some detailed inspection of the internal state, it became clear
> > that:
> > - there are no orphan items for the subvol
> > - the subvol is otherwise healthy looking, it is not half-deleted or
> >   anything, there is no drop progress, etc.
> > - the subvol was created a while ago and does the meaningful first
> >   btrfs_orphan_cleanup() call that sets BTRFS_ROOT_ORPHAN_CLEANUP much
> >   later.
> > - after btrfs_orphan_cleanup() fails, btrfs_lookup_dentry() returns -ENOENT,
> >   which results in a negative dentry for the subvolume via
> >   d_splice_alias(NULL, dentry), leading to the observed behavior. The
> >   bug can be mitigated by dropping the dentry cache, at which point we
> >   can successfully delete the subvolume if we want.
> >
> > i.e.,
> > btrfs_lookup()
> >   btrfs_lookup_dentry()
> >     if (!sb_rdonly(inode->vfs_inode)->vfs_inode)
> >     btrfs_orphan_cleanup(sub_root)
> >       test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP)
> >       btrfs_search_slot() // finds orphan item for inode N
> >       ...
> >       prints "could not do orphan cleanup -2"
> >   if (inode == ERR_PTR(-ENOENT))
> >     inode = NULL;
> >   return d_splice_alias(NULL, dentry) // NEGATIVE DENTRY for valid subvolume
> >
> > btrfs_orphan_cleanup() does test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP)
> > on the root when it runs, so it cannot run more than once on a given
> > root, so something else must run concurrently. However, the obvious
> > routes to deleting an orphan when nlinks goes to 0 should not be able to
> > run without first doing a lookup into the subvolume, which should run
> > btrfs_orphan_cleanup() and set the bit.
> >
> > The final important observation is that create_subvol() calls
> > d_instantiate_new() but does not set BTRFS_ROOT_ORPHAN_CLEANUP, so if
> > the dentry cache gets dropped, the next lookup into the subvolume will
> > make a real call into btrfs_orphan_cleanup() for the first time. This
> > opens up the possibility of concurrently deleting the inode/orphan items
> > but most typical evict() paths will be holding a reference on the parent
> > dentry (child dentry holds parent->d_lockref.count via dget in
> > d_alloc(), released in __dentry_kill()) and prevent the parent from
> > being removed from the dentry cache.
> >
> > The one exception is delayed iputs. Ordered extent creation calls
> > igrab() on the inode. If the file is unlinked and closed while those
> > refs are held, iput() in __dentry_kill() decrements i_count but does
> > not trigger eviction (i_count > 0). The child dentry is freed and the
> > subvol dentry's d_lockref.count drops to 0, making it evictable while
> > the inode is still alive.
> >
> > Since there are two races (the race between writeback and unlink and
> > the race between lookup and delayed iputs), and there are too many moving
> > parts, the following three diagrams show the complete picture.
> > (Only the second and third are races)
> >
> > Phase 1:
> > Create Subvol in dentry cache without BTRFS_ROOT_ORPHAN_CLEANUP set
> >
> > btrfs_mksubvol()
> >   lookup_one_len()
> >     __lookup_slow()
> >       d_alloc_parallel()
> >         __d_alloc() // d_lockref.count = 1
> >   create_subvol(dentry)
> >     // doesn't touch the bit..
> >     d_instantiate_new(dentry, inode) // dentry in cache with d_lockref.count == 1
> >
> > Phase 2:
> > Create a delayed iput for a file in the subvol but leave the subvol in
> > state where its dentry can be evicted (d_lockref.count == 0)
> >
> > T1 (task)                    T2 (writeback)                   T3 (OE workqueue)
> >
> > write() // dirty pages
> >                               btrfs_writepages()
> >                                 btrfs_run_delalloc_range()
> >                                   cow_file_range()
> >                                     btrfs_alloc_ordered_extent()
> >                                       igrab() // i_count: 1 -> 2
> > btrfs_unlink_inode()
> >   btrfs_orphan_add()
> > close()
> >   __fput()
> >     dput()
> >       finish_dput()
> >         __dentry_kill()
> >           dentry_unlink_inode()
> >             iput() // 2 -> 1
> >           --parent->d_lockref.count // 1 -> 0; evictable
> 
> So my previous comment from v1 still stands:
> 
> "Where does this decrement of parent->d_lockref.count happens exactly?
> 
> I don't see it immediately in iput(), or iput_final(). Please put the
> full call chain."

Sorry, I should have replied in greater detail. I added some callstack
context above dput but didn't clarify anything about __dentry_kill where
the real details are.

On current for-next I see teh decrement at fs/dcache.c:690 in
__dentry_kill() inside a conditional:

  if (parent && --parent->d_lockref.count) {
  ...
  }

I have never figured out a perfect way to mix function calls and
statements in these race diagrams with nesting and such, but I probably
should have written out the conditional? I tried to have it nested at
the "stuff inside __dentry_kill level" but after iput (which I also
wanted to put to show the inode ref count)

Let me know if you have any suggestions for how I can change it to make
it more clear!

Thanks,
Boris

> 
> Thanks.
> 
> 
> 
> >                                                                 finish_ordered_fn()
> >                                                                   btrfs_finish_ordered_io()
> >                                                                     btrfs_put_ordered_extent()
> >                                                                       btrfs_add_delayed_iput()
> >
> > Phase 3:
> > Once the delayed iput is pending and the subvol dentry is evictable,
> > the shrinker can free it, causing the next lookup to go through
> > btrfs_lookup() and call btrfs_orphan_cleanup() for the first time.
> > If the cleaner kthread processes the delayed iput concurrently, the
> > two race:
> >
> >   T1 (shrinker)              T2 (cleaner kthread)                          T3 (lookup)
> >
> >   super_cache_scan()
> >     prune_dcache_sb()
> >       __dentry_kill()
> >       // subvol dentry freed
> >                               btrfs_run_delayed_iputs()
> >                                 iput()  // i_count -> 0
> >                                   evict()  // sets I_FREEING
> >                                     btrfs_evict_inode()
> >                                       // truncation loop
> >                                                                             btrfs_lookup()
> >                                                                               btrfs_lookup_dentry()
> >                                                                                 btrfs_orphan_cleanup()
> >                                                                                   // first call (bit never set)
> >                                                                                   btrfs_iget()
> >                                                                                     // blocks on I_FREEING
> >
> >                                       btrfs_orphan_del()
> >                                       // inode freed
> >                                                                                     // returns -ENOENT
> >                                                                                   btrfs_del_orphan_item()
> >                                                                                     // -ENOENT
> >                                                                                 // "could not do orphan cleanup -2"
> >                                                                             d_splice_alias(NULL, dentry)
> >                                                                             // negative dentry for valid subvol
> >
> > The most straightforward fix is to ensure the invariant that a dentry
> > for a subvolume can exist if and only if that subvolume has
> > BTRFS_ROOT_ORPHAN_CLEANUP set on its root (and is known to have no
> > orphans or ran btrfs_orphan_cleanup()).
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v2:
> > - fixed some typographical errors in the commit message.
> > - improved the commit message with more callstacks / details.
> >
> > ---
> >  fs/btrfs/ioctl.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index b8db877be61cc..77f7db18c6ca5 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -672,6 +672,13 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * Subvolumes have orphans cleaned on first dentry lookup. A new
> > +        * subvolume cannot have any orphans, so we should set the bit before we
> > +        * add the subvolume dentry to the dentry cache, so that it is in the
> > +        * same state as a subvolume after first lookup.
> > +        */
> > +       set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &new_root->state);
> >         d_instantiate_new(dentry, new_inode_args.inode);
> >         new_inode_args.inode = NULL;
> >
> > --
> > 2.47.3
> >
> >

