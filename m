Return-Path: <linux-btrfs+bounces-21241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBAeMuaqfGkaOQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21241-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 13:58:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40784BACE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 13:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B2630C5993
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4237F8CF;
	Fri, 30 Jan 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKLQSDkG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24B37F0E6
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777437; cv=none; b=ZBeQk4aPlFBVER6MfG2jT/vCQ5qyIW3oVZP6s7JD9kF0ok86KKT5fyGL/0Tr73EYgbO4gxDkdMXuwBkdb1ZlkR6O32wlYLgFJZWVBnfIQGxCX7Nu7molYHoxB1BQzW1hRI6N9vhUBTY+0frBeboXrYV3JK3zOSSMBty3DArM/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777437; c=relaxed/simple;
	bh=LIa9DLKScaiSBYM8PR/BZLGGSGPh8uhE5J35293NXVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8SS0KAxUhjyuWc8dut4S6O2pko0XPKMObfmYyJO8TlwVSmD4twqoVCE6dwrC8dvjB69MToGs9EDuPfNS/6N0BAwwCl4C7IVXAozVOMOm8lYNEGWu7KG3KTlTkII8sbaaRimTPoGpfOm8NLH6udmd5VpQ33bPPKLzdfzpp3Yu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKLQSDkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DF2C4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769777436;
	bh=LIa9DLKScaiSBYM8PR/BZLGGSGPh8uhE5J35293NXVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cKLQSDkGKRthKSLEq5z300UnwURcvclDXzUVzzl8pyM4H+Qh/LVwt+3T95qPXxWQV
	 ybC79E/XQu6lmVUZ77PpAc3uVn5wmzHSmjbk6SUEgeMwRO+rNwJ/NEHXGH60coTraX
	 pyDP2g9Ojz3vAWTrW06nJ53qd1HIvtv9SJz6vZMQyVAFiKt1raMoF3sOjbTjoKZj5S
	 fg+j77GBKPmYLIp6YHSaOteemlSsbvPLMHd3pUAg62OeA9IAsexn+hw8n5zzfzWwgT
	 +2gLJgD4IS/sSqA1f6wWR9yBrjPDbBlkYT4OOERtgAQAX8NSssMveJgTyQw0242xps
	 s4NFKqiAz+Y3g==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so3073643a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 04:50:36 -0800 (PST)
X-Gm-Message-State: AOJu0YymMCoV/AFGF6CYMIyYkLtiHOgGGNbrGijjom8javGHasYSGWaR
	Kn5UOzuZsQnZunZ5BxLCssuK1ig5/b6pqZ24fpn3ZjRg/ZkZ7NgWnF46nq8pr+u1LXB9KyGz9vX
	2x89reQsFQGkws8oQhPTwUPuVwkVcG5E=
X-Received: by 2002:a17:907:d716:b0:b80:4030:1eca with SMTP id
 a640c23a62f3a-b8dff525e82mr165667766b.2.1769777433915; Fri, 30 Jan 2026
 04:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H6P_jJL98Z+ZC6agmcXq1DbK7XXJDGG5WpzrCZtzNsfUg@mail.gmail.com>
 <20260130001254.83750-1-loemra.dev@gmail.com>
In-Reply-To: <20260130001254.83750-1-loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 30 Jan 2026 12:49:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5kf=vR1Jcc5NduS_jUROyE0WzXCLgzAe=wMVeZcBKOGw@mail.gmail.com>
X-Gm-Features: AZwV_QhinoMyR6bBmzRJaqIePpz7sxPqGzFLOzPSdB6kmt70YV1taEPHncvkeDs
Message-ID: <CAL3q7H5kf=vR1Jcc5NduS_jUROyE0WzXCLgzAe=wMVeZcBKOGw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21241-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40784BACE7
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:13=E2=80=AFAM Leo Martins <loemra.dev@gmail.com>=
 wrote:
