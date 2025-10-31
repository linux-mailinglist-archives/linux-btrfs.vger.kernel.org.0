Return-Path: <linux-btrfs+bounces-18452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD596C23E3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9EB406428
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B4313298;
	Fri, 31 Oct 2025 08:46:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BE2BEC32;
	Fri, 31 Oct 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900377; cv=none; b=kfYi/oDwdVVUztzGThDZQgzrwYznkxNP/3K955zlLW/A7O1EZw55p/lhribPlFPOOd/tdnX+4g5S1X152CtFdmzsAGjmtSwl5br3D9Ul1PHZMeA+CqPc8Jri0XsWQ9h5Ws3aaLZ9yZfW7OUa8It5xFW45d7RjIA2ui0dkNm/Bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900377; c=relaxed/simple;
	bh=83jF2LKTH+QGrQU93fDfCjaKXuNkXU1suK4uO/IeFQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2ACP8YBMBtn3ytIsos5yt9aLh+q/LaRWURRKlGnua/t1G4juJ7ArcsmBaLpSlW+Jtlx7wj7uirjwVT1kRLpwVlxODzVn+tTtaPyZNzdosmBZix4xsU35mv04Aa/DwfuoZ9KL8b3cWTIWno/vgZyaQCH8+8598X6kvOABg8P5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 654A5227A88; Fri, 31 Oct 2025 09:46:12 +0100 (CET)
Date: Fri, 31 Oct 2025 09:46:12 +0100
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
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
Message-ID: <20251031084612.GC8798@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 03:12:57PM +0900, Damien Le Moal wrote:
> The functions blk_zone_wplug_handle_reset_or_finish() and
> blk_zone_wplug_handle_reset_all() both modify the zone write pointer
> offset of zone write plugs that are the target of a reset, reset all or
> finish zone management operation. However, these functions do this
> modification before the BIO is executed. So if the zone operation fails,
> the modified zone write pointer offsets become invalid.
> 
> Avoid this by modifying the zone write pointer offset of a zone write
> plug that is the target of a zone management operation when the
> operation completes. To do so, modify blk_zone_bio_endio() to call the
> new function blk_zone_mgmt_bio_endio() which in turn calls the functions
> blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
> blk_zone_finish_bio_endio() depending on the operation of the completed
> BIO, to modify a zone write plug write pointer offset accordingly.
> These functions are called only if the BIO execution was successful.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Should this have a fixes tag and move to the start of the series?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


