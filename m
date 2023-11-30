Return-Path: <linux-btrfs+bounces-465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C37FFF80
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 00:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497841C20D2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFC45953F;
	Thu, 30 Nov 2023 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ujg8qhdx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12A10E2
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 15:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701387240; x=1701992040; i=quwenruo.btrfs@gmx.com;
	bh=ukZCNqpJZ3iY+Tycy3abiCbWt0d+p7DWKnWHAJ4/tdY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Ujg8qhdxnh6nlx8vCUvMQq5fYWTNFIcIt0YeHaTI4PML5CabEYDIL7eGs8mZvpe9
	 AltL0yoaKHlVwxKn7reo6FgjD6jSqu/HqZUMtOyyKcgXr+zfDFGPn4XXzBX37iR2S
	 +FI3zAHACekngr9kbgLeq4MQDdL1AQ5OVipJuQDpIgM9Hb3trG/Xep/fOeTeh2TDo
	 gLUVRPxCAR7Sjq2HPGws0vMb1PqhpPrTXf14IC1WZ+8vtgqLVCnjH1zhAVuQxx+kO
	 UQO7Hq76J6wOdcvZ+3qeSScA6PNhEfb6cElN8caqgnvBJRtGwmIlAbsm4Jd0aTjMh
	 RpwxkabB5DG383EZog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1rNv733soQ-015q2U; Fri, 01
 Dec 2023 00:34:00 +0100
Message-ID: <5cababa8-3690-407e-b008-1d65e73dea29@gmx.com>
Date: Fri, 1 Dec 2023 10:03:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
 <20231130231852.GW18929@twin.jikos.cz>
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
In-Reply-To: <20231130231852.GW18929@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WlP+CsYWhwbtUw6GbdW2ibWo+hwBXH5mbvxbUi/fr8IFOXRtp5F
 I+VPxN1ABkGfK1p6TmdLvJgil1kFB9P7p34Fc6IbjxTGUObql5k4NzJzakWjZOkgRScJ25k
 /csUWPviWhW9t2aBZ1IhCQ2mgwjuEsxl39TulOtjJg5Sfa+TRrcQ7f3XD4AxjZvunAZs67R
 Lr+q63MQdgalBBO8iQztg==
UI-OutboundReport: notjunk:1;M01:P0:sfOMAnK+5Gc=;6SYaphWk5PN8GpL9qW6VSLGaVw1
 /BaK3QAm6FWNyGUK/2cSXZoVH/FRxcgl1ePdOFTssRM8qzJZGm+YEh/AXtAxylUGgZ2k6h/Pu
 N/ccgbTZ36roQrLB+CHZyLcX3YzkzFJF+zLxxjDxll9eR+rfWCbtqgd6B4EldkiABTTQR9VsG
 SuFSmInfdicGCLi4tBspBYBaV/fNTJ1sTnWwmTUYPxhKb16BGZt8wnFATYutDbWw2v+7NAgYZ
 JRqKL0WVDkWaxxqdHhYEE2O7EFz0Tfhu/y/nhwJHeHgXEgJAowsGYdB+SBaPGfHHaSHYw5W/2
 AbQlwe6L2fMP/hg5NH42plf3S2sspZ/8juEZCuQ6moUa3jobUW7elpEauxSZGaWaLtivmR7Hv
 E/VrvnpU6V1tn7Y4AZVJBTc0U0qsFGm6XkBwK4CsO1L3czUMOfkz4ITpcfRmZTg9l7UQ5X2J0
 crpYgmHZBZqx/k+I2XWz48gtQLjrtZ7QtPJVg6zMq+A4y2wBBQdSnrjAs0PA8luI++xYFXlUa
 uaROycfPRpFlX3H8k1EiMatxJe4rn4kb6FZeLR12fb/BMhJSplqo9XFhPcYzqRb1KfAAot6uv
 CI5CLycgTEUIn4O/PV0Oj+/GhSwLPTqfrrqG0qIx6TLOo6T4o6v1ytYaxJYRKNzRk5la3qTM6
 e6+FTUf+Vbg+Zhd9HGahM5kiLzD0Tqld3L+yaioIgRiP/t5WjJsopQvl4NpwCxB58lms2PNqq
 LD3xpNz5e73uh8OgFaeL41txYny80/+CiH23KjozBmBqMge5hMd7DPTCjXYSz0WG3p+R4iRFa
 K/X/7PWq0ihg3HctdwOzxSkJGSf8qK1Z8E6jegen9Kaw0yVEOr2yBYbPjsHXUhEDL78RkELGF
 dNBUfztUc4EiYiLOqBIOXVc3wQidhX9xtshHMnD3VeW8XVFspffjn4ETTRclPkc8cHA6Gzqhr
 eF42Z0Qfh/doOPURZROHLZUiBtY=



On 2023/12/1 09:48, David Sterba wrote:
> On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
>>   		return;
>>   	}
>>
>> -	kaddr =3D page_address(buf->pages[0]) + offset_in_page(buf->start);
>> +	kaddr =3D folio_address(buf->folios[0]) + offset_in_page(buf->start);
>>   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>>   			    first_page_part - BTRFS_CSUM_SIZE);
>>
>> -	for (i =3D 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
>> -		kaddr =3D page_address(buf->pages[i]);
>> -		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>> -	}
>> +	for (i =3D 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)
>> +		crypto_shash_update(shash, folio_address(buf->folios[i]),
>> +				    PAGE_SIZE);
>
> This still says PAGE_SIZE while it's folios, so for now we have the same
> order for both, right? After full conversion we'll need folio_size().

Exactly.

There are other things to consider like converting to the number of
folios other than num_pages.

Thanks,
Qu
>

