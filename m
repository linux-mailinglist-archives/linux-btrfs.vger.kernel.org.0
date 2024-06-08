Return-Path: <linux-btrfs+bounces-5575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3029012B3
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B74328209C
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC3176AD9;
	Sat,  8 Jun 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b="fpWf1VHg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D5179675
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.195.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717863357; cv=none; b=gsx7Cn/V1BTA70AVQxd76HXhG4uPoxjZn5AjnKcpjAdZ+Pbjn83SxSvaghapjHdyEaX1itgkgzaGumSkjSeZcFv8l4Fal19MhVyWMiTc01dM0q64mN7pcvBe7Eo/jp0p71dWSYEIiw0UMc0f7DhEJQL/ylQ1yVj/g9eiBK9m390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717863357; c=relaxed/simple;
	bh=EN7GN18mu2fIKovBzPFoMqM1MnZlBVmB8P31tPyV67M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Who5p8c06FNUbM1gpclNUcSR5y/yJdyVAT3ZrMPdYjLaFXzO1nk1et2bi/Z7MM7Prrwl78rkLIq1L2QwrAXuNj1Rt4yLVMVQDLhfT7H6G17vZTTWUk1SecPJtFl8ku+eU/mwlA3e19gKVyycCNlg6f5R+F3hUEX75XhOwbTOc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name; spf=pass smtp.mailfrom=bouton.name; dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b=fpWf1VHg; arc=none smtp.client-ip=109.74.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bouton.name
Received: from [192.168.10.100] (052559474.box.freepro.com [82.96.130.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.bouton.name (Postfix) with ESMTPSA id 9E3A6C42D;
	Sat,  8 Jun 2024 18:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bouton.name;
	s=default; t=1717863337;
	bh=4GkntJYCHOkjp7fXtgoD7vut4HPM/qaoAn7srfVAiNs=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=fpWf1VHgxmH1tgdKiSwBydbekdS16ObtVFHjFTcYJyvoiCDn42eDaAgrwpoVux2J3
	 poHmP4cr+ZPm+wIkR5cg/b8BHvTFQsa6A/Q4IuuPMmSCLYOnjWZJnwjSWSuURcL9tN
	 8aCzytqA14o9xZvfIeNwN5tgtXhh0W7G8k+BjFFc=
Message-ID: <a75a1a98-b150-470d-acf5-6e504a2202fc@bouton.name>
Date: Sat, 8 Jun 2024 18:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
From: Lionel Bouton <lionel-subscription@bouton.name>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
 <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
 <80456d11-9859-402c-a77c-5c3b98b755a5@gmx.com>
 <abe791bd-0e3e-4a07-a1ff-923231e145ad@bouton.name>
Content-Language: en-US
In-Reply-To: <abe791bd-0e3e-4a07-a1ff-923231e145ad@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

To keep this short I've removed most of past exchanges as this is just 
to keep people following this thread informed on my progress.

Le 07/06/2024 à 01:46, Lionel Bouton a écrit :
>
> [...]
>>> I briefly considered doing just that... but then I found out that the
>>> scrub errors were themselves in error and the on disk data was matching
>>> the checksums. When I tried to read the file not only didn't the
>>> filesystem report an IO error (if I'm not mistaken it should if the 
>>> csum
>>> doesn't match) but the file content matched the original file fetched
>>> from its source.
>>
>> Got it, this is really weird now.
>>
>> What scrub doing is read the data from disk (without bothering page
>> cache), and verify against checksums.
>>
>> Would it be possible to run "btrfs check --check-data-csum" on the
>> unmounted/RO mounted fs?
>
> Yes with some caveats as the scrub takes approximately a week to 
> complete and I can't easily stop the services on this system for a week.
> The block device is RBD on Ceph, so what I can do is take a block 
> level snapshot, map this snapshot to another system and run btrfs 
> check --check-data-csum there. If the IO is the same than btrfs scrub 
> this will probably take between 3 to 5 days to complete. I'll have to 
> run this on another VM with the same kernel and btrfs-progs versions, 
> BTRFS doesn't like having 2 devices showing up with the same internal 
> identifiers...
>
>>
>> That would output the error for each corrupted sector (without
>> ratelimit), so that you can record them all.
>> And try to do logical-resolve to find each corrupted location?
>>
>> If btrfs check reports no error, it's 100% sure scrub is to blamce.
>>
>> If btrfs check reports error, and logical-resolve failed to locate the
>> file and its position, it means the corruption is in bookend exntets.
>>
>> If btrfs check reports error and logical-resolve can locate the file and
>> position, it's a different problem then.
>
> OK. I understand. This is time for me to go to sleep, but I'll work on 
> this tomorrow. I'll report as soon as check-data-sum finds something 
> or at the end in several days if it didn't.

There is a bit of a slowdown. btrfs check was killed a couple hours ago 
(after running more than a day) by the OOM killer. I anticipated that it 
would need large amounts of memory (see below for the number of 
files/dirs/subvolumes) and started it on a VM with 32GB but it wasn't 
enough. It stopped after printing: "[4/7] checking fs roots".

I restarted btrfs check --check-data-csum after giving 64GB of RAM to 
the VM hoping this will be enough.
If it doesn't work and the oom-killer still is triggered I'll have to 
move other VMs around and the realistic maximum I can give the VM used 
for runing the btrfs check is ~200GB.

If someone familiar with btrfs check can estimate how much RAM is 
needed, here is some information that might be relevant:
- according to the latest estimations there should be a total of around 
50M files and 2.5M directories in the 3 main subvolumes on this filesystem.
- for each of these 3 subvolumes there should be approximately 30 snapshots.

Here is the filesystem usage output:
Overall:
     Device size:                  40.00TiB
     Device allocated:             31.62TiB
     Device unallocated:            8.38TiB
     Device missing:                  0.00B
     Device slack:                 12.00TiB
     Used:                         18.72TiB
     Free (estimated):             20.32TiB      (min: 16.13TiB)
     Free (statfs, df):            20.32TiB
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:30.51TiB, Used:18.57TiB (60.87%)
    /dev/sdb       30.51TiB

Metadata,DUP: Size:565.50GiB, Used:75.40GiB (13.33%)
    /dev/sdb        1.10TiB

System,DUP: Size:8.00MiB, Used:3.53MiB (44.14%)
    /dev/sdb       16.00MiB

Unallocated:
    /dev/sdb        8.38TiB


Best regards,
Lionel