>
> On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana <fdmanana@kernel.org> wr=
ote:
>
> > On Tue, Jan 27, 2026 at 8:43=E2=80=AFPM Leo Martins <loemra.dev@gmail.c=
om> wrote:
> > >
> > > I've been investigating enospcs at Meta and have observed a strange
> > > pattern where filesystems are enospcing with lots of unallocated spac=
e
> > > (> 100G). Sample dmesg dump at bottom of message.
> > >
> > > btrfs_insert_delayed_dir_index is attempting to migrate some reservat=
ion
> > > from the transaction block reserve and finding it exhausted leading t=
o a
> > > warning and enospc. This is a bug as the reservations are meant to be
> > > worst case. It should be impossible to exhaust the transaction block
> > > reserve.
> > >
> > > Some tracing of affected hosts revealed that there were single
> > > btrfs_search_slot calls that were COWing 100s of times. I was able to
> > > reproduce this behavior locally by creating a very constrained cgroup
> > > and producing a lot of concurrent filesystem operations. Here's the
> > > pattern:
> > >
> > >  1. btrfs_search_slot() begins tree traversal with cow=3D1
> > >  2. Node at level N needs COW (old generation or WRITTEN flag set)
> > >  3. btrfs_cow_block() allocates new node, updates parent pointer
> > >  4. Traversal continues, but hits a condition requiring restart (e.g.=
, node
> > >     not cached, lock contention, need higher write_lock_level)
> > >  5. btrfs_release_path() releases all locks and references
> > >  6. Memory pressure triggers writeback on the COW'd node
> > >  7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
> > >     BTRFS_HEADER_FLAG_WRITTEN
> > >  8. goto again - traversal restarts from root
> > >  9. Traversal reaches the freshly COW'd node
> > >  10. should_cow_block() sees WRITTEN flag set, returns true
> > >  11. btrfs_cow_block() allocates another new node - same logical posi=
tion,
> > >      new physical location, new reservation consumed
> > >  12. Steps 4-11 repeat indefinitely under sustained memory pressure
> > >
> > > Note this behavior should be much harder to trigger since Boris's
> > > AS_KERNEL_FILE changes that make it so that extent_buffer pages aren'=
t
> > > accounted for in user cgroups. However, I believe it
> > > would still be an issue under global memory pressure.
> > > Link: https://lore.kernel.org/linux-btrfs/cover.1755812945.git.boris@=
bur.io/
> > >
> > > This COW amplification breaks the idea that transaction reservations =
are
> > > worst case as any search slot call could find itself in this COW loop=
 and
