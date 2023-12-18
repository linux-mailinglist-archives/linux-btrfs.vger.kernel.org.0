Return-Path: <linux-btrfs+bounces-1040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BD817B6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 20:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78AC1C23299
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285471470;
	Mon, 18 Dec 2023 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TW/BQcoZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5673A1A2
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702929252; x=1703534052; i=quwenruo.btrfs@gmx.com;
	bh=0UEZVz/P34aNkA/mAE9EY8+uWFGnV0BbLKpm0Afhco4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TW/BQcoZfPcZ+sgnAiBvK11aBXLmwa8tLq9CrZR5agVb6qW/dAr4abPQjXepR5oX
	 3rFrTkYk53LSaBojdA7+yy2fTuI5r3xVwoFYPwIxXAO9ZehuGmPj6rYj9dEBW67hu
	 TwXpnYM6Y28geFI//prla/sx+FNQU3AaLTFP9d9Rd0840S3l3C0CwHATIjhUxaAu7
	 KnXrvOUiAT1QJh+vAFHh8t7xkAZIwusAJ5Z6PdPLc1rBn0iMX0GvfIxC7GqgGsYLj
	 el7sk202+X3HGXV5N6OVGd23vX3Rg7u496XlMT4yZYEmINagpTOdqVjc178HIsGmX
	 YteyKzH0/x4ZlPpQlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.108.148]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dwd-1rCD2M108D-015Y25; Mon, 18
 Dec 2023 20:54:12 +0100
Message-ID: <ae601db7-ab4c-4a40-84ba-a2a40903a7a4@gmx.com>
Date: Tue, 19 Dec 2023 06:24:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
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
In-Reply-To: <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnjp9wqK86Y0DIo8jHaRBKHycAmESNuLrC/l0HeYBvarvVLSGDX
 5ugjYo6umFN40Qx+IMSbcTnSNMJlFEwH6AhOGR0w49HpZJwc90sRfUPKvDAM8V2weQoP8k0
 eVzRbN5Mtqs541oeMBP2CbFfrJijoS5wwQwe1tstWW83TL8r8WfhNrjbhfwgrTcEBgejmOn
 PPADPsqNB93QhLU7AI5Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ECOZyuiA3vE=;16ZfeeBO2nUWxLeA6egL5OZrALs
 8qpHI+/zOJ8owSPMVOL7DqT5We9rP6/LW41HVvO2HdhC/9a9zSUAvhEdq3gO4LKA9pkKlNFhU
 8ZLFNJRK/zzHvE5zA7pREHSTgXy4+jvuaZ1hz+qPiZVR+QM8At/6Uy+Sfrp2Ev1vBj694Rbey
 1a/vs3sVa69qo01RzfhldsykfKYJ10RmYs2DPv55bZF8I6kCdnPpX6KuzwfGE/+y9ZvC6Hy/k
 VRyk+Hw+4BY+Em+Go/CJuQ/7SMuJyH18cK1g19NmNtB+xXF6WVglsF7PDzeZypCuBxahDktwG
 1GTS+r7JY+Dcb1OxnCQPUbAefYHYmSu/Qu/MzGvCqzsSZkkG/jQyTGJc17IVVjMam/R9pK5YA
 szKz0/6GLkUzbrVO6F9j44316ei+uLfXC/yiK4DzlQr7tAc+vg+ZVDxdG5Mj2G6g2JghbXuhN
 cxrnFLSATuziI+BxJilOCQePTTfjdZ/Y+byGTWNJHv6wexGd/9Cvipagpi6NQIOJLJ7gNL5b3
 vWrudAzn96KGrs23GIfNud/AynXgONJilbxZwrXD8I4DLzThBAs+K/yh0OowKkWOHSmv180Ty
 yEkDDez0Y6PX8MBY88C6RAh33XkOmEGfs9fNbF1FQh99UoQi4ZEuXN8L21boV+zov1Ca04AKg
 OTwafbJYFQIOi8/f+H72kNhnnSjlz/2fRCdYnwwzK4/+uwCLcBQfogfjNhEaBxKXJ6MdKk9s1
 YfxszTKVMMNA8OQ4NBZoy6uXgfPYEoKzkK1nacqCjbNgZ2fyIDbe2t2PndzhSJPWUNUsmlxpb
 E1UWAZK66mfrQioTntlW366sAT8y/m0og+PyQdpDF6t6r+gZSxyka3DdIPtnAYyz5rRuuIBRB
 92kcmKSRnBHwlkRC7vVia/vcV0EjUx83BWBGQ1f2Tl4pe6K+gaSYdgyRRcjf810zyCAjQCXqB
 mPDakr42kQCBQdzhaW8TpQmwnA0=



On 2023/12/19 02:54, Christoph Anton Mitterer wrote:
> Hey again.
>
> Seems that even the manual defrag doesn't help at all:
>
> After:
> btrfs filesystem defragment -v -r -t 100000M
>
> there's still:
> # compsize .
> Processed 309 files, 324 regular extents (324 refs), 146 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       22G          22G          13G
> none       100%       22G          22G          13G
>
>
> Any other ideas how this could be solved?

Snapshot or reflinks (remember cp now goes reflink by default)?

Thanks,
Qu
>
> Cheers,
> Chris.
>

