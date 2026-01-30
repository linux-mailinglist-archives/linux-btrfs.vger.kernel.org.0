Return-Path: <linux-btrfs+bounces-21252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jYy5CgYmfWkGQgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21252-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 22:43:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4DABED6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF6A73019B99
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D83346777;
	Fri, 30 Jan 2026 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggHfaoGh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9B2737F2
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809405; cv=none; b=IIpqF+xovfGoym2XEcy6E+tOSx7eDHSnt5C874ofdkB1OFAVHardmGUE0H/KpZF48/9IrzhCmgggiByZj9A3JJ46OoeEpJTL50AjOi2DvLOe6edABBibqVwMu955eZxdpNIzFo4ivrzxXzjLrvDECn1srOwrnCPY716uF3DAdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809405; c=relaxed/simple;
	bh=+QHqWlYgOFVqNukdWy0Kw+nvg5+XAYeFT6mdSgqkeds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaYzG39BnTuyYQ/Nxv0AYh94ikzRjhxRMTl6DRmelEu3snElT5KGkdCWegtjAjMqnJRn3i10SRD4smDRwFcFvqCQOASiideJPb8hClyY2ab+5wczv8MSpkG6J7+T49GRaUd7GXp1fGaefQM7XqzekEznuWi7lnf+eq1z+Y0kaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggHfaoGh; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-794265fb73bso26408567b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769809403; x=1770414203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw8DxODVad2Ccm8eyNn1BDTXqeXGKXAjnHB44Xgzznc=;
        b=ggHfaoGhY1eTIyC+38aj9mln6vAskinXAK7gnmUF8hYWfyq6b4aYHZcyQ9naQM0BXp
         e59dTnzf90wAi7UKJJWt7uR5fnqk9sgxZXUEHbs76ydbiYdAIJBHzI/4BY7FhEA9louy
         NXXgHWn+6k0QAmZaqKo7UGqSFkflgxUtKNKrbMwerELeA1gdwLJ5md3OtiqOBNIS0U/i
         2uS0so9Pzht11aAfFTeeGyAr6lyyjXHdz39UHPvettHpfDSTuYJVikjfQz/Y1pu7pGDO
         6CZxUvyaFVXa2rJ4LoRDH5hXZ1gdiRC8RuN5OEQN7MoStS2i2ftPHAFR3bP0GDoFyykT
         taLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769809403; x=1770414203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tw8DxODVad2Ccm8eyNn1BDTXqeXGKXAjnHB44Xgzznc=;
        b=bvHsHonM/Zvknd06Y6F9y8skUWh4T/9yIImjW9H8a0LinWQkkPLOayayvdMarA4lb7
         yHO9ljc4N/TyLYroyYWIxEq5IQ1buHPz12RLQb3nCEMfyxkd7X5WWXlfQSN6lvlHRj5t
         dHREUuVHY7/c0XipzdS8apgOI6lMWiNjvvU9R/lG/xZR2+Xd5OLt6GOUmc1i0wyJhv0/
         Bd3768m5fHCq47Z/CoUjoYStEVJZn5v7iPGn8elJkY6nO2Rw704j34MpcWW60jqwN/v6
         fxvY3sBzdFBdrkUZKK5CQFFYGNugu7ECCPKyObKUfo49fIRUnD91cYInihUVy664G2Db
         OJWg==
X-Gm-Message-State: AOJu0Yxeb0zvqviiH1UOodLYuF8eLlP5P2nnm5oucOY8u7kaB1k2/rsx
	m1L5Zk+bUNxRfmtqkiDv1fF9b70nOaW4BjrY2GpYkD/9v6/oA522Zhk1
X-Gm-Gg: AZuq6aKkPvdqWtT5P2hMfP/by4ZRojXlaa4MfRU6tvrWpbmhsAVDGdDzIOzzlm9Tfoi
	tEGmPYbMJLq31IZ2yMmmSDTb31mwZ1q8/c8i3krq2gzRQzLUfeCvEtFUlkGN2zeGPKmFXW/MtfX
	vkN2sQtcfkQkqGgE/y3RKtdYfxqvfyDkfW90RDEy/5XOOI/pf6OSpAUhPR4aHL/t27+Ak+iF/bJ
	+wdRoyqGUBBvim8JBE76SpRC21kUeBrcddCdWhrL2hDSsPpZIzvpbgxpgIHpN/XaZUVyBlqDZPw
	FXoB2St4tdnJxQy8edU/166wzTA+Dg1LM+792y83mw/6tNyig1dzmsAJaBBDwZxp25+O1ktNvd6
	L7OH87yvaPWNS+Z05euokPPuyjbKXwAKhJQ2mpzx8bcd656NoRtMNJxhwN9+GfQMubZQumEWmgg
	pRiGs+
X-Received: by 2002:a05:690c:e3c1:b0:793:8eec:3a85 with SMTP id 00721157ae682-7949ded8fcbmr41625997b3.31.1769809402795;
        Fri, 30 Jan 2026 13:43:22 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828d1d79sm39649717b3.48.2026.01.30.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 13:43:22 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
Date: Fri, 30 Jan 2026 13:43:17 -0800
Message-ID: <20260130214319.3714908-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H5kf=vR1Jcc5NduS_jUROyE0WzXCLgzAe=wMVeZcBKOGw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21252-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D4DABED6C
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 12:49:55 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

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

This is a great starting point. Will iterate on this and send
out a v2 next week.

Thanks,
Leo

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
> 
> There's also one problem with this idea: it won't work for zoned
> devices as writes are sequential and we can't write twice to the same
> location without doing the zone reset thing which only happens around
> transaction commit time IIRC.
> 
> Thanks.
> 
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

