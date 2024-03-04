Return-Path: <linux-btrfs+bounces-3003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC4870CA6
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 22:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0672885ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886B78B4C;
	Mon,  4 Mar 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qcQUBcQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+4EPT6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2F47A6C
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587641; cv=none; b=THo/Dic14Lu2iqrEQUtOmJz5EN8nybPeE7DB+6aBrRLiD5stOn7OD/SRALID2b1zx5dsPndFFFGIX+EIk7Fg4QjlXFg8uEqM1qqjSOEJfOoj8FTm2GT2pexGqMhPwCXJEFpzNtKETxVvnrVvK9R/O55GDFaz4022KEanJHH6fVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587641; c=relaxed/simple;
	bh=Q9DB6rrX7syx19bJ5A3zohpHLFYKFnnGw9NwnuN7ge0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOkWJWNelop31+ZzJ7UCa+DHzRCMri7lX9Y/NczRsXF2WNXLtJWrKoHINK8T/bUuhK1I2yqktjvDmIT5NI9AkfnuaEEyTp3OoPPzeMYn5CDP7e0c2tLKiEYGiu8+VpedlJ7zB8OQUe/sB7P53b2d1vdBbePxtU7XCMsHXbz+76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qcQUBcQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+4EPT6L; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9B6CB3200A00;
	Mon,  4 Mar 2024 16:27:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 16:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709587637; x=1709674037; bh=Rks9XPxmQK
	5GOWfIcTKwdovL0jPIjO9eKIjqtCUqKuE=; b=qcQUBcQfoaH5L5eFYgoTTXhogy
	oWwOjLLSqL4bEK/7Qo2Td/ojAp/MPNXd6XAJLQyB12Qx8JY6bIZnNKRuwuHbd0oG
	v9jTUkXGAaKJZRQRUYZ8tmxffkDNKatgm58l5Jo/cgQtDOrPtaCVF3pf3S8vMm+J
	4L3av3HMJTmbvwX+V5vtyAPzPI+xWqYYuCKWjgOxz92Hl1/QQrovBKNA4g/xMSVE
	t7ITbXHWNGBRoAK6dpYc3/CYIL1CfyguNi6wOBLP7qIkouHZZIG+ZMmoGOBkJFkk
	ujYkD8r0D5W2HMn3K5v9wJPsEfuYN1XWRrV6+xtQ+cBJO49CDyM0R1grIckA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709587637; x=1709674037; bh=Rks9XPxmQK5GOWfIcTKwdovL0jPI
	jO9eKIjqtCUqKuE=; b=N+4EPT6LRYjZZB7YEKMud04cNy1QMTBCAcewBcfzD86q
	O4LvJN6gyvwrehgsbHyRoAa+GI49lXm+Fx2NxpAoN3bjAoUPern8VnaXvv/vw++g
	ilf+jYLS7g9VTuTjvC8UAXNQ2fENEKJbl80IbdRlYh7chVQWpQwDDw5N31sj7S2e
	ART5tTKvy7gMWwu5AElSTbRaX4eD+5TfRRvDIVKvQ03nj46HPgSd3VRaJukUT/Tz
	yfWqrShBvtizhk/cVHgSvzvVFR3JVDFpTsyp9AkBFrZMto+1ZpmF3o+snO3NmK9M
	XSlv6fm7QJDD7Qlpzz4gaPeIziVm4/WREcZ3m90R2w==
X-ME-Sender: <xms:tDzmZSn3tWQSWM3LeFEIzf67SiZEDWV2nDYzzf6zBViEH3DRL16AcQ>
    <xme:tDzmZZ0uSw2eQzWrpnAWObryjmtVqJ8DNklAGRgDgBDsxKxl_EVcLY0Wmpvor55N4
    MwMK5bVPAl94Mc8QDE>
X-ME-Received: <xmr:tDzmZQo_AEszZbPais_PABPKGkjK7FoaiJ_Yezx4rcq4t76yMIKM99ECHOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:tDzmZWk_2TVNITNz4HU_Epe82ZHwTe70k1IAWN7OyHPIAk4t_q9Rmw>
    <xmx:tDzmZQ0aiNsQSu0Er1PdlJ0Vse8anecytIxdjsj-UnrdD5XpNT_kxg>
    <xmx:tDzmZdthPYscxb64PJ30adICvPopyyHjXjmK_0GkQ21Bgh3KKw09nA>
    <xmx:tTzmZeB7ZWhHGVCJiIz901Hj5-XAQIueQE3DXXQSQt0s4f-vpWsiLw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 16:27:16 -0500 (EST)
