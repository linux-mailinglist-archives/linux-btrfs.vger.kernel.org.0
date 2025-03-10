Return-Path: <linux-btrfs+bounces-12132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF6A58F13
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 10:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66FA188EE35
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67CF2248AA;
	Mon, 10 Mar 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JlQ+KPv9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98794224898;
	Mon, 10 Mar 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597734; cv=none; b=Ez9BthnsJxWhklXZT7Kj0KZyRBi5fQWrIdWfhHAtcAgaZ8MZLxgprn/Agdgn+P+se45TulzziGT+YQ1U1pPkwGqNy/faetCxM2WHJEgp7VW1CVgnCuykAcMCepsd5e/n6pyE1rdBWbs/qzdVd2eHq9ZD9tMzZPo2HmHvNSr2PKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597734; c=relaxed/simple;
	bh=mXMYpSdxNuyQYTceRPm1q28M5l4U2u5jbpXDDH2mEy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgPF8iln7Vh1s+uCeyW8Zuc7OfOQmulUOku5QmAEY4pBoh/ppPMolRgGS1Ocdhz4tkaUBtg3IJC8cCm6vNmJYNE4EpwpqLQyiVkBbQwlU7Wtwu0XWEgYH7Hjdxv3A42RaxeSiPxH5bf6ZdPzctcgrmpDjHbLBOUvrRgZ//IadcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JlQ+KPv9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nGGBfXcW496O6Da1moftsrudvy0YYcf4pgpt3WGpC3U=; b=JlQ+KPv94Rkxr/w8pgcpv/iw9Z
	Sm7h8AAU0/0+nMxF5j+LR4qSYTSdqP6g7Saqaqax+2Q8Zey49O/EYbPfABaiiDcfBSFyxJglvVYhK
	/ZklYmDOhTiEJjvP057AnvK8le9EGdfph/6u5iajVIQ2JWxBz9kZOc1KH2ElHwKPRLab/Enveqhpp
	reg4t7fFY8VlHipHtj2oY4t9bIiQt0CorxsnJeSGDiQq8D90xPjyTxpDi/0EYXlFzhNDOJlG++uco
	AzlIR9vGpRmDaxV8xXv+cXVnWmDAvNJz7Stcee0Sfli45uBkA8ZMyi18pKlrPOf1c1ekmIYEJ1qFy
	jRNaZd4A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trZ7M-00000002op3-0gPC;
	Mon, 10 Mar 2025 09:08:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60030300599; Mon, 10 Mar 2025 10:08:11 +0100 (CET)
Date: Mon, 10 Mar 2025 10:08:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Murphy <lists@colorremedies.com>
Cc: Waiman Long <longman@redhat.com>,
	=?utf-8?B?0JzQuNGF0LDQuNC7INCT0LDQstGA0LjQu9C+0LI=?= <mikhail.v.gavrilov@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, David Sterba <dsterba@suse.cz>,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <20250310090811.GQ16878@noisy.programming.kicks-ass.net>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
 <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>

On Thu, Jan 26, 2023 at 10:37:56PM -0500, Chris Murphy wrote:
> 
> 
> On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
> > On 1/26/23 17:42, Mikhail Gavrilov wrote:
> >>> I'm not sure whether these options are better than just increasing the
> >>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
> >>> you have large enough memory to test.
> >> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
> >> be done? In vanilla kernel on kernel.org? In a specific distribution?
> >> or the user must rebuild the kernel himself? Maybe increase
> >> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
> >> to distribute to end users because the meaning of using packaged
> >> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
> >> config and rebuild the kernel by yourself).
> >
> > Note that lockdep is typically only enabled in a debug kernel shipped by 
> > a distro because of the high performance overhead. The non-debug kernel 
> > doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough 
> > when testing on the debug kernel, you can file a ticket to the distro 
> > asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build 
> > your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.
> 
> Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
> https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
> 
> If 19 the recommended value I don't mind sending an MR for it. But if
> the idea is we're going to be back here talking about bumping it to 20
> in six months, I'd like to avoid that.

Please all, also look at the lockdep_chains output for these kernels
that need bumping this number and check if there's a particularly
'silly' annotation.

Notably, things like giving each CPU their own lock class for a double
lock yields O(n^2) chains, while using a single class with 1 subclass
for the double nesting results in O(1) chains.

We've had some needlessly expensive annotations like this in the past,
and now with dyhamic classes this is even easier.

So before bumping the number, check if there's something btrfs related
that can be done better/different wrt annotations to reduce the number
of lock chains.

