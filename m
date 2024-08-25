Return-Path: <linux-btrfs+bounces-7478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333395E2C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 10:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5230B2154C
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154A57CBA;
	Sun, 25 Aug 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GcjE+XlX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1154765
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724575673; cv=none; b=PXk4+Du9eNgr0aX0usatw3U71O+pxnMr4+RBJSOSJpdhVpe2hqgFdquXWSH/ouphQlX5r4pfP6jqg0Lq/b5MIMXdEdm//xV22CXSu3wbES4r4DLNPnTGZDKITPdj89fckydILIpgeS6QYimKvp0HXSBuKjZk19UraucCVYHRzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724575673; c=relaxed/simple;
	bh=ZYrOP8GZv0G68Vch5er+YlQDfzNeuxGJ6E5AcdTVn14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z5PXub0RuEMYSAB8Ty1Fg0x8dsVqhisJKbZVErkT4mu73i9P6Cl2tRhsrlu4Qe5XpyDHnM9vw9LcOqc3CZuBTLidUwxyKksu278XQD8dVd7+4BuJE0u8/mNaimcT71SnkvsEbWs9MNW86qeI3K2sPmI03Z5dRfVOhemp4j3oHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GcjE+XlX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724575665; x=1725180465; i=quwenruo.btrfs@gmx.com;
	bh=ZYrOP8GZv0G68Vch5er+YlQDfzNeuxGJ6E5AcdTVn14=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GcjE+XlXeL09xOlAqFxk0Fqe5QeJyOHmt+cbt6nK23Daw6xF0lUaaGKWh1/4+D3z
	 EKtKh5686Rz8JnKcXMYU/MAz38keOBE9lwJeh6R2CYmWBf3LYpL/AbtSGFF5IsPRW
	 wVtwpLKJabqGq/+rYnsPJfjYqtbC+aVCXQWFdsC8F6SJb9m+gLwNIMRzWp8bdyJfh
	 9/kKqKCglDS5CPm9pmxsmrlm0OJvohwOiV6lBdEQEPA5GZqaAUaNn/6uTixz1Dk6A
	 GYkkpEa7OKVAOnUF0RlLwDb1/XiIEelpXyRdE2EeCafnXaA04O6xrXCuossxruNIP
	 tXva47ekiz1c/DINuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1sBHzt1eOn-00aSUU; Sun, 25
 Aug 2024 10:47:44 +0200
Message-ID: <b5cd2f6c-e157-4e4f-b87c-a3ea171bd5c7@gmx.com>
Date: Sun, 25 Aug 2024 18:17:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: oops on 6.11-rc4 loong64 with RST & subpage enabled.
To: Yuwei Han <hrx@bupt.moe>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <EEF4303B52E6A560+21c563de-b84f-478e-897e-e88eb0ce4b94@bupt.moe>
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
In-Reply-To: <EEF4303B52E6A560+21c563de-b84f-478e-897e-e88eb0ce4b94@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CcxBsCAhghCjIemn3C9G++gUZG6xUX4Fkt9GhW4C6hxK141WqGv
 6EvpvbEG6N9yv949II70oEGZsiPtJX/xjjup1D210lLXgojZvbhKyEZhmSMx3E6i05i6Wd2
 ffiXZuP10TCqGmnK0KeeCbMHW/8FRdLs6S3KyeXTVLgkVqKyRj33Dp+o7ewvluLkeyU3nXt
 IheHtz1cLC1M0BbrjNpTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6sRsMzOEieY=;nrfRnGxskHIboJbsVs61b8CLX/u
 MJQZsZNVZQitg3p+W8v/kWIKxeSpz/n2AKwyHx7s4gQVzcpIPQcFpn+m5+V2q3mjGGa1RaFzO
 pknvMnAFKlsnRj6QKOkG6DbvvO1RoOIQLkHDf5t6wQQW40dBXEjCz85Ws4pWKoQTcDvQZS8nV
 Uqo5WJFLRrfn5t0AKTVg6SUC4I0sNI7VZFuc7P1fQcF6PLb3FqESQjaYDsm6e616wfYsM2bVF
 EVeTfRH1GJRS9DwCsNcZdtONiGr7Jpx+vFEZSMETSLtnl3WzuMHDDxs1QDLJJzP3CHI3tIKHs
 yUXxFj1C4LVjuozmK0g0X+ewdnGZe2omOsc02+oXAxJHotE5XsSv1NQ2tnrbnb+DT4Dhw7Ed+
 1yC7yCMy+/8MqLQyQ77O497FRUFxeryh0q/cD1Tq5BP45HYeMMwpLT9ur1V1HnG24v94uqKG+
 yE0wT9SyWR+vN+ZRf09Df3qPtu2o2FutybQ2uT+JzN3xm3hVbFAJ4cFcolG4zQ0XmJuUxHAsn
 XvfDp882u1twZMB0iWOcyReN6QTr1/T+eTrVoW200t6eLHkAOO+cbS+6pKkQY7Eiz9blj0X2U
 gdf/hxqf/9set5DUlSXbpkiZDHBj66q3ThBblK9GWkMnv7MZa/Xm73TEzPoqqnTDVnnWg4LUZ
 7ykz5Ps+vTCMbJl5EoGav5zpMfC/k3JPdlbkrVGWAddD0ZgAJvZCm32GYNTZSto9RIGQ+kZdz
 PpzKkbRfGBOuWna6O7ESdO1ss/3CVdLsAU7kuGH7dKEYApBt2MQQSu178C6ddLKUx7ZoFEOO9
 gCIUZGRh/6OnVPLVpGqz3MfQ==



=E5=9C=A8 2024/8/25 18:14, Yuwei Han =E5=86=99=E9=81=93:
> Hi,
> There is a oops when I am testing RST & subpage support.
> https://fars.ee/vTGd

My bad, in my patchset to add the subpage + zoned support, I added an
extra ASSERT() check to make sure that we didn't get compressin/inline
triggered.

But forgot that zoned write by itself will return 1, triggering that
ASSERT().

I'm already working on another patchset, mostly to prepare for subpage
sector perfect compression support, that will remove the ASSERT() and
the ret > 0 case completely.

Will definitely let you know when the patchset is finished.

Thanks,
Qu
>
> # uname -a
> Linux aosc3a6 6.11.0-rc4 #2 SMP PREEMPT_DYNAMIC Sun Aug 25 10:44:46 CST
> 2024 loongarch64 GNU/Linux
>
> Disk: HC620
>

