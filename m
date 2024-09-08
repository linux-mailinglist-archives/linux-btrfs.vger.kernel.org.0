Return-Path: <linux-btrfs+bounces-7888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62054970A64
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 00:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CF41C20ACB
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8B17A5B7;
	Sun,  8 Sep 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LgOk2MUv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E78139CF2
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Sep 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725833425; cv=none; b=Rm7DfijYSVUghN7Vi19FYM8x1UsOuZnuDy4I6NJxbHBZsEJ7/qaAzXSSiuSV8HZgirGuKX9aIPyR0TfQ/E9Qff/JCeernXpLmkIp4KIdMLbfo2Vop2HrPUO/O0L2tYM2guR3HT5BnlW7fZ5VIyyniBmDG/hvkC8WULaHiDgny7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725833425; c=relaxed/simple;
	bh=9bDGbflbMDblSIHy6alMsVoS8RqjR4YYdoTk+nk5Gs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FS3Rk3totu1fg6xPQbGqoOWR4HK9vzIdNyti6qQBigp8hy0Ynzz4OXVJUB22da7uzXbOkl/PDPVU1JUbPYU7uu4BlsEyJTzeCIOy7wrc0fiRUdzTSLoUUbwa3H/ns1b3Ipr26GzO+0Y1qO4tev34SygZ8UdT3Ce8Mz2FEpdAFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LgOk2MUv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725833417; x=1726438217; i=quwenruo.btrfs@gmx.com;
	bh=MBNftREbxyKIlBkXjurFd/3r82gLo1Cko6HI4JsfEGg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LgOk2MUvEov8NW404y0pRGoRU3wCWP6dhiE6wazuacp8lACgSVaLq782lqQGceJD
	 A/cWZaqLGqwvTO2M736S6lRku9jR4OIWkOR7oM3S1gHUuuh6ARLXKlz10ecebha76
	 RfyCID59PmwVKmbH83gXdSjiBlM8KqbA0nEVDsB+TRS4QqYlyKl51bi0dOlLm9cAc
	 z+Z6TZ6MkmK2mXJuQRB/JRC5sLWbBNcSzYwJXmfJtVvpWvP2f+DcRQIYDvvMRLxTg
	 uh2utVOrEOVP4BqXcAyvKiITQwJ2qH5YMYDQIXt325V2I0Tp4sZ31NU4nq3P/KX1U
	 xXw+/j7ft39K62HIug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1sdYjs3meC-00LDYU; Mon, 09
 Sep 2024 00:10:17 +0200
Message-ID: <d98f3ff7-44f0-4030-9ac6-eaeba231f37b@gmx.com>
Date: Mon, 9 Sep 2024 07:40:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Many I/O errors with btrfs on MicroSD and RPi
To: Mobin Aydinfar <mobin@mobintestserver.ir>, linux-btrfs@vger.kernel.org
References: <6e494a0e-dafe-41b1-8be8-35a3e85bc11e@mobintestserver.ir>
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
In-Reply-To: <6e494a0e-dafe-41b1-8be8-35a3e85bc11e@mobintestserver.ir>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHWG7Bl6aTMmubxSWzifzsjvW46kdFOa6nqDNKv+Lje1F6yyQIp
 ie1UGOFn3jro6GbUrld+qpUC2aAqRY1/fVp9WrvrEuRsXTQqFdpyDHgOv+ORxOWa3dW7pyx
 vN40h5zJehe5DdXY91IYLK2X3TVSBNkIb7pG0VFPFyrDDWoHMR6o8BFul+cq3QXvFuaRps+
 rymmtIr+oFKEHAA86Q2VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bp1cV5m3PkQ=;V3uh55lx8LQKXmhDXghh7p75rZJ
 QXkSs1YXt58AyRgf0WodrL4VhtT/1zBDJsLQi8SFuxpPTPDZnIaLPfFk0VCq0JD9/9vdM6NuP
 aWaupAnOmBi4DqPwGLDUe+0hJvaGOx/xQWr1q6grqh0baMF02sd8EvCXrEnL2JqJ1feHM2rIV
 8WDqpm1PdVSlR/NTWGiWjP6LXZQltd9mrcZMIvlpMOJXSCs41VUh1tbfQPjSTF4viQu6aNkPr
 /PgzRX87+JMxAMqeutVbzmN5xtw1eWxaCcmWgCDQhG37OIMjbjDBgLc/hrt/QH5BhP55ujGDg
 CU8SaURR5uDVh93ab6MoZlkENHRumfC1Wl9g2RBmvg6/BtD0bTaAMjIoOPaRVNpQuBYZtXKcS
 WK/uJD0dn0Z0lO/aPKvOvpbW2bBv2n/1i6LaKTPuA0YlCpmtyNP4QEa3mJBp2eJazyr0sCSRg
 KCx6uHzWy3lMBmHlPLRfau7cK9aagxNCsJAQgzWbzRs1H2Qpfn8QO9t1ttCtN1lPmVMyr0VCJ
 FGDQcuSzac0WkWthbfNRNmi6q4SqSolnEsM4aoAsA5mVjpVMFa5gLMkm5d9HorlzDLKxcE7hS
 uf+T3pnis3Xx7hWUgEAcantEC4Y6nIiRJT60yNQ1ZRzdjugiDFw7LtiEwJHHM4BXQe8Ja400M
 K30HoIsvWPKJfvN6M9CzJDyO1BwNs+Z4KDkLZHYvWN1Nlt8ko2s9Y3Ur6lsxDAVSiZf+TTv1R
 VRSJRM+I/Yca8Lis3vZ21jlrAQZ+EyahUDVdJP7sfJF7nSQCIR98dPWpbnEy4r3odMkCrCkNJ
 D0/OG4wOGk8BUxeqCGlsd9xw==



