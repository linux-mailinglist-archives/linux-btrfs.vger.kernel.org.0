Return-Path: <linux-btrfs+bounces-21242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP5lEUHSfGlbOwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21242-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 16:46:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B2BC2BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 16:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43520302B3B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA7330337;
	Fri, 30 Jan 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YsVKzV/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2YPE4mR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E42315D33
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787862; cv=none; b=b9gW21seL5T3EwOfbrncLkBHCC9CcP0dMuPFuUnt3CcOWc5TBgvyCXkgpoI+VUWZZOmrynJkdGjaIzJKTxNlAVsc55Ju0q13bRLIzZ7M4WdPgReEYiC2PM/gFpTN8U1lJTj7tCGuD5v0yCWKwBboGVK04ZVy8lSdjs5K8CG3eXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787862; c=relaxed/simple;
	bh=czvS8F7dOV1RZqg9B9NZeChPs/H7atRzTEW64jrh70E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuQI+EN06H4ebzLgU+rfImhxIwZkXOKqI0cz0pcMKXAE526uPNjqrvbXpogro1UVxrxDGjpSNDmq2KmuLw3ZeFUUqOVlkDNBfcaUZWd863Pzdcdztah7K7BUKg31anvSTy/TMOqvxD5ytYc2rW63wPAeiBWimUggvAjOgfdKubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YsVKzV/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2YPE4mR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E15A7A011F;
	Fri, 30 Jan 2026 10:44:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 30 Jan 2026 10:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769787859;
	 x=1769874259; bh=P2JFAAGh65Txpnlj9TV8Yp8CrRdqKloVah9T9ASuWXg=; b=
	YsVKzV/C9gYTq8X4BN53Bn+8yZHYONo8xbOSgeISFGAZ/3NORdG25D3hunFKcrpy
	TmNraff0VMUqhBDTNw217iLbbjAUHS7fZTWGyXKi3VXzMfQQMu18OQbaTk8RMkhr
	nYDXWEjgm45/h802m9qEvFhf9sSfpLoBznOSI1cO3/IC/pvivdvbI0rI3L71hMcz
	6OmZKa91jeaZv0TBc7QItzFybrG4n1HRP6SrPYCW0qaqxaIlxLSb0ixhJQSrI6ei
	YZGQHfzKyk5wvUtDGvyMJWeQnIlaz7MB5N6ldH63v8/pI0++lfxaszL2mpwxBrcX
	dScOuAsIRnTWJXbSeB8GbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769787859; x=
	1769874259; bh=P2JFAAGh65Txpnlj9TV8Yp8CrRdqKloVah9T9ASuWXg=; b=o
	2YPE4mRPnSKsc7KNtX7yVi0k5NEdF8zil4K+G/97jCnFbEMzcFt8CvCkiu/9fzg6
	wOZvoFvNE8NFv7bNl4HJuzEYFjnok+6Pnaxr+YKmVLjBC2lTSzygK+v4HQ63zH8X
	udzIccGQlgME0PLP4HD7mr+4GwuGTvKVhulPTcXBNWl00kJbajOzUrvDpHwZaqTx
	zAlRooP1VFaxD8pUS+NwFRstHEOwBpA3h0zUclCwHxzsK8ZJMP+G6eASlb1re6Qg
	fEUZz/GjgCZt762ojGQpITvdAhL0IIsS6UntVsloxJNU5R2iK8On/J1cGpod/Y10
	uCSy2aZEwbQSoSK9mlOWA==
X-ME-Sender: <xms:0tF8acNzEQq0VZjEltkpgV7xpF5qODPzAVF0GGFzed5Aiumv36FcQw>
    <xme:0tF8aZ88YiwGvu-NQ_dG7zTUwdxse8eZrJAhZ6owpTMEPkLhGzwVaFjgULRHcBJyn
    tIAVpq6V5h5sIPMDNCB329wbnRMYdBSvpkpJN-ia5nxECsMIEJ-IVoE>
X-ME-Received: <xmr:0tF8aYS3yFr9aOn3jpqmNTRg7LYPmmONq5nrQlv3sjSKrzhgkEsp4drqk3U4H73DxikXVDB6PSF9Fm0gsgQbW6h7Lxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    fhudehgfekhedufedvtefgteelueeigfefhfefgeejkeefhefhgfekjefhvdehnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:0tF8aTnJJnvAHAacBDy_w6TmRnfBZ9Um6P0_2PBHvc1GCPYzIHj8eQ>
    <xmx:0tF8aQQZGuTNGIDBfKNQc3eCCp3vD5_Z7sfey8ZJmDiekvNbiIN9JA>
    <xmx:0tF8aZOM3Ge9z679NawaDxG18pRXwNgCMoZ51bN0CrKeYcIP5dJFxw>
    <xmx:0tF8aRUAo_hqOWGIN1ere2zmkZim8QfZBM7VwhgINg2_4dLXLEocyw>
    <xmx:09F8adPxKAlFWNxkY52JHL8C0EaZo6EzR8E2f1ViDNYdzk3sIMeZLmt6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 10:44:18 -0500 (EST)
