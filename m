Return-Path: <linux-btrfs+bounces-12143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CDA59582
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 14:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6516516698A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F35228CB0;
	Mon, 10 Mar 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BkTT+UTi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A470808;
	Mon, 10 Mar 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611704; cv=none; b=Zb4NBPxLqwxreuyhm855uwhLN/8stpZaK1SwtEAOxsCyOXdij7vKShA7c+P/7LhlRuh/K9w7YAn5Dlre0ReqQauY8oc9KjWuqglnyEhnci8uFSKsu8lGMm9Y+sa92BsiPVEpDKuq2TEbHWoEBFLog3sWsFo3Kh200jzPDcY5k14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611704; c=relaxed/simple;
	bh=cx5jg6nX41FB/+wMNez+RBf6N+I2hCOHCQWIPO57sdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm1t4buBNiQCcZ3a9AcAomqyPcxbzTFj+L838pS1HPqltSyAgRp7uZX4Wt+ITOqZjp9okbLjsyFNUsN8Y+lqga8MbMVxg2mgIlDGugGMpsUQjAZa+k4SNoDduQRwd2vIndXFkD+Dw0nQ/IKDYMw5e7RT4sv/RTMRNPPn8tF8Lxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BkTT+UTi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P0Q5nncTlu8w0yyFGKHNI1d6KN3TELLcBWcGd04Z8eM=; b=BkTT+UTi0LpF5BtfBQLZeicRoV
	kGofT2EB8HhWThCg//q5VoeE8QUBonw3zlqq7k9FUcuPh77vaORPsAnmtwW/no/L3+19tXy8UCXYw
	TJdNFEYJUvzAtLNN5EiqNaHYIpTc33t61GUTm9NCCnslNYTlgm/xqNcpcLDQOieGhTIsFziIm6Sv4
	vRwTw9kQ7Y9t7ESfM9B+FLd9lC4DgQJ7PU1gdXNV3yvy0cI3SZFHErQjz6/+oCx2sBSUHUL8dt0bj
	rLKbX4958ZCVsYHnoKXly0Uaq/BMR454R/8HKlYrIzX1DxTDwd4EzWnhD5Wmdndz6SuXg2CMaqcWB
	f//LyNRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trclC-00000004i1J-2OzM;
	Mon, 10 Mar 2025 13:01:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 23CE03006C0; Mon, 10 Mar 2025 14:01:34 +0100 (CET)
Date: Mon, 10 Mar 2025 14:01:34 +0100
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
Message-ID: <20250310130134.GS31462@noisy.programming.kicks-ass.net>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
 <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
 <20250310090811.GQ16878@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310090811.GQ16878@noisy.programming.kicks-ass.net>

On Mon, Mar 10, 2025 at 10:08:11AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 26, 2023 at 10:37:56PM -0500, Chris Murphy wrote:
> > 
> > 
> > On Thu, Jan 26, 2023, at 7:20 PM, Waiman Long wrote:
> > > On 1/26/23 17:42, Mikhail Gavrilov wrote:
> > >>> I'm not sure whether these options are better than just increasing the
> > >>> number, maybe to unblock your ASAP, you can try make it 30 and make sure
> > >>> you have large enough memory to test.
> > >> About just to increase the LOCKDEP_CHAINS_BITS by 1. Where should this
> > >> be done? In vanilla kernel on kernel.org? In a specific distribution?
> > >> or the user must rebuild the kernel himself? Maybe increase
> > >> LOCKDEP_CHAINS_BITS by 1 is most reliable solution, but it difficult
> > >> to distribute to end users because the meaning of using packaged
> > >> distributions is lost (user should change LOCKDEP_CHAINS_BITS in
> > >> config and rebuild the kernel by yourself).
> > >
> > > Note that lockdep is typically only enabled in a debug kernel shipped by 
> > > a distro because of the high performance overhead. The non-debug kernel 
> > > doesn't have lockdep enabled. When LOCKDEP_CHAINS_BITS isn't big enough 
> > > when testing on the debug kernel, you can file a ticket to the distro 
> > > asking for an increase in CONFIG_LOCKDEP_CHAIN_BITS. Or you can build 
> > > your own debug kernel with a bigger CONFIG_LOCKDEP_CHAIN_BITS.
> > 
> > Fedora bumped CONFIG_LOCKDEP_CHAINS_BITS=17 to 18 just 6 months ago for debug kernels.
> > https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921
> > 
> > If 19 the recommended value I don't mind sending an MR for it. But if
> > the idea is we're going to be back here talking about bumping it to 20
> > in six months, I'd like to avoid that.
> 
> Please all, also look at the lockdep_chains output for these kernels
> that need bumping this number and check if there's a particularly
> 'silly' annotation.
> 
> Notably, things like giving each CPU their own lock class for a double
> lock yields O(n^2) chains, while using a single class with 1 subclass
> for the double nesting results in O(1) chains.
> 
> We've had some needlessly expensive annotations like this in the past,
> and now with dyhamic classes this is even easier.
> 
> So before bumping the number, check if there's something btrfs related
> that can be done better/different wrt annotations to reduce the number
> of lock chains.

So s_umount_key is having 40 instances; and I realize we have these per
filesystem lock types for a reason, but 40, how does my measly test box
end up with _40_ filesystems.

Now, even though cross-filesystem locking isn't common (rebind/overlay
etc?) this does mean most of the file system lock chains are times 40.

I also have 80 instances of kn->active, and 31 x->wait.



