Return-Path: <linux-btrfs+bounces-8754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F99978F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 01:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8049828400B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 23:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD091E285E;
	Wed,  9 Oct 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rjznHWpd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88318F2FC
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515477; cv=none; b=llAmV8QYQpNzvNe8S34rZRF0ogaZeFakC++sn37kCgmyhFlapF7oTqoK/K6t3BnN+5gPik0aevv9geM8Zu7lcyg5Sn6gHeVSk6jDjG94bJ8BFHs+/m9d0FyHCrMijaiPmIc2aJIsQssQrKPNOEKK+eycVTCndxwKGL8AEkgxpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515477; c=relaxed/simple;
	bh=H4hJAQD9rCClvuLVK8dzaZ8iwDBBaj8E3b3e9W2x8Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhyQ8Zf3VgPHDLK+4c9QvYpqDwoUegaCdD0LLlTJSb4k9mFWSZtqqB6ZsUEANSKQ1TTFv4IDVPMsaeseD8U5ljhpCV1xIWZt3BV0Qou2HBKoSDIH/+6RRDMo6+56naOkRXJqRIkzRI/QCr+krx/ei9+l0eYsb4mcOyxMMAqAszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rjznHWpd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728515468; x=1729120268; i=quwenruo.btrfs@gmx.com;
	bh=H4hJAQD9rCClvuLVK8dzaZ8iwDBBaj8E3b3e9W2x8Pg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rjznHWpd6iJqNpkAbt6bwC7f4C4KRgQAZ6tb0aJA/9495KSiDHbE6ESWIsbDN5Gk
	 B1XtWwplzoXNNKknrAKD4eIfxa0Vc+SWPKgdyjWHpK3bYfba5KIxchrR/BjhILsEX
	 Mjmt23eta1H4cpi0BQt/X7y3/mUEblJtI7NUXPA/kXFNrzDdGl57EPqbcW5+cJ3jB
	 dR5ExLHIxpy5ROJvZCRu2PC0uZCvRj4lE4t5EkCwT493qTQDtSEaAuWXW81lg9B6Y
	 NbiG2ewC6cH4A/kQFLuyAuucRYNAqXvu4JbrS3hp3jCD/270y7Ym7+eBwmHH5aeLd
	 zy51R6kOJmgG5aYYFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpOd-1teLB43DZ3-00cGle; Thu, 10
 Oct 2024 01:11:08 +0200
Message-ID: <8f76a524-aa49-46b2-aa44-33f92fcd00a5@gmx.com>
Date: Thu, 10 Oct 2024 09:41:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, hch@lst.de
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
 <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com>
 <5c363f14-c3d3-4d5d-bc46-8b38d2bcd08e@gmx.com>
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
In-Reply-To: <5c363f14-c3d3-4d5d-bc46-8b38d2bcd08e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zV+jaoDfI10k83mVm9WDPjAQLYkMLa5uIfMudVvpSMUtyMT/lUZ
 +M+dBa4n5z5cYlhAR7PiubHVN1Vyyn5+vkveiH2kCvYlTAE4XyP5xvlcQLCw9AzedcIsH+P
 pDJymOmYfxdEMFtaNMdkfWUbMVP0TmeUyHzdKDgw/lYjAeOJ/Gk4Emi6pV6m2uCw3jS3Wfz
 dBCHL8Z4GI2ellF0aeC3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OyJc8M4o/5g=;Q90u9BfztvLya7h5nq5rzkXRw/T
 Hs9F77yHiUY9uE8YtjFVTiKUv+FMVu88Op1gGIIQDZ1tZlRmSKqZpSo2cYH7plr+mZh828l9p
 Y2tXWlGbVpMGG13F5zsp5CnnZDCJVmPdfuCKFO2HJU2/GwGmw0eCQjfYEd36wkw5nLb9dzK6O
 rTVYSegqGQBHV1maoosZK7rwKqXps31lhKCmaUHiSMz5s+8DggtUe//WYLe6wFoH2NhQ7JXWk
 n8pCMAkrtzbNLl2Jr50H5SdAIvumeB/biImOW/YV0soABEpxawEa/IrG4eHx/LhxwmGUqMOWJ
 Cl3wKlkQ/e3H9Z8RnUNb8bFWJfN8z0LjUjOd1cQmszewpKc1ybsLQrDkIvPVbmg43aV9aVUx0
 3KNQhe9MgGpRT8ocAjqnfFwVaDJFCZoKGSwrAeLrD41RbRwaRmswxjoq9Eo+NG1a0IbEO0AWw
 koCO7eLgFnY0Bw5ynRypGA7TG5+Y8rsH6XHWe2CrDTkYY+mP7WTB67ddOvcBZFJgiw45w97Dn
 vBF93VIV8Jofu7n1w+JltIwJcu8UtiIWapt+ed857FPitklRkIN1b2TDQG9OGneiyGxGnbRW3
 ywZc0BP1HMji8iPuUnROx/qmxm6EjoX7mtmKBleiRG9wk8kgHUICr0ZziGo9IUvfSPiYmf3qw
 TdQfTpusUWye7f0SSwmxaLnpp6B7NdkvoiX1LM6/wrKmaS1942NzHriSRsMgQoRCXUPj4Vki1
 /+eUJI+BWMMhUt4ulzN73j8dMA8uKCo3xJK4PlEJEYtxLghk6DKdty5qOBrqwcLSiYG104Bzc
 Ls2s3H8O4D5n2JborNGxywZw==



=E5=9C=A8 2024/10/10 08:28, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/10/10 08:08, Qu Wenruo =E5=86=99=E9=81=93:
[...]
>> And __bi_remaining is only decreased when the cloned or the original bi=
o
>> get its endio function called (bio_endio()).
>>
>> For cloned bios, it's mostly the same chained bio behavior, with extra
>> btrfs write tolerance added.
>
> OK, I see the point. For the cloned ones we can have the following case:
>
> The profile is DUP/RAID1.
>
> For stripe 0, we cloned the original bio, increased
> orig_bio->__bi_remaining.
>
> Then submitted the cloned bio.
>
> But before submitting the original one, cloned one get finished first,
> it call the cloned endio function, which calls back to the endio of the
> original bio.
>
> Then the endio function decrease the __bi_remaining to 0 of the original
> bio, thus it continue to call the endio of the original bio, which freed
> the original bio.

My bad, this is not possible.

The original bio will have 1 as __bi_remaining as the initial value.

So even if the cloned one is finished first, the __bi_remaining will
only stay at 1, not reaching 0, so the original bio will not finish,
thus impossible to free the original bio.

I need to dig further deeper to find out why the NULL pointer
dereference happens.

Thanks,
Qu

