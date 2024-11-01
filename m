Return-Path: <linux-btrfs+bounces-9286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48F9B8AA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57BF1F216A2
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46314B955;
	Fri,  1 Nov 2024 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l86vyP9g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0414A4C6;
	Fri,  1 Nov 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439273; cv=none; b=i/BtGiDd44zCVSdXg7gAIe/2jijJNTjD2/ZF0hN7JYPU+m8CnXceU4v46lkiAuIqDTZ7FhhwbcCRCy5MozjDnxJ95poFA6auBpmlPoV4ndRWg0CbyMNDQ93v3VqrJN3N2pRUIyGqpiwibeS96BtSfslx8V39XcNqgxg2kZefT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439273; c=relaxed/simple;
	bh=wgLvzcsYWd5pdxhNxs+0A/6mIrFsEw2ggcJ2Zd28IP4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uLhNwZdl9bJHiCv/cgEqWCwow/ClJGNvoeIyoW6ZfJt8Zvf6NxK1u9THX/3eeA2wcbTHS5RxCvHlOxKHEiLU0c9CESp1sb3ni2issHFo8sOOvccJh2tkkwpTClHEdY/iD0WkYnll0Qgv6ZN9eh75eQmI5fq/P12Ch67fZLuSdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l86vyP9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B3CC4CECD;
	Fri,  1 Nov 2024 05:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730439273;
	bh=wgLvzcsYWd5pdxhNxs+0A/6mIrFsEw2ggcJ2Zd28IP4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=l86vyP9gTebKEP+awPKmAWW6TwIERtU8GTILBCWavHO0UtqsXAU9+FWIkzP2fFhE6
	 6OFifmDnGDSGv3HR5aH18yb/NfJ3SGArvCJO/RehHaDWlt6b7X512/g7/glBGT9qQL
	 xFRPCrPZ0GYGI2o3xWqPsn7E3fmUQZHd17jGP6dxey2i0b43cpiGXMLNIHILznGCsP
	 HVsa5Pc7JRUUMZYr2VwXQsppsWUrPFdNqiWuVBQTT5yepPZCxN2fM4v1nGhWyC3pAP
	 Xm84rrehBJNoUFaRUUF86BiNowmbCIKDyOPPYh1xwbjwWUHYL4ILLC3KJA4Dm5n+60
	 6W6bCNWeXYBjw==
Message-ID: <a7b87e01-045e-423e-854d-4707f9102c75@kernel.org>
Date: Fri, 1 Nov 2024 14:34:31 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/4] block: fix bio_split_rw_at to take
 zone_write_granularity into account
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-2-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241101052206.437530-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 14:21, Christoph Hellwig wrote:
> Otherwise it can create unaligned writes on zoned devices.
> 
> Fixes: a805a4fa4fa3 ("block: introduce zone_write_granularity limit")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index d813d799cee7..d6895859a2fb 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -358,7 +358,8 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	 * split size so that each bio is properly block size aligned, even if
>  	 * we do not use the full hardware limits.
>  	 */
> -	bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
> +	bytes = ALIGN_DOWN(bytes, lim->zone_write_granularity ?
> +			lim->zone_write_granularity : lim->logical_block_size);

Nit: we could also do:

	bytes = ALIGN_DOWN(bytes,
		max(lim->logical_block_size, lim->zone_write_granularity));

Also, I wonder if we should leave read split as is based on the logical block
size only ? Probably does not matter much...

>  
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync


-- 
Damien Le Moal
Western Digital Research

