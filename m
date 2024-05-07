Return-Path: <linux-btrfs+bounces-4820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC18BEE5A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FDF28675A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7558AB8;
	Tue,  7 May 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sIHXkkpl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785757319
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114697; cv=none; b=hrHKBNoupToxBn68lEJjmzgdQtCcC7kHsm+8Zs8irEtd9vDqB/W8942wUnv7YX5/QzFT9s+XTDXWz4x3ocWZg8moy9xA3y8K6l0sZTUyT6JaGK8s3oZiyb4C8ElQ8UUa4BeD48F8MgHe8hJnzdWFXDUZ8OwafPUy1xGyGR1Ab9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114697; c=relaxed/simple;
	bh=JbP+x2CZ/Ly40KJ8tOxxL9a5hrtjK3TH3XxMvS7na70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fscSfOAwZ0FHJT/FGWVCqTzJ95ZmHlyAksWpyZDp4OQ+25NAFm58Fu3tUK+jIl2DuFSKp5NBtwROLODaRamLJ89l/DqtBM7v0HWuhg3H0vepo7dzZ2nPXYtn4qF0AUi53u+ElevAmeSuWJwVcMbvCKGwTsqafQiZ/Flwmm7/riU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sIHXkkpl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715114692; x=1715719492; i=quwenruo.btrfs@gmx.com;
	bh=yT01rthnW9XEL+Ip3kKgyouN7h906r/gRjlGirnQKCc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sIHXkkplTWJHujCp15FDgKknFV0kPcOd7s3kxnc8Ln3ekSio/LpcHoXH9GY/7CUl
	 N23y+M0gWlfKlKjgip92tkKjPjn5EBa86q1VtcqQ463bWFNGZiWax0eTbsS7cF4/8
	 7Q1Bh29JWIyvOPc1dpQjuMqJhB3pkUj2FChrWEc0/DyWDdYipSkG3tmCLGHv/2tyx
	 vVPxPXcLqyjbV/tbrGy0mEDFGbU5fxuRJvkDGcfZDefn3NXDUCBu14aW/WPiKSvBy
	 aQWwg6QGXGfLC/u5x2vHZ+bhgV1fGhismrsMYvYzXhTn+L/ep5M0uvEsqH+v2DMEH
	 mTLjkCgwXb9wlRYdSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKZ3-1sKkXs2wYx-00JwNC; Tue, 07
 May 2024 22:44:52 +0200
Message-ID: <9e7c4d26-81d7-4c11-b63d-33cd43b96bd6@gmx.com>
Date: Wed, 8 May 2024 06:14:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available RAM
 - rev2
To: O'Brien Dave <odaiwai@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <65E2F681-67F5-4AC2-823B-3C6CBE22E891@gmail.com>
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
In-Reply-To: <65E2F681-67F5-4AC2-823B-3C6CBE22E891@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Q54WJn0oFSji6aXMqn0MoAVx/9IWysDmM46uww5/JM1Zv4+TlZ
 7ksSv6ak+54bISxp4aXZReCfYBbRSCr/Atj/akkZ7+O23/AVHK8MDHhbL9UNEt5ATS+sWJW
 EpBAkdp6A3gheUz4SM8l4n3EdwhNm8z7a4P847vGClKWeYaS0UQOCTFyZFEo8vybblhsBnt
 q2ijc2RG+0GExgVvHEK6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mffM7xfo674=;6nKGzQPmWiS28QBlYb+EFkIcfRa
 lmgNevBwwlRjYRpiddRWODJVYUH5h5Rt9Nj9YUiAupZ+DQ5EThCHN+MVQwbg7vZO1MrasbwKU
 8AJAggl/DrkUTEyVNJoUV6BtyKnna2ObRmXtqipTgnywKGif3UO+2uLbOfOFk0aIPNuuufBM+
 KHZMGhV1MLKjTf4RuPsHRAWM4hile+d0MZUMB4XwZoOjW7ieartkxlPNoRhda8yBLPA0ZlHXD
 WOgb19UDNVwGsKYBwRU5g7FtDhxidGKgQ/PzRUtmO9yqt1IcaHX/AtD8v8ItqyqUrSFGcK1pK
 AwLNTDnhmPQgoRH6jcM4t6rKUghCi1MSYVs8wrCnWUBTi9mYuMlJM2FSeG4T7lgNYbuVTze6R
 i/BS5h7WFsAy9J2o1CWkoE8JjnOo4m4HfHS/ojVo2+KjbV/8ktubQDg+qJDSDLhyKFIjOlthD
 wpDTafB42tb7k+/ofPcR4SRe11L6zACc2gwNeqqXaJ+uqhd5rjfeay/AuBBu2vBuMgeZHihpt
 Ww15ZQf4RkgwXIiqMNg9JbVb8Mqe9ZaNzBuPUY6CPFnbN5JjNp3ywG40mWYjIA1ur+JEW/HaR
 KuwMkv1KiUz7F/auuCrhbb9P3oxUWzLf91InMGrlSY3QWnrTbAy7Wc+Q1kQDvbeBz7644k6Fm
 2RzPv+iR50IW3rk1SwlnVg4zC85Tj24fvJlI77y+3mtTLSUnZyXoLTdY9Q852TuyN+rWqGFfI
 nGtBdql2+tBMVFC/PuiM5YwHyiHRRST2u05tBRJdkNsj4/3o0c+VhQNynn0jHNV+px5pVmFjW
 XwkE7otO40zilbhcgBZAZbdkUgWzvrzlGZ7qZ03L4TqA8=



=E5=9C=A8 2024/5/7 23:13, O'Brien Dave =E5=86=99=E9=81=93:
>> So the only way to get rid of the situation is using the newer sysfs
>> interface "/sys/fs/btrfs/<uuid>/qgroups/drop_subtree_treshold=E2=80=9D.
>>
>> Some lower value like 2 or 3 would be good enough to address the
>> situation, which would automatically change qgroup to inconsistent if a
>> larger enough subtree is dropped.
>
> Setting the threshold to 2 or 3 didn't work - the machine ran until OOM =
failure in both cases - but what did work was setting it to 1 or 0. (I=E2=
=80=99m not sure which fixed it, as I set it to 1, then 0, there was a flu=
rry of disk activity and the qgroups were immediately marked as inconsiste=
nt.)
>
> So, after rebooting into single user mode with /home in ro:
>
> $ vim /etc/fstab # to change /home back to the defaults
> $ mount /home

I guess there is some timing problem involved.

Normally a subtree with level 2 or 3 isn't that large (hundreds
extents), and should not cause a huge problem.

But it's possible that some huge subtree is already queued for scan,
thus at the time of setting drop_subtree_threshold, it's too late.

So I'd recommend to mount it RO first, setting the value, then remount
it to RW, so that none of the huge subtree would be queued before
setting the value.

Anyway glad to help, and I really believe we need a way to set the
option in a more persistent way, so that we can avoid such inconvenience
for all.

Thanks,
Qu

> $ echo "0" >/sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold
> $ cat/sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold  # to check
> $ btrfs qgroup show -pcre /home
> $ btrfs quota disable /home
>
> Thanks for your help!

