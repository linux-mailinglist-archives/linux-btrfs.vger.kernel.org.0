Return-Path: <linux-btrfs+bounces-6510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828593342D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 00:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04A81F21851
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 22:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B961411E6;
	Tue, 16 Jul 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Rpqhy1pa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939825779
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721168309; cv=none; b=fqKI254KK/VVqSyzhjE47vW6qaagr1RJ9ji00+nsTs31gQcx+0pEPlbxUM/yMyX12VH4Sm1HesZu7AlPqapGXM8tiEjIDWzkhFdrL5pCeR1VGUMWGW1HW2RoHnwzf2vVEmixkdaEX4O4LWzHo2kVeNRp+aUzvERpMp8g4dBzhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721168309; c=relaxed/simple;
	bh=75lvxw3ifZJYFUzU2LZpW4vCGdhqAeq0C9Swory8C68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqzsCTSsLZ4XJf7zkCQ1EZJrcjXNMXBimqbpObPhKBGbuVsazR56P9ff4Pdy7u95ZZw7vxWaPXa6HvEjRu8hItbUfe71x3ldm+cwi6jjTkSpGt2vxUj8eLKtaHiRMvPTWs0/PXsbA176Mugr0tDBnrMYMxDfzYthoUkGy7eCMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Rpqhy1pa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721168302; x=1721773102; i=quwenruo.btrfs@gmx.com;
	bh=75lvxw3ifZJYFUzU2LZpW4vCGdhqAeq0C9Swory8C68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rpqhy1paA2hdsfTCdIcwye7Wt98+gIFmMylavWT/w0gIpqry5JpcDrPXAYQP3awZ
	 yWMhizAVRYuo2tKRAH6eqsMcDLmxoWY4YOa1WuNUgsqgSiqFgwqlhbN6nL8UT3Hdv
	 tQvAV1HFWTsS0BGow/ZwZ0okRXzlhgkzTm6UAKAK6LxRVwXrCoXgKmZqSZwMTSs7m
	 x9437HB20hqXO1aNPbbsWPvfZDXyBoT0ZEfcBuaWMGZ4fNTbb0rNf+LQO8b/BZbwW
	 3SM9WrzsD6KgFTPEZL9eV1Gyd9dwu72BiY1f4fo4Uh1mA2WmfgQFLYPvghBobrShX
	 SV7ylPgMJ2mI8jr7tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1s3Y5f0Axl-00eQNA; Wed, 17
 Jul 2024 00:18:22 +0200
Message-ID: <ac00e986-922c-4b57-b0a4-31e21b928313@gmx.com>
Date: Wed, 17 Jul 2024 07:48:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Kai Krakow <hurikhan77@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com>
 <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
 <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com>
 <CAMthOuMWvFWNEJkOWQiP2eNwWap8H4z7Gb6qzS8M-WkTUk2=Mw@mail.gmail.com>
 <1728bb6e-9dd0-4a2c-be16-41cd01231484@gmx.com>
 <CAMthOuNqaKoJGYWNDdV33hWkG1oa77vuEt0gxxYVbW+KNrtnaw@mail.gmail.com>
 <71256c6e-c584-48e8-bce6-c04aff0d0496@gmx.com>
 <CAMthOuN_wo0AYZw3DNP2NXALrXTt9YArpeXh+0Vza_XLNCxfKg@mail.gmail.com>
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
In-Reply-To: <CAMthOuN_wo0AYZw3DNP2NXALrXTt9YArpeXh+0Vza_XLNCxfKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bGwCQ7ErVkB/BuYq2lB5gtJ3E7Gnd0SoENMfmmKzU754/Lkbhbj
 C0uFMoXhQmV2BvX53rsd9BRAgT4fjgxzGHZ7dbRgSukOs7DFDzKIieUoqD+TG0QMf6/cvkm
 irUx3paN7uQPzjdhqfgtTuy/6snvkFhyp7Bk4VCEM/ENrS2R8xeLbd0XAaB0oaL37RkmKd7
 bk2j4dL2/6V3NHA4qUfOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G4lawzg7RUE=;vff64u7304R7bzLCzGlQqEKYvAC
 9suN5lxDx/znmyP2kDg3p6IhiZg2GJOcCi/dGD8Jk4SY7pUf2mIIkgbQmfqE8HNMBdp/66EAA
 kKFtzKjoXHSV0lnSyKwUqbLXcva1+WXzVIqCzTGnC8q4x4W3zjYB0rdGespqRtfMTtynvv8H6
 Nd9iq77PmrnTIPGsLfgrMEIWScz+Sbe+Y0w6fhCOOPu016+PA+FphHT8qeZvSU5Sqh5O4+0Z3
 OiuMqnQ4Zh5QY91ylRFsAYfvrZrV3lIanrDieHwE4Ij4tX1hkIoaoDCvu+G42ECwQNxO8CMOd
 1rEFb8w5atOmhwUq2IzFQCsqDtgtDhnL7UDAkhNokDtXwxBXyGa5rzUA4wBjAWB+UJGgkLVpI
 /5mb8Gpe4vfH+K6AKUYFylm7fqSRMfDZThFJlj0XIPlUsaRlQOC/T2iySOuc12evT+wYb4kRl
 JRMrscpEmrJpDJqt2+jZyufa7ftLnIKoKYjvkL1RoZEMsoTY/QF4C+Rhd+h8jfg0c7pPMN80z
 tvN6TUaRzMcu/VPy74A6WPkZpFppyUL8Hzp3YNzaB0KzMvcMJ7Vx3CX5D79i83WzB59KzeGUg
 wYfe1yYl//crUrfc7r2Q/kmfYj6CnXhN9AcSAwYwf4O2fgS04ErFgy0JjAVAC17xAdbZSxNB5
 LJuhXTU6iGG+ASJpb0IO9JpV5VwWDfCfSSCnFoD3ov+kRpbzrBDn/kamkXW8OsdLlwMDTYdT3
 m5OXgxaA6OPwqAWyeQ1XQprFJ5JqUSrhYElLRSggoB3gdfa56bjR4a/djIZ/6NHBm12kgWQxr
 djqQItMSQg7W1PbgjJ36cqPw==



