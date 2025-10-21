Return-Path: <linux-btrfs+bounces-18129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053EBF8448
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 21:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1562344F4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89323D7C6;
	Tue, 21 Oct 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="u4UQtYZl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F8350A03
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075174; cv=none; b=Qi/lGPwe5IF/gBcCX/yzYY+EICeWCbTA/X1old6Lp836/ur7U4oDy8kCIRSNzNsUeuXUsL/mtZUH8PMbCiTU4KHedktrK/OELNuxoQc95Ree9b0vGANXHUnNYJ5quU+QrPFxR1scz6kBxodAIY1/hR2gT79EweCM9g0kPyNlRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075174; c=relaxed/simple;
	bh=YQWCyYlPcpld6ZIpgUmvfYZAWoZmq1XYeN5Z6LD2mB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q4ZrzOitIqmnSHjrcs/kpkxa0E9gALOpUhbdzS0beyoZdCm8U8KJUUza+M+GE60zuuOKep8oxw8RILS3cy2SZLUbv9+GXjVQaV9g9oPMS4XiIPvb0QnXzA76kg83imhoVvCiAcg9QcvawDRTqr4yj+uye/t1fq/RtVLC6XaPNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=u4UQtYZl; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id BI67vv7ml32S3BI67v5pIu; Tue, 21 Oct 2025 21:32:44 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1761075164; bh=Vm434qcd4jL41OY3YIQWbd34aYYENY7p2EraB9YMoaU=;
	h=From;
	b=u4UQtYZlmqj34ksikS92njKUMmoDn4YVnVPvASg0mo4loXqY/uYOaYSKd5iMbSBoA
	 2iJMR0kmefXjEc3IqU8ZF79h/z1t8U4SJAYuITwoPxDdONazptKi4pNtNFnEn/oG+I
	 PkqLto7yqcuNuI3cToKJq86wXzYZrjMYsLmWSvNCRXbRjbuxiFtbCoKNNqJGl2q0B2
	 kxk9RVyERX/SDokLTZhm/Xw5jTrEaZotkUpYCbnnqTryMgEeX37EMLKl3/rbbJtmsO
	 uL+WDvVw9hYprFKgFXNQRimMtfi5L9j5yXGdBsx8fL5pHs9euR+vdwRMCiiYAw/03U
	 tITdazzt6l4Lw==
X-CNFS-Analysis: v=2.4 cv=Tu3mhCXh c=1 sm=1 tr=0 ts=68f7dfdc cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=scLe4AieO7Rvc7EbDaYA:9 a=QEXdDO2ut3YA:10
Message-ID: <2a0a802c-0879-4ae4-9eb1-31b1a02efff4@libero.it>
Date: Tue, 21 Oct 2025 21:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: Mark Harmstone <mark@harmstone.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
 <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
 <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
 <76ac6739-806e-4e6b-acb3-ebfba74cb8f3@harmstone.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <76ac6739-806e-4e6b-acb3-ebfba74cb8f3@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHKAhTIIxlBk/uc1PdbuKrZZ+OOAWS6Yu6lLyFd16Omz3fDcur+vVaAs7PErm4rmhBXOJl+MzmbOLif6Yyr2WkeebR7eMINkauPgc+lGp/zUB7+FRFeM
 MB+SPXToB0jpBfU8LTaci1TCpG013KQNb4m408Mjw8lUu2mOa5iEyO6yAROfd3HHZB4tBmXLMr8Mwl1VkKvu3LRSVG8wVL4E0YYfjh9rP6T5W+K45Co9ZOvj
 f0oN4HPMRi7Bp1xPxOTaLQ==

On 21/10/2025 18.45, Mark Harmstone wrote:
> On 21/10/2025 4.53 pm, Christoph Anton Mitterer wrote:
>> On Tue, 2025-10-21 at 16:46 +0100, Mark Harmstone wrote:
>>> The brutal truth is probably that RAID5/6 is an idea whose time has
>>> passed.
>>> Storage is cheap enough that it doesn't warrant the added latency,
>>> CPU time,
>>> and complexity.
>>
>> That doesn't seem to be generally the case. We have e.g. large storage
>> servers with 24x 22 TB HDDs.
>>
>> RAID6 is plenty enough redundancy for these, loosing 2 HDDs.
>> RAID1 would loose half.
>>
>>
>> Cheers,
>> Chris.
> So for every sector you want to write, you actually need to write three
> and read 21. That seems a very quick way to wear out all those disks.
> And then one starts operating more slowly, which slows down every write...
  
Yes, it is true that the classic raid5/6 doesn't scale well when the number
of disks grows.

However I still think that there is room to a different approach. Like putting
the redundancy inside the extent to avoid an RMW cycles. This and the
fact that in BTRFS the extents are immutable, would avoid the slowness
that you mention.

> I'd still use RAID1 in this case.
> 
This is faster, but also doesn't scale well (== expensive) when the storage
  size grows.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

