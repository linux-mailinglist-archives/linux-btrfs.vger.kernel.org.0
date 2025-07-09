Return-Path: <linux-btrfs+bounces-15371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317CAFE30C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF823B208B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF127F182;
	Wed,  9 Jul 2025 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mTFaOYgr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E423F294
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050748; cv=none; b=HosWA/n5FxrlFCtR2gSil6YHqHvbbUbN8qoFgCReaYAFuZnDmhN+3u85FXBle/HnT+dh01l+TzfV69Jwl6rBmipsc4iSmoNMMRIm4s7RX6ceN8jrEZc74/sCkIKJUUEyNr14pcleCg20UsH3fYAvf8etX0MzoLr7KOqbOAT2XG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050748; c=relaxed/simple;
	bh=6vJdzxjDNhHgnt7fMZTXF+B5E7f4hee3pcqYausUZHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ewPhJH6CM/1YeaKkFc2e5utcohb1KG0kYJNbQd1sMJXiGMTELJnLuXDXl2RjK7RWwuaaxjHZoJfYCH9whE90bgbkFfxBwGSYRyZwmG8iTfDmlBg7264uy2yXNO7wDxGPUHkl+XMjkcI2Rl+VOi5ClbPtQfJTKSTReTTEM5irG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mTFaOYgr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752050741; x=1752655541; i=quwenruo.btrfs@gmx.com;
	bh=7JN8C44lXrhCcHt+w8ZEM+BO+EUKJByfuBiH4rVBuIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mTFaOYgrlBZXhhvhrdsBTEDPK0vQVqtzdONePBNNYVGlBNAqnQEViNvzOprWQ1Oz
	 6SHqYPPe1LQqsbMCnRUow1p9Q76zhcg53++fmOWaN9y9U8LnK6vyJth7eq55J1wRe
	 Ub5kLHIo4s+kwoI2fr25hypq0bUdnJj3AUvdUZtZsBaVfQpIyginMKJsaAI7+DgE1
	 VR2Y5wHJjKUreQqIh8UhtUmePqpkFwfSMXk4WwNoXKwR40HuS4I25hiGwsTCmItM1
	 sAO8BOXXhERpxKnsF1KVO9JQS2HM40pydM6PhPe4OZ8Z2qsT+eneuekkrRtkEST8k
	 6OAdYLkuLHeeBuEqCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1uOevF2hpp-003iD8; Wed, 09
 Jul 2025 10:45:41 +0200
Message-ID: <6052bd94-a613-4101-9d92-6f0ebb0c6dcd@gmx.com>
Date: Wed, 9 Jul 2025 18:15:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: do not poke into bdev's page cache
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1752033203.git.wqu@suse.com>
 <d3fa291f-656b-4430-923d-567208146302@wdc.com>
 <68c81f63-d7ca-4222-948c-36b7e5c863c2@gmx.com>
 <4d1fe325-4b7e-4d70-a076-8546902fb84b@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <4d1fe325-4b7e-4d70-a076-8546902fb84b@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8cRIFfSyVJgt/Q0OIJyd0TSQ/t/lIZeA5eAPUZ7VgEYByOo9lfI
 Yodaqo9vygOg8CSfBVMvNjBxzrz/6V1mxZuV9cCg65ziwrdLRKaRK+ugVTSeYTCGo+2/E23
 PxlxggYpaAkvCJFKHtHUlwgIGD5Rnm2OpUOJFRoR+FDqIk3toYqgzD6rXXYe+x9ZMAvsu/e
 G5qECo2j2l/4rzFT/xT+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vwN5DBlhq8A=;zpow3pWGoLAdQApRQneZQL/IhGG
 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
 nmZVPf4HyNm0/jkawhiiEpzG47E4aTa0=



=E5=9C=A8 2025/7/9 18:14, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 09.07.25 10:29, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/7/9 17:13, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> Minus the nit in 1/2
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> I'm also running it throught fstests on my CI setup (nearly done and
>>> looking good so far).
>>
>> If your CI run has finished, mind to check if the generic/492 failed
>> randomly?
>>
>> During my local runs, generic/492 will hit random failure, due to blkid
>> unable to find any useful btrfs super block.
>>
>> And that is caused by the 2nd patch, which makes sense as that patch
>> changed how we write the superblocks.
>>
>> So there seems to be something missing related to the writeback behavio=
r.
>>
>=20
> In the CI it finished successfully. I've manually ran it 50 times on a
> tcmu emulated SMR drive and there it failed 7 out of the 50 times with
> the following signature:
>=20
>=20
> generic/492 1s ... [  119.110313] BTRFS error (device sdb): unable to se=
t label with more than 255 bytes
> - output mismatch (see /home/johannes/src/fstests/results//generic/492.o=
ut.bad)
>       --- tests/generic/492.out	2025-05-15 21:26:16.848414286 +0200
>       +++ /home/johannes/src/fstests/results//generic/492.out.bad	2025-0=
7-09 10:41:47.280866272 +0200
>       @@ -5,8 +5,6 @@
>        label =3D ""
>        label =3D "label.492"
>        label =3D "label.492"
>       -SCRATCH_DEV: LABEL=3D"label.492"
>       -SCRATCH_DEV: LABEL=3D"label.492"
>        label =3D "label.492"
>        label: Invalid argument
>       ...
>       (Run 'diff -u /home/johannes/src/fstests/tests/generic/492.out /ho=
me/johannes/src/fstests/results//generic/492.out.bad'  to see the entire d=
iff)
> Ran: generic/492
> Failures: generic/492
> Failed 1 of 1 tests

Thanks for confirming, it's exactly the same I'm hitting.

And it's pretty weird other fses, including f2fs and ext4 are also=20
utilizing direct block device's page cache to do super block IO.

So this is something weird here.

Thanks,
Qu

