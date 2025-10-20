Return-Path: <linux-btrfs+bounces-18065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0FBF1F45
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95BC74F8126
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D76230274;
	Mon, 20 Oct 2025 14:57:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0322A7E0;
	Mon, 20 Oct 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972234; cv=none; b=V31V+mBgKqVqVg4zBd7A0KwgT5sbUtLgb25QK6ilPR2MOpTntc+YlqwW13xaA5XOnbEDWML7cHalmKyfx+ll+5ztGq34qFaeOJeYcb/8cW3jFHBdVis2F/mPs6/jUFCKSnN7lpQQ1zuZg9hk0kEAlndv0KNkUzISbf4aliJefKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972234; c=relaxed/simple;
	bh=PQk9ixRGFryduojm0awRi0pu88kQ3t2s+6XqA8tV40g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQu3ERJEV74cPlarkYwWmDXhNapB8fib7t0hlGL4kgugdLFaMXsgt9KOt95tEI8UiwDEO9odPTSuMp8fMevygLy7mR4u7gxijN2C0otLS6i7EUiDrcyCUOhPHo/+WNP7XLpMwY18VucGqdBA04McnOZMjc42JomUebhfgIasBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88327227A87; Mon, 20 Oct 2025 16:57:07 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:57:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	dsterba@suse.com, cem@kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] xfs: handle bio split errors during gc
Message-ID: <20251020145707.GA31743@lst.de>
References: <20251020144356.693288-1-kbusch@meta.com> <20251020144522.GB30487@lst.de> <aPZNNkSOYr88-8VF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZNNkSOYr88-8VF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 08:54:46AM -0600, Keith Busch wrote:
> > Ugg, how?  If that actually happens we're toast, so we should find a
> > way to ensure it does not happen.
> 
> You'd have to attempt sending an invalid bvec, like something that can't
> DMA map because you have a byte aligned offset, or the total size is
> smaller than the block device's.
> 
> Not that you're doing anything like that here. This condition should
> never occur in this path because the bio vectors are all nicely aligned.
> It's just for completeness to ensure it doesn't go uncaught for every
> bio split caller.

So this is just from code inspection and you did not actually hit
such a case?

I'll see if I can add some sanity checking for the buffer and
preferably handle this outside the I/O path where error handling
for this doesn't really make sense.

