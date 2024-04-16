Return-Path: <linux-btrfs+bounces-4318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E88A7538
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 22:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11291B22A82
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB587139CE7;
	Tue, 16 Apr 2024 20:07:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D981386A8
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298043; cv=none; b=nyJwGzcCvjNN9/9MhM7hpwJ6j2nx9CJ/IuNq77gx2Hk4fC5IckzACdVAEfcpCEU/UGyshQENTZfOiqFapmUy8dSPFrLlmNtlQdgznKcry/fCDoRTouEgwpIa4C3bjG4dsy1NEkjOh+XwMLFmi6wxr6xwdVJdTICsPLlXa2VWeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298043; c=relaxed/simple;
	bh=GVKv2UNCjOU+S6eP/UWN8cHS+vsoVaSEpZLfVU79SzE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ZJe60NuABa7nfIYdHr2YHwPfxDtQhRImAM3WryTr6z4xbLHUrxLnd9JlvPTiEuCVLa8/ypuAJprSQxj+YJ7In58QF9vv1cciJDjuDD9D2ls46A5GWdWHfr+bxYW+KuRZLXryT0lyi836hxiuDuXog2Wf1mniIsO6V2dpbuASPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 1F52CC0801C
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 22:07:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DLuvXUZQcY_p for <linux-btrfs@vger.kernel.org>;
	Tue, 16 Apr 2024 22:07:15 +0200 (CEST)
Received: from [192.168.1.195] (unknown [81.56.116.160])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 4CDC8C08007
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 22:07:15 +0200 (CEST)
Message-ID: <99701acc-161b-477c-b1b3-d61e95903045@dubiel.pl>
Date: Tue, 16 Apr 2024 22:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: =?UTF-8?Q?Re=3A_enospc_errors_during_balance_=E2=80=94_how_to_preve?=
 =?UTF-8?Q?nt_out_of_space?=
To: linux-btrfs@vger.kernel.org
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
 <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe>
 <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl>
 <3aefeb1.20bf1a80.18ee7da3d40@tnonline.net>
Content-Language: pl-PL
In-Reply-To: <3aefeb1.20bf1a80.18ee7da3d40@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> It is not wise to balance metadata block groups

I have never run balancing with musage=.

Disk got full.
I remove snapshots.
Run balance with  dusage= many times.
Hit "no space" error agian.
As a last rescue try i used  musage=0.
This helped.


In script from Kdave:

https://github.com/kdave/btrfsmaintenance/blob/be42cb6267055d125994abd6927cf3a26deab74c/btrfs-balance.sh#L55

Anyway — I will use musage as a last resort.





>   Btrfs needs unallocated disk space to be able to allocate new data or metadata chunks

Yes, thank you.






>   If it cannot allocate new data chunks you will see an out of disk space error. However if btrfs cannot allocate new metadata chunks, the filesystem will turn read-only, making it much harder to fix - as you cannot balance or add additional space in an read-only filesystem.

Now I understand it. :)




>> I started to run this script from cron every 10 minutes:
>>
>>
>> #!/usr/bin/bash
>>
>> mount | sed -nr 's%^/dev/sd[a-z][0-9] on (/[/_[:alnum:]]+) type btrfs
>> .*$%\1%; T; p' |
>> while read mnt; do
>>       if
>>           btrfs dev usage "$mnt" -g |
>>           perl -ne '/Unallocated: +([0-9]+\.[0-9]{2})GiB/ and $1 < 64 and
>> print $1' |
>>           grep -q .
>>       then
>>           echo "porządkować $mnt"
>>
>>           for usa in $(seq 0 10 100); do
>>               # I don't know whether to start with "dusage" or "musage",
>> so i shuffle it;
>>               # 15 april 2024 my serwer was locked, "dusage" returned
>> "enospace", and it
>>               # got unlocked after "musage=0"
>>               {
>>                   echo d $usa
>>                   echo m $usa
>>               } | shuf
>>           done |
>>           while read typ usa; do
>>
>>               echo; echo; date; echo "balance type=$typ, usage=$usa"
>>
>>               out="$(btrfs balance start -${typ}usage=$usa,limit=3 "$mnt"
>> 2>&1)"
>>               echo "$out"
>>
>>               # if nothing was done, then try higher usage
>>               echo "$out" | grep -q "had to relocate 0 out of" && continue
>>
>>               # otherwise finish: on error or on successful relocate
>>               break
>>           done
>>       fi
>> done
>>
> Do you mean you run this continuously on your filesystem? This is normally not required and will increase wear on your disks.

Yes. But it runs balance only when Unallocated is less then limit.


>> Thanks for hints :) :)
>>
>> This solves my questions:
>>
>> 1. i have to rebalance when Unallocated is low
>>
>> 2. i have to keep 2Gb at least.
> You should keep at least 1GB x profile mode. That is for DUP, 2GB, and for RAID1, at least 1GB on two devices.

Great info. :)

My raid is 3 disk, so I will set limit of 3 disk * 1Gb = 3Gb minimum.


> It would be better to have more, to be safe.
>
> An option that could be used is 'bg_reclaim_threshold', which is a sysfs knob to let the kernel automatically reclaim (balance) block groups that fall under a specific threshold.
>
> https://btrfs.readthedocs.io/en/latest/ch-sysfs.html

On my system it is set to 75.

Disk got full.
I remove snapshots.
Disk showed it has free space 1Tb out of 8TB.
And I got "no space" error again.
I spotted then "Unallocated = 1 MiB",
then started to balance by hand.

I will observe that system and test all i know from your help.
Thank you.



# cat 
/sys/fs/btrfs/ec3525ef-b73a-452a-a4ee-86286252d730/bg_reclaim_threshold
75


# btrfs fi show /
Label: none  uuid: ec3525ef-b73a-452a-a4ee-86286252d730
     Total devices 3 FS bytes used 7.22TiB
     devid    1 size 5.43TiB used 5.36TiB path /dev/sdc3
     devid    2 size 5.43TiB used 5.36TiB path /dev/sda3
     devid    3 size 5.43TiB used 5.37TiB path /dev/sdb3



# btrfs fi df /
Data, RAID1: total=8.00TiB, used=7.18TiB
System, RAID1: total=32.00MiB, used=1.36MiB
Metadata, RAID1: total=43.00GiB, used=39.31GiB
GlobalReserve, single: total=512.00MiB, used=48.00KiB








