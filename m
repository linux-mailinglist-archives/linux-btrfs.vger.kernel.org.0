Return-Path: <linux-btrfs+bounces-21655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEDeLABTjmmlBgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21655-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 23:24:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7715713181A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 23:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA2F030405C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 22:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4182FE563;
	Thu, 12 Feb 2026 22:23:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mtafr.prnet.org (mtafr.prnet.org [54.38.152.168])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2A261B92;
	Thu, 12 Feb 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.38.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935028; cv=none; b=XCeAeC0M3HcnMFoQBFtE7LJ3udVTLqbvyUd4pjMZiJlVfFm9gvp9fc+sQ7d3NUXR23cxNWszr1uBHIriQa/YJVqv6wu5jn9jDxR6GTDxFAbv5OI9aSV+kGdQJVrte8huUnJ1ZdJbJuE/WgiiazgCRIBnoL5bhl8b0ef73FaD7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935028; c=relaxed/simple;
	bh=1lJZTEsVYEFdbl8KMEFBkfZm9PQynTuS91keAuDmlMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jPKW7fZ+j7htGyJu8SKtInyw2/js8nI1GGnJo4RdlyGOSNzgFnKjkuok9Tt0mtzB1W9qmqgCAAdQdp0YlMeqwGMCjwgKLyJNBBug3a4wyiy5pfVYETb2OskvPN7ldXnpMC2769cJYe6NgNt37spiKOpE8+2dGhF0VmXaaBL9VB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org; spf=pass smtp.mailfrom=prnet.org; arc=none smtp.client-ip=54.38.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prnet.org
Received: from secure.prnet.org (unknown [10.1.0.1])
	by mtafr.prnet.org (Postfix) with ESMTP id 5409B2004D;
	Thu, 12 Feb 2026 23:24:10 +0100 (CET)
Received: from [IPV6:2001:7e8:cf00:bc01:8cac:7fff:fe9e:52] (unknown [IPv6:2001:7e8:cf00:bc01:8cac:7fff:fe9e:52])
	by secure.prnet.org (Postfix) with ESMTPSA id 86CC810003F;
	Thu, 12 Feb 2026 23:23:44 +0100 (CET)
Message-ID: <de166323-bb9d-4240-bc42-08ae32067284@prnet.org>
Date: Thu, 12 Feb 2026 23:23:44 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Orange PI 5 MAX: very unstable using kernel 6.19.0 and 6.18.10,
 6.18.9 perfectly stable
To: Qu Wenruo <wqu@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-rockchip@lists.infradead.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ebe4d76-eb07-499b-b140-1f300c1b8d7e@prnet.org>
 <f95f0d27-5bee-4363-b0f0-75e95b2a470d@suse.com>
Content-Language: en-US
From: David Arendt <admin@prnet.org>
In-Reply-To: <f95f0d27-5bee-4363-b0f0-75e95b2a470d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[prnet.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[admin@prnet.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21655-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7715713181A
X-Rspamd-Action: no action

On 2/12/26 10:05 PM, Qu Wenruo wrote:
>
>
> 在 2026/2/13 06:41, David Arendt 写道:
>> Hello,
>>
>> I am using a Kubernetes Cluster with 3 Orange PI5 MAX nodes. The data 
>> is stored using a btrfs filesystem as backend. If using kernel 6.19.0 
>> or kernel 6.18.10 I have experienced many crashes during high IO load 
>> on all 3 nodes. Reverting back to 6.18.9 solves the problems 
>> completely. Unfortunately the crashes are spontaneous reboots without 
>> leaving a trace in any logfile, so I have no stacktrace of them. 
>> After the crashes I have sometimes incorrect btrfs csums for a file 
>> but these may also be a result of a partial write due to the crash. 
>> On one node I had a btrfs error logged without crashing, but I am not 
>> sure if this is the root cause or a result of a prior crash. A scrub 
>> after reboot returned no error with 6.19.0.
>
> The offending tree dump items are:
>
> Feb 10 13:31:07 opi02 kernel:  item 92 key (13218356101120
> Feb 10 13:31:07 opi02 kernel:  item 93 key (13216208642048
> Feb 10 13:31:07 opi02 kernel:  item 94 key (13218356162560
>
> Obviously item 93 is smaller than all its previous and next item keys.
>
> hex(13218356101120) = 0xc05a36b8000
> hex(13216208642048) = 0xc05236be000
> hex(13218356162560) = 0xc05a36c7000
>
> It looks like something fliped, "0xc05a3" -> "0xc0523"
>
> 0xa -> 0x2 is exactly one bit flipped.
>
> So either the memory hardware has something wrong and resulting a 
> sticking bit (always 0), or there is something inside the kernel 
> touching memory it shouldn't.
>
> And this exactly matches the symptom, changing random bit of your 
> kernel, crash always expected.
>
>
> Can you run a memtest to make sure it is not hardware problems first?

Hello,

I don't know of anything like memtest86 for the arm64 platform for 
testing the whole memory, so I used the user space memtester to check 
the 14G of unused ram on all 3 machines while using kernel 6.18.10.

Here is the result of the first iteration (same on every machine):

memtester version 4.7.1 (64-bit)
Copyright (C) 2001-2024 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 14000MB (14680064000 bytes)
got  14000MB (14680064000 bytes), trying mlock ...locked.
Loop 1:
   Stuck Address       : ok
   Random Value        : ok
   Compare XOR         : ok
   Compare SUB         : ok
   Compare MUL         : ok
   Compare DIV         : ok
   Compare OR          : ok
   Compare AND         : ok
   Sequential Increment: ok
   Solid Bits          : ok
   Block Sequential    : ok
   Checkerboard        : ok
   Bit Spread          : ok
   Bit Flip            : ok
   Walking Ones        : ok
   Walking Zeroes      : ok

I don't think it is hardware a failure as it is happening on 3 different 
machines. Crashes occur somewhere between 30 minutes and 12 hours on all 
3 machines that have been running without a single crash for more than a 
year now with older kernel versions including 4 days with 6.18.9 and all 
version from 6.18.0 to 6.18.9, so it seems to be caused by something 
that has changed between 6.18.9 and 6.18.10.

Thanks,

David Arendt

>
> Thanks,
> Qu
>
>
>>
>> Unfortunately I don't have more information at the moment.
>>
>> Thanks in advance,
>>
>> David Arendt
>>
>>
>


