Return-Path: <linux-btrfs+bounces-18457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6ADC23EC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90A2189A4CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FFB326D61;
	Fri, 31 Oct 2025 08:53:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F353128BC;
	Fri, 31 Oct 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900783; cv=none; b=WqaIrRmRpGJwQIN5abAIhCMrg8/vVOyUezlgqnvM/PW5sLppFYJ23cA2wFhqFAQ34vtswNUfLkNgFtReimhTlYSyuc8K3Mj7GFXsZ2owyFetPLe5HZlZA3OAtb3nRunv3ZDoxtNI/K07HGI6fIwpRoGRv5LQvqhBIRqrVh2aNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900783; c=relaxed/simple;
	bh=fr+vWbl/yNKD2t0juswosWWBAt2JiYWHn7MONkRUCTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L06QjWGkN/5XgIo29Tu1ymzRdjsZUkT6skOq3EeAVApfzb+YZd4x784zIwh2RD3YebuACSocM1LjBT8j3r2lr/5Vdx/CuAm6YKq/oDRp9ByXnFt1o9AGedOFgj8HSQE9trGZ7vCGNV367sAoJQuL332owb1q6wPrJbkq3Opkhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 493C5227A88; Fri, 31 Oct 2025 09:52:58 +0100 (CET)
Date: Fri, 31 Oct 2025 09:52:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
Message-ID: <20251031085258.GA9041@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-9-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 03:13:02PM +0900, Damien Le Moal wrote:
> In preparation for using blkdev_get_zone_info() in upcoming file systems
> changes, also export this function as a GPL symbol.

As FYI I asked for this an plan to make use of this in XFS to unwind the
callbacks.  But I'd rather do that a merge window later to minimize
cross-tree dependencies.

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

