Return-Path: <linux-btrfs+bounces-18538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAE0C2B072
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 11:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0F9A4E7E5F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3F2FDC38;
	Mon,  3 Nov 2025 10:24:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F32FBE05;
	Mon,  3 Nov 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165447; cv=none; b=jf5R6iVb/+ac4YSq2+BbPCdcoil1PGCZ+6X14BF+hGpDX2dv2Jmhorp9DoaAgXwMzip9MOZEx7JXGecHhosKXx/iSmi8qJi3Xl+iE6VCIujaPbh2tpTfs14cVOa/S0kuw/O7c+BKTo9g+fUg0kHNaEw6wfSBskKsWRmFUyYZ7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165447; c=relaxed/simple;
	bh=FUZCd+virfGdLoGaRbAkHyz7ciacsYkUIKqwaUx+xcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGUFfW24RetZWp2Hq74PhPF8gYRzb2pzQPfJ+1roJiTQtmz1rjUkRDDKFqXamNm0T1V2A70cu+moQdE80NqO7CpAUXk9ISmG/daHB8AJzGaoE7b0weGX6FdCr0nLM8VcubRzeae3IwLuj6gC7Cu5ce7c7wkSgDxz4PZ0ls3KKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D03C227A88; Mon,  3 Nov 2025 11:24:00 +0100 (CET)
Date: Mon, 3 Nov 2025 11:23:59 +0100
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
Subject: Re: [PATCH 10/13] block: introduce BLKREPORTZONESV2 ioctl
Message-ID: <20251103102359.GA8369@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-11-dlemoal@kernel.org> <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org> <b675e291-c369-4c7e-8fa2-1470ce90f001@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b675e291-c369-4c7e-8fa2-1470ce90f001@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 02:51:57PM +0900, Damien Le Moal wrote:
> On 11/1/25 01:52, Bart Van Assche wrote:
> >> +	case BLKREPORTZONEV2:
> >> +		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
> >> +			return -EINVAL;
> > 
> > -EINVAL probably should be changed into something that indicates "not
> > supported" rather than "invalid argument"?
> 
> Not supported could be confused with the cached report zones not being
> supported. It is, but the user cannot specify input flags that are not defined.

Yes.

> This is to ensure that undefined flags are always 0 and that we can use these
> going forward when we need to define a new flag.
> So EINVAL seems appropriate to me.

Using EINVAL here is consistent with other APIs, but a bit of an
anti-feature.  Not sure what another good more specific error code
would be, but given that we don't have other major EINVAL conditions
we might as well stick to it.

> >> +	/* Input flags */
> >> +	BLK_ZONE_REP_CACHED	= (1 << 31),
> >>   };
> > 
> > Why 1 << 31 instead of 1 << 1?
> 
> Why not ? That separates input and output flags instead of mixing them in
> tighter definition.

Agreed.  Thinking about it, once you go up to bit 31 all of them
should be marked unsigned, though, i.e.,

	....			= (1U << bitnr),


