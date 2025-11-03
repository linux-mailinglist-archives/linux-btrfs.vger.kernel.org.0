Return-Path: <linux-btrfs+bounces-18539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F75C2B0C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48E4034628B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C562FDC57;
	Mon,  3 Nov 2025 10:29:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4192FD7CD;
	Mon,  3 Nov 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165751; cv=none; b=rbs4+K8ECP9RZ9FDPlUii5aFeu8zmEYi+WvG5fBnwsUbDDGRcRmUwbbu12dpqhu9tZBORTa8fk7UAYmyLhejzBhWmRrHaVkAC6Yyuaa22CAAUa6+y/PJlbZ9kXwO9BRjAc7A2TEHBsPe1zDDAZAMeM0P25MMisDKDf1aIhBTOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165751; c=relaxed/simple;
	bh=I4KqhekOC9NkOER3DEkKtQI27ATsDdkIJj+jhStltPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtgMJzr5awnsag9+9ULA9sRFPxyQM0ziV0C3IOXRVonG2TM/nskMdBqjJATBkGSuHTboFZC9gEzxedAnks53BpOCHJAtG3CDzJV7frUZSzotzNAMMfHwERFEvl1KR2EDSZZbLyNnqz83iY7guoTynFPaCbLEcrsySi4QLh874IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C497E227A87; Mon,  3 Nov 2025 11:29:02 +0100 (CET)
Date: Mon, 3 Nov 2025 11:29:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
Message-ID: <20251103102902.GB8369@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-9-dlemoal@kernel.org> <42dc640b-28e9-4706-91dc-dd075e736065@acm.org> <1276e2be-4d8b-4c59-822c-3af4490de24e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276e2be-4d8b-4c59-822c-3af4490de24e@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 03:08:30PM +0900, Damien Le Moal wrote:
> On 11/1/25 06:40, Bart Van Assche wrote:
> >> +/**
> >> + * blkdev_get_zone_info - Get a zone information from cached data
> > 
> > "Get a zone information" -> "Get zone information"
> > 
> >> +	sector = sector & (~(zone_sectors - 1));
> > 
> > Please consider changing the above assignment into:
> > 
> > 	sector -= bdev_offset_from_zone_start(bdev, sector);
> 
> That is a lot more arithmetic for the same thing.
> If anything, I think this should be:
> 
> 	sector = ALIGN(sector, zone_sectors);

That would have to be ALIGN_DOWN I think.  Which sounds useful to
clean things up to me.


