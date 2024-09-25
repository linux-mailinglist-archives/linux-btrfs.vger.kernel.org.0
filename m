Return-Path: <linux-btrfs+bounces-8229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20398687A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B099F281F85
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18462155742;
	Wed, 25 Sep 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="N+nJPC+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODSVuuWW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F191534FB;
	Wed, 25 Sep 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300792; cv=none; b=XS7NtpQ6a8erYlpRFP52qDmdj0uLug6cmUNEkH7fcBxY9jSN4rpd/tghL6JNjhYyfpkSgVyMgu4zj4AoTi1yt3qlFUkHiGxejAkagGaYxn+Vp9aR66Jp3d60RVctJ/BArCVOOIxX6tpS+Bg7hvYLctonDuBmz6GRHr4FlGc8IS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300792; c=relaxed/simple;
	bh=zgACIL4kO956MTsJjypmrRAbqhI8RF5C7MdjTFs/m5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3x87NnsD9m5j98gnZjklGChMlge6ZFx/fvaX9YVbmx3lMCBSI+hWtu2gE29XuKZI0OKaxkJ3hX7zbufdaFi1ng4O008G7ZpDP4NHiqyPK9t87UGDuBeLr+Jn8goXa1kx+qeTu8dMiBIEAbtcoRiCfpLJFbVhC86NDvM9oLC+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=N+nJPC+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODSVuuWW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11AAD1140163;
	Wed, 25 Sep 2024 17:46:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 25 Sep 2024 17:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727300788; x=1727387188; bh=2qUXrXLj9r
	mFYouQek/17YmhC2pYzW+XgqYZFPYUlTI=; b=N+nJPC+K9tTCd50RXXBWie9HzW
	WUNABaQir2oY0Bgs0SmpEcueWIvmFFwpQ3YBwUGNhZS8Pdw+p5ZB7NySic+9BODH
	kRpip20BEabfUBKvlKiTaHjNUw3ffnT+Od9Y0pvNAqR0ypT11PfVpLSZB0zgnOpo
	167rdf1Ol2evbckP5fKYelEaGWcyAlshazEF3ZZd/UGClhBzib2Tefss3L9B+CR5
	G3vgSAt+XAxB5bDwWnHQraaAR9GI0sKbZibs4nxTbdAVGWiPBE3vxtYRVnybbn8B
	S4ucbiEYhoyeT935GGxAHRUYu/bLDKL950auls8jszI9xHEmFDp291TXxdxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727300788; x=1727387188; bh=2qUXrXLj9rmFYouQek/17YmhC2pY
	zW+XgqYZFPYUlTI=; b=ODSVuuWWT4iOL9j6t9wP0bLX42eoAz24dVNfuvHFFSRs
	wHz44MZfX3iy/nFiKPQmtaRRhoY1QEyk/mx/MdGp8ltCUjmUzCaov5gGz5m6W9rZ
	iXr9iXS6YORqF6482jtiXOUD8oBPtBY5hxhDg0NPPodcqQAM7ppRHWybXGvkI7N5
	31cOJEHs2O2nZBfeUEnqmuhVvmLEPiuznG6jTh9jf1oKRltZteVn+tIynCKiiXgO
	LdN1fSH00dxkZWeBhwZ2e3eKflcf9P6eoHTQnlksuqu1J9Dvz+OqfL7cE+KQ9q3D
	/tcogyhbkIbcei8sNjjGWdkltxp/xfKNGK4woq6ZkQ==
X-ME-Sender: <xms:s4T0ZkCKBKZ8_1ZefpCEemkBtVcL6rCOTg3RGw7K9cmt7vV4utPIUA>
    <xme:s4T0Zmh5Gv-YA6vdDNjDrUEiX11c9AWeNW2mp2WGcv9JTiuvAf7k-yQW6CBCwUykB
    vQcVHIsjQTc8XXRhGI>
X-ME-Received: <xmr:s4T0Znl5mXpGaYQ-ozjo6oWgci99tZjdtPcw7E1j4iLfQfwhSO_kWORyL8abmGjIajNvBJVKoffTVqVOO_T1Nse_01g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehsth
    grsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:s4T0Zqza6kSrBA3RJUISmsAhO5MOZzM2GYhFiSPtCn-49P72hPSvQA>
    <xmx:s4T0ZpRnSVOa5sLN5lgCH1aYMj6DYSLjz_AY7C0pKOB2RTdUiTDFTg>
    <xmx:s4T0Zlaupr4FjHAu-0w1qHGlpTCCwgoMXjxl_LRz4GTxFCk3QquYMw>
    <xmx:s4T0ZiQQf6vKESnpgngbUOmTQkGEemlUhJ9SFLL6wJbAepAwkNiBZg>
    <xmx:tIT0ZnP_jAxKhKuD0rBxQlxcT3dr_V99SxC4MXguesJkiTCFxzMXQktr>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 17:46:27 -0400 (EDT)
