Return-Path: <linux-btrfs+bounces-18120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC6BF7765
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94D7E356476
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25213341AC1;
	Tue, 21 Oct 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="X2oRsrzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79B3451A6
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061580; cv=none; b=ZcDix+ruG5z6pTVdel3Fb3tR1WDzvaMXEGbRPvfAkD44DsL6VTH9o3sGBvqNlANHH/OGMJP2cfk1kJdCfuQOyzMd3jq9C9Dt3jJPHrcip2HvH8nYSp/qPbtUNwj6/F88hdii+lPr3mAb0Si9WCm9Sek/yhNB/pKLdT2lGi4Bfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061580; c=relaxed/simple;
	bh=obGPafWa/GlfDAyv9NdgnthYkwJ9bH/AFRtvlpSMTc0=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ALUOOUmGlr2BNQji1FExlIBQUYt0+VAQEJQeF+skYghV7+ffvEqWfgNnbzp9lkgQg22D8t2y9l01dsL76m1RLBE2PlKAPEkCG1BqSJH6w0bXO92QUuNm89fTJmupzOVi+j1tFxaS8DikTM0+9K1dC3R0XiN2Vb6Q3x9ZDKlVr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=X2oRsrzd; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 263C92CE0CF;
	Tue, 21 Oct 2025 16:46:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761061565;
	bh=6Ni6D7dTAZLlY3FlH9md2xUV0rD7oq2Tn8h7RkV2h8c=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=X2oRsrzd0SFSJasQSH9rV8GasSAFrPEl5HpZIVb32cP8cyWucJ9DnJK+JZ/XuFrmQ
	 1hsue/wc6l6fkaCHK+4X+8P602lkaxhjxAq7gEV9cqS2ua16lbIJJXKwDY9TM3LDrh
	 FfLQ532S+QzTGR1ipqkpDYgq0pN/uTfMHz6UgI7Y=
Message-ID: <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
Date: Tue, 21 Oct 2025 16:46:04 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: DanglingPointer <danglingpointerexception@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2025 2.02 am, DanglingPointer wrote:
> Are there any plans to work on either of the proposed solutions mentioned here to once and for all fix RAID56?

The brutal truth is probably that RAID5/6 is an idea whose time has passed.
Storage is cheap enough that it doesn't warrant the added latency, CPU time,
and complexity.

If I had four 4TB drives I would probably go for RAID1 data and RAID1C4
metadata.
> On 22/9/25 17:41, Qu Wenruo wrote:
>>
>>
>> 在 2025/9/22 16:39, Ulli Horlacher 写道:
>>>
>>> I have 4 x 4 TB SAS SSD (from a deactivated Netapp system) which I want to
>>> recycle in my workstation PC (Ubuntu 24 with kernel 6.14).
>>>
>>> Is btrfs RAID5 ready for production usage or shall I use non-RAID btrfs on
>>> top of a md RAID5?
>>
>> Neither is perfect.
>>
>> Btrfs RAID56 has no journal to protect against write hole. But has the ability to properly detect and rebuild corrupted data using data checksum.
>>
>> Meanwhile MD raid56 has journal to protect against wirte hole, but has no checksum to know which data is correct or not.
>>
>>>
>>> What is the current status?
>>>
>>
>> No extra work is done for btrfs RAID56 write hole for a while.
>>
>> The experimental raid-stripe-tree has some potential to address the problem, but that feature doesn't support RAID56 yet.
>>
>>
>> Another solution is something like RAIDZ, which requires block size > page size support, and extra RAID56 changes (mostly much smaller stripe length, 4K instead of the current 64K).
>>
>> The bs > ps support is not even merged, and submitted patchset lacks certain features (RAID56 ironically).
>> And no formal RAIDZ support is even considered.
>>
>> So you either run RAID5 for data only and ran full scrub after every unexpected power loss (slow, and no further writes until scrub is done, which is further maintanance burden).
>> Or just don't use RAID5 at all.
>>
>> Thanks,
>> Qu
>>
> 



