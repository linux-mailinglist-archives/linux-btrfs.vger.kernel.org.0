Return-Path: <linux-btrfs+bounces-1991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21EA845542
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA6B2910F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF215CD68;
	Thu,  1 Feb 2024 10:25:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25F4DA19;
	Thu,  1 Feb 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783136; cv=none; b=ghCs1OI/Q6h6wKwGCKOnUIh/hx4N8UTDqcmmhiakrFb6fvQ+144OuMRzswzItUCD8Q9EDhY8bFTZWSPi2pysukfDOlMeOJXG+eUDPdEmizO0+2BMAeZqyi9HS9avLC+47aiiLp7Lkqqke0CwqF3NDC59dHQQuQGau1KJLqHgOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783136; c=relaxed/simple;
	bh=OQNMfD7l22pZXc5xj4re2mrx8QNM3zdYIZ3qCt93++8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TazCTMV7fNR6sRc+R+R96Wg3VVingr4RIFP9opupRSyCO488tJl7kADLlARANNSfYwfhlS/alLsMNCliISDTMGqiIOB3/j5LG262Lk08DpIGCz3TH+rwoLJwBJDUUn5j8OKELSkdNGmIxmOhm203JAy/mwadsxeIhl1cs8p1Z9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rVUG9-00036B-Bn; Thu, 01 Feb 2024 11:25:29 +0100
Message-ID: <7d3cee75-ee74-4348-947a-7e4bce5484b2@leemhuis.info>
Date: Thu, 1 Feb 2024 11:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] commit bc27d6f0aa0e4de184b617aceeaf25818cc646de breaks
 update-grub
Content-Language: en-US, de-DE
To: Anand Jain <anand.jain@oracle.com>, Alex Romosan <aromosan@gmail.com>,
 CHECK_1234543212345@protonmail.com, brauner@kernel.org
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 dsterba@suse.cz
References: <CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com>
 <39e3a4fe-d456-4de4-b481-51aabfa02b8d@leemhuis.info>
 <20240111155056.GG31555@twin.jikos.cz> <20240111170644.GK31555@twin.jikos.cz>
 <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <f45e5b7c-4354-87d3-c7f1-d8dd5f4d2abd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706783133;05226587;
X-HE-SMSGID: 1rVUG9-00036B-Bn

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Anand, what's the status wrt to below issue (which afaics seems to
affect quite a few people)? Things look stalled, but I might be missing
something, that's why I ask for a quick update.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 12.01.24 00:24, Anand Jain wrote:
> On 11/01/2024 22:36, David Sterba wrote:
>> On Thu, Jan 11, 2024 at 04:50:56PM +0100, David Sterba wrote:
>>> On Thu, Jan 11, 2024 at 12:45:50PM +0100, Thorsten Leemhuis wrote:
>>>>
>>>> On 08.01.24 15:11, Alex Romosan wrote:
>>>>>
>>>>> Running my own compiled kernel without initramfs on a lenovo thinkpad
>>>>> x1 carbon gen 7.
>>>>>
>>>>> Since version 6.7-rc1 i haven't been able to to a grub-update,
>>>>>
>>>>> instead i get this error:
>>>>>
>>>>> grub-probe: error: cannot find a device for / (is /dev mounted?) solid
>>>>> state drive
>>>>>
>>>>> 6.6 was the last version that worked.
>>>>>
>>>>> Today I did a git-bisect between these two versions which identified
>>>>> commit bc27d6f0aa0e4de184b617aceeaf25818cc646de btrfs: scan but don't
>>>>> register device on single device filesystem as the culprit. reverting
>>>>> this commit from 6.7 final allowed me to run update-grub again.
>>>>>
>>>>> not sure if this is the intended behavior or if i'm missing some other
>>>>> kernel options. any help/fixes would be appreciated.
>>>>
>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>> tracking bot:
>>>>
>>>> #regzbot ^introduced bc27d6f0aa0e4de184b617aceeaf25818cc646de
>>>> #regzbot title btrfs: update-grub broken (cannot find a device for /
>>>> (is
>>>> /dev mounted?))
>>>> #regzbot ignore-activity
>>>
>>> The bug is also tracked at
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218353 .
>>
>> About the fix: we can't simply revert the patch because the temp_fsid
>> depends on that. A workaround could be to check if the device path is
>> "/dev/root" and still register the device. But I'm not sure if this does
>> not break the use case that Steamdeck needs, as it's for the root
>> partition.
> 
> 
> Thank you for the report.
> 
> The issue seems more complex than a simple scenario, as the following
> test-case works well:
> 
>   $ mount /dev/sdb1 /btrfs
>   $ cat /proc/self/mountinfo | grep btrfs
> 345 63 0:34 / /btrfs rw,relatime shared:179 - btrfs /dev/sdb1
> rw,space_cache=v2,subvolid=5,subvol=/
> 
> However, the relevant part of the commit
> bc27d6f0aa0e4de184b617aceeaf25818cc646de that may be failing could
> be in identifying a device, whether it is the same or different
> For this, we use:
> 
>      lookup_bdev(path, &path_devt);
> 
> and match with the devt(MAJ:MIN) saved in the btrfs_device;
> would this work during initrd? I need to dig more. Trying
> to figure out how can I reproduce this.
> 
> Thanks, Anand
> 
> 