Date: Wed, 25 Sep 2024 14:46:25 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop the backref cache during relocation if we
 commit
Message-ID: <20240925214625.GA3017662@zen.localdomain>
References: <68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com>
 <20240925190743.GA2997332@zen.localdomain>
 <20240925201734.GA296133@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925201734.GA296133@perftesting>

On Wed, Sep 25, 2024 at 04:17:34PM -0400, Josef Bacik wrote:
> On Wed, Sep 25, 2024 at 12:07:43PM -0700, Boris Burkov wrote:
> > On Tue, Sep 24, 2024 at 05:11:37PM -0400, Josef Bacik wrote:
> > > Since the inception of relocation we have maintained the backref cache
> > > across transaction commits, updating the backref cache with the new
> > > bytenr whenever we COW'ed blocks that were in the cache, and then
> > > updating their bytenr once we detected a transaction id change.
> > > 
> > > This works as long as we're only ever modifying blocks, not changing the
> > > structure of the tree.
> > > 
> > > However relocation does in fact change the structure of the tree.  For
> > > example, if we are relocating a data extent, we will look up all the
> > > leaves that point to this data extent.  We will then call
> > > do_relocation() on each of these leaves, which will COW down to the leaf
> > > and then update the file extent location.
> > > 
> > > But, a key feature of do_relocation is the pending list.  This is all
> > > the pending nodes that we modified when we updated the file extent item.
> > > We will then process all of these blocks via finish_pending_nodes, which
> > > calls do_relocation() on all of the nodes that led up to that leaf.
> > > 
> > > The purpose of this is to make sure we don't break sharing unless we
> > > absolutely have to.  Consider the case that we have 3 snapshots that all
> > > point to this leaf through the same nodes, the initial COW would have
> > > created a whole new path.  If we did this for all 3 snapshots we would
> > > end up with 3x the number of nodes we had originally.  To avoid this we
> > > will cycle through each of the snapshots that point to each of these
> > > nodes and update their pointers to point at the new nodes.
> > > 
> > > Once we update the pointer to the new node we will drop the node we
> > > removed the link for and all of its children via btrfs_drop_subtree().
> > > This is essentially just btrfs_drop_snapshot(), but for an arbitrary
> > > point in the snapshot.
> > > 
> > > The problem with this is that we will never reflect this in the backref
> > > cache.  If we do this btrfs_drop_snapshot() for a node that is in the
> > > backref tree, we will leave the node in the backref tree.  This becomes
> > > a problem when we change the transid, as now the backref cache has
> > > entire subtrees that no longer exist, but exist as if they still are
> > > pointed to by the same roots.
> > > 
> > > In the best case scenario you end up with "adding refs to an existing
> > > tree ref" errors from insert_inline_extent_backref(), where we attempt
> > > to link in nodes on roots that are no longer valid.
> > > 
> > > Worst case you will double free some random block and re-use it when
> > > there's still references to the block.
> > > 
> > > This is extremely subtle, and the consequences are quite bad.  There
> > > isn't a way to make sure our backref cache is consistent between
> > > transid's.
> > > 
> > > In order to fix this we need to simply evict the entire backref cache
> > > anytime we cross transid's.  This reduces performance in that we have to
> > > rebuild this backref cache every time we change transid's, but fixes the
> > > bug.
> > > 
> > > This has existed since relocation was added, and is a pretty critical
> > > bug.  There's a lot more cleanup that can be done now that this
> > > functionality is going away, but this patch is as small as possible in
> > > order to fix the problem and make it easy for us to backport it to all
> > > the kernels it needs to be backported to.
> > > 
> > > Followup series will dismantle more of this code and simplify relocation
> > > drastically to remove this functionality.
> > 
> > +1
> > 
> > > 
> > > We have a reproducer that reproduced the corruption within a few minutes
> > > of running.  With this patch it survives several iterations/hours of
> > > running the reproducer.
> > > 
> > > Fixes: 3fd0a5585eb9 ("Btrfs: Metadata ENOSPC handling for balance")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/btrfs/backref.c    | 12 ++++---
> > >  fs/btrfs/relocation.c | 76 +++----------------------------------------
> > >  2 files changed, 13 insertions(+), 75 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > > index e2f478ecd7fd..f8e1d5b2c512 100644
> > > --- a/fs/btrfs/backref.c
> > > +++ b/fs/btrfs/backref.c
> > > @@ -3179,10 +3179,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
> > >  		btrfs_backref_cleanup_node(cache, node);
> > >  	}
> > >  
> > > -	cache->last_trans = 0;
> > > -
> > > -	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
> > > -		ASSERT(list_empty(&cache->pending[i]));
> > > +	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
> > > +		while (!list_empty(&cache->pending[i])) {
> > > +			node = list_first_entry(&cache->pending[i],
> > > +						struct btrfs_backref_node,
> > > +						list);
> > > +			btrfs_backref_cleanup_node(cache, node);
> > > +		}
> > > +	}
> > 
> > Non blocking suggestion:
> > 
> > The fact that this cleanup has to keep an accurate view of the leaves
> > while it runs feels like overkill. If we just maintained a linked list
> > of all the nodes/edges we could call kfree on all of them. I think the
> > existing rbtree of nodes would probably just work too?
> > 
> > I think just adding the pending instead of assuming it's empty makes
> > sense, though.
> 
> This is one of the cleanups that's coming, because we keep a list of everything
> in either ->leaves or ->detached, and now we can have them in the pending list.
> The cleanup function assumes that everything that is handled at this point so
> everything should be empty.
> 
> This is obviously silly, so the cleanup is to iterate the rbtree and free that
> way and not have all this stuff.
> 
> We were only calling this after we were completely done with the loop for
> backref cache, so the pending lists should have been empty if there was an error
> and cleaned up before calling this function.
> 
> But now because we're calling it every time we have to make sure we evict the
> pending list ourselves.
> 
> Again, this was done for simplicity sake, the problem is bad enough we want it
> to be backported as widely as possible, so all other cleanup stuff is going to
> be done separately.
> 
> > 
> > >  	ASSERT(list_empty(&cache->pending_edge));
> > >  	ASSERT(list_empty(&cache->useless_node));
> > >  	ASSERT(list_empty(&cache->changed));
> > > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > > index ea4ed85919ec..aaa9cac213f1 100644
> > > --- a/fs/btrfs/relocation.c
> > > +++ b/fs/btrfs/relocation.c
> > > @@ -232,70 +232,6 @@ static struct btrfs_backref_node *walk_down_backref(
> > >  	return NULL;
> > >  }
> > >  
> > > -static void update_backref_node(struct btrfs_backref_cache *cache,
> > > -				struct btrfs_backref_node *node, u64 bytenr)
> > > -{
> > > -	struct rb_node *rb_node;
> > > -	rb_erase(&node->rb_node, &cache->rb_root);
> > > -	node->bytenr = bytenr;
> > > -	rb_node = rb_simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
> > > -	if (rb_node)
> > > -		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
> > > -}
> > > -
> > > -/*
> > > - * update backref cache after a transaction commit
> > > - */
> > > -static int update_backref_cache(struct btrfs_trans_handle *trans,
> > > -				struct btrfs_backref_cache *cache)
> > > -{
> > > -	struct btrfs_backref_node *node;
> > > -	int level = 0;
> > > -
> > > -	if (cache->last_trans == 0) {
> > > -		cache->last_trans = trans->transid;
> > > -		return 0;
> > > -	}
> > > -
> > > -	if (cache->last_trans == trans->transid)
> > > -		return 0;
> > > -
> > > -	/*
> > > -	 * detached nodes are used to avoid unnecessary backref
> > > -	 * lookup. transaction commit changes the extent tree.
> > > -	 * so the detached nodes are no longer useful.
> > > -	 */
> > > -	while (!list_empty(&cache->detached)) {
> > > -		node = list_entry(cache->detached.next,
> > > -				  struct btrfs_backref_node, list);
> > > -		btrfs_backref_cleanup_node(cache, node);
> > > -	}
> > > -
> > > -	while (!list_empty(&cache->changed)) {
> > > -		node = list_entry(cache->changed.next,
> > > -				  struct btrfs_backref_node, list);
> > > -		list_del_init(&node->list);
> > > -		BUG_ON(node->pending);
> > > -		update_backref_node(cache, node, node->new_bytenr);
> > > -	}
> > > -
> > > -	/*
> > > -	 * some nodes can be left in the pending list if there were
> > > -	 * errors during processing the pending nodes.
> > > -	 */
> > > -	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
> > > -		list_for_each_entry(node, &cache->pending[level], list) {
> > > -			BUG_ON(!node->pending);
> > > -			if (node->bytenr == node->new_bytenr)
> > > -				continue;
> > > -			update_backref_node(cache, node, node->new_bytenr);
> > > -		}
> > > -	}
> > > -
> > > -	cache->last_trans = 0;
> > > -	return 1;
> > > -}
> > > -
> > >  static bool reloc_root_is_dead(const struct btrfs_root *root)
> > >  {
> > >  	/*
> > > @@ -551,9 +487,6 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
> > >  	struct btrfs_backref_edge *new_edge;
> > >  	struct rb_node *rb_node;
> > >  
> > > -	if (cache->last_trans > 0)
> > > -		update_backref_cache(trans, cache);
> > > -
> > 
> > This looks suspicious to me. You said in the commit message that we need
> > to nuke the cache any time we cross a transid. However, here, you detect
> > a changed transid s.t. we would be calling update (presumably for some
> > reason someone felt was important) but now we are just skipping it.
> > 
> > Why is this correct/safe? Do we need to dump the cache here too? Are we
> > never going to hit this because of some implicit synchronization between
> > this post snapshot path and the cache-blowing-up you added to
> > relocate_block_group?
> > 
> > And if we need to dump the cache here to be safe, are you sure the other
> > places we can go into the relocation code from outside
> > relocate_block_group are safe to interact with an old cache too? I'm
> > thinking of btrfs_reloc_cow_block primarily.
> 
> This is an extremely subtle part.  clone_backref_node() is called when we create
> the reloc root, which can happen out of band of the relocation, so outside of
> the relocate_block_group loop.
> 
> This was made to work in conjunction with the updating logic, so we had to call
> it here in order to make sure the code in clone found the right nodes, because
> src->commit_root->start would have been in ->new_bytenr if we hadn't updated the
> backref cache yet.
> 
> Now we don't care, if it happens out of band we actually don't want to keep
> those cloned backref cache, so the relocate block group loop will evict the
> cache and rebuild it anyway.
> 
> If this happens where it should, eg select_reloc_root, then the cache will be
> uptodate and src->commit_root->start will match what exists in the backref
> cache.
> 
> This is safe specifically because in the relocate block group loop we will evict
> everything, and then any reloc root creation that happens once we have the
> bacrekf cache in place will be synchronized appropriately.

I thought about it some more, and noticed that the clone_backref_node
can only be called in the transaction critical section in
create_pending_snapshot, while the btrfs_relocate_block_group can only
run under a transaction, so if clone_backref_node runs, relocation is
guaranteed to see a changed transid by the time it runs. Since the
effects of clone_backref_node are contained entirely to the backref
cache, which we are guaranteed is gonna be blown away next relocation
step, I think we can just omit clone_backref_node entirely?

Whether we want to get rid of it entirely or not, I am relatively
convinced now that this aspect of the patch is fine.

On the other hand, I am now extremely concerned about the interaction
between the new relocate_block_group and btrfs_reloc_cow_block...
> 
> > 
> > >  	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
> > >  	if (rb_node) {
> > >  		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
> > > @@ -3698,10 +3631,11 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
> > >  			break;
> > >  		}
> > >  restart:
> > > -		if (update_backref_cache(trans, &rc->backref_cache)) {
> > > -			btrfs_end_transaction(trans);
> > > -			trans = NULL;
> > > -			continue;
> > > +		if (rc->backref_cache.last_trans == 0) {
> > > +			rc->backref_cache.last_trans = trans->transid;
> > > +		} else if (rc->backref_cache.last_trans != trans->transid) {
> > > +			btrfs_backref_release_cache(&rc->backref_cache);

What prevents a race between this and btrfs_reloc_cow_block running
node = rc->backref_cache.path[level];

I feel like I must be missing some higher level synchronization between
the two, but if my suspicion is right, btrfs_reloc_cow_block would now
grab a backref_cache node and use it while btrfs_backref_release_cache
called kfree on it, probably resulting in UAF.

> > > +			rc->backref_cache.last_trans = trans->transid;
> > 
> > Non blocking suggestion:
> > This feels like it could be simpler if we initialized last_trans to 0
> > after allocated the reloc_control, then we could just check if we need
> > to release, then unconditionally update.
> 
> Do you mean this?
> 
> if (rc->backref_cache.last_trans != trans->transid) {
> 	if (rc->backref_cache.last_trans)
> 		btrfs_backref_release_cache(&rc->backref_cache);
> 	rc->backref_cache.last_trans = trans->transid;
> }

Yeah, or even

if (rc->backref_cache.last_trans != trans->transid)
        btrfs_backref_release_cache(&rc->backref_cache);
// no-op if they are equal
rc->backref_cache.last_trans = trans->transid;

> 
> Thanks,
> 
> Josef