Date: Fri, 30 Jan 2026 07:43:49 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
Message-ID: <20260130154349.GA1191016@zen.localdomain>
References: <CAL3q7H6P_jJL98Z+ZC6agmcXq1DbK7XXJDGG5WpzrCZtzNsfUg@mail.gmail.com>
 <20260130001254.83750-1-loemra.dev@gmail.com>
 <CAL3q7H5kf=vR1Jcc5NduS_jUROyE0WzXCLgzAe=wMVeZcBKOGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5kf=vR1Jcc5NduS_jUROyE0WzXCLgzAe=wMVeZcBKOGw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21242-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB4B2BC2BE
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:49:55PM +0000, Filipe Manana wrote:
> On Fri, Jan 30, 2026 at 12:13 AM Leo Martins <loemra.dev@gmail.com> wrote:
> >
> > On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > > On Tue, Jan 27, 2026 at 8:43 PM Leo Martins <loemra.dev@gmail.com> wrote:
> > > >
> > > > I've been investigating enospcs at Meta and have observed a strange
> > > > pattern where filesystems are enospcing with lots of unallocated space
> > > > (> 100G). Sample dmesg dump at bottom of message.
> > > >
> > > > btrfs_insert_delayed_dir_index is attempting to migrate some reservation
> > > > from the transaction block reserve and finding it exhausted leading to a
> > > > warning and enospc. This is a bug as the reservations are meant to be
> > > > worst case. It should be impossible to exhaust the transaction block
> > > > reserve.
> > > >
> > > > Some tracing of affected hosts revealed that there were single
> > > > btrfs_search_slot calls that were COWing 100s of times. I was able to
> > > > reproduce this behavior locally by creating a very constrained cgroup
> > > > and producing a lot of concurrent filesystem operations. Here's the
> > > > pattern:
> > > >
> > > >  1. btrfs_search_slot() begins tree traversal with cow=1
> > > >  2. Node at level N needs COW (old generation or WRITTEN flag set)
> > > >  3. btrfs_cow_block() allocates new node, updates parent pointer
> > > >  4. Traversal continues, but hits a condition requiring restart (e.g., node
> > > >     not cached, lock contention, need higher write_lock_level)
> > > >  5. btrfs_release_path() releases all locks and references
> > > >  6. Memory pressure triggers writeback on the COW'd node
> > > >  7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
> > > >     BTRFS_HEADER_FLAG_WRITTEN
> > > >  8. goto again - traversal restarts from root
> > > >  9. Traversal reaches the freshly COW'd node
> > > >  10. should_cow_block() sees WRITTEN flag set, returns true
> > > >  11. btrfs_cow_block() allocates another new node - same logical position,
> > > >      new physical location, new reservation consumed
> > > >  12. Steps 4-11 repeat indefinitely under sustained memory pressure
> > > >
> > > > Note this behavior should be much harder to trigger since Boris's
> > > > AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
> > > > accounted for in user cgroups. However, I believe it
> > > > would still be an issue under global memory pressure.
> > > > Link: https://lore.kernel.org/linux-btrfs/cover.1755812945.git.boris@bur.io/
> > > >
> > > > This COW amplification breaks the idea that transaction reservations are
> > > > worst case as any search slot call could find itself in this COW loop and
> > > > exhaust its reservation.
> > > >
> > > > My proposed solution is to temporarily pin extent buffers for the
> > > > lifetime of btrfs_search_slot. This prevents the massive COW
> > > > amplification that can be seen during high memory pressure.
> > > >
> > > > The implementation uses a local xarray to track COW'd buffers for the
> > > > duration of the search. The xarray stores extent_buffer pointers without
> > > > taking additional references; this is safe because tracked buffers remain
> > > > dirty (writeback_blockers prevents the dirty bit from being cleared) and
> > > > dirty buffers cannot be reclaimed by memory pressure.
> > > >
> > > > Synchronization is provided by eb->lock: increments in
> > > > btrfs_search_slot_track_cow() occur while holding the write lock, and
> > > > the check in lock_extent_buffer_for_io() also holds the write lock via
> > > > btrfs_tree_lock(). Decrements don't require eb->lock because
> > > > writeback_blockers is atomic and merely indicates "don't write yet".
> > > > Once we decrement, we're done and don't care if writeback proceeds
> > > > immediately.
> > >
> > > This seems too complex to me.
> > >
> > > So this problem is very similar to some idea I had a few years ago but
> > > never managed to implement.
> > > It was about avoiding unnecessary COW, not for this space reservation
> > > exhaustion due to sustained memory pressure, but it would solve it
> > > too.
> > >
> > > The idea was that we do unnecessary COW in cases like this:
> > >
> > > 1) We COW a path in some tree and we are at transaction N;
> > >
> > > 2) Writeback happened for the extent buffers in that path while we are
> > > in the same transaction, because we reached the 32M limit and some
> > > task called btrfs_btree_balance_dirty() or something else triggered
> > > writeback of the btree inode;
> > >
> > > 3) While still at transaction N, we visit the same path to add an item
> > > to a leaf, or modify an item, whatever. Because the extent buffers
> > > have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
> > > returns true).
> > >
> > > So during the lifetime of a transaction we can have a lot of
> > > unnecessary COW - we spend more time allocating extents, allocating
> > > memory, copying extent buffer data, use more space per transaction,
> > > etc.
> > >
> > > The idea was to not COW when an extent buffer has
> > > BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
> > > (btrfs_header_generation(eb)) matches the current transaction.
> > > That is safe because there's no committed tree that points to an
> > > extent buffer created in the current transaction.
> > >
> > > Any further modification to the extent buffer must be sure that the
> > > EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
> > > transaction's dirty_pages io tree, etc, so that we don't miss writing
> > > the extent buffer to the same location again before the transaction
> > > commits the superblocks.
> > >
> > > Have you considered an approach like this?
> >
> > I had not considered this, but it is a great idea.
> >
> > My first thought is that implementing this could be as simple
> > as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
> > would mess with the assumptions around the log tree. From
> > btrfs_sync_log():
> >
> > /*
> >  * IO has been started, blocks of the log tree have WRITTEN flag set
> >  * in their headers. new modifications of the log will be written to
> >  * new positions. so it's safe to allow log writers to go in.
> >  */
> >
> > ^ Assumes that WRITTEN blocks will be COW'd.
> >
> > The issue looks like:
> >
> >  1. fsync A COWs eb
> >  2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
> >  3. fsync B does __not__ COW eb and modifies it
> >  4. fsync A writes modified eb to disk
> >  5. CRASH; the log tree is corrupted
> >
> > One way to avoid that is to keep the current behavior for the log
> > tree, but that leaves the potential for COW amplification...
> >
> > Another idea is to track the log_transid in the eb in the same way
> > the transid is tracked. Then, in should_cow_block we have something
> > like:
> >
> > if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID &&
> >     buf->log_transid != root->log_transid)
> >   return true;
> 
> Log trees are special since their lifetime doesn't span on
> transaction, so what I suggested doesn't work of course for log trees
> and I forgot to mention that.
> 
> Tracking the log_transid in the extent buffer will not always work -
> because it can be evicted and reloaded, so we would lose its value.
> We would have to update the on-disk format to store it somewhere or
> keep another in memory structure to track that, or prevent eviction of
> log tree buffers - all of those are too complex.

