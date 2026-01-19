Return-Path: <linux-btrfs+bounces-20679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3BD39EF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 413CE300533C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445128689A;
	Mon, 19 Jan 2026 06:49:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3946283FE6
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805346; cv=none; b=uBR/2wa1RaEvuT9v8jBlmTuBDEx09YR2CizsI9qg1eobqTbiGXAJl369cl4s0XCNZAOpLjx+kNSjTKf0SGXI+bDaymY4b8cTsH3nuAcan+H/vD5k8vMXbAlNI9JfVKEOnpo2OZf3XbQUeBOyQG+qlWuklXTxwG4RCJmZxW9Y9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805346; c=relaxed/simple;
	bh=T4ow4R2163W57xo7q9l7u1WZpsamU4RWmlPlMYangcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu9tqtwG7JZIDRxg6dj4m5Tpz8nCGG6OZA71ObG+0iWNrmeHLVFF1azgE16wAnLLYgkcvIFV8j8heKkQg/9MXD7o3E3Q/cla1xpIy1Ty9/+dYa0PqY4X7+wkcuDeiRZuH5KBXtaXeGlYEfsX4YKZEzKFMSaRetGZ8j/r/jTnOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F97E227AAA; Mon, 19 Jan 2026 07:48:58 +0100 (CET)
Date: Mon, 19 Jan 2026 07:48:57 +0100
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
Message-ID: <20260119064857.GA1316@lst.de>
References: <20260116095739.44201-1-johannes.thumshirn@wdc.com> <20260116145421.GC16842@lst.de> <9a37829c-cc94-4d4a-b732-834e1c68cc2c@wdc.com> <fadec915-cb8c-4b0a-96f6-5b278d5789fc@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fadec915-cb8c-4b0a-96f6-5b278d5789fc@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jan 17, 2026 at 09:46:49AM +0000, Johannes Thumshirn wrote:
> > The main intention behind this is, that we can handle metadata like
> > metadata on regular non zoned devices, including the ability to
> > overwrite it. But agreed I'd need to measure how much space we save this
> > way. The second motivation is that we can remove the faking of
> > sequential zones on conventional zones, aka the write pointer emulation
> > etc..
> One thing we could do here (and it shouldn't be easy as well) is, 
> *prefer* sequential zones for data and conventional zones for metadata. 

Absolutely.


