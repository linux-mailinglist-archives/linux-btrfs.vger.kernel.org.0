Return-Path: <linux-btrfs+bounces-14539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D075AD0AAB
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 02:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F9316FB7D
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6617BA9;
	Sat,  7 Jun 2025 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hlWTG3xO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHhFsA4z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00748E55B
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Jun 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749256676; cv=none; b=WdafyhTwQ1NFDU8CwoZQQtcV+E0L02V5rFFamxZCz1/UaQz7n3ogyOZ6RsipSHaNV0aSONeXYLkkNPTKcvP3tSTIXiMuQTJlnXQCQUCl/6aQgZIU18k2d21jNa1pB3Yi+wnt7RvVv7ndcKH5IXJIDwX34uzf9l+4UQbpp3LVCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749256676; c=relaxed/simple;
	bh=ByBC9Wn2IlL4IYwiDsNkT1dN/k18PqKkYTXZq4TCFO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6hGDP/u41VkcAMXbKZqTgapAfwKBRxGgOCKLh6+LcnBhIpfaMuLrTHH7Unt3ptSfmplpYajRVT36jmLtSZ7p4F7gNKqAiC3gMJ7xU2zzHeUJNixMyqIHYf568ASI7LVamUaCZdEXEjOkFX/Xl6vU0G8EylcRsk1McgWwjxDfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hlWTG3xO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHhFsA4z; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E49871140102;
	Fri,  6 Jun 2025 20:37:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Jun 2025 20:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749256671; x=1749343071; bh=vjyRPsI97L
	AiUDE1ZPX6YGLT9pAAk2T8jMbo66los6U=; b=hlWTG3xOs0jeNk63Ge9cV0Rl05
	AyHGEusxPJXYfjJkkdEeDX+JayYyUCseI3NgwD0O7IoChIDbW0RJaUh6mF/qxpO0
	g8skhhH/2AiWNtBWFhIuot72sPswR/Xv1Dk0MqVlyBcgOz+wZaAMUDATxihY025H
	pxKloIEhF12yebv6YDOp/MhbMAlAOOYoQyPd9jIwb5bP5JRjTGXBCFR8Fx9LqYve
	V8qKeFVOZGQxYgg4U7rnXO4wgKp1d+lYGdx7zXXbeek22uKF308cM6QYO5VK+T4G
	Q76Y/iyYHgBLEx1kchsFtQ2qW79RUrmvzmWRjCVvVohi6BZ2FM8Z0ubyBMZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749256671; x=1749343071; bh=vjyRPsI97LAiUDE1ZPX6YGLT9pAAk2T8jMb
	o66los6U=; b=BHhFsA4z3RWCUi/UEIRXEpm4Ib1rEYmKknlJe/HZuqwpfK5V8Jo
	WyMoYzw08k432+DBTWUTsfWQUeNTIZq2abMFQNe9IX4AfnBM5cHeTxSy9Ydx5BS3
	uZc4KOK5XK7P4emWSa4fer+481KrZ9i8DZ1AlimANFuMLSWRQiOTPTwaffQwoUK8
	UNw7a+f1/fRt23rf9V0vUYWYseVDx02Q/VTK357uF0La+NTcjxgaNLc1h4HmdWmh
	8fIZyubERRcSivL8v2W6+bYnXStynWuJW1Pdl8Ip0FoEmLNrpQSr0GJMyQn8kEyd
	1ejPn3QNC41Le3J/MpozTXXtdQ4peJeqvEw==
X-ME-Sender: <xms:34lDaIaPvTlna6sS_9cHpnQ7bQ9GrjSLWgtEW2QQ4on0AbPLirZ8cA>
    <xme:34lDaDacJrDIR8F9BzmVfx-8_iFWdFQXxAcvC8MkkC3CZdbx6kL7Sv4gNw2ZYllqe
    toCrcHo12FQrrvCk6Y>
X-ME-Received: <xmr:34lDaC9f8X3eSiWh0qunF3pP3BrwQuIBfv8-6fXslUmgWpsXbvyDhzxvA3XN_zlW8r9Q5998f9VJdoiAN_OcpcI6-Zs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpefhveduveeuueegledvieeifeehffevffekieeiiefggffgleej
    hfevheetlefggeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhtuhhtohhrihgrlh
    gpohhnvggplhhinhgvrhhsrdhmugdptghomhhprhdqlhgvrghkrdgsthdpkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjihhmihhssehgmhigrdhnvghtpdhrtghpthhtohephhgthh
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfh
    hssehgmhigrdgtohhmpdhrtghpthhtoheprghnrghnugdrjhgrihhnsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:34lDaCotgUFGDENTeAJ-wNzc2EsnfncyTElMlBg6RQGmUh_un5X0vg>
    <xmx:34lDaDq7jz0WewISUMEZeXTUVm89IXvjqXIjP96MeSj3ITdpg8pIVg>
    <xmx:34lDaARwx74MOleGp_qLOpT93sKoqCYBhLUgaKhMdqqVNbNn72b5EQ>
    <xmx:34lDaDrb25dZArPwz3FWXV34OGSe9753zLKoz8p3xtubRUkeJIHtGA>
    <xmx:34lDaKjxPfmlLpButHhcTOUIzfnY5UI4DC83F0dUwJBF2f7WrqVx0tV->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 20:37:51 -0400 (EDT)
