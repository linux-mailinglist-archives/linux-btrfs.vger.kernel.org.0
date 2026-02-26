Return-Path: <linux-btrfs+bounces-21945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMeIGewn2kAdQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21945-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 03:31:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A73071A01E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 03:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 420F13028D63
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19504285CA3;
	Thu, 26 Feb 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuoWy9ft"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F412C859
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073056; cv=none; b=NtGouO5mp8Ju1PKi5bkbFFbOgvjyiSqhI9Rjcd/fOf5alUHwnvSgavDbQqzxAbNYKgoaCzGTQxc1zOToyn9/YaVYdu8rv+kVltY5nR69kimVoI2Zw/wEBYZyrrepH8Dw4BbCYovo4hWlPitETwBhwqqNNBWbGJVu+rr6yE79JIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073056; c=relaxed/simple;
	bh=f7FsqIVd9aJslHk5+ve1BohHw6jwbtkBLPLp3d3573c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTo7FQpM7MG1cOReSgojkjzS6eX5ItTmOaCGxNGg2x7xbBxJGBkZpjTlZO/RjOWljXfsiPxiNc8BH/YUfrC6UIH+BQQu27n/3CAEiloF5xDSK7p6kPMSnc1XSFEh+nINaFpBWcoqRr/Psg3/RRLvKLxVgXii0r7sl66uY1hpSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuoWy9ft; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64cb577e79cso330684d50.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 18:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772073054; x=1772677854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fniyo8nMFXcZyk2Mf81kadnn7U5/qe6oXznFmSRSkZA=;
        b=OuoWy9ftYdOpfvYerYOyeP17UkFWQPiUx5fwDbA2+I/zR8lSuc6eJBEn4aW7xTocyC
         tPBskj/JMqyNMSIoPL7wKnsD8ctFufDbzLkNhjll+R+M8wHaeR4w4x5qZdw7zkJwL38A
         REnt13XfAYIl+oCD5noAXy/83uh9hG48YtD+t6K6FjrdprkNR8F/uvm+ZaIlKFWb5KAx
         WC5ePv6/P+av6YQPDeaqZ6vKxiCgFbghLNv8qKE9Pu2Mj0D4OjFokewfSQQ1ajzJu0Ce
         /bVl0/c8kAFN6UTYpy88ln/B2RP7XNU1gElyrqEEkNCk2Ts5GaTXHB7dvlRIlcDPJWvl
         /jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073054; x=1772677854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fniyo8nMFXcZyk2Mf81kadnn7U5/qe6oXznFmSRSkZA=;
        b=QIA+5zUUPPqkER7oBqjRK9O96JySYF6yO15yt8VmbewHvEiank+urWpy+0bMPFUMex
         xC0ZPu0g5DpgC2MWgYY6vg8TqESw0hh9y5Bl6g7OVFV2OZ4LIFU9FGfp0Giugmkzpni4
         gUQCX8EPq+YSk9EMhMOaEEvA4H2NHeibdzqCkdnzFORtcpcl1ux5ZUp+JESk4hRNTkMW
         j0+4MzsrG9vUxDDjOA34ptej0pIgX/Lev+C7cwSBRWolHMqn64cb2LIe37EOTVcHWWP1
         EYDWrlKaoOjGRFF5iNW/H5QGDnBdJ6zKG6STVVT5bWSFkEn37bw/Lwl1w1RZnvelng2y
         jnxA==
X-Gm-Message-State: AOJu0YzQOegmH3uZ+i8lde/PWr4GG4JE42YJkUV+euN6selGtp/WK0IG
	hTDMyD1E1taKITDU+ZYXxvK5vuIFnL0iLOADScFd/z0Zr+S1bV86irBQCPlqo6MX
X-Gm-Gg: ATEYQzzFR7QAefDCvrVxbVh6mB4bWH1byTRYQF07NoxP/fyY7W4Dfzcme4FNE4rPDDi
	zq8pPTGvESUlsAK8ziSxPcwNm8wfmRTHe0XK8JkODJn1hGQh40RzgAVFdtm5v+ZjvrGPf7BsiSJ
	FNpg2mb8yfTPdJS+OEWVHXFGmBHZwSMEFXSxv0ule7c3tweWVd6gz9ijgzapsn1zOfWRdv9pcur
	bRvv/RXHcX17RC3cdvN3Llc9DhEUSjk60aBmi05vWe7d5wXh4TfE6V/aHBLCWuIzTyHvjVUs3s1
	b4MXMYbOd7XX6JiQtS/Crj1Hes9ASzDRsMrG6HVRy2j62mNX5BylEuTQPvxMH9R3aS9YZcTR1uk
	JTlEtDTKF+Kps4gVXopSJwDabP6xAlDyVmQSE6350pu12SAem/Y0aIAlgAoDQ8lJ47wl743YVzC
	vbXcRRL+EykuaLuJW0ViM0vxBjXGsr
