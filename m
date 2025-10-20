Return-Path: <linux-btrfs+bounces-18067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04378BF1FE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEB34C53B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A8124169A;
	Mon, 20 Oct 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtXFVIXa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0D23D7CA;
	Mon, 20 Oct 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972749; cv=none; b=DKBy7brPT7WN1EB619lU0nOmlapQUGZZOtKk+fUJJN2lZXrgTcHBlnbKzaej5xRLk3SOAqLSkOF7zlbw0Yf0b9Qq6eELyw9ElgABV2VeT+ITA7hA3b543kJHJcBGTZeGj9rXRoyoJRja9HABsl5X8MgxDkrJZmfbdTDZmvyR7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972749; c=relaxed/simple;
	bh=3EkXiAu/USmySeAhUp/jAk24XbuLM4uWOtER/AsXpGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUfyWm0oQ9CwKnpUFRegM1lp5H7O4gSTfPHstTkxypifs5AxLxI9vK84/1rGMjXb39T4A3EX24dNAlo9OEdAo2guDDnCEzNGp1kFcfLSjWN8IIotrXv9rPsN2vMcfAjPF5ITd3U8WHx59er6xltBCvi9L9joPOVdT4MJNx3hawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtXFVIXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C1DC4CEF9;
	Mon, 20 Oct 2025 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972748;
	bh=3EkXiAu/USmySeAhUp/jAk24XbuLM4uWOtER/AsXpGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtXFVIXau3tPhdNONmh25bbdxciMLbvWhNAzRgRGXuFOcj9m22/7vslNPfZSKkkGL
	 r+KT9ellKO2tMOv6O3zKC5AQj535riYz3SHAaqknCGmmWZkcmW1CMf6HaNz+3GaDpr
	 XY+hrainR/2buJSXMutWKKcq+EoD+JHzthT23Nk4UgBZEeJfF++EX/IgQngayAuS+W
	 qtRAdj8ay3q0+2KgBFdjpW7KFfMaTh+KjZ6jeLcWKUyRe/v7JF8qhzUZbvFU0ECxFO
	 53CBB+BsbsCyz8eOxdbz7ZTAD9qTvNjBzkwyHTYhXSa3fe3kiJDYHxASwsxWxv1Ovk
	 Py6a3fCAnLvLw==
Date: Mon, 20 Oct 2025 09:05:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, dsterba@suse.com, cem@kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] xfs: handle bio split errors during gc
Message-ID: <aPZPyme5tYvZc9GR@kbusch-mbp>
References: <20251020144356.693288-1-kbusch@meta.com>
 <20251020144522.GB30487@lst.de>
 <aPZNNkSOYr88-8VF@kbusch-mbp>
 <20251020145707.GA31743@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020145707.GA31743@lst.de>

On Mon, Oct 20, 2025 at 04:57:07PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 08:54:46AM -0600, Keith Busch wrote:
> > > Ugg, how?  If that actually happens we're toast, so we should find a
> > > way to ensure it does not happen.
> > 
> > You'd have to attempt sending an invalid bvec, like something that can't
> > DMA map because you have a byte aligned offset, or the total size is
> > smaller than the block device's.
> > 
> > Not that you're doing anything like that here. This condition should
> > never occur in this path because the bio vectors are all nicely aligned.
> > It's just for completeness to ensure it doesn't go uncaught for every
> > bio split caller.
> 
> So this is just from code inspection and you did not actually hit
> such a case?

Correct, no one actually hit such errors. Same is true for the btrfs
patch.