=E5=9C=A8 2024/9/9 07:00, Mobin Aydinfar =E5=86=99=E9=81=93:
> Hi.
>
> My Raspberry Pi is down because btrfs reports I/O error. So I removed my
> MicroSD from RPi and I mounted it on my computer with ram-reader. btrfs
> check reports many problems.
>
> The documention says don't use btrfs check --repair unless you know what
> are you doing so I didn't use it.

That's the correct way to go.

Unfortunately from the output, it looks quite some of your metadata is
full of garbage now:

  BTRFS warning (device sdc2): tree block 121929728 mirror 1 has bad
bytenr, has 15771731761493389218 want 121929728
  BTRFS warning (device sdc2): tree block 121929728 mirror 2 has bad
bytenr, has 17159496520340310444 want 121929728

The "bytenr" is a u64 representing the logical address, should at least
always be aligned to sector size (4K in most cases).

Furthermore it shows both copy is corrupted, with different corruption.

It looks like the sdcard itself is not reliable thus a big chunk of data
is either discarded or filled with garbage.

So far no transid error, thus at least its FLUSH/FUA command handling
seems sane.

Thanks,
Qu
>
> I mounted the MicroSD and I copied all of its readable content and I
> tried to use "btrfs scrub start" but it got aborted after ~10GiB.
>
> I check RPi's dmesg everyday to ensure there is no under voltage, I'm
> sure that there is no under voltage issue but I had multiple power
> outages in 3 last months.
>
> I don't have dmesg from RPi, but I have dmesg from my computer (See the
> attachment).
>
> btrfs scrub status:
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 4c3054bf-5704-4afe-be0d-d2300359d493
> Scrub resumed:=C2=A0=C2=A0=C2=A0 Mon Sep=C2=A0 9 00:34:28 2024
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abor=
ted
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:11:00
> Total to scrub:=C2=A0=C2=A0 33.99GiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 17.01MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 csum=3D52
>  =C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>  =C2=A0 Uncorrectable:=C2=A0 48
>  =C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>
> My computer uname:
> Linux Mobin-Mehdi-PC 6.10.7-0-generic #1 SMP PREEMPT_DYNAMIC Thu Aug 29
> 16:26:29 UTC 2024 x86_64
>
> btrfs --version:
> btrfs-progs v6.10.1
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=3Dbuiltin
>
> btrfs fi show:
> Label: none=C2=A0 uuid: 4c3054bf-5704-4afe-be0d-d2300359d493
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 1 FS bytes used 33.79GiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 59.02GiB used 39=
.07GiB path /dev/sdc2
>
> btrfs fi df /mnt/Removable:
> Data, single: total=3D35.01GiB, used=3D33.59GiB
> System, DUP: total=3D32.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D2.00GiB, used=3D200.53MiB
> GlobalReserve, single: total=3D54.44MiB, used=3D0.00B
>
> dmesg: As mentioned, Check the attachment.
>
> Best Regards.

