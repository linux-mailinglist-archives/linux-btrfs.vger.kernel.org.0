Return-Path: <linux-btrfs+bounces-11179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2973A22D1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650851889704
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78151E2848;
	Thu, 30 Jan 2025 12:54:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0950B660;
	Thu, 30 Jan 2025 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241667; cv=none; b=dbMXLygTfDJJdzFJRdOlE90xEtnWR8bKA98OdT4NVOm8MSgFPZJS7RfK0YQqGqJYE54WRsMVNYlMPZy0yKZ6btA62vR/Kg+AYCKQMT/arLmdtxJe4yCjsx2Dkz27MqrzUiAw8K+HL9K+gbOY916v9tiMl7Yr3/7OsCgCnsvc9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241667; c=relaxed/simple;
	bh=Ot3Bo4GO39731EgDitIZNpHcyMlOeXBQ3IUEoGjo46E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgfS5lup0MzB6NVU6FhpcrqrXBUXBpENFhNLFHElDky0MT2cZuN5/7t3+hqnZNNeNGJjOBabI+oVv0t9pAtGYHc+ihSsdIfvRnbJRaAG/wztADzcL/rZu2Hf/rgwZkx5Lobb3GNULC4WBbNV38kNZl5t7Tyk6WP/njfmX2/CVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70D0268C4E; Thu, 30 Jan 2025 13:54:21 +0100 (CET)
Date: Thu, 30 Jan 2025 13:54:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250130125421.GB19390@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <Z5pJGHAR7AWCC0T4@kbusch-mbp> <20250129154025.GA7047@lst.de> <Z5pteC56jYBRDupP@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5pteC56jYBRDupP@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 11:03:36AM -0700, Keith Busch wrote:
> > away.  But we also lose integrity protection over the wire, which would
> > be unfortunate.
> 
> If the "wire" is only PCIe, I don't see why it matters. What kind of
> wire corruption gets undetected by the protocol's encoding and LCRC that
> would get caught by the host's CRC payload?

The "wire" could be anything.  And includes a little more than than
than the wire, like the entire host side driver stack and the device
data path between the phy and wherever in the stack the PI insert/strip
accelerator sits.

