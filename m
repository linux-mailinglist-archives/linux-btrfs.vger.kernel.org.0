Return-Path: <linux-btrfs+bounces-18526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF507C2A1BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 06:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB533B205F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 05:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D02951A7;
	Mon,  3 Nov 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkju2wnG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF248285CAE;
	Mon,  3 Nov 2025 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149327; cv=none; b=e+Jy6GqOU5Rk3uceJinisPjWFYkHtzTTbkIH+4pvg4NSzCLTowKJzxI533m3NwlrfYz94t9AI/pG9VSZ5xsYptJVzmZZemk63UxICB+9Ncc88yPjK/jMgAdhfViY1VhRbr5flXjAP6eWnkApr4+rbd9gRilRPMPIYNBQ36YxSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149327; c=relaxed/simple;
	bh=6LgEPdkotDiUC26z3hawBssMdC0Ec7mJ0QWs+Mou5lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d620GwxxOKLx5+YuXjk2q6fkiPj6fq7NWN8lry2idY/2owZNIirCBjwJ0uALggE3NbNxa02TcR8j4bfa3YotvMLGRfue+ybyzJuj3BrZvvujJe4ylRvrJGqAUPy3kqj5DPM9VigdUI+5Sg5e08RAVDHjzrfRWlEZY+9zIFz6pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkju2wnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C7CC4CEE7;
	Mon,  3 Nov 2025 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149326;
	bh=6LgEPdkotDiUC26z3hawBssMdC0Ec7mJ0QWs+Mou5lg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fkju2wnGMNeh+frH605RoGSCvt8OW3kANgUJV2wPQIt310Go8GP5F0WoIv4ukN2mM
	 DLe5vl55xqJ1CljTAM33OYU8Xya0oD4z4KA84VTMp6LNoCDKY0ad++WVn/rLkABk5c
	 I2wWsE7N21GY5cdnePjgj3KJFiO70mQlSZ/nTfbQcD4uVIfAlcelRzecci2TuyiU0u
	 A63n1+5axU1qIIk7VMf0qgRgSAyu/kMRMQSST6EgHgRkzxSrF37rsk9xE1VhyTDYee
	 d2ZrWFXDgc+UbeGLZuOlZMX8/Ls3+cABTyFgsEtr9pGTzN36bFgTO2NBHCtfsd00Yy
	 AjODKC0h8kSnw==
Message-ID: <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
Date: Mon, 3 Nov 2025 14:55:22 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-2-dlemoal@kernel.org>
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 02:48, Bart Van Assche wrote:
> Hi Damien,
> 
> disk_update_zone_resources() only has a single caller and just below the
> only call of this function the following code is present:
> 
> 	if (ret) {
> 		unsigned int memflags = blk_mq_freeze_queue(q);
> 
> 		disk_free_zone_resources(disk);
> 		blk_mq_unfreeze_queue(q, memflags);
> 	}
> 
> Shouldn't this code be moved into disk_update_zone_resources() such that
> error handling happens without unfreezing and refreezing the request
> queue?

Check the code again. disk_free_zone_resources() if the report zones callbacks
return an error, and in that case disk_update_zone_resources() is not called.
So having this call as it is cover all cases.

-- 
Damien Le Moal
Western Digital Research

