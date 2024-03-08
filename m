Return-Path: <linux-btrfs+bounces-3135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE8876C3A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 22:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3642281535
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3BB17745;
	Fri,  8 Mar 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RydWUsC7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D05B20C
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931756; cv=none; b=nHsj8wJ1/bQt+rAjVWX5fLUvV3FMa1s/vwzPKm5s6lls9roStbQT/6vtEvXuZ2izZthBvK3w7Wlga4eFE/6OyI/0ArJtuVf9G93erGBdgQoM+OC80w1j6NSfOf6g21QsUH0v/jChIHSpLW62m5xog+ajnU9RWI/dRTd5sjlsT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931756; c=relaxed/simple;
	bh=uBo6sozDcH7heyuPigVLX7YZuPh3Y0p9PS8rPYiSi8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aOzOv8pXF9IEHcHizBC6CdxtGe/GsPfRMBPq6e+whIhxgPPqxifcB+L/H7jVAN6ZRCVkcQAuAXkyfIrjZqwF5kuIemNT4I1FOV+V4SGCnbSzSxexd/ooq1spiJ15kijy0Hni3c1jpZBP/wvp8m9aKABspWXmcgPu3/Ps9YII1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RydWUsC7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709931749; x=1710536549; i=quwenruo.btrfs@gmx.com;
	bh=uBo6sozDcH7heyuPigVLX7YZuPh3Y0p9PS8rPYiSi8Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=RydWUsC7IbDgY3bDKLYAA5hadp/yPLklQfhY8f5LWLcNTUsMxqv9cSKT+DT/YTQR
	 01XqdkvsLTt+zacfYsCFV1XiRrQEMPZaKaO3zLQFPp+RKdO7mLU6tTRtpTWXcmCgf
	 WXkAEk+mdpH87LdPxs14uR4VHkKt015XKeOsNufRb8a3KKorWUiZeYY457i0ceYNj
	 giYUGFGTSPGPvyBhD2iaNUi9msUISjCCbiguSzn0PAIsux+To1C2jOb8peONbsScQ
	 5leVUsjD1Nz3cA9naHp5qexpk1ODTk5gdCm9lqvNde0R69JnejkiyJJyT9NPfRY70
	 C4ySDPCtvRl8nDfOsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGeB-1rHNIc1Dc3-00RIq0; Fri, 08
 Mar 2024 22:02:29 +0100
Message-ID: <5b35783e-941e-4f1e-9c55-84fd319e6322@gmx.com>
Date: Sat, 9 Mar 2024 07:32:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: raid1 root device with efi
Content-Language: en-US
To: Matt Zagrabelny <mzagrabe@d.umn.edu>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
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
In-Reply-To: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LU66TnTvDKGDybWxas1FGiRi1s0UbrtoSWWTUwwqg3tnvEWRFBZ
 79dK7sN+SGCHDAmVaMTzmRW1+4FFquTAb+I601Iodrx/VoRG7oSBqfF8Z/p4APNF/wuloTI
 qk8NVfuk8IkxIZqG50DWU7170/y3fk4VzMif2CZ0chgnfIPlevnPfxFBYrK7gsrRqVKhlbQ
 k4Uq84Do2dIpRyj8G9wnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qvhIlUrXm04=;ZyY2rbu/tk8y/csFOQ9jDGbbKp/
 qfaC44B0r77ILu923K3fAR73ncLM7QNYd0PqY/9SMMsYoI0pPRnNAhz5I2UupfHGn0O7NXkug
 XyHIBBDT/uBtrRWZ0pTc6vYaUXapVPf1jkw4kWN/CuKiH3Pa69Bk4vAPvWWCw5hq0j1HdWP+f
 iKA0F7iUA4XHivx0HaJqO+5wkAuuBzf5ZRKJh0ViOlSLfrG1wUfu/bDMsm5LTjHoXvmGFXL3f
 CIjL54/1ayh2KOfniEuEnUErlKdMyvKwVJYngfQhokaXRccjYmy6cDb3HaU3NrlpMczUFKP+x
 gUW12kYroOOydi3t97TsMOpgxWveY079rnrT3bK1kYl0nZovo9vc8qBZaVSaF+iS+qqznGWkh
 mp1H+FL0otcAhEV5/PS6fHoo/ZBNyhnjABDKxg38/ezLj991F6qq9ZMULWtexsQ/6TnfcX4Uh
 YK9jfbtwop/rljrmJCsJJjSrND9SDB0+M2jmnpLRHXVCxed1M2C/6qGCXncaSC0KIlNRKZ8Ue
 DStiylwx9u+jvhoelZc1cL4RNL9POa3RVVxxTL/L05DFqWOV+3Nyhd7OYcbI8my3NJZjTHSnm
 2442+JtS2lqZipIdgBHjnVv5PYOi4PvU0pTeMyeVr9Txrl/67BvYyHMQtFMVLnr44jDGvwiQp
 21gURSpkEFYzJF3YmkN/24xVOhsmn+U7Tg5LmMC4V7ws15sUAhOXVJBxkTsRRUniU6R+EUzWb
 uEceC4nGT9std1owEpi6kqIKQ4NXnwh9GJlfewmI9I0AP/JuezDvTl3G46xLTUAogLvD06waa
 fHB9PgfmBxzRQmuPFXc+o+qtqpnBWHQxHefm60K0CbaUw=



=E5=9C=A8 2024/3/9 07:09, Matt Zagrabelny =E5=86=99=E9=81=93:
> Greetings,
>
> I've read some conflicting info online about the best way to have a
> raid1 btrfs root device.
>
> I've got two disks, with identical partitioning and I tried the
> following scenario (call it scenario 1):
>
> partition 1: EFI
> partition 2: btrfs RAID1 (/)

This really depends on how you want to setup your bootloader.

In my case, I hate GRUB2 so much that I always go with:

- Partition 1: EFI (also as /boot)
   This includes both the EFI bootloader (systemd-boot), along with
   kernel and its initramfs.

   The disadvantage is, if you go LUKS, your kernel/initramfs will never
   be encrypted, thus exporting some risks (e.g. some attacker with
   physical access to your system can implant some rootkit into your
   initramfs and steal your credential)

- Partition 2: Whatever you want
   It can be btrfs RAID*, or even other fs over LUKS over LVM etc.


>
> There are some docs that claim that the above is possible and others
> that say you need the following scenario, call it scenario 2:
>
> partition 1: EFI
> partition 2: MD RAID1 (/boot)
> partition 3: btrfs RAID1 (/)

At least OpenSUSE TumbleWeed doesn't need a dedicated /boot, and it is
using GRUB2.

So I don't think a dedicated /boot is mandatory.

Thanks,
Qu

>
> What do folks think? Is the first scenario setup possible? or is the
> second setup the preferred way to achieve a btrfs RAID1 root
> filesystem?
>
> The reason I ask is that I followed a guide (for scenario 1) and
> rebooted the computer after each step to verify that things worked.
> After I finished the whole guide, I unplugged one of the disks (with
> the system off) and the BIOS could no longer find the disk. I then
> plugged the disk back in and the BIOS could still not find the disk,
> so something is amiss.
>
> Thanks for any commentary and help!
>
> -m
>

