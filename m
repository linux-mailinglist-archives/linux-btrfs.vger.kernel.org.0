Return-Path: <linux-btrfs+bounces-13426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E01A9CD4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFED7173616
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7528A1CF;
	Fri, 25 Apr 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="BXAa8PJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXUjbcJ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98430218ADE
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595525; cv=none; b=JxPox1+D1kCDvu6zKRsp47l/e4prda3xCx5iw7xICikBQL2LjESqJxZ1qS/9wvuMIYa855coyhyPGdnGro7rmY3TxZ7a7fhWVMt6804KX8YF/CmUVYaVJB2pt7DsqPD/AJZvYEnZm0GTcjxYsDZL9Fml2ORNk2TwkIYnYRsAdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595525; c=relaxed/simple;
	bh=XJg7YMxqtpfXOja/XUEjN+zlKG99TeafXZqkDlDnjaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5fEEeFLTyxCjulVnKmWu0hgATP+cE98AUI4SP5RJx45Z3syw4P9aies7DgOGGzHvSo5m8aMlNYp/ZWDktj60KonZpHGTo+uCvyfi4J1HKOreIHTmbuQPiEesQlKfsLfu7MvMSsjmq1YaCIcVhtEy3vrSpL7D7lLapI+1jLE8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=BXAa8PJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sXUjbcJ1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86AA01140142;
	Fri, 25 Apr 2025 11:38:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 25 Apr 2025 11:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1745595521;
	 x=1745681921; bh=L8ZoWE8eP3+CGKsINaX5EaftFovHdqkRovHORRkjqsA=; b=
	BXAa8PJ9GEVpyN+ZWVBITA9okLBII0jNv/jBni8R4Ql7raEPU2W2r+CsPBo2UKMK
	8HZLak6m50Di/oD1eBS9ixBk2Gfc45n6zBhfNykVdhShW08aK8etrc2P9gIeZV55
	hgB7Mdfa3G8QXn2LoEy8gnQ3g2p7s5lhsSxI3S1RSnMo+KT/YwU+QH+CW7G9D5ck
	PojSkA8EMoXIDwbZ0loB2x9TI9ZK2kjGWmmnSSe58ACCfwjoLyR/2AxOtNkCPuwQ
	ksegbINQlJ02spXZPlHEBhmM0MqjtDfhqG7QuX49PYqDvYH2XcynBjvgJIS4E0JA
	O75vb5+vNeDbINEHS/vYng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745595521; x=
	1745681921; bh=L8ZoWE8eP3+CGKsINaX5EaftFovHdqkRovHORRkjqsA=; b=s
	XUjbcJ1u+pTc/y0WQ9L74FjI7qJrY6nYbSnbuVFwWsKvRD309C4Yq5oQtqQZ1hxe
	G5jb27Ep+m34ESL3cEiaTd1S1JgNMwcFFPd0kMqr+Tk9/Q//EWKzRE9cYsUaYWIQ
	yxsbRJh4mjiFfB7kJQKMxXpGqOrGzSmF5tBJ8NarJ6RVDAILGmg8dAbYcIONwg4C
	OYjxFhSJst1NPZDuBdmypiU35yLaP0+Ro5LkQ7SeOWQKFtccIhCjXkdHwNE8s26x
	hazvbcRJxbqexGlRUyHvuSX27rnW7Y+8KvvD9xMAkNxhGptSpB43gSjV0Wmau9dO
	eZhU0ImtavejxYqNpgQDg==
X-ME-Sender: <xms:gKwLaNk_GxH1zcBxMeatxggFuw3dHE-KEIlUvrIelZjfCH-MdhplUw>
    <xme:gKwLaI1B-RWGoNnoIlUdGdhwTFdOV1jc1caCkojxfSvkxJyGMKCNOtfGGr8Yc_fHc
    37V8IHI-tj_XFUgm2w>
X-ME-Received: <xmr:gKwLaDrvYfczoJa5G_65TzvlImnpVGhaFOTkdZYtFy3w9F2o4j9socp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgiipdhrtg
    hpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrh
    hnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:gawLaNlj_GslBJ2AoAVO-tHZY2MwI3UQGYLGi0WyRq-k-JnLF_-5nA>
    <xmx:gawLaL09ezL6-lMBrjXjigxAEt8zXGXbXdg9dAuObbd3TyXaGKNAUQ>
    <xmx:gawLaMuzE4nssmBAMdviWwjW4nA9I19WwBgHGCKuKY76RACTJnEH_w>
    <xmx:gawLaPWArUyjltanaXl4cu0gGUFJ5C1Tf4pOOIJ22P1HFfNJuxMS3w>
    <xmx:gawLaDSrK-vIHoGK3HSRmACjImFsMM5AO5JQn7yMFYi5-BHcJOAsG73G>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 11:38:40 -0400 (EDT)
Date: Fri, 25 Apr 2025 08:39:43 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
Message-ID: <20250425153943.GA1567505@zen.localdomain>
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
 <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
 <20250425115813.GE31681@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425115813.GE31681@suse.cz>

On Fri, Apr 25, 2025 at 01:58:13PM +0200, David Sterba wrote:
> On Fri, Apr 25, 2025 at 10:18:38AM +0100, Filipe Manana wrote:
> > On Thu, Apr 24, 2025 at 10:54 PM Boris Burkov <boris@bur.io> wrote:
> > >
> > > If btrfs_clone_extent_buffer() hits an error halfway through attaching
> > > the folios, it will not call folio_put() on its folios.
> > >
> > > Unify its error handling behavior with alloc_dummy_extent_buffer() under
> > > a new function 'cleanup_extent_buffer_folios()'
> > 
> > So this misses any indication that this fixes a bug introduced by:
> > 
> > "btrfs: fix broken drop_caches on extent buffer folios"
> 
> Thanks for noticing, this was not obvious.
> 
> > With a subject and description like this, it's almost sure this patch
> > will be automatically picked for stable backports, and if it gets
> > backported it will break things unless that other patch is backported
> > too.

Oops.
I was trying to *avoid* it getting backported by ommitting the Fixes:
tag. I should have just squashed them together as you guys say. I was
worried it might be confusing with Daniel also making related changes,
but it should have been fine anyway.

Speaking of which, I believe his patch
"btrfs: put all allocated extent buffer folios in failure case"
also fixes a leak from my first patch, for folios that are past the
attached counter in the fail case, so that needs the Fixes: tag too.

> > 
> > Also, since the bug was introduced by the other patch and it's not yet
> > in Linus' tree, it would be better to update that patch with this
> > one's content.
> > That's normally what we do - I know both patches are already in
> > github's for-next (I didn't even get a chance to review this one since
> > it all happened during my evening), and it's ok to rebase and squash
> > patches.

Copy

> 
> Agreed, as long as the a buggy patch is in for-next there shuld be no
> need for a fixup unless the branch is frozen for merge window.
> 
> Also non-trivial patches should not be pushed to for-next too quickly,
> exactly to give people chance to have a look. For trivial, clearly
> correct or non-code updates I would not care much if it's applied
> without much delay.

Apologies. How long should I leave a fix on the list without pushing it?
I did get a non-trivial review (as in he didn't just blindly stamp it)
from Qu.

Shall I leave it up for ~24 hours or until review from one of you two in
the future? Or since Filipe noticed the bug in the first place, wait for
his review in this particular case? For me, getting things off my plate
makes it less likely I will get pulled away from finishing them, which
is why I wanted to push it while I was focused on it and felt done. If
that's inappropriate, that's totally fine by me, just saying.

Sorry for making this a headache with the buggy initial fix and churny
followups.

