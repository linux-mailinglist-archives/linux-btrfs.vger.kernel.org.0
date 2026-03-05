Return-Path: <linux-btrfs+bounces-22261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNXaAkvjqWl1HAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22261-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 21:10:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E008218033
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147EC3060788
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D63CF69D;
	Thu,  5 Mar 2026 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KLLfx7AI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5Bvmkoo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226A2D9492
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772741443; cv=none; b=Pec4CgwRkD1RXWLNsjoJeQN8Xo/WmvKwCVcAi9YatKDaflaz32jXYt4mO6ZpenzGRxqRtIxeuFsujeIbqLjErHGb3XK3Dj1MDiDkKOiveWZDoLWQfvntVA3bm9h+cRUUeljPb5quT6cCBuoVBwwnuL7XTo5vIjrhG46q6ObAk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772741443; c=relaxed/simple;
	bh=i/RvQkaK1hDZO449E9W2xUaIHxxFTw8xkZ5PsOELnKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0cvf3kDi5jaTgLuKUKO2VmhSVssjpZ3vgO01R03COoUD02g47nTAY3QUUr8xs8d3bgcU1pcGq+52JFk2iBuH5GhHvE1IfZqGBFGcC+B7QlwU7jmVwSsy4916lym0zy+vtpXs6XOmSGuXV2CxLrI++ITUppETNJyRJFNgSDmdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KLLfx7AI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5Bvmkoo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CCBC1400026;
	Thu,  5 Mar 2026 15:10:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 15:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772741440;
	 x=1772827840; bh=aA8ZFQPTDkG/RukDiB7aTA4BgRrcqERAQUv5kaJNiRE=; b=
	KLLfx7AIDBUExeKGxh69LnS9YDNVDdlQ3SMudos4iesNRmYznSYiCJ1NyeXngcR6
	9MqN0qLrRITvzSygdC90ZVFL0Lwl2tK23yB3Yilo25m48PFcMmmJCcB08W4GWhW0
	lTUy0jv02evwJ/kx/31Z2lvXa7lfSRcNXBGrg75jEDQog1YH3d41sW2tCl1KII2W
	QnlB5vTtjdu6iGpKbfRngU4PX/s2SLJbl4R9xGgx7vX07udjIbmWz5wBF4eH4meg
	aN7Zs7o1IWlTnV2U++zKebkBUG5w2SlNfGiOXNHd1Dv1blPh2bJa55caxrlf0Jqc
	sjlakRLQrI9n76XuDhRYRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772741440; x=
	1772827840; bh=aA8ZFQPTDkG/RukDiB7aTA4BgRrcqERAQUv5kaJNiRE=; b=a
	5Bvmkoo9F0EDGG+dTsMcNyf6qCC2oMDdwTozmtcpeU51/93UcHeM6yPqe3ZndKRm
	hCQVqItX9KSoURHuSSUOhR/0v5tA2wMwbbvTW73aPsvhgEFPMl+jIXrXaPOET08L
	GVqP/ZwzQpKapmtvCj74zBnwbN3SmQIhEgB2F2kiLuZuGLCffcKcaJsWj0u/3jfU
	xHOvgdQGC4Nc+eOkL5MySpClOxYL14rZ7iyXgcKmWYvrKazBjGkGAyYo34pFuZUx
	ozzI+NkPMzwXjhnSZGsWxXwOmHBNex00PJtorxn17b7j3xk3G7yd9MNMU739cueF
	UPGxsJ7Evi+AZqqnEzNTA==
X-ME-Sender: <xms:P-OpaSsvesKx1zDbEmrxMLfZrl9cJAPIcnNmODyg7Otn44Lm3TNT_Q>
    <xme:P-OpabL4e1HbE6YbZhHMFUgxLX6iPXq5MdtQSVyQPXTYKvjzJFZODVgM7oTUTyWNS
    wh_5i0WWWTukq-JfDHA3dwbof1w1ml7rr0Cix6F7x-84Y_AYdwhDMU>
