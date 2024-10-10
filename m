Return-Path: <linux-btrfs+bounces-8777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7D9982AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AF51F21A9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52D1BD4E0;
	Thu, 10 Oct 2024 09:45:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D61BBBC4
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553506; cv=none; b=lWE4yCbkMOGwOuLCxRmcHtbqBdWN9HBI1Mlvw16/3J/GWKPZBTRTmGdN11Wlv4593HsxsJeumjty9uYrtasinQutZ48P4gYpWklSn03AMWVBjhh7uZdvlr0OR2qzpAGedYdmGdLYY/MIYGhoN/wljb34dZAJQoQ4sgPJfFBgoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553506; c=relaxed/simple;
	bh=6eiDyhuZxxwzkQjEDPZxwxH9psTvZg5RmPFx8LWQhQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxMJP1WlpewUEBnYis2u2ZvX+1ETBA9K6wWt+lCEbMbckCEcWlNiuO4xGaRNKshFJ+36vjANHzSsae2Oeehn5Tjx19zVs/h2FR2o75uglNS+PfXw5PxZ1L6D/XaGnHAa+ntxG5P4hF2hwWZ+qL2BXTk2u1RH/lTZAfH3KVy1AdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AC60227A87; Thu, 10 Oct 2024 11:45:00 +0200 (CEST)
Date: Thu, 10 Oct 2024 11:45:00 +0200
From: hch <hch@lst.de>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: hch <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Message-ID: <20241010094500.GA10100@lst.de>
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com> <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com> <5c363f14-c3d3-4d5d-bc46-8b38d2bcd08e@gmx.com> <8f76a524-aa49-46b2-aa44-33f92fcd00a5@gmx.com> <20241010070620.GC6674@lst.de> <zwr4zs6gggixecwyapy7ghay4bjp3tsekqgzj3gswxmfn5dwyq@cu757ssku4p6>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zwr4zs6gggixecwyapy7ghay4bjp3tsekqgzj3gswxmfn5dwyq@cu757ssku4p6>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 10, 2024 at 08:53:52AM +0000, Naohiro Aota wrote:
> Things can screw up here. If the btrfs_bio_end_io() for a "split clone"
> btrfs_bio is called fast enough (or immediately in case of dm-error), the
> "split original" btrfs_bio is not yet submitted. Thus, its private data,
> which is setup in btrfs_submit_mirrored_bio(), is not yet have a proper
> value. So, reading orig_bbio->bio.bi_private returns NULL, and accessing
> its max_errors results in NULL pointer dereference.

Ok, thanks.  So yes, the cmpxchg based version of this should be fine.


