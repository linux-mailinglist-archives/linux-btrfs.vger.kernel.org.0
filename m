Return-Path: <linux-btrfs+bounces-18681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD66C32E24
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 21:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 968F534AF02
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AA2F0669;
	Tue,  4 Nov 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJbwQVBE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D722EA169;
	Tue,  4 Nov 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287229; cv=none; b=AoaFgyRcc6oJ8oJH8JalL8Jq3X8/kdyz2zFv/1IS0CVJRDYA1B5Ryjn82J7+lGDWB0vWvsEWNUuVAND9Kly0K/NOppqSB77gxPz4B5ZzPY3HMLUtnjUN7FFE35PC56WPNnKsVVOYaeRYrkbEOsDtQyENhc3wve0HONXMEejrhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287229; c=relaxed/simple;
	bh=3FSJqyPE1Vqo06Q/AoUzipo9gS2M6q2r8A7ZJUYYuF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cMDC9bhrtvDO0aCT6mPPzTDasjBx25F+SNQidNLLndFh3Lp6ksTEM7gCgqB1g1qhJJB3D75IPxKyPn23RQ1FUKPGWTbBmw7RcVekGlFwkILAvnPvVCc8ouBVj3Al1LtGv8r2hqyjKSt2BwvX2HR/VWCZJtrs5RemEMd9zYeIzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJbwQVBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74D6C4CEF7;
	Tue,  4 Nov 2025 20:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762287229;
	bh=3FSJqyPE1Vqo06Q/AoUzipo9gS2M6q2r8A7ZJUYYuF4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CJbwQVBE1D1MYm990XnLqqMuyjhnCCOdAlu+z03qAX2ImU+84t4gZezs53Dzn9YpY
	 xtvwjMHu+8X7lnYZ7JH4Pylbx4OxU+wk7qFyH49pRSdzAPUohWE2+gx1CkiP48JcWA
	 mnW2fbmijTHwh06o/88J4zyBfAaWNyvd7glFfXqzL0ir7Ks5RBywi418cZ1gnuwbTq
	 wppFtkGUZqi82Yt8ZyH+IqGRrBTo8wU4a2GROfbtr/EK6jMSAgdty7FmdAiDrAR2fM
	 g7o35wTbh4g/MsecHVA5qC90s2DhjfjjHF23pfL29BWk6AO7AJmXaPL94b6x2Yg39y
	 uSGT2Lsjtq+xw==
Message-ID: <da7e8c3e-49fe-49bd-9642-3b0ae67a3503@kernel.org>
Date: Wed, 5 Nov 2025 05:13:45 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-12-dlemoal@kernel.org>
 <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 04:00, Bart Van Assche wrote:
> On 11/3/25 5:31 PM, Damien Le Moal wrote:
>> - * @BLKREPORTZONE: Get zone information. Takes a zone report as argument.
>> - *                 The zone report will start from the zone containing the
>> - *                 sector specified in the report request structure.
>> + * @BLKREPORTZONE: Get zone information from a zoned device. Takes a zone report
>> + *		   as argument. The zone report will start from the zone
>> + *		   containing the sector specified in struct blk_zone_report.
>> + *		   The flags field of struct blk_zone_report is used as an
>> + *		   output only and ignored as an input.
>> + *		   DEPRECATED, use BLKREPORTZONEV2 instead.
>> + * @BLKREPORTZONEV2: Same as @BLKREPORTZONE but uses the flags field of
>> + *		     struct blk_zone_report as an input, allowing to get a zone
>> + *		     report using cached zone information if BLK_ZONE_REP_CACHED
>> + *		     is set.
> 
> Was it promised to add information in the above comment about the 
> differences in accuracy between the two ioctls? See also
> https://lore.kernel.org/linux-block/97535dde-5902-4f2f-951c-3470d26158da@kernel.org/

As I said, I did. See the comments with the BLK_ZONE_COND_ACTIVE condition.
If you think that is not enough, I can cross reference tht in the comment for
BLKREPORTZONEV2.



-- 
Damien Le Moal
Western Digital Research

