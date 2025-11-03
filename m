Return-Path: <linux-btrfs+bounces-18549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4ACC2BFAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB83BFBEF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DB3112C4;
	Mon,  3 Nov 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfzuyc0w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4630308F0A;
	Mon,  3 Nov 2025 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174794; cv=none; b=fLP31nl57cnQbZgOL/E9WExW58JtGPnO32Lu4iOoUzsb/hIouDpO5L31vlWMN++1epCvPMgB5ZXMdVxs2UgufK6BYZEDSbbiwtemDOQLFVTnogogLuOWAQJ0Acm0AIqssi+Qu1stCy2u+Nnbu0xBW3AIBrYYTbgoUHWok8OSL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174794; c=relaxed/simple;
	bh=mg14JfajU5W0qY3xKlC1LzugPqDhaogBLa+MoPCu9po=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cat0t2zspx+mDnpH/nH8Rl4euS3z+6bYz0Aj0pCHq5b8ltnlN+rqcmEE3tJmKrcFQqJukdN4QysJ2hlQ+J8Z2HyoKWlw2WhNh0WIN0z5EiZHRC4UgtUgOv9BJVlaoxhj2aOSxGesT1nQ+IdAwinZVuaawQ+aqFJmUMKLcY6Y5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfzuyc0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC8C4CEE7;
	Mon,  3 Nov 2025 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174794;
	bh=mg14JfajU5W0qY3xKlC1LzugPqDhaogBLa+MoPCu9po=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Tfzuyc0w0PG8B9qeo4EY1e6oWHR35RGpaPLMhqntB/ik1LckO74VHTfp82JdQfC9k
	 0XUUezUYERCKbPcEpQY508qcq5lLukAr+xy/HgvMMnFHFrhxq+AwL0mtcl8g3ynIYb
	 FsW8Nr3O/XJikCmQBNqdHGt7OEq0tEcBuNdvdKHO7YvkkFHuIcD0/uRGGFqYSqR9u1
	 Pd7ZRjdZfeTJpyRPVCSwWFC4B9ujnv6yxK+/mq21WfNfEkreGE0imhdNkpA+pHbXy/
	 TECb2JVsfxse8iQFM6majHDvwTu6aCy7dgtulG1U5hG4HAxVR6J6cFHyAK4kOVvqY9
	 uSZasy7Ak7n8g==
Message-ID: <32f2f32a-eafd-43ef-a599-fc4784fdf492@kernel.org>
Date: Mon, 3 Nov 2025 21:59:49 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-4-dlemoal@kernel.org>
 <8947e877-cd53-4f1d-989c-bdde311c00e9@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8947e877-cd53-4f1d-989c-bdde311c00e9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 20:41, Hannes Reinecke wrote:
> On 10/31/25 07:12, Damien Le Moal wrote:
>> The functions blk_zone_wplug_handle_reset_or_finish() and
>> blk_zone_wplug_handle_reset_all() both modify the zone write pointer
>> offset of zone write plugs that are the target of a reset, reset all or
>> finish zone management operation. However, these functions do this
>> modification before the BIO is executed. So if the zone operation fails,
>> the modified zone write pointer offsets become invalid.
>>
>> Avoid this by modifying the zone write pointer offset of a zone write
>> plug that is the target of a zone management operation when the
>> operation completes. To do so, modify blk_zone_bio_endio() to call the
>> new function blk_zone_mgmt_bio_endio() which in turn calls the functions
>> blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
>> blk_zone_finish_bio_endio() depending on the operation of the completed
>> BIO, to modify a zone write plug write pointer offset accordingly.
>> These functions are called only if the BIO execution was successful.
>>
> Hmm.
> Question remains: what _is_ the status of a write pointer once a
> zone management operation is in flight?

On the device, it will be unchanged until the command completes, or rather, one
can only see it that way since the drive will serialize such command with report
zones.

> I would argue it's turning into a Schroedinger state, and so we
> cannot make any assumptions here.

Let me try to skin that cat below :)

> In particular we cannot issue any other write I/O to that zone once
> the operation is in flight, and so it becomes meaningless if we set
> the write pointer before or after the zone operation.
> Once the operation fails we have to issue a 'report write pointer'
> command anyway as I'd be surprised if we could assume that a failure
> in a zone management command would leave the write pointer unmodified.
> So I would assume that zone write plugging already blocks the zone
> while an zone management command is in flight.
> But if it does, why do we need this patch?

There is no such "blocking" done, the user is free to issue a zone reset while
writes are n flight, and most likely get write errors as a result such bad practice.

For this patch, the assumption is that a failed zone reset or zone finish leaves
the zone write pointer untouched. All the drives I know do that. So it is better
to not modify the zone write plug write pointer offset until we complete the
command.

But granted, that is not always true since the failure may happen *after* the
drive completed the command (e.g. the HBA loses the connection with the drive
before signaling the completion or something like that). In such case, it would
not matter when the update is done. And for zone reset all commands, all bets
are off since the command may fail half-way through all the zones that need a reset.

But in the end, logically speaking, it makes more sense to update things when we
get a success result instead of assuming we will always succeed. This has also
the benefit of leaving the zone write plugs in place for eventual error recovery
if needed.

-- 
Damien Le Moal
Western Digital Research

