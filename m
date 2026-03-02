Return-Path: <linux-btrfs+bounces-22161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPh9FD8Jpmm9JAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22161-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 23:03:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2341E4A08
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C8D0303C3B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259C1A6811;
	Mon,  2 Mar 2026 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YZjekUsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="leyAbggr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0171A6810
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488728; cv=none; b=Uu5FIDJ0atQYAQKIre2EezSjPWwL0kibiExydx8+5YNpvh9r1lzPMIqruhZWqnpUz6UeXg3NlYK2QLsgvqp8oafRnTsBj3KszuTtAiUUvZ7BHRyDHeWbYMU00ExmIVllJ1ad/xyZ8UkuBzZfME0oWso7ZzJTsRch478aE5CASes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488728; c=relaxed/simple;
	bh=eQSK4nZuvJLOG2WZoWZomVGuZONUdhNz0NS3j0CaJxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvxho67cPU4vh6K0mS1rOL/2kiQyJZNXqolRzKVd9rlqqcJTyPuKKKs4Qu84jaqBZljbGdlKrfcVbCk+/XalQJOGjmq5NF7U5DrNwqZ4S1jHzFpbeIS1nq38A4Y25h1WXc4TFC00tyPB9I7SUC2Ur59h8yJUoNV0LfYn8bKvBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YZjekUsn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=leyAbggr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A7FB7A0185;
	Mon,  2 Mar 2026 16:58:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 16:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772488725;
	 x=1772575125; bh=e7ulLku0e92sVuYGoXFA6KKVEqCWe9j6ljk+IWo0J1s=; b=
	YZjekUsnkd8uc1cDRSZe5NkBEXKXXDuiLYtDoBtFIchb3ygj2HUk+ma2qb/5QeHV
	DZE8j8RBLl6dY4h16m5OaYk36uBqVnV+4XxfDi9KCcpfXGg9UtoKz8t6YfuCKCIC
	TIuy37RZcPWKZsbadtuXbh26PTRDBVCFdn6oeSA8mCxoXFYvk4ujkTuEiNf8O3lI
	ECyiBu1cp+1qKNl9Yf0JeXpp0kzlJraLsWJFsIIviUh39hMYGWpDE4cVhqlna/hc
	N+xkpSrvUMOQDNqkfrmizQrfA6eD/hKGJd4CIZsALGM6QIqyDZMuhlPeYarXZSyg
	09QBlyiXGq/IxEwCnxn5Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772488725; x=
	1772575125; bh=e7ulLku0e92sVuYGoXFA6KKVEqCWe9j6ljk+IWo0J1s=; b=l
	eyAbggr6A548iz+RhURrVy9D8D9csgqMLK3xPCeDTCq1DfZVGI7y2ITgAkT4TwIA
	W5JwykZ/69UfFQ/3b3YwXqOgNHpAbVStxBbLEY8hIIK2mUMIek5NPil4FgrsiVp4
	GNYeT1Bq9WglMeXKiAf8UsudcvXoTBo44SwaYc2U2ey3U5abguLqZUOaLXmDVFRB
	8+faW1I1akyzgLHXDSoaHBtDLC6fNXKFGFKjofqyzfysCblX79cq02Ov6YjTpFuK
	drNzRfigfq6aYghIwrnd/ptW+lJIzfbNVQVmiy9FnqYo0UBadyrPo3V36RgK8LmY
	9/NLpH2HKW6BbA0bysByQ==
X-ME-Sender: <xms:FQimaSmqTMFWxZOPBAOTLrbZecOURA7aRfPmFhEK8v7P8T_U7t3NAA>
    <xme:FQimaf3o5HLCWdrRE081_bv6dl9tMdHsEf3pOhuzn0LAZMNmM4oHb-tvFGI0SBJND
    eUwN1WKjuhYAtOPX49v9aMlScdQTfTvcWFEFbjt35tzy5ZtxE9UXb0>
X-ME-Received: <xmr:FQimaeR3T_g4Mzk-DwoO7NTckr6tWkLiRzWYPTGQgV4UBcbBDLJmQ3vK8x_cfC2gXQxv22jCYjfK6aaqXu4FOY_LkNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrlhgvgidrlhihrghkrghsseiirggurghrrgdrtghomhdprhgtphhtthhopehlih
    hnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FQimaRstl4UKu0-dW7__wWd6J_Qm-UbmqggQCk1bLKkWG3pdohYi-Q>
    <xmx:FQimaTb0jpyORlTy4jqwTrpxnC6peuJQ_3J-GF-M_HAUsfIcFZXisg>
    <xmx:FQimaWtqpqvfARe07v9NHoZKTPWG4n9X4ZzmyDIqFHIjqwVn6hUCCA>
    <xmx:FQimaVEksFl4ezzjE6mNCmdMlob_4ASomFSaxVRw_X-26CC0M7sENA>
    <xmx:FQimacsBkgQFDpgEnoLhrIlPNSZWvh94XqXzpb0ie2484Ei2l9eNZuT3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:58:45 -0500 (EST)
