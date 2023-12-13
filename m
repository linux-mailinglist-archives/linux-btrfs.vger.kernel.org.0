Return-Path: <linux-btrfs+bounces-951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD881237E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 00:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778261C21432
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972979E18;
	Wed, 13 Dec 2023 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l6RhWx0k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BAC9
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 15:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702511212; x=1703116012; i=quwenruo.btrfs@gmx.com;
	bh=qXry6xSHLWxg3FFBM4Og+aGf4fcBW3CaBbpfJRunOks=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=l6RhWx0k2Lip3gu5r725IcyON3Os+A0WbVTGQYnPMUDEpp3+fnlCVVWuYw1p35XY
	 5zZVmoilJr8ljCl6+8H45AXDT6H3CYrwXIFjZDWcb1IvwT1h5YzK9X/vawxWBqM35
	 pNB6HJbwF/mVa8RUcz4/y1Fam1avFCqNKberITOqdAWFCaP1W8uVnCCQigefBA/LI
	 mENn7iRC8+JJrCX6NjNCq+z0e4WLYz1BojSf0mQrkjwXISMU/l2UgHkbo2TgqdpLi
	 TdFNx51/qaAyVcMqySy5gECYWuBzp9HtyJ7rWw58X/hHu4ttClgDsGZQionSoYFry
	 pHkPNM8kmYum64vtOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1rY6yI0IMY-00qRRU; Thu, 14
 Dec 2023 00:46:52 +0100
Message-ID: <32a3cfc2-a38e-4ddc-8dd6-c9c1928005e5@gmx.com>
Date: Thu, 14 Dec 2023 10:16:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, David Disseldorp <ddiss@suse.de>,
 linux-btrfs@vger.kernel.org
References: <20231205111329.6652-1-ddiss@suse.de>
 <19fc847b-7df6-41fc-ad52-f4e7f6d13201@suse.com>
 <20231207121537.GU2751@twin.jikos.cz>
 <d8cd0a73-9ea8-4990-bcbe-949ff9c8cad8@gmx.com>
 <20231213231552.GK3001@twin.jikos.cz>
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
In-Reply-To: <20231213231552.GK3001@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DpDYKGgW5lu36fX2rjSNtzxI5YhgQfh9c5S5n21Icty9aSnBPNC
 uVjWWxfjBona9JSCrSYlukPnVjuhNEF4BJrW3qwiHA8LfwmyURU+n9Uh11y46sgJU94/YCy
 Yz8yIQDEzoFfwHJW/3Lot+VBopOYVAb9rvpR/MWkGmD0WsVVV3Smn1ocbbFVmNqqO3Tx4P7
 BylET56aO5mhS9nZKt5bQ==
UI-OutboundReport: notjunk:1;M01:P0:fgeklmsCgqs=;+bEO++vgd4SBxzVDSTNz75Mdbt3
 hdNlX0Z4sMKKR/nu31cDNSAbWC2q2w3uyYnZk8QzTebHZw9JOdU5HvOWR4qareVo6TN5GIHgg
 6KS5XKFaKg97GiiZa9OjEZ1mbyK39svvgYsrIdMQ0pHoBOOH9ojnGGRl8a1JyuJrTnVEO2+UJ
 GW3YO2Jc2FKU8Co7hztaz6JGhy6M6CWxRvSEvLxvlShz2ZgASipA+h9yETKD9fNmWkOqGUijo
 zW1BHC5HEdKyRmvJ57s8W39Ur3arX3gLchHqu79SLJq41LIwgFkXC+l5EAnmjRADXiOCw7g7S
 frnAgjQ5O7+BZSfNpQ7ZW8FB0OcjG2XCHWEzxuXERE1oarAoHkum4sUcgbGTo8e8pbHyylMc+
 8Ex366LFsvAp57lalQ2pp8e8F0XacYmHh7O16xyMk1YeTKmFdG4O9XPLarFkotve3C+JOAhFN
 As97+YUqJ544eSwWj7j1wvia+ei8nlVMTfINoNj620EiZva4mnt/T0mGGrnedDtSFJWfmzxbM
 U6AWHmcHVtqU59DloobFc9z9deDoDXNPtsjf+XnTBN5X1FeywYGWkc8BWGf/ht29bVK3onEKx
 bVnf+S9BRAzEgT6Y4uIEEPCkc5/u/ZMisWgVeZOm/tfktVuaaQIHmjNGbIAEsOy2ImA+wg/nR
 TN0l/m2k0b87j8uN/P+iifiw0WaYt73ssnNj16w3XvkSIt24xphg75KKxUhlu5dLNnLI1tdR0
 uk57S0lgK3f+/LQvavcosoE4mSbuRULaFWkPNlyMmXfWiOA1ysD/vx4RrpkddJay5CGRs6WLr
 Y8uf8y6CzAnvL+3tRi5/IyUKf20XnD2N9lP37IIW9H9XHf4HucSwBthPGvzB9grz0UVEAiagE
 hH0ExiNSlWEtlgGzyuJlPX9/INhRlFo77iGgOxkEUPF0pYpq6qt+wQmJcAqw/lhqJcTLpfUwd
 dwyzzcRfqoXa/TC+uzRTALFPSWw=



On 2023/12/14 09:45, David Sterba wrote:
> On Fri, Dec 08, 2023 at 06:26:50AM +1030, Qu Wenruo wrote:
>>> The value that can be read from the sysfs file is in bytes and it's so
>>> that applications do not need to interpret it, like multiplying with
>>> 1024. We'll probably never return the pretty values with suffixes in
>>> sysfs files.
>>>
>>> However, on the input side the suffixes are a convenience, setting to
>>> limit the throughput as '32m' is better than typing '32000000' and
>>> counting zeros or $((32*1024*1024)) or 33554432.
>>>
>>> This is why memparse is there and kstrtoull does not do that.
>>
>> That suffix is causing confusion already, just check my "25e" case.
>> (It does not only lead to huge number, but also lead to incorrect value
>> even if we treat "e" as a suffix)
>>
>> Furthermore, the convenience argument is not that strong, you won't
>> expect end users to do the change for a fs every time.
>> Thus it's mostly managed by a small script or some other tool.
>>
>> In that case I don't think doing extra bash calculation is a big deal
>> anyway.
>
> This is a nice study of convenience vs extra work "that's no big deal".
> The sysfs files can be used by scripts, often times it's the only access
> to some settings (like /usr/bin/rescan-scsi-bus.sh/usr/bin/rescan-scsi-b=
us.sh).
> The value format, naming of the sysfs files is inconsistent and
> navigating to a particular directory and setting some magic value is I
> think common. Another example are trace points, or dynamic printk.
>
> There are tools abstracting that but sometimes it's a person that needs
> to type it and the shortcuts like the suffix are convenient because
> there's no extra need to type exact syntax and numbers for a $((...))
> expression. Ask 3 people if they'd prefer to type "4m" or
> "$((4*1024*1024))".
>
> If you ask me I'm all for allowing "4m" and I did that several times
> when testing things like the discard tunables, chunk size or the scrub
> limits. I consider the sysfs files an interface for human interaction so
> even if it's used like that in 10% of time it's still saving typing or
> allowing one to focus on the real prolem instead of shell sytax.
>

OK, then let me jump into the rabbit hole of stroxll family for my
holiday projects, to make the memparse() itself more reliable and get
rid of the caveats.

Hopefully allowing callers to select which suffixes they want to use.

(Well, at least I hope "25e" can give us a correct value after the fix)

Thanks,
Qu