> > > exhaust its reservation.
> > >
> > > My proposed solution is to temporarily pin extent buffers for the
> > > lifetime of btrfs_search_slot. This prevents the massive COW
> > > amplification that can be seen during high memory pressure.
> > >
> > > The implementation uses a local xarray to track COW'd buffers for the
> > > duration of the search. The xarray stores extent_buffer pointers with=
out
> > > taking additional references; this is safe because tracked buffers re=
main
> > > dirty (writeback_blockers prevents the dirty bit from being cleared) =
and
> > > dirty buffers cannot be reclaimed by memory pressure.
> > >
> > > Synchronization is provided by eb->lock: increments in
> > > btrfs_search_slot_track_cow() occur while holding the write lock, and
> > > the check in lock_extent_buffer_for_io() also holds the write lock vi=
a
> > > btrfs_tree_lock(). Decrements don't require eb->lock because
> > > writeback_blockers is atomic and merely indicates "don't write yet".
> > > Once we decrement, we're done and don't care if writeback proceeds
> > > immediately.
> >
> > This seems too complex to me.
> >
> > So this problem is very similar to some idea I had a few years ago but
> > never managed to implement.
> > It was about avoiding unnecessary COW, not for this space reservation
> > exhaustion due to sustained memory pressure, but it would solve it
> > too.
> >
> > The idea was that we do unnecessary COW in cases like this:
> >
> > 1) We COW a path in some tree and we are at transaction N;
> >
> > 2) Writeback happened for the extent buffers in that path while we are
> > in the same transaction, because we reached the 32M limit and some
> > task called btrfs_btree_balance_dirty() or something else triggered
> > writeback of the btree inode;
> >
> > 3) While still at transaction N, we visit the same path to add an item
> > to a leaf, or modify an item, whatever. Because the extent buffers
> > have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
> > returns true).
> >
> > So during the lifetime of a transaction we can have a lot of
> > unnecessary COW - we spend more time allocating extents, allocating
> > memory, copying extent buffer data, use more space per transaction,
> > etc.
> >
> > The idea was to not COW when an extent buffer has
> > BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
> > (btrfs_header_generation(eb)) matches the current transaction.
> > That is safe because there's no committed tree that points to an
> > extent buffer created in the current transaction.
> >
> > Any further modification to the extent buffer must be sure that the
> > EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
> > transaction's dirty_pages io tree, etc, so that we don't miss writing
> > the extent buffer to the same location again before the transaction
> > commits the superblocks.
> >
> > Have you considered an approach like this?
>
> I had not considered this, but it is a great idea.
>
> My first thought is that implementing this could be as simple
> as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
> would mess with the assumptions around the log tree. From
> btrfs_sync_log():
>
> /*
>  * IO has been started, blocks of the log tree have WRITTEN flag set
>  * in their headers. new modifications of the log will be written to
>  * new positions. so it's safe to allow log writers to go in.
>  */
>
> ^ Assumes that WRITTEN blocks will be COW'd.
>
> The issue looks like:
>
>  1. fsync A COWs eb
>  2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
>  3. fsync B does __not__ COW eb and modifies it
>  4. fsync A writes modified eb to disk
>  5. CRASH; the log tree is corrupted
>
> One way to avoid that is to keep the current behavior for the log
> tree, but that leaves the potential for COW amplification...
>
> Another idea is to track the log_transid in the eb in the same way
> the transid is tracked. Then, in should_cow_block we have something
> like:
>
> if (btrfs_root_id(root) =3D=3D BTRFS_TREE_LOG_OBJECTID &&
>     buf->log_transid !=3D root->log_transid)
>   return true;

Log trees are special since their lifetime doesn't span on
transaction, so what I suggested doesn't work of course for log trees
and I forgot to mention that.

Tracking the log_transid in the extent buffer will not always work -
because it can be evicted and reloaded, so we would lose its value.
We would have to update the on-disk format to store it somewhere or
keep another in memory structure to track that, or prevent eviction of
log tree buffers - all of those are too complex.

So I had this half baked patch from many years ago:

 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
                      *root, struct btrfs_path *path, int level);
@@ -1426,11 +1427,30 @@ static inline int should_cow_block(struct
btrfs_trans_handle *trans,
         *    block to ensure the metadata consistency.
         */
        if (btrfs_header_generation(buf) =3D=3D trans->transid &&
-           !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
            !(root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
              btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
-           !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
+           !test_bit(BTRFS_ROOT_FORCE_COW, &root->state)) {
+
+               if (root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID)=
 {
+                       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTE=
N))
+                               return 1;
+                       return 0;
+               }
+
+               if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) ||
+                   test_bit(EXTENT_BUFFER_WRITE_ERR, &buf->bflags))
+                       return 1;

This was before a recent refactoring of should_cow_block(), but you
should get the ideia.
IIRC all fstests were passing back then, except for one or two which I
never spent time debugging.

And as that attempt was before the tree checker existed, we would need
to make sure we don't change and eb while the tree checker is
verifying it - making sure the tree checker read locks the eb should
be enough.

There's also one problem with this idea: it won't work for zoned
devices as writes are sequential and we can't write twice to the same
location without doing the zone reset thing which only happens around
transaction commit time IIRC.

Thanks.

>
> Please let me know if you see any issues with this approach or
> if you can think of a better method.
>
> Thanks,
> Leo
>
> >
> > It would solve this space reservation exhaustion problem, as well as
> > unnecessary COW for general optimization, without the need to for a
> > local xarray, which besides being very specific for the
> > btrfs_search_slot() case (we COW in other places), also requires a
> > memory allocation which can fail.
> >
> > Thanks.

