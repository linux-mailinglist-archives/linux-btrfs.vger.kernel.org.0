Return-Path: <linux-btrfs+bounces-20110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49ECF537A
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBEF3035259
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981F72C08D9;
	Mon,  5 Jan 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lWiKNxaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRBYJYpK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492C1F94A
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637280; cv=none; b=KieHoCJBEnNPFFxjIcobI312Pyctabc7II3lFooX39OxdFBN0TuoqWf/jkIlB9miQSQYoJfl+3qugFgZ5Xf6D3gWFRZWupAdebsyMYqcQJC4o7b8tvnpQewNg/yxZwJqM8CRE56ZnBEBkWaqoHASW7+KhyaTF4FEflL1NAFuqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637280; c=relaxed/simple;
	bh=me+RcVruTruCQKAO7v9yZGRyGp3TGMtvo3GMCAdoZKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq0L6SUUvurHk0luOUZLb2erdMkkyKCft9S5J+icdCpRV8kZRB7nniPR2gg8rSC+eyzMQiTqbH+IkDSsrqeRXmxeVr+ybMJTuigYWajm1iQ6F81c5pgUYXNH01oRGtffGgmsv/tkkxxIuYMOdfueK7A6CtraqhwCbpoCwbfJ1jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lWiKNxaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRBYJYpK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 403601400013;
	Mon,  5 Jan 2026 13:21:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 13:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767637274;
	 x=1767723674; bh=DQliBRmniDv8AmuUfKy05dL8x8ADGfQtpyRQ9i7rylI=; b=
	lWiKNxaLehvfNQE1u+8/Xo6B0o5Tzu7bv7HPibh1QUgazHCfqS+zRCafotTA7xuu
	LolitFFVdwljrnimhCGQSIM55TinBIDBbu57cvNYvab9Z/QYj58EHjf0Aqfb6rgt
	qaoq03MgOZQ9yiCmw/q12NbcrawKFRj2Oc5Zh7Ali1EWzD98nzm4EmX/fliB/iIE
	Log6+78Zx45/duDxz92OjkPy5/aJgTBv2fes2yhr2Wc1OUchDKAIfOLJWBWJeH34
	/Ho0uYcjsoeKqt8Wx2dFvxxirXAgUli3KJ7zENNa97FeAaTT6N5KL7xPSKsNXotT
	kgUtg17ACRKiz0N0zZpazA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767637274; x=
	1767723674; bh=DQliBRmniDv8AmuUfKy05dL8x8ADGfQtpyRQ9i7rylI=; b=j
	RBYJYpKzMnbZ/01KTk99AGNN4UmA0a4y2KCulW8qAVpHvgN+z2W1WN0K02hm5fuI
	g43XzpT2OKSd0WKUQBCULoJJTsu2SXcD//t+JnqxmEPUOEnO4CUlmm/Tqp5+1qqL
	TRSfLQ8M4zSvsxlcj2AcN327J/aA9qQ733JCYZCCI8d/6rGszuzaH1lF8aiY4MWk
	mPgNqiCEDXdytAHJvMS7r+dbdJ37gBJ4RDHaIrG80QLNqTWvUMzmtXippDMpgSnZ
	bKboa3BkiGjJT2O58n9TPn+LA2HX7RPO38ikyOSH6d2Qtp80yuynmBQdeiGsnGIS
	2tpYZxpi5miPOwAjHVsJA==
X-ME-Sender: <xms:GgFcaWB4Y6WvP56UnsSIR836ubdIfrRdigGH8OZUSFx3iIlQR63l4w>
    <xme:GgFcaWgglNoQpKA5BrOaLiBLt2edhOIC0orb9b41BairctagBYx5svaNe2Sxby5Kz
    tzAP8BKUpUqDhZtgrO-9iakSv9gZDXiRrhJkPWeHbBeuR6aNucCFYk>
