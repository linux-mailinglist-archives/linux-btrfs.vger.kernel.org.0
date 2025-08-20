Return-Path: <linux-btrfs+bounces-16178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65387B2E239
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1E16D6BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E97327786;
	Wed, 20 Aug 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fRssMe4x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581F2264D5
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706933; cv=none; b=SdSPt3itqm1CxHD6zvJ8iq9d8ZW3l6mM2wEkivB0/bLfleXMnI04btcommDx3LFlBG2LFodFUryAp7NgXVte0iRERe1qBlq4rYWqzHb7RPsy8O3GOBw4ChGJZOEBpc/Dby2SNIWLGfKgwsGH6ra674IGsDijTcuL21Gnvt1QL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706933; c=relaxed/simple;
	bh=IsFyELa9QPrqBJgwucGOJ0VEdl9y/5Oh61mhguqB+ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5RG6txnm8Fqy8lVd3A3VXuv+WcpGeuVJAGmJ6s94If7GRScTUeq3KUjVy+DmRsWSU5pXhL2ESs7Wejlt8/l+B9ntp1CmO4nA34aRg6mhjP+gn/lWwKK6ksX4IVs4eaipkAGIWIwAy64/PBpbXBuOnnQX1FTcnqKoIiUpAYI6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fRssMe4x; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 09:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755706918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBLYyaohMUoNQ9X3he/qnSrc95mW/vnc+a+/vaGlBWU=;
	b=fRssMe4x4fjWLKNWxp9No6Dt3tT/XKMTSIz4exFpUGvwlVWtQ9hM1hkvC54a+RUloUG33v
	0F2yFukgQwfF1ekGUJ3up1lB8CT6ifF13pr6i/0mgLfGuYbsq0W66fsruIpbmgjtE4Ir6Z
	fnJoz9vzguWadvcdAyHnRc7Gwiz7Mp0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com, wqu@suse.com, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <6xccsmpdtvweriimshfvgz7yzxcdodbxhzfvxraigdqiomkgze@wb2i46neozwu>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
 <aKPmiWAwDPNdNBUA@casper.infradead.org>
 <tw5qydmgv35v63lhqgl7zbjmgwxm2cujqdjq3deicdz2k26ymh@mnxhz43e6jwl>
 <aKUM49I-4D24MmwZ@casper.infradead.org>
 <i4hg4g75ywbera643uhtshkj6xrriqi4mi5dg3oga5os3tp6m5@u2dcv2snbiqs>
 <aKXLXJw7m-TSkZOI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXLXJw7m-TSkZOI@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 02:19:24PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 19, 2025 at 06:25:36PM -0700, Shakeel Butt wrote:
> > On Wed, Aug 20, 2025 at 12:46:43AM +0100, Matthew Wilcox wrote:
> > > OK, but couldn't we make that argument for anything else?  Like slab,
> > > say.  Why's "file" memory different?
> > 
> > Good point and I think it does apply to other memory types too. I would
> > call "file" memory to be more important as it is one of the largest
> > consumer of DRAM on, at least, Meta infra. Slab needs a bit more thought.
> > At the system level (i.e. /proc/meminfo), we account at the page (or
> > slab) level while for memcg, we account per-object (plus obj_cgroup
> > pointer).
> 
> That was supposed to be a reductio ad absurdum, not an invitation to
> add more counters.
> 
> Look, if this is information you really need, I think you should come
> up with a better way of collecting it than by adding new counters and
> new complexity to everything involved in GFP_ACCOUNT activities.
> 

Please elaborate more on this complexity. To me, particularly for this
specific case, a dedicated counter seems more cleaner compared to error
prone and costly alternatives. I am not getting the complexity argument.

> The unaccounted address_spaces are a very tiny percentage of file
> memory, at least as far as this patch set goes.

From [1], Qu noted "On a real world system, the metadata itself can
easily go hundreds of GiBs...".

This does not seem tiny.

> I don't think this
> patch is justifiable on its face.

I think I have provided enough justifications. However I don't want to
force push this until I fully understand your concerns. This will become
part of API and I don't want a situation where we regret this later.

[1] https://lore.kernel.org/linux-mm/08ccb40d-6261-4757-957d-537d295d2cf5@suse.com/

