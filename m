Return-Path: <linux-btrfs+bounces-18601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA846C2E5A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 00:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55EDD34BB68
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 23:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65D2FE074;
	Mon,  3 Nov 2025 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIT/BTp1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191932F692D;
	Mon,  3 Nov 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210893; cv=none; b=XhpvgJscmj0rhdyw9yFkTPNJFydFb30M01PfeqaSRp4V4ZN7p/CDJ8PJRWyPj7DkQhxRjZLv9ndaxRybI9uHXEYK1uzR01S7EpXX8xvlr0evecRiH+peMXcrNYBFKHAenF+Hda+pHVprMgQsJirns3jWLiIdJT/bQT7N/Y2D/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210893; c=relaxed/simple;
	bh=6O2ngqEIH1rvuzv3mpBrfCb9R60Mx/pJq5EQc4OPBnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bg2SPyG9pEpagweD+12vGGtyDvVuxJDcVAqnPKMwQ+MSxryvj1YmbjQr2+iESYuNWYX7jIGAJflLiUwtMoQao8iuZPshAtdRQGAhAAoGI/SElhySe9vRStBVRrsSv3x8bO8Iql8CAvt3bkwkxmoCzBfFbEGt4NCM4jh5PWrRePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIT/BTp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A414C116C6;
	Mon,  3 Nov 2025 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762210892;
	bh=6O2ngqEIH1rvuzv3mpBrfCb9R60Mx/pJq5EQc4OPBnA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qIT/BTp1oRYAPPF8exJTOJqgAd4ZMryvWOoPil83FhJrymfnAELwHJZf8Ufo5m0o5
	 avOn3dacEd+8E3yBoYUc8sqiAdR3hFLd2Imd0NztctI9RV/1ZWL12m7yiYGPOiVHzY
	 RrBV8yMLiJgrSqtFWt5ALlYLYo26CUN1hus6WeyLQJoJ+jDOkJgy1pLmGquRcdbMuJ
	 V//DXYi9T3AJK1dBXWnPKr5JfCL9Qy9Ome6iS/IOrioWC8Gh218+OOncy+cS1/NfIJ
	 X5rrCRnBMOCfk82xTmFbkJ8uCsU9b8P3oCLLVP2OsGW+NtWgI3gx0wBn1D2zqvaqHy
	 bkt4TcrfSSCoA==
Message-ID: <35effd01-0158-4381-9803-d71b79ca775f@kernel.org>
Date: Tue, 4 Nov 2025 08:01:29 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
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
 <3c634060-494b-4319-8298-caa940e92f48@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3c634060-494b-4319-8298-caa940e92f48@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 07:12, Bart Van Assche wrote:
> On 11/3/25 7:17 AM, Johannes Thumshirn wrote:
>> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>>> applications access to the fast zone report implemented by
>>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>>> and is documented in include/uapi/linux/fs.h.
>>>
>>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>>> field of struct blk_zone_report also as an input. If the user sets the
>>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>>> is used to generate the zone report using cached zone information. If
>>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>>> as BLKREPORTZONES and the zone report is generated by accessing the
>>> zoned device. 
>>
>> Is there a downside to always do the caching? A.k.a do we need the new
>> ioctl or can we keep using the old one and cache the report zones reply?
> 
> Hi Damien and Johannes,
> 
> I have a different proposal, namely not to introduce BLKREPORTZONEV2 at
> all. If we keep the BLKREPORTZONE ioctl and do not introduce the
> BLKREPORTZONEV2 ioctl then in the kernel we only have to cache zone
> information that will be used by filesystems. Information that won't be
> used by filesystems doesn't have to be cached. With this approach the
> existing data structures are sufficient (struct blk_zone_wplug and
> conv_zones_bitmap) and we don't need to introduce new data structures
> for tracking zone information.

See XFS and BTFS mount code.

E.g., for XFS, xfs_mount_zones() -> xfs_get_zone_info_cb() -> xfs_init_zone().
Zone type, condition and write pointer are used. That's about everything in the
zone report and to generate that we need: (1) zone condition and (2) zone write
pointer offset. Both are available from zone write plugs and when we do not have
a zone write plug, we need the zone condition (1), and that allows us to infer
(2). For the zone type, that can always be inferred from the zone condition so
that is not cached.

So we already are caching the *minimum* amount of data needed, and that data
allows us to generate a near perfect zone report without needing to interrogate
the drive. We are not doing any "Information that won't be used by filesystems
doesn't have to be cached.". This is already optimal.

BLKREPORTZONEV2 is for users to also get the benefits of a faster zone report
for things like mkfs (formatting a large RAID volume takes a long time because
of zone reports on all drives). Removing it would be counter productive.

-- 
Damien Le Moal
Western Digital Research

