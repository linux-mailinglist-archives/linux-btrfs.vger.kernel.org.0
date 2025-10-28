Return-Path: <linux-btrfs+bounces-18374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337DC1225F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C42425499
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F1335966;
	Tue, 28 Oct 2025 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="M1GkIIhN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKz0bG2E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BF1BC2A
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610419; cv=none; b=eNKBLFBSkFpNakOBMbDvBqlZoVeUXTVa7ypEx5oEJrmmtkGtyBa4jIL4VN84zsDDXGObk1W9OgghLwctSK9MhL7tuGsBqGZyxG68jq9mZmhH7lLsR3xKob1mT+xRXJy5ZcySxSAuLWtHHFWalz96cu2rqiQyhwJY03wyZxHwbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610419; c=relaxed/simple;
	bh=nSmcOWNy/qgaVyvxkwO4/pI8muWuxorLhIwYBu7zyLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1bl+doREk34GEWD79wXRg23RRTi7IYVPFz5L0k8skOhD4ksxcCs3VGlinmfkK9eHoig05PTmWV0tLlbowlBdsW9eeVmSTtYgKxao9cphpOGWk/vwgHCq7u/S2AjaPDEYpAF3CCv5PSN3xujPK38PsIkT8BNWoGl7lDu39p17RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=M1GkIIhN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKz0bG2E; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C737EC00AD;
	Mon, 27 Oct 2025 20:13:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 20:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761610415; x=1761696815; bh=GHaedRPAdy
	KSe2zx8NV6iE07CLs7ybenV/mks4TB33E=; b=M1GkIIhNMQIDw48AryqIpKnq4D
	Txt2wfq/ijewlkxG2rjuOljsiOrpTryzJC53Rk5JsG8lWDk4zIAUen6K1DfQUV7E
	4FAAs3R7sGsA1ApxRI4ZhrrxsP6IwfdoTNH5VcKkcvf4EETs8Q4Vye4+RViuYyLy
	wF3A1xyGzlwDU/YBgqi2z74Q7eISx1BJa4V9lWv54xg75irlJHbIHzGLy1zC/wQ0
	PbyGu/S0JxcIT451XG+J7TfxNVMEGKAO7PKRtacek1/4HCf3V35K47F84VvfSbX8
	BSqp05+ZAAJAccRbdztMlctis0PvM2aUB0nHyq/85DuR3BkbhKFPIz2UBWIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761610415; x=1761696815; bh=GHaedRPAdyKSe2zx8NV6iE07CLs7ybenV/m
	ks4TB33E=; b=hKz0bG2EMHTQi7w0SxqAyKImdYs9r012iDxMUsD0MY05DSWExPh
	b+BJq7lGHS4FTp5T+AXFE9hEjngFhOXt4Lkaks7KMTwqNoldu6woZyEN4go7mITR
	AI2zkHR5N+Fc6xkl38DmXc15bGpynBWCoZPfsb1/jsNdxx9i1GSs6XXIqG9SOnlM
	Ub1LB5TT2IdhHGXRJbbz+opijtT34IxAsZgAlt9LsNgNcbiVRNJtT16zH2nAMlXA
	VwtsRWgErdTbTJwbV3/nSjXDZLuI5U9fXyzKiWxcTqecw/9T8kWEpUCIYekiL//G
	J2w6IqwkBeFC4xXkh01fcluAHZQltT7eCUg==
X-ME-Sender: <xms:rwoAafSBTtA8aK_59GF7JmjdvPM3PrivROk-QQKsQH48-c6hgPs-wQ>
    <xme:rwoAaWwssndrI0NjGYsE6rDYyDNThtKU0_xunFNU-W2Tft7KzW4VZr6QIRJ1l97ep
    1rAHjpI8iUfELsCMOuqdd2G2pOEfIYUAXgWPExAc9QfPH_huvFwtg>