X-ME-Received: <xmr:P-OpaXkqFPyr6H9nLUiP-lbrF1FvBtoxkXW9V0yBtnMe7dqtWEuLhZEntxIDNtvbl6n7ZdNFttLOSyoAvADi3tTqg7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopehloh
    gvmhhrrgdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhr
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvg
    grmhesfhgsrdgtohhmpdhrtghpthhtohepfhgumhgrnhgrnhgrsehsuhhsvgdrtghomhdp
    rhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:P-OpaUI7OGyizljKPBlg1cYDpCZlbpATJ2fQ6ISYTWXbvJvPwp4o7g>
    <xmx:P-OpaU5WfNzxMZqxtpEVAGphJU2I5S53eSE4ZYz_WCSbQCViED2ZLg>
    <xmx:P-OpaQ3yklkGM2c_8hFvvL_CXMzMgli3hnHuBhTYg3aPYC3VYsWUtA>
    <xmx:P-OpaSc0DaGDNEu4CcB43siwp88042GDfxkF5RGAkCruL7CHWxo8Pw>
    <xmx:QOOpaUvI43f1I-ix6n57jdbFlh47f0H7HY-7-q9o2W3dZKimfTJTRNP6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 15:10:39 -0500 (EST)
Date: Thu, 5 Mar 2026 12:11:19 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, Filipe Manana <fdmanana@suse.com>,
	Sun YangKai <sunk67188@gmail.com>
Subject: Re: [PATCH v4 1/3] btrfs: skip COW for written extent buffers
 allocated in current transaction
Message-ID: <20260305201119.GA1237826@zen.localdomain>
References: <cover.1772097864.git.loemra.dev@gmail.com>
 <e8e4f5e396d821ba9ed6a4eee073ae8628d52aeb.1772097864.git.loemra.dev@gmail.com>
 <3f85a632-d062-4006-8bd7-1048c60197ef@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f85a632-d062-4006-8bd7-1048c60197ef@gmx.com>
