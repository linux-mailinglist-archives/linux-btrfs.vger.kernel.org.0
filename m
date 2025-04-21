Return-Path: <linux-btrfs+bounces-13192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAABA9505F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA037A7B18
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43A264609;
	Mon, 21 Apr 2025 11:44:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7E20E01E;
	Mon, 21 Apr 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235863; cv=none; b=ZiLqT1or11sFesAvFEdhC2rvXfErYKIhlfjUaw9P6fb7SOYYi+Wj8nkySJ2nHQFi/i3WHWz+7+TJHdDBILxKLvQsdzVLcQpyVD2my4cSOvyMeoQD9GPmBA9I624PFrb/npquOPNg8QMvbNtQZhFF7gKLRQ9yOYHoHfY5gS5kKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235863; c=relaxed/simple;
	bh=SmTPx3Hdu6a/3m/MxfhysVzBTkXdppcBGKiMgdSrsVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss4723ihoXbrBCrcI8IU1eJdmtu9IJFM+2EMN0yL90q7Ak1MXVjKDYQN089kEwEDY9XSfRK4Ni97G0Wxaev5+snNf1+0bNk1G0FmNofHg9y5DWSdNgNG+AmLU6GCqc2s69jpdYWZOvSgKh7W4dIFQjETk+q/UDVD8TZBLmL1yL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6624E68AFE; Mon, 21 Apr 2025 13:44:16 +0200 (CEST)
Date: Mon, 21 Apr 2025 13:44:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/8] btrfs: raid56: store a physical address in
 structure sector_ptr
Message-ID: <20250421114416.GA23431@lst.de>
References: <cover.1745024799.git.wqu@suse.com> <03dbeaa8ac424885402a6590e393a15d5ae67c82.1745024799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dbeaa8ac424885402a6590e393a15d5ae67c82.1745024799.git.wqu@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Apr 19, 2025 at 04:47:13PM +0930, Qu Wenruo wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [ Use physical addresses instead to handle highmem. ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I think you should take full credit and authorship here as this is quite
different from what I posted.

The changes look good to me, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>

