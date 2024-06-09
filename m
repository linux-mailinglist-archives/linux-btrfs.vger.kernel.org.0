Return-Path: <linux-btrfs+bounces-5578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C10901410
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 02:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0CD1F22480
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E923BE;
	Sun,  9 Jun 2024 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b="tGc0jfy0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4015C0
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.195.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717892205; cv=none; b=kKGHrjONXcp5FRvnxHtNRobPARfLWEtDjbybGH9UO6thy/IqPd75blXFH3JNkNGTxLtFfPft8fNAomMO4xf5FGXmVlYMMs50uOSvWt6Vr+Tm8RpvP57mDl42L4iCWKAivp6LyL/2X6FymkfF6LSYB3PtDBbYmWysM3Wy8ZrWe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717892205; c=relaxed/simple;
	bh=8PttiA9qX1ppAfmp7V/1vw8qoL/BRA/i9JdfFrSKFb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cQxUOFPJbtzoq/juiHqVZsdAqpoqM3U2NRc5LETD6MFcIGjY2ktrlqe66Cfg/4eZN9R5FW3GLhUo+bCi/oXJyKkQxiJ/ms+d/+eH3q1HWj2Db047byGkFjlzrDyxKW1iqsTeOMYnWfVJNtmmTOy+TtWgDy04jG8wtVGhvFM0/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name; spf=pass smtp.mailfrom=bouton.name; dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b=tGc0jfy0; arc=none smtp.client-ip=109.74.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bouton.name
