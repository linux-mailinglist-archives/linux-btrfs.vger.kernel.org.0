Return-Path: <linux-btrfs+bounces-21244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA5MIyvVfGlbOwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21244-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 16:58:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41904BC4EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A37093006818
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224230BBB6;
	Fri, 30 Jan 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4EsQ2fh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3532E6BF
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788710; cv=none; b=LIuH0UF34P7/XCvU8I8VOAXtnFURV2Mma0feTdRRiWL/o5lNWmGWREZmqubI9gDIlr5dU0Oc1CJu6X8DZIjhvJcC4nnYRNYj/ylqI91eEaKH3f8FKmAu9hyxByrvKH5n3B7mTZPqJVtxjv12wBQnb1mS1MM/3lmcs0s1vS1N/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788710; c=relaxed/simple;
	bh=5mWSQnTz77bGgNvCYjfdFd5yOs33aNXYC4IFnTuEfg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfNFO6CumImJ2IS7YPKcOyf3K+9KRmmxtNCPxR/tDMQSrSgla0oUAmHoQPlLdADW/01nwT+8t03ueCY1uv1yOtui/CLXMYbY9QJSuWFIFKzOP1ZDpX6NsR6BW83GapCndFHST74fcoQvdqy+CDyu3ROaW6dnLMfGOCnNPbaNvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4EsQ2fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0253AC19421
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769788710;
	bh=5mWSQnTz77bGgNvCYjfdFd5yOs33aNXYC4IFnTuEfg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n4EsQ2fhlAcXkMl3nwtiUidQ2Fl3VwKaEj+KFuVfoUbdEF4Jxw75OGQjnJ5NwIL04
	 PIFEKY9KLL9KYrempnAfpNhJbAsE6u9hV/il9YY48Uljp0SGdyc8eNfTOFVjguvhnA
	 4OvcFfgWIeL89WBJZEDDCrMsV+RM9YEcgiR+jHFEBZ+tstDHwTBmJRsbAClGXnrW9W
	 u6/3b1QVv+BWFPSpdKwMrVY4+kzqiO7NunbCHG7RBMbVcd0VcdCvlsrfvb5thcwkh5
	 wfy/Z6fOLTXB71q6/DZ/uwSQyCBgA8qTLmrKfW14JGDZMkckAa02o2MJdy2EK3+51u
	 f+y27x0I78kIA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8de761c13eso240270866b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 07:58:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDbbBx58S1SN5nc7sje+j9G95QAErTNbx5jG7z1HQNWRBWKtayJf82UbJbbpOy+dEbL59VY3AKBlqNMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQUDNRYmjiNADT3DSwOmPYbkFlbmB0SFbyMIc2aZrFrND/ja2
	EDoHYJNCuhQzlJ/PJi3bvYpWT62vOzF1d07lw6EzfCmBWzrkLi97eJO3CSHvIvqEhBe1dgzWAZa
	sw2+iCduF758NRwmjB1TYuJKMtmuo9jg=
X-Received: by 2002:a17:907:9803:b0:b70:b700:df98 with SMTP id
 a640c23a62f3a-b8dff56f01bmr203607966b.5.1769788708415; Fri, 30 Jan 2026
 07:58:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H6P_jJL98Z+ZC6agmcXq1DbK7XXJDGG5WpzrCZtzNsfUg@mail.gmail.com>
 <20260130001254.83750-1-loemra.dev@gmail.com> <CAL3q7H5kf=vR1Jcc5NduS_jUROyE0WzXCLgzAe=wMVeZcBKOGw@mail.gmail.com>
 <20260130154349.GA1191016@zen.localdomain>