X-Received: by 2002:a53:c7c9:0:b0:649:b100:4c6e with SMTP id 956f58d0204a3-64c78d3f28emr10612364d50.60.1772073053674;
        Wed, 25 Feb 2026 18:30:53 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb763d660sm381339d50.17.2026.02.25.18.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 18:30:53 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3 2/3] btrfs: inhibit extent buffer writeback to prevent COW amplification
Date: Wed, 25 Feb 2026 18:30:47 -0800
Message-ID: <20260226023050.2138594-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8b4f2be8-169d-4e10-a47f-b534ab0ebac6@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21945-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A73071A01E6
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 14:17:24 +0800 Sun YangKai <sunk67188@gmail.com> wrote:

> 
> 
> On 2026/2/25 03:22, Leo Martins wrote:
> > Inhibit writeback on COW'd extent buffers for the lifetime of the
> > transaction handle, preventing background writeback from setting
> > BTRFS_HEADER_FLAG_WRITTEN and causing unnecessary re-COW.
> > 
> > COW amplification occurs when background writeback flushes an extent
> > buffer that a transaction handle is still actively modifying. When
> > lock_extent_buffer_for_io() transitions a buffer from dirty to
> > writeback, it sets BTRFS_HEADER_FLAG_WRITTEN, marking the block as
> > having been persisted to disk at its current bytenr. Once WRITTEN is
> > set, should_cow_block() must either COW the block again or overwrite
> > it in place, both of which are unnecessary overhead when the buffer
> > is still being modified by the same handle that allocated it. By
> > inhibiting background writeback on actively-used buffers, WRITTEN is
> > never set while a transaction handle holds a reference to the buffer,
> > avoiding this overhead entirely.
> > 
> > Add an atomic_t writeback_inhibitors counter to struct extent_buffer,
> > which fits in an existing 6-byte hole without increasing struct size.
> > When a buffer is COW'd in btrfs_force_cow_block(), call
> > btrfs_inhibit_eb_writeback() to store the eb in the transaction
> > handle's writeback_inhibited_ebs xarray (keyed by eb->start), take a
> > reference, and increment writeback_inhibitors. The function handles
> > dedup (same eb inhibited twice by the same handle) and replacement
> > (different eb at the same logical address). Allocation failure is
> > graceful: the buffer simply falls back to the pre-existing behavior
> > where it may be written back and re-COW'd.
> > 
> > In lock_extent_buffer_for_io(), when writeback_inhibitors is non-zero
> > and the writeback mode is WB_SYNC_NONE, skip the buffer. WB_SYNC_NONE
> > is used by the VM flusher threads for background and periodic
> > writeback, which are the only paths that cause COW amplification by
> > opportunistically writing out dirty extent buffers mid-transaction.
> > Skipping these is safe because the buffers remain dirty in the page
> > cache and will be written out at transaction commit time.
> > 
> > WB_SYNC_ALL must always proceed regardless of writeback_inhibitors.
> > This is required for correctness in the fsync path: btrfs_sync_log()
> > writes log tree blocks via filemap_fdatawrite_range() (WB_SYNC_ALL)
> > while the transaction handle that inhibited those same blocks is still
> > active. Without the WB_SYNC_ALL bypass, those inhibited log tree
> > blocks would be silently skipped, resulting in an incomplete log on
> > disk and corruption on replay. btrfs_write_and_wait_transaction()
> > also uses WB_SYNC_ALL via filemap_fdatawrite_range(); for that path,
> > inhibitors are already cleared beforehand, but the bypass ensures
> > correctness regardless.
> > 
> > Uninhibit in __btrfs_end_transaction() before atomic_dec(num_writers)
> > to prevent a race where the committer proceeds while buffers are still
> > inhibited. Also uninhibit in btrfs_commit_transaction() before writing
> > and in cleanup_transaction() for the error path.
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.c       |  4 +++
> >   fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
> >   fs/btrfs/extent_io.h   |  6 ++++
> >   fs/btrfs/transaction.c | 19 +++++++++++++
> >   fs/btrfs/transaction.h |  3 ++
> >   5 files changed, 94 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 0e02b7b14adc..d4da65bb9096 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -590,6 +590,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
> >   		btrfs_tree_unlock(buf);
> >   	free_extent_buffer_stale(buf);
> >   	btrfs_mark_buffer_dirty(trans, cow);
> > +
> > +	/* Inhibit writeback on the COW'd buffer for this transaction handle. */
> > +	btrfs_inhibit_eb_writeback(trans, cow);
> > +
> >   	*cow_ret = cow;
> >   	return 0;
> >   
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index ff1fc699a6ca..e04e42a81978 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1940,7 +1940,9 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
> >   	 * of time.
> >   	 */
> >   	spin_lock(&eb->refs_lock);
> > -	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> > +	if ((wbc->sync_mode == WB_SYNC_ALL ||
> > +	     atomic_read(&eb->writeback_inhibitors) == 0) &&
> > +	    test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> >   		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
> >   		unsigned long flags;
> >   
> > @@ -2999,6 +3001,64 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
> >   	kmem_cache_free(extent_buffer_cache, eb);
> >   }
> >   
> > +/*
> > + * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during transaction.
> > + * @trans: transaction handle that will own the inhibitor
> > + * @eb: extent buffer to inhibit writeback on
> > + *
> > + * Attempts to track this extent buffer in the transaction's inhibited set.
> > + * If memory allocation fails, the buffer is simply not tracked. It may
> > + * be written back and need re-COW, which is the original behavior.
> > + * This is acceptable since inhibiting writeback is an optimization.
> > + */
> > +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
> > +				struct extent_buffer *eb)
> > +{
> > +	unsigned long index = eb->start >> trans->fs_info->nodesize_bits;
> > +	void *old;
> > +
> > +	/* Check if already inhibited by this handle. */
> > +	old = xa_load(&trans->writeback_inhibited_ebs, index);
> > +	if (old == eb)
> > +		return;
> > +
> > +	/* Take reference for the xarray entry. */
> > +	refcount_inc(&eb->refs);
> > +
> > +	old = xa_store(&trans->writeback_inhibited_ebs, index, eb, GFP_NOFS);
> > +	if (xa_is_err(old)) {
> > +		/* Allocation failed, just skip inhibiting this buffer. */
> > +		free_extent_buffer(eb);
> > +		return;
> > +	}
> > +
> > +	/* Handle replacement of different eb at same index. */
> > +	if (old && old != eb) {
> > +		struct extent_buffer *old_eb = old;
> > +
> > +		atomic_dec(&old_eb->writeback_inhibitors);
> > +		free_extent_buffer(old_eb);
> > +	}
> > +
> > +	atomic_inc(&eb->writeback_inhibitors);
> > +}
> > +
> > +/*
> > + * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers.
> > + * @trans: transaction handle to clean up
> > + */
> > +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans)
> > +{
> > +	struct extent_buffer *eb;
> > +	unsigned long index;
> > +
> > +	xa_for_each(&trans->writeback_inhibited_ebs, index, eb) {
> > +		atomic_dec(&eb->writeback_inhibitors);
> > +		free_extent_buffer(eb);
> > +	}
> > +	xa_destroy(&trans->writeback_inhibited_ebs);
> > +}
> > +
> >   static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >   						   u64 start)
> >   {
> > @@ -3009,6 +3069,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> >   	eb->len = fs_info->nodesize;
> >   	eb->fs_info = fs_info;
> >   	init_rwsem(&eb->lock);
> > +	atomic_set(&eb->writeback_inhibitors, 0);
> >   
> >   	btrfs_leak_debug_add_eb(eb);
> >   
> > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > index 73571d5d3d5a..fb68fbd4866c 100644
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -102,6 +102,8 @@ struct extent_buffer {
> >   	/* >= 0 if eb belongs to a log tree, -1 otherwise */
> >   	s8 log_index;
> >   	u8 folio_shift;
> > +	/* Inhibits WB_SYNC_NONE writeback when > 0. */
> > +	atomic_t writeback_inhibitors;
> 
> I might be missing something here, but I'm curious whether this atomic 
> counter can ever go above 1. If not, and it's strictly binary, perhaps 
> using atomic_set(1/0) instead of atomic_inc/dec would make the intent 
> clearer?

You're right! It looks like the counter will never go above 1 as we're
only increasing the counter when we actually COW the eb in
btrfs_force_cow_block and that will only ever happen once per eb.

This opens the door for:
 1. trans_handle A wants to modify eb Z, COWs and inhibits writeback
    on eb Z
 2. trans_handle B wants to modify eb Z, does not COW because same
    transaction generation and not WRITTEN, does not inhibit writeback
	on eb Z
 3. trans_handle A finishes, uninhibits eb Z
 4. trans_handle B still modifying eb Z with no inhibition

This leaves the door open for COW amplification. The correct thing to
do is inhibit writeback not only when the buffer is COW'd, but
whenever the handle resuses a COW'd buffer without re-COWing.

Will send out an updated v4 shortly, good catch!

> 
> Otherwise looks good. Thanks.
> 
> >   	struct rcu_head rcu_head;
> >   
> >   	struct rw_semaphore lock;
> > @@ -381,4 +383,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
> >   #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
> >   #endif
> >   
> > +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
> > +			       struct extent_buffer *eb);
> > +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans);
> > +
> >   #endif
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index f4cc9e1a1b93..a9a22629b49d 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -15,6 +15,7 @@
> >   #include "misc.h"
> >   #include "ctree.h"
> >   #include "disk-io.h"
> > +#include "extent_io.h"
> >   #include "transaction.h"
> >   #include "locking.h"
> >   #include "tree-log.h"
> > @@ -688,6 +689,8 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
> >   		goto alloc_fail;
> >   	}
> >   
> > +	xa_init(&h->writeback_inhibited_ebs);
> > +
> >   	/*
> >   	 * If we are JOIN_NOLOCK we're already committing a transaction and
> >   	 * waiting on this guy, so we don't need to do the sb_start_intwrite
> > @@ -1083,6 +1086,13 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
> >   	if (trans->type & __TRANS_FREEZABLE)
> >   		sb_end_intwrite(info->sb);
> >   
> > +	/*
> > +	 * Uninhibit extent buffer writeback before decrementing num_writers,
> > +	 * since the decrement wakes the committing thread which needs all
> > +	 * buffers uninhibited to write them to disk.
> > +	 */
> > +	btrfs_uninhibit_all_eb_writeback(trans);
> > +
> >   	WARN_ON(cur_trans != info->running_transaction);
> >   	WARN_ON(atomic_read(&cur_trans->num_writers) < 1);
> >   	atomic_dec(&cur_trans->num_writers);
> > @@ -2110,6 +2120,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
> >   	if (!test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
> >   		btrfs_scrub_cancel(fs_info);
> >   
> > +	btrfs_uninhibit_all_eb_writeback(trans);
> >   	kmem_cache_free(btrfs_trans_handle_cachep, trans);
> >   }
> >   
> > @@ -2556,6 +2567,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
> >   	    fs_info->cleaner_kthread)
> >   		wake_up_process(fs_info->cleaner_kthread);
> >   
> > +	/*
> > +	 * Uninhibit writeback on all extent buffers inhibited during this
> > +	 * transaction before writing them to disk. Inhibiting prevented
> > +	 * writeback while the transaction was building, but now we need
> > +	 * them written.
> > +	 */
> > +	btrfs_uninhibit_all_eb_writeback(trans);
> > +
> >   	ret = btrfs_write_and_wait_transaction(trans);
> >   	if (unlikely(ret)) {
> >   		btrfs_err(fs_info, "error while writing out transaction: %d", ret);
> > diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> > index 18ef069197e5..7d70fe486758 100644
> > --- a/fs/btrfs/transaction.h
> > +++ b/fs/btrfs/transaction.h
> > @@ -12,6 +12,7 @@
> >   #include <linux/time64.h>
> >   #include <linux/mutex.h>
> >   #include <linux/wait.h>
> > +#include <linux/xarray.h>
> >   #include "btrfs_inode.h"
> >   #include "delayed-ref.h"
> >   
> > @@ -162,6 +163,8 @@ struct btrfs_trans_handle {
> >   	struct btrfs_fs_info *fs_info;
> >   	struct list_head new_bgs;
> >   	struct btrfs_block_rsv delayed_rsv;
> > +	/* Extent buffers with writeback inhibited by this handle. */
> > +	struct xarray writeback_inhibited_ebs;
> >   };
> >   
> >   /*

