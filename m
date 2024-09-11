Return-Path: <linux-btrfs+bounces-7927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D128C974C3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC8B23013
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BE14D6F7;
	Wed, 11 Sep 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BAMarAVA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DE14A4C9
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042303; cv=none; b=TNB1rtn0gxV2Q5CHu0BXjKX43pwjlhW6VYJps6WmxaV4Wgh6ZhzXUONOfezdU9WhJGrDnCeWkkS8xrvTDYqVD1mnxo4Y8X7E0l81OUiDcJM/05XXDUYEYzi9hO2mq3LcVgRHKWmxaAEs5pibtRqwKhwnT/Ibgr6Zfn5Bw9m8Ugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042303; c=relaxed/simple;
	bh=IAz0E02DR3rR/U78yyNtZ+0udr59wA9vhXWhCnwv/E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bw08l+7Gi8y4xqYjYrWpPrioratXouQ77aelSXREaHUBR+ZIEXCgdMcof6/gcw0d64wSWyF/YN8z49285trQpnL95U0+pZwqipXx53xV8nVqJb4v5t18BeVoUm2V90/zM+NLKGyUwH7jBpeld5hNJXnKzS5qsAq7AtDkTXIosXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BAMarAVA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726042299; x=1726647099; i=quwenruo.btrfs@gmx.com;
	bh=t3tv8ye8ocRg1tt/lrSs5sCNOTuawavJb73QsPly1PE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BAMarAVAI6pyVOkeLEHmrHW/0ivG+ic887wlZ3n4i6ELpCCDT504xcUv2h4KyauL
	 ATccBq1+hYnj3ggh6zJ/TwE/7Qt+9533K/Vfqnstv7BdGppr3Nv6UDw4EC56OTMtU
	 KWr19dUFta/atEa52WWR/056o/1cYSelv59a1mSy1X2mjTDV/JBaoyKDtB7yvuQVl
	 wlvSP+mIHxhfVT3EYZnaGfARMVqa1BapRH9gVhH/yAndSelo0YRtFJP9K+QL33eJM
	 0jm7SYh5Z3sSPNr7EHgQSw+esro0UYgBSop5toY5U/UWlds+vK0hhhjqZ6magFlYR
	 vfje41x9GZMzMpczgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw7f-1s6kUD216x-00j4mm for
 <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:11:38 +0200
Message-ID: <79e83450-098a-4e09-bfcb-625b6346525d@gmx.com>
Date: Wed, 11 Sep 2024 17:41:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs balance broke filesystem
To: linux-btrfs@vger.kernel.org
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
 <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
 <20240911080004.GA218002@tik.uni-stuttgart.de>
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
In-Reply-To: <20240911080004.GA218002@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P/JfJBe0Pzs0t0lfatJf1yRiC+4RhEIbutfaOLMpkjcQG91WGgN
 0tHGBQnmAf5O1hOi8HJH4QoCM6sFg+dV/dSPP2o0HhOly8D5sp0oG1OSmJm4xgby8oFwFQG
 sqtNs/ghrLAt/mIlHbNHhrPAdLOTfgOyy6fyYZM41fct3MIP2987Yer54nZdqDuFKyvSb1b
 FXsJJipg+w0iqfTbsnhYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9dHX/XcCQus=;4MQk4DL3ogeDKqs1j/sKWY4jH7T
 XmH6SFI11HwF4HMKMHhPSPFF08bPVFeUrdOU85cu8Fbl/bu8xHVdEkiBgK+GjK2pMi+UrA5Ot
 gzzGneexDS2Z+/wjNWCSY5u26A2taagTKBypm3dKoeieHdHXejLHS7hv2u3UEgUrlrPnQmMbS
 3lkGx1H9iomobFsRkUmU5pXHwb7CVBoMprmDKyjuxBY4xQE+AUZ82Hi6b+GoCGipfayetVR9w
 3bWJwV63GgQSmG6sokS4qdthSC00QpxwpIXg5CN6o1ffUK98CquIxxr5ETLJdvH+xO2KXkrw7
 oynfXe3nr2kA8CRBPz9xkTPED/GXjve0oBv0aXlSXB1ahZUMmhQYyuNSwG3K/DbNMMcioKo+S
 IaaAwmqXxBv2tBnU52IJP7cWrqgxr72hsnkrd2ISNkEd59nurSkSjxkR2pmga8zGkCh2ryPE6
 i6N94+xU6MO9i5dtcLUevtpR6bej8QaLHC3LRarzmS0WLKv0pqQRA0de0/EphF2I9FwBRrkkC
 fMNLUUMagRcDfK1DzUpAeVcaM6HQwHsGDHkwnb11N/ndSCpVHZ0NzxK4rrDfE12sYT1OkSc40
 70vFPYh/j934d/NRXwWH4oqp7VciNpM1YhcwdfbXMEk5v2lqoRHf7htOuL4g9VKASIRr2Je6T
 MqTwJEcQWUQAWYoMOuhxOOXtC9m16VABJC3MYMhspXJIX20pnNdivJkdtrvzWsm2neV68YDGz
 z6PKWJdlI699OGldb/MLZE6VO5446QeAiughBhYLQKWmABVp03jV0x0wwdgvAUXMm9MYAYh6R
 IpzrUZtmEjCWwl83VBEQDukg==



