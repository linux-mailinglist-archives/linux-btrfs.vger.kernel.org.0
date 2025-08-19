Return-Path: <linux-btrfs+bounces-16159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44336B2C8D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8215A5CF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F92877F1;
	Tue, 19 Aug 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuER1DPL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048426E707
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618866; cv=none; b=ZKjJ1c+GI42BJ9eR6PNc2ICnFcU4Yet1UROBsBnw/qtyRHGS9S7M0roNXFDO8RCh2Pq3xsh6ws2zMzdL5EzfrjEBT0dvghdvEJXOFzqanBKIeNKlz+UrkTqVarr/a1cYiihBiQCL/pIW9OTe1o9LXmq7Mtf9cc0GW//OmR/xVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618866; c=relaxed/simple;
	bh=S65wDZoRLxmSfj21MfAA/E0v1fAbAA9l3eqqpm/r3Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM7I/Qz0e++jcWJVnfJtKAriKDw3+9DFSum1CRbgiCHzQXF33wo9y5fOLxxLzZxcNq04JWXxKEff4t+6FVJv8AuAEq3jd84+W6BHKvETpIJ96poIWOobwnhD1wJ8IRWZRX+NYchJsfO6CuqUZOdaUhXGL9kNBe9JD2bCFwN5B2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuER1DPL; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 08:53:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755618852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PG0zliYVlI6AQ64N2YXt0bgLSgwMGhnFEXp7yOr1q0=;
	b=WuER1DPLc5dv9K+FyrJfrMwpUJJ39XGue0LfyIYiP9IkGL50Xa4nQWocAMWSUEyJ4XnJSX
	qr+xmCcAi3gf6D6p302Om9D+BIds+i+at2NEgww8owRtPX5TNtYzsfg/6QB1zdez08VD5c
	UcIL6KrKDkNBEfiDIVIIIvIrCtb9tJs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com, wqu@suse.com, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <tw5qydmgv35v63lhqgl7zbjmgwxm2cujqdjq3deicdz2k26ymh@mnxhz43e6jwl>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
 <aKPmiWAwDPNdNBUA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKPmiWAwDPNdNBUA@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 03:50:49AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 05:36:54PM -0700, Boris Burkov wrote:
> > Uncharged pages are tricky to track by their essential "uncharged"
> > nature. To maintain good accounting, introduce a vmstat counter tracking
> > all uncharged pages. Since this is only meaningful when cgroups are
> > configured, only expose the counter when CONFIG_MEMCG is set.
> 
> I don't understand why this is needed.  Maybe Shakeel had better
> reasoning that wasn't captured in the commit message.
> 
> If they're unaccounted, then you can get a good estimate of them
> just by subtracting the number of accounted pages from the number of
> file pages.  Sure there's a small race between the two numbers being
> updated, so you migth be off by a bit.

My initial thinking was based on Qu's original proposal which was using
root memcg where there will not be any difference between accounted
file pages and system wide file pages. However with Boris's change, we
can actually get the estimate, as you pointed out, by subtracting the
number of accounted file pages from system wide number of file pages.

However I still think we should keep this new metric because of
performance reason. To get accounted file pages, we need to read
memory.stat of the root memcg which can be very expensive. Basically it
may have to flush the rstat update trees on all the CPUs on the system.
Since this new metric will be used to calculate system overhead, the
high cost will limit how frequently a user can query the latest stat.

I do know there are use-cases where users want to query the system
overhead at high frequency. One such use-case is keeping a safe buffer
on a memory overcommitted system (Google does this and measure system
overhead every second).

