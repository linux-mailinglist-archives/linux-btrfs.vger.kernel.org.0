Return-Path: <linux-btrfs+bounces-20681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B2D39F04
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6381F3008140
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFBE28850C;
	Mon, 19 Jan 2026 06:51:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D19283CA3
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805462; cv=none; b=eWngVddwEP+eK3Szi3zMrjIQhKzveJXjJmX4csJXuSWKaw2YSHKIFjKIWiHU0+e4yxyBkU1QKqoE8UtU0OfYrfqTYa5DvM1NqSTD1IyXmBdwmnyQ1tpAJUx3Gda49m8ayFsgeWizcZMFeOmvstassZ8EjOrJ2Fpycc+mll+440w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805462; c=relaxed/simple;
	bh=gKovHMJBooihoCKPJrztVcSUifxd1+fKTaLC7gYPBlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH7xzL5wqcvGF1xMpSjyHOkpxAYdt/LlQ/YuHKyz/6WKM8/BXVUtw+opsJxa7nhwSLgWWUC2F0BtUAr/TR4Q3Z+RW7H5VWEXwnwrwfFW1p5z/U+U9mfM4ZBmQlVQehM9mn997E1Hw7FRUbHqhwbkodYj5Kqde4ClzOhQCQyAINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAC82227AAA; Mon, 19 Jan 2026 07:50:57 +0100 (CET)
Date: Mon, 19 Jan 2026 07:50:57 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	David Sterba <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional
 zones
Message-ID: <20260119065057.GB1316@lst.de>
References: <20260116095739.44201-1-johannes.thumshirn@wdc.com> <20260116145421.GC16842@lst.de> <9a37829c-cc94-4d4a-b732-834e1c68cc2c@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a37829c-cc94-4d4a-b732-834e1c68cc2c@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 16, 2026 at 06:46:23PM +0000, Johannes Thumshirn wrote:
> way. The second motivation is that we can remove the faking of 
> sequential zones on conventional zones, aka the write pointer emulation 
> etc..

Is that so much code?  For XFS, it basically is a making the replacement
of REQ_OP_WRITE with REQ_OP_ZONE_APPEND in the lowest level write path
conditional instead of unconditional, and to query the rmap to fake up
a write pointer at mount time.  At the same time this allows running
on conventional devices, which is not just great for testing, but also
allows direct benchmarking of the different allocators (and it turns out
there's plenty workloads where at least on XFS the zoned allocator
does better).

