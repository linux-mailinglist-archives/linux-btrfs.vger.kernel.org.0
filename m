Return-Path: <linux-btrfs+bounces-14464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09555ACE626
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B427F172879
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49817212B28;
	Wed,  4 Jun 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGhGZyiC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE2BA42
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072574; cv=none; b=KhYTeQqn3v+RmlG5sA2VzcQWF8yNWEaCr0Nzrwr2lTFTCCgR2L+kBwhL8orZTEAFdcKEr5F6TCtHokBXFfwKsWCQCPJEOFK9NWdbeOuSIPhJq00bZ8yZKhijbRrYZizielz826EP/yyyvz2NkPfYF7t7N19RFgiQ7Wz6uNhmeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072574; c=relaxed/simple;
	bh=ON5orqwACNpdcOGrdaIuqOZFSTgqrfVta5ZuRm9/mBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ln8uoeDM498cEsz40TeHfe8WABUT0SX949g4WzL94RAmBaJZKASceYHoFkAuxWuBHgaN+86RuIyHGdFAYm32dEKOVvBua7VQ/uY7GgIOe/SpQOTPdK9cvqYq1LvudgcGk55etbTmCwRz12uw5gsv3kkVT4mJkwNhgzePZgF1UAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGhGZyiC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad574992fcaso44547166b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072571; x=1749677371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RoS+OMp3SSn9TgOPbWMKXmVQDrBdwXTGUYG9B4x81Y=;
        b=UGhGZyiC0iB1+MMIWM/+lMuJVmrHjvdoQWZ2lv7e5cq8IqebDctI3G5mYOiF2fkF9Y
         PooaOfdIYRkCt3V2dFNNjvLlBs5blCVEm8MbLbUtKUKQCsnmr2dUzM67bN+fdJE+0Gm1
         0hP7UVaTY/t0rB5Y1vquOutzKximlMw/2QwE7hLmDIhJbQDutMHPLd7Fg9+Vx3n1xoo0
         Ky+QlANnF2xrcKcUh0n8HSTIzs+umuZRu2b3lGsrIuPZ/bRewwUmDauhP+XfSyBpsch9
         zPQ5RMaEy0U9WMGYWD3t3NU2lGyicqhMWBvSO1xZFBk1HwN3lCDwT9aankHlrJXU+1QV
         Ssww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072571; x=1749677371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RoS+OMp3SSn9TgOPbWMKXmVQDrBdwXTGUYG9B4x81Y=;
        b=lISASdLQCtbW7XT01Tz1tr0o0s7UfPMaPmWjfoUWtab4vpko6G03KjAxE09ckSBw0e
         Ir4ENZFkc9wzH8lmvhBaBI02pIu81P3hTi9n2BosZPy089XZ4zaYzYTcUgUVrkVbLp45
         n98VRnioWq1xb1SUgpq0+i2ZaD5mVspjl/PtgslapySyMFQ3EzpMESDZy0hG/l0eWw7o
         xwcHyuog+mY8l8sXR7p0s/WOUKs+ovkigvP6zD2dNSB/xTrw24ZxPgyaAqzdixEgEST7
         SNuczPQgBF6XBMOXXN+lyI+AqpviYCtlcALu7cyXW3sS9YGREp4XxPjLxlZMR0jxZG6C
         6lEA==
X-Forwarded-Encrypted: i=1; AJvYcCXoRaPwbAJsUFykBTYyArbTHKdnk2TmmAcdbnkTnmJzaJoFpCgwAAVxImbji2bMfw3S79FcPraHDh7w4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOvy2/lASfH6IKTtPBi8tZJPl1anXW3lYdua4AbsCTIW6TL5Xj
	lHTYN6iOYaI6SAJQDXPoaFNAuFXHYL3w5gklX+p/oQkYGV/svGpzB/wd