Supposing we cannot think of a way to do overwrites on log tree ebs,
but that we can make it work for other ebs (excluding the zoned case
you mentioned below):

What do you think about the problem of space reservation exhaustion
due to COW amplification when narrowed to just log trees? As far as I
can tell, there is nothing special about how logged items consume
transaction reservation so the problem would be reduced but still exist.

Do we want to pursue working out the kinkds in eb-overwrite (seems super
valuable regardless of motivation) and think of some other final
backstop for log tree ebs? Given that the fsync will be sending the ebs
down to the disk quite soon anyway, I was thinking it might be more
palatable to try to fully prevent premature writeback of log tree ebs.

> 
> So I had this half baked patch from many years ago:
> 
>  static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
>                       *root, struct btrfs_path *path, int level);
> @@ -1426,11 +1427,30 @@ static inline int should_cow_block(struct
> btrfs_trans_handle *trans,
>          *    block to ensure the metadata consistency.
>          */
>         if (btrfs_header_generation(buf) == trans->transid &&
> -           !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
>             !(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
>               btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
> -           !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
> +           !test_bit(BTRFS_ROOT_FORCE_COW, &root->state)) {
> +
> +               if (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID) {
> +                       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> +                               return 1;
> +                       return 0;
> +               }
> +
> +               if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) ||
> +                   test_bit(EXTENT_BUFFER_WRITE_ERR, &buf->bflags))
> +                       return 1;
> 
> This was before a recent refactoring of should_cow_block(), but you
> should get the ideia.
> IIRC all fstests were passing back then, except for one or two which I
> never spent time debugging.
> 
> And as that attempt was before the tree checker existed, we would need
> to make sure we don't change and eb while the tree checker is
> verifying it - making sure the tree checker read locks the eb should
> be enough.

I suspect this is what Sun was hitting in his replies to Leo.

> 
> There's also one problem with this idea: it won't work for zoned
> devices as writes are sequential and we can't write twice to the same
> location without doing the zone reset thing which only happens around
> transaction commit time IIRC.
> 
> Thanks.
> 

Thanks for your input on this, it's really appreciated,
Boris

> >
> > Please let me know if you see any issues with this approach or
> > if you can think of a better method.
> >
> > Thanks,
> > Leo
> >
> > >
> > > It would solve this space reservation exhaustion problem, as well as
> > > unnecessary COW for general optimization, without the need to for a
> > > local xarray, which besides being very specific for the
> > > btrfs_search_slot() case (we COW in other places), also requires a
> > > memory allocation which can fail.
> > >
> > > Thanks.

