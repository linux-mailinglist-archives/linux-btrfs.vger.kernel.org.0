Return-Path: <linux-btrfs+bounces-8530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50798F90A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDDC1F22586
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53A1BFDFC;
	Thu,  3 Oct 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kihYL7xs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWlMEKS8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094D1AC429
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991605; cv=none; b=HGQX+zgpTTRxemNbhAZ1G7Nnb0JzmA0/NFySseQJAZAHH4TI+86pZxiGcLoSRZOzSNenqn/8VclgTuPAPosCL8lQ8LIqN2/ASuMBIvE3FPR/DWTJsLM7Qs+muhFKNG/TC+sDAORKzAc5xtZmnYx84N8KHcH3OYIwDuKII5YBbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991605; c=relaxed/simple;
	bh=7+ak70AVWVm2Mkjkln6XuHeROYQvjVMjvjDZIT9VFX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCQM/USBBn01QydSwYQhKQ6uvdIP4NXRFH8xZMOZ9dCuHfil+mzmPZ+vn67+8/apbj/mhrbuMyj4PtIx4lQlE77Th3OCkJw6XRu1MsHDfbqsEBxJrkWv8Qz6SUWwY5Ir2unLJBde6UTnMzOth4gPZ4gTiL85zc+k6DRsLqjeSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kihYL7xs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWlMEKS8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F7B41380272;
	Thu,  3 Oct 2024 17:40:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Oct 2024 17:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727991603; x=1728078003; bh=Q+50a1h6e8
	HEsV8m87ylt0RkYubrbgQsOeINstq6Xio=; b=kihYL7xsOWAx/QGVOfl8tkHItr
	V2Z0VxvXXC6RqlWbXkelBNf0Csva48wl79IDYeMfWnreOp8H0GSsvTr2TjAKtNC/
	Vn5cEgBKzkl7qC00zsMt5H3BM2Cvy3Cd8+IOxuElbXZix8uG6DWQMDlUrNtYn1Gh
	i8b/LZAzn7t4cbeJEL3uhnfQxwL9PSrJ/Hdml1vD+K/B8VzI0NXh5YNOuUjasPam
	tIaEMdvgrLcpo9AV+X0223tMlGDVAxH8gBkk71c5y2Lme+N91I9m1qG8jTjx/sNM
	pntRmTXR/m8ZusYMrMnXWB/e2A45zOXb0htnQHJXRXmMkx/riNuwu5oJdUpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727991603; x=1728078003; bh=Q+50a1h6e8HEsV8m87ylt0RkYubr
	bgQsOeINstq6Xio=; b=OWlMEKS8nEDnkFoEr4hWDtzTEYBSONPBEVNvYgEwSAc+
	G2RbKELSBpHq7TqSaCtQch8Ru31avYqCOEfrkZmV6axnRAlUqaS1RnXzfrtfkcxj
	7zGIxIwdq1xLoz1JoBsxhVG/S/McI2lajVkzigRByTd814HpWwQ2gtRscEuJyZLj
	peXrIcswhzMxR8aA/4vYv7a56aYbODLS40+BmlqB+jIxsPg7E1AkkBJLSuAw+YaQ
	1xoE09yIG/8mGY4ga0Pg+/QgKTZYz2oM91tDylRsgP5N1amEgZ8Ug2z7f6U7pxzh
	ivDYV9lnmN2SZ0ay8QR8KVj3e68N9PJQfXArfzmzMQ==
X-ME-Sender: <xms:Mw__Zpk4uiRlCZFZfPV1PBVBF9siVzUR16TxGX_ar5FMoDgW_sIleA>
    <xme:Mw__Zk2rJRUVwlUh9yju0Dj6wrlND3oGV6P7FP-qgYzXx27RZzhVub4UeKfp9fRuq
    VlELG-3qIoBIK8vSYg>
X-ME-Received: <xmr:Mw__Zvp1TYHfh5EfMUY5vSGYgAEA7_Tub86HesIfAiH52jLYaxNiwk-cq1vaL3ynqjozDPcYIAwkb03pGjIU3pmAruk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:Mw__ZplDVXlUVf26Km1y_Uv1ghz-DzhZ9A7bz4NyhwWrZueATc6aUg>
    <xmx:Mw__Zn0CWX87LfH3EhXNxVpInTPWxqF7UExkbhon6I1df8cVqgi4HA>
    <xmx:Mw__Zov5RGPEvDxzUSSb9ISqIrDeLmYEc3tFQ9i1U2ajKcqLZ8lQLQ>
    <xmx:Mw__ZrWzUkUgmm6Yu-TdIyoCoMSj0xKLZuTQAXbwLFdce-zeEGWhvQ>
    <xmx:Mw__ZozloO5tSL0Wr96p7CbqUi1Ge5N_UucPMgdEMyckLAlRlwHN9HPF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:40:02 -0400 (EDT)
Date: Thu, 3 Oct 2024 14:39:59 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/10] btrfs: backref cache cleanups
Message-ID: <20241003213959.GE435178@zen.localdomain>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>

On Thu, Oct 03, 2024 at 11:43:02AM -0400, Josef Bacik wrote:
> Hello,
> 
> This is the followup to the relocation fix that I sent out earlier.  This series
> cleans up a lot of the complicated things that exist in backref cache because we
> were keeping track of changes to the file system during relocation.  Now that we
> do not do this we can simplify a lot of the code and make it easier to
> understand.  I've tested this with the horror show of a relocation test I was
> using to trigger the original problem.  I'm running fstests now via the CI, but
> this seems solid.  Hopefully this makes the relocation code a bit easier to
> understand.  Thanks,
> 
> Josef

Sent a few minor comments inline, but all the patches look good to me.
The only ones I would say I didn't deeply understand were 6 and 7 for
the cowonly changes, in case you feel you need a closer look at those.

One high level request (also raised inline on one of them) is just to
add more high level documentation of the functions and general
algorithm design, while it's fresh. The doc covering the backref
cache data structure itself that we have in our dev doc repo is great,
but doesn't do enough to explain the actual relocation operations
carried out with the help of the backref cache.

With that said, thanks for following up (!!) and you can add

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Josef Bacik (10):
>   btrfs: convert BUG_ON in btrfs_reloc_cow_block to proper error
>     handling
>   btrfs: remove the changed list for backref cache
>   btrfs: add a comment for new_bytenr in bacref_cache_node
>   btrfs: cleanup select_reloc_root
>   btrfs: remove clone_backref_node
>   btrfs: don't build backref tree for cowonly blocks
>   btrfs: do not handle non-shareable roots in backref cache
>   btrfs: simplify btrfs_backref_release_cache
>   btrfs: remove the ->lowest and ->leaves members from backref cache
>   btrfs: remove detached list from btrfs_backref_cache
> 
>  fs/btrfs/backref.c    | 105 +++++-------
>  fs/btrfs/backref.h    |  16 +-
>  fs/btrfs/relocation.c | 362 +++++++++++++++++-------------------------
>  3 files changed, 192 insertions(+), 291 deletions(-)
> 
> -- 
> 2.43.0
> 

