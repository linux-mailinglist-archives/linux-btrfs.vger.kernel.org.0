Return-Path: <linux-btrfs+bounces-1125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312981C4F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 07:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5105A28408F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEBA8C0C;
	Fri, 22 Dec 2023 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TYIYNkYY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E186FBC
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703225611; x=1703830411; i=quwenruo.btrfs@gmx.com;
	bh=JIXlgCn1JxDVlyaeD+tXujSldr0DyR00ylz5u7ZzWrM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TYIYNkYYHP9fQQ6ltbjd7HlcV6ShqtX6UCPBKL3no5pHPI6Tt1qFPNNNL1kv+Bve
	 8xqczkM8tKfvqVhfkxdA97COUVSlHDBGCZ3AoPCuZhfhV78iEgaMioT8m/YOh4TNm
	 YgaSIvi9jGmA8AEB20b/ShK+82tw9B4tFy6dSO7u8C20cHzSIC0ggPBY4+ZQKW7Yz
	 Z2mA3p0t8X/DxnH9Dk8ct7P8PHEzYAig8Rj1SNX4MGZgcHJyqnHgisfMAVMm2ovd7
	 0CCZf9Hwx2gH5qa+bubC/BULFIKFMlaDGHSG00kfg7cKHPrKRMvu5Fyp6aa9zyCsJ
	 rSEflILnz8//CTu3Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.114.154]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1qsSNm2uim-00kMdN; Fri, 22
 Dec 2023 07:13:31 +0100
Message-ID: <ef780348-5570-4f5d-8c92-bf7bc4868752@gmx.com>
Date: Fri, 22 Dec 2023 16:43:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-US
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
 <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
 <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
 <a9fafe9c-27c8-4465-aafa-a4af6987c031@wiesinger.com>
 <6c2424bb-9c91-4ac0-970b-613ca97b3e01@gmx.com>
 <771df9a9-c7c3-40a7-a426-0126118d3af0@wiesinger.com>
 <9f4ad251-7af7-4f02-b388-64dd6c8257ac@gmx.com>
 <0c644c25-7ec4-43da-a70b-1632e87490b3@wiesinger.com>
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
In-Reply-To: <0c644c25-7ec4-43da-a70b-1632e87490b3@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:29LoQ465Su+lriLIoiDjondSCFHn4qr6iyQIjN5egQR1YHYfAVE
 fxXdJxdyGyBx6jyO56GlhXc2dOoNDGAgMDsqkHlEwp8FCMzRC85FzgSwv7HuSAeIv7QFpyc
 379DeELDIKLYSJ0mScRkvHdEy5d+PXol7yCXFTaJwnnFyHKdDlacQSppZwFPwAGxcOvNA9t
 QnftQkT8YaYEaZJBH0cVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S/wk++4cczM=;xx8yRiczSlFH7NYto9g3xoMV31K
 gcw/GYLLeofpd3lYsTIO0r+Ab0irM2fzs16aog66p983gb6c2rHtSU7zDfPEdFEnAkWtnXz+T
 8XlMlJWCJ5MgI/wqgmKHcfMMuBifzk6zjEYHhertEb/6utDDCJ/QZHj8KFZ5oZh4PPrNoBSQB
 qT7MNePusp3zXdw97Wx5QRUfGxKIYaNsEDwXXB/I3urX7kE9JmybB8oIoNiP8lEpYbJxQpCfm
 e2r2AubYOCzDonyY8rDkpI8R1vt6UhekNMZDPhihcd7h5bBcDVqjD/UCthin0B9p1etN6ldNU
 Iez2wKQtkBie41agyZxfmZOhWH2cvh/I3wwl8d0WpAHa/l2B+7UtNCJ4EsNLe1sbMnc901WCi
 BTy1t7wMuw2UJcSSNzw6l6q98VzI8oa9feZx7KqMtf9BAmwA4ree5ssw+QoghWqhDSJJdra84
 Pt+d+asbVb0YXfmq8gpn9xVlSg1HNS4qmFc6iq/lqPvw496eXhyrjTTvwtFwSRCknY3mp3QZ8
 KpCfCmtj47ERwNmeBs7IY0oGxWElijeirnUgpMFAgs8zF3MsHCMdlatrOrzI9keMKhR039ZsY
 P/xt8FBe4X36M/nnFNxhxxHbqg8rrU6lVJ7cWzORtASW5//nVmLUMCeQRh9nFWJVtMCVYXpaT
 +pdCpnMNFpS4fxaQdiN99c9WbWMhxPTSXZ32ww99+UHlNCHOYGI4h3fnZMlpLVkDIYBDqACBe
 P4mGpX0B3xQETLs5bpHLszSQgi0SVKCwGgho2hC1jkvj29LjuffBKFFFQREkoCFgzqMXkvLox
 WuRnzLNBsGuyMo/x07dqaW0sRO7bWrTTr3+YQ+MmPtcX0p/Jkd9Waf67/ThScWpwmlmaO0pHm
 4F1ckKaCMTlCTPkv0t2kpThxOQEpwpXGT1n/z4b/80ktGHk8wvCgGTq5PB7R+XwnjCQia8lNL
 sNnifEz5xnIQ3+CzJreJ3BTLQss=



On 2023/12/22 16:28, Gerhard Wiesinger wrote:
> On 03.12.2023 11:19, Qu Wenruo wrote:
>>
>>
>>> BTW:
>>>
>>> if compression is forced, should be then just any "block" be compresse=
d?
>>
>> There is a long existing problem with compression with preallocation.
>>
>> One easy example is, if we go compression for the preallocated range,
>> what we do with the gap (compressed size is always smaller than the rea=
l
>> size).
>>
>> If we leave the gap, then the read performance can be even worse, as no=
w
>> we have to read several small extents with gaps between them, vs a larg=
e
>> contig read.
>>
>> IIRC years ago when I was a btrfs newbie, that's the direction I tried
>> to go, but never reached upstream.
>>
>> Thus you can see some of the reason why we do not go compression for
>> preallocated range.
>>
>> But I still don't believe we should go as the current behavior.
>> We should still try to go compression as long as we know the write stil=
l
>> needs COW, thus we should fix it.
>
>
> Any progress with the fix?

Tried several solution, the best one would still lead to reserved space
underflow.

The proper fix would introduce some larger changes to the whole delalloc
mechanism.

Thus it's not something can be easily fixed yet.

Thanks,
Qu
>
> Thnx.
>
> Ciao,
>
> Gerhard
>