X-ME-Received: <xmr:GgFcaXMyWGqC65W9YMRg6jZMMPblQO_NlN8jdMzs2EZnoKFgy9ndsYuNufYASD6zK8sNKrTI_e_tOr-N03mUhpRsPpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvle
    dtvdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:GgFcaf4Vv-iFfgiFpoWEvJVfh9whDojgc2oaxcZbYQXrjZHAYN_EKg>
    <xmx:GgFcad0ODTtjs2tWARiPK0m_ajLuFqYbQ06edn0sylk8qyAJj430Lw>
    <xmx:GgFcaYbNPdd-E6begyHeJhT680lObvY1e32Spge9ggXSTJb_cEKhvw>
    <xmx:GgFcadCYE7OI-lEI3RCqHaHJNQmebA-fUx3wQdOIjbNB-1Jvc4Bozg>
    <xmx:GgFcaVz5Eivq7iuqTP8rjIWIjDg22t_toGGuzo-aJYbt-Vy1GWnFGu73>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 13:21:13 -0500 (EST)
Date: Mon, 5 Jan 2026 10:21:28 -0800
From: Boris Burkov <boris@bur.io>
To: Sun Yangkai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/7] btrfs: fix periodic reclaim condition
Message-ID: <20260105182102.GA1015682@zen.localdomain>
References: <20260103122504.10924-2-sunk67188@gmail.com>
 <20260103122504.10924-3-sunk67188@gmail.com>
 <20260104194008.GA416121@zen.localdomain>
 <7797d6e2-99b6-4112-9c7c-4cb09dde8486@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7797d6e2-99b6-4112-9c7c-4cb09dde8486@gmail.com>

On Mon, Jan 05, 2026 at 09:00:15PM +0800, Sun Yangkai wrote:
> 
> 
> 在 2026/1/5 03:40, Boris Burkov 写道:
> > On Sat, Jan 03, 2026 at 08:19:48PM +0800, Sun YangKai wrote:
> > 
> > First off, thank you very much for your attention to this and for
> > your in depth fixes.
> 
> Glad to hear from you and Happy New Year! :)
> 
> >> Problems with current implementation:
> >> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
> >>    negative reclaimable_bytes to trigger reclaim unexpectedly
> > 
> > Agreed, completely. IMO, the message here could use a bit more clarity
> > that negative reclaimable_bytes is an intentionally designed condition
> > so this is a fundamental bug, not a weird edge case.
> > 
> >> 2. The "space must be freed between scans" assumption breaks the
> >>    two-scan requirement: first scan marks block groups, second scan
> >>    reclaims them. Without the second scan, no reclamation occurs.
> > 
> > I think I understand what you are saying, but let me try to restate it
> > myself and confirm:
> > 
> > Previously, due to bug 1, we were calling
> > btrfs_set_periodic_reclaim_ready() too frequently (after an allocation
> > that made the reclaimable_bytes negative). With bug 1 fixed, you really
> > have to free a chunk_sz to call btrfs_set_periodic_reclaim_ready(). As a
> > result, periodic_reclaim became way too conservative. Now the
> > multi-sweep marking thing AND reclaim_ready mean we basically never
> > reclaim, as the second sweep doesn't get triggered later.
> > 
> > Is that about right? I agree that this needs some re-thinking / fixing,
> > if so.
> 
> Yes that is the case. Your statement is way much better than mine. A sweep
> always reclaim blockgroups marked by the previous sweep and mark blockgroups for
> the next sweep. That explains why the assumption is not proper and we need a new
> assumption to work on.
> 
> >> Instead, track actual reclaim progress: pause reclaim when block groups
> >> will be reclaimed, and resume only when progress is made. This ensures
> >> reclaim continues until no further progress can be made, then resumes when
> >> space_info changes or new reclaimable groups appear.
> > 
> > I think you are making a much bigger change than merely fixing the bugs
> > in the original design, so it requires deeper explanation of the new
> > invariants you are introducing. Clearly, I am one to talk about it, as I
> > messed up with my attempt, but I still think it is very valuable for
> > future readers. Thanks for bearing with me :)
> 
> Thank you for bring us such a cool feature so I can try it out, learn details of
> the implementation and bring some my opinions. I'm quite happy with these
> experience. I started with a simple fix but the change was getting bigger and
> bigger to reduce regressions and finally it's more like a redesign rather than a
> fix.
> 
> Sorry for the previous short but unclear statement and let me try to make it
> clear in the new year :)
> 
> Let's start with the new assumptions:
> 1. Reclaim is for getting more unallocated blockgroups/spaces.
> 2. Periodic reclaim should happen periodically :)
> 
> I think both users and developers will agree with this but I want to explain
> more about 2. Currently, the bg->reclaim_mark related logic and dynamic periodic
> reclaim logic both depend on 2. Your previous statement explains the former one
> very well and I'll focus on the latter one here.
> 
> When we have less than 10GiB unallocated space, dynamic periodic reclaim will
> kick in. With the filesystem getting fuller, the bg_reclaim_threshold is getting
> larger to make periodic reclaim more aggressive to reclaim some unallocated
> space. However, if we paused periodic reclaim when the threshold is small, like
> 19, then we'll never resume it even if we want to reclaim more aggressively with
> a larger threshold later. And dynamic periodic reclaim will not work as
> expected. This may happen when we first try reclaiming with threshold 19, while
> having some quite large extents in 10% used blockgroups and having no enough
> continuous free space in other 70+% full blockgroups. We'll fail to get more
> unallocated space, pause periodic reclaim, and not try reclaiming when the
> threshold gets larger than 79 later. This is why I resume periodic reclaim when
> threshold changes.
> 
> So the core issue of this part logic about periodic reclaim is when to pause and
> when to continue.