=E5=9C=A8 2024/9/11 17:30, Ulli Horlacher =E5=86=99=E9=81=93:
> On Sun 2024-09-01 (19:15), Qu Wenruo wrote:
>
>> Convert/balance is only recommended if you have unallocated space (show=
n
>> in `btrfs fi show`) to fulfill at least a metadata block group (1G in
>> size for most cases).
>
> How can I detect this "unallocated space"?

My bad, the more correct usage should be "btrfs fi usage"

In your case, "btrfs dev usage" is also fine, and that already shows the
problem:

/dev/mapper/cryptroot-1, ID: 1
    Device size:           915.01GiB
    Device slack:            3.50KiB
    Data,single:           842.97GiB
    Metadata,single:        72.01GiB
    System,single:          32.00MiB
    Unallocated:             1.00MiB  <<< Only 1MiB, not enough


This multi-device problem is a long existing known problem, I guess it's
really time for us to properly fix it.

The unallocated space is only a workaround, to prevent hitting the
situation.

> I have eg:
>
> root@fex:# btrfs fi show /
> Label: 'U22'  uuid: 3a37b060-8d05-402a-83b9-16690588a070
>          Total devices 1 FS bytes used 11.91GiB
>          devid    1 size 64.00GiB used 15.07GiB path /dev/sdd1
>
>
> I am using btrfs-balance.sh, which came originally with SLES 14. I have
> copied it to my Ubuntu systems, too.
>
> In default configuration btrfs-balance.sh does a btrfs balance on all
> mounted btrfs filesystems once a week via crontab.
>
> See:
>
> https://fex.rus.uni-stuttgart.de/fop/Gjo5Y0BX/btrfs-balance.sh
>
> https://fex.rus.uni-stuttgart.de/fop/bKWs8Gx4/btrfsmaintenance
>
> root@fex:# grep BALANCE /etc/default/btrfsmaintenance
> BTRFS_BALANCE_MOUNTPOINTS=3D"$BTRFS_ALL"
> BTRFS_BALANCE_PERIOD=3D"weekly"
> BTRFS_BALANCE_DUSAGE=3D"1 5 10 20 30 40 50"
> BTRFS_BALANCE_MUSAGE=3D"1 5 10 20 30"
>
> Should I disable it?

For your use case, RAID1 with unbalanced disk size, there is really no
good way to fix it until we fix the root bug.

You can try to add another disk (preferable 1TiB), then do metadata
balance and most of the problem should be gone (2 + 1 + 1 TiB should
acts no differently compared to 2 + 2 TiB)

It's still preferable to have two disks with the same size for RAID1*
metadata.

Thanks,
Qu

>
> So far I have had no problems.
>
>

