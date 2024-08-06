Return-Path: <linux-btrfs+bounces-6997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD69948C70
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C151C23020
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEE1BDAB5;
	Tue,  6 Aug 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FtMXzbFx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7D1BDAA3
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938131; cv=none; b=kHOqTssSouiDuoebmYkD+E/c5yOuySAmr+tKOuPJgnIeXS9Bq0qhRvLsZIjV9VAANjL3Yt4/M1Ttdz0djFq7w84qXYwQJ7kTYJK0CgJDhx7TojUWMF+D2rD0wQEGMCcomJ5uKoNLq7KT+4BZNUw7pkfvwP/C5V0jdSPwZri32Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938131; c=relaxed/simple;
	bh=gfMkNMzLN5jVv1SVWOHZtubEWaE/SWe+gJpWrmtx8ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZtgleytZuo9rMLYRU2i+iZt6WZfLFl706em0b9tQX5q0Jmys/B3GoB+/xd4jjz3bJG4nGiqZS902Tuzt++KWVsDtV2Ghj2UhvhG45ImlsHGEmnrTr2qfvCmo0jMf5BI+7gIiYKo5Mz+nMHX0X1Jm1sWPonUO94xOz7Y9IE1FL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FtMXzbFx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722938125; x=1723542925; i=quwenruo.btrfs@gmx.com;
	bh=VKQqiX0cLtt0EUefRiBu2LxFaIugwt4zWJH/bn03XDE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FtMXzbFxB5CVVVOThgNfS9t+ytAeTDakLcf5VJgAnfuKEbXzl75hNLV4s/MV3Vst
	 kNxi3pOYSR+9pwf+1jXISiJsYtCf6wKivxEwZ4YaIMPiwH6nwqWMo3KDbikPF9I1E
	 UXO+o1qwvvDA+ypAij9wCmyB6FELLloWWwKBudZKXzGa2bhFC6QYRQ2k7px5lhAmA
	 x0E8utu7QGtu1LUxFXvQqdA+oW9lO6AW2a3vGYshy1KKHJHViU8BM5ij7pDZa41Tb
	 iFQ8jRAMshEtATt8p7t+escaBg/Ozr/zzFoSxz5GyLSZO7vcWDyRY4hyDaZJ1MjQT
	 vIIccJgHJoY8V3o9jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1sbXlG0Jyl-007n0L; Tue, 06
 Aug 2024 11:55:25 +0200
Message-ID: <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
Date: Tue, 6 Aug 2024 19:25:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
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
In-Reply-To: <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kwYKT5I0VpsK++nyv6KOrqeAf1Bu7BALs1NLDCfYbzHOeFVSmWp
 WZjyle0lpva+COwBitQPNwm7AepikMedn820aPmTn9WQtNZ+C4M1x5yM6s9DCd0Kj++g60f
 9Sz0V/eeV75/7EoczAF3uyhFq9ozJosV0LYVeY1f8qFKf+2i2qNdRBHfEn5guZ7LMUlDKli
 WylUBKR08LmtwI33PVi+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f5ffwdNcgNc=;32q4scXGW3M+plPTrYPXf5AtH1c
 MSivu3lk6aOerCqdYnLawWe/U0RzaxW97Pjb6MRmE+d4Rt7zQWARkW92Pz383caKpf0NuGeZ0
 Iha35iJVzEcndHWRIspGkf+zsIml+BLCL7uK89o9/OZC2UNXC1VrBzDcDgLWmAvOM2ZAjR7db
 h/z3EPbeYQAzHgnUb2cNYQfE3dXf5plOVkwbJzndJDFCpNkcdnRqvT5ZHNZsagbcYYRMSIRm+
 GpO5vY/g0SMbXp31b4YalSYv6vpDu4dXHj97JyCeWRHVijEJwbjQ7FzEnUvNfQInUb0rb77eV
 5yC4uQBaYAVjjYcXrEaLjZypA1AG1hRWzvCr27OXXfHQUoBKP0bc/plJjP6yjGZTU7cceFdcd
 jiiqFxMq8mxUW3ifKUk80MZIjyL+5atGw8xoOuf/qPnKsEfFsaTS4sS7R8g7FQ40dvI2Wf98c
 05FH5QTjTo+K4k4r91t6dOXFtzvQz609oUWGaXbu3BYa0GqRbXS8n93GTEn6a4BZzcfzhAecE
 92AngWnm7VPIUBdE4h6QDe+XBmE1cHz10lGhobNsRo5u99EdhKf3k/jY2vy5aAelfj3rP4/bU
 7Z4TRbZmSeK+nY1wQH3zArNEYib8A1N4cMLn5yrC5Jt722iq5KkYVaa7M/kV7eMXsd6SlDZag
 gzsNHdstoWjW09e3UI7+Onn/vyGoCc5Zgvp9GIjbukHYBap/C5LNjLR+vtb9x09tJlqOi8P7d
 YINJ/e9OapKs+WKn7sovegr7sJE4kltkKlPaK+/3I16OrAVQWWLygAn9ebGih7AcaqGkiBNOa
 tG/iUieFIVR1bYb5uMvdA1XA==



=E5=9C=A8 2024/8/6 16:49, Hanabishi =E5=86=99=E9=81=93:
> On 8/5/24 22:47, Qu Wenruo wrote:
>
>> It's recommended to go the default values anyway.
>
> It's for testing purposes. As you can see in original message, it
> happens regardless.
> I simply noticed that increasing the threshold makes the problem worse.
>
>> Mind to provide the kernel version?
>
> Originally reported at 6.10-rc7. Current tests with 6.11-rc1 and
> 6.11-rc2. Still the same results.
>
>> Is there any memory pressure or the fs itself is fragmented?
>
> No. I tested it on multiple machines with lots of free RAM, also tested
> with like 99% empty disks.
>
> Could you please try it yourself? It is fairly easy to follow the steps.
> I use 'rsync --preallocate' to copy the files over (and maybe call
> 'sync' after to be sure).
> Then run defragment on them and see if the problem reproduces.
>

The problem is, I can not reproduce the problem here.
Or I'm already submitting patch to fix it.

# xfs_io  -c "fiemap -v"
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE       TOTAL FLAGS
    0: [0..460303]:     583680..1043983  460304   0x1

# btrfs fi defrag /mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
# sync

# xfs_io  -c "fiemap -v"
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE       TOTAL FLAGS
    0: [0..460303]:     583680..1043983  460304   0x1

In fact, with your initial fiemap layout, btrfs won't even try to defrag
it, due to the extent size is already larger than the default threshold.

I also tried "rsync --preallocate" as request, the same:

# rsync --preallocate
/home/adam/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst  /mnt/btrfs/

# xfs_io  -c "fiemap -v"
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE       TOTAL FLAGS
    0: [0..460303]:     1043984..1504287 460304   0x1

# btrfs fi defrag /mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
# sync
# xfs_io  -c "fiemap -v"
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
/mnt/btrfs/mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE       TOTAL FLAGS
    0: [0..460303]:     1043984..1504287 460304   0x1

The same, btrfs detects the extent is large enough and refuse to do
defrag. (Although tried "-t 1G" for defrag, no difference)

That's why I'm asking you all the information, because:

- The kernel code should skip large enough extents
   At least if using the default parameter.

- Even for preallocated cases, as long as the file occupy
   the whole length, it's no different.

- Even btrfs chose to do defrag, and you have no memory pressure
   there should be new continuous data extents.
   Not the smaller ones you shown.

So either there is something like cgroup involved (which can limits the
dirty page cache and trigger write backs), or some other weird
behavior/bugs.

Thanks,
Qu