Date: Mon, 2 Mar 2026 13:59:30 -0800
From: Boris Burkov <boris@bur.io>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH-RFC] btrfs: for unclustered allocation don't consider
 ffe_ctl->empty_cluster
Message-ID: <20260302215930.GB1633109@zen.localdomain>
References: <20260226113419.28687-1-alex.lyakas@zadara.com>
 <20260226173746.GA2968189@zen.localdomain>
 <20260226182915.GA2992537@zen.localdomain>
 <CAOcd+r31fvMHskN93LNjbXrhpL0hF1kZd6rkVuhcEAgXHtcW-A@mail.gmail.com>
 <20260302194359.GA1173790@zen.localdomain>
 <20260302214918.GA1633109@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302214918.GA1633109@zen.localdomain>
X-Rspamd-Queue-Id: CC2341E4A08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22161-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bur.io:dkim,bur.io:email,zen.localdomain:mid,zadara.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 01:49:18PM -0800, Boris Burkov wrote:
> On Mon, Mar 02, 2026 at 11:43:59AM -0800, Boris Burkov wrote:
> > On Sun, Mar 01, 2026 at 12:14:09PM +0200, Alex Lyakas wrote:
> > > Hi Boris,
> > > 
> > > On Thu, Feb 26, 2026 at 8:28 PM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > On Thu, Feb 26, 2026 at 09:37:46AM -0800, Boris Burkov wrote:
> > > > > On Thu, Feb 26, 2026 at 01:34:19PM +0200, Alex Lyakas wrote:
> > > > > > I encountered an issue when performing unclustered allocation for metadata:
> > > > > >
> > > > > > free_space_ctl->free_space = 2MB
> > > > > > ffe_ctl->num_bytes = 4096
> > > > > > ffe_ctl->empty_cluster = 2MB
> > > > > > ffe_ctl->empty_size = 0
> > > > > >
> > > > > > So early check for free_space_ctl->free_space skips the block group, even though
> > > > > > it has enough space to do the allocation.
> > > > > > I think when doing unclustered allocation we should not look at ffe_ctl->empty_cluster.
> > > > >
> > > > > I see what you are saying, and a the level of this situation and this
> > > > > line of code, I think you are right.
> > > > >
> > > > > But as-is, this change does not contain enough reasoning about the
> > > > > semantics of the allocation algorithm to realistically be anything
> > > > > but exchanging one bug for two new ones.
> > > > >
> > > 
> > > Thank you for your review and your comments below.
> > > 
> > > However, I am not sure what is it that you are actually requesting.
> > > Do you expect me to describe the whole mechanics of find_free_extent()
> > > and how its state is tracked through ffe_ctl?
> > 
> > To be confident that this change does not introduce a different,
> > potentially more serious, bug, it is important to demonstrate why this
> > transformation is reasonable, safe, and fits the existing model. That
> > implies some level of explanation of the mechanisms of the existing
> > model.
> > 
> > > 
> > > > > What is empty_cluster modelling? Why is it included in this calculation?
> > > > > Why should it not be included? Where else is empty_cluster used and
> > > > > should it change under this new interpretation? Does any of this change
> > > > > if there is actually a cluster active for clustered allocations?
> > > I am not changing the meaning of any field of ffe_ctl, which tracks
> > > the state of every call to find_free_extent().
> > > 
> > > I found an issue where "empty_cluster" is used erroneously in my opinion.
> > > 
> > 
> > At this point, in my opinion, you have a useful insight and a good lead
> > for a fix, but have not done enough work to justify the change you want
> > to make.
> > 
> > > According to the code, "empty_cluster" describes the minimal amount of
> > > free space in the block group, which we are considering to allocate a
> > > cluster from. I am not changing the meaning of it.
> > > 
> > > My fix is suggesting that "empty_cluster" should not be used when
> > > looking at free space in a block group during unclustered allocation.
> > > Nothing else is changed. In the issue that I saw, this bug prevented
> > > us from allocating a metadata block from a block group, when the block
> > > group still had enough space to make a 4Kb allocation.
> > 
> > At a minimum level, I would like to see an analysis of why the
> > empty_cluster may have been included in the calculation and some
> > reasoning about why excluding it ought to be safe and not cause issues
> > in other situations. Aside from improving the behavior in the conditions
> > you observed.
> > 
> > i.e., a general demonstration of an understanding of how the change fits
> > into the code at a wider level than just changing the one thing you care
> > about right now.
> > 
> 
> I spent a few minutes looking into this out of curiousity.
> 
> So at a base level, clustered allocator is used by metadata and data in
> ssd_spread mode. So let's focus on metadata, since that was your case
> anyway.
> 
> This check was introduced by the commit
> 425d83156ca ("Btrfs: skip block groups without enough space for a cluster")