Received: from [192.168.10.100] (052559474.box.freepro.com [82.96.130.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.bouton.name (Postfix) with ESMTPSA id 55737C436;
	Sun,  9 Jun 2024 02:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bouton.name;
	s=default; t=1717892192;
	bh=EaZb5VrlGfmqV67marvJINFYYrRT9bkkmaLIV27JW5U=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=tGc0jfy0d4qPF3xoJp/zvJ2L6E4qUI4jcrs9d6V/rqa4/TxxBkCyxvLBotIiOVbru
	 q/t4eV07edlHHTp5xVTIAtdVgVqE1zQP5Hyrz4GCM+F8fcLzV9sjcJe5BmfbJcdkc4
	 Two3R1spCAEexVuRq5IDLmzG61Z/u8eo1LVmNifI=
Message-ID: <e6bfb0b9-dd9f-46d5-ae77-c90047a4cb04@bouton.name>
Date: Sun, 9 Jun 2024 02:16:29 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
 <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
 <80456d11-9859-402c-a77c-5c3b98b755a5@gmx.com>
 <abe791bd-0e3e-4a07-a1ff-923231e145ad@bouton.name>
 <a75a1a98-b150-470d-acf5-6e504a2202fc@bouton.name>
 <41a2a18f-6937-400a-b34b-c89b946535e1@gmx.com>
From: Lionel Bouton <lionel-subscription@bouton.name>
Content-Language: en-US
In-Reply-To: <41a2a18f-6937-400a-b34b-c89b946535e1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/06/2024 à 00:48, Qu Wenruo a écrit :
>
>
> 在 2024/6/9 01:45, Lionel Bouton 写道:
>> Hi,
>>
>> To keep this short I've removed most of past exchanges as this is just
>> to keep people following this thread informed on my progress.
>>
>> Le 07/06/2024 à 01:46, Lionel Bouton a écrit :
>>>
>>> [...]
>>>>> I briefly considered doing just that... but then I found out that the
>>>>> scrub errors were themselves in error and the on disk data was 
>>>>> matching
>>>>> the checksums. When I tried to read the file not only didn't the
>>>>> filesystem report an IO error (if I'm not mistaken it should if the
>>>>> csum
>>>>> doesn't match) but the file content matched the original file fetched
>>>>> from its source.
>>>>
>>>> Got it, this is really weird now.
>>>>
>>>> What scrub doing is read the data from disk (without bothering page
>>>> cache), and verify against checksums.
>>>>
>>>> Would it be possible to run "btrfs check --check-data-csum" on the
>>>> unmounted/RO mounted fs?
>>>
>>> Yes with some caveats as the scrub takes approximately a week to
>>> complete and I can't easily stop the services on this system for a 
>>> week.
>>> The block device is RBD on Ceph, so what I can do is take a block
>>> level snapshot, map this snapshot to another system and run btrfs
>>> check --check-data-csum there. If the IO is the same than btrfs scrub
>>> this will probably take between 3 to 5 days to complete. I'll have to
>>> run this on another VM with the same kernel and btrfs-progs versions,
>>> BTRFS doesn't like having 2 devices showing up with the same internal
>>> identifiers...
>>>
>>>>
>>>> That would output the error for each corrupted sector (without
>>>> ratelimit), so that you can record them all.
>>>> And try to do logical-resolve to find each corrupted location?
>>>>
>>>> If btrfs check reports no error, it's 100% sure scrub is to blamce.
>>>>
>>>> If btrfs check reports error, and logical-resolve failed to locate the
>>>> file and its position, it means the corruption is in bookend exntets.
>>>>
>>>> If btrfs check reports error and logical-resolve can locate the 
>>>> file and
>>>> position, it's a different problem then.
>>>
>>> OK. I understand. This is time for me to go to sleep, but I'll work on
>>> this tomorrow. I'll report as soon as check-data-sum finds something
>>> or at the end in several days if it didn't.
>>
>> There is a bit of a slowdown. btrfs check was killed a couple hours ago
>> (after running more than a day) by the OOM killer. I anticipated that it
>> would need large amounts of memory (see below for the number of
>> files/dirs/subvolumes) and started it on a VM with 32GB but it wasn't
>> enough. It stopped after printing: "[4/7] checking fs roots".
>>
>> I restarted btrfs check --check-data-csum after giving 64GB of RAM to
>> the VM hoping this will be enough.
>> If it doesn't work and the oom-killer still is triggered I'll have to
>> move other VMs around and the realistic maximum I can give the VM used
>> for runing the btrfs check is ~200GB.
>
> That's why we have --mode=lowmem exactly for that reason.
>
> But please be aware that, the low memory usage is traded off by doing a
> lot of more IO.
>

After the OOM I remembered reading discussions about the lowmem mode but 
even then I wasn't sure how to know at which point it would be needed : 
on one hand 32GB seems like a lot for a <20TB filesystem but this 
filesystem has both many files and snapshots.

The metadata uses 75.4GB and I assume it is for the 2 copies of the dup 
profile. If most of the RAM used by check is a copy of the metadata, 
64GB should be enough this time.

The process is using 35.4G at the "checking fs roots" step and it has 
been so for several hours now.

Thanks for your patience,
Lionel

> Thanks,
> Qu
>>
>> If someone familiar with btrfs check can estimate how much RAM is
>> needed, here is some information that might be relevant:
>> - according to the latest estimations there should be a total of around
>> 50M files and 2.5M directories in the 3 main subvolumes on this 
>> filesystem.
>> - for each of these 3 subvolumes there should be approximately 30
>> snapshots.
>>
>> Here is the filesystem usage output:
>> Overall:
>>      Device size:                  40.00TiB
>>      Device allocated:             31.62TiB
>>      Device unallocated:            8.38TiB
>>      Device missing:                  0.00B
>>      Device slack:                 12.00TiB
>>      Used:                         18.72TiB
>>      Free (estimated):             20.32TiB      (min: 16.13TiB)
>>      Free (statfs, df):            20.32TiB
>>      Data ratio:                       1.00
>>      Metadata ratio:                   2.00
>>      Global reserve:              512.00MiB      (used: 0.00B)
>>      Multiple profiles:                  no
>>
>> Data,single: Size:30.51TiB, Used:18.57TiB (60.87%)
>>     /dev/sdb       30.51TiB
>>
>> Metadata,DUP: Size:565.50GiB, Used:75.40GiB (13.33%)
>>     /dev/sdb        1.10TiB
>>
>> System,DUP: Size:8.00MiB, Used:3.53MiB (44.14%)
>>     /dev/sdb       16.00MiB
>>
>> Unallocated:
>>     /dev/sdb        8.38TiB
>>
>>
>> Best regards,
>> Lionel
>


