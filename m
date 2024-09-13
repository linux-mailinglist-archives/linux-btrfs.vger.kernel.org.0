Return-Path: <linux-btrfs+bounces-7986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8D977888
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34021F258DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 05:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA979187356;
	Fri, 13 Sep 2024 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="AFrN714g";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="+UxOKmp4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764D1865E6
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206901; cv=none; b=agV+Ig3S6GlgUpOHdvwqd6WN3HvAaxu9+y20JCETjgsn1oTBdo+k7v+6hl7jvskILqPn6kx6AjCIsfnCswXxiKTcbIGysWxNR+hbcf+SJFYe0M1eKYvoTbnCbaPNS0ei+VNExcR5ejKdLqe2zfhL9Yx2F96j4zrXR1+EBdrVc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206901; c=relaxed/simple;
	bh=xHi5ZUXrG+ky1eR9CDq5oyk01BpRrxMQGJ7jx7biw04=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=co2iukqcO/i4QF7oyXrtFGScImuvNzJTk/4MfUtwVbe33T0nuFxuAA8aQfYmx8NFm/DCuNq7FDgWFqYtDk/GR6k6ELJox1f40ovc3QZTj9vJg+MWpFFIONL+9WNMbbY1v8OdRv7i8X6RWTBaqDO3k58+6SOb6Y61KAqnFp2T9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=AFrN714g; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=+UxOKmp4; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <0c9fe0ac-9a98-4f72-bb87-361070c32772@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726206896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8RwfUF01Tqgngj/wig5n7WHIVwCfBbAJVY1z1qJUvw=;
	b=AFrN714g6H7eQG7mCqT7vOlyvo9rSRP+4Kck67Itc+/whSE3kqfZPUVia3BgKBudF6vy6+
	O9SpgE98epEoalLllhJWHVbOJevsLKBK4VTUKyw9AfxVCOy4ph4MysYp+hLnrr0ymiENCv
	Xh5UsWfdxnpmpL7xoviYkOv2shm/3OtqDkiqbAxvL+EOvp7A0VWdXDzlDk05hEj05Rld4U
	mVnC1fFtClGK2F47IoAv/rPOUVrjLMS3a/zXl8Ck5SKDp2jSaKrPJDUlCYP93kGcXAPv1M
	AlWK+xTWt7uj9RahW40yeuyC44COHef7ZES9uu3bxTAuC62emJpShBfHOVSvTxGPRqzNbA
	+JfvwbRnXE1+O2Re5Y+5d17LS+NUryCMcQtwsyCBijuGWKBeJcbP0dwixYEom3tKsFjpX+
	l35jq/l74W7VXl8OXgcJ761ymsEuWdXxfvBBNJs00s35GqXoR1gUmW2Q1t2/MV6ev3FSxV
	EYK7p10PgZBcAx1KjqPNNFafTWO1wez/2nHUh0B1uu5AGGDeutyHdhdLvvd6cA0Y3d/L5w
	mxXXSWcteK8017upL+lNSxUUgbeJ6MxQTFNIWzBc6Kes8svGlWf5emq03O+Mm5+6rQ8XzT
	UmSDk+9P17BYsGnB3cBxQK5RrSOcR2xpH78a4mq9tjdIxUTh5B+9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726206896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8RwfUF01Tqgngj/wig5n7WHIVwCfBbAJVY1z1qJUvw=;
	b=+UxOKmp4wKnTsIRUh+plfMU2fJMmltY0z0hHL1BhhHb1SESWRtWSVONI/0GEBjcAR4pA1R
	fQCHmRunXY1+xQAg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Fri, 13 Sep 2024 09:54:49 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
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
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <84938a9c-97ba-4f90-8e66-bdfabf455146@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/09/2024 à 09:29, Qu Wenruo a écrit :
> 在 2024/9/13 14:55, Archange 写道:
> [...]
>>> And it's indeed a false alert.
>>>
>>> In that case, as long as you still have unallocated space, you can
>>> just relocate the system chunks:
>>>
>>> # btrfs balacne start -s <mnt>
>>>
>>> Which should move the system chunks to new locations and will not
>>> utilize the first 1MiB reserved space.
>>
>> # btrfs balance start -s /
>> ERROR: Refusing to explicitly operate on system chunks.
>> Pass --force if you really want to do that.
>>
>> According to https://btrfs.readthedocs.io/en/latest/btrfs-balance.html,
>> -s requires -f, so I guess I should continue with that?
>
> Yes.

Hum, no success:

# btrfs balance start -s --force /
ERROR: error during balancing '/': No space left on device
There may be more info in syslog - try dmesg | tail

# dmesg
[ 2919.917607] BTRFS info (device dm-0): balance: start -f -s
[ 2919.918105] BTRFS info (device dm-0): 1 enospc errors during balance
[ 2919.918108] BTRFS info (device dm-0): balance: ended with status: -28

Indeed,

# btrfs filesystem show /dev/mapper/root
Label: 'root'  uuid: e6614f01-6f56-4776-8b0a-c260089c35e7
     Total devices 1 FS bytes used 439.69GiB
     devid    1 size 476.87GiB used 476.87GiB path /dev/mapper/root

There is unused space though, but not sure how to reclaim it.

$ btrfs filesystem df /
Data, single: total=472.87GiB, used=438.21GiB
System, single: total=4.00MiB, used=80.00KiB
Metadata, single: total=4.00GiB, used=1.48GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

As advised on the balance page, I’ve tried to run with `usage=0` as 
filter (for both m, s and d), but the result is always:

Done, had to relocate 0 out of 480 chunks

> And I also recommend to convert your metadata and system chunks to DUP,
> if there are enough unallocated space.
> (If have more devices then RAID1).
>
> It looks like the old mkfs defaults to SINGLE for SSDs, but nowadays we
> keep DUP no matter if it's SSD or not.

Alright, but I guess I need to solve -ENOSPC first…

Thanks,
Archange


