Return-Path: <linux-btrfs+bounces-15855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1914B1B737
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203A97AAE95
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C213279DA9;
	Tue,  5 Aug 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bp2Du3rd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N/LDeG7t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n6Uc6tLX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j8hZqmVR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC025A2B4
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406893; cv=none; b=btIdfdMfStvRW7JY1QBLnUfSgzd2LkMRPxKz7iU8JoFfVGQrE22FvUrtzBLYLUjV5+BIf/PkwtU/Myl6gjUvcQ5MCx4sMF3YUoLsaF8pjJMowSCV6BOD8Ve2DQkvLQBTdXH0MqR6pf8Fc3XrRui73+ujiACSsNoLnfRDY9LQXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406893; c=relaxed/simple;
	bh=DXdN+YyXXsygM0/rE7jpmNzCZBwDIbXisWVaxBvbTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqBWPBaDQpy8iX5q/A00gIjdnqHIqOQ2uNFRmq0/NT3tqvi5XhQlKcFUvTjdxEilSuUW+nHYYZjY0JZ+9jTi922c3F0+Wpt/A0CBTuU/+b3O9j6B587MoqWFNQKIL3yB/QSlm3pfVDqIaLzKs63C6jyyuim+U8Eld++TmvTP080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bp2Du3rd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N/LDeG7t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n6Uc6tLX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j8hZqmVR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D75AE1F38C;
	Tue,  5 Aug 2025 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754406890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqxr9MGWYLm3aT8/wKd2gLEo/QgKO57h62jxmF2te0=;
	b=Bp2Du3rd7X1UAuThT6+pcVyBTVkrPTNTJJwtTMM+S5pBJ4Xtz+xXe/CsNp1hqaz7bi+IJf
	zLidyzMvUodsBSphaG8boXPQTQAmNbQ0kuFjjziQTC7XNnb8mPBx1keN/xdC6GQ8l4Fu66
	jjly1FeXYIVESyNYI/td2KdpPMn3ekQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754406890;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqxr9MGWYLm3aT8/wKd2gLEo/QgKO57h62jxmF2te0=;
	b=N/LDeG7t7jMf+Yf+p6Fbm2kyDtlV2+qChUwTJ/oyJyo8RI908HrBkMt7hQPETvTFIwdmv/
	MI3VT/eoUtQ9vEDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754406889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqxr9MGWYLm3aT8/wKd2gLEo/QgKO57h62jxmF2te0=;
	b=n6Uc6tLXzG77D2Fo5/Th+jLQ+vJ+LROYqbqBXuWE/uTw42XYZEMWyotqLct+8StZGnEPQi
	aSZiYW0hz8GUOOo53yKqxJLafG57mOuu2kMcExUhAZb4ouLbBn57qUt1mixXtKoOcm9GNf
	xHklm3XuYpeRbE0FkWNe5I/JAl5sF40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754406889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqxr9MGWYLm3aT8/wKd2gLEo/QgKO57h62jxmF2te0=;
	b=j8hZqmVR/ioQ7g97bELUlASO6HN98UkIwXCYPa6U+lzNhzmcagWhaoQv0L6vCOolnyLiXi
	kqhV0+yuyVtGWSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A551D13A50;
	Tue,  5 Aug 2025 15:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lKo3KOkfkmhrZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 05 Aug 2025 15:14:49 +0000
Date: Tue, 5 Aug 2025 17:14:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250805151447.GM6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250804135750.GL6704@twin.jikos.cz>
 <20250804190026.484954-1-loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804190026.484954-1-loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Mon, Aug 04, 2025 at 12:00:12PM -0700, Leo Martins wrote:
> On Mon, 4 Aug 2025 15:57:50 +0200 David Sterba <dsterba@suse.cz> wrote:
> 
> > On Tue, Jul 29, 2025 at 12:08:04AM -0700, Leo Martins wrote:
> > > This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> > > 
> > > A ref_tracker object is allocated every time the reference count is
> > > increased and freed when the reference count is decreased. The
> > > ref_tracker object contains stack_trace information about where the
> > > ref count is increased and decreased. The ref_tracker_dir embedded in
> > > btrfs_delayed_node keeps track of all current references, and some
> > > previous references. This information allows for detection of reference
> > > leaks or double frees.
> > > 
> > > Here is a common example of taking a reference to a delayed_node and
> > > freeing it with ref_tracker.
> > > 
> > > ```C
> > > struct ref_tracker *tracker;
> > > struct btrfs_delayed_node *node;
> > > 
> > > node = btrfs_get_delayed_node(inode, tracker);
> > > // use delayed_node...
> > > btrfs_release_delayed_node(node, tracker);
> > > ```
> > > 
> > > There are two special cases where the delayed_node reference is long
> > > term, meaning that the thread that takes the reference and the thread
> > > that frees the reference are different. The inode_cache which is the
> > > btrfs_delayed_node reference stored in the associated btrfs_inode, and
> > > the node_list which is the btrfs_delayed_node reference stored in the
> > > btrfs_delayed_root node_list/prepare_list. In these cases the
> > > ref_tracker is stored in the delayed_node itself.
> > > 
> > > This patch introduces some new wrappers (btrfs_delayed_node_ref_tracker_*)
> > > to ensure that when BTRFS_DEBUG is disabled everything gets compiled out.
> > > 
> > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > 
> > I'm still missing why we need to add this whole infrastructure, there
> > weren't any recent bugs in delayed inode tracking. I understand what the
> > ref tracker does but it's still increasing structure size and adds a
> > perf hit that is acceptable for debugging kernels but still.
> 
> Our leading btrfs crash is a soft lockup related to delayed_nodes.

Adding infrastructure for real problems makes sense, this is a good
justification and should be mentioned in the patch. On which version do
you observe it?

> [21017.354271] [     C96] Call Trace:
> [21017.354273] [     C96]  <IRQ>
> [21017.354278] [     C96]  ? rcu_dump_cpu_stacks+0xa1/0xe0
> [21017.354282] [     C96]  ? print_cpu_stall+0x113/0x200
> [21017.354284] [     C96]  ? rcu_sched_clock_irq+0x633/0x730
> [21017.354287] [     C96]  ? update_process_times+0x66/0xa0
> [21017.354288] [     C96]  ? dma_map_page_attrs+0x250/0x250
> [21017.354289] [     C96]  ? tick_nohz_handler+0x84/0x1d0
> [21017.354291] [     C96]  ? hrtimer_interrupt+0x1a1/0x5b0
> [21017.354293] [     C96]  ? __sysvec_apic_timer_interrupt+0x44/0xe0
> [21017.354295] [     C96]  ? sysvec_apic_timer_interrupt+0x6b/0x80
> [21017.354296] [     C96]  </IRQ>
> [21017.354297] [     C96]  <TASK>
> [21017.354297] [     C96]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [21017.354302] [     C96]  ? xa_find+0xa/0xb0
> [21017.354305] [     C96]  btrfs_kill_all_delayed_nodes+0x6b/0x150
> [21017.354307] [     C96]  ? __switch_to+0x133/0x530
> [21017.354308] [     C96]  ? schedule+0xff4/0x1380
> [21017.354310] [     C96]  btrfs_clean_one_deleted_snapshot+0x70/0xe0
> [21017.354313] [     C96]  cleaner_kthread+0x83/0x120
> [21017.354315] [     C96]  ? exportfs_encode_inode_fh+0x60/0x60
> [21017.354317] [     C96]  kthread+0xae/0xe0
> [21017.354319] [     C96]  ? __efi_queue_work+0x130/0x130
> [21017.354320] [     C96]  ret_from_fork+0x2f/0x40
> [21017.354322] [     C96]  ? __efi_queue_work+0x130/0x130
> [21017.354323] [     C96]  ret_from_fork_asm+0x11/0x20
> [21017.354326] [     C96]  </TASK>
> [21042.628340] [     C96] watchdog: BUG: soft lockup - CPU#96 stuck for 45s! [btrfs-cleaner:1438]
> 
> btrfs_kill_all_delayed_nodes is getting stuck in an infinite loop because
> the root->delayed_nodes xarray has a delayed_node that never gets erased.
> Inspecting the crash dump reveals that the delayed_node has a reference count
> of one, indicating there is a reference leak.
> 
> I believe this bug was introduced or at least magnified somewhere between
> 6.9 and 6.11.

