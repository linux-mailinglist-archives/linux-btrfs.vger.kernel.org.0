Return-Path: <linux-btrfs+bounces-7667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D64964DE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 20:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7BC28370A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860B1B8E87;
	Thu, 29 Aug 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iQniuaT4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYchxXQe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772B148FF0
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956847; cv=none; b=sB2wuNhDVbBKMOe/Dqm+AhViunGPDuZQsfls5RgWBUf/ZH8s7e2fb+6bgHrzutC+uMORRI5gJpQpPyUn2Ju95W9Ssr+1GTnoBzi0h5TAZAF2cqghgUlFKLmkwONUGVcvc8Xhd8eWD2egsM5L6Gxmz3PZw233Q9tTRQ3SKb3oYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956847; c=relaxed/simple;
	bh=ogipQgAU0TJAh77JjhQYfao9QTlAGfPf/fMuLZFOZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPskfVNWpmA3OTbwGokjrDJEaNoUL11xOtvINWkd07qQ/Nn8CEKZBBqJ9yDCU5/T5ze6HbrQ0iXHBx5BqpKZWuLXCz26vj2kYcd1OLX2CDMK8D4h7ZKdPLR7wmH0NffGz5f5TQkiYa8m4ASAPQiTUUR2T4HjlRRYdQlGvQg5NOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iQniuaT4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uYchxXQe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5FBEB138FD34;
	Thu, 29 Aug 2024 14:40:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 14:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1724956843; x=1725043243; bh=nNKIEvhzZY
	2VY263cYScUG6vP8DemRPrEivmyZ+6JyI=; b=iQniuaT4u33bovccMbdMmrbmhd
	b5owdRKL9Nhv9Ly0eNELJOtIX4SDnqmVHUxBLaPNxY7r+mKCeEUOFPpeR01PLtFZ
	FqOLb51zleoPmTfMgQImBNLJHS5LhE5xDLJa7Q6L6TA7lUMG/0GiKXcbFukqkrB0
	xBu0DoXmY7OBKWjin6RvIQ0j82KSXyKyZXck8kPgFtA94lySqU+TEVFSzKC2yajy
	YA+2F/lM+CBJiw3cbyyG25wAdjQ1y1nNKTsLkhbNa/x2w9o+UNmQ19DkjNA2bJH3
	t+GVe7ypM/lrSy6k3H0mWwJKre+xSHCwBOykmW0ryquOFgIN9q4LUJoASxog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724956843; x=1725043243; bh=nNKIEvhzZY2VY263cYScUG6vP8De
	mRPrEivmyZ+6JyI=; b=uYchxXQe0kIH9VvQwd4XzjB9LGu+twNmJbotRWUzdlnW
	5r+4flk2cT+/4Du9foQyg7aahwIzDYwSCx69gQWE1ktWyf3qnnlnIwq9tZrYUlQR
	IMRGppT7HwDSpW62cbf6wClggiZQxumOIPdUc8zvM5N5ub82M10flTo8xe697Fzi
	QND8FAr29ZyH+IK2cA7H6VPca/ID5k64XVcilN1nyyCgCH17822rmavgYLlbJ0lp
	GY3mfokLKUrMpHYUGwAjZfrpcDwHaSQGV2b2U8dXvFwZesVcFLnvTpMkQRDh9h3P
	eTsgZoVp5q1hxHWtDERhQxP1Rso0Drc+knDP527EvQ==
X-ME-Sender: <xms:q8DQZkBSfSnKL2pGh2BrGlKyOYKLXUHR7vXDySZcSnJiQSLsTNQOFg>
    <xme:q8DQZmihN92EkvbwM20m-WKWKgBgfYuAF40P2m1HleSBIXChHoBRvNSMa4cwPH9jb
    HE4PyHcNC_vmvM0SFI>
X-ME-Received: <xmr:q8DQZnmB8x4kfALlDqHTM8uzhFt69-ay7QcChr6RhUYcRvQ0S6KZMSy0-fxzBh5IlNxwXccXwdZmNRUhvpzcJlMYDp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepleffgeevgeetueegledtueeluddtudekhefhudeuheegfeev
    ieehteevieejueetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhi
    ohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehjohhsvghfsehtohigihgtphgr
    nhgurgdrtghomhdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:q8DQZqxCcIKpSrJW5709iwP173qnF4IhRixjia32iNx-grKkaoDNXw>
    <xmx:q8DQZpSvhkAbOj3Eb0-iBJQ1YdLvLvOQGsjd5AvKR_GPe5JzJ_GBHg>
    <xmx:q8DQZlZWbjBAM9VjJ0YL_CzjipdwbnI81w8-EHJ2WS8Uq2YCOIq2uQ>
    <xmx:q8DQZiSYcV7dGyX2cnC99qWmTiLEzM1mocwqWL_dwN6WfpSYG7s0Fg>
    <xmx:q8DQZiL031wLI32owwJTUOxv5ZejmCFZRgDvi3KrO5gg_hLP7c4E7lNx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 14:40:42 -0400 (EDT)