X-Rspamd-Queue-Id: 1E008218033
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22261-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:01:19PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/2/26 20:21, Leo Martins 写道:
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
> > btrfs_init_new_buffer() when the block was first allocated. Normally
> > dirty_pages is only cleared at commit time by
> > btrfs_write_and_wait_transaction(), but if qgroups are enabled and
> > snapshots are being created, qgroup_account_snapshot() may have already
> > called btrfs_write_and_wait_transaction() and released the range before
> > the final commit-time call.
> > 
> > Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> > correctly pins the block if it is freed later.
> > 
> > Relax the lockdep assertion in btrfs_mark_buffer_dirty() from
> > btrfs_assert_tree_write_locked() to lockdep_assert_held() so that it
> > accepts either a read or write lock. should_cow_block() may be called
> > from btrfs_search_slot() when only a read lock is held (nodes above
> > write_lock_level are read-locked). The write lock assertion previously
> > documented the caller convention that buffer content was being modified
> > under exclusive access, but btrfs_mark_buffer_dirty() and
> > set_extent_buffer_dirty() themselves only perform independently
> > synchronized operations: atomic bit ops on bflags, folio_mark_dirty()
> > (kernel-internal folio locking), xarray mark updates (xarray spinlock),
> > and percpu counter updates. The read lock is sufficient because it
> > prevents lock_extent_buffer_for_io() from acquiring the write lock and
> > racing on the dirty state. Since rw_semaphore permits concurrent
> > readers, multiple threads can enter btrfs_mark_buffer_dirty()
> > simultaneously for the same buffer; this is safe because
> > test_and_set_bit(EXTENT_BUFFER_DIRTY) ensures only one thread performs
> > the full dirty state transition.
> > 
> > Remove the CONFIG_BTRFS_DEBUG assertion in set_extent_buffer_dirty()
> > that checked folio_test_dirty() after marking the buffer dirty. This
> > assertion assumed exclusive access (only one thread in
> > set_extent_buffer_dirty() at a time), which held when the only caller
> > was btrfs_mark_buffer_dirty() under write lock. With concurrent readers
> > calling through should_cow_block(), a thread that loses the
> > test_and_set_bit race sees was_dirty=true and skips the folio dirty
> > marking, but the winning thread may not have called
> > btrfs_meta_folio_set_dirty() yet, causing the assertion to fire. This
> > is a benign race: the winning thread will complete the folio dirty
> > marking, and no writeback can clear it while readers hold their locks.
> > 
> > Hoist the EXTENT_BUFFER_WRITEBACK, BTRFS_HEADER_FLAG_RELOC, and
> > BTRFS_ROOT_FORCE_COW checks before the WRITTEN block since they apply
> > regardless of whether the buffer has been written back. This
> > consolidates the exclusion logic and simplifies the WRITTEN path to
> > only handle log trees and zoned devices. Moving the RELOC checks
> > before the smp_mb__before_atomic() barrier is safe because both
> > btrfs_root_id() (immutable) and BTRFS_HEADER_FLAG_RELOC (set at COW
> > time under tree lock) are stable values not subject to concurrent
> > modification; the barrier is only needed for BTRFS_ROOT_FORCE_COW
> > which is set concurrently by create_pending_snapshot().
> > 
> > Exclude cases where in-place overwrite is not safe:
> >   - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
> >   - Zoned devices: require sequential writes
> >   - Log trees: log blocks are immediately referenced by a committed
> >     superblock via btrfs_sync_log(), so overwriting could corrupt the
> >     committed log
> >   - BTRFS_ROOT_FORCE_COW: snapshot in progress
> >   - BTRFS_HEADER_FLAG_RELOC: block being relocated
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Reviewed-by: Sun YangKai <sunk67188@gmail.com>
> 
> Unfortunately this patch is making btrfs/232 fail.
> Bisection lead to this one.
> 
> I have hit the following errors during btrfs/232 run with this patch, but
> not the commit before it:
> 
> - Write time tree-checker errors
>   From first key mismatch to bad key order.
> 
> - Fsck errors
>   From missing inode item other problems.
>   AKA, on-disk corruption, which is never a good sign.
> 
> One thing to note is, that test case itself can lead to a false alerts from
> DEBUG_WARN() inside btrfs_remove_qgroup(), thus you may need to manually
> remove that DEBUG_WARN() or check the failure dmesg to be extra sure.
> 
> Thanks,
> Qu
> 

I confirm that b/232 looks broken with this and good without it.

Reverted this patch (but left the independently useful inhibition patch)
while Leo figures out the tree-checker issues, which were reasonable to
expect coming out of something like this.

Thanks,
Boris

