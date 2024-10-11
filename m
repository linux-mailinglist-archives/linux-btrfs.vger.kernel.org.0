Return-Path: <linux-btrfs+bounces-8867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91499AF1F
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 01:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2D51C2402E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1481E3DE6;
	Fri, 11 Oct 2024 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Ym6KJO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD21D27A9;
	Fri, 11 Oct 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688311; cv=none; b=hZRK5tqr3zMMzpTL+IYZoA7fpmZNh3MD7y4YXW/yx4ooOBkFcdHdEO+9BIUNy03FGbulIBV52WHcSe0SPv/GMlnHm3ojmzQUl1eODABzUymEBqxaWhTcEktOMI7Y2KrMFnraxDhcX6MDTMTk1GehOx+ebLEzKmnTcC4CtHWAA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688311; c=relaxed/simple;
	bh=iVJ74e4tA1WxfHXS2xP4RqS7VvfQLdtn7Zy1xtIgh5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtzn6bBBnEacnYghEb/bNNaU85KV8uWOt1v9xiziLT+dV/weXr8J1brl91rA9vGvMamG6p/zcoh2ACyLXkrCAbuJq3Aa/tvqWq7c/lbDnta+MeuEgkfhz9bMZiCLPHwrJy2UcbmDlDeKOtMx2y1og5O23m++Tg1VeAjlcHlupjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Ym6KJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D19CC4CEC3;
	Fri, 11 Oct 2024 23:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688310;
	bh=iVJ74e4tA1WxfHXS2xP4RqS7VvfQLdtn7Zy1xtIgh5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6Ym6KJOF6tfls3kP0ehEPQZxEZLje3eMQHOk+Cd/nR4ws/cIVbd6MA5SeVoVQmKK
	 mxx5dNMw/481In9ovH50xCEVB6pP31MVQ47e2nYl3C2Oxsuauy29+O1peg0N9/xmbq
	 F180EP5MTAbYcFwxk9baCTKhQp6OkU2jX/OWDYssXq7xfX8l7jg6+ZhNT+sY/xZhdi
	 II6Ij98DGQ7smljfSzMGiRKX/PseqCew3FmMuE0rE1HUkLnNWA3KbFktOSDp6z6euh
	 WvKHXPhyfD2yFHIyQ5QYFySsVXz118y+VowWBAQhzm2diBIvUbczSC4jjVNi6WDHjk
	 QWA7uI9pVYXzA==
Date: Fri, 11 Oct 2024 16:11:49 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: Root filesystem read access for firmware load during hibernation
 image writing
Message-ID: <ZwmwtZivKP8UDx1V@bombadil.infradead.org>
References: <3c95fb54-9cac-4b4f-8e1b-84ca041b57cb@maciej.szmigiero.name>
 <413b1e99-8cfe-4018-9ef3-2f3e21806bad@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413b1e99-8cfe-4018-9ef3-2f3e21806bad@maciej.szmigiero.name>

On Sat, Oct 05, 2024 at 03:16:27PM +0200, Maciej S. Szmigiero wrote:
> The issue below still happens on kernel version 6.11.1.
> 
> Created a kernel bugzilla entry for it:
> https://bugzilla.kernel.org/show_bug.cgi?id=219353
> 
> It would be nice to at least know whether the filesystem read access supposed is
> to be working normally at PMSG_THAW hibernation stage to assign the issue accordingly.

No, there are races possible if you trigger IO to a fs before a suspend
is going on. If you have *more* IO ongoing, then you are likely to stall
suspend and not be able to recover.

> CC: request_firmware() maintainers

If IO is ongoing suspend is broken today because of the kthread freezer
which puts kthreads which should sleep idle, but if IO is ongoing we
can stall. This is work which we've been working to remove for years and
after its removal we can gracefully freeze filesystems [0] [1]
properly on suspend.

Other than that, obviously upon resume we want firmware to be present,
and to prevent races on resume we have a firmware cache. So on suspend
we cache used firmware so its available in cache on resume. See
device_cache_fw_images().

So.. we just now gotta respin the latest effort. I had stopped because
I know Darrick had some changes which he needed to get in sooner but
since this is low hanging fruit I never got around to it. So someone
just needs to respin the series.

[0] https://lwn.net/Articles/752588/
[1] https://lwn.net/Articles/935602/

  Luis