Date: Thu, 29 Aug 2024 11:40:41 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <20240829184041.GA1560741@zen.localdomain>
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
 <20240828001601.GC25962@twin.jikos.cz>
 <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
 <20240828175419.GI25962@twin.jikos.cz>
 <Zs9ycrywZ/yIboGO@devvm12410.ftw0.facebook.com>
 <20240829173655.GN25962@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829173655.GN25962@suse.cz>

On Thu, Aug 29, 2024 at 07:36:56PM +0200, David Sterba wrote:
> On Wed, Aug 28, 2024 at 11:54:42AM -0700, Boris Burkov wrote:
> > > > This pattern came from the cleanup.h documentation:
> > > > https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L11
> > > 
> > > [...] @free should typically include a NULL test before calling a function
> > > 
> > > Typically yes, but we don't need to do it twice.
> > 
> > I believe we do if we want to get the desired compiler behavior in the
> > release case. Whether or not the resource-freeing function we call
> > checks NULL is not relevant to the point of checking it here in the
> > macro.
> 
> I'm trying to understand why we're discussing that, maybe I'm missing
> some aspect that makes it important to stick to the recommended use.
> I've been reading the macros and looking for potential use, from that
> POV no "if(NULL)" check is needed when it's done in the freeing
> function.

For the record, I I agree that there is no risk for ever doing something
bad to a btrfs_path, no matter what we do with this extra check in
DEFINE_FREE

> 
> There will be few cases that we will review when using the macros and
> then we can forget about the details and it will work.
> 
> > > > As far as I can tell, it will only be relevant if we end up using the
> > > > 'return_ptr' functionality in the cleanup library, which seems
> > > > relatively unlikely for btrfs_path.
> > > 
> > > So return_ptr undoes __free, in that case we shouldn't use it at all,
> > > the macros obscure what the code does, this is IMHO taking it too far.
> > 
> > This may well be taking it too far, but it is a common and valid
> > pattern of RAII: auto freeing the half-initialized parts of structure
> > automatically on the error exit paths in the initialization, while
> > releasing the local cleanup responsibility on success.
> > 
> > Look at their alloc_obj example again:
> > https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L31
> > and the explanation that acknowledges kfree handles NULL:
> > https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L43
> > 
> > Suppose we were initializing some object that owned a path (and cleaned
> > it up itself on death), then initializing that object we would create a
> > __free owned path (to cleanup on every error path), but then once we were
> > sure we were done, we would release the auto free and let the owning object
> > take over before returning it to the caller. Freeing the path in this case
> > would be a bug, as the owning object would have it freed under it.
> > 
> > That's almost certainly nonsense for btrfs_path and will never happen,
> > but it isn't in general,
> 
> You got me worried in the previous paragraph, I agree it will never
> happen so I'm less inclined to prepare for such cases.
> 

That is fair enough, and I have no problem with that judgement.

> > so if we do add a __free, it makes sense to me
> > to do it by the book. If we really want to avoid this double check, then
> > we should add a comment saying that btrfs_path will never be released,
> > so it doesn't make sense to support that pattern.
> 
> Sorry I don't understand this, can you please provide pseudo-code
> examples? Why wouldn't be btrfs_path released?

I think this is just me not having a good terminology for "we used
return_ptr or no_free_ptr". Perhaps "gave up ownership" or "gave up
responsibility" or "canceled free" as "released" is too similar to the
actual __free action :)

I don't have any pseudocode materially different from the example in
cleanup.h with "btrfs_path" substituted in.

All I'm trying to accomplish in this whole discussion is emphasize that
the extra IS_ERR_OR_NULL check is not about ensuring that btrfs_path is
valid, but is about following the best practice for supporting the code
reduction in the "gave up ownership" happy path. In fact, just "if (_T)"
would be sufficient in Leo's DEFINE_FREE, for that reason.

My taste preference here is to explicitly acknowledge that we plan to
never give up ownership of an auto-free btrfs_path, and thus document
that we are intentionally not including the extra NULL check. Since the
authors of the library bothered to explicitly call it out as a pattern
users should follow.

Thanks for entertaining this discussion, I enjoyed learning more about
cleanup.h.

Boris

