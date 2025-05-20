Return-Path: <linux-btrfs+bounces-14133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D2ABD38F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430C416848B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4B1267F70;
	Tue, 20 May 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="ZXZp7pga"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [135.181.111.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA20262FC4
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.111.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733807; cv=none; b=n4E+Zrss27LnSXPb/Ob6rCMWrMFeTEIfr0s2z/uSq4Yj4vW7+dzqt/SdVA529GYSoWuoN35q+jfh+CTAjROc7wnaiL0CFEcSWrNdlOLPLARgjUGMvemI9nRGKpcdjzrGru9FlJ3zSelU5NhhmWm/ioThovqwaeGlc66yJVl9POs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733807; c=relaxed/simple;
	bh=X1oa4Ok+qxylBR1egDh0mGNp+akt86HCPrbgljJbKFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=soI4yNF/UHyHhSssDhUGwIim2pZmJSbxFButNrERTOWZ4hPSjaKi2teDfMny91q2gaLVoVtvofvUer1yTrQK0tBbBsVJqSNwhQfKdi5oQZA0JSICSJ3Pga1B/eO7K5rOmg6xk4gFDSvJ4LdSBkPX7XOoSwcw7iyQGMs4PrVkQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=ZXZp7pga; arc=none smtp.client-ip=135.181.111.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hxRd2UOu+zX8mOKkspsBb66dnHtUUcafD7BugzIXZR0=; t=1747733806; x=1748943406; 
	b=ZXZp7pgaWDDRmwBVsqOVJqUDfK78BMXRT9hgYyTTRFZfNpcmlEnZuNDZL7WfWKrodGFypZr9j3v
	IacICfHgx1kob9+UKA7ofwyTvK8KWCB6RQx/O+ZK/9sGnvwTn0qBOeiP2psvWNx4r5iKtjJnzS6ea
	cPM0UOkjSr+fcJjk0W3UEcqYeUtwMjCqmwPGZmS9L7zW/HwvoRrHsuZF6x3zeJLjFw0o2RorWP5rn
	16+cAVlQAgY8eipZnhgU5FTWvkeqE4eqFHMYqvP+iMAfIjgc+SikDIBIhrad3/pMziGQ3H58NdWoz
	9zICJn4T2dPnC0a2fF7y4O+BN0xYvx7OLjig==;
Received: from [2001:470:28:704::1] (port=48494 helo=tnonline.net)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <forza@tnonline.net>)
	id 1uHJ7x-000000003os-1f4O;
	Tue, 20 May 2025 09:19:14 +0000
Received: from [192.168.0.109] (port=40834)
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <forza@tnonline.net>)
	id 1uHJ7x-00000000IgJ-0wVo;
	Tue, 20 May 2025 11:19:13 +0200
Message-ID: <c49ee3e6-b0f8-4886-a364-e745d0e5d091@tnonline.net>
Date: Tue, 20 May 2025 11:19:13 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Language: en-US, en-GB
From: Forza <forza@tnonline.net>
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.6 (-----)

Hi,

On 2025-05-12 20:07, Anand Jain wrote:
> In host hardware, devices can have different speeds. Generally, faster
> devices come with lesser capacity while slower devices come with larger
> capacity. A typical configuration would expect that:
> 
>   - A filesystem's read/write performance is evenly distributed on average
>   across the entire filesystem. This is not achievable with the current
>   allocation method because chunks are allocated based only on device free
>   space.
> 
>   - Typically, faster devices are assigned to metadata chunk allocations
>   while slower devices are assigned to data chunk allocations.
> 
> Introducing Device Roles:
> 
>   Here I define 5 device roles in a specific order for metadata and in the
>   reverse order for data: metadata_only, metadata, none, data, data_only.
>   One or more devices may have the same role.
> 
>   The metadata and data roles indicate preference but not exclusivity for
>   that role, whereas data_only and metadata_only are exclusive roles.

This sounds like the old preferred_metadata (Allocator Hints) patch 
series from Goffredo Baroncelli[1] back in the 2020, now being 
maintained and improved by Kai Krakow[2] and others. Is this an 
updated/enhanced version of those patches?


> 
> Introducing Role-then-Space allocation method:
> 
>   Metadata allocation can happen on devices with the roles metadata_only,
>   metadata, none, and data in that order. If multiple devices share a role,
>   they are arranged based on device free space.
> 
>   Similarly, data allocation can happen on devices with the roles data_only,
>   data, none, and metadata in that order. If multiple devices share a role,
>   they are arranged based on device free space.

