Return-Path: <linux-btrfs+bounces-6980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00A947556
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 08:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94089B21433
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033C143C6C;
	Mon,  5 Aug 2024 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Lc7Tjf0D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B731E4B2
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839683; cv=none; b=f1NF2kZYqIxkxbOSNyOPrvXEUV3w2WBFizhISmGPrTjl+1oFy2CJUkmT/qcIfOjiYQBEEDzdBxdwivDvAJFZ+1R5LFQN8wc2Jtg2vExp5KV76k4zLjjD64ESYkyIGzW5FSZnxq/kzrKsG30jxXMX71B0xObq/eifpgJEx8U1xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839683; c=relaxed/simple;
	bh=+hw6wc38U17iXw0ybHqKx8SGZoldDw232pBME+iLJm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bn2K1zPnzb8Sk0qBk8mYSkC6YWOCg4SSYW0zAtPMyB3iXMaNB58uhuuLV7OwfDFIUzsNf8OC882m4196F7dpH7mfpi99rTP2YGprLaiHA1+DV7ASbE5dTQnXUTbpVxCR3DLPGOwGrhcV1pK/68vfb7Uhr3ozt4CyYwomKLUiNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Lc7Tjf0D; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722839678; x=1723444478; i=quwenruo.btrfs@gmx.com;
	bh=+hw6wc38U17iXw0ybHqKx8SGZoldDw232pBME+iLJm4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Lc7Tjf0DEykg7wM1B9sIZ5R4Vu7E/xqcsbFCQq79kuno4aDkHHw/z++R1FQc6Et7
	 /RikogQMO1Dt7F/Y6l1fFfmjjeRGdyaaWbyr0G5YfEuEn+fAL616xPUdBtWP14ool
	 DRrnJXw9u1kGDzyMzmuq9Vr7dKsE+6QW8njcCYcyIvNs5SGwCz5bj64nqc7OY9hfu
	 IrbOhb6x0vgA2j++2N+OO/CaQS2VecZagVxVzMP2ZR6pL50Z6vaL0iukoqlT8pmpO
	 EQhbYG5KD+DIBLe/rZh6f4vNehjsNWWzoY5BfcFpMAAA8ZSVdgvorc3qD0kgI1SbI
	 4MRtG74BDYe6ttBB4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1srYnb0upZ-00YsWd; Mon, 05
 Aug 2024 08:34:38 +0200
Message-ID: <1e96ef22-b51d-488a-ab90-84fd85c981ea@gmx.com>
Date: Mon, 5 Aug 2024 16:04:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
To: ellie <el@horse64.org>, linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
 <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
 <7d692229-d3d5-4b82-a70a-b7371c8724f0@horse64.org>
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
In-Reply-To: <7d692229-d3d5-4b82-a70a-b7371c8724f0@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wc/O3I43JwqrUsb3RKZnKWJjFhYYicTCl0Y/evEXoJI12Ale/y2
 64pfGH2N9gSfi65FQ2lAgqnwYes2MllBF3BSQzDYrIm/Aj0bMGbJ69WTbO+WrFTFd4GKd/h
 gvwFOAStcUcZHLaeV4aF0x5IU4HQFqiTD2IwVuPlfGTjnzV2aP7Hzuv2c7QnLEpRJWVi1nS
 uxDTCv1zmY9L9dknqQiOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DinmyAdnNEM=;dUOjyQi0fylWOzCbZoajzl8bZ3t
 un4re02ImqKIx81sOiH0O918y/oyNW4CRGzuMEMP2Qbq1yyBWmC2Dlwdtb6RFdu7chdvmxFT6
 Nza1rVTyBWmB3VGjVmu+YfSYLVIsrnClsraU+x92KAPmgDdxfOHJdqD9gx6bP3Y16hhYlJq8E
 4FTUvbJWqzQ1vyzY7Lje3VLaz51TV8oOIWD2F7HU0IF1NM2N3F0vrEut83SWg84tI/Jpwj6Jk
 8eV5UJrWdfeqkReYMZ8oYYFTFg5wHvuz4ycojuYQeWjqu49vq9SSkHx8DN9s3tT1MaE27d5Vn
 Y7EAmtHKGqxKsaidtAGPC9ZgHNyFRSWxKgdSr+es6NTN1qaupT5JCnR88qGp6LpSKj8HInwc3
 /RQEAeKh52T9Kt6fxAe7ZWUFXIJkf2VWOJ4CnWUeNqXP+Fgdg0BcUmNebkhzW7QDduSnZom/S
 WR6Bh4ls4BxvVCNgDPJFlrJ2H9tRBdV+tqv5rgluD63P8JJA2RVDtb9hksfWAgj/k5qRqUqMb
 3luod5TRFbIarf3gvb+cdGQxx2OHJ2aw2VdrF0KmOhT60M1YwJvEiIWvNOgYmF6c15bENN6mD
 YHXZtA7oZ9I8EHOvDHGfiJkQvdTM7ahZfDzsRQdcUWEk51fzUjShbZj3Au6fyuwjELs8uxDtV
 kiDK6YEB3RvSFw43u1x2QiTT6OrOvz/t7zhm746GaqOOp8GVPgspiuP3S8/leU1PS5EzGvNkp
 SV8sa8K9hpKtSuZupRlS4M9kxxh9sbNrXAUQevW3PYczBAzwQAz1kuSsE6ehp9AzLlIR2gDsu
 LyAa7YNLBz+4CJcI8uAY0sAwQw17wmlzrxUIp53YfNHvY=