> > ---
> >   fs/btrfs/ctree.c     | 87 ++++++++++++++++++++++++++++++++++----------
> >   fs/btrfs/disk-io.c   |  2 +-
> >   fs/btrfs/extent_io.c |  4 --
> >   3 files changed, 69 insertions(+), 24 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 7267b2502665..ea7cfc3a9e89 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -599,29 +599,40 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
> >   	return ret;
> >   }
> > -static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> > +/*
> > + * Check if @buf needs to be COW'd.
> > + *
> > + * Returns true if COW is required, false if the block can be reused
> > + * in place.
> > + *
> > + * We do not need to COW a block if:
> > + * 1) the block was created or changed in this transaction;
> > + * 2) the block does not belong to TREE_RELOC tree;
> > + * 3) the root is not forced COW.
> > + *
> > + * Forced COW happens when we create a snapshot during transaction commit:
> > + * after copying the src root, we must COW the shared block to ensure
> > + * metadata consistency.
> > + *
> > + * When returning false for a WRITTEN buffer allocated in the current
> > + * transaction, re-dirties the buffer for in-place overwrite instead
> > + * of requesting a new COW.
> > + */
> > +static inline bool should_cow_block(struct btrfs_trans_handle *trans,
> >   				    const struct btrfs_root *root,
> > -				    const struct extent_buffer *buf)
> > +				    struct extent_buffer *buf)
> >   {
> >   	if (btrfs_is_testing(root->fs_info))
> >   		return false;
> > -	/*
> > -	 * We do not need to cow a block if
> > -	 * 1) this block is not created or changed in this transaction;
> > -	 * 2) this block does not belong to TREE_RELOC tree;
> > -	 * 3) the root is not forced COW.
> > -	 *
> > -	 * What is forced COW:
> > -	 *    when we create snapshot during committing the transaction,
> > -	 *    after we've finished copying src root, we must COW the shared
> > -	 *    block to ensure the metadata consistency.
> > -	 */
> > -
> >   	if (btrfs_header_generation(buf) != trans->transid)
> >   		return true;
> > -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> > +	if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
> > +		return true;
> > +
> > +	if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
> > +	    btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
> >   		return true;
> >   	/* Ensure we can see the FORCE_COW bit. */
> > @@ -629,11 +640,49 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> >   	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
> >   		return true;
> > -	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
> > -		return false;
> > +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> > +		/*
> > +		 * The buffer was allocated in this transaction and has been
> > +		 * written back to disk (WRITTEN is set). Normally we'd COW
> > +		 * it again, but since the committed superblock doesn't
> > +		 * reference this buffer (it was allocated in this transaction),
> > +		 * we can safely overwrite it in place.
> > +		 *
> > +		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
> > +		 * persisted at this bytenr and will be again after the
> > +		 * in-place update. This is important so that
> > +		 * btrfs_free_tree_block() correctly pins the block if it is
> > +		 * freed later (e.g., during tree rebalancing or FORCE_COW).
> > +		 *
> > +		 * Log trees and zoned devices cannot use this optimization:
> > +		 * - Log trees: log blocks are written and immediately
> > +		 *   referenced by a committed superblock via
> > +		 *   btrfs_sync_log(), bypassing the normal transaction
> > +		 *   commit. Overwriting in place could corrupt the
> > +		 *   committed log.
> > +		 * - Zoned devices: require sequential writes.
> > +		 */
> > +		if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID ||
> > +		    btrfs_is_zoned(root->fs_info))
> > +			return true;
> > -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
> > -		return true;
> > +		/*
> > +		 * Re-register this block's range in the current transaction's
> > +		 * dirty_pages so that btrfs_write_and_wait_transaction()
> > +		 * writes it. The range was originally registered when the
> > +		 * block was allocated. Normally dirty_pages is only cleared
> > +		 * at commit time by btrfs_write_and_wait_transaction(), but
> > +		 * if qgroups are enabled and snapshots are being created,
> > +		 * qgroup_account_snapshot() may have already called
> > +		 * btrfs_write_and_wait_transaction() and released the range
> > +		 * before the final commit-time call.
> > +		 */
> > +		btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> > +				     buf->start,
> > +				     buf->start + buf->len - 1,
> > +				     EXTENT_DIRTY, NULL);
> > +		btrfs_mark_buffer_dirty(trans, buf);
> > +	}
> >   	return false;
> >   }
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 32fffb0557e5..bee8f76fbfea 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4491,7 +4491,7 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
> >   #endif
> >   	/* This is an active transaction (its state < TRANS_STATE_UNBLOCKED). */
> >   	ASSERT(trans->transid == fs_info->generation);
> > -	btrfs_assert_tree_write_locked(buf);
> > +	lockdep_assert_held(&buf->lock);
> >   	if (unlikely(transid != fs_info->generation)) {
> >   		btrfs_abort_transaction(trans, -EUCLEAN);
> >   		btrfs_crit(fs_info,
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index dfc17c292217..ff1fc699a6ca 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3791,10 +3791,6 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
> >   					 eb->len,
> >   					 eb->fs_info->dirty_metadata_batch);
> >   	}
> > -#ifdef CONFIG_BTRFS_DEBUG
> > -	for (int i = 0; i < num_extent_folios(eb); i++)
> > -		ASSERT(folio_test_dirty(eb->folios[i]));
> > -#endif
> >   }
> >   void clear_extent_buffer_uptodate(struct extent_buffer *eb)
> 

