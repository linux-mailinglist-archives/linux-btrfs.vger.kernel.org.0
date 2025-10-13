Return-Path: <linux-btrfs+bounces-17716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8FBD4EE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70AC2350E11
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBC17F4F6;
	Mon, 13 Oct 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="OQEdLVz3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9030AAA9
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372220; cv=none; b=NwWqUsr3Kj7i9Lnn98/U7guxYcU5iPXphfMLiMIvJYipWSl7mDlJtgvfQJrXyuwnZRApOWkrk6LeGJvcwDTN957iLEQp1APOINx2b2VL+3cr0YhxNGaDMRFCpNr9T7aS0iYh83ofvCwFUZT26OfET+aLbkwKQMIFbm4ZZWG1lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372220; c=relaxed/simple;
	bh=HYjzPi5jVJJayUVxyxtwiD+jUCIF5CnhgC97Nh3Yyqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqMcFbamajsz8gDmkPNvDgxKpxWGCcIUiNGSjGE9077qJP7e8TH46uM1BDXCL5N3ZQh85mkxpmEN73nF1E2pX9WSOBxEcwdF4LXGtSUWy/CNCKOGBYMdMYWOorJGsXC1zHNqKiI/vnPZCtZ3BGa9tdVuLsgScihFyeSYe4DOR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=OQEdLVz3; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-To;
	bh=UxYTL/X0QTZAOlzt1MDEDdRdgMMTdNG3sgs8PRvbTbw=; b=OQEdLVz3pwDUO/LJ8kKncq0icn
	dz+o57Yb9cBzj3yn0ZEZOHtCQZIR/28yDuSxavmCMAmNctBPvN/IQJJszx3wz0v4FeMpkR8SC1uoS
	ULZl5cdWDc+9gF2IZzqrjTlZqrBl4duv1kv1mk5v0CaYEtNIReyM7D2c9WT/7IXC+Baw5NdR067nl
	NrAvkuKGAFcnoUbXqnHfCexgh8jeVi9owqe9pmIT52Zl1mnTE3nscOC0CgUpxA9EFIwtZRHH4acX/
	lKfYgkJHSCclSF/7/17hIUlfIw0KYWYTMWVzNpt0YlVA8YOL3TSOgPnzTjlzn6IibvO8hqGHbeyhF
	FqH9b3eg==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1v8Kwi-0004Sx-27; Mon, 13 Oct 2025 15:58:48 +0000
Date: Mon, 13 Oct 2025 15:58:48 +0000
From: Andy Smith <andy@strugglers.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Mysterious disappearing corruption and how to diagnose
Message-ID: <aO0huPDpgwqytAPX@mail.bitfolk.com>
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
 <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
 <aLIm5djb6Ee4T1ot@mail.bitfolk.com>
 <635a25a0-c8cb-4a48-bf8b-c81dac1c1260@gmx.com>
 <aLI8XeLxrWhwhcZK@mail.bitfolk.com>
 <5f38efc7-6d0c-4f9e-89a5-6d1fccbed397@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f38efc7-6d0c-4f9e-89a5-6d1fccbed397@gmx.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

Hi Qu,

On Sat, Aug 30, 2025 at 09:33:49AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/30 09:18, Andy Smith 写道:
> > Hi Qu,
> > 
> > On Sat, Aug 30, 2025 at 08:28:25AM +0930, Qu Wenruo wrote:
> > > 在 2025/8/30 07:47, Andy Smith 写道:
> > > > Okay. Yes it is still supported by Debian so they are still publishing
> > > > updates for the related LTS kernel but I am relying here on fixes going
> > > > in to LTS kernel in the first place.
> > > 
> > > In v6.4 we reworked the scrub code (and of course introduced some
> > > regression), but overall it should make the error reporting more consistent.
> > > 
> > > I didn't remember the old behavior, but the newer behavior will still report
> > > errors on recoverable errors.
> > > 
> > > I know you have ran scrub and it should have fixed all the missing writes,
> > > but mind to use some liveUSB or newer LTS kernel (6.12 recommended) and
> > > re-run the scrub to see if any error reported?
> > 
> > I do a bit of travelling the next few days and I will not like to change
> > kernels on this non-server-grade system with no out-of-band management
> > while I am not close by. So, I will leave things with sdh outside of the
> > filesystem for now.
> 
> Have a good travel.
> 
> > 
> > When I return I will upgrade the kernel, scrub and if clean put sdh back
> > into the filesystem then scrub again. The Debian bookworm-backports
> > repository has a linux-image-amd64 package at version 6.12.38-1~bpo12+1.
> > 
> > When I go to put sdh back in to the filesystem, I can do so with a
> > "replace" because sdh > sdg. Unless you think it would be better in some
> > way to do a "remove" and then an "add" this time?
> 
> Replace is way more efficient/faster than remove then add.
> 
> The latter will relocate all chunks of the source device to other devices
> (which may not even have enough space), and add the new device empty.
> Thus you will need to rebalance all those chunks again to reach the new
> device.
> 
> So just plain dev-replace will be the best.

Just to close this off in a slightly unsatisfactory way:

I found time this last few days to upgrade the machine to Debian 13, so
that is kernel 6.12.48+deb13 and btrfs-progs v6.14.

I did a scrub in the state that it was when we last corresponded
(suspect SSD not in the filesystem) and that came back all clean.

I did a replace to get the temporary drive out and the suspect SSD back
in, which went without incident.

Then I did a scrub again and again all was fine.

So I now can't see any problem. I can't reproduce what was happening
before.

Thanks,
Andy

