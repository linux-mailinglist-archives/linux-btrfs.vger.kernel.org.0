Return-Path: <linux-btrfs+bounces-6152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516E9243F9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 18:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7774B256D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D521BD517;
	Tue,  2 Jul 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MhcbGVTk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYTCP5F8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674F1BD50A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939162; cv=none; b=TA7+xaXHCmiG7YG6jkFE0bp7wJ5NcuObeEPUEFWgFaFGxVbGHSaBST0k7ZUiyl+WGmXMcv6eFk2xxbc0lZr5zEZArDHbyJGY8uJJIytH8ypHYZKUS82Kx7YRl67VRCG+jcoj5ALa8J7dWhodQKKGNXt9w6PH22gyxB9bmwZbJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939162; c=relaxed/simple;
	bh=WTKI+VuUO7ZI4wW48YfCHTz352DxbbEdDvmK5jMa7gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcC+jktAhoDYiNHgcK+2pPAT1rPlCZp5zBhAVtb3KX6AVJraFHQpjFggRHO0cV0uLEArk8BRCsIVwywrGQLq8xlOzUKwHFhA4iz9zCmpMKJ+3ydxLlnm1V9U09GPVkI5Vo4v2SzWK3jX7dvBLFIZ9tBmhmPPIegh4w+NbzrZN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MhcbGVTk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sYTCP5F8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 916CC138025A;
	Tue,  2 Jul 2024 12:52:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Jul 2024 12:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719939159; x=1720025559; bh=Wf0R6AXx0X
	q0Zv0W3EVYOeWXlz5ZsZ7UA8nrz4fDukU=; b=MhcbGVTk5bRXni3lXaAPzWEZVl
	e5P1FzaPfAe25jH21mrlWyZd0CIcHtim263/EBXTPcjCi3dDH7kX/qXOm+b0VgRC
	60b7aksJQ3ApUJD4+/5S25EKEeYs/NGFaucTsDHLd7LWKHJfB2sBVI8nrKt+NorG
	7t25JRF9J/Kuvft+okCrCRvUjccYCcrpM3O91Q1EKQeTFXNbmVFRxwyNe5BTcFJM
	IEy23wTO6z7hEwF+y0uVZ7BrYhSpCpdC75djMLULXTL6CntChdqqPNF/2AmdK1hn
	Cju9otJSEHIMl38Au2+2DOVMdI+XbQ8+Mq8ZWv2NxiODwxmqp+6+QHaOzMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719939159; x=1720025559; bh=Wf0R6AXx0Xq0Zv0W3EVYOeWXlz5Z
	sZ7UA8nrz4fDukU=; b=sYTCP5F8tVTLArVuR6DPnHmSm3Ga0iWeJ7t6Lbz6cl7A
	lPsC67fKr1WZObkC1VGP/RVY34z32VNeFWtODJaIhsjSigPAyczvBxMLPxgKiJQ8
	gZXC8FuH5B+T37Fx0X5ZlFR1qAm4lRLVmXIGEPe4kezSEPealQhZOfnvfnJOyr6O
	R3t7O30eqzhABAkMBgpdS/hN4+InohFWQPge0gVxl25jsokXifQkNhHRyN1eAAYD
	VlxUrRBI9Zv5r9+sPqOWbXvEpVquwnOGf0OuD4lBliq9zFKGJUI5NN3KiZCQxpHi
	OLel1C4uywSKfIst0NfIBclavnE8dwG47IO/KkZefw==
X-ME-Sender: <xms:VzCEZm7P41aJkGlKyus6oNEcjIxj263szFauRrZzgN7r6_qONFeoeQ>
    <xme:VzCEZv5BupBEprChxiY4YBaftOcyj08Hu7EJBGCVRKKcCP8fdsqnt3L9dFulzMAPo
    RGHalGlTZVQVmBX6-w>
X-ME-Received: <xmr:VzCEZlelIAj2Jg7PFJktKv0XCc7VJlmvRpp6xrWVsZ0LZN6Nm3Id_b3vHWNLXuEVfoXD1n1beHPkrsZgq-IvM1cVKFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:VzCEZjL8ie1la0VyypVn87M_VhPL_brfPqT3vY0idlF98-5wZX7AeQ>
    <xmx:VzCEZqIRsTKNd0oZODzHqBRfEnE2co_WqV_QtqrLl7r72rSK8DlOAQ>
    <xmx:VzCEZkyqeulRkqyt3jma6iolgVoFuFL8I118KKVzm4kci_jCGG6Z5Q>
    <xmx:VzCEZuJb6PYeZXKJ3borxMJIpEc76RNZTW4zY21PxFTnIYyNB1ihRA>
    <xmx:VzCEZm2NOf9uIk0AJBCubwc8aQ6dVNZtoU_kDuw_nob5_s01lnC6tcYp>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 12:52:38 -0400 (EDT)
Date: Tue, 2 Jul 2024 09:51:58 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] btrfs: fix __folio_put refcount in
 btrfs_do_encoded_write
Message-ID: <20240702165158.GA2502368@zen.localdomain>
References: <cover.1719930430.git.boris@bur.io>
 <9e23e32fb945c3e1c43f8c0f8ca20552c48d5b65.1719930430.git.boris@bur.io>
 <20240702161916.GI21023@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702161916.GI21023@twin.jikos.cz>

On Tue, Jul 02, 2024 at 06:19:16PM +0200, David Sterba wrote:
> On Tue, Jul 02, 2024 at 07:31:13AM -0700, Boris Burkov wrote:
> > The conversion to folios switched __free_page to __folio_put in the
> > error path in btrfs_do_encoded_write.
> > 
> > However, this gets the page refcounting wrong. If we do hit that error
> > path (I reproduced by modifying btrfs_do_encoded_write to pretend to
> > always fail in a way that jumps to out_folios and running the xfstest
> > btrfs/281), then we always hit the following BUG freeing the folio:
> > 
> > BUG: Bad page state in process btrfs  pfn:40ab0b
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0x40ab0b
> >  flags: 0x5ffff0000000000(node=0|zone=2|lastcpupid=0x1ffff)
> > raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
> > raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
> > page dumped because: nonzero _refcount
> > Call Trace:
> > <TASK>
> > dump_stack_lvl+0x3d/0xe0
> > bad_page+0xea/0xf0
> > free_unref_page+0x8e1/0x900
> > ? __mem_cgroup_uncharge+0x69/0x90
> > __folio_put+0xe6/0x190
> > btrfs_do_encoded_write+0x445/0x780
> > ? current_time+0x25/0xd0
> > btrfs_do_write_iter+0x2cc/0x4b0
> > btrfs_ioctl_encoded_write+0x2b6/0x340
> > 
> > It turns out __free_page dereferenced the page while __folio_put does
> > not. Switch __folio_put to folio_put which does dereference the folio
> > first.
> 
> By 'dereferenced' you mean to decrease the reference count? Because
> dereference is usually said about pointers, it's confusing in this
> context.

Yes, you're right. It is "removing a reference" but not the best use of
"de-reference" in that case :) "decrement the refcount" is certainly
much clearer.

