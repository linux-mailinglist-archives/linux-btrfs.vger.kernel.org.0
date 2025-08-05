Return-Path: <linux-btrfs+bounces-15858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4EB1B9D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF9916BFFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D3295529;
	Tue,  5 Aug 2025 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UFfnLQ9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gnlle2+D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F981D416C
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417182; cv=none; b=It2KlS8uFdTrx+D52s+Bh3lJU3AtsYxjV5YWwTsNqqQDjKt9oLGRBFiqyWY1Cg15ZYfyvgE1kbMWZ+qGB3Dmxs6wsXEMTarTx4fxWDvG0A5YQtiseB+O24Wr4BuMInQcuNdKRHsOsKPdZMEbcDgvf0asC882wNysVRkhKXu/HmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417182; c=relaxed/simple;
	bh=Y5OqTD5Qn5fhuXMQNPb7OBDxCGxEp2mYxZZoODVhO2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLZxNzjOtLmNxav+2knQCFaHP3zue2+Wl7JcPQbzq5941DGliAVLTz99u3nmMVXY+reA8OBXPNmIUdzrC9mt1Ubk0Iy+7CHytQSEK54Apf5LFl/8AhUjjqtOz41FZidCdHGeHpjdMRfIiDPA5igB/V9Q9ppTJjjnQSnibXHDqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UFfnLQ9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gnlle2+D; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85103140012E;
	Tue,  5 Aug 2025 14:06:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 14:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754417179; x=1754503579; bh=BRMtJNIhSG
	y6sq8TGXJ3ITo5nCDWNU5EbVeoyf/SuOo=; b=UFfnLQ9gPAFDIuSLi1gc2J0PJF
	98WpmFNTmk2v5jGjq/h88jwhV8bIVZm4cCoQmozkU0bEpR7ivDem1SpUMJjpcWk6
	TM62R1iwbmel3h4mdbyXiyqhatovOJ3p+7anROzd5R8euGAMNGl1LlSFyLXT98KZ
	N6ZzC6hGYUHK1hAIf3P8J0Z+D0tND/sPN6ozhthaBZO3ECQow0nOFGd2/ba9YpAd
	X/17g7oAX1GysFHuRSeoLYn4dOb5fKteJzsRgg+CjeKHl3M2EoVhPTJe69gjq52i
	H2DE0uIsms0iwjHvfk3D0W1L6TvCY69oqoFvEMLZCZSnVQxi21IEIqvJ+RBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754417179; x=1754503579; bh=BRMtJNIhSGy6sq8TGXJ3ITo5nCDWNU5EbVe
	oyf/SuOo=; b=Gnlle2+DmedZvRNKWL8abRTruzZKIywRAq3bNsVGN3G/PolilRv
	PJHrJ/ciSDOsLfyos8a4g56Md3jeddkUuYjrXqPGdoZ+r40sfshJd8zNArsjPxfu
	hPqTDlidEBAT9m3FVLg+ddqRQsbPzUhTWs6UEX7qxPZqYhKahQUcaoFHQaUqCWaK
	b+VXP+Y6lB6T7ZYv+FgWoIsb+FiG0HWZSmFrrpA/ddh5zPeAW25ZgCqo9peg3qss
	XFOZPX+yoP3bTUm/zoYm+0WZz1+k6OVkUcxZoiR4tAbLN6ahkkpeqQYWuK2XmnGQ
	QiNFME/C4tcswbyoUstMg0ux5P7y1PeEzNA==
X-ME-Sender: <xms:G0iSaE0TT5487iK9v2ZLnN_9fH2VuK7ALF0Rws10IeEozy8KKxTpzg>
    <xme:G0iSaJpz6HGsUNjg-20IklgkoFqojzX7Kss-dk5RTQA9wWZ2wcPi-M88LcSt6ADTL
    keRy6zjgdTXrfBYqvE>
X-ME-Received: <xmr:G0iSaJei7U6xqgwYG0VANBS9JUI8RdBb3bq4Db-chEZ63U3SeX-5TFdWKCFQ_MCa3QXxN5DckbGY3HPfCzEm3OMsRrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehlohgvmhhrrgdruggvvh
    esghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtoh
    hm
X-ME-Proxy: <xmx:G0iSaAoat51hIY30alx2aZj89PpZZxzPTW1KfDkblYGVSy3ASWUziA>
    <xmx:G0iSaCFgKaSUfdDe0vgO_w9UKXW-UvRIe_8KXnGm7l8GPlL8ey9yjQ>
    <xmx:G0iSaIunUtYnST9CYNoadA2Z73Xx6G9inedkO1vGCAfJ2T1bE4CSUQ>
    <xmx:G0iSaMUeCZ24CnaosFNow5Jp4CzObgDsOj7XKqPaVonl6Q2s_d1sew>
    <xmx:G0iSaMzkUgi7-2hCX-VPiSyR4OGBuR_1DPJ13X-3wOR1shrG4Xk5DwQ3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:06:18 -0400 (EDT)
