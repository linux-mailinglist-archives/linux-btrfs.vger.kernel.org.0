Return-Path: <linux-btrfs+bounces-5372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A769E8D553E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FD1B23B58
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9D17DE23;
	Thu, 30 May 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bIcQGcHu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10F2B9A6;
	Thu, 30 May 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106707; cv=none; b=SZQpelZVjcwDQb1hhpShXsGjv/9j4DvlxWuaQVKo8Sp+SzrVZCzYGWEtBP6/lY5weaVliMgdarK5+E5krOOW2CjirYCGGNjdtLYrlIDyGCP7EE526cE59JMvsC28fmds+yCqTzavwcDmPDlGo23FzOELtsb9Zy0cwpF6A2HwKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106707; c=relaxed/simple;
	bh=04KMvnpqWE3XNjO/wyuBQldJJ5eKVGeMvKJMhMprRWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNxOya9SwfP4a9L6CpGn1W3TrksEo9Pk6/RQRhJvKKlnCI65t3yg12o+mOXzlri59O7xM/qTku7Aw2wuEIT90BDZEjL3Cli+OSA65iob1NZkPtOxBEvhI/NQDRyHH8MEw1wmh218jJeI1ES3bnX8czNSdMbCwB12183vZjzScSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bIcQGcHu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717106697; x=1717711497; i=quwenruo.btrfs@gmx.com;
	bh=Rj8Zo613kMLOf6p8t7ekOTUoczYBfy9ryjlgEkEyo0Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bIcQGcHuiaES7Z6PAyX1TmRbuzeTrGK7a1LHwhvTFhvHyVMfpQ1dHO1G8LWnKEXX
	 B08jEwKlSI02YbLZhSHfjw8bdsAEV5x/BPmLF2UFjVi06K1NDK7O9U7gl38rgJJ9F
	 +xEWaYmGYB8Mec5D3Pr+56zqYKGEYKk4ZVgG0ntyEkFCiNomd3ZRdw/Yudbrwr4Sd
	 APWUEOBXLcAX9knqrnnNhVgPjwBbzEFj6vTYXBBSv9Qpc4QnA7sQFx+XnxU8SVGk+
	 U/ipYhUvy6x2LJTBVLCU1rbe4M4qnF8cCn/+Nwyh1hfCC9CjQ25lPzCmShdm0fedj
	 myCQqT3ItbCbAj5xtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My36T-1sPVKB2Fyh-00wA7b; Fri, 31
 May 2024 00:04:57 +0200
Message-ID: <76911b13-e26b-44d0-bace-ff4c13e96b5b@gmx.com>
Date: Fri, 31 May 2024 07:34:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: kernel NULL pointer dereference, address: 000000000000002c -
 RIP: 0010:alloc_extent_buffer
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 Linux btrfs <linux-btrfs@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
References: <CA+G9fYvJjAqf1pxMZpsm6rO_UVqhKOpB=0SUpBec8UhQBOXSrA@mail.gmail.com>
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
In-Reply-To: <CA+G9fYvJjAqf1pxMZpsm6rO_UVqhKOpB=0SUpBec8UhQBOXSrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1tZQ7V1MYLYvcZuA1GUDuuKMAj1kTGsVoMQ4oZki6llKE/W2ypw
 zhj7jIOG2oKV2kMHrQ9JKp8Qzpz+RpEIpNXZTDoohxJCi70r4P23rWJYf5j7RN6joFubevi
 EtvzSZZBrBMKN79kpcdAVSLKC3Xw3BuVv81tpWJu73we6vEaQzDYuqx2gBcEdBXbGAxb5r6
 vFPYFNPTE+OV5u0TS/Oew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W15UJ07y8Tk=;EKsBkmUWtVwMBDei7ahi21x+4uP
 lCAhybJVGf5Q0iG6PZhOdfNqWNerDjXJybh6Lx8hc4ZV2kFgyIi5SapPHQxRAUNmyHEL9C3lV
 li/RX7zNO9G7lQohckrrMBDrV+GmhEDSy3uSSK7oN/CdjQiSCmHep2wi9OKFPoZIxWCWwxedJ
 gTAMGqVbZd3mLSctnsLDB6pCf81Wi3JNHZkXilBTgGV+EL+ICOoui/UmCTRl/St3yDr+KLsoH
 4pn9riluzfP8V8hBaDeqfU3azn17cvqlZtgSobmZozQ7tSq8d8bwvN48f257Yntc9HDs4YkxG
 XS+RNQq9QFF4HyG2mCktFt3x9iw2tp4+W13hqrq6jzOPHv4T2orH86ICyAILkEyX/JRHFsYML
 kDp0xMk6g1OfOJjV85Dp8czx0/oI+V87yBy1isQV8vV9kFI52VOHL5WYBLQLMSnymVxUpiCot
 WiIepYqTl4m7+UQHASwsY6Y1Ob07tgFJX6Viihz030G+T5XjBeHr7jEGmVpJpWqvv710a+bbn
 Y0z/HQVu3btAW6bmV0BN/W7XyIExvVU0aq/KhzbkAEjb60KsDtRe+0AOa7Au/AVSKsvsBa6TX
 5jEDgbUvLcm400gFah5IgiTUi6JMn0tss8Cg17WPITUHghyjML0GYLJlowMzug/LTWjQddGJf
 lAw9otF3OkqwByGFKshBFlAhYgF2l0do/TgfLGNQF+ZnR/PoUoKziCS9cnDAmjxPKlGyzp9sJ
 WNHTpZMWJLOKRo3ZmZFlkKK2nL0GgFZE4eLC/dw3NV9YV14lH4E4wodMBJcXdeG5KvraxE025
 PGUfcqJ730/Vxlu6rAn0LEnSSpCpZyM/sZTcuYriX2Iy4=



