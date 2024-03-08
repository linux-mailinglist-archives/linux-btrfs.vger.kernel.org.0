Return-Path: <linux-btrfs+bounces-3094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB2876148
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920641F23DEB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0966535CA;
	Fri,  8 Mar 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b="q3Mdw5qk";
	dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b="g10KV6r+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C948535C2
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.138.97.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891514; cv=none; b=HBrpBnb6r2TwdlIm0zQGqF8R8esYa1V4cVDS6o4N8S4Ks4pgTzmbOyQQvaLtTjmjTo5RGktUlOrIjNRIF29KW1nDJZstutzLlpBqQ2bS6jLH3gZo/susp2vgANlVFcR7syDZ+YbR6umqkPlbCepeDoQXN4OWcNsm2gYkAcuhDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891514; c=relaxed/simple;
	bh=2YcJtj8w4ZcCzjwQy3ZhxICG1eCZZtHdXSDGrLZhT2o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=mG3Ikx1kB0cOzyGUDMj7HLd/HqT6TD8sICtaMpIB0KwrV6WiCrc3z2MbOv0c7q3kkOAJjcky9cQliNtECnwue6NfYQIU/cMUJbsJk/fQiZQAaOVYjyVfP4mUInK6w6vEUXDpBI6ud2cZM2CL+A/+KKFb9j2Af5GtAX5TKyrN3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cobb.uk.net; spf=pass smtp.mailfrom=cobb.uk.net; dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b=q3Mdw5qk; dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b=g10KV6r+; arc=none smtp.client-ip=213.138.97.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cobb.uk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cobb.uk.net
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
	id 9D3849B92F; Fri,  8 Mar 2024 09:45:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
	s=201703; t=1709891146;
	bh=2YcJtj8w4ZcCzjwQy3ZhxICG1eCZZtHdXSDGrLZhT2o=;
	h=Date:From:Subject:To:References:Cc:In-Reply-To:From;
	b=q3Mdw5qkQPaGIv56DzhHQlZMy7P9noEc7kzT1EJqZJ+lTQX/2p/nIo0rPgQzqWJcq
	 zQrjDUppVialmgjBA7+c9aKYMbTUtovhbT+aFl1nO2sOLgxmDyo3E94fjLGh7Ah7eM
	 ThaRm/PuxiywfybNJetrf8o+TSt3EY1T2vKq57JK+3VfgFxWz6W4Ab9OodXJeXm7G9
	 RX3iDVoYSbJNSKXoi1yieq+cA4+mSk2HQEWc1tdHUlosbH3KIiL6LJke8KGrRmSbKE
	 HgU7tfG/S1V8l1NoNPZPki3QmabUrSYyUC6TwiUNZmrFvklhafDqd9KsFvwkRJNzFd
	 Jmiwm3QdId0eA==
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
	by zaphod.cobb.me.uk (Postfix) with ESMTP id 9AA789B909;
	Fri,  8 Mar 2024 09:45:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
	s=201703; t=1709891117;
	bh=2YcJtj8w4ZcCzjwQy3ZhxICG1eCZZtHdXSDGrLZhT2o=;
	h=Date:From:Subject:To:References:Cc:In-Reply-To:From;
	b=g10KV6r+iqR4uiLAXUBRv6ziOiq9ATtcSt+9zD4NrWfuKm2/OQc7GpT/UzloxQVdm
	 B79Wy/2WhWyxkQ5aHIRBKDhuUGgzTM3HJ16WAHflW/B2lhkyL1I3/K1KmckaIlG+ce
	 uep6ksZvpH1L+awY/zUQmr5Z1OZ7xRbw8qHa4irudeLsZlCuo/ZiVhlZkwA9gRvaa2
	 i/QPNh5TzJcyS0m2evFoOt5fY9QDt2jCleVge2ZPxDGIazsWNx2u/UYxbNgSfhORG/
	 htcP5XiHv4CpCOsnR8nfyqbM+YsadsxdbhZmqLaM2NwIISIpinv/HcdpqeC8mrIFRK
	 AgHGuK1bUI9gg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
	by black.home.cobb.me.uk (Postfix) with ESMTP id 6A6C81C3EDE;
	Fri,  8 Mar 2024 09:45:17 +0000 (GMT)
Message-ID: <fcfab114-c1a0-4059-990d-e4724b457437@cobb.uk.net>
Date: Fri, 8 Mar 2024 09:45:17 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: scrub: last_physical not always updated when scrub is cancelled
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
 <ba3a8690-1604-429e-9e8a-7c381e6592f8@gmx.com>
Cc: Michel Palleau <michel.palleau@gmail.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <ba3a8690-1604-429e-9e8a-7c381e6592f8@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

By the way, I have noticed this problem for some time, but haven't got 
around to analysing it, sorry. I had actually assumed it was a race 
condition in the user mode processing of cancelling/resuming scrubs.

In my case, I do regular scrubs of several disks. However, this is very 
intrusive to the overall system performance and so I have scripts which 
suspend critical processing which causes problems if it times out (such 
as inbound mail handling) during the scrub. I suspend these processes, 
run the scrub for a short while, then cancel the scrub and run the mail 
for a while, then back to suspending the mail and resuming the scrub. 
Typically it means scrubs on the main system and backup disks take 
several days and get cancelled and resumed *many* times.

This has worked for many years - until recently-ish (some months ago), 
when I noticed that scrub was losing track of where it had got to. It 
was jumping backwards, or even, in some cases, setting last_physical 
back to 0 and starting all over again!!

