Return-Path: <linux-btrfs+bounces-8228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F3C98677E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B552BB20946
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77014884C;
	Wed, 25 Sep 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ztk+aoGN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2A13BAD5
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295460; cv=none; b=o02Z1XxHYKQ8Lf15pw1BmeEmXu1/reEI9HPLjG+0SZ/nOiFWwbd1vJLZaEbfYBKH8P0tw3W4K3oOImPxpSugY+WrA1NV/YjHJnkCjsYycprXCAdB/t7H6Ty7ftWNfur8yaeRPUoyCKUMFOAdosnHL6Xs3Plk/yj0QeYuUBtZ0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295460; c=relaxed/simple;
	bh=1F+pOoTT3KZZndL4hANlflemEzTKuqJA9yxqX2Kv1hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndiHHfvA1uXIWqJRRotVO9fh79HMZkd6ptnNznry5iia4jyvcfY1b43HpBP70DOTUklyNx/xEGRXP+yLZ7MUhLHMRJnRjIRY7yrJ+6orVdsoPijPI5dvq4oQ4zepSZGOTrz9u32QDhSbKOgDq7EO9h/SEqPzvrhBofMZzXnyhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Ztk+aoGN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ddceaaa9f4so2662727b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727295456; x=1727900256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDITRgiaK5n2n4iWh204/20WaEgGngKYA5mIc+ZfZKk=;
        b=Ztk+aoGNzNVjUI/INdaYqD9t5tA7uD8Oei+k/NSI+lqghRFZSPk0ZUdgCBbxH71M1A
         jXykbYK5ig+SwHthjM306gxFs5odqxAxiHA42AFZXCm0f3F8cWpgwModzoxd6fa9fkdG
         EQj6yW/FNMnuj2i5D4NDjvIbjGm8riwpJimrLy00ESIFI7qhUfgNTCB1xQnwIz+Rtz7p
         Ht4l6rHGPc43mD1dYBGWP2y1N9WUYQZzX7ZyF0t4ZuovczjKLcFs4S8vEfFWTFWqTyFY
         vvoIvXnbJnfJBauv/B+ACmyO6qYSR7ydwHstNyrRuBXZZb26cWeKFjeRQTXX+VkvqFjS
         zNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295456; x=1727900256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDITRgiaK5n2n4iWh204/20WaEgGngKYA5mIc+ZfZKk=;
        b=m8mvvXzSJcwITmJRNZSHjk7YfyKMN7sKLR4t5OGhuolmFxx38igQFl7Wgb/7FXtWMv
         jJTcVgMoRgt1k498taK0cuKTkYvn2gbzo0cN3lm2pMZZAtpgWEzGEpGu+0xXu4ybbCGp
         oBhXj4dfbwnHydBNL6TpmmXfhCwsoPDuCehcuadsGvbqw0R2QOupoZATxyLwYWANiGqc
         BwRt7NFw+D4I5kfvnUe+C0vPo17qZ3fDp3KnLckcD4N8BzfZ/mYPro+FzMWXTfjnwU65
         C7UXS2eqyUqSsbyHxF3VlUqHVFvgYA6Gq+sRKG88qoDYdMrTkmXrQcU3PtKI7F+aCvni
         KGCQ==
X-Gm-Message-State: AOJu0Yxj91DT1I9EgKgCZkAdIEuOHa+xPolNLA+wLi2bNSqgtkbDQrYp
	NEJDyHupCVtnnlZePRlVMUjEd1/HBt7KnxjR7C3pQ2O15mpaMbXy3UTcFJkPsMs=
X-Google-Smtp-Source: AGHT+IG+qKzjSB0ShoEtgnotPwyD4iza4Oto+ZTiThMsS1fEIyCxOOh8N3ZJZ4s3P4erNDSV1h00Ag==
X-Received: by 2002:a05:690c:10d:b0:6e2:1a7f:20d3 with SMTP id 00721157ae682-6e21da219b2mr31687387b3.37.1727295455702;
        Wed, 25 Sep 2024 13:17:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d27fedbsm7259617b3.115.2024.09.25.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:17:34 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:17:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop the backref cache during relocation if we
 commit
Message-ID: <20240925201734.GA296133@perftesting>
References: <68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com>
 <20240925190743.GA2997332@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925190743.GA2997332@zen.localdomain>

