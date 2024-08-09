Return-Path: <linux-btrfs+bounces-7060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5C94C98A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 07:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BA41F23710
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 05:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75E16B75F;
	Fri,  9 Aug 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FKgvUcGj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8918E25
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180672; cv=none; b=biPsORsqV73RivJOR8h1m8waq3IK1s5LX4l/nLZoIQvMgNfSRSlCCI+50j45/7M9H9fie95QUoccBE2Z5vJ0TVrGuuZMhlJo+X6U3c7BXlTn68E8poaUeqmvFxmPKqJX8PBy0CXj7Ld0JxuOZxdSBnefocdWFmLiktDlkXRaQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180672; c=relaxed/simple;
	bh=EP0q0cd5tYA4kEciQokp4vnviQ7aeAA3DmdWXAPkCb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p0eyGdW+UPOci5ch5KCmgdDrLlSF2BlHO8BU5Y96Alh/R5B3rRtEfqEPOhbd79V14xhhkK3OATvbqybE5IfmpI76hAkIXLazSdX08vsbkOtLxaFDL0Mc3rTR+uyD2HsIPkGRXOgsRK/sSARqAZ9cysXJ7u2w0lFZAALRr/LDxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FKgvUcGj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723180665; x=1723785465; i=quwenruo.btrfs@gmx.com;
	bh=EP0q0cd5tYA4kEciQokp4vnviQ7aeAA3DmdWXAPkCb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FKgvUcGjrIeL7PNS1nr8pR6w1oGmYUpq6kimXY9eblxYFn9tV9UNu5V85u361XoR
	 geE6HMwCOY+O38Zk4R1rw3uFr6RWarWUV0vwLuqa03pAG7p9Z5MjQNRSrbyQnlPsH
	 QRrMggi65z6bFzYkZqnW8fl07+j6Y2W+jP0FJDFR9PZKmeAJcrQaFA2XnRk+rPIDC
	 kxOpGcAD9aebvYbiF1LSC8fGfodcsCNb7OsaxLbOf4kA9xKntTbV4ZdNqis1/O/GT
	 KZXjYmDiTaSptoKZpzcdiNZQqxwZOoYk5cMmUcG4cosDzu75I2HqhpT0PHdiJMROx
	 zxkCpQ8CpY38oeleHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1slfdz0G0Y-00SFkI; Fri, 09
 Aug 2024 07:17:45 +0200
Message-ID: <5ad9c2de-9f8b-4a1f-8c4d-788e35ba4899@gmx.com>
Date: Fri, 9 Aug 2024 14:47:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 =?UTF-8?Q?Andr=C3=A9_KALOUGUINE?= <andre.kalouguine@ensta-paris.fr>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <6c0cad97-2082-4209-8d30-05c4b0eecd0c@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <6c0cad97-2082-4209-8d30-05c4b0eecd0c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6XDa/uyOY9YhcwB8vA+bi2+iEsZOEqW5rUq+NLMgOD7syuy8oHA
 hKLTT3Y7B8XMCa4x3HyUruWl9VYW2W33Ss+XY2O72vrPGlF8zNvZSNoOVcdQCyyCaqaUJiV
 /gLbVcnJFEe7U993WdrZHcfT5Mo7FI5z+FVsG/hFKRYUPri21xrSuPZCGtWBNupXTjm5qa3
 X2A+banEeKJBaITpkX/uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8eIpJGmioJs=;T4eer46ZRjURiuRpJF1DUxRKNrp
 tcXBlgp9oIIxVSsbDsVHwLbePWmL8/3CxlZ/CWlC2k4yZoFpu1bDv/FCnXvx8KYfSA5bes+jc
 aLMZ3oaXgCnhNpcUT7BE/9LOf3MiiH5uIfzkE8tBOL2mttH+j+H1uXINrxzwuVJ/Wabr0bPR7
 KOrvaBYVH9bep95lQxv3yFgoJwZoDc74gMjd/m0UX9LNoG4xtdc7x0T3rLxNIyjkLS1kov6rl
 LoPbf3LdfdhkSU8k3uym4EPopVY6tsk9wONBeQ6MyCJWkVCXfOVwEl4JzR7Y+FuxU56H1deIU
 02ayGfiuKsiek+P/OepX+xloMfXm2tI68viWLGzFrf3IiHLiTs5dzgpWSfz00B/li/3bAjVLB
 PkBPQF5UQ07LtfR/wQRsxMaEIYRXs4su0hP/seZE6y6fBF4y02GaydSfGXvPlT74L2jZozg76
 bIhA0uFko6622mycFE2qb8Y86JyUSpiZQPIPP+1FW9u/TiFZumPTVS4bx+IRAvU78eNxYuaL0
 KyXJOAkUGcCSebNR9TaUvip+uBh5zhp41HoGe4ULqILQ7LcdeDldUfenUOzDHjOn4Hqe/oFxn
 4QOJbhIp1LvNvsZV+Pfdjcyaw/bgMAhbPGaMEkaL96+eKB9ldvacUeTVyfl3R8JfZuYmfd5U1
 KMJmGH2yUkw83L+QyR2DM2RwxAy7tsff4KWyIPlmZrzRZFe1/BTlcplQleIscegWx64r7AvY6
 o1kzwSHGXK7FLA5cddDW/kRIHG1Q059i+Ppftw6JtHtTvdnZZz4R/dSzOIS42Z/m9jT9qArdb
 3C+KrfYo4vEGfsXCJDJ0yJWw==



=E5=9C=A8 2024/8/9 13:33, Andrei Borzenkov =E5=86=99=E9=81=93:
> On 09.08.2024 01:28, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/8/9 05:48, Andr=C3=A9 KALOUGUINE =E5=86=99=E9=81=93:
>>> Hi,
>>> I have a system running Arch Linux, kernel 6.10, with the system
>>> installed on a btrfs partition (with a @home subvolume). I had a
>>> kernel panic today and after hard rebooting, the disk can't be
>>> mounted. Under a live USB, mounting gives:
>>>
>>> BTRFS error (device nvme1n1p3): bad tree block start, mirror 1 want
>>> 211658031104 have 0
>>> BTRFS error (device nvme1n1p3): bad tree block start, mirror 2=C2=A0wa=
nt
>>> 211658031104 have 0
>>
>> This means some tree blocks are just wiped out from the disk.
>>
>> Either it's the async discard (which is now enabled by default as long
>> as the device supports, and I doubt it's the case) or the hardware is
>> not properly doing flush.
>>
>
> But it apparently has redundant profile (I assume, dup in this case, as
> it is the same device). What are chances to lose both copies of the data
> at the same time?
>
If flush operation is not properly handled, then the submitted both copy
will not reach disk, while the device reports they have reached disk.

If the device is not properly handling FLUSH, then it's no different
than "nobarrier" mount option.

And that can easily cause both copy to be lost.

Another possibility is, some NVME firmware has automatic dedup, thus the
DUP profile makes no different than single.

I have to say the whole firmware thing is rabbit hole, but I'm not sure
if discard is involved either.

Thanks,
Qu

