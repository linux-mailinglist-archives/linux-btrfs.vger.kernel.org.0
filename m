Return-Path: <linux-btrfs+bounces-3302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BAB87C224
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850491F21E3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2985745F4;
	Thu, 14 Mar 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dTVkSajI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ad9O/1M9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32241A38D0
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437665; cv=none; b=RXKLPYoAA14wtK4eP+h4+Y4nEqXBg6OYCE7npD0eooqF32x8y3SoNGBVopl1b1Dp8VR9WvQ9NpwH/Ku9cz9KjhjybXVR4ZdHVuKWVqfVpUqD4UFk25RECcA0/t5GlsmyFxWKndvRh60005ALklkzIzlHKo5rero60KWPQWEcJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437665; c=relaxed/simple;
	bh=xrhOXzFNgHIyNuDGb8gKtm7TbQYjcl8dWt1U9jOUoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xre4h87H62YoCKKkISr/csFmpWwKbb5Q/demF2JJdr98IXOJ+wF8KZUbvqkkMbokJsAlAiRgHrEIHj/MEywMdEa3052QMUi1BOjE+U+TeL1pz/BGGHqfhG0X57FiGE1DvZrYX0lPJv8mn+stgNOj6dWumSP9oFgSim5nYdxDOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dTVkSajI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ad9O/1M9; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 040295C0074;
	Thu, 14 Mar 2024 13:34:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 14 Mar 2024 13:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710437661; x=1710524061; bh=YAoyT5wJsl
	1KvNKNOM0709xDy1vtnCVQtlwgjoQ+UMY=; b=dTVkSajI1nnchasbbs3j9IeiN8
	TzSBho9tbbFYUM/P3nv2x/ed5Di2tgLParGxpzMh8q4oMSsSxz0d0o0PqdESKDAc
	BI4AIkWbWvT1Wf0rhQX9I+/5LBNupF8kJ6mVq5IbrlM71aIz3F0uapY2pK3+edUy
	eGHYz44TKW43NjZGYTZaDB5a6MCzC+SIJ/WJxH/6VYrOoDF2mB2uqtBPeRFLAU7M
	NUOw04GmFr3OMQrUwhd9DGGOWb9I/he8CrR16kWgjAwdDuy3/J5GtoTEl2GBB8Ym
	Mws2Z0aAZS3WuY686vj+Lw+p2qniFNfc2RqV/cQV7TTJ9OiieiXsq/lRTpzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710437661; x=1710524061; bh=YAoyT5wJsl1KvNKNOM0709xDy1vt
	nCVQtlwgjoQ+UMY=; b=ad9O/1M9h54A2jCndSjMllFStxc7qtIwU72RjoleIVab
	zr09glVXjE3xLbqqoY5gWd/cYxNUGYl0i5fF/7DTjrFU7pFFJkiDvt/ZBG6JpczC
	4aSa+fYEXvAFuY5BRWmux2xCsWvuf27wOPUyUYxWy3EbQe+m2j7m3CqOYW9jrFIx
	LDlfhO0ifb1AK/QTY+mV1YFVv2IlcwhF/dTthH8+TtxAy39+4oELT3ILAdKXt54f
	kwiVv2+UMUptiN53Wa038IhxFZgMg1Kn+DQb/TJhRJigCS48XhdKeU3w37iFxmb+
	9zv860cRglekDS+nvKt307ld67RknbTaPS7uYvZljA==
X-ME-Sender: <xms:HTXzZVwkXl96Mhr9VqbtoWeSYzAo_DegLWWS36nwolZIYmF5DZTZnQ>
    <xme:HTXzZVQ_hsRhxHoT-kJKzO_A94qGmsl5msWlL7anYSSLborUM1U7-li8ECpxtXyvw
    MooP7zENHNKQ-Jz-mA>