Date: Tue, 5 Aug 2025 11:07:17 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250805180717.GB4088788@zen.localdomain>
References: <20250804135750.GL6704@twin.jikos.cz>
 <20250804190026.484954-1-loemra.dev@gmail.com>
 <20250805151447.GM6704@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805151447.GM6704@twin.jikos.cz>

On Tue, Aug 05, 2025 at 05:14:47PM +0200, David Sterba wrote:
> On Mon, Aug 04, 2025 at 12:00:12PM -0700, Leo Martins wrote:
> > On Mon, 4 Aug 2025 15:57:50 +0200 David Sterba <dsterba@suse.cz> wrote:
> > 
> > > On Tue, Jul 29, 2025 at 12:08:04AM -0700, Leo Martins wrote:
> > > > This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> > > > 
> > > > A ref_tracker object is allocated every time the reference count is
> > > > increased and freed when the reference count is decreased. The
> > > > ref_tracker object contains stack_trace information about where the
> > > > ref count is increased and decreased. The ref_tracker_dir embedded in
> > > > btrfs_delayed_node keeps track of all current references, and some
> > > > previous references. This information allows for detection of reference
> > > > leaks or double frees.
> > > > 
> > > > Here is a common example of taking a reference to a delayed_node and
> > > > freeing it with ref_tracker.
> > > > 
> > > > ```C
> > > > struct ref_tracker *tracker;
> > > > struct btrfs_delayed_node *node;
> > > > 
> > > > node = btrfs_get_delayed_node(inode, tracker);
> > > > // use delayed_node...
> > > > btrfs_release_delayed_node(node, tracker);
> > > > ```
> > > > 
> > > > There are two special cases where the delayed_node reference is long
> > > > term, meaning that the thread that takes the reference and the thread
> > > > that frees the reference are different. The inode_cache which is the
> > > > btrfs_delayed_node reference stored in the associated btrfs_inode, and
> > > > the node_list which is the btrfs_delayed_node reference stored in the
> > > > btrfs_delayed_root node_list/prepare_list. In these cases the
> > > > ref_tracker is stored in the delayed_node itself.
> > > > 
> > > > This patch introduces some new wrappers (btrfs_delayed_node_ref_tracker_*)
> > > > to ensure that when BTRFS_DEBUG is disabled everything gets compiled out.
> > > > 
> > > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > 
> > > I'm still missing why we need to add this whole infrastructure, there
> > > weren't any recent bugs in delayed inode tracking. I understand what the
> > > ref tracker does but it's still increasing structure size and adds a
> > > perf hit that is acceptable for debugging kernels but still.
> > 
> > Our leading btrfs crash is a soft lockup related to delayed_nodes.
> 
> Adding infrastructure for real problems makes sense, this is a good
> justification and should be mentioned in the patch. On which version do
> you observe it?
> 
> > [21017.354271] [     C96] Call Trace:
> > [21017.354273] [     C96]  <IRQ>
> > [21017.354278] [     C96]  ? rcu_dump_cpu_stacks+0xa1/0xe0
> > [21017.354282] [     C96]  ? print_cpu_stall+0x113/0x200
> > [21017.354284] [     C96]  ? rcu_sched_clock_irq+0x633/0x730
> > [21017.354287] [     C96]  ? update_process_times+0x66/0xa0
> > [21017.354288] [     C96]  ? dma_map_page_attrs+0x250/0x250
> > [21017.354289] [     C96]  ? tick_nohz_handler+0x84/0x1d0
> > [21017.354291] [     C96]  ? hrtimer_interrupt+0x1a1/0x5b0
> > [21017.354293] [     C96]  ? __sysvec_apic_timer_interrupt+0x44/0xe0
> > [21017.354295] [     C96]  ? sysvec_apic_timer_interrupt+0x6b/0x80
> > [21017.354296] [     C96]  </IRQ>
> > [21017.354297] [     C96]  <TASK>
> > [21017.354297] [     C96]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [21017.354302] [     C96]  ? xa_find+0xa/0xb0
> > [21017.354305] [     C96]  btrfs_kill_all_delayed_nodes+0x6b/0x150
> > [21017.354307] [     C96]  ? __switch_to+0x133/0x530
> > [21017.354308] [     C96]  ? schedule+0xff4/0x1380
> > [21017.354310] [     C96]  btrfs_clean_one_deleted_snapshot+0x70/0xe0
> > [21017.354313] [     C96]  cleaner_kthread+0x83/0x120
> > [21017.354315] [     C96]  ? exportfs_encode_inode_fh+0x60/0x60
> > [21017.354317] [     C96]  kthread+0xae/0xe0
> > [21017.354319] [     C96]  ? __efi_queue_work+0x130/0x130
> > [21017.354320] [     C96]  ret_from_fork+0x2f/0x40
> > [21017.354322] [     C96]  ? __efi_queue_work+0x130/0x130
> > [21017.354323] [     C96]  ret_from_fork_asm+0x11/0x20
> > [21017.354326] [     C96]  </TASK>
> > [21042.628340] [     C96] watchdog: BUG: soft lockup - CPU#96 stuck for 45s! [btrfs-cleaner:1438]
> > 
> > btrfs_kill_all_delayed_nodes is getting stuck in an infinite loop because
> > the root->delayed_nodes xarray has a delayed_node that never gets erased.
> > Inspecting the crash dump reveals that the delayed_node has a reference count
> > of one, indicating there is a reference leak.
> > 
> > I believe this bug was introduced or at least magnified somewhere between
> > 6.9 and 6.11.
> 
> That's likely to be related to the xarray conversion in 6.8.
> 