The Allocator Hints patch series show that this is a good method. We are 
several users that use those, also in production environments to good 
effect. Some argue that having more tiers would be beneficial, it could 
be combined with defrag or balance operation to place data on slow or 
fast storage.

> 
> Finding device speed automatically:
> 
>   Measuring device read/write latency for the allocaiton is not good idea,
>   as the historical readings and may be misleading, as they could include
>   iostat data from periods with issues that have since been fixed. Testing
>   to determine relative latency and arranging in ascending order for metadata
>   and descending for data is possible, but is better handled by an external
>   tool that can still set device roles.

Benchmarks using round-robin, latency and latency-round-robin and queue 
based scheduling show that latency based allocation can be particularly 
useful for some workloads and device types. It is difficult to 
generalise, but based on benchmarks we see that a good all-rounder is a 
queue based approach. See [3] for a complete set of raw data from these 
benchmarks.


|  # | Storage    | Jobs | Test                | Policy      |   IOPS  |
| -: | :--------- | ---: | :------------------ | :---------- | ------: |
|  1 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | pid         |      81 |
|  2 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | round-robin |      93 |
|  3 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | latency     |      89 |
|  4 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | latency-rr  |      87 |
|  5 | HDD RAID1  |    1 | RandRead 4 KiB QD1  | queue       |     102 |
|  6 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | pid         |  68 800 |
|  7 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | round-robin | 143 000 |
|  8 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | latency     | 142 000 |
|  9 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | latency-rr  | 137 000 |
| 10 | SSD RAID10 |    1 | RandRead 4 KiB QD32 | queue       | 143 000 |

(table wraps)

|  # | Policy      | BW (KiB/s) | Avg Lat (ms) | 99 % Lat | 99.9 % Lat |
| -: | :---------- | ---------: | -----------: | -------: | ---------: |
|  1 | pid         |        328 |        0.310 |   30.016 |    242.222 |
|  2 | round-robin |        374 |        0.091 |   26.084 |     60.031 |
|  3 | latency     |        358 |        0.041 |   26.608 |     32.900 |
|  4 | latency-rr  |        348 |        0.041 |   28.181 |     33.817 |
|  5 | queue       |        409 |        0.050 |   24.511 |     35.390 |
|  6 | pid         |    275 456 |        0.458 |    8.029 |     10.290 |
|  7 | round-robin |    572 416 |        0.217 |    0.338 |      0.627 |
|  8 | latency     |    569 344 |        0.219 |    0.306 |      0.400 |
|  9 | latency-rr  |    547 840 |        0.227 |    0.326 |      0.449 |
| 10 | queue       |    571 392 |        0.218 |    0.457 |      0.594 |

I think md uses a mix of queue based and sector-distance based approach 
depending on device type[4].

> 
> On-Disk Format changes:
> 
>   The following items are defined but are unused on-disk format:
> 
> 	btrfs_dev_item::
> 	 __le64 type; // unused
> 	 __le64 start_offset; // unused
> 	 __le32 dev_group; // unused
> 	 __u8 seek_speed; // unused
> 	 __u8 bandwidth; // unused
> 
>   The device roles is using the dev_item::type 8-bit field to store each
>   device's role.
>
> Anand Jain (10):
>   btrfs: fix thresh scope in should_alloc_chunk()
>   btrfs: refactor should_alloc_chunk() arg type
>   btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>   btrfs: introduce device allocation method
>   btrfs: sysfs: show device allocation method
>   btrfs: skip device sorting when only one device is present
>   btrfs: refactor chunk allocation device handling to use list_head
>   btrfs: introduce explicit device roles for block groups
>   btrfs: introduce ROLE_THEN_SPACE device allocation method
>   btrfs: pass device roles through device add ioctl



Have you considered how to deal with `df` and disk free calculation? Are 
device roles preserved during `btrfs device replace`?

Thank you!

[1] 
https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/T/
[2] https://github.com/kakra/linux/pull/36
[3] https://gist.github.com/kakra/ce99896e5915f9b26d13c5637f56ff37
[4] 
https://github.com/torvalds/linux/blob/a5806cd506af5a7c19bcd596e4708b5c464bfd21/drivers/md/raid1.c#L832-L843





