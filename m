Return-Path: <linux-btrfs+bounces-7648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178A96307F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 20:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803B5B24BFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E711AB50E;
	Wed, 28 Aug 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ivcSJw2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNwwuOYI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C71A38CF
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871291; cv=none; b=HVvl9LZMCsnN0qMCSJrIIot7QZ1O7kdEqFZeUAjhCPBZNyFHsk3gEBTvy6W9iV8AgAe2SpPb4Y/2iTMbmZZSus9cndjwOpPvHGcCymRAOl0E9jt6gXnUdPfivoiTdLTJyYX3k6s7MC/eFe74eIi19DWWhiImkBYViFAsY+JNLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871291; c=relaxed/simple;
	bh=0fDwjk5jhbdyX/QmlWOXPytsT4KEqVjmd2WeGPZnlko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFrP8Y1+ovqjvmw5+xIJ/5tAeszW2cmcmuDrKilGiBQ2RjLbnAEQrYtie1YcxiPZ8a2Tm/7Rpr1j+CWDOitMoIXO6m7bpAYQAYrDTvwp6Q9c7oIg8d2XMKQg4w0WQHpXnMML+cGHUEXYWVGvwUAoIRpt8diAndo40TQU80RYLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ivcSJw2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNwwuOYI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 087CE11515B3;
	Wed, 28 Aug 2024 14:54:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 28 Aug 2024 14:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1724871288; x=1724957688; bh=QeloCU8iCY
	g7K3SAMGjlRML6mcB2TQIu0ncTiEYoB2U=; b=ivcSJw2sRD1Zu5z7EUTfn39jcq
	cakjH2J626ZQJFsVrnqoFybOSWNWPp4ra/umEZbizdVNBft/eGfmBwqSOjC14eXr
	vIC8OOxXqlNWUE1+Qzsd3QedIUIFkdSLPGR1dai5YtQ5Ap/zPJGfJho3tMWCfE+c
	hePnh2x/8b9yJ+yprpmaD3MPw2i+5TmmKokepksWDxtQGZC6cOfwNDla58yf/R18
	WJ6Y1spWCosb3B7Q8l/shytyzrvA4kmsf353EtE9fMQnBwW6rTThcmXYXf6t263f
	SnwDbFCVMU9LBI0MS9/BThnVrkHuHs1y9O0dX3Q4LER4wbP5igFUQSUa8VkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724871288; x=1724957688; bh=QeloCU8iCYg7K3SAMGjlRML6mcB2
	TQIu0ncTiEYoB2U=; b=lNwwuOYI9H8ROECVTeObNGfACaDwPODqG9jsJEtawpua
	2X2uW+5e2zipTvjH7UcKaKisEN1mYZFF5K2ZTutiGNl2mkM8RUsTupDNxCrMpTI8
	nBOcNHWRufaIhY0lM9GxidiwrnYanyshMfELzfOvzSkEbazqthXRFA0T/RbZIXvS
	boGQwGYuSpEfrvzX0JK9p7OuODFdc/3L5RfNn1EXlKpkRFUdEjpxY6bKsHT9Ebpk
	fr5cdMTflbMDncA2HHpNMF+vbhVFR3SwOfYA5e61F2kSWQyV/7AeNuQc7HeKnAZb
	5m+vmybw1P+gwnalgnrJXbtMBXxa8a78lYeiChjEGQ==
X-ME-Sender: <xms:d3LPZjTeUVLAKoJic5XY7ZW6ozsNiUHl_NpFF16Z7yQykoTLRFGJXA>
    <xme:d3LPZkxwZNIiFxDtxyzYBwDov7CPw2iQ5GFfbnWpMygR7fzdacC83l17XlQf7MuBT
    X_fo8JU0OGq_xRdtg8>
X-ME-Received: <xmr:d3LPZo1wGDcn5ypTjxi87_r6_0f3arEhfDrycQBQZEZlE0adLA0O-ZT5OksT2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddguddvkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:d3LPZjAGZre8xD4kWWd0F8FXeyYfFQ8n-yAQOyUjA7NMJC3dLoNumw>
    <xmx:d3LPZsiGg1DUl_3hDibzoHlj_fj1SGu_AQUm6NwhB2wrQ5mNkdcWpA>
    <xmx:d3LPZnqvXqSJgNkXS6HqTPBypeM5UGfdXjlspqp7-Sv82jlOVaGWGg>
    <xmx:d3LPZnjkDRFtOrM0dbChtPHcRkE1J2AC3TUn36elh6v_4MCYWi9C2Q>
    <xmx:d3LPZmagpdMGfYsztI8ZtcaEVISKcg1CAcAl-JR3B12LrjZCmxDo0Zw2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 14:54:47 -0400 (EDT)
