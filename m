Return-Path: <linux-btrfs+bounces-2197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E584C450
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 06:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D361C23EB6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 05:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AEC1CD28;
	Wed,  7 Feb 2024 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l4yFDEpv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB31CD13
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282431; cv=none; b=Dz6ZVSuXDrPtULrqNdC83Mn/dWATzwbigOLhbhNb25Qpemg0vBAMXud5D4r6NW6bvPpvBr742Cibre1JP64zXv7MaVcfqROB16xDcpuskJUaU1RoPd/JRcklPTlMFTLuD1mzmLk50zfEJuk6DGeJCD3RuknzjRVSb5eB3QJ8zgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282431; c=relaxed/simple;
	bh=624zyd2xEokuLDPaic7eK1KQvrUJCw2ZKDgXEwNOOJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZsQNN4ctfbi4p8eBsciFEY8R667rUoIM6LUhEWrtfeXq9KMRtbMUwSzO9g8dmCw4njXj0yvn7DOJ0yuxRStg9QHtB/au1d8YNLw2cuAUyD+5tTFyzS+0+zVJL7tO7Ef2aLEcgWyScRrGCKzJFKy6ExGxNaIDAo7An+CcYx4z/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=l4yFDEpv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707282427; x=1707887227; i=quwenruo.btrfs@gmx.com;
	bh=624zyd2xEokuLDPaic7eK1KQvrUJCw2ZKDgXEwNOOJ0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=l4yFDEpvKdLGglYei38v1QJ8LJVmc38it8QegETx6OeEqv36uOqDXGBcxykksnDu
	 +pr5WJYaT4b4MGdKQSCyBrqrMfofbK+H/eae2meH4NDHlxJtMH6QGdfPAf3x+dXLc
	 cnr8mq6gWPgbzRhREL5olj0KmfSx8srfDBdVeeoR61mZkUCLYg/K7B3Gd1UR8WH+D
	 ZTi0OP9rgxx5sNoZXCobevMUFxw+XZEIqHlnBL6VEZWc72LpKunxJ8F+Pk7qhfHg6
	 kOySTmHEevqRS4jH1Y7z6bch99aqNlxv9DqqdD01Uc+XjHa/mdrfbxi/v8n+rn44l
	 9gDzO8O1jK6dcLEfhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1r0iEk34dU-00bdr8; Wed, 07
 Feb 2024 06:07:07 +0100
Message-ID: <07bc2e91-0106-48ab-b07d-f54b75e9a991@gmx.com>
Date: Wed, 7 Feb 2024 15:37:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to delete/rewrite a corrupted file in a read only snapshot?
Content-Language: en-US
To: Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <ZcKEoftmxxp3SOiB@merlins.org>
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
In-Reply-To: <ZcKEoftmxxp3SOiB@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XMGHCuDfvazNojvwenR+uDyu4XFL8bmZtF7OoeWmLqxnclXs1eS
 CPD9o9zLOJRIHqbCgwC7f3ySqZBFUEUCQD5L5HZ4gesoeM2o546S3QeebH2zGW7q+31n5Ka
 2uTz/ga7s14Ea+8krs3UKbA02/bIrNDtnoQCUipiYKIKebWZxjGG1vvCC17oSjZCbeBKgeI
 qVWsZJY9n+y0GpfPsfIYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E1qMlXZf4k4=;9kQZ5anvBu3J0+lCxFOmhWsz6bD
 TyOkyAxmOG8RpJtSai5X2LMN23wiLl77Q7x2pGiUIfP1RMmitkwQtDQfXv8WKGdBU9Fp8LLAE
 G9sWm//a5/fn8cvJ97Evox4FrfbjeGueKs7fDMe7YFwAn2GV19hQQzw03KrCgMspSTPVEp26B
 aNEdR7xB8yYn4PwfbibTtnFURK0cO2zVEv1qc9Sl4tXJuONqcgcrbf9f2E0dVxRnE5z6hHzeu
 PFNdL6wltiOVjEhU2FnpUM+glXE982H5idnbh281AWAbVI0yr8F/tI+ccr900/4U2uxNkKc8K
 APbdLANlWyOVCAdWgLcvgtESGt6IUeo6HNcYq2FU1tAXdbrhfcGer+oDznoWtNNRkvDNaQQW5
 nlw6j7nB0PX1UOTRz0qdu3uPqmL5MKSzSiepm+q5N03lGJBjjWJiwnbc46Pi5rvkNEaJhIW+H
 r8Yh4xjSrYmechR/fUfTe1K3JfN8XTX3fyKTXgeDh37tXIFq2i2N6n0z8JyBpA0b6UjiswPj+
 lb5nkaujNDLaY7Aw6PxZ3kpak408kV7gCaLZD4NX/pLKfG8bGgXRilFtr/4wYM7BISv8lVbsS
 MljwXcXc9piXA1VCgDNSyDf/ETf5MuDiptBCGDDJGC1omLuJQVvlSWoiausfYGjhmpYD1X+dm
 eWa5XgkUQIbdDvtVMpyodhz/qv1oUEB+uan9qqqMJWBZ57KqstSjxOiaghfFjxPUX7fms37X3
 qQyeIKWbhB+VTLOgBDsQKtWCAlFv4z8tKiZhDK/6p+o2Wsf9XpPhmjU+RIvJ+1KHiZtdH+r3F
 FO9+mF+ueL9iQkKqA9Fk/JzdrrEQZebZAQwLVmd2pVlFA=



On 2024/2/7 05:42, Marc MERLIN wrote:
> howdy,
>
> I'm seeing this during a background check:
> [374402.156920] BTRFS warning (device dm-18): checksum error at logical =
4401320624128 on dev /dev/dm-18, physical 2939697954816, root 63534, inode=
 595460, offset 1506283520, length 4096, links 1 (path: nobck/file2)
>
> this is in a read only btrfs send snapshot, so I can't just delete the
> file or the snspshot (I have 20 historical ones all with the same broken
> fine).
>
> can I either
> 1) force delete it with some admin tool

That would break any later incremental receive.

> 2) even better force/overwrite it with the correct file from source?

That's possible manually.

If you can get the correct content of that sector, you can manually
write it back to the location (all needed info is already in that line,
including where the device is, what's the physical offset, the size)

And later verify with scrub to make sure it's properly fixed.

Thanks,
Qu
>
> Thanks,
> Marc