In-Reply-To: <20260130154349.GA1191016@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 30 Jan 2026 15:57:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7O9eAA+sapfsGfn=crF3Levk7wrFNVSbwEP4uMtLJbJA@mail.gmail.com>
X-Gm-Features: AZwV_QgZth5p58ja7XEBt6YR_kbNeBsbZQPAHiMHgzVe4v58W_erPbWSmn5c2Wg
Message-ID: <CAL3q7H7O9eAA+sapfsGfn=crF3Levk7wrFNVSbwEP4uMtLJbJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Boris Burkov <boris@bur.io>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com];
	TAGGED_FROM(0.00)[bounces-21244-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bur.io:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41904BC4EA
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:44=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Jan 30, 2026 at 12:49:55PM +0000, Filipe Manana wrote:
> > On Fri, Jan 30, 2026 at 12:13=E2=80=AFAM Leo Martins <loemra.dev@gmail.=
com> wrote:
> > >
> > > On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana <fdmanana@kernel.org=
> wrote:
> > >
> > > > On Tue, Jan 27, 2026 at 8:43=E2=80=AFPM Leo Martins <loemra.dev@gma=
il.com> wrote:
> > > > >
> > > > > I've been investigating enospcs at Meta and have observed a stran=
ge
> > > > > pattern where filesystems are enospcing with lots of unallocated =
space
> > > > > (> 100G). Sample dmesg dump at bottom of message.
> > > > >
> > > > > btrfs_insert_delayed_dir_index is attempting to migrate some rese=
rvation
> > > > > from the transaction block reserve and finding it exhausted leadi=
ng to a
> > > > > warning and enospc. This is a bug as the reservations are meant t=
o be
> > > > > worst case. It should be impossible to exhaust the transaction bl=
ock
> > > > > reserve.
> > > > >
> > > > > Some tracing of affected hosts revealed that there were single
> > > > > btrfs_search_slot calls that were COWing 100s of times. I was abl=
e to
> > > > > reproduce this behavior locally by creating a very constrained cg=
roup
> > > > > and producing a lot of concurrent filesystem operations. Here's t=
he
> > > > > pattern:
> > > > >
> > > > >  1. btrfs_search_slot() begins tree traversal with cow=3D1
> > > > >  2. Node at level N needs COW (old generation or WRITTEN flag set=
)
> > > > >  3. btrfs_cow_block() allocates new node, updates parent pointer
> > > > >  4. Traversal continues, but hits a condition requiring restart (=
e.g., node
> > > > >     not cached, lock contention, need higher write_lock_level)
> > > > >  5. btrfs_release_path() releases all locks and references
> > > > >  6. Memory pressure triggers writeback on the COW'd node
> > > > >  7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and se=
ts
> > > > >     BTRFS_HEADER_FLAG_WRITTEN
> > > > >  8. goto again - traversal restarts from root
> > > > >  9. Traversal reaches the freshly COW'd node
> > > > >  10. should_cow_block() sees WRITTEN flag set, returns true
> > > > >  11. btrfs_cow_block() allocates another new node - same logical =
position,
> > > > >      new physical location, new reservation consumed
> > > > >  12. Steps 4-11 repeat indefinitely under sustained memory pressu=
re
> > > > >
> > > > > Note this behavior should be much harder to trigger since Boris's
> > > > > AS_KERNEL_FILE changes that make it so that extent_buffer pages a=
ren't
> > > > > accounted for in user cgroups. However, I believe it
> > > > > would still be an issue under global memory pressure.
> > > > > Link: https://lore.kernel.org/linux-btrfs/cover.1755812945.git.bo=
ris@bur.io/
> > > > >
> > > > > This COW amplification breaks the idea that transaction reservati=
ons are
> > > > > worst case as any search slot call could find itself in this COW =
loop and
> > > > > exhaust its reservation.
> > > > >
> > > > > My proposed solution is to temporarily pin extent buffers for the
> > > > > lifetime of btrfs_search_slot. This prevents the massive COW
> > > > > amplification that can be seen during high memory pressure.
> > > > >
> > > > > The implementation uses a local xarray to track COW'd buffers for=
 the
> > > > > duration of the search. The xarray stores extent_buffer pointers =
without
> > > > > taking additional references; this is safe because tracked buffer=
s remain
> > > > > dirty (writeback_blockers prevents the dirty bit from being clear=
ed) and
> > > > > dirty buffers cannot be reclaimed by memory pressure.
> > > > >
> > > > > Synchronization is provided by eb->lock: increments in
> > > > > btrfs_search_slot_track_cow() occur while holding the write lock,=
 and
> > > > > the check in lock_extent_buffer_for_io() also holds the write loc=
k via
> > > > > btrfs_tree_lock(). Decrements don't require eb->lock because
> > > > > writeback_blockers is atomic and merely indicates "don't write ye=
t".
> > > > > Once we decrement, we're done and don't care if writeback proceed=
s
> > > > > immediately.
> > > >
> > > > This seems too complex to me.
> > > >
> > > > So this problem is very similar to some idea I had a few years ago =
but
> > > > never managed to implement.
> > > > It was about avoiding unnecessary COW, not for this space reservati=
on
> > > > exhaustion due to sustained memory pressure, but it would solve it
> > > > too.
> > > >
> > > > The idea was that we do unnecessary COW in cases like this:
> > > >
> > > > 1) We COW a path in some tree and we are at transaction N;
> > > >
> > > > 2) Writeback happened for the extent buffers in that path while we =
are
> > > > in the same transaction, because we reached the 32M limit and some
> > > > task called btrfs_btree_balance_dirty() or something else triggered
> > > > writeback of the btree inode;
> > > >
> > > > 3) While still at transaction N, we visit the same path to add an i=
tem
> > > > to a leaf, or modify an item, whatever. Because the extent buffers
> > > > have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block=
()
> > > > returns true).
> > > >
> > > > So during the lifetime of a transaction we can have a lot of
> > > > unnecessary COW - we spend more time allocating extents, allocating
> > > > memory, copying extent buffer data, use more space per transaction,
> > > > etc.
> > > >
> > > > The idea was to not COW when an extent buffer has
> > > > BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
> > > > (btrfs_header_generation(eb)) matches the current transaction.
> > > > That is safe because there's no committed tree that points to an
> > > > extent buffer created in the current transaction.
> > > >
> > > > Any further modification to the extent buffer must be sure that the
> > > > EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
> > > > transaction's dirty_pages io tree, etc, so that we don't miss writi=
ng
> > > > the extent buffer to the same location again before the transaction
> > > > commits the superblocks.
> > > >
> > > > Have you considered an approach like this?
> > >
> > > I had not considered this, but it is a great idea.
> > >
> > > My first thought is that implementing this could be as simple
> > > as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
> > > would mess with the assumptions around the log tree. From
> > > btrfs_sync_log():
> > >
> > > /*
> > >  * IO has been started, blocks of the log tree have WRITTEN flag set
> > >  * in their headers. new modifications of the log will be written to
> > >  * new positions. so it's safe to allow log writers to go in.
> > >  */
> > >
> > > ^ Assumes that WRITTEN blocks will be COW'd.
> > >
> > > The issue looks like:
> > >
> > >  1. fsync A COWs eb
> > >  2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
> > >  3. fsync B does __not__ COW eb and modifies it
> > >  4. fsync A writes modified eb to disk
> > >  5. CRASH; the log tree is corrupted
> > >
> > > One way to avoid that is to keep the current behavior for the log
> > > tree, but that leaves the potential for COW amplification...
> > >
> > > Another idea is to track the log_transid in the eb in the same way
> > > the transid is tracked. Then, in should_cow_block we have something
> > > like:
> > >
> > > if (btrfs_root_id(root) =3D=3D BTRFS_TREE_LOG_OBJECTID &&
> > >     buf->log_transid !=3D root->log_transid)
> > >   return true;
> >
> > Log trees are special since their lifetime doesn't span on
> > transaction, so what I suggested doesn't work of course for log trees
> > and I forgot to mention that.
> >
> > Tracking the log_transid in the extent buffer will not always work -
> > because it can be evicted and reloaded, so we would lose its value.
> > We would have to update the on-disk format to store it somewhere or
> > keep another in memory structure to track that, or prevent eviction of
> > log tree buffers - all of those are too complex.
>
> Supposing we cannot think of a way to do overwrites on log tree ebs,
> but that we can make it work for other ebs (excluding the zoned case
> you mentioned below):
>
> What do you think about the problem of space reservation exhaustion
> due to COW amplification when narrowed to just log trees? As far as I
> can tell, there is nothing special about how logged items consume
> transaction reservation so the problem would be reduced but still exist.