Agreed. And I think the larger point is that the signedness bug
invalidates just about everything to do with the existing "reclaim
ready" heuristics.

> 
> If we cannot free more unallocated blockgroups in periodic reclaim, we should
> pause it because we don't want to just move things from a blockgroup to a newly
> allocated blockgroup and then remove the old one periodically.

I observed exactly this, as well as reclaim attempts that would make a
bunch of allocations then fail on a later allocation attempt relocating
a larger extent which is a bunch of pointless cpu and lock churn in the
allocation algorithm.

> 
> And we should continue periodic reclaim when we may be able to free more
> blockgroups.
> 

This assumption I would push back on. This was my initial assumption as
well, but it is worth challenging. At Meta, we used to use the automatic
threshold based reclaim that reclaims every bg that goes over threshold
(25% for us) then back under. This actually creates a huge amount of
reclaim and was the reason for even coming up with dynamic thresholds.
In practice, switching to the buggy dynamic+periodic drastically reduced
this extra reclaim.

Suppose we allocate some block extents / block groups then free half the
space and fragment them. You might think it's best to rapidly compact
everything. But as long as we have unallocated and the holes are big
enough for allocations to come through and re-fill them, it's mostly OK.

We much more want to do a "minimal" amount of reclaim until we truly
need it.

With all that said, your points above about the threshold going up but
reclaim staying asleep make a lot of sense to me. That is a signal that
the "need" is increasing.

> For pausing, it's hard to tell if we're freeing more unallocated directly
> without changing current code. But in btrfs_reclaim_bgs_work() we have
> 
> btrfs_relocate_chunk()
>   ->btrfs_remove_chunk()
>     ->btrfs_remove_block_group()
> 
> So the old blockgroup is removed and we can see that in space_info->total_bytes.
> 
> Let's start with all the blockgroups having the same size and reclaiming a
> single blockgroup. If we succeeded moving extents into existing blockgroups,
> we'll not allocate a new one and space_info->total_bytes is getting smaller
> because we've freed the old one. If we failed moving things into existing bgs
> and allocated a new one, then space_info->total_bytes will not change.

Some of my comments on this point were silly, I was thinking about
used_bytes which would not change, not total_bytes. Thanks for the
detailed description to knock me out of that mistake.

Also, I'm not sure the logic about total_bytes is 100% ironclad, as
I haven't carefully checked what block group allocation/freeing is
possible concurrently over the span where you track the sizes.

> 
> When reclaiming n blockgroups, as long as we're using less space, such as n-1
> new blockgroups are allocated or n new smaller blockgroups, we're making some
> progress and able to detect that from space_info->total_bytes.
> 
> Reclaim may racing with some other work that free/allocate blockgroups, which
> will lead to either an unnecessary extra periodic reclaim or an unexpected
> pause. An extra periodic reclaim is not a big thing. But the unexpected pause
> matters. This is the only regression currently and I think that will not happen
> frequently.

OK, we're on the same page with the possibility of some racing :)
Your explanation makes sense and I don't think it's a huge deal or
anything.

