Return-Path: <linux-btrfs+bounces-14182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD1AC1597
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 22:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6918B188ED53
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 20:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408DE241686;
	Thu, 22 May 2025 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYrVJK/a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED4188713
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946370; cv=none; b=Un3tm9uQ5SrYsHgRiPBIf4oTn3ILCftonCaFr6/XQrFiJnuLtswlNq2KUlr34tv+ySpUKe1LSVSWIr87F7yzHld3CTOLg/4u+BNuvVe5AZJO6A88+m7hqN029TZGFi3UBeNRJVUWa5UGAkbugLI4D8X58f7b0474nppsaP72AqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946370; c=relaxed/simple;
	bh=FIolFIRPRAOUl5MJzscvNm08M26xEww8NaNvWkzqF84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qbYRYZ7PxETuU/taAvHum9wMqa2yzCACF027cookHkSNSMpBk79kUIiyl9uf417RfkNFtEj/jM8qShto6aRBoDSt63NLj/gMxzItTZwzklBbJXKPzddBXuYeSLFzeHhd8R3SuXZ+RsxF+0k43x5Zd0hR9p+0giVDnzkrdKj20+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYrVJK/a; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad54e5389cdso895574866b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747946367; x=1748551167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjOlhc3F5DtHC9YJqdEqifeqh8PS+JqTRzIJwHmjpF0=;
        b=mYrVJK/acA89+9GqJh/cMqHNkexvYhAWKx3XA+ZGvY912KQowShCzTrtHmrLfRQksX
         XBZjo5kKp4R8fJdHeq2erkMKBFXz0tbPDmxMfSoVgrz4F7r9cZE69enFuoB+D36i1Xki
         SahjzcEzbjRwr1YoVYHvaaIf59kfTu2P/IgWUhAiTqIRmLRIlmMl9jVVk5m9loGN1x6e
         8z3llHk2HMaTK4BnATWViXgoG4bC+jX2WVtnnn8hM9faBelRLk6mx4j1f1ivbIuuNJWs
         eu9S9Qu6Ezm94x9J0K/mn2B0RNG8Am3OZlyxiJzdzCCsY7L1Qbr/YsR3vCkOSsBOU14j
         nGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747946367; x=1748551167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjOlhc3F5DtHC9YJqdEqifeqh8PS+JqTRzIJwHmjpF0=;
        b=jmD2p/Qvs86wClvKZEnOVuIB/62Gp5LbQWuRLxjYoqFDso9MYrPzO4qgNXdiD6zite
         0JrvnLAETSYVO5ynfUJ+B5Rtdo2gTTZxTrnSDxzZn8w71JQ/R4Ujs2OYRW4T58YbQ7el
         lJDpQJ2VfgT/2nNfJzQol3Km3JZJpIWz0/Ifu66SculOCP9esBx1RMNlbBGTF+rDuzFc
         rTbeFmz3ocKt/Dw+0gPaRLcFrrVijpthtb96D5VrPwllmElFsMKOW8TQODTkFoLxlBnt
         qTfWjFAU8e13HYlK8IXx377UWTLA/eY0+vT/O/pdBJOmvbOYNlqNAEWUtigCw3mc0CrP
         FR8g==
X-Forwarded-Encrypted: i=1; AJvYcCXnGKxtt7GCbgosx5/yM6EKtl+kL9Um2lqsxZpjKPwOKbMrl/pCWFjlKuFFWjnVfQLfDAMrl0N2+dIUHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyktSJSFpnipaCobBh4DscyMbgN/+HYNUU2PpDnCXUCUmBQ6Oma
	+GM39hlfyuv8cahD/8buHGiZ78DqFQ1Zrs9KOHrp8RCWZuyt8zaNvtj3eu6W6g==