X-ME-Received: <xmr:rwoAaSfontqL3GsjNnbg_WeUWU3-e0kchEjp2c4_Y8-ZqhG7s3Yz8-tYOh-_fc6CZcVeIGEz3QT6lS_fbZNPjVMcpk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhoshhssghohihlrghnsehsthgrnhhfohhruggrlhhumhhnihdrohhrghdprhgtph
    htthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rwoAaaIrCth7WuR7fL-1xjf-GGxYYVMr7-y4gCcci733aC0zajFr2Q>
    <xmx:rwoAabGdpr5YAQdaQ0g5fWO-6Maudfd-L8zK6F4IWa-aiaiXx09aqw>
    <xmx:rwoAacoVYlmcSidV7EJPTe1vAmyoLcfY4qnYoemBsN78NVR1tZCvaQ>
    <xmx:rwoAacR1I0yLE6wzWpZl5LAecGJS1L7sI0Rb7hxG10Bw36CRObhgvw>
    <xmx:rwoAadVO3tAwjzj-jm9Hn0Sf7nX3YPqoVEn13GCKoxUqCs1F_mNXs-Qg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 20:13:34 -0400 (EDT)
Date: Mon, 27 Oct 2025 17:13:29 -0700
From: Boris Burkov <boris@bur.io>
To: Ross Boylan <rossboylan@stanfordalumni.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs fragmentation
Message-ID: <20251028001329.GA3148826@zen.localdomain>
References: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>

On Mon, Oct 27, 2025 at 03:40:59PM -0700, Ross Boylan wrote:
> When recording over-the-air television the results are typically very
> fragmented when saved to btrfs, e.g., several thousand segments for
> 6GB.
> This occurred even on a large, nearly empty, filesystem of 5.5TB.
> Automatic defragmentation doesn't seem to make much difference,
> although manual defragmentation does.

Our max extent size is 128MiB which gives a best case of 48 extents, I
believe. Is that what you get after you do the manual defrag? If there
is compression (I think you said there isn't, but doesn't hurt to check
with compsize on the file..) that maximum is 128KiB in which case we
would expect ~50k extents for a 6GiB file.

> 
> I first noticed the fragmentation when I started getting messages that
> the writes were taking a long time, although I have not seen those
> recently.
> 
> It seems this application (the one recording the TV) may not be a good
> fit for btrfs.  The developers recommend xfs, but it would be nice to
> have the
> more flexible volume management of btrfs.

Have you been able to try with xfs?

> 
> I'm curious if anyone here has any thoughts or advice on this.
> I'd appreciate cc on replies.
> 
> DETAILS
> New partition on Seagate Exos x18 (spinning disk).
> btrfs --version -> 5.10
> uname -a -> Linux barley 5.10.0-36-amd64 #1 SMP Debian 5.10.244-1
> (2025-09-29) x86_64 GNU/Linux
> under Debian 11/bullseye, (current stable release is 13.1, so a bit old)

This is indeed a pretty old kernel, so answers about the behavior or
expected behavior might be outdated. Reproducing on a newer kernel is
always helpful, though in this case I suspect it has more to do with the
writing/sync-ing pattern.

> The entire btrfs filesystem is based on a single partition: no RAID,
> no compression, no snapshots, no subvolumes.
> The recordings are done by mythtv 31.0, which I believe basically
> takes the video stream and dumps it to disk.  The developers say it
> writes "continuously".
> 
> I speculate that what is going on is that it is writing small chunks
> to disk and each chunk causes the entire underlying segment to be
> rewritten.

If you are able, some kind of trace of what is going on when you run the
program would be helpful. strace would be a good start, I think. I can
give you some useful bpftrace scripts to try too, but who knows if they
will work on your old kernel :)

The important things to get to the bottom of are:
- does mythtv try to fallocate the file ahead?
- does mythtv do random writes as opposed to sequentially appending?
  From glancing at the code I could find online, it looks like no..
- how often does mythtv sync/fsync
- is something else on your system forcing frequent writeback (memory
  pressure, vm knobs, etc..)

In theory it should be quite possible to get btrfs to pile up a decent
amount of delayed allocations for dirty pages and allocate them all at
once quite contiguously when doing the writeback. This assumes:
1. we get to build up some good delayed allocations
2. there are big contiguous chunks of free space (as you mentioned in
   your next paragraph, this is a concern, but you said it reproduces on
   a fresh system)

So unfortunately, the devil is in the details with issues like this one.

> However, I've noticed that even when I cp a complete file to btrfs it
> ends up pretty fragmented, albeit the target filesystem in that case
> was very full.

If you can reproduce with a simpler program than mythtv on your empty
fs on the same system, that could be interesting, too. Worth a shot.

Thanks,
Boris

> 
> Thanks.
> Ross Boylan