> 
> For continuing, rather than tracing used_bytes, I think we should care more
> about unused_bytes. This is inspired by calc_dynamic_reclaim_threshold(), which
> will return 0 if there's no enough unused space. And also care about
> reclaim_threshold to make dynamic periodic reclaim work.
> 
> 

First, I think let's agree what we want and don't want to pause:
I don't think we care about running the reclaim sweep and checking
thresholds, updating marks, etc. That is relatively cheap. So if we
change the pausing logic to still allow that work more often, it's OK.
We really want to prevent triggering reclaims in tight fail loops.

With that said, let's consider all the cases again.

1. We scan all the bgs and don't attempt any reclaims.
2. We attempt a reclaim of BG X at threshold T and it completely fails to
allocate a new home for extent E of X.
3. We attempt a reclaim of BG X at threshold T and it "succeeds" by
allocating a new BG Y and moving all the extents from X to Y.
4. We attempt a reclaim of BG X at threshold T and it makes proper
progress and puts some the extents of X into the existing bgs.

After case 1, I think we agree pausing isn't needed, and is in fact bad.

After cases 2 and 3, we want to avoid triggering more reclaim until we
have evidence that it is likely a reclaim could possibly succeed. If
unused gets worse since then, and the threshold goes up, it is
*possible* a reclaim will succeed (we might pick a more full block group
that happens to be full of smaller easy to allocate extents) but it is
much more likely it won't. As far as I can tell, the best signal for
unpausing reclaim for the "we have seen a reclaim fail" case is still
"relative freeing" of extents.

After case 4, we don't *need* to pause, as it is going to increase
unallocated and reduce the "pressure" on the reclaim system, but it
doesn't fundamentally hurt either. We made some progress and we want to
be conservative and not be too greedy. Let allocation breathe and do
some work to fill the gaps up. However, this case is quite different
from 2 and 3 in that a subsequent relocation seems likely enough to also
succeed.

My original (designed) logic was "pause on 2,3,4; unpause on the
conditions that unstick 2,3" which I think you have correctly argued is
suboptimal. 4 can get stuck never reclaiming even as things get worse,
even if we might succeed (we've never failed..)

So I think the best (short term) solution is:
"detect failure modes 2 and 3 and unpause on release"

I believe your patches already enact "detect failure modes 2 and 3" and
we just disagree on the unpausing mechanism.

> > I think the simplest pure "fix" is to change the current "ready = false"
> > setting from unconditional on every run of periodic reclaim to only when
> > a sweep actually queues a block group for reclaim. I have compiled but
> > not yet tested the code I included in this mail :) We can do that more
> > carefully once we agree how we want to move forward.
> > 
> > If you still want to re-design things on top of a fix like this one, I
> > am totally open to that.
> > 
> > Thanks again for all your work on this, and happy new year,
> > Boris
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 6babbe333741..aad402485763 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -2095,12 +2095,13 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
> >  	return unalloc < data_chunk_size;
> >  }
> > 
> > -static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> > +static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> >  {
> >  	struct btrfs_block_group *bg;
> >  	int thresh_pct;
> >  	bool try_again = true; > >  	bool urgent;
> > +	bool ret = false;
> > 
> >  	spin_lock(&space_info->lock);
> >  	urgent = is_reclaim_urgent(space_info);
> > @@ -2122,8 +2123,10 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> >  		}
> >  		bg->reclaim_mark++;
> >  		spin_unlock(&bg->lock);
> > -		if (reclaim)
> > +		if (reclaim) {
> >  			btrfs_mark_bg_to_reclaim(bg);
> > +			ret = true;
> > +		}
> >  		btrfs_put_block_group(bg);
> >  	}
> > 
> > @@ -2140,6 +2143,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> >  	}
> > 
> >  	up_read(&space_info->groups_sem);
> > +	return ret;
> >  }
> 
> It's a good idea to return bool here! I hadn't thought of it.
> 
> >  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> > @@ -2149,7 +2153,8 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
> >  	lockdep_assert_held(&space_info->lock);
> >  	space_info->reclaimable_bytes += bytes;
> > 
> > -	if (space_info->reclaimable_bytes >= chunk_sz)
> > +	if (space_info->reclaimable_bytes > 0 &&
> > +	    space_info->reclaimable_bytes >= chunk_sz)
> >  		btrfs_set_periodic_reclaim_ready(space_info, true);
> >  }
> > 
> > @@ -2176,7 +2181,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
> > 
> >  	spin_lock(&space_info->lock);
> >  	ret = space_info->periodic_reclaim_ready;
> > -	btrfs_set_periodic_reclaim_ready(space_info, false);
> >  	spin_unlock(&space_info->lock);
> > 
> >  	return ret;
> > @@ -2190,8 +2194,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
> >  	list_for_each_entry(space_info, &fs_info->space_info, list) {
> >  		if (!btrfs_should_periodic_reclaim(space_info))
> >  			continue;
> > -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
> > -			do_reclaim_sweep(space_info, raid);
> > +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> > +			if (do_reclaim_sweep(space_info, raid))
> > +				btrfs_set_periodic_reclaim_ready(space_info, false);
> > +		}
> 
> Even if we have blockgroups to reclaim in this turn, we still mark some
> bg->reclaim_mark and expect the next periodic reclaim, which will not run, might
> reclaim them.