=E5=9C=A8 2024/5/30 23:26, Naresh Kamboju =E5=86=99=E9=81=93:
> The following kernel BUG: and kernel crash noticed while running xfstest=
s btfs
> filesystem testing on qemu-x86_64 with loop back.
>
> Steps to reproduce link provided.
>
> Test details:
> ----
>    Tests:  xfstests-btrfs  btrfs/232
>    SKIP_INSTALL=3D'true'
>    TEST_DEV=3D'/dev/loop0'
>    SCRATCH_DEV=3D'/dev/loop1'
>    TEST_DIR=3D'/mnt/test'
>    SCRATCH_DIR=3D'/mnt/scratch'
>    FILESYSTEM=3D'btrfs'
>    T_SIZE=3D'5G'
>    S_SIZE=3D'8G'

That's a pretty common setup, and unable to reproduce it here.

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Test log:
> -------
>   <12>[ 6457.571628] run fstests btrfs/232 at 2024-05-29 16:31:29
>
> <6>[ 6464.685165] BTRFS: device fsid
> 50147eec-0761-4d75-8e77-df9c50ac385e devid 1 transid 6 /dev/loop1
> (7:1) scanned by mount (152729)
> <6>[ 6464.715051] BTRFS info (device loop1): first mount of filesystem
> 50147eec-0761-4d75-8e77-df9c50ac385e
> <6>[ 6464.719266] BTRFS info (device loop1): using crc32c
> (crc32c-generic) checksum algorithm
> <6>[ 6464.724996] BTRFS info (device loop1): using free-space-tree
> <6>[ 6464.789867] BTRFS info (device loop1): checking UUID tree
> <6>[ 6499.694309] BTRFS info (device loop1): qgroup scan completed
> (inconsistency flag cleared)
> <6>[ 6499.766172] BTRFS info (device loop1): qgroup scan completed
> (inconsistency flag cleared)
> <1>[ 6572.421678] BUG: kernel NULL pointer dereference, address:
> 000000000000002c
> <1>[ 6572.423036] #PF: supervisor read access in kernel mode
> <1>[ 6572.423070] #PF: error_code(0x0000) - not-present page
> <6>[ 6572.423143] PGD 0 P4D 0
> <4>[ 6572.424555] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> <4>[ 6572.424814] CPU: 0 PID: 152772 Comm: fsstress Not tainted
> 6.10.0-rc1-next-20240529 #1
> <4>[ 6572.424946] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> <4>[ 6572.425062] RIP: 0010:alloc_extent_buffer+0x253/0x820

Any line number and code context for it?

It may be a clue for the recent bug of various bad page status.

Thanks,
Qu
> --
> Linaro LKFT
> https://lkft.linaro.org
>

