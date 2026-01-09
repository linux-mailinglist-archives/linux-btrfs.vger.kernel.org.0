Return-Path: <linux-btrfs+bounces-20356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BDD0C746
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 23:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A49303BE39
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBFD345CA0;
	Fri,  9 Jan 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="F8ojmkNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbYqQkYE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9C21C9EA
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997640; cv=none; b=HNVQcn5nqKLl1O/mtYvNl9TM+GTOIjDYFqJYArJ3s681IUvEbD54R4klU8d/55A6FZ8iePXFierHL/2BJ8etONfEM+H3JB8O6a7SmJNUH7M1iRbFdTO3kyaa/JmTJ4F427UYJZeGis82vthrFibOaVqeJq531ZqSbPR4X2lwqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997640; c=relaxed/simple;
	bh=aZTuzoYs4nhjKFRwpJd1vhCTzm0aQcOmU6X4GirEq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdVRk4PzpDltnQlK94o4gK2wLrF8cTB9Gi/41WnXf9AqQYe5f4g+eZfPe5zFNkyrJPN7r1iGO1NhJpnwiJ66mRJl+k5URd01qMjgfS5cIdSN24345tpjO371kfJryd5TSO0vWF1ijcJFqRR89zBpLm5wuJO54FeYLM81qKfM238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=F8ojmkNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbYqQkYE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1283BEC0100;
	Fri,  9 Jan 2026 17:27:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 17:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767997638; x=1768084038; bh=2s7fPnwFGd
	ykS5ar5n1BtoTfDYEv3BGcgCgdK8Mt+3Y=; b=F8ojmkNJyo3bfquG4cz3DWYEPj
	xuXDxP+evtURlxIr2F+M2v1zHhMNOM9YVLPig52mY27DB5VReU6AZf+G8l2LGD7C
	wSk8RzREjkk3vt4SAq46UzpKW35Po9cxtsQTHiKjWmD3vphvQY2PuRyWgfKKd9je
	6oXIf7p0neXtlhdstcqGTlf72WkyIdDM4vSfopMhRHSen9tTVcSbnxwmDlSuu2KY
	5pu32VS1W+wVP5od9QM5sBuXQropZfGIv0JA+n1eJxntaQWkob0XuD2LPtV6QrmQ
	2ZNrjekGX+5+tipv2JdyHsdM7ghaw90+0YkfrCTvue7yytvpPOJohkQgjF8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767997638; x=1768084038; bh=2s7fPnwFGdykS5ar5n1BtoTfDYEv3BGcgCg
	dK8Mt+3Y=; b=hbYqQkYE6qNxRiyvEyKe+hrDJ9Jud/wylPIt1nJHNpiiijScQ5N
	INMxQ7GL1XVyVXixdSVvDyEvrga9p7MA8dyrRIxjrmVdhN3ccn0MN05qHVvaYskv
	fxLb7tl2Nq5QHDGMf2koMVuNvTlo1yeruTft8km2i3tWSyOGJ41/ydiIzpbYrg3a
	G/BR1q9rjzNWQgLtr0MeRHqw9GVgpq5c97wtpqCqRazk1DGAjkVEcJTmKS/VF7JJ
	bpakQc/YXXjQOfh1ipDF5YxT+okO5ee8RrSOWhcFsKW0qWKzwfziVNV2Hhy4ItEK
	X7yk3j92/Hs812Hz0tnf6EBXPrLoHyoCQOQ==
X-ME-Sender: <xms:xYBhabwYz1q_MN1Q1_b6J8hZHjQ5gXTByzpCh-vocqPiPMaPUPn_gg>
    <xme:xYBhaatniEFW03U3ge-8tBPesWGAyL71mpCncGYuHGLJNSs8Ie_1Gzu9F2L8lQBMQ
    Q-dzI3qdDLTRr4Yc2A-Q4lz7H_jzNnRRWkbSX5_H9SxY2RF1cDsTU1j>
