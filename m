Return-Path: <linux-btrfs+bounces-6630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C363938326
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jul 2024 02:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D271F2148F
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jul 2024 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE617FD;
	Sun, 21 Jul 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BV1n3TiU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BB1361
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Jul 2024 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721521485; cv=none; b=Fk0BsH/+lkHhO63T0MYyom8elIpGFgW49NxxNFZnIAwLE3Ysyy9a4whMh/J6Ie9pb5Gx/qN1RZ5335a02m6KDAy705ih7sX8cIsJFxra3A1CcCRNnisTXpAER/W8ulmELeyNYlFkMFc5iXUnLJg4WOTYxIzfJbPYVgqRxq1v8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721521485; c=relaxed/simple;
	bh=8AxUP0NbHOVKugJA522wrtk79cNvehWuHnoDxh+fowA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnwLdRwLRLv9FPpfnB3gloLb6gWrephOS9s/MEFRPiS/slsKQ4x/j5mdJJE60/K5Eqssvp6/Zdtq8pcbRT5dDCbvRlg6kLApxhKDYYkTTrfiveDtyI3FZFa1w1JJsbW88hWN6D/VZAuook/+dIEpaxuPkBGcrQwk/B9H9V/uilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BV1n3TiU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721521466; x=1722126266; i=quwenruo.btrfs@gmx.com;
	bh=8AxUP0NbHOVKugJA522wrtk79cNvehWuHnoDxh+fowA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BV1n3TiUwrb+djuPrwPNNSOAlQQszPJYa6E3+j1salQm8AiG4TDELSI1S4GgQ/uK
	 TRhjEtsU/yOTs0LU1SH4iiBAA6V4MeUYfIxkPz9O58fmcVUL7Efs6FgMFmhKQn7jl
	 2Nx+JuyUZyFAKUP9laQtCey2sekwAh2C6s8K4VV5hbKXvvDTZi8hqnhEDzIuvJsRB
	 W4NUKxuaimoZfiTiMBRl7Aa63c+VBMVtWKNvu4duBTplT6ubhrlGpJN1TDz91SwZS
	 HAwY2Q3gwZyPQNbd+fih60S8qpZOtM6gS+iDxIYsvFe2ZOa8APbPWZFRM1LW+kz+5
	 ZdmVJxQb8mohAs0tMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1sT8Vt31s8-00Bxww; Sun, 21
 Jul 2024 02:24:26 +0200
Message-ID: <4030c50f-491e-48ee-8977-0194934bda74@gmx.com>
Date: Sun, 21 Jul 2024 09:54:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid using fixed char array size for tree names
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>
References: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
 <20240719235328.GB23446@twin.jikos.cz>
 <05c6a4a6-5dde-48d1-8876-e625dce9ce02@gmx.com>
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
In-Reply-To: <05c6a4a6-5dde-48d1-8876-e625dce9ce02@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zWx1Oowd5lXoqbqX1i6giqLGuaGxNL/e9xGKY6JY3AHLbYLKxsw
 dBrdnQ6xS0DZ3JWTM4qZUQYmCBc/aIEnMxkgi+E6WjGzup41MT5goS7xU53CwCsAQ04y9vl
 gMPRn15fXaaeFKPDaYdQcyYJXmQENWa4FqMenV+mKgr3iTKVpnVYJpakwzjZ3x8vcZ9dp0f
 JJwiGcnHZJitReOKiIIuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lohf8n63+I0=;d9u4IrNKBiS9TnKoj84UYhEmlqC
 XW325rRaUH1MSQZ+c3CXYohbacls7FPkKh6/uJ3/1VEZvmcpTx8QdIAmSSZA/dEsESzOiGS0t
 XAx2J2OnL2ncuZ5y5cdF+ZAhfQ28bI2b/VbepLVnhU03OEGrRZmUy7Qbz873mTb9sOP7HLjdC
 1jc1Q72Zb5LJ3txnjneE/3wxtZcR3u4LafWqtwe7ap+2nWbOS0HAUtGKyKXmKhCPqwfd3wDNE
 5/YFPUu/LYQziIC9PrjvkGU1idlUqSiflnUP0r/2CNOwcBO+OXS4rVA1VaSl16E5ZB/z7OHPP
 gn28dd8YObgW3QBztoLSfj5w3HVzISWMm2dr4DpYRaNSH4leapQmkJNO9s/uLuVbS/Y4X67cY
 XrW1YVjAcMdgHG+gsZX6dlgMXngFiwjKNKea1MmrvZwNtwIlQn0+7F+kTi5iLk0jCSiDZH8cb
 gZm9DdL+uq22fdXC8hJ5DB6YE5m9YoFhhWAdj4FEtub362vsirLihx73Z2dunV3Y5K8cmvtws
 e3AG3rch2sofQjZqJLT1OTwX1QwzRGlMAvzw+ZBWecWrVz0ymJoo/ZlqI3FSvJXfyGQg9DLI+
 JrcgEGYyEXVCylIxllxHIHJNnApf3GFAWkZ9MyOk82Cc5QG+sYLiSr5u9PU9uen0Hud8TVLHM
 7SMxNiGy2rpvt610Q2yC90VXcvL+T0+/C9qRF1T+lbA07sj9aOQyAbV08IPiofP3AaCawRCcb
 sIgDUUYD3ofRT5H5M8WZ46vHhAIyi0DihWySYJn22bHXgqmvp/t+jREHu5Hr7Vi6zaL0DRruo
 nTDOIhFN2pvqqrd2OYH4fU3Q==