On Wed, Sep 25, 2024 at 12:07:43PM -0700, Boris Burkov wrote:
> On Tue, Sep 24, 2024 at 05:11:37PM -0400, Josef Bacik wrote:
> > Since the inception of relocation we have maintained the backref cache
> > across transaction commits, updating the backref cache with the new
> > bytenr whenever we COW'ed blocks that were in the cache, and then
> > updating their bytenr once we detected a transaction id change.
> > 
> > This works as long as we're only ever modifying blocks, not changing the
> > structure of the tree.
> > 
> > However relocation does in fact change the structure of the tree.  For
> > example, if we are relocating a data extent, we will look up all the
> > leaves that point to this data extent.  We will then call
> > do_relocation() on each of these leaves, which will COW down to the leaf
> > and then update the file extent location.
> > 
> > But, a key feature of do_relocation is the pending list.  This is all
> > the pending nodes that we modified when we updated the file extent item.
> > We will then process all of these blocks via finish_pending_nodes, which
> > calls do_relocation() on all of the nodes that led up to that leaf.
> > 
> > The purpose of this is to make sure we don't break sharing unless we
> > absolutely have to.  Consider the case that we have 3 snapshots that all
> > point to this leaf through the same nodes, the initial COW would have
> > created a whole new path.  If we did this for all 3 snapshots we would
> > end up with 3x the number of nodes we had originally.  To avoid this we
> > will cycle through each of the snapshots that point to each of these
> > nodes and update their pointers to point at the new nodes.
> > 
> > Once we update the pointer to the new node we will drop the node we
> > removed the link for and all of its children via btrfs_drop_subtree().
> > This is essentially just btrfs_drop_snapshot(), but for an arbitrary
> > point in the snapshot.
> > 
> > The problem with this is that we will never reflect this in the backref
> > cache.  If we do this btrfs_drop_snapshot() for a node that is in the
> > backref tree, we will leave the node in the backref tree.  This becomes
> > a problem when we change the transid, as now the backref cache has
> > entire subtrees that no longer exist, but exist as if they still are
> > pointed to by the same roots.
> > 
> > In the best case scenario you end up with "adding refs to an existing
> > tree ref" errors from insert_inline_extent_backref(), where we attempt
> > to link in nodes on roots that are no longer valid.
> > 
> > Worst case you will double free some random block and re-use it when
> > there's still references to the block.
> > 
> > This is extremely subtle, and the consequences are quite bad.  There
> > isn't a way to make sure our backref cache is consistent between
> > transid's.
> > 
> > In order to fix this we need to simply evict the entire backref cache
> > anytime we cross transid's.  This reduces performance in that we have to
> > rebuild this backref cache every time we change transid's, but fixes the
> > bug.
> > 
> > This has existed since relocation was added, and is a pretty critical
> > bug.  There's a lot more cleanup that can be done now that this
> > functionality is going away, but this patch is as small as possible in
> > order to fix the problem and make it easy for us to backport it to all
> > the kernels it needs to be backported to.
> > 
> > Followup series will dismantle more of this code and simplify relocation
> > drastically to remove this functionality.
> 
> +1
> 
> > 
> > We have a reproducer that reproduced the corruption within a few minutes
> > of running.  With this patch it survives several iterations/hours of
> > running the reproducer.
> > 
> > Fixes: 3fd0a5585eb9 ("Btrfs: Metadata ENOSPC handling for balance")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/backref.c    | 12 ++++---
> >  fs/btrfs/relocation.c | 76 +++----------------------------------------
> >  2 files changed, 13 insertions(+), 75 deletions(-)
> > 
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index e2f478ecd7fd..f8e1d5b2c512 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -3179,10 +3179,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
> >  		btrfs_backref_cleanup_node(cache, node);
> >  	}
> >  
> > -	cache->last_trans = 0;
> > -
> > -	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
> > -		ASSERT(list_empty(&cache->pending[i]));
> > +	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
> > +		while (!list_empty(&cache->pending[i])) {
> > +			node = list_first_entry(&cache->pending[i],
> > +						struct btrfs_backref_node,
> > +						list);
> > +			btrfs_backref_cleanup_node(cache, node);
> > +		}
> > +	}
> 
> Non blocking suggestion:
> 
> The fact that this cleanup has to keep an accurate view of the leaves
> while it runs feels like overkill. If we just maintained a linked list
> of all the nodes/edges we could call kfree on all of them. I think the
> existing rbtree of nodes would probably just work too?
> 
> I think just adding the pending instead of assuming it's empty makes
> sense, though.

This is one of the cleanups that's coming, because we keep a list of everything
in either ->leaves or ->detached, and now we can have them in the pending list.
The cleanup function assumes that everything that is handled at this point so
everything should be empty.

This is obviously silly, so the cleanup is to iterate the rbtree and free that
way and not have all this stuff.

We were only calling this after we were completely done with the loop for
backref cache, so the pending lists should have been empty if there was an error
and cleaned up before calling this function.

But now because we're calling it every time we have to make sure we evict the
pending list ourselves.

Again, this was done for simplicity sake, the problem is bad enough we want it
to be backported as widely as possible, so all other cleanup stuff is going to
be done separately.

