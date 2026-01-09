Return-Path: <linux-btrfs+bounces-20355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BFD0C58F
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 22:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA9D3031361
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 21:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C31833D6CF;
	Fri,  9 Jan 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LnCvOyZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InOeuoP1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831733D4F6
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994790; cv=none; b=hyd9E0rEKfHeu6Ltx4x9wTKdsI9Ttct55B/YAvZ08zC/8dVZDi5NWUUUZQaA9FENhjBYe4/nJyF+zS7qW0Bn18H4FcoNzqNuC5bmcxF8Dsr+cFMLlkn65u5AjvDD8Ob33/OUjqqnNWSwlhszJQRX+P8oHA5pBXditUsWrqWJ2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994790; c=relaxed/simple;
	bh=Pon9WtaO0R+MEUtqkmCAsSy6tVRLJ/vuxdVHECxE7dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3vasan4Ml0tHXJ8o4q18bR3vrnKmyiMADk2A5ULxd1+JDgvGW71ettAcwMqDHPK5EoTSFO93n/CVLMd96flqm80lCDuYrFFlgwVdSoYm1qTsG0ccnqcFdhSv59+ycu0HOjeL9GEkFj7007pIz1RY/yKfbl8Bz63J/xSXARiWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LnCvOyZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InOeuoP1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D92EEC014B;
	Fri,  9 Jan 2026 16:39:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 16:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767994787; x=1768081187; bh=EqnpetSawA
	meht/WSOizhexkCe2eeeor/usloMYp5dc=; b=LnCvOyZtzqP4M9RUxZyl8Nqhmz
	hzAhWOWHhh2/vUbBK/ZmJzMkYVwG3TT1YtyA+ZOZP/izmK5aaZIuhpVO9+pCXu7i
	PacT1Xf39W2h65i3NDCGoEfdZeWj3061v1wdoWcwEfnC4lkWNyUwWY4yUFNOG9fy
	8od5gXmqOMYvcSjRGPHBrr0DI5+7sOJGt0myDTlyz6T34YvrZK42YVh1MHAip+Qx
	jgeogNB1p5bDt6hWC4QfBRiEe316X3IywZ1oVUWPUiYxTRt8aEBw8xWSi4vHuzSs
	1KNMOQ0IdSXXRjc1gJMWlQJrPhPf51xm2VzR33pm1Z4xZS9kYWlomw05PTpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767994787; x=1768081187; bh=EqnpetSawAmeht/WSOizhexkCe2eeeor/us
	loMYp5dc=; b=InOeuoP1/idr8SF8o5eHq+g6U6+Fu/sv0XzO21qzciJ29YyRbYL
	H1egx2iUMQ37ZL5FDR0bRzz+jGUO27vEKb6iOvqpI05VhUzTmNfQ3Ebsc/xXok0Y
	8prA2AJdLlVmT1qA7Er8YmPNZ7T1aaNDZw1Vo1RJS5lBS1Bem4cJEwC3lPeGmLGx
	RQ0IR8UkyE9GBHAS8ZG4pA4fo6ZYlgiDf7ztLOfBqDbe3S1WvAooGO/G8NDCtZLp
	v8f5smcX8SP9nC7TZI58NEYrKhcVk6zg7g8vhLFlrOcClOI+gfPBpf7FWZseSzEp
	WDEguP4HfusSnWyNDdb5vsEOdmSibW+GD+Q==
X-ME-Sender: <xms:onVhaa_MatsiDjzVPQSgndh4p6WW6gCpNGye4CbiHXy_gLxLN4W3rQ>
    <xme:onVhaSJYhIXyBj2lWNMKQZWvuEoafGLi1wX1xxGq23B99qBCWoTU5Up78W2ydDQ0D
    i_alSpubSwE4kB_5wzc3lYvrj3EfWcNwgdLM8qeRNlze3g6N9QHN1I>
X-ME-Received: <xmr:onVhadYaXrC2nb0I8-4Z5F3JaERU4_yvlzpikDg-SnNOwsZJUtpXEl4hKaJu1SbkBDm-ZdSylkKL4oQ3GmgmUXRPtl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelleduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:onVhacI0QN4lFAfGXXeVdp_ig69nZbK7F55XV-NYQN1laTGFmIOL1Q>
    <xmx:onVhaTA-9pluQcY6d8mVg7oSoM3xWG0Aynr-Zo00Dc8gz-UNaC0XuA>
    <xmx:onVhaZobicgbTmC-RSzscFTp4nwLi2VEeTqpa8W4LLzczqmo0KY7WQ>
    <xmx:onVhaWgm-PwjWsWDpzwi6XK5c1fvp4lJ7Usc9RfFfGXZxqTDp-AQCA>
    <xmx:o3Vhac0nSf1Z_ejxjz13KOFS0SjHm07R4egdikN96hKZi5cKrLFYtb-T>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 16:39:46 -0500 (EST)
Date: Fri, 9 Jan 2026 13:39:53 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Delayed ref root cleanups
Message-ID: <20260109213953.GA3129444@zen.localdomain>
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

Sorry for the slightly hyperbolic language. My point was merely that it
is the main observable outcome. I agree with you that it's not an actual
meaningful regression in any way that we care about today.

All I'm saying is we consider it a minor win (all else being equal) to
shrink structs, so it's only fair to consider growing them a minor
regression.

It can be offset by other benefits and be an attractive choice anyway.

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

Agreed.

> 
> So, if the structure for embedding is small enough not to cross 4K and
> still leave some space then I consider it worth doing. In the case of

All I'm really asking is for some durable explanation why it is that you
consider it worth doing. Your email and patch messages just explained
why it was possible.

Even something like "if a non optional object is smaller than ~X, we
prefer not to use up slab" would be a helpful explanation.

Understanding how you think about these things is important to other
developers so we know what principles to try to follow in our own work.

Otherwise, we are just guessing at your taste preferences, and we can
monkey around and you can clean up after us :). I assume that is not the
most desirable.

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

I mean, it's not impossible to imagine a future where the lower hanging
fruit are exhausted and we are butting up on 4k.

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

I won't say pointless, since you're right, there is a point to reducing
stack size. Perhaps the better expression of how I feel about that is
"arbitrary". But individual improvements are always useful.

Thanks,
Boris

