Return-Path: <linux-btrfs+bounces-18602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E8C2E912
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 01:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72E5188131A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 00:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFF1FFC59;
	Tue,  4 Nov 2025 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCvxJbUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F893B7A8;
	Tue,  4 Nov 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215330; cv=none; b=c9Z0KOK23bOYDDmM774/R6woYCdW0Y1E7qrL7+jpr6HlQO/2wx/Ed7i2RTT5rgeNvJ3WPWt6jUSwr/ZU0wTYpjX421Vz8JD/1VDA47sU05V8w+D2L9rvA6VPeTQr/4jINwXeuY3rOOY/BNYNM9p4kgJDzWg8c4kvhZl0mNC7UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215330; c=relaxed/simple;
	bh=q51FjAcV5ST/TNFAnYhXlTQwQa95eEqoUkjdhTLCezw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=csdaSZSnpgEzm/sHDECNm7ZxR8siaPq9Er7HBBWQ/1w5jYY6zaMPvoW9Vs2x+UJ1u375tfSplLYirKflIWVmnM/o2ZzYtoFtIcwlziXGvieZk/kl5Ksyx7IzfpWg2vHAs6iOoUsJoL1KeSj11vH4Z6AF3kBVH5tUdV9RSD1Iabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCvxJbUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D53FC4CEFD;
	Tue,  4 Nov 2025 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215330;
	bh=q51FjAcV5ST/TNFAnYhXlTQwQa95eEqoUkjdhTLCezw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iCvxJbUp6IyviKFnxh4K07lx1ij/PwQCubwpGDa/AjJGi2K4oJ7bZcdvw8Klnl9lF
	 T2oDhBBvy/igyp9JfRzLTXW19/3HsOENGXGSDOQl025h4aByy20JpZTcMGHyX/CHWj
	 bvN3pJCFDOtcbzsqBS+daoZwJMZeY58rgoInPUsByGRqOhPj4dmp9IUrIOiSTAKi5+
	 OOoUNO/4JcRfZ8nuu37Pa1KdvtgCeOt9WMsoP4gibGoDhVvghyOGesMpHF3ACXukt1
	 me2eOvWaVKDC90CF/kfF5QtUjwtCqkwrpQPYva9aXotqnrR5bTj2ewj+6B19nTjd3M
	 hdDZNeslgVXog==
Message-ID: <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Date: Tue, 4 Nov 2025 09:15:26 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 00:17, Johannes Thumshirn wrote:
> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>> applications access to the fast zone report implemented by
>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>> and is documented in include/uapi/linux/fs.h.
>>
>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>> field of struct blk_zone_report also as an input. If the user sets the
>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>> is used to generate the zone report using cached zone information. If
>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>> as BLKREPORTZONES and the zone report is generated by accessing the
>> zoned device.
> 
> 
> Is there a downside to always do the caching? A.k.a do we need the new 
> ioctl or can we keep using the old one and cache the report zones reply?

The old one is needed to allow getting the precise imp open, exp open, closed
conditions, if the user cares about these. E.g. Zonefs does because of the
(optional) explicit zone open done on file open.

And we cannot break existing user space anyway (e.g. sysutils blkzone), so we
must return the "legacy" report unless asked otherwise.


-- 
Damien Le Moal
Western Digital Research

