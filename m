Return-Path: <linux-btrfs+bounces-18584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FBBC2CEB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C107188A488
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677FE2853F7;
	Mon,  3 Nov 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="02WulxwH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB663043C7;
	Mon,  3 Nov 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184962; cv=none; b=he4PnTS96kY4SNIHsYI5BAWx8m5b+KISuskr56wBZoC1xsQAr6ZCyd3W+SAksBI4I+wni7+sfM4h3q7X+s+LYTsyMbLDIgjMFfPUW8EJTUXDUU29rzyRHpVZ6752FxOrqT308P1ehb/zZZfpU36eeVBX2e+9szcGwxUkLNJjQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184962; c=relaxed/simple;
	bh=3H+4higPbUdrQOgNTHiHoV0OkYE8XUs1kez79VSzRho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lwx04wnbXmApF/jfD7x0Eme/it0s3xelY+zBRHRzH0MmnAgsYTdIr7Xt07xtDQh5FD/GG20hjA7Z43kO+Zg001gcXZaLdWKLkXGe75GAaZNyCQlbTFr/dLfCH+8yfw0ZiBQ4xhV4j60FRnuuhVFLcFRB5ZSllT5lrHty/d2gVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=02WulxwH; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d0bcB4tb7zmV4CC;
	Mon,  3 Nov 2025 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762184952; x=1764776953; bh=8+ZnI63ovUK1I7wBR7LkOuvP
	2rrk7ZSWPowftFD0GXY=; b=02WulxwHEs8MyMtxjIJK7WJgs5zSkdrxPgnr2hXx
	Aj005502n0zYHgaxpfkmmjClPgnX6gUyoxFaDwxk/Doj40Hfrb3CNbroypmkbuVH
	oh1nrA6ZvRZzyhWG9Z2d8CrHuMfEigfkF+p9SvtXWYcG7RhtLid/jt6uhxiUM53w
	f/NqvFt5I+kELSkk5RUYvh8uv9EbKfLuJx/g4QgtkSDGZkZpg8bT6N1cK9C15+nz
	Iltvy47MrGSKu0OD2BQOMF03X2osqY2VJc+HLXrgk6HENnG7wlgDCSb8gKsc2DzQ
	vX4OSfRMzF5y4fsgXJMIq15aGGyQwdBwwQ79htaeSFmw3A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aMFMxo0XxxXk; Mon,  3 Nov 2025 15:49:12 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d0bbt0fDwzm5mQ7;
	Mon,  3 Nov 2025 15:48:57 +0000 (UTC)
Message-ID: <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Date: Mon, 3 Nov 2025 07:48:54 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/25 10:05 PM, Damien Le Moal wrote:
> On 11/1/25 06:17, Bart Van Assche wrote:
>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>> Implement tracking of the runtime changes to zone conditions using
>>> the new cond field in struct blk_zone_wplug. The size of this structure
>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>> end of the structure. For zones that do not have a zone write plug, the
>>> zones_cond array of a disk is used to track changes to zone conditions,
>>> e.g. when a zone reset, reset all or finish operation is executed.
>>
>> Why is it necessary to track the condition of sequential zones that do
>> not have a zone write plug? Please explain what the use cases are.
> 
> Because zones that do not have a zone write plug can be empty OR full.

Why does the block layer have to track this information? Filesystems can
easily derive this information from the filesystem metadata information,
isn't it?

Thanks,

Bart.

