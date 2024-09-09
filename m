Return-Path: <linux-btrfs+bounces-7899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E6997255E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371D3B236E5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271818D649;
	Mon,  9 Sep 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b="epxPyZtY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mobintestserver.ir (mobintestserver.ir [95.81.92.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B218CBF1
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Sep 2024 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.81.92.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921395; cv=none; b=IqSXikyAb3w/EzFZs7867aDLThJi09tLyjOqqxFznM68XqhjKhOJdUQie6mlsAZyNHw0VpuumhfKf3hWt7LOrQCN8eWpGR4FojA3+aMwoW0k8NVd8lhAqvjJk+kme/Vvt2V2BOw2HIX1Dbt424R5/wug5TbHFQL1xbe1CCO1eww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921395; c=relaxed/simple;
	bh=C/Pk8dE1CQSNZL/4CVfOh7v/PvB7CCGx2+r1nJYW0u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fd6HnoWijIL2GZu63b6dipkx8e32qVxlrblpjG4m50+gynPBzOzyjSRwZcxSq3o8bf/QUz2gmY33xoqPQHxX6nLYv9HZl5tq6WhLpX7heaLqodBDu+fDHvY4x5HvS8Vhdzp18wB43rvZ9ZbrVluF+DPzAEEpeVTZ8+zknkM0XyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir; spf=pass smtp.mailfrom=mobintestserver.ir; dkim=pass (2048-bit key) header.d=mobintestserver.ir header.i=@mobintestserver.ir header.b=epxPyZtY; arc=none smtp.client-ip=95.81.92.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mobintestserver.ir
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobintestserver.ir
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=dkim; bh=C/Pk8dE1CQSNZL/
	4CVfOh7v/PvB7CCGx2+r1nJYW0u8=; h=in-reply-to:from:references:to:
	subject:date; d=mobintestserver.ir; b=epxPyZtYLB3BAEFYk9460id7vcJZKof9
	Qe78dn4KJZXsJuN4i6SlKJgEoyPHblpPuoWC0lr+qNNx3KRRrrIOUsmYVs6RjSAIuX79uG
	BXwsjFz/l/ASck59fLWzQyMS666ZB36jq3H8IIK22V+cBv76hnnlTDtUodqtX0np8HO55L
	qPSXJDfOa2inDIzNweCNmCXK4Xi+lz1mrFm4oxdnK3PB69TMHNaxTvDllPQJOPvMA/fvJ3
	ZuxyKIs9VYYfles8qVRkDkT1dzR1V1ZpUPtAxJltVdUoo5R6cmFcLJMJwrubZhvKonAS6Q
	nOuvMKSRPgUeWNxciHAecw/7giikUA==
Received: 
	by mobintestserver.ir (OpenSMTPD) with ESMTPSA id f9f458b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 22:36:20 +0000 (UTC)
Message-ID: <36899b8a-ffc1-401a-87c8-0b9ef3fbdcad@mobintestserver.ir>
Date: Tue, 10 Sep 2024 02:06:17 +0330
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Many I/O errors with btrfs on MicroSD and RPi
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <6e494a0e-dafe-41b1-8be8-35a3e85bc11e@mobintestserver.ir>
 <d98f3ff7-44f0-4030-9ac6-eaeba231f37b@gmx.com>
From: Mobin Aydinfar <mobin@mobintestserver.ir>
In-Reply-To: <d98f3ff7-44f0-4030-9ac6-eaeba231f37b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On ۱۴۰۳/۶/۱۹ ۱:۴۰, Qu Wenruo wrote:
> 
> 
> 在 2024/9/9 07:00, Mobin Aydinfar 写道:
>> Hi.
>>
>> My Raspberry Pi is down because btrfs reports I/O error. So I removed my
>> MicroSD from RPi and I mounted it on my computer with ram-reader. btrfs
>> check reports many problems.
>>
>> The documention says don't use btrfs check --repair unless you know what
>> are you doing so I didn't use it.
> 
> That's the correct way to go.
> 

:)
> Unfortunately from the output, it looks quite some of your metadata is
> full of garbage now:
> 
>   BTRFS warning (device sdc2): tree block 121929728 mirror 1 has bad
> bytenr, has 15771731761493389218 want 121929728
>   BTRFS warning (device sdc2): tree block 121929728 mirror 2 has bad
> bytenr, has 17159496520340310444 want 121929728
> 
> The "bytenr" is a u64 representing the logical address, should at least
> always be aligned to sector size (4K in most cases).
> 
> Furthermore it shows both copy is corrupted, with different corruption.
> 
> It looks like the sdcard itself is not reliable thus a big chunk of data
> is either discarded or filled with garbage.
> 
> So far no transid error, thus at least its FLUSH/FUA command handling
> seems sane.

Looks like my MicroSD just collapsed because I see some fatal errors 
even on my FAT32 boot device.

I replaced the failing MicroSD. The copied data was enough for getting 
the system up and running again. Thanks for your detailed explanation 
and your great work on btrfs :)

Best Regards.

> Thanks,
> Qu
>>
>> I mounted the MicroSD and I copied all of its readable content and I
>> tried to use "btrfs scrub start" but it got aborted after ~10GiB.
>>
>> I check RPi's dmesg everyday to ensure there is no under voltage, I'm
>> sure that there is no under voltage issue but I had multiple power
>> outages in 3 last months.
>>
>> I don't have dmesg from RPi, but I have dmesg from my computer (See the
>> attachment).
>>
>> btrfs scrub status:
>> UUID:             4c3054bf-5704-4afe-be0d-d2300359d493
>> Scrub resumed:    Mon Sep  9 00:34:28 2024
>> Status:           aborted
>> Duration:         0:11:00
>> Total to scrub:   33.99GiB
>> Rate:             17.01MiB/s
>> Error summary:    csum=52
>>    Corrected:      4
>>    Uncorrectable:  48
>>    Unverified:     0
>>
>> My computer uname:
>> Linux Mobin-Mehdi-PC 6.10.7-0-generic #1 SMP PREEMPT_DYNAMIC Thu Aug 29
>> 16:26:29 UTC 2024 x86_64
>>
>> btrfs --version:
>> btrfs-progs v6.10.1
>> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
>> CRYPTO=builtin
>>
>> btrfs fi show:
>> Label: none  uuid: 4c3054bf-5704-4afe-be0d-d2300359d493
>>      Total devices 1 FS bytes used 33.79GiB
>>      devid    1 size 59.02GiB used 39.07GiB path /dev/sdc2
>>
>> btrfs fi df /mnt/Removable:
>> Data, single: total=35.01GiB, used=33.59GiB
>> System, DUP: total=32.00MiB, used=16.00KiB
>> Metadata, DUP: total=2.00GiB, used=200.53MiB
>> GlobalReserve, single: total=54.44MiB, used=0.00B
>>
>> dmesg: As mentioned, Check the attachment.
>>
>> Best Regards.