X-ME-Received: <xmr:xYBhaSvOWYRrHnwfay1-moEhrrySJLgdRYZFJqatb6zljkA_2nwgCJzyEovyZ0X0WxRMwLu_6Ducu_Tqt8qK0nIOlnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopegushhtvghrsggrsehsuh
    hsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:xYBhafPt5Uu2fjJXvyJnq9UHTq9SSk8KmuTMU_p4l_6l177wu5oZvQ>
    <xmx:xYBhaQ0eFGU04cCusyzEayAryyR9VbvlXEql4iCGXAx5Z5K7OXI6cw>
    <xmx:xYBhabP6HSHZQSu8LOfsmLsRqfJpXMLydWEhQzOrf6pa6CCRlVggbg>
    <xmx:xYBhaQ2a1807kn1OqNGRqbehrSwCh3HpL5O-jvzKp03CJeqsA-yl_Q>
    <xmx:xoBhaY5Xe1onnm7hNeT1Af6cPukJZ91Wfr9GW4msEeJLfGwKILHKD0dF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 17:27:17 -0500 (EST)
Date: Fri, 9 Jan 2026 14:27:24 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Delayed ref root cleanups
Message-ID: <20260109222724.GB3129444@zen.localdomain>
References: <cover.1767979013.git.dsterba@suse.com>
 <20260109181627.GB3036615@zen.localdomain>
 <20260109210921.GT21071@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109210921.GT21071@twin.jikos.cz>

On Fri, Jan 09, 2026 at 10:09:21PM +0100, David Sterba wrote:
> On Fri, Jan 09, 2026 at 10:16:27AM -0800, Boris Burkov wrote:
> > On Fri, Jan 09, 2026 at 06:17:39PM +0100, David Sterba wrote:
> > > Embed delayed root into btrfs_fs_info.
> > 
> > The patches all look fine to me, but I think it would be nice to give
> > some justification for why it is desirable to make this change besides
> > "it's possible". If anything, it is a regression on the size of struct
> > btrfs_fs_info as you mention in the first patch.
> 
> A regression? That's an unusal way how to look at it and I did not cross
> my mind. The motivation is that the two objects have same lifetime and
> whe have spare bytes in the slab.
> 
> > If the answer is just that it's simpler and there is no need for a
> > separate allocation, then fair enough. But then why not directly embed
> > all the one-off structures pointed to by fs_info? Like all the global
> > roots, for example. Are they too large? What constitutes too large?
> > Later, when we slowly add stuff to fs_info till it is bigger than 4k,
> > should we undo this patch set? Or look for other, bigger structs to
> > unembed first?
> 
> Fair questions. If we embed everything the fs_info would be say 16K. The
> threshold I'm considering is 4K, which is 4K page on the most common
> architecture x86_64. ARM can be configured to have 4K or 64K on the most
> common setups, so I'm not making it worse by the 4K choice.
> 
> So, if the structure for embedding is small enough not to cross 4K and
> still leave some space then I consider it worth doing. In the case of
> increasing the fs_info by required and small new members (spinlocks,
> atomics, various stats etc) we can first look how to shring the size by
> reordering it. Currently I see there are 97 bytes in holes. Then we can
> look what is used optionally, eg. depends on a mount option and move it
> to a separate structure.
> 
> The delayed root is a core data structure so we will not have to
> separate it again and revert this patchset. What I'd start looking for
> for a separate data structure would be some kind of static
> almost-read-only information, like mount option bits or status flags
> etc.
> 
> Also I don't want people to worry about fs_info size when there's
> something new to implement. We have some space to use and I will notice
> if we cross the boundary as I do random checks of the patch effects
> every now and then. This applies to parameters and stack space
> consumption. You may say this is pointless like in the other patchset
> but even on machines with terabytes of memory a kernel thread is still
> limited to 16K of stack and layering subsystems can use substantial
> portions of it. My long term goal is to keep the level the same without
> hindering development.

Also, all quibbling aside, I don't want to hold you up on trivialities.

If you can think of a short, specific explanation for why this is
preferable, I would appreciate you adding it. But even if not, please
add:

Reviewed-by: Boris Burkov <boris@bur.io>