Date: Mon, 4 Mar 2024 13:27:10 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs-progs: forget removed devices
Message-ID: <ZeY8rlr0ckxSEh+0@devvm12410.ftw0.facebook.com>
References: <cover.1709231441.git.boris@bur.io>
 <751eba3d-c72e-475b-8d21-e15c1d085ce0@oracle.com>
 <20240301115442.GI2604@twin.jikos.cz>
 <20240301154444.GB1832434@zen.localdomain>
 <20240304180736.GM2604@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304180736.GM2604@suse.cz>

On Mon, Mar 04, 2024 at 07:07:36PM +0100, David Sterba wrote:
> On Fri, Mar 01, 2024 at 07:44:44AM -0800, Boris Burkov wrote:
> > On Fri, Mar 01, 2024 at 12:54:42PM +0100, David Sterba wrote:
> > > On Fri, Mar 01, 2024 at 08:01:44AM +0530, Anand Jain wrote:
> > > > On 3/1/24 00:06, Boris Burkov wrote:
> > > > > To fix bugs in multi-dev filesystems not handling a devt changing under
> > > > > them when a device gets destroyed and re-created with a different devt,
> > > > > we need to forget devices as they get removed.
> > > > > 
> > > > > Modify scan -u to take advantage of the kernel taking unvalidated block
> > > > > dev names and modify udev to invoke this scan -u on device remove.
> > > > > 
> > > > 
> > > > Unless we have a specific bug still present after the patch
> > > > "[PATCH] btrfs: validate device maj:min during open," can we
> > > > hold off on using the external udev trigger to clean up stale
> > > > devices in the btrfs kernel?
> > > > 
> > > > IMO, these loopholes have to be fixed in the kernel regardless.
> > > 
> > > Agreed, spreading the solution to user space and depending on async
> > > events would only make things harder to debug in the end.
> > 
> > In my opinion, leaving the incorrect cache around after a device is
> > destroyed is a footgun and a recipe for future error.
> 
> I agree here partially, leaving stale cached entries can lead to bad
> outcome, but including userspace as part of the solution is again making
> it fragile and less reliable. We're not targeting the default and common
> use case, that would work with or without the fixes or udev rules.
> 
> The udev event is inherently racy so if something tries to mount before
> the umount udev rule starts, no change other than we now have yet
> another factor to take into account when debugging.

That's a good point. I do agree that this is a race we need a solution
for, and is a good argument for an in-kernel fix.

> 
> > Patching it up
> > with Anand's kernel-only fix will fix the problem for now,
> 
> This is a general stance kernel vs user space, we can't rely on state
> correctnes on userspace, so kernel can get hints (like device scanning)
> but refuse to mount if the devices are not present.
> 
> > but I would
> > not be at all surprised if there isn't a different more serious problem
> > waiting for us down the road. We're just looking at exactly devt and
> > temp_fsid, and I'm quite focused on breaking single device filesystems.
> > I spent a week or two hacking on that reproducer. Are we *confident* that
> > I couldn't do it again if I tried with all kinds of raid arrays, error
> > injection, races, etc? What about after we add three more features to
> > volume management and it's been two years?
> 
> We can only add more safety checks or enforcing some feature using flags
> or options. Adding features to a layer means we need to revisit how it
> would go with the current state, something that we did with the
> temp-fsid, now we're chasing out the bugs. We did not have a good test
> coverage initially so it's more than what could be expected for a
> post-release validation.

I think it's fine for new features to hit unexpected bugs, that's pretty
much normal. All I'm saying is that  putting bandaids on bandaids is what
leads to a much higher likelihood of bugs any time something changes.

> 
> > Getting a notification on device destruction and removing our state for
> > that device is the correct fix. If things like this need to be
> > in-kernel, then why is udev the only mechanism for this kind of
> > communication? Can we get a callback from the block layer?
> 
> I don't know, it sounds simple but such things can get tricky to get
> right once it's spanning more layers and state changes. I've heared too
> many horror stories from CPU or memory hotplug, the unexpected changes
> in block devices sound too similar.
> 
> The approach we have is to store some state and validate it when needed,
> but we apparently lack enough information sources to make the validation
> 100% reliable. I think we gained a lot of knowledge just from debugging
> that and prototyping the counter examples but I'm observing we may not
> have means for fixes.

Agreed with everything you've said. I naively feel like a notification
model can work, but it does have a kind of spooky air to it for the
reasons you gave.

An idea that popped out of our group at Meta discussing this bug was to
use udev to manage state used by a btrfs specific version of mount. That
btrfs-mount would handle all the "scan before mount" considerations we
currently have. 

Ideally, it means we can get rid of the in-kernel cache entirely and so
we aren't afraid of races with userspace. Food for thought, at least.

Since a solution like that would be a pretty serious undertaking, I
think we probably do need a more pragmatic short term fix like Anand's.
What about refactoring it a bit to just trust the cache a lot less. It
would essentially be the same as Anand's patch, just without special
cases for mismatches. Basically, something like "create a new btrfs_device
no matter what"