a5f6f719a5cd ("Btrfs: test free space only for unclustered allocation")

gives another good hint on the evolution and why the check is only done
in the unclustered case.

> 
> with the justification that for unclustered allocation attempts in
> clustered mode, the search fails because it searches for bytes +
> empty_size anyway, which I see borne out in btrfs_find_space_for_alloc()
> (u64 bytes_search = bytes + empty_size)
> 
> Later in the wider loop, we set empty_size to 0 as a final last resort.
> 
> So to me, this suggests the allocator is intentionally designed to go
> allocate a new metadata block group when there isn't enough room for a
> new cluster, but shouldn't return ENOSPC as a result of this preference.
> 
> How exactly did you notice this in the first place? I assume you saw it
> skipping a block group in practice then noticed this code? After the
> fix, did it actually use the block group? I am kind of surprised based
> on that code I found in btrfs_find_space_for_alloc(), if so. So that
> would probably need explaining.
> 
> I could well be wrong in some part of my analysis, I am just sharing
> some quick findings. Please feel free to investigate further and
> convince me otherwise. But this is the sort of analysis I was looking
> for to motivate and contextualize the change.
> 
> In addition, please include exactly the improvement in behavior from
> your change to make it as clear as possible. (e.g., before when running
> <script> it would allocate 6 metadata block_groups, now it only
> allocates 5.)
> 
> Thanks,
> Boris
> 
> > > 
> > > I tagged the patch as RFC, because I am unable to test it on the
> > > latest mainline kernel, and I tested it on a stable LTS kernel 6.6.
> > 
> > Why are you unable to test it on the latest mainline kernel? I can run
> > it through fstests for you, if that would be helpful.
> > 
> > > 
> > > Thanks,
> > > Alex.
> > 
> > Thanks,
> > Boris
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > >
> > > > > etc. etc.
> > > > >
> > > > > Thanks,
> > > > > Boris
> > > > >
> > > >
> > > > I missed the RFC tag in the patch, so I would like to apologize for my
> > > > negativity. In my experience with other bugs, the interplay between the
> > > > clustered algorithm and the unclustered algorithm is under-specified so
> > > > I think it is likely you have indeed found a bug.
> > > >
> > > > If you want to fix it, I would proceed along the lines I complained
> > > > about in my first response and try to define the relationships between
> > > > the variables in a consistent way that explains why we shouldn't count
> > > > that variable here.
> > > >
> > > > If you do go through with sharpening the definition of empty_cluster,
> > > > I would be happy to review that work and help get it in.
> > > >
> > > 
> > > 
> > > 
> > > > Thanks,
> > > > Boris
> > > >
> > > > > >
> > > > > > I tested this on stable kernel 6.6.
> > > > > >
> > > > > > Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
> > > > > > ---
> > > > > >  fs/btrfs/extent-tree.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > > > > index 03cf9f242c70..84b340a67882 100644
> > > > > > --- a/fs/btrfs/extent-tree.c
> > > > > > +++ b/fs/btrfs/extent-tree.c
> > > > > > @@ -3885,7 +3885,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
> > > > > >             free_space_ctl = bg->free_space_ctl;
> > > > > >             spin_lock(&free_space_ctl->tree_lock);
> > > > > >             if (free_space_ctl->free_space <
> > > > > > -               ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
> > > > > > +               ffe_ctl->num_bytes +
> > > > > >                 ffe_ctl->empty_size) {
> > > > > >                     ffe_ctl->total_free_space = max_t(u64,
> > > > > >                                     ffe_ctl->total_free_space,
> > > > > > --
> > > > > > 2.43.0
> > > > > >

