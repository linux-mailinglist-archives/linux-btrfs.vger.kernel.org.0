Return-Path: <linux-btrfs+bounces-7544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5092596027A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 08:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749091C220E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3915359A;
	Tue, 27 Aug 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aJsLXZat"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396954F87
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741522; cv=none; b=C0E3ikYiZzgL6YeKFLCNkIVxNvUn3jFxe/muhc9usS6Wm640bUYMukgJg5yUntQQlSPbYJTqgomTxFjn9ckNrnFUlfjo1hYPoL/YIt5i0KG1VfU2319xjQ7bu6jVYl0bNQAdU6DsXoChVgfBV0uCOpC1QbP1cdWOCq5WDWLzUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741522; c=relaxed/simple;
	bh=6ohVE7AxKNXOhM0bcOoBX9r1cT6kUPaBhdfDBnKGkt4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ABGKLvLM6Zw1qabSnzbD9DgAcj5cDtoaMg36pJlKPDSPtu4NC5T4vJ5oVd2egnYQgnixOlafHIVFhWlCTEjMjPnGfK557AT8RDnsto/ZTLW0NiKJIoQL6QWM5FAx2rZZjbWJV4R+K2oNc1NyYqnIO7GNiRY7i0vMfKSQVEjLNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aJsLXZat; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724741511; x=1725346311; i=quwenruo.btrfs@gmx.com;
	bh=6ohVE7AxKNXOhM0bcOoBX9r1cT6kUPaBhdfDBnKGkt4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aJsLXZat1rQSezb8klX1aVQJ7hjbKtsHwrSNOCfcJT6/C6BFtXypO1Fifip+uH+e
	 RrwtGC4EHX1FMZixgIslgcYWW6DdF9T3q6Ec79kqBZIQDKWcfHWbZ14Xv4S2Ujbdr
	 08+D75l0kGYoqWC+pDnbIgqoZWr7NysQBjuCTQLxo+POCqpIrp+1mTGLXVBEOu0cW
	 0VUbi/MCzcAU0agty57cnQjj1mcZxNDEXy7oZCau1t43SVb1PDk5hIY1qmemFNgGs
	 uRr/6n+wr5O4wzVX7Pb66EhU4sVOgGzT5eY0WZCiEC2YZiO+mdANT7GSZjidoGiT9
	 hncOpTvUvYs3SgKwOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1sb1WV1P4e-00Qncu; Tue, 27
 Aug 2024 08:51:51 +0200
Message-ID: <bc8701ab-0054-48c7-88d9-6fd9e856cde7@gmx.com>
Date: Tue, 27 Aug 2024 16:21:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
 <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6f7117dd-a9ba-4c0a-be4b-6adae1be98d3@gmx.com>
Content-Language: en-US
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <6f7117dd-a9ba-4c0a-be4b-6adae1be98d3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oC4d1fw/1LN/HmyLqPk+M8UFG9RMVD0wujQOCy5WavLh/7hr1xB
 tToYmhI6IfhB/6LeGpAWr5CymKupayTgTGB/5Q6ZYFlFEDlX0CM1+yZ1qQH8JDopLvRhUOK
 /kLvrPipX45A+5HgV0TST5zaB1Qf83Ej0ogqQ8lawTccaQeJsoeggNeSkqjpnTPEza8JRXf
 Pw3E80ctXs8Lh/vG7a99A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6kiwjc0Wds=;Lpvyb2Xe/3JeVOnPjWWe6pP63sh
 dMG+V7e0Gc+6YgjZtBAZczV8OuIslKXXF7T+GlgH3XP+prCXq2o1XLM/DICDSo6h6VX84V/53
 n0y+SF4TKzV1IFYT9GQPcf/EbQSIHvK8051jWMbO/JZtId6JEazhtKg5I78O4xgqoIaHdF+mh
 CFj3f4uO8RaPFRmXntzD68U+WCyPG++r2efNRaoLqCY33iUZ2rwpd36EGH+25jG+LtwiFW7I4
 a0gv4pUi07ONPFYjOPCjto/rKoh7lE1MQ1/ebnWbXkEEIafHD0vtuFvP3ZPL22MB6MEIjZlcn
 3hxDJN6OMXD6SflNkZFSisI3j/0YxTwGdlgK+O8UBKNiVPN6YnDBQBjAlwCRHGppQ8wdJk0JC
 gtnqoHc8GDDq87Aj30Fdq90H07fIGXCxNt/0y7wn7B6vP6SoNLZ7XmchZI5ZFbBRcQ28nrqG1
 QDe6xO94QhiGySXy05orDrB1imM4Fgw34r5mTe7uOW1KfTCtUnq2W8XBufmJWA5iCc/pKPTa6
 pWYwYZHSsOy68UhXI7xxZF+mUjh3EoI8xSnv6SGoXoKhTZYYtg2/tWzj1rrJOCb1AVM6c8TDy
 48EIN0x7bYyNjq2j0tI3OoX4CTUU+Gv/mtHrGTZXE0p2KR5dHpKmSiBEOQad+jdA3EaEPIp60
 hmM/G8sN/zyq27k7VxYiHsinm5aX6+QgwjuzzirL0lyDQHKSEZL4ihr4lGmjJlWQLQzOC/xlB
 Gee/Ei7WEP9zrfSU/ULfY68Wkc0oSG2Q1zXH7Qvu8tWEs0q4P9stS0N076de5SrYHwMCG0seW
 pZqO2ZIDTXAr1E2JddTQNb4q9SgMNeRjKfN04B6J7KlCA=



=E5=9C=A8 2024/8/27 14:49, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/8/27 10:17, Pieter P =E5=86=99=E9=81=93:
>> On 27/08/2024 01:18, Qu Wenruo wrote:
>>> After your latest --repair try, the fs should be more or less fine, yo=
u
>>> can try remove the offending file.
>>>
>>> Just a minor problem left with the superblock used bytes, that can be
>>> fixed by another "btrfs check --repair" run very safely.
>>
>> No luck, unfortunately. Removing the file fails (automatically gets
>> re-mounted read-only, and the file re-appears), and btrfs check --repai=
r
>> fails to repair the super bytes_used error (output attached).
>>
>>> Another possibility is, the fs is old and you just migrated the drive/=
fs
>>> to the current platform, but I doubt about the case considering the fi=
le
>>> is some browser cache, which shouldn't be that old.
>>>
>>> Just in case, mind to try something like memtest86+ (UEFI payload) or
>>> memtester (inside the OS) to rule out the hardware problem?
>>
>> The fs is only around 1.5 years old, it never left the system. The file
>> was last modified on July 22. I'll run another memtest.
>
> Anyway considering it's not going to be resolved by repair, I can craft
> a dedicated tool, if you can compile btrfs-progs.
>
> That should fix modify that specific file extent (root 257 ino 50058751
> filepos 0) by changing its on-disk bytenr to the correctly.
>
> Will let you know when the tool is done (should be pretty soon)

Here is the hand crafted fix for you:

https://github.com/adam900710/btrfs-progs/tree/dirty_fixes

The usage is:

# ./btrfs-corrupt-block -X <device>

The fs must be unmounted.

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> Thank you,
>> Pieter
>>
>

