Return-Path: <linux-btrfs+bounces-11213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE331A25107
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 02:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570DF3A3511
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81BF4FA;
	Mon,  3 Feb 2025 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddall.name header.i=@siddall.name header.b="Yq35gKDr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from pmg-pub-smtp1.teksavvy.com (pmg-pub-smtp1.teksavvy.com [76.10.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6D8F6E
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738545108; cv=none; b=n1WAnwTAQtpKJRGgp1rFZhh8sOAERzKVqbtV0ozBle6g6zstI3n9qiPbedSr4zwN/U4oBPpUU0NkkJKAgpw+PuRQMokqCMRosvPjptK7ksmKYfrEQwi65TUpFaES553pAOJwfmwElWDUgWtIhnJU9tu7CJZAnKTLRL5qnuhMkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738545108; c=relaxed/simple;
	bh=xoRrTElsiBW9VY8Ny3eKFh3Ov1quD/miFGEoleHb/So=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ymq9eSDbbHzPaR3ukUIllhZwIMPPMMcV3fvIzL3opjqY4oibqubg3W9Z2o7WpDYoKMjsTZGOXpPVOwRUFvJS2mJucItj/D7GvAkjkZJfjzSjj0Cc/+7N3L6u9GwJq1/MxsbGr1g2y5hLi9W43qHWcm4d5S/dSzUt6Y2SXl2thFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siddall.name; spf=pass smtp.mailfrom=siddall.name; dkim=pass (1024-bit key) header.d=siddall.name header.i=@siddall.name header.b=Yq35gKDr; arc=none smtp.client-ip=76.10.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siddall.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddall.name
Received: from pmg-pub-smtp1.teksavvy.com (localhost.localdomain [127.0.0.1])
	by pmg-pub-smtp1.teksavvy.com (Proxmox) with ESMTP id CD69634C167F;
	Sun,  2 Feb 2025 20:11:44 -0500 (EST)
Received: from siddall.name (206-248-137-23.dsl.teksavvy.com [206.248.137.23])
	by pmg-pub-smtp1.teksavvy.com (Proxmox) with ESMTP id 6187534C1669;
	Sun,  2 Feb 2025 20:11:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 siddall.name 353D472920F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siddall.name;
	s=siddall; t=1738545104;
	bh=ytZbIgbgQQVNSpohwiBmo97frYcQcAuzCDzqWxQeV5s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Yq35gKDr1qm/dJSS8zg6vNXT0rM2UKAQfjudA4IAktW25rsqAwltZTrv+tZcXenl9
	 TcpmF8FPolknoYtyFG+T7msBV/hMMGbLUNwQcn+ucPXkJgEAwTKD7n0yJK3mF16p++
	 +kpTUGfylOzA+FEQSRRHMajBPk4VS52+hgUU41D0=
Received: from [192.168.0.2] (siddall-2.internal.siddall.name [192.168.0.2])
	by siddall.name (Postfix) with ESMTPS id 353D472920F;
	Sun,  2 Feb 2025 20:11:44 -0500 (EST)
Message-ID: <34f1c34a-68e5-4d3b-8273-402b40556a8d@siddall.name>
Date: Sun, 2 Feb 2025 20:11:44 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
 <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
Content-Language: en-US
From: Jeff Siddall <news@siddall.name>
In-Reply-To: <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

To be clear, when I say "device failed" I mean it disappeared entirely 
so from btrfs perspective it was missing.

Kernel string is: 6.1.0-1025-rockchip #25-Ubuntu SMP Mon Aug 26 23:01:14 
UTC 2024 aarch64 aarch64 aarch64 GNU/Linux

I have since rebuilt the array so fi usage doesn't contain anything 
relevant to this issue any more.

Mount options are defaults.

I was chatting with @multicore over on libera.chat/#btrfs who said they 
were able to reproduce.  I can see if I can find out how they did if you 
are still unable to see this for yourself.

Thanks,

Jeff


On 2025-02-02 19:44, Qu Wenruo wrote:
>
>
> 在 2025/2/3 09:13, Jeff Siddall 写道:
>> After a device failed on RAID1 filesystem, an attempt to convert the
>> online filesystem from RAID1 to single failed.  This isn't an uncommon
>> use case if the failed device isn't readily replaceable.
>>
>> The command ran was:
>>
>> btrfs balance start -f -sconvert=single -mconvert=single -
>> dconvert=single /mountpoint
>>
>> and the kernel logs were:
>>
>> kernel: BTRFS info (device nvme0n1p3): balance: start -dconvert=single -
>> mconvert=dup -sconvert=dup
>> kernel: BTRFS info (device nvme0n1p3): relocating block group
>> 1222049267712 flags data|raid1
>> kernel: BTRFS warning (device nvme0n1p3): chunk 1223123009536 missing 1
>> devices, max tolerance is 0 for writable mount
>
> This is not the chunk to be relocated. Considering the tolerance is only
> 0, meaning it's the newly created single chunk.
>
> I tried locally, but failed to reproduce the same problem.
>
> Mind to provide the following info:
>
> - Kernel version
> - Btrfs fi usage output
> - Mount option of the fs
>
> My major concern is, the failing devices is still considered online, but
> will fail all read/write/flush commands.
> (Btrfs only has read time repair, not failing device detection)
>
> In that case, converting to single is the worst thing you can do, as it
> will write metadata chunks into that failing devices, and lost 
> everything.
>
> The proper solution is to unmount the fs (if possible), remove the
> failing device, then mount the fs in degraded mode, add replace the
> missing device with a newer one.
>
> Thanks,
> Qu
>
>> kernel: BTRFS: error (device nvme0n1p3) in write_all_supers:4370:
>> errno=-5 IO failure (errors while submitting device barriers.)
>> kernel: BTRFS info (device nvme0n1p3: state E): forced readonly
>> kernel: BTRFS warning (device nvme0n1p3: state E): Skipping commit of
>> aborted transaction.
>> kernel: BTRFS: error (device nvme0n1p3: state EA) in
>> cleanup_transaction:1992: errno=-5 IO failure
>> kernel: BTRFS info (device nvme0n1p3: state EA): balance: ended with
>> status: -5
>>
>> Either it should be made possible to convert a RAID1 device with a
>> missing device to a single device filesystem without errors, or the
>> command should return a message stating that it is not supported to
>> convert RAID1 array with missing devices to a single.  Having the
>> process fail and then going forced readonly is a significant failure on
>> an otherwise working system.
>>
>>
>>
>


