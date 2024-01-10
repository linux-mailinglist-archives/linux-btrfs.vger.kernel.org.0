Return-Path: <linux-btrfs+bounces-1353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA508292FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 05:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBC1B25337
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418E63A0;
	Wed, 10 Jan 2024 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A8ArwrWi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE325683
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704860302; x=1705465102; i=quwenruo.btrfs@gmx.com;
	bh=vPUF4+KPIWbMpQoY4+tU4LvVmPlqdtDWH7qZ227Aqhw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=A8ArwrWihCgPmd8Wx9BX/tXSsTis8dtXnPBPiryItmyTlHX5JFy4FH9T45IthTka
	 5O5pLSm83MH8zy5rFfMTs81JEqIJ9lABcatDZ2CA/58r8FCn4WPHAWHlzy/azatff
	 oYfGtfOuCJe6iSbnPKgmnNdrkNsacYb0AcPy+ol33N58K/Dl46Lbc6pm1NfcYekOx
	 6jIxi5Fb1KlHQgWzQpssT2H5K9JD8KGb7OkPaWC2jSC1/BSQwg5FWzQS7Ohfuu+bg
	 kdI+fhqju57Paf2FplJe8EDhdgAZdzJAYxVzdoQ3K9T7ghjL/O4AJDcY3W/tojMnN
	 4jCoZN6Pn5gNtFf+8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.113.22]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1rFySZ0OJZ-00862p; Wed, 10
 Jan 2024 05:18:22 +0100
Message-ID: <258d7550-6d31-4e52-9fb1-4349641fc3c9@gmx.com>
Date: Wed, 10 Jan 2024 14:48:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: fix and simplify the inline extent
 decompression path for subpage
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1704704328.git.wqu@suse.com>
 <20240110032913.GT28693@twin.jikos.cz>
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
In-Reply-To: <20240110032913.GT28693@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v/vM8pUUPMjsDvokB6bl13dsEMQa2b7z3tMgPuP5rOSMA7C1qUn
 r4Npn2t34qK7ZqxC8dXpm+kes8ji1OhH3ZDZQ1XfXJll2dINNESKtgtkJRcpZvyMQBjRNT7
 WB3C9jEBdRBcuNBMtRoaXmjfTtnV9tn13/NvLc1z2hkBck+2NHYTzskXd28XycOP28VMPwc
 IKKVJkGcX8dNDBg92N9rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nZtsfx2nff0=;Frc4+JpLPsveY8/4kYEkNCDDUps
 G3c2sN8SozQ/Z0mIRPYSNPsFTRa/E0+YGSBRANeBTD+W5ezsMljhUjTuT19vkSF/L/sM51xCw
 IE2SqJ6NdmsjWwsLK0WHKttYyrVzA6kMZsMH/xUQDmCZ3LGLNja53RhO9fCIMTCxDgmaNNBk0
 Wube+Au+ceN9lj84qbVUhuOkffqWhR7l7jKeSp5Vsw8c/S5CaQtW627v0asnTfZafXUKrxgxC
 DavdaYjvxaDAoi/mAenvk3gN9u8Xb1iX3oCGXxIrdZ5L0IbvleanCsOvQiY+3h+Kk4gLzEEOg
 8zTHhaIDMV7gtZCfHP31+Qs6Jp4EmGWeAhjyjeZsNXVOX76eQmsm2fuC73tA+sliFLsPvjeCV
 jvw7GIwCf5hyZ0jNvyVTtPCZCKv5kTOE+Y1q9Bh1+ypcxoXlJC7k0LSqt9g1haQxp3nR73E0w
 e51Gzfc+epgRMkwsvrePHx1z4g6RdydRJ9ZzCnP5Wydl7LyWTKvsQNjYqhBTQzdUF/uFbpxRA
 5CAeCx1TozIMNM4Y5oV76JKuSBNgjxqy9Fg7T3jnkYxIpff1E30gJHEM/wnLHpBqMHgro725I
 hkDibiLzLj32Jt1n/Ys2lm7Glvdjzd1bjt/J3EzX9oxvMVimcY3p3XORnV/+RGPqq66MM4zTo
 6VlQO3Ooh4OU6OrYF4zADjVAxb+QscW4EaKJFLfuH7IKDDf48mLcNhjQ7tf35sQxwOYPNoB2s
 8G+DkE+pIV7U27pUTdFjIyRiGF/6ZyJmKtOENDKetOrBRK+4uKx+oxvZa3tTA2lbVPYG0oMTs
 /bmXj4t0CXhB6zN39zhbQNnSP3gzjoNiqf26s6n0zQm+VyDMEDH2/bvfvHC2CHFSDbH3v6FUF
 sv8fq9ThnKpbUcUpUT5V77sLGuwfrfBNb5GptC/Z6ZQwI9DGun4R+8NtsV5LDlWg/rSW51DoR
 NwXaDyFXPfSfkGwj3AwWWJzhNyo=



On 2024/1/10 13:59, David Sterba wrote:
> On Mon, Jan 08, 2024 at 07:38:43PM +1030, Qu Wenruo wrote:
>> There is a long existing bug in subpage inline extent reflinking to
>> another location.
>>
>> The bug is caused by an existing bad code, which is from the beginning
>> of btrfs.
>> The bad code is never properly explained and got further copied into ne=
w
>> compression code.
>
> I think there was an idea to let an inline compressed extent to span
> more than one page, but it never materialized. There could be code
> handling it but due to the invariants (like that inline extent is always
> smaller than a sector) it's never executed.

Unfortunately it doesn't look like this.

For multiple page cases, we should not call `offset_in_page()` for that
@start_byte, and even in that case, we still don't need that @start_byte
parameter.

To me, that parameter is just for subpage, but not properly documented
and since it's mostly dead code, we copy them around without properly
knowing the reason.

>
>> The bad condition never got properly triggered by different reasons for
>> different platforms:
>>
>> - On 4K page sized system, the @start_byte is always 0
>>    Thus the existing checks are all dead code, thus never triggered.
>>
>> - For subpage (4K sectorsize 64K page size) cases, inline extent
>>    creation is disable for a different reason
>>    Since no inline extent can be created, there is no way to reflink
>>    any inlined extent thus no way to trigger it.
>>
>> The fixes are mostly going to rework the decompression loop, making sur=
e
>> the input and output buffer are always large enough for inline extent.
>> Thus no need for any loop, but a single decompression call.
>
> Yeah, as long as we have the page =3D=3D sectorsize it's not necessary.
>
>> But the difficulty lies in how to properly test the bug.
>> For now I'm only doing cross-platform tests, using image created on
>> x86_64, and do the reflink on aarch64.
>> Not sure if it's possible to upload a binary image for fstests, or I
>> don't have any good way to test the bug.
>
> We had this discussion year ago (no crafted images) but the maintainer
> of fstests changed meanwhile so you can try again.

It looks like that's the best way to go for now.

Thanks,
Qu

> You can always add
> that to progs but it won't get the same level of testing due to its
> primary purpose to test the userspace code.
>
>> Qu Wenruo (3):
>>    btrfs: zlib: fix and simplify the inline extent decompression
>>    btrfs: lzo: fix and simplify the inline extent decompression
>>    btrfs: zstd: fix and simplify the inline extent decompression
>
> Added to misc-next, thanks.
>
> There are new error messages when the decompressed length is not
> expected, this could be still improved (and made more consistent). The
> name of the file or inode number and filesystem identification are
> missing, but that's how the current code works.
>