That's likely to be related to the xarray conversion in 6.8.

> Let me know if you want anymore details about the crash.
> 
> > 
> > We have the ref-verify code and mount option, from what I've heard it
> > was used sporadically when touching related code. We can let the ref
> > tracking work like that too, not turned on by default ie. requiring a
> > mount option.
> 
> The only issue with a mount option is that we would not be able to conditionally
> compile ref_tracker_dir and ref_tracker pointers in struct btrfs_delayed_node,
> permanently increasing the size of the struct from 304 bytes to 400 bytes.

That's not a small difference though for delayed inodes it may be still
within the acceptable range. Turnin on debugging features for other
subsystems also bloats structures, lockdep makes from 4B spinlock
something like 70B, also indirectly hidden in other embedded structures.

> Alternatively, there could be a delayed_node ref_tracker helper struct that we
> could store a pointer to.

This might make more sense for the first implementation.

> > In case you'd want to enhance more structures with ref tracker the mount
> > option can enable them selectively.
> > 
> > > @@ -106,6 +113,13 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> > >  		 */
> > >  		if (refcount_inc_not_zero(&node->refs)) {
> > >  			refcount_inc(&node->refs);
> > > +#ifdef CONFIG_BTRFS_DEBUG
> > > +			inode_cache_tracker = &node->inode_cache_tracker;
> > > +#endif
> > 
> > We try to avoid #ifdefs if it's a repeating pattern, this should be
> > abstracted away in a helper.
> 
> Sounds good.
> 
> For the record, there would be no need for it if we used the typedef
> approach :-). There is a good example of how the original
> author of ref_tracker implemented it in include/net/net_trackers.h.

We also try to stick to consistent coding style and patterns even if
there's something possibly better. Dealing with various preferences in
a big code base becomes quite distracting over time.

Could the typedef be replaced by a struct that's abstracting the
conditional type? Something like

struct delayed_inode_tracker {
#ifdef ...
	struct ref_tracker tracker;
#else
	struct {} tracker;
#endif
};

Visually it's basically the same what I see in the net_tracker.h and we
won't have to argue about the typedefs.

> > > +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> > > +							     GFP_ATOMIC);
> > > +			btrfs_delayed_node_ref_tracker_alloc(
> > > +				node, inode_cache_tracker, GFP_ATOMIC);
> > >  			btrfs_inode->delayed_node = node;
> > >  		} else {
> > >  			node = NULL;
> > > @@ -125,17 +139,19 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> > >   *
> > >   * Return the delayed node, or error pointer on failure.
> > >   */
> > > -static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > > -		struct btrfs_inode *btrfs_inode)
> > > +static struct btrfs_delayed_node *
> > > +btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
> > > +				 struct ref_tracker **tracker)
> > 
> > And another pattern, please don't change the style of the function
> > definition line, the return value is on the same line as name, if
> > parameters don't fit under reasonable column limit like 90 chars then
> > it's on the next line. Most of the code has been fixed so you can just
> > extend it.
> 
> Got it, I was just using the default kernel .clang-format.
> Is there a btrfs specific .clang-format I could use?

Though there's "default kernel" .clang-format, many subsystems have
their own style.  I think Boris mentioned an adjusted .clang-format for
btrfs, but we have hand tuned code I'm not sure can be expressed in the
config. The best we can do is to let if format things that have
basically no exceptions and not touch the rest.

