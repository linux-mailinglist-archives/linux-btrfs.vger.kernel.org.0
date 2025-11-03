Return-Path: <linux-btrfs+bounces-18593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C6C2DB1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 19:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F65C4EFB81
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCCE302776;
	Mon,  3 Nov 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3Wd6znBU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFB43147;
	Mon,  3 Nov 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194724; cv=none; b=b56QXwk7s/O/rS8ZVTwMO9WWIPju5q0XVZrpo8Fnko3XF/DWUixMRNPGKE9tFrP8sW6gV6E6caaQj8etJJUqB/0inWZAUTwo+VUeKqJAggPcrixPTdrqkaB5j4pGb6EjqfMCGVaozkNNzeUGxcb3uKNccnCtCl16sCXzf5OmvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194724; c=relaxed/simple;
	bh=caIo3tGjRNJ9LhlUpDKcLjz1HspYMqFtn6HUaCsClVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QMyk8XFATJgPkKFg0SHKCwNtCAaHq/iFcequ1yDOxokxEsQ3ITNBuQ9AdRQAl+9O8YW8jgmSUURALNI2eM1drF4/kCi0lcvymc6fpfwAFG+6qBq3/RnULjBb0hkvQosjlFORPMnQkcC+11zreHSZdNPyvdKuT/zfsqhVwc0wgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3Wd6znBU; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d0gD147QZzmQQpT;
	Mon,  3 Nov 2025 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762194718; x=1764786719; bh=LZJml/qUOYUxSf7YMBAn3UuQ
	CViaS2F+0XfsjOVP9Ic=; b=3Wd6znBUTNnv5oLWu0Z6ZGjHVwTIPDE0VfFHMiAH
	IlPWZ01eXCuohryCC6xfn/qUY3c8LKulFybRi/hNBut5nOtH4uxj7WSkg/TTXkSg
	Zep+CJgvwBue1DWnPdT/hJCgQrUGGuA2CpC4gJWwhHUifr58OpbZeCjYodl96ZF+
	dFTMRTrXTe+oR4IqG3wrbCzvYpbVYTIYEk/Kqd/FOeqo5Tn66NSb+xKg3Ntycvf5
	xjqm29tRGuQPoCNVAt2drUtBjZZiXk40WIiTWyuc930gIMsbHrpxhQvRRZPvaFIx
	2gvH8ivseCYB9U6X4LgUzP3MJzwUXl9xuBFBWigPvuR/VA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ge3e0dOQZCba; Mon,  3 Nov 2025 18:31:58 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d0gCh59kPzmLwyn;
	Mon,  3 Nov 2025 18:31:43 +0000 (UTC)
Message-ID: <28a8b421-1c5f-400f-b890-62ebc7d74e88@acm.org>
Date: Mon, 3 Nov 2025 10:31:42 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
From: Bart Van Assche <bvanassche@acm.org>
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
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
 <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Content-Language: en-US
In-Reply-To: <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 7:48 AM, Bart Van Assche wrote:
> On 11/2/25 10:05 PM, Damien Le Moal wrote:
>> On 11/1/25 06:17, Bart Van Assche wrote:
>>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>>> Implement tracking of the runtime changes to zone conditions using
>>>> the new cond field in struct blk_zone_wplug. The size of this structure
>>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>>> end of the structure. For zones that do not have a zone write plug, the
>>>> zones_cond array of a disk is used to track changes to zone conditions,
>>>> e.g. when a zone reset, reset all or finish operation is executed.
>>>
>>> Why is it necessary to track the condition of sequential zones that do
>>> not have a zone write plug? Please explain what the use cases are.
>>
>> Because zones that do not have a zone write plug can be empty OR full.
> 
> Why does the block layer have to track this information? Filesystems can
> easily derive this information from the filesystem metadata information,
> isn't it?

(replying to my own email)

Is this a good way to check what zone type information filesystems need?

$ git grep -nH BLK_ZONE_TYPE_ fs
fs/btrfs/zoned.c:96:		ASSERT(zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL);
fs/btrfs/zoned.c:211:		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
fs/btrfs/zoned.c:488:			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
fs/btrfs/zoned.c:566:		    BLK_ZONE_TYPE_CONVENTIONAL)
fs/btrfs/zoned.c:815:	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
fs/btrfs/zoned.c:1360:	if (unlikely(zone.type == 
BLK_ZONE_TYPE_CONVENTIONAL)) {
fs/f2fs/segment.c:5295:	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
fs/f2fs/segment.c:5417:	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
fs/f2fs/segment.c:5473:	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
fs/f2fs/super.c:4332:	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
fs/xfs/libxfs/xfs_zones.c:177:	case BLK_ZONE_TYPE_CONVENTIONAL:
fs/xfs/libxfs/xfs_zones.c:179:	case BLK_ZONE_TYPE_SEQWRITE_REQ:
fs/zonefs/super.c:385:		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
fs/zonefs/super.c:874:	case BLK_ZONE_TYPE_CONVENTIONAL:
fs/zonefs/super.c:886:	case BLK_ZONE_TYPE_SEQWRITE_REQ:
fs/zonefs/super.c:887:	case BLK_ZONE_TYPE_SEQWRITE_PREF:
fs/zonefs/zonefs.h:26: * defined in linux/blkzoned.h, that is, 
BLK_ZONE_TYPE_SEQWRITE_REQ and
fs/zonefs/zonefs.h:27: * BLK_ZONE_TYPE_SEQWRITE_PREF.
fs/zonefs/zonefs.h:37:	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)

In the above I see that all filesystems check for the following zone
types and don't check whether a zone is empty or full:
* CONVENTIONAL
* SEQWRITE_REQ
* SEQWRITE_PREF

Do you agree with this conclusion?

Thanks,

Bart.