=E5=9C=A8 2024/8/5 15:50, ellie =E5=86=99=E9=81=93:
>
>
> On 8/5/24 08:10, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/8/5 15:25, ellie =E5=86=99=E9=81=93:
>>> On 8/5/24 07:39, ellie wrote:
>>>> Dear kernel list,
>>>>
>>>> I'm hoping this is the right place to sent this. But there seems to b=
e
>>>> a btrfs corruption issue on the Pine64 PinePhone:
>>>>
>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>>>
>>>> The kernel is 6.9.10, I wouldn't know what exact additional patches
>>>> may be used by postmarketOS (which is based on Alpine). The device is
>>>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/
>>>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to
>>>> check in software if it's 1.2a or 1.2b, and I don't remember which
>>>> it is.
>>>>
>>>> This is on an SD Card, so an inherently rather unreliable storage
>>>> medium. However, I tried two cards from what I believe to be two
>>>> different vendors, Lexar and SanDisk, and I'm seeing this with both.
>>>>
>>>> The PinePhone had various chipset instability issues before, like
>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe
>>>> has however been fixed since. I have no idea if that's relevant, I'm
>>>> just pointing it out. I also don't know if other filesystems, like
>>>> ext4 that I used before, might have also had corruption and just
>>>> didn't detect it. Not that I ever noticed anything, but I'm not sure =
I
>>>> necessarily ever would have.
>>
>> In the detailed report in pmOS issue, you mentioned it's a video file.
>>
>> I'm wondering if all the corruptions you see are from video files,
>> especially if the video files are all recorded on the file.
>>
>> If that's the case, it may be related to the IO pattern, especially if
>> the recording tool is using direct IO and didn't have proper writeback
>> wait for those direct IO.
>>
>> Thanks,
>> Qu
>>
>
> Thanks so much for the quick input!
>
> All the files I mentioned in bug reports were written by syncthing, so
> there wasn't any on-device video recording involved. I once saw Nheko's
> database file corrupt however, so it's apparently not limited to
> syncthing. I'm guessing video files are affected so often simply due to
> their large size.

I did a quick clone and search of syncthing.

There is no usage of O_DIRECT directly, so I guess it's not the known
csum mismatch caused by bad sync of direct IO writeback.

In that case, since the corrupted file is syncthing synchronized, can
you do a diff of the binary data?

To avoid the EIO from btrfs, you can use "-o rescue=3Dall,ro" to mount the
sdcard on another system, then compare the binary.
(e.g. "xxd file.good > good.xxd; xxd file.bad > bad.xxd; diff *.xxd")

At this stage, we need to find out what's really causing the problem,
the btrfs itself or some thing lower level.
(I strongly hope it's not btrfs, but either way it's not going to end up
well)

Thanks,
Qu

>
> Regards,
>
> Ellie

