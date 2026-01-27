Return-Path: <linux-btrfs+bounces-21122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHAsET8QeWmHuwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21122-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:21:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E02B099BE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590A73040471
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4636C590;
	Tue, 27 Jan 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VUwgJjFf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vCgkqy+P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C79322B7B
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541685; cv=none; b=MDn7rN/2lbbTdsWlafZoAW7j9lNSZQYI8AmxJQQgZ2KdJclsHS28yFWhUpITiabds/ljxliJe2koDBw+GUxemY89DzmRNFXwtzk+b24qNDWZShmtItGMO9exmL0SkTCTvP0javMIhxVqkUlZLD7GF0+xEpqSu2QXZXcwzhEGF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541685; c=relaxed/simple;
	bh=VsHNof/ny7k1MKMmFkvCjeUcjzDMcOWt6bc4ISKQ1jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExaW+CCB3NLnUOIgjsTqbPeg2JiDDyK0DWOnFBnH/avXzfufVrnBSRCCjZJcxmkbZHuS2yKS6KTTW8YNGDwDkA9MnxHyYR/5jDgQJk9JtIM6lZejnGdF8iGEijxoNkefZ+ih9wqtG6RHsTdh045WK1Jof6199WwHa8OEIhITqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VUwgJjFf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vCgkqy+P; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CCD01400037;
	Tue, 27 Jan 2026 14:21:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Jan 2026 14:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769541683;
	 x=1769628083; bh=xFI+529FVSrmigZ5IQkmsdmu7tRXzOyKq0vG0CZja7o=; b=
	VUwgJjFf0t85KToiR5RzvPy3HZ0Y8tBEmoulDebchzgBJAuTqpPyabCvEB6G7icM
	/UuCddPQgBnJlNY60+cUNi/9kSYTaCi5/0Q+5SDORqmgTXWkOGhJMiCU+BSgVmag
	WELv5AZih8mUxAJSlTEOMoELHtV/yMF+YAlld8wNZ+WFeAPZNgVNJcvDnqmtJv+n
	aN0kBgrIXfgFT1T4F9ECU+6c04Ei6yzAqr4XSV4Of9UlvcLAoM0MTMrz13rhoyiU
	EfhLp+Zi2u7IqjskYLnBIPTUCy28KQSUtoiBqMLllKm3+6UpMaoSldspOljgNd53
	SXiDRMkK9CsK/k+ewdGNeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769541683; x=
	1769628083; bh=xFI+529FVSrmigZ5IQkmsdmu7tRXzOyKq0vG0CZja7o=; b=v
	Cgkqy+PpjNJ0rI0WKQ67sj6m4YzMVHm4H3gVvRObbf+7TqAQSuWKRvunT0EaIQAN
	3DfvP5OFEzyG/8G9uS+T/PrSXJ2iJujCnbFLkvIKk4tSQGSuSLAuxLH56oEJch+Y
	G9xl5nLxCnALHjrNwGbOt4QIwdc3dspMW1jv+tq8QQcBY+z2KwXBG0uG3TuS+3Ia
	/B7tBV58nNUdZ8Udf4qXZLKozLz9O/3gc5MSHKZWTY5gMIEWlWSVyx5EaQAoZ8ZB
	n6HzP4ae6029v/A05XI1zzcDpNEomnXFPlSRZe/QhmU2rN1MyKSBywMG9RCguchs
	DKK+DtKUFGpAokKy1ysJw==
X-ME-Sender: <xms:MxB5aXfYs6U_gAwIxXgrgkOPR8qf4htwDGnVsXFDhyFvDv-KWGETZg>
    <xme:MxB5aTO0VbpWqMjvt8zv7gOmtA9txPGRcOqzDrM_v_h_Xk0Iz0gSY40lh4yTnXciz
    _Hjr4PMQSrdLrv_94-rUVWQ72TperYYDs-cOWs0v48uTh3w7JxU1jfv>
