Return-Path: <linux-btrfs+bounces-21733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMh5FmnjlGmjIgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21733-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:53:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F71512AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0F9030B38F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A262FD698;
	Tue, 17 Feb 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe9q9MZ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40B2FC876
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364900; cv=none; b=iY8Y5b/8ut/OYm64PFSw7e6VO71PDMgMuhVXLoHrNEH+JiS8H7XpXNz2DNzNb5mdzEBG7uZUfVJVJ1F3RaB4ifMONFoHwBcmKPDgvHrWkZM59lNzjfaWhryJJb3lND4nS4OU9LOhghYCXbiOvu5qDLt9w6AE1iCADUgqQthxJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364900; c=relaxed/simple;
	bh=SEYmbJpaVbRYH0eprGidOc3qTl4OUCqb9WeN5Oeb9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrmvtSDf5X1PI/jepue54IWyvPgSrswVvB01hk+DKDCMZ9ewKxqAEwfoRYOfWmy+Mnf/MTOGW9FvZ+E+U4D9LADo9qmLnOYJ3N//F9RBfAjs0xAlCvwy0A/K6vZOtMIcKeQS5QsW1UuWmVp18Ot5/WBwQWn0makq3+oPqhxtKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe9q9MZ+; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso4331093d50.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771364898; x=1771969698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHcy8rmXa7JKuFUwTP2EgWfbziWdThJDQc/xHjTizro=;
        b=Oe9q9MZ+9exwgH0GFQ0iX1cBs9qmqE5JICZlpLeYHHEv5lQqBilak1ex7U4bLo6XbY
         htLUqCn64RMObMmxkDztkZ77wFRDOX0qx8svPhX5an1mRK6l4fL1W/vZghlp7SkRtJzm
         J/+GicXevDu6wRyRa2tUSCuLd7CNf4hCGHhFqWeCYgZr2psSXMwLqbtUKSqn8hLzT52f
         hU5zxUyDgKdj3iUVmv32SX9OcPF99YO1OPStiNN2Sv3ZYgEgCR3dr2uarCVJigZhaybG
         T4k5qFuJ17/Qadd36gQttDz4XogOxeEyYO0/nHY61gNydQTuhJC8SX4ymZk5dts5d014
         o/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771364898; x=1771969698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHcy8rmXa7JKuFUwTP2EgWfbziWdThJDQc/xHjTizro=;
        b=cmX8No/5LM9wdZ8sZWHO0sWLAHgEs0+9DFbFQYE2GKQMSl+zADeq4TTZ/y1ctTWMZ/
         yChLUD2l9sP2cbkH4hn9OM1js11QTq01e8iQhK3obFZyldOG15CzcPcigJEP9YbcE86h
         iLG47lhXQi7HjyrWS467NU9EeEoxj6o+y1P4BspKgE6T2OEyv1knvTB1O+Ww49NOop/g
         oIaFMkDl5tpshTGuOVJjWYnXZ1sdGbCmLQnNoxR+nQ/ht9cLSaqGpY+cglsO60TYGjjc
         3kRxhkijTpsjzpwZogl8eZJJ7Tuxsg934k6nIOC0cEGE5qT6Hm1FFQYujIYNVzcUDnvJ
         xdsg==
X-Gm-Message-State: AOJu0Yxhe56bmuLaDI+KFVSKoQgZqgX2Lx+WTl/fiohNR7k75ugD1pxQ
	WcItYbOuoyNVamQyFrvV8trKvkYxMJSFKmdd3H4NIi6IJT6FfkhBl+suPj/846m2
X-Gm-Gg: AZuq6aJ96y+U2u6Q67ifaVN8lhZYQFJKgJLHaKNKjp5IVssofZi7hNzhX3RGCncAGYj
	5q3PbahwsivYy3VDUl2KvqXpKIiEv2xS8tczpbHHsaaDK/rHHmJ68uIp+wmiLBSMsWOXii7311V
	epmayMBXTjSGzu8LVSbRfeswVgIBI2dIGmns9yR9hk0OqJgUZCZc7feOUIVfYhCBqcmEOeH5M4Y
	AtfAUYJIEb9JPDzdNOBEeTdTg3mc2l8ffkhSzQpG33pUSzIHu5j28cPfKqiDH76B7+bLQf5qRFs
	AdsIOjA3f0Mln1tn4Be8SMSc8vo2oYv+xN8P7xbkK/g1cZm7wwYV/FisFc52TWUKVw/Xh8A3P2J
	mAYqc0f3AqW+VjnH8o7X/qZstMFVewClHhn26Q7ZGkDrCKbejZzOdH6qlJh0IOm0fD0MOl9WaX4
	163l5nBfq/6WsedMj768svNbkei5bQ
X-Received: by 2002:a05:690e:1914:b0:64a:d705:31d0 with SMTP id 956f58d0204a3-64c197a929amr10819400d50.28.1771364898024;
        Tue, 17 Feb 2026 13:48:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f005sm5234577d50.3.2026.02.17.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 13:48:17 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: skip COW for written extent buffers allocated in current transaction