Why won't it run? We only pause if we truly called
btrfs_mark_bg_to_reclaim() (the word mark is unfortunately overloaded
here... that function really queues the bg for a reclaim attempt)

> 
> >  	}
> >  }
> 
> So I'm afraid this patch will introduce obvious regression on periodic reclaim.
> Add the "changed threshold" condition can alleviate this when dynamic reclaim is
> also enabled but will not work for fixed threshold. So I failed to come up with
> a simple fix patch with no obvious regression :(
> 

Can you share a description of any workloads you've been testing
against? I think that would also help frame the discussion to avoid me
talking too much :D

The regression I can foresee here is that the successful passes will
pause for too long (until the next chunk_sz of freeing)

We can also relax that condition to something more like an extent size
(1M or BTRFS_MAX_EXTENT_SIZE perhaps) to make it a little gentler of a pause.

We can also unpause on "urgent". I think that would likely be
sufficient. I'll do some actual experiments.. :)

Thanks,
Boris

> >> CC: Boris Burkov <boris@bur.io>
> >> Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
> >> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> >> ---
> >>  fs/btrfs/block-group.c | 15 +++++++-------
> >>  fs/btrfs/space-info.c  | 44 +++++++++++++++++++-----------------------
> >>  fs/btrfs/space-info.h  | 28 ++++++++++++++++++---------
> >>  3 files changed, 46 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index e417aba4c4c7..94a4068cd42a 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >>  	while (!list_empty(&fs_info->reclaim_bgs)) {
> >>  		u64 used;
> >>  		u64 reserved;
> >> +		u64 old_total;
> >>  		int ret = 0;
> >>  
> >>  		bg = list_first_entry(&fs_info->reclaim_bgs,
> >> @@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >>  		}
> >>  
> >>  		spin_unlock(&bg->lock);
> >> +		old_total = space_info->total_bytes;
> >>  		spin_unlock(&space_info->lock);
> >>  
> >>  		/*
> >> @@ -1988,14 +1990,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >>  			reserved = 0;
> >>  			spin_lock(&space_info->lock);
> >>  			space_info->reclaim_errors++;
> >> -			if (READ_ONCE(space_info->periodic_reclaim))
> >> -				space_info->periodic_reclaim_ready = false;
> >>  			spin_unlock(&space_info->lock);
> >>  		}
> >>  		spin_lock(&space_info->lock);
> >>  		space_info->reclaim_count++;
> >>  		space_info->reclaim_bytes += used;
> >>  		space_info->reclaim_bytes += reserved;
> >> +		if (space_info->total_bytes < old_total)
> >> +			btrfs_resume_periodic_reclaim(space_info);
> > 
> > Why is this here? We've just completed a reclaim, which I would expect
> > to be neutral to the space_info->total_bytes (just moving them around).
> > So if (any) unrelated freeing happens to happen while we are reclaiming,
> > we resume? Doesn't seem wrong, but also seems a little specific and
> > random. I am probably missing some aspect of your new design.
> > 
> > Put a different way, what is special about frees that happen *while* we
> > are reclaiming?
> 
> As explained, I want to use this to detect if the reclaim freed some unallocated
> space.
> 

Makes sense now.

> >>  		spin_unlock(&space_info->lock);
> >>  
> >>  next:
> >> @@ -3730,8 +3732,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> >>  		space_info->bytes_reserved -= num_bytes;
> >>  		space_info->bytes_used += num_bytes;
> >>  		space_info->disk_used += num_bytes * factor;
> >> -		if (READ_ONCE(space_info->periodic_reclaim))
> >> -			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
> >>  		spin_unlock(&cache->lock);
> >>  		spin_unlock(&space_info->lock);
> >>  	} else {
> >> @@ -3741,12 +3741,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> >>  		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
> >>  		space_info->bytes_used -= num_bytes;
> >>  		space_info->disk_used -= num_bytes * factor;
> >> -		if (READ_ONCE(space_info->periodic_reclaim))
> >> -			btrfs_space_info_update_reclaimable(space_info, num_bytes);
> >> -		else
> >> -			reclaim = should_reclaim_block_group(cache, num_bytes);
> >> +		reclaim = should_reclaim_block_group(cache, num_bytes);
> > 
> > I think this is a bug with periodic_reclaim == 1
> > 
> > In that case, if should_reclaim_block_group() returns true (could be a
> > fixed or dynamic threshold), we will put that block group directly on
> > the reclaim list, which is a complete contradiction of the point of
> > periodic_reclaim.
> 
> I guess you mean just resume periodic reclaim is enough and put it on reclaim
> list is not necessary. I agree.
> 

+1

> >>  
> >>  		spin_unlock(&cache->lock);
> >> +		if (reclaim)
> >> +			btrfs_resume_periodic_reclaim(space_info);
> > 
> > This also makes me wonder about the idea behind your change. If you want
> > periodic reclaim to "pause" until a block group meets the condition and
> > then we "resume", that's not exactly in the spirit of checking at a
> > periodic cadence, rather than as block groups update.
> 
> Because IMO we need periodic reclaim to reclaim this blockgroup. So if it's
> paused, resume here so the next periodic reclaim will handle this blockgroup.
> 

As argued above, we want to resume when there is space in the "target"
block groups, not an exciting "source". Otherwise the failed stuck case
can keep hammering hopelessly.

> >>  		spin_unlock(&space_info->lock);
> >>  
> >>  		btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
> >> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> >> index 7b7b7255f7d8..de8bde1081be 100644
> >> --- a/fs/btrfs/space-info.c
> >> +++ b/fs/btrfs/space-info.c
> >> @@ -2119,48 +2119,44 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> >>  	 * really need a block group, do take a fresh one.
> >>  	 */
> >>  	if (try_again && urgent) {
> >> -		try_again = false;
> >> +		urgent = false;
> >>  		goto again;
> >>  	}
> >>  
> >>  	up_read(&space_info->groups_sem);
> >> -}
> >> -
> >> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> >> -{
> >> -	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
> >> -
> >> -	lockdep_assert_held(&space_info->lock);
> >> -	space_info->reclaimable_bytes += bytes;
> >>  
> >> -	if (space_info->reclaimable_bytes >= chunk_sz)
> >> -		btrfs_set_periodic_reclaim_ready(space_info, true);
> >> -}
> >> -
> >> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
> >> -{
> >> -	lockdep_assert_held(&space_info->lock);
> >> -	if (!READ_ONCE(space_info->periodic_reclaim))
> >> -		return;
> >> -	if (ready != space_info->periodic_reclaim_ready) {
> >> -		space_info->periodic_reclaim_ready = ready;
> >> -		if (!ready)
> >> -			space_info->reclaimable_bytes = 0;
> >> +	/*
> >> +	 * Temporary pause periodic reclaim until reclaim make some progress.
> >> +	 * This can prevent periodic reclaim keep happening but make no progress.
> >> +	 */
> >> +	if (!try_again) {
> >> +		spin_lock(&space_info->lock);
> >> +		btrfs_pause_periodic_reclaim(space_info);
> >> +		spin_unlock(&space_info->lock);
> >>  	}
> >>  }
> >>  
> >>  static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
> >>  {
> >>  	bool ret;
> >> +	u64 chunk_sz;
> >> +	u64 unused;
> >>  
> >>  	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> >>  		return false;
> >>  	if (!READ_ONCE(space_info->periodic_reclaim))
> >>  		return false;
> >> +	if (!READ_ONCE(space_info->periodic_reclaim_paused))
> >> +		return true;
> > 
> > This condition doesn't feel like a "pause". If the "pause" is set to
> > false, then we proceed no matter what, otherwise we check conditions? It
> > should be something like:
> 
> > if (READ_ONCE(space_info->periodic_reclaim_force))
> >         return true;
> > 
> > as it is acting like a "force" not a "not paused".
> > 
> > Hope that makes sense, it's obviously a bit tied up in language semantics..
> 
> Because assumption 2. if it's not paused, periodic reclaim should happen
> periodically. I use "pause" here because I expect periodic reclaim happen
> periodically, and setting "pause" to true express that the periodic reclaim
> should not keep ticking.
> 
> >> +
> >> +	chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
> >>  
> >>  	spin_lock(&space_info->lock);
> >> -	ret = space_info->periodic_reclaim_ready;
> >> -	btrfs_set_periodic_reclaim_ready(space_info, false);
> >> +	unused = space_info->total_bytes - space_info->bytes_used;
> > 
> > Probably makes sense to use a zoned aware wrapper for this, just in
> > case we make this friendly with zones eventually.
> > 
> >> +	ret = (unused >= space_info->last_reclaim_unused + chunk_sz ||
> >> +	       btrfs_calc_reclaim_threshold(space_info) != space_info->last_reclaim_threshold);
> > 
> > This second condition is quite interesting to me, I hadn't thought of
> > it. I think it makes some sense to care again if the threshold changed,
> > but it is a new behavior, rather than a fix, per-se.
> > 
> > What made you want to add this?
> 
> To make dynamic periodic reclaim work but it will also help for fixed threshold
> when it's changed :)
> 
> >> +	if (ret)
> >> +		btrfs_resume_periodic_reclaim(space_info);
> >>  	spin_unlock(&space_info->lock);
> >>  
> >>  	return ret;
> >> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> >> index 0703f24b23f7..a49a4c7b0a68 100644
> >> --- a/fs/btrfs/space-info.h
> >> +++ b/fs/btrfs/space-info.h
> >> @@ -214,14 +214,11 @@ struct btrfs_space_info {
> >>  
> >>  	/*
> >>  	 * Periodic reclaim should be a no-op if a space_info hasn't
> >> -	 * freed any space since the last time we tried.
> >> +	 * freed any space since the last time we made no progress.
> >>  	 */
> >> -	bool periodic_reclaim_ready;
> >> -
> >> -	/*
> >> -	 * Net bytes freed or allocated since the last reclaim pass.
> >> -	 */
> >> -	s64 reclaimable_bytes;
> >> +	bool periodic_reclaim_paused;
> >> +	int last_reclaim_threshold;
> >> +	u64 last_reclaim_unused;
> >>  };
> >>  
> >>  static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
> >> @@ -301,9 +298,22 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
> >>  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
> >>  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
> >>  
> >> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
> >> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
> >>  int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
> >> +static inline void btrfs_resume_periodic_reclaim(struct btrfs_space_info *space_info)
> >> +{
> >> +	lockdep_assert_held(&space_info->lock);
> >> +	if (space_info->periodic_reclaim_paused)
> >> +		space_info->periodic_reclaim_paused = false;
> >> +}
> >> +static inline void btrfs_pause_periodic_reclaim(struct btrfs_space_info *space_info)
> >> +{
> >> +	lockdep_assert_held(&space_info->lock);
> >> +	if (!space_info->periodic_reclaim_paused) {
> >> +		space_info->periodic_reclaim_paused = true;
> >> +		space_info->last_reclaim_threshold = btrfs_calc_reclaim_threshold(space_info);
> >> +		space_info->last_reclaim_unused = space_info->total_bytes - space_info->bytes_used;
> >> +	}
> >> +}
> >>  void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
> >>  void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
> >>  
> >> -- 
> >> 2.51.2
> >>
> 
> Thanks,
> Sun Yangkai
> 

