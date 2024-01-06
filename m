Return-Path: <linux-btrfs+bounces-1284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA3782618B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 22:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CD61F21FFF
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDE2F9CA;
	Sat,  6 Jan 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YMUmvnwW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A66E575;
	Sat,  6 Jan 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704574717; x=1705179517; i=quwenruo.btrfs@gmx.com;
	bh=q8kMFaYUTh0daI3iKSMpizdypHcTuUe091zMsPWVA7o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YMUmvnwWRYWPC1YGxp+W6l0N32b1yaxD8jkLg8KWqXF9bfFmsoT0+sF1+IvmW/v6
	 fmA0WUMMdVZmsJTSxY7re4/ygV7zHzZ2uhzVb3gPgmOQhVD1APjqMqxOUuViMw6KR
	 aJ5OQBXZP8qyaP74neY/q1/6wp43pYtLaKG06k8HSPr3YiLaaUnWz66xuGCA3bWeh
	 ubOLzQPi6fb4SY1lB4gC35RXN7z0JY6O58Ig/07WTK2dHXmSD21UWc+6gNa7BWo0Z
	 vsl9jACIiIO9xQA4FGSdLF3CJFn2NNIFyIk1fbnV/vtjY+vuaEupm5MnMtuUx4EGn
	 IUe+IAkbsPNlYRpDTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1r2LNl0Qky-00tFut; Sat, 06
 Jan 2024 21:58:37 +0100
Message-ID: <7708fc8b-738c-4d58-b89e-801ce6a4832a@gmx.com>
Date: Sun, 7 Jan 2024 07:28:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] kstrtox: introduce memparse_safe()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 David.Laight@aculab.com, ddiss@suse.de, geert@linux-m68k.org
References: <cover.1704324320.git.wqu@suse.com>
 <ZZllAi_GbsoDF5Eg@smile.fi.intel.com>
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
In-Reply-To: <ZZllAi_GbsoDF5Eg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzsjw6N+nkYBtBUo8TeUj/nImXMjGzZkF4q87f2bxzL/n4qFIUn
 T+ggO+aWnkHu4MQv/w1ircSIcOiQ8luYDoccBBlJQJX8qG+45objSsB7C+TqISDnangino6
 /G/EXgArbQeHv4/TaBHbwp+JAKH4BWZ/BI7KmfwpYrnsVj2FDsdwwKIeeiCSDOmOGad6G9W
 p/RQgcCvNohiuxlj7IHfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TD8zMtWHZ9A=;DD1MjWag+zbXE0ueYEvBgdfdlOJ
 GQ2qRVdqw3dyB+znbAiRJ0ADVH5b2/jKv/YoWHA4x3uOJEE4x7aaL6mY6uCTZNlRLNKAFdkCq
 CO0jPZt1apTqp8UH6h0pmDw9HoCCrC6qmx0ApH6xGTR/dkURRQB79RO5OhNiw3rFtqTrkfTxk
 TDn+0uVolXhJYibOIiWpTgYeqsRayzMiZRDmTsyrOV9brMtlFCf7hQ43VKHsjDyIXE+r/Cgy7
 QnlO/COTcthibcRSw1k89UtGlkr0R6MClhfUjTSTdvM2lssQ5yEd+p49Z1RdsIA8cnM8Xewzs
 MZl66mlszqiMuk6FV6TB82s17dThGaIhmDgyUHmhq4pU+8kQopC4xJ3PpstdlUl12evuPB6CU
 rUgI0qllZaE71Zqj+QjOS7O4jXcoC+iB6chkj0sn6MUhkRIgLDc8ElmBtU+s8lOy+PGsZ/jlf
 C/WdXtW9CMe3zVvLb6GBwNsnRVKuqttdXzs1JdgmoGtNrKnF2yvovnkuNuRj5GpB6VGZG/57Z
 aaIYHi9ONtsM5V/JGkqFttfO/60L8gaY1DTbmJf4eEiZXg8Ix2WXN6/KrzPrAHcXw4n1f+uVK
 F9L5k2clvbMXvDUZdEgSLDETTo++pXnFQku5XXT+DueNd3fsa1erOi6nv9mZOEnTYvA+GjUyI
 MoY5GUOResTISrVksxL6XguUrWvQRltbiQ5Wp02+lzt8535wpDlv41Cc1C2M/khsxsudTyXxQ
 Mt8r2HgHaayJfJvVDNwX7q4Vd9AY92LSKkdI1xG2PbhbYIydzft2qTsBDIqW+v5NV0Z5Q9eC6
 AO60521eZlSxgteZkPpBZnqCbN9iQMTN0nd9JFfWWUAPHakoKwK6yTbIyj98+rQUihUboaSEG
 xC6E7DjLfa746I2JlZO7YZ1+VsNg3FEjZmZTXPi/pBbYPWRpSnobd7FiAuVyKT4vnG6kxMLAM
 Sitb2Q==



On 2024/1/7 01:04, Andy Shevchenko wrote:
> On Thu, Jan 04, 2024 at 09:57:47AM +1030, Qu Wenruo wrote:
>> [CHANGELOG]
>> v3:
>> - Fix the 32bit pointer pattern in the test case
>>    The old pointer pattern for 32 bit systems is in fact 40 bits,
>>    which would still lead to sparse warning.
>>    The newer pattern is using UINTPTR_MAX to trim the pattern, then
>>    converted to a pointer, which should not cause any trimmed bits and
>>    make sparse happy.
>
> Having test cases is quite good, thanks!
> But as I understood what Alexey wanted, is not using the kstrtox files f=
or this.
> You can introduce it in the cmdline.c, correct? Just include local "kstr=
tox.h".

Not really possible, all the needed parsing helpers are internal inside
kstrtox.c.

Furthermore, this also means memparse() can not be enhanced due to:

- Lack of ways to return errors

- Unable to call the parsing helpers inside cmdline.c

Thanks,
Qu

>
> I'm on leave till end of the month, I'll look at this later.
>

