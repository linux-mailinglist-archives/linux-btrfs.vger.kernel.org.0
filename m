Return-Path: <linux-btrfs+bounces-18091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBABF4A4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 07:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C64E39E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159372571AD;
	Tue, 21 Oct 2025 05:28:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0A339A8;
	Tue, 21 Oct 2025 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024536; cv=none; b=n6CHEKNkbDVHLO0MfwhEgVbPOhMTiBw0gO4HWPS0/5rwxB+CHJ6jdtMDHqHTRmsnw8tVIJppC0/pqIputu/zTJGQBwg5An2M9DyaZGuyKW1ioWs0wjXrMEeqaL8x0zXbyKGV65v7gQdBHaxG9V6M8u1+fpfDy6A3sN77VyladM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024536; c=relaxed/simple;
	bh=6APbdJsXA3vsT7ic253mk3XrYAH/gXJmYIUHlFUOf+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnv4RCLmTR16Nq9bWM+yvOLBSUemcyBjrvL1bMSffZ0m17SFFDd2hHYogptbIoU0w6wX88MNnn0bLT2XYUzd4AFstACJev7M5FThthVYPK0tJtJUEyuOztz+HQ31lXzpRs8gq3JuVm+0r9L38Hj09lbeXC5m+sqbmWcWS29r0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02C79227A87; Tue, 21 Oct 2025 07:28:48 +0200 (CEST)
Date: Tue, 21 Oct 2025 07:28:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@meta.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, dsterba@suse.com, cem@kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] xfs: handle bio split errors during gc
Message-ID: <20251021052848.GA29451@lst.de>
References: <20251020144356.693288-1-kbusch@meta.com> <20251020144522.GB30487@lst.de> <aPZNNkSOYr88-8VF@kbusch-mbp> <20251020145707.GA31743@lst.de> <7e4dcafb-80ce-458c-a7d1-520222275cd9@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e4dcafb-80ce-458c-a7d1-520222275cd9@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 11:16:57AM -0400, Chris Mason wrote:
> On 10/20/25 10:57 AM, Christoph Hellwig wrote:
> > On Mon, Oct 20, 2025 at 08:54:46AM -0600, Keith Busch wrote:
> >>> Ugg, how?  If that actually happens we're toast, so we should find a
> >>> way to ensure it does not happen.
> >>
> >> You'd have to attempt sending an invalid bvec, like something that can't
> >> DMA map because you have a byte aligned offset, or the total size is
> >> smaller than the block device's.
> >>
> >> Not that you're doing anything like that here. This condition should
> >> never occur in this path because the bio vectors are all nicely aligned.
> >> It's just for completeness to ensure it doesn't go uncaught for every
> >> bio split caller.
> > 
> > So this is just from code inspection and you did not actually hit
> > such a case?
> 
> This is from me testing out AI reviews on linux-next, and they do love
> suggesting defensive programming a little too much.  I'd be happier
> with EIOs in this case but agree it's probably never going to happen.

It would be relaly useful to note in the patches if something was
found by code analys or testing and what tools are used.


