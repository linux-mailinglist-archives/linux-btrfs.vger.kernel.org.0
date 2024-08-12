Return-Path: <linux-btrfs+bounces-7147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475894F969
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813A5B20E49
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D3195390;
	Mon, 12 Aug 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="t5DTXaM6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78954759
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500769; cv=none; b=Z+7rg0dswsxtl88PvvRGtrU376HFIJ4Dmk7ISPsyaEoSbC1Z7atBw4aFSd6BBgyMMK/h82PtEdmxML0LHal1qTHjQHvcS2ccOFRfO9Lkibkkp2dlKTGXhHN0n1/a+ZJV/m+05T5JfUNLk3HNQ6Z/14P7KWVCI4wk5MexFwcbiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500769; c=relaxed/simple;
	bh=J3IdUuu3vGJxLiydzlbqHy6eEVtPhfze/ZpkZgO+neQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R42g660yT8r9sS3omSfRTa6+9yQ9NfCwg7Q8mXbmOyFi0YuxXT2S6RN93GF8fnu5P0ZKXG5DjkZq2yhT63qd2ixFZGw8vqF6TU15X3/8SoI+QtwgIhzl9So6MvyLonZHAFtSdQJpOh0jd2IV9vvxy3XKy/seEN2V+n62MIw1ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=t5DTXaM6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723500763; x=1724105563; i=quwenruo.btrfs@gmx.com;
	bh=J3IdUuu3vGJxLiydzlbqHy6eEVtPhfze/ZpkZgO+neQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t5DTXaM6SMsiR5wav1tB9OEyJJ8iSXDpIfVDpVJ7S7qMcoEMCAaaqlCnBM/VY2Hb
	 v0qidMV4XqmQVM3kAWES6jf9/pcV3bjk1miHbEFnh4BfJeuVf8VYTMWcTUyHYiL+q
	 l8z28DGoOclHszBgp54iDg28671AnmlQWKT05kriinNVx7vdR3bh6+XHgeirbjMHZ
	 SHRKrMkg+CqJJFmF3Y1CPiFgT64UnQ3DfcY0u0m4ltPEEh0qGbYz679g/hJd/Ux2h
	 dYBDTXsHDbJ9i3N9Fj0nVq6dCBsTBSUvjo9kBzoppE0U+6puYdd95TltGwlr7x7vf
	 fa0da3qzgjCp3dpObw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1sffjV39A3-00UpLw; Tue, 13
 Aug 2024 00:12:43 +0200