Date: Tue, 17 Feb 2026 13:48:08 -0800
Message-ID: <20260217214815.658944-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H54zGbpSiwnJXXg0pXLUQtZSwQ65X8iN716Tko0EtynRQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21733-lists,linux-btrfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A07F71512AF
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 12:18:48 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Fri, Feb 13, 2026 at 8:38 PM Leo Martins <loemra.dev@gmail.com> wrote:
> >
> > When memory pressure causes writeback of a recently COW'd buffer,
> > btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
> > btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
> > the buffer unnecessarily, causing COW amplification that can exhaust
> > block reservations and degrade throughput.
> >
> > Overwriting in place is crash-safe because the committed superblock
> > does not reference buffers allocated in the current (uncommitted)
> > transaction, so no on-disk tree points to this block yet.
> >
> > When should_cow_block() encounters a WRITTEN buffer whose generation
> > matches the current transaction, instead of requesting a COW, re-dirty
> > the buffer and re-register its range in the transaction's dirty_pages.
> >
> > Both are necessary because btrfs tracks dirty metadata through two
> > independent mechanisms. set_extent_buffer_dirty() sets the
> > EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
> > mark, which is what background writeback (btree_write_cache_pages) uses
> > to find and write dirty buffers. The transaction's dirty_pages io tree
> > is a separate structure used by btrfs_write_and_wait_transaction() at
> > commit time to ensure all buffers allocated during the transaction are
> > persisted. The dirty_pages range was originally registered in
> > btrfs_init_new_buffer() when the block was first allocated, but
> > background writeback may have already written and cleared it.
> 
> This is not quite correct, the dirty_pages range is never cleared on
> background writeback.
> We only clear it during a transaction commit, in
> btrfs_write_and_wait_transaction().
> 
> Normally we shouldn't care about setting the range again in
> dirty_pages, because after
> we call  btrfs_write_and_wait_transaction(), no more COW should be
> possible using this
> transaction (which is in the unblocked state, so any new COW attempt
> will be in another transaction).
> 
> The exception is if we have snapshots to create and qgroups are
> enabled, since in qgroup_account_snapshot() we
> call btrfs_write_and_wait_transaction() and after that we can get more
> COW, due to all the stuff we need to do to
> create a snapshot, before we get to the final call to
> btrfs_write_and_wait_transaction() right before we write the
> super blocks in btrfs_commit_transaction().

Got it, thanks for the correction. Updated in v3.

Thanks,
Leo

> 
> >
> > Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> > correctly pins the block if it is freed later.
> >
> > Exclude cases where in-place overwrite is not safe:
> >  - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
> >  - Zoned devices: require sequential writes
> >  - Log trees: log blocks are immediately referenced by a committed
> >    superblock via btrfs_sync_log(), so overwriting could corrupt the
> >    committed log
> >  - BTRFS_ROOT_FORCE_COW: snapshot in progress
> >  - BTRFS_HEADER_FLAG_RELOC: block being relocated
> >
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >  fs/btrfs/ctree.c | 53 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 7267b2502665..a345e1be24d8 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -599,9 +599,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
> >         return ret;
> >  }
> >
> > -static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> > +static inline bool should_cow_block(struct btrfs_trans_handle *trans,
> >                                     const struct btrfs_root *root,
> > -                                   const struct extent_buffer *buf)
> > +                                   struct extent_buffer *buf)
> >  {
> >         if (btrfs_is_testing(root->fs_info))
> >                 return false;
> > @@ -621,8 +621,55 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> >         if (btrfs_header_generation(buf) != trans->transid)
> >                 return true;
> >
> > -       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> > +       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> > +               /*
> > +                * The buffer was allocated in this transaction and has been
> > +                * written back to disk (WRITTEN is set). Normally we'd COW
> > +                * it again, but since the committed superblock doesn't
> > +                * reference this buffer (it was allocated this transaction),
> 
> Missing an "in" before "this transaction".
> 
> > +                * we can safely overwrite it in place.
> > +                *
> > +                * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
> > +                * persisted at this bytenr and will be again after the
> > +                * in-place update. This is important so that
> > +                * btrfs_free_tree_block() correctly pins the block if it is
> > +                * freed later (e.g., during tree rebalancing or FORCE_COW).
> > +                *
> > +                * We re-dirty the buffer to ensure the in-place modifications
> > +                * will be written back to disk.
> > +                *
> > +                * Exclusions:
> > +                * - Log trees: log blocks are written and immediately
> > +                *   referenced by a committed superblock via
> > +                *   btrfs_sync_log(), bypassing the normal transaction
> > +                *   commit. Overwriting in place could corrupt the
> > +                *   committed log.
> > +                * - Zoned devices: require sequential writes
> > +                * - FORCE_COW: snapshot in progress
> > +                * - RELOC flag: block being relocated
> > +                */
> > +               if (!test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) &&
> > +                   !btrfs_is_zoned(root->fs_info) &&
> > +                   btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
> > +                   !test_bit(BTRFS_ROOT_FORCE_COW, &root->state) &&
> 
> We need a  smp_mb__before_atomic() before checking FORCE_COW, see the
> existing code below.
> 
> > +                   !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) {
> > +                       /*
> > +                        * Re-register this block's range in the current
> > +                        * transaction's dirty_pages so that
> > +                        * btrfs_write_and_wait_transaction() writes it.
> > +                        * The range was originally registered when the block
> > +                        * was allocated, but that transaction's dirty_pages
> > +                        * may have already been released.
> 
> I think it's worth adding something like: "... already been released
> if we are in a transaction that creates snapshots and we have qgroups
> enabled."
> 
> Otherwise it looks good, thanks!
> 
> > +                        */
> > +                       btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> > +                                            buf->start,
> > +                                            buf->start + buf->len - 1,
> > +                                            EXTENT_DIRTY, NULL);
> > +                       set_extent_buffer_dirty(buf);
> > +                       return false;
> > +               }
> >                 return true;
> > +       }
> >
> >         /* Ensure we can see the FORCE_COW bit. */
> >         smp_mb__before_atomic();
> > --
> > 2.47.3
> >
> >

