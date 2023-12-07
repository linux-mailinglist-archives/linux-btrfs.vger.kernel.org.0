Return-Path: <linux-btrfs+bounces-754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA9809214
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 21:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB4B20D54
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A05025C;
	Thu,  7 Dec 2023 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sXf3ipd7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E1170F
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 12:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701979873; x=1702584673; i=quwenruo.btrfs@gmx.com;
	bh=ZMqL58BqiF3dWyk3+Y/AN0xYl9NKYVHZakLG1q9r9IE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sXf3ipd7uwkd3gy9an5hgvFqygwaq/4NGtBm8xv38R56+a7b4W4ZbgBf9D4wXa5/
	 3wTzegiz8itBOtWBcAPCe0Hl4cbtpTXb/dhgjansXGzF58QBGmOTqq3JGFrWM8/bj
	 ernPi8T28nBV19+hrmadrhNOuq4Xch2VHxWrnHk+tFXscRvLarWg/y55B8NF2SlVq
	 4IsZ4mzaeoVdplXvI2kC5hmnOh+0GW1P5XbGxktlMZ6tsKUdntYY0htYJCtLzvV25
	 FLDLOuqBKavKSXznHjo99EKtZHWYnD2b/EEH5v/IE7lePRDNZ1gghOX5wozgdr/Z9
	 xhHcjYj9H/tsdB5UCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCOE-1qqW2u2Q44-00NA4Y; Thu, 07
 Dec 2023 21:11:13 +0100
Message-ID: <f6dd7115-e365-4f02-960e-43e2c6a5bdf5@gmx.com>
Date: Fri, 8 Dec 2023 06:41:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: get rid of memparse() for sysfs operations
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Disseldorp <ddiss@suse.com>
References: <69524a828a08d8d88face116ea7563fd34275815.1701920169.git.wqu@suse.com>
 <20231207140906.GY2751@twin.jikos.cz>
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
In-Reply-To: <20231207140906.GY2751@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6386SoETUpEHsOWZAooRwblpDEVEDlJzAukt0LcVr2BZDXiNRl
 FeEmZ4G0C8AW9mklTxxUVp0cIkRugNU05lGssBJArbdXyeG4IL5RncMWlA/NtcS10gz8q5L
 m5oSUha2iFWP9F0wz5rwS0/CWz+Z3jXPYljansPc2dw+in1C6lCJ4MEP+cyV2JrjPdJWTIo
 qGad7INMXDFSl2t7wVAIQ==
UI-OutboundReport: notjunk:1;M01:P0:DWCUruloCHs=;8S8UZkBApF+LrxzJNX3FXpv4MnN
 OOf5EjfTjqo/sZ3SwAyp6KeuuHn5jPi4/lN2HzmFHwUBt4WwLxMmiAKBZDSr2UVS482aeYIK2
 bLqHdAdzjc3YGBHtUKd6ZCQzHfAWzvC+I3M/IW7eC1gyoHyr1UcSSx9Q3KZQeTzOcLMxtBNzQ
 uRTGicT34s5oSR9dz0kzfSpIfIzV/B63GYCrcOaKo0GwWqllvQ+sa+9ETNg1QBKdEzbQCkSmE
 wiiXHBqFOgroBZs//joPBMDPWZ5RQYWO5+3B7EUSrn0AJSvy467VibeUzEcqHWM8NbCM0+gj2
 0BJsK0NFT6CRpyyo9xcTzPQWAtCculFoRjmUWMVGp/skFyhZ8uHLN4ZdIFFbh9fcotjbBppSd
 cbtXujl6JJgqk+kWTEBDtQBjGLFYtfEF0THxs6o//QAHVQ/yRuFVSwTimhmgDZttiv7A5PHpG
 v8CzbJrVHYAa3cksqjXA6zLV3UulMrpoN6ad1AcsIPN+KTXXBNy3hc6eWEWdtotDF0hlFqwtv
 I66WT7lC+Ip7TGvaaFAWVSwW2JXn99bwK018cC5e2a1aYpmVJGqo2Do7zD3JUW2YHvixGE7SQ
 vulheOeDS8fVwpWG9ruaBgkOOzigxDQFApwN9WmQkg9AJ0TtiGf5KbDeGH6Px3xyEOq4IaKUG
 Sl6MF0zNMf8bt18QP13Dd9yn1lGFfd2Kt3iuN3v/fbPxUI3HPEP5BkecCM6fmYqE0SC/+yEq3
 90DCiyNo4zloevblf5U31DS+G/U6p5z+5a1ff7VFEjh6RdEjJNfiW3AaIYZCEgJG4AUjOWFy2
 2ZRiUIQjnar6VuYGMc9ccXDNAaitGUG8Y5v6S7Nu+PZWlLkYJ90jVBinGWhwtxVHCUkHvsJlP
 WTkOUxxM0d57D1dHo+8jX5vKkHDcvIyygs8t01AIn7RsAQzovT3KjCiN+8RMMjVoH3XMsO/uu
 WsDBkve/mvkgWi014UXlGo9Qoyw=