X-Gm-Gg: ASbGncuRMjidbyRofDAcL5aXsy9CVi1VLQnB8+jbZXzqdDVQx9j3DpbzSA+C5UdmEvm
	3UtijsgZzt6xBN5OpOGnVRJbY0c8jYxfXBtLoqpg9wFTm812uk/SHlzS9yC+48Y32auCkirviFB
	P7ruNNS+drOkD3rU3gB9WGEIBCp6hYsCsyjTNOWy9UdKAlGhMGYzzvv4lNfTWnoxn0Dl6AS6Hl3
	wT3hye+pwOoaaFejnBytDmBHWdI8/L5uawvnLuot/US/ONpNGO+MMeWvMZRYRL9ddNu0Okki1aD
	K3Vg0St5+41+4rZrlJBmNbMvGYzkXy1IbhzKrgrKBI3JtvEBYaMtAp13Vae6Plj+fXHil7uvEBl
	U9tKEIY7PvUy7E9mYrgpWR2FyOTtI669m922MuYQ3L/EwDM9S/0rNdfyeh8hrNJ43Owjh3O+7Wr
	t84dWnwlk=
X-Google-Smtp-Source: AGHT+IHtQDKBWWBLOylQ13HbBA9BzAmVnmg0ATk/JRJ6lk4BjxviRjP2b57uCskxY/gXQ3QDaN1Ohg==
X-Received: by 2002:a17:906:6a28:b0:ad5:3e27:ebc with SMTP id a640c23a62f3a-addf8fd93d8mr427055166b.57.1749072570628;
        Wed, 04 Jun 2025 14:29:30 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:9386:40ea:f665:2d25? (2a02-a466-68ed-1-9386-40ea-f665-2d25.fixed6.kpn.net. [2a02:a466:68ed:1:9386:40ea:f665:2d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-addfc4e04a1sm123140166b.143.2025.06.04.14.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 14:29:30 -0700 (PDT)
Message-ID: <4ca355b0-f4d8-4e84-80b5-17e5a42e8273@gmail.com>
Date: Wed, 4 Jun 2025 23:29:29 +0200
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
 <fee4ece3-b5f6-4510-89d0-40f964da2720@gmail.com>
 <67bf4ef7-6718-4ab8-85c1-8b8035a8981e@oracle.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <67bf4ef7-6718-4ab8-85c1-8b8035a8981e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Op 02-06-2025 om 06:24 schreef Anand Jain:
> On 23/5/25 04:39, Ferry Toth wrote:
>> Hi,
>>
>> Op 12-05-2025 om 20:07 schreef Anand Jain:
>>> In host hardware, devices can have different speeds. Generally, faster
>>> devices come with lesser capacity while slower devices come with larger
>>> capacity. A typical configuration would expect that:
>>>
>>>   - A filesystem's read/write performance is evenly distributed on 
>>> average
>>>   across the entire filesystem. This is not achievable with the current
>>>   allocation method because chunks are allocated based only on device 
>>> free
>>>   space.
>>>
>>>   - Typically, faster devices are assigned to metadata chunk allocations
>>>   while slower devices are assigned to data chunk allocations.
>>
>> Finally a new effort in this direction.
>>
>>> Introducing Device Roles:
>>>
>>>   Here I define 5 device roles in a specific order for metadata and 
>>> in the
>>>   reverse order for data: metadata_only, metadata, none, data, 
>>> data_only.
>>>   One or more devices may have the same role.
>>>
>>>   The metadata and data roles indicate preference but not exclusivity 
>>> for
>>>   that role, whereas data_only and metadata_only are exclusive roles.
>>>
>>> Introducing Role-then-Space allocation method:
>>>
>>>   Metadata allocation can happen on devices with the roles 
>>> metadata_only,
>>>   metadata, none, and data in that order. If multiple devices share a 
>>> role,
>>>   they are arranged based on device free space.
>>>
>>>   Similarly, data allocation can happen on devices with the roles 
>>> data_only,
>>>   data, none, and metadata in that order. If multiple devices share a 
>>> role,
>>>   they are arranged based on device free space.
>>
>> I can see the use case for large pools of disks used in server 
>> environments where disks get assigned a role.
>>
>> For desktop use I would like it a lot better with no roles, just a 
>> performance-based chunk allocation to select between a ssd and a hdd. 
>> And then used more like a hint to the allocator. Really nothing should 
>> go wrong if a data or meta-data gets allocated on the wrong / sub- 
>> optimal disk.
>>
>> This could then bring back the old hot relocation idea, finally.
>>
>>> Finding device speed automatically:
>>>
>>>   Measuring device read/write latency for the allocaiton is not good 
>>> idea,
>>>   as the historical readings and may be misleading, as they could 
>>> include
>>>   iostat data from periods with issues that have since been fixed. 
>>> Testing
>>>   to determine relative latency and arranging in ascending order for 
>>> metadata
>>>   and descending for data is possible, but is better handled by an 
>>> external
>>>   tool that can still set device roles.
>>>
>>> On-Disk Format changes:
>>>
>>>   The following items are defined but are unused on-disk format:
>>>
>>>     btrfs_dev_item::
>>>      __le64 type; // unused
>>>      __le64 start_offset; // unused
>>>      __le32 dev_group; // unused
>>>      __u8 seek_speed; // unused
>>>      __u8 bandwidth; // unused
>>>
>>>   The device roles is using the dev_item::type 8-bit field to store each
>>>   device's role.
>>
>> I think filling the fields with either measured or user entered data 
>> should be fine, as long as when the disk behavior changes you can re- 
>> measure or re-enter.
>>
>> The difference between a ssd and a hdd will be so huge small changes 
>> will have no real effect.
> 
> 
> Yeah, for desktop setups with SSDs and HDDs, the distinction is clear
> and stable, so assigning data or metadata based on device type makes
> sense. It’s straightforward to handle statically, and a
> --set-roles-by-type mkfs option will make it automatic.
> 
> Even if the SSD temporarily slows down during a balance, we’d still
> prefer to keep metadata on it, assuming the slowdown is short-lived.
> SSD performance typically recovers, so there's no need to overreact
> to transient dips.
> 
> For virtual devices, mkfs --set-roles-by-iostat should also work well.
> And later if performance characteristics change permanently, a
> balance-time option like --recalibrate-role-by-iostat could
> re-evaluate based on I/O stats, confirm with the user, and relocate
> chunks accordingly.
> 
> Also, I'm trying not to introduce too many options or configuration
> paths, just enough to keep Btrfs simple to use.
> 
> Does that sound reasonable?

That sounds very good.

I  am curious what happens when the fast device fills up, what will the 
allocator do? I guess it will fall back to allocating to the slow device?

If so, we're going to need some periodic or just in time "move files 
that have for a long time not been written / read" to the slow disk.

While that file my be referenced from multiple subvolumes, and you 
wouldn't want those duped (like happens with defragmenting).

> Thanks, Anand
> 
>>> Anand Jain (10):
>>>    btrfs: fix thresh scope in should_alloc_chunk()
>>>    btrfs: refactor should_alloc_chunk() arg type
>>>    btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>>>    btrfs: introduce device allocation method
>>>    btrfs: sysfs: show device allocation method
>>>    btrfs: skip device sorting when only one device is present
>>>    btrfs: refactor chunk allocation device handling to use list_head
>>>    btrfs: introduce explicit device roles for block groups
>>>    btrfs: introduce ROLE_THEN_SPACE device allocation method
>>>    btrfs: pass device roles through device add ioctl
>>>
>>>   fs/btrfs/block-group.c |  11 +-
>>>   fs/btrfs/ioctl.c       |  12 +-
>>>   fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
>>>   fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
>>>   fs/btrfs/volumes.h     |  35 +++++-
>>>   5 files changed, 366 insertions(+), 64 deletions(-)
>>>
>>
> 