Message-ID: <4b2b80ad-ef51-410b-8093-60d133e9c523@gmx.com>
Date: Tue, 13 Aug 2024 07:42:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help! Unmountable due to dev extent overlap
To: Stefan N <stefannnau@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com>
 <ac2ff9ae-b2fa-49df-9ce3-fc32ddd3c222@gmx.com>
 <CA+W5K0qUAXYSZFxJv+vVM+knFkXm+VK61zOb2qF6TXmW156LOA@mail.gmail.com>
 <7bc8aa3b-f5c1-4db5-b588-4332af4bdda6@suse.com>
 <CA+W5K0qW5x-V2LR0FoJMueAeG9P-VNnKJ5C=ObCvEVVKwwXagA@mail.gmail.com>
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
In-Reply-To: <CA+W5K0qW5x-V2LR0FoJMueAeG9P-VNnKJ5C=ObCvEVVKwwXagA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eslBiYhX45jKSAN6JlepfiblHf+ljoTYlLnE5FUEby9teehFFBs
 Jwujzbi2jvZC3ZLdhjYP+xCjscwp2ifQLxgHd5cuHrQbCD5AIZpAvAU7+CsKw5Naw7lpyJn
 m4BAMigK5XA3y0UWpgBtYT9Pgo/2hsGksS3WuUM9YVhZrnv0/iCNwISXtbAVgrrIH/c0LV0
 nMUjzmMj7KiFDlwGOIZmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rKRphdHIFOY=;etDp7bNhz1YF59bhd6lidcHap0p
 1lUmcitaukaaLF7N+L9XMFt0DsqJNO3WNgsWcStGRUAfB1hNThYdi7e1u5AOkBe5i9Z1IaSFl
 OPwe87kutEf4PwMxmZovPcm6tSstzXerImH2u6xUkFyYoTgRpMioFY9RYx6E0lR54mcCFM9SF
 RItmGVT68qLSYgtDx+AWJKkcFfe0ICefKq0uT7kliP5xPgqbSeP3iyFO4Yd5+5Qa1BCJL1Qsj
 ie2CXrfJZyrCGqudIXYZdadSK4E2u9rI2LIWEQ0I2N5EfoZZ1KpvbNuG8wK2D+EHoZ1oFZJyL
 kYxGZ7pnN9j1dNBeDlqE+BYvgHObqa2eBSnFZAJA6NRyg0BMqKP96oQA+8pPDSsSzh8Necz3e
 QE8WzypHHRyoncY4gtLECoaEP9D161B33UUPBuW2jNgUih3d/TcaPW4fabG0b/fKzdY9sC5Ui
 iUZJTV2pk5epxOwoS7+BZk2agj2UBQD9QhK3qjdwmsu+KDw/jmvYRrh7B+zN+0N6dIUsToYgo
 npfRxLcd1qtXnMtLFzl/tD3c+pD0/gj4D5Kwuv78zDtOCSehfk+gthq+7B6c1oQYMNxF7IdAt
 3M1X88Rxl8BRWrBH6UgyGwDavqsu0i2feP6JIZLGLnCHh7CNX0lG7F2hFDhLzbEXb942knrBf
 x13nWDyKy2x8bzayL7f1/gEv+6vTvWsVJk9zGflc4Fcl2KnPjwYGYMZFfOfbk7T/0dW2EKJSF
 IwMAcVNrTAUkKgjlm32RSJQzzQItXMUEBdV+UkrMjtsZgR6s+gX/w3roP2ieOSRU48wwFoh98
 EggdNF0XskCC0pkU1bg0Phzw==



=E5=9C=A8 2024/8/12 21:21, Stefan N =E5=86=99=E9=81=93:
> On Mon, 12 Aug 2024 at 17:05, Qu Wenruo <wqu@suse.com> wrote:
[...]
>
> 3 passes on memtest and no errors!
>
> This is an old filesystem though that has been going for several
> years, is it possible this issue has been there for a while
> undetected?

Yes, that's also possible.

In that case I guess the fs is also mounted on a different system before?

> It's been through several out of space data/metadata
> consistency issues over the years and I had believed scrubbing had
> resolved these, is it possible that these errors combined with the
> scrub not verifying the metadata caused the issues today?

The only situation to lead to the corruption is at chunk allocation.

Scrub is not going to detect nor worsen the problem.

> Or given the
> bit flip, do you still think it's more likely to be memory? There's
> been no other symptoms but it is non-ECC..
>
>> And I have already submitted a patch to detect the corruption and
>> prevent it from corrupting the on-disk data in the future.
>>
>> Unfortunately I have no idea how to fix your fs at all...
>>
>> The overlapping can indeed lead to data corruption (since the
>> overlapping dev-extents will be overwritten eventually from two
>> different data chunks).
>>
>> And since their chunk items are completely valid, I can not simply craf=
t
>> a dirty fix to modify the value of that dev-extent, as that will cause
>> problems for dev-extent verification against chunks.
>>
>> And if I need to modify the chunk items, it's going to cause a chain
>> reaction to modify all the other dev-extents and dev items and superblo=
cks.
>>
>> So I can only recommend to backing up your data (may hit EIO if unlucky
>> enough), and rebuild the whole fs.
>
> How can I best mount the filesystem to recover what data I can? So far
> I haven't mounted it at all, the ro flag isn't sufficient to bypass
> the error.

"-o rescue=3Dall,ro" should be enough. That "rescue=3Dignorebadroots"
implied by "rescue=3Dall" will make btrfs to skip dev-extent verification.

Thanks,
Qu

>
>> At least your sacrifice will be remembered in the kernel git log foreve=
r...
>>
>> Thanks,
>> Qu
>>>
>>>> Thanks,
>>>> Qu
>>>