On 2023/12/8 00:39, David Sterba wrote:
> On Thu, Dec 07, 2023 at 02:06:11PM +1030, Qu Wenruo wrote:
>> [CONFUSION]
>> Btrfs is using memparse() for the following sysfs interfaces:
>>
>> - /sys/fs/btrfs/<uuid>/devinfo/<devid>/scrub_speed_max
>> - /sys/fs/btrfs/<uuid>/allocation/<type>/chunk_size
>>
>> Thus we can echo some seemingly valid values into them (using
>> scrub_speed_max as an example):
>>
>>   # echo 25e > scrub_speed_max
>>   # cat scrub_speed_max
>>   10376293541461622784
>>
>> This can cause several confusion:
>>
>> - The end user may just want to type "0x25e"
>> - Even if it's treated as decimal "25" and E (exabyte), the result is
>>    not correct
>>    25 exabyte should be 28147497671065600, as 25 with 2 ** 10 would lea=
d
>>    to something ends with "00" in decimal (25 * 4 =3D 100).
>>
>> [CAUSE]
>> Above "25e" is valid because memparse() handles the extra suffix and do
>> proper base conversion.
>>
>> "25e" has no "0x" or "0" prefix, thus it's treated as decimal, and only
>> "25" is the valid part. Then it goes with number detection, but the
>> final "e" is treated as invalid since the base is 10.
>>
>> Then we do the extra left shift based on the suffix.
>>
>> There are several problem in memparse itself:
>>
>> - No overflow check
>>    The usage of simple_strtoull() lacks the overflow check, thus it's
>>    already discouraged to use.
>>
>> - The suffix "E" (exabyte) can be easily confused with 0xe.
>>
>> [FIX]
>> For btrfs sysfs interface, we don't accept extra suffix, except the
>> mentioned two entries.
>>
>> Furthermore since we don't do pretty size output, and considering the
>> sysfs interfaces are mostly for script or other tools, there is no need
>> to accept extra suffix either.
>>
>> So here we can just replace the memparse() to kstrou64() instead, and
>> reject the above "25e" example.
>
> No, please read the reasoning why we want the suffixes,
> https://lore.kernel.org/linux-btrfs/20231207135522.GX2751@twin.jikos.cz/

I'm strongly against the expectation that all sysfs entrances should
accept suffix.

In fact, no matter if it's btrfs or not, memparse() is the minor usage,
most are not accepting the suffix.

>
> That memparse accepts 0x is fine but I'd say highly uncommon to be ever
> seen as input.

Really? 0x10000000 or 4294967296, which is easily to grasp?

Thus the whole thing really depends on your expectation.

But one thing is for sure, all entries should accept bytes, that should
always be true.
Whether suffix should be acceptable is already debatable.

>
> If memparse is not able to correctly parse exabytes then it's not our
> bug, as the comment says

But it's our fault to use functions known to lead to wrong numbers.

>
> "This function has caveats. Please use kstrtoull instead."
> https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L93
>
The comment says exactly what we should do, "use strtoull instead".

Thanks,
Qu

