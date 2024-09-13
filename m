Return-Path: <linux-btrfs+bounces-7988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFC9778A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 08:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034471F25B60
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149B1AB6CA;
	Fri, 13 Sep 2024 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="IIOs+OTN";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="Qaq+4rOP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AA4A07
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207964; cv=none; b=K2iVmM8DFrqYXEiSlj9NNLQwh49BI7G3E7aymuc5ErfjX1BF6/8kosyaNop7gi7m1ViHouQuyWs/xKTA5qjqDD8yZL7R4OKnUvjlOBz+VpUbx8K5yPwSAqJW6R9IXGx80OvWznSsZcgcP3TqOh9jYWhCcW+AQQLsNz9xFOEG5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207964; c=relaxed/simple;
	bh=aBkyvFTy8IfeOQFR0YQwymJnIuL+txKyLkZQ2aYII1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=W0B3zYeRXRaZdGPGX3puKlN6jjcMzIUQC7eVniX/vRuzg2eB8vU+zcfRm29w1bHa5dDmYGUZyZvRj+fL3k2xaimqy1LVWioeVy1D8nYIvs1wFXpVyAQ/eNUEYOdEuPBZ4BPjp5rNQmk3NLp9SYAojeQIJB9dIgrgnsmbczRdq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=IIOs+OTN; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=Qaq+4rOP; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <fe0726b6-002c-43b9-91b1-dd04e296fc58@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726207958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDjPSdeVt7dFa2MHgmyybbo/I6d2/PLlmRNZWA6d8Bo=;
	b=IIOs+OTNFlafs3o5sr4hZMlB0sHlivvqf+SaEERSIuo2dCmvGRAuDKV/5M3ISh0nUE47du
	/YKKSMiHyWBnMvQL+RJHRLsm02bcOc+Sf05QkoMErzuni7/PtZQUuQ8oITSJLOBSUfOwlC
	DwO4yBaa85rNq9Eu7EYAKzUGQXZjovosNZsRjzR0okLEucT4wZV2j0nobFcF3qlAEtlhjR
	XkXQxu0bYJ5vQnSFa9nvDmOwyokXx/ZgvbaxZ3lR1exM/wb+VYvu3CE3GmNAJ4tAuvlH4h
	zBb8sD1JxewqMDmcxVtaoSF2eDlMjCtTlSlXLxCCYhSu0D8UFDSM77v9Sb5qXExMXGgQjR
	TzG5K5WRvlHoWlbFepAoImYcwxBbdzF3WaCxbm3cS1Ux99XCAfF33kw5r2QO9G8Erq/FNC
	4mGuMN9uoJyZergWlFbXA1lrKW8sFhW0FQysMNFAYLN/16QOSC1sfUuuQ34lBGaUuwVKiL
	vq8SBDld1DYDVpEBR53U2auGo+b7REFwRUmZLQuNYHzlLGlpOnaIMKh9dVUDIANW5bqO8j
	0sij2o4lbiWKbVEKuidLqLKmFpABdipBpa6i6B3dS/IqBfhRXz2kzz8gWuUwKc/td3j7mi
	R4no6QCIg3kUHIKgzq/X/oEEdH0Er3gr+bEm7P6f+fRPqro/P10Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726207959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDjPSdeVt7dFa2MHgmyybbo/I6d2/PLlmRNZWA6d8Bo=;
	b=Qaq+4rOPuEzCee0urm8lL+5tMpSGyXpbMcYTNNq/GOs1JbER2zSb7qN5VuNuUeecAutx2o
	ve8YkaeXki9Tk4BA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Fri, 13 Sep 2024 10:12:29 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
From: Archange <archange@archlinux.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
 <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
 <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
 <1ee66f34-b855-4a96-bf75-a3d14b9ce392@suse.com>
 <c275d2c9-20d9-46ce-82ab-3f86c091a5d3@archlinux.org>
 <84938a9c-97ba-4f90-8e66-bdfabf455146@gmx.com>
 <0c9fe0ac-9a98-4f72-bb87-361070c32772@archlinux.org>
Content-Language: fr-FR, en-GB-large
In-Reply-To: <0c9fe0ac-9a98-4f72-bb87-361070c32772@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/09/2024 à 09:54, Archange a écrit :
> Le 13/09/2024 à 09:29, Qu Wenruo a écrit :
>> 在 2024/9/13 14:55, Archange 写道:
>> [...]
>>>> And it's indeed a false alert.
>>>>
>>>> In that case, as long as you still have unallocated space, you can
>>>> just relocate the system chunks:
>>>>
>>>> # btrfs balacne start -s <mnt>
>>>>
>>>> Which should move the system chunks to new locations and will not
>>>> utilize the first 1MiB reserved space.
>>>
>>> # btrfs balance start -s /
>>> ERROR: Refusing to explicitly operate on system chunks.
>>> Pass --force if you really want to do that.
>>>
>>> According to https://btrfs.readthedocs.io/en/latest/btrfs-balance.html,
>>> -s requires -f, so I guess I should continue with that?
>>
>> Yes.
>
> Hum, no success:
>
> # btrfs balance start -s --force /
> ERROR: error during balancing '/': No space left on device
> There may be more info in syslog - try dmesg | tail
>
> # dmesg
> [ 2919.917607] BTRFS info (device dm-0): balance: start -f -s
> [ 2919.918105] BTRFS info (device dm-0): 1 enospc errors during balance
> [ 2919.918108] BTRFS info (device dm-0): balance: ended with status: -28
>
> Indeed,
>
> # btrfs filesystem show /dev/mapper/root
> Label: 'root'  uuid: e6614f01-6f56-4776-8b0a-c260089c35e7
>     Total devices 1 FS bytes used 439.69GiB
>     devid    1 size 476.87GiB used 476.87GiB path /dev/mapper/root
>
> There is unused space though, but not sure how to reclaim it.
>
> $ btrfs filesystem df /
> Data, single: total=472.87GiB, used=438.21GiB
> System, single: total=4.00MiB, used=80.00KiB
> Metadata, single: total=4.00GiB, used=1.48GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
> As advised on the balance page, I’ve tried to run with `usage=0` as 
> filter (for both m, s and d), but the result is always:
>
> Done, had to relocate 0 out of 480 chunks

OK, ramping usage until something was moved did the trick.

Thanks again for your help,
Archange


