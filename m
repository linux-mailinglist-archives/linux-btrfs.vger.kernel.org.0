Return-Path: <linux-btrfs+bounces-18468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C914C2639F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 17:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC3AD34DE88
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899712FD697;
	Fri, 31 Oct 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qxm8g8rb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD02F6590;
	Fri, 31 Oct 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929554; cv=none; b=pbdx6BpjPlrAEoW1Ykvjmsk1ZA0J9rvwn8G5ce8SRJIN/AjdbNXLawOqRXY2U2fQLwQrhDPo43CD0D0etzE+yCnu6pC83c8F/JhRS5fcKywSYnJh/9e+zkP8JyU+0Pmw7mjczIkutBs7pZzVdadvwz++xaUkM2INhrd4hTwkMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929554; c=relaxed/simple;
	bh=1N3fdJ2B+fMkIlCdu5Zd5AwLY7LihNq+dC6S4re75do=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pHJ0WP13xuoifUHbHc+ANR1B53EuI3/CMC3Qwfy6mjybN9ybU9eAKI5x8fakLUuPWNGhxAY7H4NXeYEmsagm6162dmlMExjZuTR+aUMJ7uXWYzf/s0rVqVGbZ558Vua+afqtdzE2s6nyTxHfD96CHLU3YAxDYExI+ht11hGN/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qxm8g8rb; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyn8V5C4lzm0pKc;
	Fri, 31 Oct 2025 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761929544; x=1764521545; bh=R/OEKut8Bh5NEjnT73fa64w+
	0NdKfKaDZ37ZcX9yBBE=; b=Qxm8g8rbfACqduG6mzsKiZcY5peLYhA5r68hfeuF
	npeC2F7MrPHfRCE2dgdI/VpN9Z6Hg0odL8mTXTU6q/aItJVUsc2yuLcoSKChIa3J
	CYZK7JejpVEKTgh6SS/QaCBg90QG8UIrv50QzRgeI+pEkrppligx7C1qjj2QKFH2
	9azdHnrqY2mKi3qwnrbyTRK8MiFp0837mT7ieCSNzn0Rb7Y4xkf0350AH8m56CC8
	mNCZM/Quc8W0QsSqNcGubULzysAB7Hpc5bSnTIbMmsQJ7auKE5fPqVUNu+QzToI4
	CCBV+h74m5k7iF9/sRnUJO02LHBBzHdocpCu7aVdgsG0Lw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Wp5YOSWbUGra; Fri, 31 Oct 2025 16:52:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyn8F2n2rzm0pK1;
	Fri, 31 Oct 2025 16:52:11 +0000 (UTC)
Message-ID: <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org>
Date: Fri, 31 Oct 2025 09:52:10 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] block: introduce BLKREPORTZONESV2 ioctl
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-11-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-11-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
> field of struct blk_zone_report also as an inpiut. If as an input, the

inpiut -> input

>   /*
> - * BLKREPORTZONE ioctl processing.
> + * Mask of valid input flags for BLKREPORTZONEV2 ioctl.
> + */
> +#define BLK_ZONE_REPV2_INPUT_FLAGS	(BLK_ZONE_REP_CACHED)

Parentheses are not needed here - the definition of BLK_ZONE_REP_CACHED
should include parentheses if necessary.

> +	case BLKREPORTZONEV2:
> +		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
> +			return -EINVAL;

-EINVAL probably should be changed into something that indicates "not
supported" rather than "invalid argument"?

> index dab5d9700898..1441d79a6173 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -82,10 +82,20 @@ enum blk_zone_cond {
>   /**
>    * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>    *
> - * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
> + * @BLK_ZONE_REP_CAPACITY: Output only. Indicates that zone descriptors in a
> + *			   zone report have a valid capacity field.
> + * @BLK_ZONE_REP_CACHED: Input only. Indicates that the zone report should be
> + *			 generated using cached zone information. In this case,
> + *			 the implicit open, explicit open and closed zone
> + *			 conditions are all reported with the
> + *			 BLK_ZONE_COND_ACTIVE condition.
>    */
>   enum blk_zone_report_flags {
> +	/* Output flags */
>   	BLK_ZONE_REP_CAPACITY	= (1 << 0),
> +
> +	/* Input flags */
> +	BLK_ZONE_REP_CACHED	= (1 << 31),
>   };

Why 1 << 31 instead of 1 << 1?

Otherwise this patch looks good to me.

Thanks,

Bart.

