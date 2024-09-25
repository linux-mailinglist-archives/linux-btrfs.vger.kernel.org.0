Return-Path: <linux-btrfs+bounces-8227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6439866A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BE028560B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01D13D61B;
	Wed, 25 Sep 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="i6ZD7fZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnbgW0Xn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66222219E0;
	Wed, 25 Sep 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291269; cv=none; b=f1u6XawpCmDitqBwdjlX09Nxz8V6H5hsJG9G+gyk0S1Og4E9Fpz26MXipFuvlFEcciIkFeYvLA2T+C8/idmn9fcGv7yQkDPSs6Jk7msw9uB8B2wl62x+kXXcSVjWUYGVWM9tv1NhXJVefNXW23SnNgSu/5eRY41ZDBDguHDQGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291269; c=relaxed/simple;
	bh=UkbjWlTzZnNL4hhjtWg6oW2A22aIoNFXxmMA0atJCYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW7ody+ryFRnCBJgagAo6+4xOg6XTf3D5C0sZEwQ6MxQHeqRsrTpF9R9wQJMSvJ60VdyUbrONWZO2pYvwQu9BQlccWzOwJoM0AQ5EjQzv9mzJfOCMRgn7uOH4p1024tDApvZKmUPEG0h8Zi9LN2Vr594BjQCyLXY8RKrlwYRpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=i6ZD7fZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnbgW0Xn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 24FDD13801AF;
	Wed, 25 Sep 2024 15:07:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 25 Sep 2024 15:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727291265; x=1727377665; bh=8Tz2aYGA8S
	+d1SbgAQMdVTdnar1kOMDFXM6be291BmU=; b=i6ZD7fZPHE+Uabj5D+K1q4Ibbs
	mqf6PxFlbZqad9vgNBjUzmNtsAaO6g0QaTH6HkfSKM7F2jgals2zPE+kwEhAmDNZ
	KgWPs55iknZ3ftZVOTmNJc13NbGXsd52hwRhE6cioYR+Q3l7R42DGhN0zOBMqmzu
	ce94eSpHJlc8tAkqQRjtgAM1GWpXSgNkyFrrYeYssfD67UEYzIHeezt3d9MxxnfT
	qoIZR7BSRXxK/yRgMRnSdPP1vxddzLNEO25PpUn/ktzWS1o9vxBjNByvSZ6OF4A4
	gjC/g1HIIJUnTEvwhn6OhAXfavWgajODMU2Fm3SHLmqO+GsJo+xcGOm4LGeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727291265; x=1727377665; bh=8Tz2aYGA8S+d1SbgAQMdVTdnar1k
	OMDFXM6be291BmU=; b=OnbgW0Xnb11dsKyHwnYPPhO0VG/CltqYyy2QPK6TAEFY
	rxGuzdnYcybw2p04Uqq2BusRnB6KabgZAauTlcvNhrdT5oRERDujK7QHaNrMGCtB
	S3KYDPIzwX2wULhbjfT6oc/TRTXbq8OgAuB9pCkVqzhmSVtKNrMb2g0E071gQKkT
	UoaE9E9+Q+6p2hyTLYpweiAcUmxVXWJBmCn/FuBaB1Lidfk0D1LMREh5wquu7N3B
	KA/RSA7WwWBsqqIwL2dhc27E3B+yqeHheU23elju3h2CoInmf9uojT/Lkl2Ily60
	QwG4yOpT8juDLhrDTolK2dBxdVueW6k4FG7T6aaBig==
X-ME-Sender: <xms:gF_0ZjaQkHN-o_ystKunMFxwaEGn1VAGbmVNr-hVAGc_rFnGpXAXQA>
    <xme:gF_0ZiYH3CMlcqrE34gRM1OEvdEaYUNbnIm_8aT9qV7VdwzBne_ZaH-QcmA-xnFtT
    kXLGCSxLgdhvUdiMS4>
X-ME-Received: <xmr:gF_0Zl-Hg3WuK46RDmG9P6j3711nb1wj_1h6Subti4GjcMW3NO3_6FtOYz4PNxvend0R_c0rvHKcdqBdmTryuvGTnC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepsh
    htrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gF_0ZpppF6frET7Bjoh7vjb3k25kM6eFhKGhy9EbxJYjHU2VG6CMuw>
    <xmx:gF_0ZuoWFFCcKGbciyYseAFtuo6fskcT7sx_YFroWsp9XkYUebQiLQ>
    <xmx:gF_0ZvSZwrGu3TrEf7lZAIJRZD90j0zM5WjaWcIeHAB97XVKmLBuGA>
    <xmx:gF_0ZmpWun0G0MV2jn_hXCar8ACALHPa6axywfu2ZyJ8dTPBHrEeuQ>
    <xmx:gV_0ZnmI9JirucwaXDyottopkYvsWe8Q45k4q7uWgz1Xo4ATOz50VIhu>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 15:07:44 -0400 (EDT)
