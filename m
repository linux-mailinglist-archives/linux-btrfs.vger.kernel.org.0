Return-Path: <linux-btrfs+bounces-7034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D694B2A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B2B2814C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089B146599;
	Wed,  7 Aug 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WosVmCMx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6794D5BD
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068129; cv=none; b=ZaMjRYaLQ6iOTk74AUaBNmg2CabCp77ryc6sakah5X90bct/v728fHOUoEcX15cMYu4a7YVeq6Wpv1BbGMQOY3XDhsloBdnyXubl5JjZfeVv4fROUV6RyksaNp/AcNNO3pCFwFI/g+y17bQwcfgQE5U8CXPCfcYtM1GG7yqxmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068129; c=relaxed/simple;
	bh=+r0YJh1edFxeHw428wO2HoM2k2cUjTIbDj6uti0lRp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaUKebRfmOXzzsWfL5aI6Hlf8Hn1W+qM8xhph3p0Bzxwb5KddOVd3Z5sVGbD0+nsISrlgt/jBvYtXABoMvG1su2OkfIq/fEDV5pQyg3DU2UYz33B5FS4mT05vt0ILTLiwUURWVn+H4BRR15bETQwXrLcaBE02kwERTqFU1/xrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WosVmCMx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723068123; x=1723672923; i=quwenruo.btrfs@gmx.com;
	bh=jeQ98Y49IbUR4hsSlc5nsu1+LbzNp2cvo8cpuQ17GZs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WosVmCMxl8pUpEimElKzMsPkZP3USkf7z0sWhvdlGoIMG72drM8+aQ0vdWptJfZo
	 QtRPykCqGwBrKksLJcv+PMAxoNlDYpjMDQC0NyGEt2HPIQAnqkg/Q7nFsCrXfCXXJ
	 FwBsyx+yp+gpyuQQtH0+LJZiWFhnJ52mWkEl8snTqRG+lPEfqOwyDPITWX9E8Om8V
	 RO/OUY00XYcXJu9cvD1pWC2PhMDCuAsYQX4+yoWHLbrST86b1HNDrsCIhXtBV4kPi
	 UbfNpQ1EIfuO6/vTqVUzluTJ9Cb1sa/DTgm06d9dEIj87yToT9FZ5wkHflIQtOfml
	 DWcRDv1eIrsInBr9gA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1sIupS3Ndc-00xK6q; Thu, 08
 Aug 2024 00:02:03 +0200
Message-ID: <a7dc892a-5b71-4bb7-8709-3765c91debc0@gmx.com>
Date: Thu, 8 Aug 2024 07:31:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: refactor __extent_writepage_io() to do
 sector-by-sector submission
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <9102c028537fbc1d94c4b092dd4a9940661bc58b.1723020573.git.wqu@suse.com>
 <20240807141805.GB242945@perftesting>
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
In-Reply-To: <20240807141805.GB242945@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHPtypOiUymF27l5CHowz7PzlFoAtxow4DQX9e+7+dybqRKujaP
 GTE0CCeQwJWl5WxReeH2SOxPM8tX9jIGLNm4uUyfQ7o+Y7o3vDQ3TuRnqCRUNtMHpueLQce
 L2mU/3I0oH+uTnzZYgL4u14m4g7W87PgC5tEh4DSPsQW8tBmsBycXOzKWCszeqUP0vXHWGF
 xM8QYqzZDkm06FC+afFFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rSohcp46fqo=;wbsLfG//wLkRwCj7o+w7WSAArJW
 5LaS93S8nmSfPca6n4vnQMhqfpRymq9aaorvvBS6VNjQw8MaW4mEgzziE+hwS7ykK8Kyt9hrM
 uIcaH3BT6Tq6ZR229r6MDDHes0PSqH/NAg54cec+lKqow90r06EqDyfY0sxo/vWfEl4trJhZp
 OugRT3NIHc7nGKPtvNULsXo6t/FA7VM3Ju5rKRFUpJ64rlSUL9UQyxMjwFGp+jpe2mIfmhIST
 /6Mj1P8f+cdTRFri5M/gokxf8+imWKV/Kz4cL5U26nc4EgBIESciw5IM4a9W3Rti+kCObEiyc
 wIYXIKtqrBdm/s/GYKKbf/uKJegIdQd742RfA7c83Tu5TC2oNvNQDND0hTRH6isK1u9YXMWOb
 cJIWzWEA5rqrvUnkT9n6M+LYSKghumkrTFY0G4yfTPW/u1YFjc6diKXiRFVu9d+xcDi04dbTM
 a1JNbp2pSG3p31VxnKHaUQpE8quVLb5sV624Gjh/EPfe00KyDmCOBefFwAIcsUDLkWKvoVQsq
 7wAHCXcEPBXj3dbV7wTrfD3/BkjYN3i5kwOCZEyK9Lgammitj2S44JEUp7JdMDvU4nTd5mS7Z
 X/fT9axlPiztnGP222e3TFI84EZaAO3ZO+o5eYFObR+zp/aRU9MtjgsGuXv4WF4DrZOB+xhju
 Tkr4uyRn6acmsJ3uI2e4hNrWfxMe9CNBtMGGEVxugTKbyYx8S6NzrsiGQVp7UjXWdKZJ7ZhqY
 07dl2Gv1iutHKviNqSdEAyZ/2WoLAYHK0Yd7jEmfXuGADAD/2MAxHg8mhr0c2NRSNfFo9JzJf
 cgp2PuSrJvh30ZYBeazMoKng==