> 
> >  	ASSERT(list_empty(&cache->pending_edge));
> >  	ASSERT(list_empty(&cache->useless_node));
> >  	ASSERT(list_empty(&cache->changed));
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index ea4ed85919ec..aaa9cac213f1 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -232,70 +232,6 @@ static struct btrfs_backref_node *walk_down_backref(
> >  	return NULL;
> >  }
> >  
> > -static void update_backref_node(struct btrfs_backref_cache *cache,
> > -				struct btrfs_backref_node *node, u64 bytenr)
> > -{
> > -	struct rb_node *rb_node;
> > -	rb_erase(&node->rb_node, &cache->rb_root);
> > -	node->bytenr = bytenr;
> > -	rb_node = rb_simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
> > -	if (rb_node)
> > -		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
> > -}
> > -
> > -/*
> > - * update backref cache after a transaction commit
> > - */
> > -static int update_backref_cache(struct btrfs_trans_handle *trans,
> > -				struct btrfs_backref_cache *cache)
> > -{
> > -	struct btrfs_backref_node *node;
> > -	int level = 0;
> > -
> > -	if (cache->last_trans == 0) {
> > -		cache->last_trans = trans->transid;
> > -		return 0;
> > -	}
> > -
> > -	if (cache->last_trans == trans->transid)
> > -		return 0;
> > -
> > -	/*
> > -	 * detached nodes are used to avoid unnecessary backref
> > -	 * lookup. transaction commit changes the extent tree.
> > -	 * so the detached nodes are no longer useful.
> > -	 */
> > -	while (!list_empty(&cache->detached)) {
> > -		node = list_entry(cache->detached.next,
> > -				  struct btrfs_backref_node, list);
> > -		btrfs_backref_cleanup_node(cache, node);
> > -	}
> > -
> > -	while (!list_empty(&cache->changed)) {
> > -		node = list_entry(cache->changed.next,
> > -				  struct btrfs_backref_node, list);
> > -		list_del_init(&node->list);
> > -		BUG_ON(node->pending);
> > -		update_backref_node(cache, node, node->new_bytenr);
> > -	}
> > -
> > -	/*
> > -	 * some nodes can be left in the pending list if there were
> > -	 * errors during processing the pending nodes.
> > -	 */
> > -	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
> > -		list_for_each_entry(node, &cache->pending[level], list) {
> > -			BUG_ON(!node->pending);
> > -			if (node->bytenr == node->new_bytenr)
> > -				continue;
> > -			update_backref_node(cache, node, node->new_bytenr);
> > -		}
> > -	}
> > -
> > -	cache->last_trans = 0;
> > -	return 1;
> > -}
> > -
> >  static bool reloc_root_is_dead(const struct btrfs_root *root)
> >  {
> >  	/*
> > @@ -551,9 +487,6 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
> >  	struct btrfs_backref_edge *new_edge;
> >  	struct rb_node *rb_node;
> >  
> > -	if (cache->last_trans > 0)
> > -		update_backref_cache(trans, cache);
> > -
> 
> This looks suspicious to me. You said in the commit message that we need
> to nuke the cache any time we cross a transid. However, here, you detect
> a changed transid s.t. we would be calling update (presumably for some
> reason someone felt was important) but now we are just skipping it.
> 
> Why is this correct/safe? Do we need to dump the cache here too? Are we
> never going to hit this because of some implicit synchronization between
> this post snapshot path and the cache-blowing-up you added to
> relocate_block_group?
> 
> And if we need to dump the cache here to be safe, are you sure the other
> places we can go into the relocation code from outside
> relocate_block_group are safe to interact with an old cache too? I'm
> thinking of btrfs_reloc_cow_block primarily.

This is an extremely subtle part.  clone_backref_node() is called when we create
the reloc root, which can happen out of band of the relocation, so outside of
the relocate_block_group loop.

This was made to work in conjunction with the updating logic, so we had to call
it here in order to make sure the code in clone found the right nodes, because
src->commit_root->start would have been in ->new_bytenr if we hadn't updated the
backref cache yet.

Now we don't care, if it happens out of band we actually don't want to keep
those cloned backref cache, so the relocate block group loop will evict the
cache and rebuild it anyway.

If this happens where it should, eg select_reloc_root, then the cache will be
uptodate and src->commit_root->start will match what exists in the backref
cache.

This is safe specifically because in the relocate block group loop we will evict
everything, and then any reloc root creation that happens once we have the
bacrekf cache in place will be synchronized appropriately.

> 
> >  	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
> >  	if (rb_node) {
> >  		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
> > @@ -3698,10 +3631,11 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
> >  			break;
> >  		}
> >  restart:
> > -		if (update_backref_cache(trans, &rc->backref_cache)) {
> > -			btrfs_end_transaction(trans);
> > -			trans = NULL;
> > -			continue;
> > +		if (rc->backref_cache.last_trans == 0) {
> > +			rc->backref_cache.last_trans = trans->transid;
> > +		} else if (rc->backref_cache.last_trans != trans->transid) {
> > +			btrfs_backref_release_cache(&rc->backref_cache);
> > +			rc->backref_cache.last_trans = trans->transid;
> 
> Non blocking suggestion:
> This feels like it could be simpler if we initialized last_trans to 0
> after allocated the reloc_control, then we could just check if we need
> to release, then unconditionally update.

Do you mean this?

if (rc->backref_cache.last_trans != trans->transid) {
	if (rc->backref_cache.last_trans)
		btrfs_backref_release_cache(&rc->backref_cache);
	rc->backref_cache.last_trans = trans->transid;
}

Thanks,

Josef

