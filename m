Return-Path: <linux-btrfs+bounces-1547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1D831514
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 09:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019771F22D68
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3C12E41;
	Thu, 18 Jan 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="El+Z4mBd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2A125A2;
	Thu, 18 Jan 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567753; cv=none; b=KLQ+yWe6wwONCpiTbnIxzUtvDTc0vHL73BiuOdfzoHDeo+kf5wQGQtY0Ji1FZp0n1/F7dnzCSFOJDMA9+GzoL7mLRrQOr22lzCSdFiA4mhCzM6yVWNP0j6wkrxb/WL3oRDlUYHtxMoTqeNBhBSTblDzdRY2zRvhsHuO6Azw1Quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567753; c=relaxed/simple;
	bh=pBiIFlcotxVSEzXLAxvoxYYGuZdP+l+/zGq0x2xnSkM=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=e+ZrBknX+wgJuLGYb38wz+n/7JOZx17iOnoAnpkmLKJWes5FEb7cdnRtEbFMZVidft5qW52smAh2UKnDXjT85NruT9BqzkTBnOUoW9dd6bNe/44HZHBls2QcI2dKsU/uJROmAEZCj+wt9xRRhvN7+w9kLArisXUiG1j+pJ+EaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=El+Z4mBd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705567724; x=1706172524; i=quwenruo.btrfs@gmx.com;
	bh=pBiIFlcotxVSEzXLAxvoxYYGuZdP+l+/zGq0x2xnSkM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=El+Z4mBdystprmB6dRcAzVyROxMC94J/+ZMTVO5PlAGdm9lroW7ILDGTjNMpk8Ws
	 7EbiCAIDlpSmwzjKA3QSYPwFQNY59nFDHzjw9REYcGaVitN/gmq/zcOcPf5wikH3x
	 3eT0xph7+mKrsk8Ifwe0AY62W4FWiyRsjLu6Yd1IeTkOuxTp6azQxt1ZIiIjk0V3j
	 7wSiQWpni59bxDLEml6K+SM3Rma+M226KS3adwFadchjMTR8ZZUkmPXXXD4/mgHpa
	 K1hl2GGSeqAsp2vHK36Zu6d/oc9E69Acosn3RY8D2OkZy1/VkoGXE8Wp3l5jq+Xrr
	 drpdrT3R9/8c1oH8Pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wuq-1rVtrL3ux2-005dEZ; Thu, 18
 Jan 2024 09:48:44 +0100
Message-ID: <ef3e57f4-297a-4c26-a232-fb255dfa3867@gmx.com>
Date: Thu, 18 Jan 2024 19:18:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about btrfs no space left error and forced readonly
Content-Language: en-US
To: ChenXiaoSong <chenxiaosongemail@foxmail.com>, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, huhai@kylinos.cn,
 liuyun01@kylinos.cn, zhangduo@kylinos.cn, liuzhucai@kylinos.cn,
 zhangshida@kylinos.cn
References: <tencent_0C621A54ED78C4A1ED4ECA25F87A9619CE09@qq.com>
 <2870e41e-c0a8-4ab4-baaa-bbffbcd1e6a4@gmx.com>
 <tencent_0681F9CE96CDCF741BD6ECA4C401EC4CCB09@qq.com>
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
In-Reply-To: <tencent_0681F9CE96CDCF741BD6ECA4C401EC4CCB09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:88v36+MIFHXmZiblvgO4W5tO/vMhrV8oNqG4Kqy/zgvWYzipwJm
 Azuoaky3+WMpKOklzs6vaJ3lhJlhPLEbDi6DDKeSJn1v9L85yg9LBKc1iMrADcbqjsyJ35E
 tMknnj7AwsZhAGfDxwguuACnFYNuDrLq9GB7wXJJsUcYf6+zKK67PNyqMAC9etlz86OkVhy
 Xc6Zn3lJNqhw5l3X7RX5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b8ZixhXjUVg=;I2UcLDHPHsAvFYb4ab1sAiOo3Wt
 bHP229do0vgU6QgK0Mr1rTebZ7RbZazGp6K6TvL6Fpe7a9gO4NORkr5QXF85+kA/Gjy+zUn5I
 bG0197Uggla24HWOESkRGa//vTUSS9GjToTI5IsuINPvvdqM3FGwPxWydIDealKjzz1R5GX31
 wwIIcTq2rXTpbsuJXiUQyO4lAY5Z898Gn5UVPnbJmepQc3f4ASuxcG3Qor+mwxpa+M7RL6bCd
 qd9ISjSRrCQ61mCNlp/wKpMIVgV/yDVHurFp9PwIFMhfSZjW4TKjWgSSWrxmx3jXNEX4cgtUg
 ODymoJ9hGPDG9Fv9tSUrXf5iEDzDfW2Nsj2uXNBy2KKj1F2mS1u9iGIWZYd0exWX424hkkn4h
 hAfr3eTeuajb9Pnhh5fT00t+XFh45PzJX5a2Kak12cqcDQ5YigCYf3+WsdxqodfOYhNUuXNi7
 3vtJYUQcN+P0O4eg/Ftf22yEIMFAkWUxfrlCDC3L2eEdQJzhgTY/v4yj3X6zC00XlVbuubV7i
 j1KDLSxq2fpPLsWeE/faSi9scmLJViHvm7IubuU99d0i8Hb75k7iEldJgtPZSc0+B+bLXdOWa
 KmJEk+lJsh++mi+cwXr/pcw9APPDpmAsxmpP3v1LNsU7ZavOvybDWyRcu8ao+v9oVMqbLdDy4
 vl5jsI39G2zdM/UzYTelwN9GmUVv4ccJaOt704SA/ummXaRTBKceFTgjiTcSpejwfro+BL96O
 yqRohadJbB/35+qW+u7QTjtyJN2UZwN/8i3QSf1B6CS39cnpYtGvp3uZDwWAWVBqzFU7naaAa
 J8pGArWTfGVbw3t9hYrpaD+hSdfml5U2EXuRPNCFy8CLtMMCsyIQAvVLsicalvLY3ZBiAjzST
 URuZpdj9dS6hOv9Eme56maeqbYVVHEVu+9RT/tS8TIZFC6q8wBIz6LdEUB8qmQVvJ6ASLwHtl
 njj2bNEqCxiqedXzCfvg+qz7w6o=



On 2024/1/18 18:03, ChenXiaoSong wrote:
> On 2024/1/18 15:07, Qu Wenruo wrote:
>>
>> And `btrfs fi usage`, `btrfs fi df` output, along with `btrfs check
>> --readonly` if possible.
>
> The environment has been restored by rebooting the system, and there is
> enough disk space after rebooting the system.

Still those output can be helpful.

And if possible, full dmesg please, just in case if there is something
related.

Thanks,
Qu
>
>