X-ME-Received: <xmr:MxB5aeKBsONgsAORMGXYePyp9RmZlJ_bNwGUz6l_lJzhxZzIxqCTBxaR7geBMn_khuYo8MiXiyZpWAfDO8fkI_yG0wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvd
    eltddvveegtdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhkieejudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:MxB5aUGiCmfdEdCXS71n83dYc7vRpELSFYi1NO_rO0AxqeYpSE60Zw>
    <xmx:MxB5aWT5_0hwGk2AmXwXbpN_g3-llQ8VV3MUucLap73j_mJHFz_NpQ>
    <xmx:MxB5aQHz1EwqwCRuK7oLIicPIanXv6rTonrWkZYPIrNSWyL0aJobjQ>
    <xmx:MxB5aS8Qf8dJ434vcKORfOcY7vXi_AJvZlUmmV7N2gZLuybt2seDJQ>
    <xmx:MxB5aeNCqR2PRlZ3UpAdXQaGn1IVlM9qXRDB6wKFeubT7wn1kz_5citO>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 14:21:23 -0500 (EST)
Date: Tue, 27 Jan 2026 11:20:59 -0800
From: Boris Burkov <boris@bur.io>
To: Sun Yangkai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize periodic_reclaim_ready to true
Message-ID: <20260127192059.GC3450664@zen.localdomain>
References: <20260126113104.9884-1-sunk67188@gmail.com>
 <20260126173450.GB1066493@zen.localdomain>
 <4f2af29b-6720-47fb-814c-e6f8b0327c30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f2af29b-6720-47fb-814c-e6f8b0327c30@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[bur.io];
	TAGGED_FROM(0.00)[bounces-21122-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,bur.io:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: E02B099BE9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:15:20PM +0800, Sun Yangkai wrote:
> 
> 
> 在 2026/1/27 01:34, Boris Burkov 写道:
> > On Mon, Jan 26, 2026 at 07:30:52PM +0800, Sun YangKai wrote:
> > > The periodic_reclaim_ready flag determines whether the background reclaim
> > > worker should process a specific space_info. Previously, this flag
> > > defaulted to false because space_info structures are zero-initialized.
> > >
> > > According to the original design, periodic reclaim should be active from
> > > the start and only disable itself (set to false) if it fails to find
> > > reclaimable block groups.
> > >
> > > Now that the reclaim condition has been fixed in a previous patch to
> > > properly handle reclaim_bytes, it is necessary to enable this by default.
> > > This ensures background reclaim logic kicks in as soon as the thresholds
> > > are met after mount.
> 
> Hi Boris. Glad to receive your reply within hours :)
> 
> > Is this problem practical on a test/real workload or theoretical? If we
> > never free net-1G, I don't know how much reclaim is gonna help anyway.
> 
> Yes, actually we don't know how much space is enough currently :(. It would be
> a lot better of we could find it out when failed to reclaim a blockgroup ...
> 
> I have a test case for periodic reclaim like this:
> 1. mount the fs with >10G unallocated
> 2. filling the disk to nearly full (< 10G unallocated)
> 3. free up some space(>10G unallocated) and umount, preparing for the next
> test
> 
> I expect the periodic reclaim kick in when the disk is nearly full (during 2)
> instead of after freeing up some space(during 3). This let me started to think
> about this patch.

If the filesystem has only ever allocated and never freed, then it
cannot possibly make progress at 2.

If you have also freed a gig in smaller extents than later allocations but
bigger extents than the ones in one of the block groups you are
relocating, then it could succeed even with net allocation greater than
-1GiB.

> 
> In real world workload, we may have a fs quite empty when mounted, and fill up
> to quite full and expect periodic reclaim will happen to get rid of running
> out of space for unallocated. But periodic reclaim will not work without this
> change.
> 
> And this patch is the simple and quick fix for that "edge case".
> 

