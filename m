Return-Path: <linux-btrfs+bounces-10720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D450A012DF
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 08:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3523A4641
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6D14A639;
	Sat,  4 Jan 2025 07:11:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AB13AD26
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735974711; cv=none; b=LGuFc2Y/B/nlKxFXzJbSvcmlr5ey233pLwgXZfZubdfKVYNGjPA+Vr0loqxNBjbN40AGu6AKILqWqEu1YnETrsK7lNepcc6Arv9ysDDI9bunDL7uAneE2Cm9WjgaKaOi9nm5gQ6DZCsciSSM+wylL8hvF2k0wF1Kl2JQrb3f6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735974711; c=relaxed/simple;
	bh=PSgk9K7ypMYU1nrOsBIFImsYdy81lDbPNSWR047uaVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tk5n1zWl+eMvCqSfk98HVagtY95hmyM8c0J4cPa+BbishVO7v4QVJ7cWtlcih+BZqGQLNhhqEkqwg7TaVeKPvRh8CN/tA6GpW1CtMtA81/f7Q4eRc3MwFQcInkDQN4+jiP7OG6ThsvufX0olgCwvCsGU1O0APvQSrojijm0vUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 4773AC08DB9
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 08:11:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6Q1tZYd9k28J for <linux-btrfs@vger.kernel.org>;
	Sat,  4 Jan 2025 08:11:42 +0100 (CET)
Received: from [192.168.55.34] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 42C75C05B98
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 08:11:42 +0100 (CET)
Message-ID: <957d6a7a-e57e-43c0-b5c9-67276946220a@dubiel.pl>
Date: Sat, 4 Jan 2025 08:11:40 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
 <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
 <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
 <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
 <000bcef0-a86e-4832-90bb-9a4a47afad6d@dubiel.pl>
 <5d045808-1f34-4dd3-bb82-71da628ccaf6@gmail.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <5d045808-1f34-4dd3-bb82-71da628ccaf6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



>>
>>   > If you want to be extra safe, the best solution is to use tools that
>> can report the usage percentage of each block group.
>>   >
>>   > You need something procedure like this:
>>   >
>>   > start:
>>   >     if (unallocated space >= 8GiB)
>>   >         return;
>>   > check_usage_percentage:
>>   >     if (no block group has usage percentage < 30%) {
>>   >         delete_files;
>>   >         goto check_usage_percentage;
>>   >     }
>>   >     balance dusage=30
>>   >     goto start;
>>   >
>>   > Although there are some concerns, firstly the tool, sorry I didn't
>> remember the name but there is an out-of-btrfs-progs tool can do exactly
>> that.
>>
>> In btrfs-progs package I didn't find any such tool.
>>
>> There is "btrfs maintenance" by kdave:
>>
>>                        https://github.com/kdave/btrfsmaintenance
>>
>> but it starts normal balance, it doesn't analize "block usage 
>> percentage".
>>
>
> https://github.com/knorrie/btrfs-heatmap
>
> https://github.com/knorrie/python-btrfs
>
> The latter is general Python library to work with btrfs and various 
> (sample) tools, like btrfs-balance-least-used or btrfs-usage-report.
>

Ok, thank you for support. I will look for that tools and try them.



PS.

For other people searching information:



— on Github "'no space left on device' despite only 59% fill" — good 
help from kakra:

https://github.com/btrfs/btrfs-todo/issues/61



— old reading on Marc's Blog "Fixing Btrfs Filesystem Full Problems"

https://marc.merlins.org/perso/btrfs/post_2014-05-04_Fixing-Btrfs-Filesystem-Full-Problems.html



— superuser thread, clear_cache, skip_balance:

https://superuser.com/questions/1419067/btrfs-root-no-space-left-on-device-auto-remount-read-only-cant-balance-cant