=E5=9C=A8 2024/7/20 10:01, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/7/20 09:23, David Sterba =E5=86=99=E9=81=93:
>> On Fri, Jul 19, 2024 at 02:20:39PM +0930, Qu Wenruo wrote:
>>> [BUG]
>>> There is a bug report that using the latest trunk GCC, btrfs would cau=
se
>>> unterminated-string-initialization warning:
>>>
>>> =C2=A0=C2=A0 linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer=
-string
>>> for array of =E2=80=98char=E2=80=99 is too long
>>> [-Werror=3Dunterminated-string-initialization]
>>> =C2=A0=C2=A0=C2=A0 29 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 { BTRFS_BLOCK_GROUP_TREE_OBJECTID,
>>> "BLOCK_GROUP_TREE"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
>>>
>>> [CAUSE]
>>> To print tree names we have an array of root_name_map structure, which
>>> uses "char name[16];" to store the name string of a tree.
>>>
>>> But the following trees have names exactly at 16 chars length:
>>> - "BLOCK_GROUP_TREE"
>>> - "RAID_STRIPE_TREE"
>>>
>>> This means we will have no space for the terminating '\0', and can lea=
d
>>> to unexpected access when printing the name.
>>>
>>> [FIX]
>>> Instead of "char name[16];" use "const char *" instead.
>>
>> Please use a fixed size string, this avoids the indirection of one
>> pointer and the actual strings.
>
> I strongly doubt the necessary of avoiding indirection.
>
> Just remember all of our error messages are some pointers to a ro data
> section, and I see no reason why we need to bother the indirection or
> whatever.
>
> They are the cold path anyway, so is our tree names.
>
> You can go char name[24], but without a proper macros checking the
> string length, we're going to hit the same problem sooner or later.
>
> So, I see no reason bothering extending the char size.
> It's not extendable, nor safe.
>
>> For static tables like this is a compact
>> way to store it.
>
> Nope, it's not compact at all, for shorter names we're just wasting
> global ro data space.
> The const char * solution is really using the minimal space.

If you really want to dig deeper, let me compare the bytes usages of
both methods on 64bit systems:

For name[24]:
13 * (8 + 24) =3D 416 bytes

For const char *name:

13 * (8 + 8) + (9 + 11 + 10 + 8 + 7 + 9 + 8 + 10 + 9 + 15 + 16 + 15 +
16) + 13 =3D 365 bytes

Now you can see which methods wastes more space.

Thanks,
Qu
>
> Thanks,
> Qu
>
>> As the alignment is mandated by u64 the sizes would be
>> best in multipes of 8, so 'char name[24]'.
>>
>