Date: Wed, 25 Sep 2024 12:07:43 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop the backref cache during relocation if we
 commit
Message-ID: <20240925190743.GA2997332@zen.localdomain>
References: <68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com>

On Tue, Sep 24, 2024 at 05:11:37PM -0400, Josef Bacik wrote:
> Since the inception of relocation we have maintained the backref cache
> across transaction commits, updating the backref cache with the new
> bytenr whenever we COW'ed blocks that were in the cache, and then
> updating their bytenr once we detected a transaction id change.
> 
> This works as long as we're only ever modifying blocks, not changing the
> structure of the tree.
> 
> However relocation does in fact change the structure of the tree.  For
> example, if we are relocating a data extent, we will look up all the
> leaves that point to this data extent.  We will then call
> do_relocation() on each of these leaves, which will COW down to the leaf
> and then update the file extent location.
> 
> But, a key feature of do_relocation is the pending list.  This is all
> the pending nodes that we modified when we updated the file extent item.
> We will then process all of these blocks via finish_pending_nodes, which
> calls do_relocation() on all of the nodes that led up to that leaf.
> 
> The purpose of this is to make sure we don't break sharing unless we
> absolutely have to.  Consider the case that we have 3 snapshots that all
> point to this leaf through the same nodes, the initial COW would have
> created a whole new path.  If we did this for all 3 snapshots we would
> end up with 3x the number of nodes we had originally.  To avoid this we
> will cycle through each of the snapshots that point to each of these
> nodes and update their pointers to point at the new nodes.
> 
> Once we update the pointer to the new node we will drop the node we
> removed the link for and all of its children via btrfs_drop_subtree().
> This is essentially just btrfs_drop_snapshot(), but for an arbitrary
> point in the snapshot.
> 
> The problem with this is that we will never reflect this in the backref
> cache.  If we do this btrfs_drop_snapshot() for a node that is in the
> backref tree, we will leave the node in the backref tree.  This becomes
> a problem when we change the transid, as now the backref cache has
> entire subtrees that no longer exist, but exist as if they still are
> pointed to by the same roots.
> 
> In the best case scenario you end up with "adding refs to an existing
> tree ref" errors from insert_inline_extent_backref(), where we attempt
> to link in nodes on roots that are no longer valid.
> 
> Worst case you will double free some random block and re-use it when
> there's still references to the block.
> 
> This is extremely subtle, and the consequences are quite bad.  There
> isn't a way to make sure our backref cache is consistent between
> transid's.
> 
> In order to fix this we need to simply evict the entire backref cache
> anytime we cross transid's.  This reduces performance in that we have to
> rebuild this backref cache every time we change transid's, but fixes the
> bug.
> 
> This has existed since relocation was added, and is a pretty critical
> bug.  There's a lot more cleanup that can be done now that this
> functionality is going away, but this patch is as small as possible in
> order to fix the problem and make it easy for us to backport it to all
> the kernels it needs to be backported to.
> 
> Followup series will dismantle more of this code and simplify relocation
> drastically to remove this functionality.

+1

> 
> We have a reproducer that reproduced the corruption within a few minutes
> of running.  With this patch it survives several iterations/hours of
> running the reproducer.
> 
> Fixes: 3fd0a5585eb9 ("Btrfs: Metadata ENOSPC handling for balance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/backref.c    | 12 ++++---
>  fs/btrfs/relocation.c | 76 +++----------------------------------------
>  2 files changed, 13 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e2f478ecd7fd..f8e1d5b2c512 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -3179,10 +3179,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
>  		btrfs_backref_cleanup_node(cache, node);
>  	}
>  
> -	cache->last_trans = 0;
> -
> -	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
> -		ASSERT(list_empty(&cache->pending[i]));
> +	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
> +		while (!list_empty(&cache->pending[i])) {
> +			node = list_first_entry(&cache->pending[i],
> +						struct btrfs_backref_node,
> +						list);
> +			btrfs_backref_cleanup_node(cache, node);
> +		}
> +	}

Non blocking suggestion:

The fact that this cleanup has to keep an accurate view of the leaves
while it runs feels like overkill. If we just maintained a linked list
of all the nodes/edges we could call kfree on all of them. I think the
existing rbtree of nodes would probably just work too?

I think just adding the pending instead of assuming it's empty makes
sense, though.

>  	ASSERT(list_empty(&cache->pending_edge));
>  	ASSERT(list_empty(&cache->useless_node));
>  	ASSERT(list_empty(&cache->changed));
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index ea4ed85919ec..aaa9cac213f1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -232,70 +232,6 @@ static struct btrfs_backref_node *walk_down_backref(
>  	return NULL;
>  }
>  
> -static void update_backref_node(struct btrfs_backref_cache *cache,
> -				struct btrfs_backref_node *node, u64 bytenr)
> -{
> -	struct rb_node *rb_node;
> -	rb_erase(&node->rb_node, &cache->rb_root);
> -	node->bytenr = bytenr;
> -	rb_node = rb_simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
> -	if (rb_node)
> -		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
> -}
> -
> -/*
> - * update backref cache after a transaction commit
> - */
> -static int update_backref_cache(struct btrfs_trans_handle *trans,
> -				struct btrfs_backref_cache *cache)
> -{
> -	struct btrfs_backref_node *node;
> -	int level = 0;
> -
> -	if (cache->last_trans == 0) {
> -		cache->last_trans = trans->transid;
> -		return 0;
> -	}
> -
> -	if (cache->last_trans == trans->transid)
> -		return 0;
> -
> -	/*
> -	 * detached nodes are used to avoid unnecessary backref
> -	 * lookup. transaction commit changes the extent tree.
> -	 * so the detached nodes are no longer useful.
> -	 */
> -	while (!list_empty(&cache->detached)) {
> -		node = list_entry(cache->detached.next,
> -				  struct btrfs_backref_node, list);
> -		btrfs_backref_cleanup_node(cache, node);
> -	}
> -
> -	while (!list_empty(&cache->changed)) {
> -		node = list_entry(cache->changed.next,
> -				  struct btrfs_backref_node, list);
> -		list_del_init(&node->list);
> -		BUG_ON(node->pending);
> -		update_backref_node(cache, node, node->new_bytenr);
> -	}
> -
> -	/*
> -	 * some nodes can be left in the pending list if there were
> -	 * errors during processing the pending nodes.
> -	 */
> -	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
> -		list_for_each_entry(node, &cache->pending[level], list) {
> -			BUG_ON(!node->pending);
> -			if (node->bytenr == node->new_bytenr)
> -				continue;
> -			update_backref_node(cache, node, node->new_bytenr);
> -		}
> -	}
> -
> -	cache->last_trans = 0;
> -	return 1;
> -}
> -
>  static bool reloc_root_is_dead(const struct btrfs_root *root)
>  {
>  	/*
> @@ -551,9 +487,6 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
>  	struct btrfs_backref_edge *new_edge;
>  	struct rb_node *rb_node;
>  
> -	if (cache->last_trans > 0)
> -		update_backref_cache(trans, cache);
> -

This looks suspicious to me. You said in the commit message that we need
to nuke the cache any time we cross a transid. However, here, you detect
a changed transid s.t. we would be calling update (presumably for some
reason someone felt was important) but now we are just skipping it.

Why is this correct/safe? Do we need to dump the cache here too? Are we
never going to hit this because of some implicit synchronization between
this post snapshot path and the cache-blowing-up you added to
relocate_block_group?

And if we need to dump the cache here to be safe, are you sure the other
places we can go into the relocation code from outside
relocate_block_group are safe to interact with an old cache too? I'm
thinking of btrfs_reloc_cow_block primarily.

>  	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
>  	if (rb_node) {
>  		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
> @@ -3698,10 +3631,11 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  			break;
>  		}
>  restart:
> -		if (update_backref_cache(trans, &rc->backref_cache)) {
> -			btrfs_end_transaction(trans);
> -			trans = NULL;
> -			continue;
> +		if (rc->backref_cache.last_trans == 0) {
> +			rc->backref_cache.last_trans = trans->transid;
> +		} else if (rc->backref_cache.last_trans != trans->transid) {
> +			btrfs_backref_release_cache(&rc->backref_cache);
> +			rc->backref_cache.last_trans = trans->transid;

Non blocking suggestion:
This feels like it could be simpler if we initialized last_trans to 0
after allocated the reloc_control, then we could just check if we need
to release, then unconditionally update.

>  		}
>  
>  		ret = find_next_extent(rc, path, &key);
> -- 
> 2.43.0
> 