Except that it runs into any number of trivial edge cases itself. Like
"never freeing" like I pointed out above, but also failing on the first
try (setting back to false) then later having net free less than 1GiB
but in a state that could make progress and not re-enabling.

Fundamentally the thing to work on is the enabling condition. Whether
it's on at mount or not is kind of irrelevant, IMO, because it is 
essentially the same as the state after a relocation fails.

e.g., with your change, this is still possible and essentially not that
different from starting at step 3 on a fresh mount.

T0: blank fs size 100G
T1: alloc 95G contiguous
T2: reclaim tries, fails; periodic_reclaim_ready = false
T3: concurrently free and allocate 10G while never seeing a net of -1G,
but making real, big holes that could result in a successful relocation
T4: reclaim is still disabled forever

> > If the "net 1G freed" condition is not the actual condition that we
> > want, maybe we should rethink that? We can enable it on 1G total freed,
> > regardless of allocation to give it a chance to run even if the net free
> > is 800M or something. I was worried about workloads that did actually
> > allocate and fill in the gaps.
> 
> I agree. It's not reliable and may trigger too often than what we expect.
> 
> > Or we can just use the total available space
> > as a proxy, like "if we do a free and the total free in the space_info
> > is >1G, enable periodic reclaim". The reclaim loops aren't gonna be
> > costly and we don't expect them to do anything when the fs isn't full
> > anyway.
> 
> Comparing current free space with a target free space instead of tracing a
> reclaim_bytes is a good idea. At least we don't need to maintain an extra
> counter any more. But the fixed 1G target might cause some problems since a
> reclaim might fail with a >1G free space. With the fixed 1G target, we might
> trying the useless work again and again. I suggest to set a target larger than
> the free space we have when setting periodic_reclaim_ready to false so we'll
> not trigger periodic reclaim if there's no "enough" free space freed.

The current periodic+dynamic reclaim is already essentially saying it is
targeting something like 2-10GiB unallocated. It simply goes away past
10G and gets quite aggressive as you get closer to 0. So more signals
based on a target free doesn't make that much sense to me, unless I am
misunderstanding your idea. Please feel free to explain in more detail
:)

Here's how I was thinking when I came up with the current condition:
I was concerned about a filesystem that is in a relatively steady state
and quite full, so in the <10G unallocated. If it is totally steady
state, then nothing can ever make progress. So we should say we aren't
ready until *something* changes. What could that something be? Some
ideas:
1. any space at all has been freed
2. >THRESH space has been freed (ignoring concurrent allocations)
3. >THRESH net space has been freed
4. the largest available hole in a bg has changed (that means the bg is
now "better" at receiving relocated extents)

So 1. will definitely catch every case where you could reclaim, but is
also susceptible to getting stuck failing a lot with trivial amounts
freed.

And 3. is maybe too "mean" and doesn't account for fragmentation.

I intuitively thought 2. was going to be too similar to 1., but maybe
it's a good middle ground. If there is a high enough rate of freeing
activity, since the last time we looked, then we should look again.

I think 4 is also interesting (perhaps in concert with 2 or 3) as it
more directly accounts for the critical factor of the current
fragmentation. But as written it is too similar to 1., small irrelevant
changes might change the largest hole even if there is still no hope
whatsoever.

> 
> How much the target should be larger than the current free space? Still 1G, or
> maybe we could find a better value, taking more factors into consideration?
> 
> And at mount time we cannot find out a proper target value so just set
> periodic_reclaim_ready to true. (BTW, this is why I use "paused" instead of
> "ready" in the previous fixup patch: to make the default value fits the default
> logic, but just set it to true as default seems enough :)
> 
> So even with this redesign , I think this patch is also necessary, or at least
> no harm.

Agreed that it's no harm.

> 
> Thanks,
> Sun YangKai
> 
> > Either way, though, I don't think this is harmful, so we can probably
> > put it in. Just curious what you think about the other ideas and why
> > you decided this was needed.
> >
> > Thanks,
> > Boris
> 