=E5=9C=A8 2024/7/16 22:55, Kai Krakow =E5=86=99=E9=81=93:
> Hello Qu!
>
> Am Di., 16. Juli 2024 um 11:09 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx=
.com>:
[...]
>
> Yes, they apply. Thanks. I will be testing this first on two different
> machines before applying to the server.

I doubt if you will hit anything like that again.

Even if there is some hidden cause of memory corruption, it may not hit
extent tree again.

But at least enhanced sanity checks are always a good thing.

>
> Also, I wanted to update you about the VM host environment, I got
> replies from our datacenter operator:
>
> * 2 x Intel Xeon E5-2680 V4, 2.4Ghz 14-Core 35MB 9.8GT 2400Mhz HT&TB
> * 16 x 64 GB, ECC reg. DDR4-2400 LRDIMM
> - this hardware exists twice and VMs can be migrated
>
> The qemu host process of our VM has been up since May, 26th 2024. This
> is when we did a shut down to attach a third btrfs pool disk to the
> system. No VM migration has been done since then, and there probably
> hasn't been a migration before for at least one year. Our operator
> says it has probably never been migrated since it has been taken into
> production. So, a VM migration before May 26th is unlikely but not
> impossible, and there has been no migration since May, 26th.
>
> And some other observations:
>
> Also, while the issue existed, I could mount the FS fine in ro mode
> and copy data (I've did a full borg backup, it only reads changed
> files). But if I mounted rw, it would take anything from 2 min to 30
> min before the kernel complained again, even if the FS was completely
> idle. I cancelled the previous (failed by crashing) balance job before
> doing anything else with the FS.

The problem of that specific corruption is (despite the mysterious
reason), it won't be detected until that offending data extent at
402811572224 got some updates.

And if the updates on that extent doesn't touch the corrupted entry it
will still be fine.

So the corruption can exist for quite some time, until triggered recently.

At least the generation when the data extent is created is not that new,
the latest generation is 3933860, meanwhile the generation of that
extent is 3678544, and considering the indirect ref should always be the
first to be created, I guess the corruption is there for a while.

With the new tree-checker, your scrub routine should be able to catch
any similar existing problems now.

Thanks,
Qu

>
> Not sure if anything matters for your analysis in the afterthought,
> just wanted to update you.
>
>
>> Meanwhile the missing commit looks like a good candidate for stable 6.6
>> branch, I can definitely send it to stable later.
>>
>> Thanks,
>> Qu
>
> Thanks,
> Kai