X-Gm-Gg: ASbGncvKVAkZ0aLsr63EtVvgQJSA3lVlnV4J71fdrxFSB4OWCSGRZndy7gOjwDpHItQ
	gK85fpD0YU9YNauSxVweHjDycXjS/i0kUYG0n70MaaHHsBb/6znKHKwG1ND7W6VKqkV5kFMwzrX
	QWezpbjEAytKudkXcJgtdae0sdAplj3s6VNMy9mk7JxL2GAyeHSlSrGO+5B7tpQApnYHKVrG7U8
	izuKF1JtnUFVg2YITtKUaHo8siMMHjDo6iMjQTSya/ANHgJpR+w4HqQSatvEc5jwOZUSwuFD/po
	SQvMGDUndoLpb1b1nwm3V62y1uLwCQ2BcleuW142dno4yu7T4eGGEFUSBIXxH6iTLPkQR74O4bM
	bDdHTbCfg9fr1V2Y6wJwQ9XwrO7fStU6P0UukgeglJsEN8n/9OkNWyyZsJdD8PNFuTdPiZPrFGT
	L1dJlqoSU=
X-Google-Smtp-Source: AGHT+IEHv61O1qxdpwGXKtm3HA8vo6ta6wscoWieX3ocrqxmI7gT1HnT2pEKViL17gJWMdCGfsAOBw==
X-Received: by 2002:a17:906:f582:b0:ad4:f6d8:ee2f with SMTP id a640c23a62f3a-ad52d5ba63dmr2453991266b.38.1747946366691;
        Thu, 22 May 2025 13:39:26 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:a184:d5bd:b889:de85? (2a02-a466-68ed-1-a184-d5bd-b889-de85.fixed6.kpn.net. [2a02:a466:68ed:1:a184:d5bd:b889:de85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06d533sm1127999166b.45.2025.05.22.13.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 13:39:26 -0700 (PDT)
Message-ID: <fee4ece3-b5f6-4510-89d0-40f964da2720@gmail.com>
Date: Thu, 22 May 2025 22:39:25 +0200
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
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Op 12-05-2025 om 20:07 schreef Anand Jain:
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

Finally a new effort in this direction.

> Introducing Device Roles:
> 
>   Here I define 5 device roles in a specific order for metadata and in the
>   reverse order for data: metadata_only, metadata, none, data, data_only.
>   One or more devices may have the same role.
> 
>   The metadata and data roles indicate preference but not exclusivity for
>   that role, whereas data_only and metadata_only are exclusive roles.
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

I can see the use case for large pools of disks used in server 
environments where disks get assigned a role.

For desktop use I would like it a lot better with no roles, just a 
performance-based chunk allocation to select between a ssd and a hdd. 
And then used more like a hint to the allocator. Really nothing should 
go wrong if a data or meta-data gets allocated on the wrong / 
sub-optimal disk.

This could then bring back the old hot relocation idea, finally.

> Finding device speed automatically:
> 
>   Measuring device read/write latency for the allocaiton is not good idea,
>   as the historical readings and may be misleading, as they could include
>   iostat data from periods with issues that have since been fixed. Testing
>   to determine relative latency and arranging in ascending order for metadata
>   and descending for data is possible, but is better handled by an external
>   tool that can still set device roles.
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

I think filling the fields with either measured or user entered data 
should be fine, as long as when the disk behavior changes you can 
re-measure or re-enter.

The difference between a ssd and a hdd will be so huge small changes 
will have no real effect.

> Anand Jain (10):
>    btrfs: fix thresh scope in should_alloc_chunk()
>    btrfs: refactor should_alloc_chunk() arg type
>    btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>    btrfs: introduce device allocation method
>    btrfs: sysfs: show device allocation method
>    btrfs: skip device sorting when only one device is present
>    btrfs: refactor chunk allocation device handling to use list_head
>    btrfs: introduce explicit device roles for block groups
>    btrfs: introduce ROLE_THEN_SPACE device allocation method
>    btrfs: pass device roles through device add ioctl
> 
>   fs/btrfs/block-group.c |  11 +-
>   fs/btrfs/ioctl.c       |  12 +-
>   fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
>   fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
>   fs/btrfs/volumes.h     |  35 +++++-
>   5 files changed, 366 insertions(+), 64 deletions(-)
> 


