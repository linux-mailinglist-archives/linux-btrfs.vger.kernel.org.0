Return-Path: <linux-btrfs+bounces-18650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D5C30DC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 13:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1295423733
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337F2ECE8D;
	Tue,  4 Nov 2025 12:03:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BC2E3373;
	Tue,  4 Nov 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257796; cv=none; b=aow9LAiknrbEPDyqf9BtndFGtGwaNHNUVlFMItVZ16L+I5HijmxLLPkxdYGfunBgFM+QDtiiwkaGTQZA/19eVlEi+qsallHuzPNDOuTX/nDd47Ykv4IwYtfd5UEhEb5kpXBHHvAmVViji3ZWBWQyEM5+L7c2BSavXbr40oDcGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257796; c=relaxed/simple;
	bh=QS40qdRp3eQcP2yb01uL6R/pw61ly5auhn8DQ2oVhbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixqWDPV83oE76DNFow1S8MGPbZ3J5zXq47rt1sSn/smegodm3HjLm9R9NJKvwBTk1Mn6yILTRVOn+Y/5mlxU15QoVfWUjp/IeI5JKkbX5TZlSGwQST2fgLseFqtkeZ10TApUQmkS7eQ3/VACp+Ab7qVa53QUKnhOIeynW4wRHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA5B6227A88; Tue,  4 Nov 2025 13:03:09 +0100 (CET)
Date: Tue, 4 Nov 2025 13:03:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	David Sterba <dsterba@suse.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 07/13] block: track zone conditions
Message-ID: <20251104120309.GA16283@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-8-dlemoal@kernel.org> <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org> <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org> <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org> <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com> <83b60505-64a4-40fe-aa50-02a56ca7ad8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b60505-64a4-40fe-aa50-02a56ca7ad8c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 04, 2025 at 07:53:07AM +0900, Damien Le Moal wrote:
> > In case current file systems store this, isn't that a code duplication for each
> > fs ? perhaps having a central interface at block layer should help remove the
> > code duplication ?
> 
> catch 22: You cannot ask the file system without first knowing the zone layout
> and conditions of zone to check the file system metadata.

The file system also really needs to verify that it's view matches the
hardware view at mount time, otherwise you'll run into really nasty
cases later when they are out of sync due to a bug or corruption.


