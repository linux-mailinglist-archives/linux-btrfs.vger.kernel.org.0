Return-Path: <linux-btrfs+bounces-399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DFA7FAD43
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 23:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEFB21473
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0748CCE;
	Mon, 27 Nov 2023 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Vuach4Wh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F43AA9
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701123455; x=1701728255; i=quwenruo.btrfs@gmx.com;
	bh=DRhLA9VE53ZrNoht9tGvrvPRdE/Y0Zx8p9QmWFBXLXU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Vuach4WhOLQRafX3/WxOPVRRLaB6E8Q5B6W2QSuFplWvcaJAyFdHD6gSvod5XGFk
	 7DVjtSMX10NWi6Z4LPWBgo4q6n1MvcSlXBmsnztY+Alsf1o8J89CILupOaUCuRgVE
	 wVXa9dWzTFu5PRm67vmsmtc3mVyAdQAkjpohT2BVUI4wPFIxuDEKuCpAzVuyq6mq5
	 w9Mfa5bANs8TnK/23fdRV5rhyhSy5wSEhF5AY5fa7DkUXYdQEbc/+MkCfeo5oJAcY
	 GKGmXQJHRFSpbGlz2B4iirsTNRQnCsPJk1U14MfB5jwofzj+wqEAEaV2cGdM46/xj
	 GxqK0UebDE9nPTR6kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3KTo-1rHKdp0KyA-010Kjw; Mon, 27
 Nov 2023 23:17:35 +0100
Message-ID: <84df53e7-7034-4aba-a35a-143960d626a3@gmx.com>
Date: Tue, 28 Nov 2023 08:47:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
 <20231127163236.GF2366036@perftesting>
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
In-Reply-To: <20231127163236.GF2366036@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lvnMwfUuYcoXhWqKdzd7x9G61iNf3GWLCuwmXqhbDvu9svUz/TO
 VZCBpvmNyt8CmDsssUGBdX3Pt0pe58Omx4pTT2kshmCK44IbQOsylLVVCn0ZA5nVlZM5JH/
 Q7dg7ToFQ2uxNcXa4I20CZwDy5Sgl/ixVKgBu2d+IUqV3Gy4629OynJWWXEYGQb+1UIbVFt
 N60maXxIijHI8b+4tfE6A==
UI-OutboundReport: notjunk:1;M01:P0:57hBkbJIu+A=;XTwvvIoX6Ekhd1ytSVw+OaN5+N9
 I6UqJgSvQRaxU/wFiIOPdJqEd6MBQh9Fqd5iWkQVyTa+dMFAzygVnBuloXQlI5nOflJe8yMg7
 Xkzm4dAglTjNNGNzRAZDyBdnHbF27KYiMDN5PioNIiTO+5QR357jDOdl1hbkFdWq66mgDLmgO
 nXMKKzN6/5k6se2hRvTd5iXghAm9kRPP82ay+ZoUzYLaWEaFuJdp9Fj6+go63Gbwnw3tWB4Bb
 Q/0MsDnF99rDNqfYUfcHFsSFBHo/PD56GyzmMKwuLDzyPYoDai9xuX3nkeYXDa0VpvAbvwpNI
 QGKEgq9DBZweBHzUblj2jRN8gKhczXOfkJI7gEvZkacA5vWbt4GXcE3DzeyJjn8T3+xFuBUDG
 3haZ7qEYD0u4gHfwRbvZ8G+5rpB2aNPD/xni5XuiN0MzfvSUFCywdDo61fcwsi7s4YT549Ff6
 d31+lJGTCBXYJv7VslhTtFtyouHGjxUT2gHIrbHgoILpW/Fr9WvHk4qoIcHkiwBMKbtVJSe9N
 R1qy2UFSSItRqpuooMlR4nGUBXSt93aoGjYTMD8xiuO3UZDkvXX0W+84dC9I+3/wwdzT896+d
 TJ9/rhaKoPWr/oqvPHgQ4XTbBpOL1iDakhdGLT0KivGBY3qVU5DbDP7xuyiGmAYO+apsyXFA7
 Led0W6MLA2RvA2ZAhrv0yPBjx2bUIU2zK3TBGqMgv/WRM36c5VBP2qAqlKYfga5rWPVOkzl0o
 m2H3PNgpJ3OcX45RXLfowIyhic0CNIQS1TNh2Ay0WtxaEMtW2tL2AXa3NSUFV9eoh6sTBQksf
 LwKgLV7jSc/7OXsABPrjNKEtYijFgGGelQ8+Tm+2d6ptG71eZaETvT8TE6q4UhuLVw0s4g58u
 dzXUUrCg+pupNiCFZXF3AEDBUVV5Y8SOIx3yNf1u3wNX6h1E/teLzn7qcYGqKHksZXB0KLuz5
 XKTpGA==



On 2023/11/28 03:02, Josef Bacik wrote:
> On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
>> For now extent_buffer::pages[] are still only accept single page
>> pointer, thus we can migrate to folios pretty easily.
>>
>> As for single page, page and folio are 1:1 mapped.
>>
>> This patch would just do the conversion from struct page to struct
>> folio, providing the first step to higher order folio in the future.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This doesn't apply to misc-next cleanly, so I can't do my normal review,=
 but
> just swapping us over to the folio stuff in name everywhere is a valuabl=
e first
> start.  I'd like to see this run through our testing infrastructure to m=
ake sure
> nothing got missed.  Once you can get it to apply cleanly somewhere and =
validate
> nothing weird got broken you can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks, the failed apply is due to the fact that this relies on another
patch: "btrfs: refactor alloc_extent_buffer() to allocate-then-attach
method".

Otherwise a full fstests is already done and looks fine.

Thanks,
Qu
>
> Thanks,
>
> Josef
>