Date: Wed, 28 Aug 2024 11:54:42 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Message-ID: <Zs9ycrywZ/yIboGO@devvm12410.ftw0.facebook.com>
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
 <20240827203058.GA2576577@perftesting>
 <20240828001601.GC25962@twin.jikos.cz>
 <Zs9ZuApvQCH4ITT9@devvm12410.ftw0.facebook.com>
 <20240828175419.GI25962@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828175419.GI25962@twin.jikos.cz>

On Wed, Aug 28, 2024 at 07:54:19PM +0200, David Sterba wrote:
> On Wed, Aug 28, 2024 at 10:09:12AM -0700, Boris Burkov wrote:
> > On Wed, Aug 28, 2024 at 02:16:01AM +0200, David Sterba wrote:
> > > On Tue, Aug 27, 2024 at 04:30:58PM -0400, Josef Bacik wrote:
> > > > On Tue, Aug 27, 2024 at 12:08:43PM -0700, Leo Martins wrote:
> > > > > Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
> > > > > be called using the __free attribute. Defined a macro
> > > > > BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
> > > > > very clear.
> > > > > ---
> > > > >  fs/btrfs/ctree.c | 2 +-
> > > > >  fs/btrfs/ctree.h | 4 ++++
> > > > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > > > > index 451203055bbfb..f0bdea206d672 100644
> > > > > --- a/fs/btrfs/ctree.c
> > > > > +++ b/fs/btrfs/ctree.c
> > > > > @@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
> > > > >  /* this also releases the path */
> > > > >  void btrfs_free_path(struct btrfs_path *p)
> > > > >  {
> > > > > -	if (!p)
> > > > > +	if (IS_ERR_OR_NULL(p))
> > > > >  		return;
> > > > >  	btrfs_release_path(p);
> > > > >  	kmem_cache_free(btrfs_path_cachep, p);
> > > > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > > > index 75fa563e4cacb..babc86af564a2 100644
> > > > > --- a/fs/btrfs/ctree.h
> > > > > +++ b/fs/btrfs/ctree.h
> > > > > @@ -6,6 +6,7 @@
> > > > >  #ifndef BTRFS_CTREE_H
> > > > >  #define BTRFS_CTREE_H
> > > > >  
> > > > > +#include "linux/cleanup.h"
> > > > >  #include <linux/pagemap.h>
> > > > >  #include <linux/spinlock.h>
> > > > >  #include <linux/rbtree.h>
> > > > > @@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
> > > > >  void btrfs_release_path(struct btrfs_path *p);
> > > > >  struct btrfs_path *btrfs_alloc_path(void);
> > > > >  void btrfs_free_path(struct btrfs_path *p);
> > > > > +DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))
> > > > 
> > > > Remember to run "git commit -s" so you get your signed-off-by automatically
> > > > added.
> > > > 
> > > > You don't need the extra IS_ERR_OR_NULL bit if the free has it, so you can keep
> > > > the change above and just have btrfs_free_path(_T) here.  Thanks,
> > > 
> > > The pattern I'd suggest is to keep the special NULL checks in the
> > > functions so it's obvious that it's done, the macro wrapping the cleanup
> > > functil will be a simple call to the freeing function.
> > 
> > This pattern came from the cleanup.h documentation:
> > https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L11
> 
> [...] @free should typically include a NULL test before calling a function
> 
> Typically yes, but we don't need to do it twice.
> 

I believe we do if we want to get the desired compiler behavior in the
release case. Whether or not the resource-freeing function we call
checks NULL is not relevant to the point of checking it here in the
macro.

> > As far as I can tell, it will only be relevant if we end up using the
> > 'return_ptr' functionality in the cleanup library, which seems
> > relatively unlikely for btrfs_path.
> 
> So return_ptr undoes __free, in that case we shouldn't use it at all,
> the macros obscure what the code does, this is IMHO taking it too far.

This may well be taking it too far, but it is a common and valid
pattern of RAII: auto freeing the half-initialized parts of structure
automatically on the error exit paths in the initialization, while
releasing the local cleanup responsibility on success.

Look at their alloc_obj example again:
https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L31
and the explanation that acknowledges kfree handles NULL:
https://github.com/torvalds/linux/blob/master/include/linux/cleanup.h#L43

Suppose we were initializing some object that owned a path (and cleaned
it up itself on death), then initializing that object we would create a
__free owned path (to cleanup on every error path), but then once we were
sure we were done, we would release the auto free and let the owning object
take over before returning it to the caller. Freeing the path in this case
would be a bug, as the owning object would have it freed under it.

That's almost certainly nonsense for btrfs_path and will never happen,
but it isn't in general, so if we do add a __free, it makes sense to me
to do it by the book. If we really want to avoid this double check, then
we should add a comment saying that btrfs_path will never be released,
so it doesn't make sense to support that pattern.

