Return-Path: <linux-btrfs+bounces-12937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E945A8386A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 07:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DDF1B6584E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 05:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F761F098F;
	Thu, 10 Apr 2025 05:31:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1831917F4
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263095; cv=none; b=T4n2lZT8+hhGZ/m+1uRWy4koGyR8AbaRb8FQ/3sbHOmcJ/fIAo4Rb8AIMhrekqGtxB3BfJjCz005sZMyRbLgejILfQk1n221ians8S5+W/YxpHMUsAPFVM7r8Ucow206l/awoXdnC1Qe+C6Yy32hQ6sn/h80cCGMLC0h5WReW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263095; c=relaxed/simple;
	bh=7nURtJXmG5+QhahbgLXiFaVh8aLsTWCbPIKMJ0mSEV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8iLjc5Zng3Vvc27Di2mpjDELy4mQTKPqnKOAZP9q2lmJAgyz/nUZKLCoQ1jyYLZa841I8sRRH/ElQN/1r6JoGY9qVe8PazYfel9lKcb6Xzpa5PO/bbRf4rbC6fOgO1yKR+hy9T7/kMYPxavGmtHZ9JnAi/3LQy8fcGUb1IwKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0343D68BFE; Thu, 10 Apr 2025 07:31:28 +0200 (CEST)
Date: Thu, 10 Apr 2025 07:31:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/8] btrfs: pass a physical address to
 btrfs_repair_io_failure
Message-ID: <20250410053127.GB30044@lst.de>
References: <20250409111055.3640328-1-hch@lst.de> <20250409111055.3640328-4-hch@lst.de> <8f2a68bf-8883-4d6a-a756-eacd18022a7d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2a68bf-8883-4d6a-a756-eacd18022a7d@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 07:49:30AM +0930, Qu Wenruo wrote:
>>   		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
>>   				  repair_bbio->file_offset, fs_info->sectorsize,
>>   				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
>> -				  page_folio(bv->bv_page), bv->bv_offset, mirror);
>> +				  bvec_phys(bv), mirror);
>
> Just one concern, this is highmem safe?
>
> If it's highmem safe, I'm pretty happy to go the single physical address 
> way instead of folio/page + offset.
>
> That's way more convenient to handle block size < page size cases.

Physicall addresses and thus bvec_phys work perfectly fine for highmem.
That's why I did that here instead of the more obvious virtual address.


