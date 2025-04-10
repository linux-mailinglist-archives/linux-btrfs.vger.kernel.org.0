Return-Path: <linux-btrfs+bounces-12936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FAA83867
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 07:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C42B1B6572B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 05:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A31F09AD;
	Thu, 10 Apr 2025 05:30:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EDF510
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263045; cv=none; b=EKy4JO9MhsyjiSaT+mhfzR2vnA7dY1WIzC4JiaKcAdbZ1K18UXf8C9WFoitS4XUgMBzwUhXM4sXFk6ifw5WFs58/BVDl5iHQmB7L6k7IrIO5xPQ9+23iUEQtoaQlaZlLcY1V4MTtJ1U+5q5LoI+QJk4lIDeaMVm03FqmxLGHJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263045; c=relaxed/simple;
	bh=d56WytdpPVHbXfwoqTEiAOz8enteYQUSwY89YvAuLIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ1B5AOY/D2ZgldGTOuIfxKcxP36rVADRFeYdypxrW6G8QdFcywm07sUxS2w2EDZm7JmbpEsSg7Fdlq0iQdnOhO3epO68fnIHC3K5CAz3cb/t/G6MEjRcFK+xvsGDgq+ld7rSZ97+w6ooO0u/SKMt6AfetUWOcpdBFhMvshfMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70ABE68BFE; Thu, 10 Apr 2025 07:30:36 +0200 (CEST)
Date: Thu, 10 Apr 2025 07:30:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] btrfs: remove the alignment checks in
 end_bbio_data_read
Message-ID: <20250410053036.GA30044@lst.de>
References: <20250409111055.3640328-1-hch@lst.de> <20250409111055.3640328-2-hch@lst.de> <d0f52e89-1bd2-4a06-b142-1e18381862b6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f52e89-1bd2-4a06-b142-1e18381862b6@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 07:43:54AM +0930, Qu Wenruo wrote:
> The old comment indeed is incorrect, but can we still leave an ASSERT()
> just in case to case any unaligned submission?
>
> It shouldn't cause anything different for end users, but should greatly
> improve the life of quality for developers.

What is is trying to check for? fi.offset isn't really a meaningful value
to check for as it's just an offset into the folio.  bi_sector would be
useful, but it's not owned by the file system after the bio was submitted.
Maybe adding that assert to the submission path would make sense?  Remember
that the bio completed is exactly the one submitted by the file system,
and cloned split bio never reaches back into the file systems.