=E5=9C=A8 2024/8/7 23:48, Josef Bacik =E5=86=99=E9=81=93:
> On Wed, Aug 07, 2024 at 06:21:00PM +0930, Qu Wenruo wrote:
>> Unlike the bitmap usage inside raid56, for __extent_writepage_io() we
>> handle the subpage submission not sector-by-sector, but for each dirty
>> range we found.
>>
>> This is not a big deal normally, as normally the subpage complex code i=
s
>> already mostly optimized out.
>>
>> For the sake of consistency and for the future of subpage sector-perfec=
t
>> compression support, this patch does:
>>
>> - Extract the sector submission code into submit_one_sector()
>>
>> - Add the needed code to extract the dirty bitmap for subpage case
>>
>> - Use bitmap_and() to calculate the target sectors we need to submit
>>
>> For x86_64, the dirty bitmap will be fixed to 1, with the length of 1,
>> so we're still doing the same workload per sector.
>>
>> For larger page sizes, the overhead will be a little larger, as previou=
s
>> we only need to do one extent_map lookup per-dirty-range, but now it
>> will be one extent_map lookup per-sector.
>
> I'd like this to be a followup, because even in the normal page case (or=
 hell
> the subpage case) we shouldn't have to look up the extent map over and o=
ver
> again, it could span a much larger area.

Yep, that's also something I want to improve.

My guess is, using a cached extent_map can improve the situation?

But that will be another patch, purely for performance improvement.

[...]
>>
>> +	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
>> +		ASSERT(fs_info->subpage_info);
>> +		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &dirty_bitmap);
>> +		bitmap_size =3D fs_info->subpage_info->bitmap_nr_bits;
>> +	}
>> +	for (cur =3D start; cur < start + len; cur +=3D fs_info->sectorsize)
>> +		set_bit((cur - start) >> fs_info->sectorsize_bits, &range_bitmap);
>> +	bitmap_and(&dirty_bitmap, &dirty_bitmap, &range_bitmap, bitmap_size);
>
> I'd rather move this completely under the btrfs_is_subpage() case, we do=
n't need
> to do this where sectorsize =3D=3D page size.

This has a tiny problem, that page dirty and subpage dirty is not in sync.

For sectorsize =3D=3D PAGE_SIZE, the set_bit() is only called once, and
bitmap_and() is very cheap for single bit operation too.

The complex part is already under btrfs_is_subpage() check.

In fact the set_bit() and bitmap_and() will later be reused for
inline/compression skip, for both regular sectorsize =3D=3D page size and
subpage cases.

(There will be another new bitmap introduced into bio_ctrl, to indicate
which sector(s) do not need writeback, thus ther bitmap operations will
be there for that future change)

Thanks,
Qu

>
> Other than that this cleans things up nicely, you can add my
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> to v2.  Thanks,
>
> Josef
>

