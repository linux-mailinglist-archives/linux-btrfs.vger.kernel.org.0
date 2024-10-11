Return-Path: <linux-btrfs+bounces-8868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137599AF76
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D31284805
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8211E5018;
	Fri, 11 Oct 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsFZtDBr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4881D151F;
	Fri, 11 Oct 2024 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689994; cv=none; b=lwk/BdsL8R8SxPQcsXobcLeT9SJKoySO24/uhayrT4ChCrr60fBzuOxmT8U9rhoDeAo9ZaI3MlIRHno78f5PXMqBiUA0Xw19XoZH8SfsclXDiZcXwhZbyZEMrYSW4zRZta5UwKn23ZcwmShn5d0na98SBiQRb7A0BIpJn6KLz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689994; c=relaxed/simple;
	bh=0H0BfGqTjHllor+/fH1lqydfbPRfBmmQP7rU/V3btE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb0mfKj/ZC4d/KACwKl49L2B9nq/GxHA34lw4iWRj5KVFLGM9Oec4NMceddSMgGhi7V58r6VXT2w83zpc/850FPrtVhV1ilwDl/xNLDGyTy9iU3vtzjRejZ5S0Vpj2eJ4gqqgr3BCfrX9vUP1wbjoQBhN3ZnYHWydME2kFME6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsFZtDBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307ECC4CEC3;
	Fri, 11 Oct 2024 23:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728689994;
	bh=0H0BfGqTjHllor+/fH1lqydfbPRfBmmQP7rU/V3btE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsFZtDBr7U9R4CzAT0t+ml6MpKPygeLFDPMCOv9bcinKIBWOUd72WSsUnsWZxaiwq
	 QKM+oR7N0aKVZDMQTjYvMrEcGgkfQowMwdKc3C6BxKKCpo0d2dPEVXdN7zHxOFj60T
	 qo1h9vpH0F4BayrVI0URR4L2tFq+nzap5J5Z6au4Gz48wNlejIpgblSEEo0zQ/2PQu
	 OVOi6OMSMM0lYWoVBAbY1hZeiOnbvxJt+SalZF8ehiFd6qoo1zV5dzXeo96arTXro9
	 XPsufb8M9cHhfRmYWCvdXSRVlHh3eT6Q3HnvNI1Ul4g+Ack1JlxooiF8B/TYehrWBi
	 e4ZuOtcpm8iug==
Date: Fri, 11 Oct 2024 16:39:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: Root filesystem read access for firmware load during hibernation
 image writing
Message-ID: <20241011233953.GJ21877@frogsfrogsfrogs>
References: <3c95fb54-9cac-4b4f-8e1b-84ca041b57cb@maciej.szmigiero.name>
 <413b1e99-8cfe-4018-9ef3-2f3e21806bad@maciej.szmigiero.name>
 <ZwmwtZivKP8UDx1V@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwmwtZivKP8UDx1V@bombadil.infradead.org>

On Fri, Oct 11, 2024 at 04:11:49PM -0700, Luis Chamberlain wrote:
> On Sat, Oct 05, 2024 at 03:16:27PM +0200, Maciej S. Szmigiero wrote:
> > The issue below still happens on kernel version 6.11.1.
> > 
> > Created a kernel bugzilla entry for it:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219353
> > 
> > It would be nice to at least know whether the filesystem read access supposed is
> > to be working normally at PMSG_THAW hibernation stage to assign the issue accordingly.
> 
> No, there are races possible if you trigger IO to a fs before a suspend
> is going on. If you have *more* IO ongoing, then you are likely to stall
> suspend and not be able to recover.
> 
> > CC: request_firmware() maintainers
> 
> If IO is ongoing suspend is broken today because of the kthread freezer
> which puts kthreads which should sleep idle, but if IO is ongoing we
> can stall. This is work which we've been working to remove for years and
> after its removal we can gracefully freeze filesystems [0] [1]
> properly on suspend.
> 
> Other than that, obviously upon resume we want firmware to be present,
> and to prevent races on resume we have a firmware cache. So on suspend
> we cache used firmware so its available in cache on resume. See
> device_cache_fw_images().

Reads are generally supposed to succeed on a suspended system but if the
read causes a write (e.g. atime update) they can block just like a write
would.  So in the end you probably have to cache the firmware blobs in a
tmpfs or something like that.

> So.. we just now gotta respin the latest effort. I had stopped because
> I know Darrick had some changes which he needed to get in sooner but

Do you remember what changes those were?  I don't. :(

--D

> since this is low hanging fruit I never got around to it. So someone
> just needs to respin the series.
> 
> [0] https://lwn.net/Articles/752588/
> [1] https://lwn.net/Articles/935602/
> 
>   Luis