We suspected as much, but cannot see anything wrong with it despite lots
of staring at it. Could be something super subtle with a missing
READ_ONCE or the fact that the locks are no longer the same for the two
users.

> > Let me know if you want anymore details about the crash.
> > 
> > > 
> > > We have the ref-verify code and mount option, from what I've heard it
> > > was used sporadically when touching related code. We can let the ref
> > > tracking work like that too, not turned on by default ie. requiring a
> > > mount option.
> > 
> > The only issue with a mount option is that we would not be able to conditionally
> > compile ref_tracker_dir and ref_tracker pointers in struct btrfs_delayed_node,
> > permanently increasing the size of the struct from 304 bytes to 400 bytes.
> 
> That's not a small difference though for delayed inodes it may be still
> within the acceptable range. Turnin on debugging features for other
> subsystems also bloats structures, lockdep makes from 4B spinlock
> something like 70B, also indirectly hidden in other embedded structures.
> 
> > Alternatively, there could be a delayed_node ref_tracker helper struct that we
> > could store a pointer to.
> 
> This might make more sense for the first implementation.
> 
> > > In case you'd want to enhance more structures with ref tracker the mount
> > > option can enable them selectively.
> > > 
> > > > @@ -106,6 +113,13 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> > > >  		 */
> > > >  		if (refcount_inc_not_zero(&node->refs)) {
> > > >  			refcount_inc(&node->refs);
> > > > +#ifdef CONFIG_BTRFS_DEBUG
> > > > +			inode_cache_tracker = &node->inode_cache_tracker;
> > > > +#endif
> > > 
> > > We try to avoid #ifdefs if it's a repeating pattern, this should be
> > > abstracted away in a helper.
> > 
> > Sounds good.
> > 
> > For the record, there would be no need for it if we used the typedef
> > approach :-). There is a good example of how the original
> > author of ref_tracker implemented it in include/net/net_trackers.h.
> 
> We also try to stick to consistent coding style and patterns even if
> there's something possibly better. Dealing with various preferences in
> a big code base becomes quite distracting over time.
> 
> Could the typedef be replaced by a struct that's abstracting the
> conditional type? Something like
> 
> struct delayed_inode_tracker {
> #ifdef ...
> 	struct ref_tracker tracker;
> #else
> 	struct {} tracker;
> #endif
> };
> 
> Visually it's basically the same what I see in the net_tracker.h and we
> won't have to argue about the typedefs.
> 

Oh that's clever, I like it :)

> > > > +			btrfs_delayed_node_ref_tracker_alloc(node, tracker,
> > > > +							     GFP_ATOMIC);
> > > > +			btrfs_delayed_node_ref_tracker_alloc(
> > > > +				node, inode_cache_tracker, GFP_ATOMIC);
> > > >  			btrfs_inode->delayed_node = node;
> > > >  		} else {
> > > >  			node = NULL;
> > > > @@ -125,17 +139,19 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
> > > >   *
> > > >   * Return the delayed node, or error pointer on failure.
> > > >   */
> > > > -static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > > > -		struct btrfs_inode *btrfs_inode)
> > > > +static struct btrfs_delayed_node *
> > > > +btrfs_get_or_create_delayed_node(struct btrfs_inode *btrfs_inode,
> > > > +				 struct ref_tracker **tracker)
> > > 
> > > And another pattern, please don't change the style of the function
> > > definition line, the return value is on the same line as name, if
> > > parameters don't fit under reasonable column limit like 90 chars then
> > > it's on the next line. Most of the code has been fixed so you can just
> > > extend it.
> > 
> > Got it, I was just using the default kernel .clang-format.
> > Is there a btrfs specific .clang-format I could use?
> 
> Though there's "default kernel" .clang-format, many subsystems have
> their own style.  I think Boris mentioned an adjusted .clang-format for
> btrfs, but we have hand tuned code I'm not sure can be expressed in the
> config. The best we can do is to let if format things that have
> basically no exceptions and not touch the rest.

FWIW, I've never attempted to write clang-format rules for btrfs, though
I would love if we had them. Josef said that he tried a few years back
and was unsuccessful. Could be worth another attempt, maybe the rule
writing has become more sophisticated :)

