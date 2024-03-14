Return-Path: <linux-btrfs+bounces-3291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EECA87C167
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701091C22006
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EAA73535;
	Thu, 14 Mar 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MUc6bz/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbHJqDYm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0071B56;
	Thu, 14 Mar 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434291; cv=none; b=UOy7kX6PKpQKgxL+Bl8d0+0fqNXNMR5OOL/zwooR6pPC10W9B86sYDA/twoIM3fZdWWnllJI0jJXtQGaKPZ0hOaiXHeARU6zu+MYc0faqI+O/yl9zR24xNHB6b8F4k0DQFHOpuzkp6rxtwmlZS9NRwaeQpWJeD5OaAtTxJykL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434291; c=relaxed/simple;
	bh=t35Pmu2JoOZZ7lGOLyMeHVQKyydwEAV/kBgMfv/T8tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvHNmVtrQqaMJkxETvyLhxXjidahcqsyEmgrvjHfkMg0/vPStjpJSVhyrKb4OrKfx9rEmjCclO6ea2EDftXir85MDJ2Lp4m5WX59T1y/nQhRWo8bh8s300EsCeemhS8ZA4RfC/y4K/7iK95n9iRFgdRJ4jXU0XKZ75/H6J2ZXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MUc6bz/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbHJqDYm; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1EA835C0074;
	Thu, 14 Mar 2024 12:38:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 14 Mar 2024 12:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710434288; x=1710520688; bh=TsRfcrl1Ou
	GyrvETv+2zcfu8CLdXT5OcxdKp77wCTxs=; b=MUc6bz/dYu3aDM6qUv/8G+bCj5
	ZO0x3VzrhLjsUfRSmpBoeCBa6huhpLGwGKkRkPnA2WBVemI5p8XD13YQVfdBkIWg
	iImRz2ZN09cdT3474o2qKhhB7OJZ0L1w4Hh7kT2hq7SlIG8/gXzF1R5oIH0hYhDd
	Gr/eRjWm5uWUSSUbFYg5W+Nhi6GJNPBidBsV+IAKLAXjiu/ft3pDMqW3CuZve3xQ
	WazyhDRzW6adAivfQ/77Idd1oYPdxSA5dNG4yMY/5WczyeGismiOL6FuwflCg4Fm
	jbQXbV2tIVtL/LgvPvzZEAZw76HO9wF/zZ898L8OHNe89N/0a7G6HU+wHLnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710434288; x=1710520688; bh=TsRfcrl1OuGyrvETv+2zcfu8CLdX
	T5OcxdKp77wCTxs=; b=QbHJqDYmKmKB8c4unTPcA2KG84d13+vCYicMOb1iAYoi
	ceSHeEmeEfqI/TR6Wr+Lf6ROEnqE9TNEjAouheJHUaWQ/KIeX1dNepeDQVi1EiU0
	1YGYjY8vwLZSnOy17Awh8XhpXS7P3nwf/eM1EJi0mWnOx/v2H0dqh+ihIj/CezZZ
	GmXZbzSgadtE6NqDa5oyxxKTi9Nhl5wgI0umfRHRUt8dMUPbIYTkinFKTRJQ2d7a
	IYqhKkm95A7HyGKZsIuCd8qpHR7IA2Cw8NtgKm1fUQd84ALfleTp1DyVp5gVQBOX
	FcYb2Qat22BZDpkQSeKP6VXq48mL2aVZ1Kgeccyw0w==
X-ME-Sender: <xms:7yfzZZwobcc3zjTkRS4mK3pSS9aS5ajYqxfj2Y8ZSvJsRe15GCRK6Q>
    <xme:7yfzZZSOvPvHaeLu-780CnW9WWLOUxa46oms-GABIQxeVCSy86YqScwvgWYC-LRvr
    nz0cI4lqDeLCmc3u80>
X-ME-Received: <xmr:7yfzZTUFMlfiq3xz6U29krW1dQrQEV90mYQF6mET8cw3cxY8cd-V4FNWspd6qjqAEXMNte7J8n-qjkCdqniDffwX8z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:7yfzZbhBuRh7BuzStiqcR71G4lZPqXtTVVDcIN3gFJijNUQUJGANtQ>
    <xmx:7yfzZbAP0FkQMwLoaMApH09wvZD7m98SrWGv4vslyRfN0BKEE6bjQg>
    <xmx:7yfzZUJq1cIudA17kI_D_LzySbe8E-r5Ip-YUXsdWLFh4IzSYLxewA>
    <xmx:7yfzZaAby1VwJgQgMiE0EPozKMUP_Y5rEqZTTO5OEB5LjA8-2bFgpQ>
    <xmx:8CfzZSMWtOlLXCSGqzVj3R-1oJ5-zFZ89FwAcqvm_RnU4HNK0OKvyQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 12:38:07 -0400 (EDT)
Date: Thu, 14 Mar 2024 09:38:58 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/277: specify protocol version 3 for verity send
Message-ID: <20240314163858.GA3483566@zen.localdomain>
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
 <20240314150122.GA20751@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314150122.GA20751@twin.jikos.cz>

On Thu, Mar 14, 2024 at 04:01:22PM +0100, David Sterba wrote:
> On Wed, Mar 13, 2024 at 04:46:29PM -0700, Boris Burkov wrote:
> > This test uses btrfs send with fs-verity which relies on protocol
> > version 3. The default in progs is version 2, so we need to explicitly
> > specify the protocol version. Note that the max protocol version in
> > progs is also currently broken (not properly gated by EXPERIMENTAL) so
> > that needs fixing as well.
> 
> What do you mean? Progs are ready for protocol 3 as its availability
> depends on kernel and if it's enabled then it's assumed that progs match
> the protocol specification.

I'm not sure exactly how it happened, but I currently also can't get
btrfs-progs to actually put proto=3 in the send ioctl. I believe that
the #ifdef CONFIG_BTRFS_DEBUG used to set the protocol version doesn't
pick up the config value in the kernel (should it?!)

I was able to fix it by switching to using EXPERIMENTAL as the flag but
haven't sent that yet.