Log trees are small to start with, and if they ever hit -ENOSPC, we
just fallback to transaction commit.

>
> Do we want to pursue working out the kinkds in eb-overwrite (seems super
> valuable regardless of motivation) and think of some other final
> backstop for log tree ebs? Given that the fsync will be sending the ebs
> down to the disk quite soon anyway, I was thinking it might be more
> palatable to try to fully prevent premature writeback of log tree ebs.
>
> >
> > So I had this half baked patch from many years ago:
> >
> >  static int split_node(struct btrfs_trans_handle *trans, struct btrfs_r=
oot
> >                       *root, struct btrfs_path *path, int level);
> > @@ -1426,11 +1427,30 @@ static inline int should_cow_block(struct
> > btrfs_trans_handle *trans,
> >          *    block to ensure the metadata consistency.
> >          */
> >         if (btrfs_header_generation(buf) =3D=3D trans->transid &&
> > -           !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
> >             !(root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
> >               btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
> > -           !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
> > +           !test_bit(BTRFS_ROOT_FORCE_COW, &root->state)) {
> > +
> > +               if (root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJEC=
TID) {
> > +                       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WR=
ITTEN))
> > +                               return 1;
> > +                       return 0;
> > +               }
> > +
> > +               if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) ||
> > +                   test_bit(EXTENT_BUFFER_WRITE_ERR, &buf->bflags))
> > +                       return 1;
> >
> > This was before a recent refactoring of should_cow_block(), but you
> > should get the ideia.
> > IIRC all fstests were passing back then, except for one or two which I
> > never spent time debugging.
> >
> > And as that attempt was before the tree checker existed, we would need
> > to make sure we don't change and eb while the tree checker is
> > verifying it - making sure the tree checker read locks the eb should
> > be enough.
>
> I suspect this is what Sun was hitting in his replies to Leo.
>
> >
> > There's also one problem with this idea: it won't work for zoned
> > devices as writes are sequential and we can't write twice to the same
> > location without doing the zone reset thing which only happens around
> > transaction commit time IIRC.
> >
> > Thanks.
> >
>
> Thanks for your input on this, it's really appreciated,
> Boris
>
> > >
> > > Please let me know if you see any issues with this approach or
> > > if you can think of a better method.
> > >
> > > Thanks,
> > > Leo
> > >
> > > >
> > > > It would solve this space reservation exhaustion problem, as well a=
s
> > > > unnecessary COW for general optimization, without the need to for a
> > > > local xarray, which besides being very specific for the
> > > > btrfs_search_slot() case (we COW in other places), also requires a
> > > > memory allocation which can fail.
> > > >
> > > > Thanks.

