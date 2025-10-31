Return-Path: <linux-btrfs+bounces-18456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC9C23E9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C74D188A8B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66331A056;
	Fri, 31 Oct 2025 08:51:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5A2F360C;
	Fri, 31 Oct 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900705; cv=none; b=YYZ0sXbUenwmOKc/AXTrtI1uAGf6jBnctbFUubEZNtdI/25B77HaS8nvleQmMYhjp+OltIkRYhT/0ZbgKcWJKh3dZlGdHfspc+mYMaIYkfcULdGbpjBShLIIYm0ldADUziZpEKDQiYfWVzvGxTzRo5h8oHt0EfurJAfWG2X+EwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900705; c=relaxed/simple;
	bh=jSryC8evZeUw5B135iJkzvYd083iU7jxZ90urxpLJUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRF1eD0h2/ZE1GEtoh5LKN1Tdg8nw7MpjbBw80cySB3ed7goFOKB6St+2ABvocEKzBKjK7yVYOWeRbpLvNOGzufvHgprsnK1FGQg7sjQUsFXJ24c3eatyFRDWmYnpYh7Mpiq43WMjl1P9M4hZfK1d7nn20JE/AHiO1WXmTSFHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F502227A88; Fri, 31 Oct 2025 09:51:39 +0100 (CET)
Date: Fri, 31 Oct 2025 09:51:39 +0100
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
Subject: Re: [PATCH 07/13] block: track zone conditions
Message-ID: <20251031085139.GG8798@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-8-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 03:13:01PM +0900, Damien Le Moal wrote:
> The function blk_revalidate_zone_cond() already cache the condition of

s/cache/caches/ ?


> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index f85743ef6e7d..dab5d9700898 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -61,6 +61,10 @@ enum blk_zone_type {
>   *
>   * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
>   * be considered invalid.
> + *
> + * The condition BLK_ZONE_COND_ACTIVE is used to represent any of the
> + * BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN and BLK_ZONE_COND_CLOSED
> + * conditions.

Maybe explain a bit more that this is only seen for cached reports, and
in that case the two open states and closed won't ever be seen, i.e.
that they are mutually exclusive?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