Date: Fri, 6 Jun 2025 17:37:43 -0700
From: Boris Burkov <boris@bur.io>
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Anand Jain <anand.jain@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Sequential read(8K) from compressed files are very slow
Message-ID: <20250607003743.GA4182169@zen.localdomain>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
 <20250604013611.GA485082@zen.localdomain>
 <aD_mE1n1fmQ09klP@infradead.org>
 <20250604180303.GA978719@zen.localdomain>
 <d934d1ea-4e3e-71ef-8b42-698ccd747799@gmx.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d934d1ea-4e3e-71ef-8b42-698ccd747799@gmx.net>

On Thu, Jun 05, 2025 at 07:09:07PM +0200, Dimitrios Apostolou wrote:
> Hi Boris, thank you for investigating! I've been chasing this for years and
> I was hitting a wall, the bottleneck was not obvious at all when looking
> from outside the kernel. I've started a few threads before but they were
> fruitless.

Happy to help, it's an interesting problem!

> 
> On Wed, 4 Jun 2025, Boris Burkov wrote:
> 
> > 
> > stats from an 8K run:
> > $ sudo bpftrace readahead.bt
> > Attaching 4 probes...
> > 
> > @add_ra_delay_ms: 19450
> > @add_ra_delay_ns: 19450937640
> > @add_ra_delay_s: 19
> > 
> > @ra_sz_freq[8]: 81920
> > @ra_sz_hist:
> > [8, 16)            81920 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > 
> > 
> > stats from a 128K run:
> > $ sudo bpftrace readahead.bt
> > Attaching 4 probes...
> > 
> > @add_ra_delay_ms: 15
> > @add_ra_delay_ns: 15333301
> > @add_ra_delay_s: 0
> > 
> > @ra_sz_freq[512]: 1
> > @ra_sz_freq[256]: 1
> > @ra_sz_freq[128]: 2
> > @ra_sz_freq[1024]: 2559
> > @ra_sz_hist:
> > [128, 256)             2 |                                                    |
> > [256, 512)             1 |                                                    |
> > [512, 1K)              1 |                                                    |
> > [1K, 2K)            2559 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > 
> > 
> > so we are spending 19 seconds (vs 0) in add_ra_bio_pages and calling
> > btrfs_readahead() 81920 times with 8 pages vs 2559 times with 1024
> > pages.
> 
> I specifically like the bpftrace utility you are using, it opens up new
> possibilities without custom kernel compiles, so I want to experiment. Could
> you please include the script you used for this histogram?
> 

Unfortunately, I modified the script a bunch since using it. So I don't
have that exact one lying around.

But the features necessary are basically:

fentry:YOUR_FUNC {
        $val = args->YOUR_ARG->YOUR_FIELD->ANOTHER_FIELD; // whatever is relevant
        @h = hist($val);
}

And a bpftrace and kernel built with enough debugging features like BTF
to support it.

The quickstart oneliners here:
https://github.com/bpftrace/bpftrace/blob/master/docs/tutorial_one_liners.md
and the full manual:
https://github.com/bpftrace/bpftrace/blob/master/man/adoc/bpftrace.adoc
I generally find to be quite useful in practice while hacking with my
scripts. You can also refer to a bunch of my examples here if you like,
but caveat emptor on quality :)
This one is a good recent example using fentry and args:
https://github.com/boryas/scripts/blob/main/bt/compr-leak.bt
but that directory has many others from over the years.

If you are reading older scripts, they will often use kprobe/kretprobe
isntead of fentry/fexit, FYI.

> > 
> > The total time difference is ~30s on my setup, so there are still ~10
> > seconds unaccounted for in my analysis here, though.
> 
> This is outstanding. I expect such improvement will give a *huge* boost to
> postgresql workloads on compressed filesystems. By huge I mean 5-10x for
> sequential table scans.

As long as it doesn't regress other workloads too much! Fingers crossed,
and working on further perf testing :)

> 
> I'm also wondering, in the past I was trying to see if it makes any
> difference to tweak the setting /sys/block/sdX/queue/read_ahead_kb but
> couldn't see any substantial change. Do you see it affecting your results,
> with your patch applied? Or is btrfs following different code paths and
> completely ignoring that?
> 

Sorry, haven't gotten to testing this yet.

> > 
> > > > I removed all the extent locking as an experiment, as it is not really
> > > > needed for safety in this single threaded test and did see an
> > > > improvement but not full parity between 8k and 128k for the compressed
> > > > file. I'll keep poking at the other sources of overhead in the builtin
> > > > readahead logic and in calling btrfs_readahead more looping inside it.
> 
> Since your findings indicate that the issue is probably lock contention, you
> might want to try /proc/lock_stat. It requires a kernel built with
> CONFIG_LOCK_STAT, which is what blocks me at the moment, but it might be
> easier for you if you already compile it for developing btrfs. Docs at:
> 
> https://docs.kernel.org/locking/lockstat.html

I think it might be more running the algorithms of the extent range locking
(basically an rb tree storing a set of bits on ranges) rather than contention
on the lock itself. And the "lock" is more like waiting for an event
from this data structure, so I don't think it would show up in lockstat out
of the box. But appreciate the tip!

Boris

> 
> 
> Thank you,
> Dimitris
> 

