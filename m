Return-Path: <linux-btrfs+bounces-11178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788AA22D1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 13:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAD61680B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7A1E2848;
	Thu, 30 Jan 2025 12:53:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA63B660;
	Thu, 30 Jan 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241601; cv=none; b=AYA4g4gztNjuGBf5KTSMhVBJVJuFE/c5HQABI7S0ev9HCMg01bWjDQYWs1+7N5nnIQk4BddbeidXSseveK8U1ni3az0ITZcriUcs6sLv/0zQ2TjmoM4TS8jFT6YG6MNCpUYYRyvk8RJmZ4UzY09I3QorHR4nWLhqn3SGtcq3Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241601; c=relaxed/simple;
	bh=IikLnl2xRBT1SqibI2yFWsU+AQtGjFfIGPASJTUXKew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKgAIL2GuyERtbb7OzySPkuT1bKGec7/wckGxmXpEGfpRMuSy1r72/4HH6k9D3vuv/reGrEm/iOqO3xZhLqU3jGD1klu2eN9IzbZL5ZX+dit6CSwD/GFRxKD9vuOyFap02deAC7fT9BbbRixPNReQonCC5YYzpTzpyNMkxQMxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C37EC68C4E; Thu, 30 Jan 2025 13:53:06 +0100 (CET)
Date: Thu, 30 Jan 2025 13:53:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com, dsterba@suse.com,
	clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250130125306.GA19390@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de> <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 30, 2025 at 02:52:23PM +0530, Kanchan Joshi wrote:
> On 1/29/2025 9:05 PM, Christoph Hellwig wrote:
> >> This patch series: (a) adds checksum offload awareness to the
> >> block layer (patch #1),
> > I've skipped over the patches and don't understand what this offload
> > awareness concept does compared the file system simply attaching PI
> > metadata.
> 
> Difference is that FS does not have to attach any PI for offload.
> 
> Offload is about the Host doing as little as possible, and the closest 
> we get there is by setting PRACT bit.

But that doesn't actually work.  The file system needs to be able
to verify the checksum for failing over to other mirrors, repair,
etc.  Also if you trust the device to get things right you do not
need to use PI at all - SSDs or hard drives that support PI generally
use PI internally anyway, and PRACT just means you treat a format
with PI like one without.  In other words - no need for an offload
here, you might as well just trust the device if you're not doing
end to end protection.

> 
> Attaching PI is not really needed, neither for FS nor for block-layer, 
> for pure offload.
> When device has "ms == pi_size" format, we only need to send I/O with 
> PRACT set and device take care of attaching integrity buffer and 
> checksum generation/verification.
> This is abstracted as 'offload type 1' in this series.
> 
> For other format "ms > pi_size" also we set the PRACT but integrity 
> buffer also needs to be passed. This is abstracted as 'offload type 2'.
> Still offload as the checksum processing is done only by the device.
> 
> Block layer Auto-PI is a good place because all above details are common 
> and remain abstracted, while filesystems only need to decide whether 
> they want to send the flag (REQ_INTEGRITY_OFFLOAD) to use the facility.
---end quoted text---

