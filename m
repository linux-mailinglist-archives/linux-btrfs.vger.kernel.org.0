Return-Path: <linux-btrfs+bounces-18126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A89E6BF7F0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 19:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BD74E734F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7034834C801;
	Tue, 21 Oct 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="pt+kOzGu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6EE34C153
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068644; cv=none; b=eKCiQgU0FQlMQ+hCgD+PDqjFoCnpr9ArbX5M+qLfpTQVeeUlrdOHxPNapl1CAoxsC+I5XAEKY2H5wUfzlNwv0GjychhJYCbxEMKYP+j1IJ4iLHl4rS+t/O1ryKudgLjk+/MqkKFO9hBU6W4m0HZTuHSQ7LwkomTTCZ4rnCbHLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068644; c=relaxed/simple;
	bh=HkRGPd8xx5Zlj/9zmI/TGIxnGxrSYIqQqOH0TtTjrFw=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cNwg1jYmOpH0te/GJaeT7ulTDpZ395TNUclAtSb+R91XXjUg8OImyuOZx0ucD8Z8vE5+g2hZrR92SUUxqzD6IAlZbKkKOV3YzR3FJ55mClbgASxuOwgTTFsWgrK32IPrahZ4DSTzPSYkbglXFG6wQcZ8XDMvb2ERlUN7BsgMZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=pt+kOzGu; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id B548C2CE1B3;
	Tue, 21 Oct 2025 18:43:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761068637;
	bh=xibGc6gpbQH34Q3qir1AwkstggVaVwTObr7SEFJaOsc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=pt+kOzGuWIUl+z4snIrPzBB2u8wB3BKfNwXkmJwtchg3EeCjdkolSFoV2hS2yl0be
	 kJ1UpRKP4ZcYmsRcoMQTZDGATnEst/wIPH+EBOJkcaCnZ3BnsSQ9EF3emjO2FfoFG5
	 ryxJgxQ2qq1wpTVOR7tCiVpUJJN2QUdXvtoBD6B8=
Message-ID: <6482b960-40d8-4a64-9517-930e7f99f239@harmstone.com>
Date: Tue, 21 Oct 2025 18:43:57 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
 <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
 <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
 <76ac6739-806e-4e6b-acb3-ebfba74cb8f3@harmstone.com>
 <212e280e-475c-4259-a7e1-5e96b2713832@gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <212e280e-475c-4259-a7e1-5e96b2713832@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2025 6.32 pm, Andrei Borzenkov wrote:
> 21.10.2025 19:45, Mark Harmstone wrote:
>> On 21/10/2025 4.53 pm, Christoph Anton Mitterer wrote:
>>> On Tue, 2025-10-21 at 16:46 +0100, Mark Harmstone wrote:
>>>> The brutal truth is probably that RAID5/6 is an idea whose time has
>>>> passed.
>>>> Storage is cheap enough that it doesn't warrant the added latency,
>>>> CPU time,
>>>> and complexity.
>>>
>>> That doesn't seem to be generally the case. We have e.g. large storage
>>> servers with 24x 22 TB HDDs.
>>>
>>> RAID6 is plenty enough redundancy for these, loosing 2 HDDs.
>>> RAID1 would loose half.
>>>
>>>
>>> Cheers,
>>> Chris.
>> So for every sector you want to write, you actually need to write three
>> and read 21. 
> 
> RAID5 needs to read 2 sectors and write 2 sectors. Independently of the number of disks in the array.

This isn't the case for btrfs' implementation, which will stripe every chunk
over each disk if it can. Possibly other people do something different.

> It is more difficult to make any generic statement about RAID6 because to my best knowledge there is no standard parity computation algorithm for it, each vendor does something different. But simply adding the second parity block means you need to read 3 and write 3 blocks.
Likewise for btrfs' implementation of RAID6. I suppose this shows that if
anyone were ever to fix it, they would need to make sure that RAID6 chunks
get given 4 stripes rather than 24.

>> That seems a very quick way to wear out all those disks.
>> And then one starts operating more slowly, which slows down every write...
>>
>> I'd still use RAID1 in this case.
>>
> 