I haven't had time to track it down - I just hacked the scripts to 
terminate if it happened. Better to have the scrub not complete than to 
hobble performance forever!

If anyone wants to try the scripts they are in 
https://github.com/GrahamCobb/btrfs-balance-slowly (see 
btrfs-scrub-slowly). A typical invocation looks like:

/usr/local/sbin/btrfs-scrub-slowly --debug --portion-time $((10*60)) 
--interval $((5*60)) --hook hook-nomail /mnt/data/

As this script seem to be able to reproduce the problem fairly reliably 
(although after several hours - the filesystems I use this for range 
from 7TB to 17TB and each take 2-3 days to fully scrub with this script) 
they may be useful to someone else. Unfortunately I do not expect to be 
able to build a kernel to test the proposed fix myself in the next 
couple of weeks.

Graham


On 08/03/2024 00:26, Qu Wenruo wrote:
> 
> 
> 在 2024/3/8 07:07, Michel Palleau 写道:
>> Hello everyone,
>>
>> While playing with the scrub operation, using cancel and resume (with
>> btrfs-progs), I saw that my scrub operation was taking much more time
>> than expected.
>> Analyzing deeper, I think I found an issue on the kernel side, in the
>> update of last_physical field.
>>
>> I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a basic
>> btrfs (single device, 640 GiB used out of 922 GiB, SSD).
>>
>> Error scenario:
>> - I start a scrub, monitor it with scrub status and when I see no
>> progress in the last_physical field (likely because it is scrubbing a
>> big chunk), I cancel the scrub,
>> - then I resume the scrub operation: if I do a scrub status,
>> last_physical is 0. If I do a scrub cancel, last_physical is still 0.
>> The state file saves 0, and so next resume will start from the very
>> beginning. Progress has been lost!
>>
>> Note that for my fs, if I do not cancel it, I can see the
>> last_physical field remaining constant for more than 3 minutes, while
>> the data_bytes_scrubbed is increasing fastly. The complete scrub needs
>> less than 10 min.
>>
>> I have put at the bottom the outputs of the start/resume commands as
>> well as the scrub.status file after each operation.
>>
>> Looking at kernel code, last_physical seems to be rarely updated. And
>> in case of scrub cancel, the current position is not written into
>> last_physical, so the value remains the last written value. Which can
>> be 0 if it has not been written since the scrub has been resumed.
>>
>> I see 2 problems here:
>> 1. when resuming a scrub, the returned last_physical shall be at least
>> equal to the start position, so that the scrub operation is not doing
>> a step backward,
>> 2. on cancel, the returned last_physical shall be as near as possible
>> to the current scrub position, so that the resume operation is not
>> redoing the same operations again. Several minutes without an update
>> is a waste.
>>
>> Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
>> last_physical field with the start parameter after initialization of
>> the context.
> 
> Indeed, we're only updating last_physical way too infrequently.
> 
>> Pb 2 looks more difficult: updating last_physical more often implies
>> the capability to resume from this position.
> 
> The truth is, every time we finished a stripe, we should update
> last_physical, so that in resume case, we would waste at most a stripe
> (64K), which should be minimal compared to the size of the fs.
> 
> This is not hard to do inside flush_scrub_stripes() for non-RAID56 
> profiles.
> 
> It may needs a slightly more handling for RAID56, but overall I believe
> it can be done.
> 
> Let me craft a patch for you to test soon.
> 
> Thanks,
> Qu
> 
> 
>>
>> Here are output of the different steps:
>>
>> # btrfs scrub start -BR /mnt/clonux_btrfs
>> Starting scrub on devid 1
>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
>> Scrub started:    Thu Mar  7 17:11:17 2024
>> Status:           aborted
>> Duration:         0:00:22
>>          data_extents_scrubbed: 1392059
>>          tree_extents_scrubbed: 57626
>>          data_bytes_scrubbed: 44623339520
>>          tree_bytes_scrubbed: 944144384
>>          read_errors: 0
>>          csum_errors: 0
>>          verify_errors: 0
>>          no_csum: 1853
>>          csum_discards: 0
>>          super_errors: 0
>>          malloc_errors: 0
>>          uncorrectable_errors: 0
>>          unverified_errors: 0
>>          corrected_errors: 0
>>          last_physical: 36529242112
>>
>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
>> scrub status:1
>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1392059|tree_extents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes_scrubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:1853|csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected_errors:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|duration:22|canceled:1|finished:1
>>
>> # btrfs scrub resume -BR /mnt/clonux_btrfs
>> Starting scrub on devid 1
>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
>> Scrub started:    Thu Mar  7 17:13:07 2024
>> Status:           aborted
>> Duration:         0:00:07
>>          data_extents_scrubbed: 250206
>>          tree_extents_scrubbed: 0
>>          data_bytes_scrubbed: 14311002112
>>          tree_bytes_scrubbed: 0
>>          read_errors: 0
>>          csum_errors: 0
>>          verify_errors: 0
>>          no_csum: 591
>>          csum_discards: 0
>>          super_errors: 0
>>          malloc_errors: 0
>>          uncorrectable_errors: 0
>>          unverified_errors: 0
>>          corrected_errors: 0
>>          last_physical: 0
>>
>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
>> scrub status:1
>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1642265|tree_extents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes_scrubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:2444|csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected_errors:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|duration:29|canceled:1|finished:1
>>
>> Best Regards,
>> Michel Palleau
>>
> 


