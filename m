Return-Path: <linux-btrfs+bounces-18566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F57C2C3AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A43451C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A8275AEB;
	Mon,  3 Nov 2025 13:46:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574E1946C8;
	Mon,  3 Nov 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177604; cv=none; b=ooQ8bosWci1XQxe0QgoNxc2lOPaMKmiKeTILL2XpkUn+pvKrZThZcMZTnPDx4qAJDKdLNgDpQWeq+15LwcoHKfMGDL/IWh0W6JalcrXPqVHOlTaDLXUMszlyXCiPSiTmbXyZVnAZIpJahHjE0jDT1BkfySgLA1zb4kPE+qihoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177604; c=relaxed/simple;
	bh=R3c3VoyXxv+yIE4Z1qhuL8CmP/vDMOZ0RfOmwCVkqJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk1TLB/L2oiPCTs4sdtfFt/VPy0MKvMW+NlGpV5aSBaqhbE+W4Q7AxFVZUGJzWF5W5kyKCbB4PkhMETAqLMakL095r3MX98OPFI3h6hvwTuSMgdlTga5uR6YgYTBX8luT67GMmNCbtSUAqAb6kPX7I3Wy+MHG9+745aHGu6z4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55C98227AAA; Mon,  3 Nov 2025 14:46:37 +0100 (CET)
Date: Mon, 3 Nov 2025 14:46:36 +0100
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
Subject: Re: [PATCH v2 02/15] block: freeze queue when updating zone
 resources
Message-ID: <20251103134636.GA25126@lst.de>
References: <20251103133123.645038-1-dlemoal@kernel.org> <20251103133123.645038-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103133123.645038-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 10:31:10PM +0900, Damien Le Moal wrote:
> Modify disk_update_zone_resources() to freeze the device queue before
> updating the number of zones, zone capacity and other zone related
> resources. The locking order resulting from the call to
> queue_limits_commit_update_frozen() is preserved, that is, the queue
> limits lock is first taken by calling queue_limits_start_update() before
> freezing the queue, and the queue is unfrozen after executing
> queue_limits_commit_update(), which replaces the call to
> queue_limits_commit_update_frozen().
> 
> This change ensures that there are no in-flights I/Os when the zone
> resources are updated due to a zone revalidation. In case of error when
> the limits are applied, directly call disk_free_zone_resources() from
> disk_update_zone_resources() while the disk queue is still frozen to
> avoid needing to freeze & unfreeze the queue again in
> blk_revalidate_disk_zones(), thus simplifying that function code a
> little.
> 
> Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


