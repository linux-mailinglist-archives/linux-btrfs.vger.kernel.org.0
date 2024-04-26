Return-Path: <linux-btrfs+bounces-4561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C98B427E
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7331F22901
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 23:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D13D0C2;
	Fri, 26 Apr 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RNXahxmC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A723C46B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172794; cv=none; b=Po0mPpq563equzy90JGqzv7oe9Bw2h+S3gLcCn92NN7O9SEVAmX58nUqg2UETFLtMpt1SzzrNfxuzyE2ob6CjOwLVqgre0uh00DAqcZoiWz6sWcdhvrST1K+QOtBNzn8JRNSmSnmSMOkWLa4L1L19FPUyTxcwP3Rpe3UNF0sUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172794; c=relaxed/simple;
	bh=hlXel4XS3ywtdxadR4h7nrO1tCDzUGeNBfoWyVqxP4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IMItlEKAWwT1vI+d656oyAIp171r4S2awaZLhfQXw+7HPxTCbFwMP2NKNfWiOFC3Y+XyxMFFfX4dhoXo9S+16C2zOEZ+VTmYFipk+cVTWiOkGhzkdFWozjTiBhYAHyeKpYhmq1vS2Sa5IlSTF88XSad4WDrB+5hnljDL0GLHcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RNXahxmC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714172790; x=1714777590; i=quwenruo.btrfs@gmx.com;
	bh=hlXel4XS3ywtdxadR4h7nrO1tCDzUGeNBfoWyVqxP4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RNXahxmCPpJxwwzPQ4Fhfk/lB5yxydkrmnAWeRZyxMf2AinbSiw9j/xRxnz0Tr3S
	 P0w9YvUEe+3NWjFONzFy+J6eHhM/NrsjfyA/EvYL10hpBa2iULqQ6frzykvuIR+9+
	 jtoatWilU4eOFpcJvlE3Irg4JFX1FxXNvFXlWdd/J3rSCOTFl2ZuDr4mHJslo14IV
	 Um6xk+gqc7dLqA2jphU2x/Spjqkc1EOpdgUBqTysLNcNw1rkG8IzLzJGoAQ0KWcFg
	 /ezKQ0aQuXTqOEqVWnHsslTPnOnsxHaGNUIIxSB2g8tZlbKiLoUBz0zUFJEBTOlOE
	 xzItiNDo3upkUb0QPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQv8x-1sMGkl469n-00O2HH; Sat, 27
 Apr 2024 01:06:29 +0200
Message-ID: <71f2d380-9b11-4ed5-949c-0edc1ed56c60@gmx.com>
Date: Sat, 27 Apr 2024 08:36:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's the difference between `btrfs sub del -c` and `btrfs fi
 sync`?
To: intelfx@intelfx.name, linux-btrfs@vger.kernel.org
References: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
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
In-Reply-To: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LiMheyJMQMU+5on/Cts3wjD053L4iS9eQocXnZ/5loHRPBDLbv+
 XmATpMpo3mnGe50FYJS2+ZV4y+g6QO08fYO8kp5Nx0cwSclh1UUCGD4J5pUXcqse+OZ/VCD
 Srz/ZbFjHS51hzhfIxKLiypCfEV4Y3FJj9N8C8Gb1ljYG5rReQOpUiylVBMc98U2AjA3lpj
 u0XRkEvFpsjFwJ6f62F/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:otJYgOimgds=;HN6tGnL6NVWphQntZIsuPPNvE/g
 I3xPgT2zEHjQoMN6tufVWY3o508h+l8ZvXjH9uO0ALkRSrd7c5GvFIgKdm0Cn3Pc7LeCjui1y
 u2SjCE5r4GQu6aclGMxopf1TnsQG+51bZdhdXpSE6kYvt9EAszP64t23gpr9psMfnTCqTq/k9
 wnZk45M9PIgWenHfQCBHXU+avIN3WvZXDiLjoCPoWqRJ6ytS1RhV645hkBcB0vY2anYMZmgjh
 Yj6P6Bc4pLrwMZQt77O68h5A63LJU4qU6chnnD6gKshWtAlk/TeQY8hgI81fGAyU8S50S5EZ8
 PhBbSkGkRXsoddzA8OZ/fzvFPDWS+S4RVLfYKaf030o3GjkGBwCmSc8L8d+CHe4PiXwr1npwn
 i1emtIUt/tDuHgXLwYPZHbk0XA3ejm7q9S1k33kI19x8r7/4bSXQ/BOM+MD3eRE9xBoUO7UOm
 7xkLDSGdHryyc0nMVcg6cmaM6y9HmQBYime1ZRJMBBQH4NVIyQRkK2E2G8OgCIRL/Lv+uAJaU
 KOl8MUeFrEhQb1zDyFxuS4SSheWtbzV/RtAAOIudX6fG3ZkpQNZL2u7IGXk2cXm7/ejEhcM7L
 KLMYoyLz6aRKobBpsFJ3oBGs9q6uq6JUx/RG41ts+PAt373gzsAiHEU4Is92xlzloqvSXlqcn
 xeitxpw6FMuCjTXpIvSWPSrSGYrOdTJAr44h4PZwejdWxHP1p/cdDUgwdKDU9626m/vsevzg/
 Jebrq5c7JELQsyIQuro2SiXsWQsTNJdhUiakzQ3mXCC0B1P8ThbekUcXsWf71/FMR6MQMxIQG
 0EBXx3EVDpcIsjqxVSRVgHGjSBD9NHDVOR0ZKeRGS8s3U=



=E5=9C=A8 2024/4/27 08:22, intelfx@intelfx.name =E5=86=99=E9=81=93:
> Hi,
>
> I've been trying to read btrfs-progs code to understand btrfs ioctls
> and one thing evades my understanding.
>
> A `btrfs subvolume delete --commit-{after,each}` operation involves
> issuing two ioctls at the commit time: BTRFS_IOC_START_SYNC immediately
> followed by BTRFS_IOC_WAIT_SYNC. Notably, the relevant comment says
> "<...> issue SYNC ioctl <...>" and the function that encapsulates the
> two ioctls is called `wait_for_commit()`.
>
> On the other hand, a `btrfs filesystem sync` operation involves issuing
> just one ioctl, BTRFS_IOC_SYNC (encapsulated in a function called
> `btrfs_util_sync_fd()`).
>
> I tried to look at the kernel code for the three ioctls but to my
> untrained eye, they look like they are doing different things with
> different side effects.
>
> What is the difference, and why is it needed (i.e. why are there two
> sets of sync-related ioctls)?

IIRC --commit-after/each only commit the current transaction, and it's
just doing the same `btrfs fi sync` after all/each subvolume deletion.

The reason is to ensure the unlinking (not fully deleting) of the target
subvolume fully committed to disk, so a sudden powerloss after the
deletion won't lead to the re-appearing of the target subvolume(s)


However there is a another behavior involved, `btrfs subvolume sync`,
which is to wait for a deleted subvolume to be fully dropped.
In the case of btrfs subvolume deletion, it can be a heavy load, thus
btrfs only unlink the to-be-deleted subvolume, and mark it for
background deletion.
`btrfs subvolume sync` would wait for any such orphan subvolume to be
deleted.

Thanks,
Qu


>
> Cheers,

