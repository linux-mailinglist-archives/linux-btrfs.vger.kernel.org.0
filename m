Return-Path: <linux-btrfs+bounces-12938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D6A83871
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 07:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDFB1B6599C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 05:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C01F09B2;
	Thu, 10 Apr 2025 05:34:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CA4D8C8
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263260; cv=none; b=ou0967PACxg/6IlXtzY7gTTVMI3GRFkXeuDjmeFf1uY1O3UOXLT5dJdKTejOxHf4CNLujdoo45lgeVkKGkgnCjFwphmPCXXUiqcFOxe2WMpzWOT3o7b0Nn/k/n538gVZWfD3Kn0tzMTTMj/WtI2cyWH/Y6S5GbUDmnAO/Q7+PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263260; c=relaxed/simple;
	bh=fHfJV+FoT4RWXFw1YqubGkx1zd78pVE4ydUQ0C0jm/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j46teS+xGEM78TjxUFdFIZTEdyqoTvVWUO5mbxZCOYw5ehenuL5AE70QVUlvq3YPlUVaHQj34gXu8rLPoBzo6zgtAd4iuFmzjdQ8EVuHxbpLJTOQwUYhrtUSzDtT8NQh4pdsNWJpz7weqeNNb9d+FoDhsFkmeSvbomG6HLwdoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D25B68BFE; Thu, 10 Apr 2025 07:34:13 +0200 (CEST)
Date: Thu, 10 Apr 2025 07:34:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/8] btrfs: store a kernel virtual address in struct
 sector_ptr
Message-ID: <20250410053413.GC30044@lst.de>
References: <20250409111055.3640328-1-hch@lst.de> <20250409111055.3640328-7-hch@lst.de> <0b3a6b18-ab19-4997-86dc-fd269b7b61da@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b3a6b18-ab19-4997-86dc-fd269b7b61da@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 08:04:25AM +0930, Qu Wenruo wrote:
> 在 2025/4/9 20:40, Christoph Hellwig 写道:
>> All data pointed to by struct sector_ptr is non-highmem kernel memory.
>> Simplify the code by using a void pointer instead of a page + offset
>> pair and dropping all the kmap calls.
>
> But the higher level bio from btrfs filemaps can have highmem pages.
>
> That's why we keep the kmap/kunmap.

Where do filemap pages come into the raid code?   As far as I can see
they are always copied, and the memory is only allocated in the raid
code.  As seen in this code we have two direct allocations that I
convered to __get_free_page, and one case that uses the bulk page
allocator where I use page_address.  Or did I miss something?

> Or is there a way to set the filemap to no use any highmem pages?

You can restrict the allocation of a mapping to avoid highmem using
mapping_set_gfp_mask().  But that would not help with direct I/O IFF
user pages came into this code.


