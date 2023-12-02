Return-Path: <linux-btrfs+bounces-536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F5801B96
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CA2281CF8
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D310A36;
	Sat,  2 Dec 2023 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QV7s02p/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66DFE
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Dec 2023 01:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701507637; x=1702112437; i=quwenruo.btrfs@gmx.com;
	bh=CriP5tmy3OUWeia1LaYbyPSQeuLKDfQyxfn0OiCX6fc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=QV7s02p/0KvJ7NnmfSu4r263B30SOqJBQerTeQ9DEb//DB2kj7bkp4DUx+LDIsMj
	 pNi/wDLHQUmBAu8C98k+fzifalohVbUKiJIX9vhwcJH5HGLjtiYXV9GLBrhJ++nZy
	 H4TKtbgU5C80k6e7qE5kroazyQOHhiU29mbrglKg4s7OPnCZD6Cx4smTRjk8cA8Mr
	 a2/578dEkzX8qTasdlHykC63e4PVXRxMl0ge4teix4drdc5/7QpPkkTjiCozCD8rN
	 KQEINEQj9rTHzFNimwxA5oDYJYQK6b9XcwMKqhwIupxd5b0ZrszTdYiK36hhO/gZ8
	 zLvxm8URHKjzTUR6zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfNf-1rPNkJ1PtX-00v6V9; Sat, 02
 Dec 2023 10:00:37 +0100
Message-ID: <759e3fb3-893c-4537-b863-bfe8ae8a6d54@gmx.com>
Date: Sat, 2 Dec 2023 19:30:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
To: Russell Haley <yumpusamongus@gmail.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
 <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
 <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
 <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
 <d1db5758-35d1-4737-b69d-06473cc46e86@gmail.com>
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
In-Reply-To: <d1db5758-35d1-4737-b69d-06473cc46e86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bsYjzMRNBhcigllkZr4P9U+L7VVbfIgtUFCN90TcPJTCOlcov3d
 rUKi/7ooF3/aNIAuzVCnvISI04lDmr+RpSBDlCfubtgFGtv3jP9hNzIUBnxQElj+ZbewE4h
 ZWO7cPllkiwGIOAE6M7Tez0wdef5a8MoiLw9mylM7gaOKuVlk7F9OxxGdpHhp4qmX4meer8
 r+JkT77M+jp9KoI9qvvNg==
UI-OutboundReport: notjunk:1;M01:P0:HoGL/XWrfes=;nFQ7thtYz/wfytFc4OHMDPQqfcy
 MjESvhWw1FYFTJkhQGz8R6AKs9EsTvsZ3sBbtW9xH4WJkyhHScqwguMSEKRDEt6HOvn8K3oov
 TFHxPbzL5Ux/3PWGfPSB0XTzqhY4onIndi9E18kJC4pSj054Epp+3FNgvgOrGHzWdNlAdpcn8
 N8W35Qj3Ua13muaN7MYmuyK6YwZ0odrEusR1oBEC2Ht2fNt23eiWjekcJWX2EZs+VT6nzBA9b
 UioGW9uQER4uo2GicUR219VwR89ZGyPWdqP5Z3C+UMumG6ECQoe5o2wK4TcHwsgLlgWfbUVy/
 yymWy6IlerK5eaUjh5L76hd5ZT/XQUUjw2Uvu8/cQjI0RM2yIa/GqF70U2d2pm1qH9hU0hA24
 gxV1DaeTzV57Lbze8754F54Dr1xjMJ2/BM3yLtJbh9dSCI6ZfP2tKJgvtQozA7zLAdiwDMldh
 JR9I0XVzZZCKfgjhFC1GnCr7LtqZccvYnGMfcjw0Ml/0eXJtYsL1sWffyYjKBnG4SSTSmDdzo
 y0qUd1Hy7sCp1i1YUDilPlrE8h1qJkZ2nVjruqkfGJ6wXkSG61RJDjyWP5RXHPJ7gjRqC7Cre
 kZ3cUCZF9xR/eXRxTSRotqxp20r915qps4Ml1O99XF3NiyIdPxDGJPj7Xc3yKotjrfcuS3COG
 2RtFqtfQ6fu47Z+NFb4sh7uljcvk/WqrjFlrifMx3X60QrKstO/3HCipVZ2ki8nzwpFbaYm2b
 ONSK5b5PZl52/4zuauqNg+KwU82AEovKp6N1C1e+ORyVUPSJs4991SbiLCHNa2LAQaI5vL2k+
 yCeltcfOv9zoJ97lVHYyPZwpk00EwWHbiRdFnR3lp5uzwQEkqTSz7ytDdir6+pm/2ICxwoztb
 HKVMtWW+u3j0gt+aYPMTq6ZeI091UvTpD7WU8kJFM4v5kNvnvUDACMmNncHpOqX0ynH/ej+Yo
 pR6bIqdwto8XYxfy5NmdUguhRos=



On 2023/12/2 18:34, Russell Haley wrote:
>
>
> On 12/2/23 00:43, Qu Wenruo wrote:
>>
>>
>> On 2023/12/2 16:43, Russell Haley wrote:
>>> To be clear, there is no reason to be suspicious of the other disk tha=
t
>>> was converted to block group tree and has passed a scrub after
>>> rebooting? It should be safe to mount that one read-write again?
>>
>> Scrub is only checksum verification, no comprehensive extent tree
>> cross-check like `btrfs check`.
>>
>> If we really screwed up the block group tree conversion, btrfs check
>> should be able to expose it.
>>
>> Thus that's why I'm going to add "btrfs check" runs before and after
>> block group tree conversion.
>>
>> Just remember, scrub is never as good as "btrfs check".
>
> Thanks. `btrfs check` passed too, so I've removed `ro` from fstab.
>
Then it looks like it's less possible that I screwed up, or we're
hitting a really corner case that only certain layout is affected.

Anyway, more `btrfs check` never hurts (except someone is super impatient)

Thanks,
Qu