X-ME-Received: <xmr:HTXzZfXG3no5bx8vNrt627wJq14RH6aNU-1CBsVWdCpEaX-7ZA6kC74rZpj1un1cEumTX5VU8U6ilvtcNVo35rgN72M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:HTXzZXhAWpxmopX8UivM7d03_JmH3V2pIsVlp5xpP-sm_CI26BimzQ>
    <xmx:HTXzZXAHPWP0oQj2BYO3I067hmWykiygOTR7HtFckq0ePkAte_YJDA>
    <xmx:HTXzZQJn0ZE30HoPyS4H7bvvmRQknOF79SUkacphhgY7-7hutN8MWA>
    <xmx:HTXzZWA5Kl0h0J_gcqytdlizVLLnsuyrsDmA_GN0doR5AzGls-7p8A>
    <xmx:HTXzZc7iWyqGTNqPRzIZt8V2ogNIzhHsd0jxO9o0-fuChN1zjI56kw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 13:34:21 -0400 (EDT)
Date: Thu, 14 Mar 2024 10:35:12 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: scrub: refine the error messages
Message-ID: <20240314173512.GA3485866@zen.localdomain>
References: <cover.1710409033.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710409033.git.wqu@suse.com>

On Thu, Mar 14, 2024 at 08:20:13PM +1030, Qu Wenruo wrote:
> During some support sessions, I found older kernels are always report
> very unuseful scrub error messages like:
> 
>  BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2823, gen 0
>  BTRFS error (device dm-0): unable to fixup (regular) error at logical 1563504640 on dev /dev/mapper/sys-rootlv
>  BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2824, gen 0
>  BTRFS error (device dm-0): unable to fixup (regular) error at logical 1579016192 on dev /dev/mapper/sys-rootlv
> 
> There are two problems:
> - No proper details about the corruption
>   No metadata or data indication, nor the filename or the tree id.
>   Even the involved kernel (and newer kernels after the scrub rework)
>   has the ability to do backref walk and find out the file path or the
>   tree backref.
> 
>   My guess is, for data sometimes the corrupted sector is no longer
>   referred by any data extent.
> 
> - Too noisy and useless error message from
>   btrfs_dev_stat_inc_and_print()
>   I'd argue we should not output any error message just for
>   btrfs_dev_stat_inc_and_print().
> 
> After the series, the error message would look like this:
> 
>  BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872

Stoked on this series, thanks for doing it!

qq: would it be helpful to also include the actual/expected csum? I
think it's particularly helpful when one or the other is either zeros or
the checksum of the zero block.

> 
> This involves the following enhancement:
> 
> - Single line
>   And we ensure we output at least one line for the error we hit.
>   No more unrelated btrfs_dev_stat_inc_and_print() output.
> 
> - Proper fall backs
>   We have the following different fall back options
>   * Repaired
>     Just a line of something repaired for logical/physical address.
> 
>   * Detailed data info
>     Including the following elements (if possible), and if higher
>     priority ones can not be fetched, it would be skipped and try
>     lower priority items:
>     + file path (can have multiple ones)
>     + root/inode number and offset
>     + logical/physical address (always output)
> 
>   * Detaile metadata info
>     The priority list is:
>     + root ref/level
>     + logical/physical address (always output)
> 
>   For the worst case of data corruption, we would still have some like:
> 
>    BTRFS warning (device dm-2): checksum error at data, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
> 
>   And similar ones for metadata:
> 
>    BTRFS warning (device dm-2): checksum error at meta, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
> 
> The first patch is fixing a regression in the error message, which leads
> to bad logical/physical bytenr.
> The second one would reduce the log level for
> btrfs_dev_stat_inc_and_print().
> 
> Path 3~4 are cleanups to remove unnecessary parameters.
> 
> The remaining reworks the format and refine the error message frequency.
> 
> Qu Wenruo (7):
>   btrfs: scrub: fix incorrectly reported logical/physical address
>   btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
>   btrfs: scrub: remove unused is_super parameter from
>     scrub_print_common_warning()
>   btrfs: scrub: remove unnecessary dev/physical lookup for
>     scrub_stripe_report_errors()
>   btrfs: scrub: simplify the inode iteration output
>   btrfs: scrub: unify and shorten the error message
>   btrfs: scrub: fix the frequency of error messages
> 
>  fs/btrfs/scrub.c   | 185 ++++++++++++++++-----------------------------
>  fs/btrfs/volumes.c |   2 +-
>  2 files changed, 66 insertions(+), 121 deletions(-)
> 
> -- 
> 2.44.0
> 

