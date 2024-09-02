Return-Path: <linux-btrfs+bounces-7718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75006967EE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 07:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFF01F2256A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23C153837;
	Mon,  2 Sep 2024 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KIdwShoj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E57149E03
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255860; cv=none; b=X5Vr63hbrxxUwvZOP/3b4VP7OrVcxNo77+AajpcP7kvAlZbMQ/CJ+rm1lRinBaTVz01nMShEIRB3wKcTvsfVqNdJvYleMmfDpoVAltHfljUXPrj8RFpjUtgv1zjlXkeM6cUHxJ5BeBgqrST0yVumDy3r2AMWAtNmIakDPL02mV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255860; c=relaxed/simple;
	bh=pxTlJgM5VFD8G4cTyC0Jdy9nOBhvnJERAdyjPvCrjbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IY6ZvKdlgjWdUFxBA7MfKV82LSVo0nxRw3CNur5HX6HX2LCKydl+j1CgkMO8jnh37T9AMv0Pu3omEVbccvCceygH9ERYJYSDS5Cxv8VvSplHL+RavvlKO5ppL0WlG5xd8sR8lZTS+OXmlTwDgIJT1D0MCfyuJa8zd1SEqRbxvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KIdwShoj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725255794; x=1725860594; i=quwenruo.btrfs@gmx.com;
	bh=pue1M7b3mb+F6yfsJb1V3VwrmcGNBqUeVIJXY2x5LxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KIdwShoj6iknjCYxxunxT7hU0wVWVa00w7ew1KCHfLAQiF9aShV/4PwFswwp1juZ
	 AiiohdaYVUuzLbO49QkssVS44BydCC/Hki1rUdXveLBFcxkxXeEb/AHf+vpX0mGCX
	 TJ5UqUUEEb7nFNbXH5MpJdUUohYdL4kt/xLiyz2f4C7V7Rqgv9yLorgG72UvH2JkL
	 HQp1Rbp3R8ZPZCwcLE5z9YyH/BGEfFL4Q4TnKzGio9O4d0llTaz1nEx+Gw0tX7Dql
	 Gbwv/9XT+9mdqN1HxSYHVcDTQ+gwqcmA17ns67ZDnBufcO1e0/9iyDSCk9khsov6r
	 n5IUbJxBdLXsGVICmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2W5-1sJx9K1qvH-00qdzW; Mon, 02
 Sep 2024 07:43:14 +0200
Message-ID: <c70ac7be-c670-4b89-ae8c-bd34fb505997@gmx.com>
Date: Mon, 2 Sep 2024 15:13:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corrupt BTRFS can't be get into a consistent state
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
 <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
 <ce3a4dbc-4e81-4b05-b9e5-c92eec9b5d80@wiesinger.com>
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
In-Reply-To: <ce3a4dbc-4e81-4b05-b9e5-c92eec9b5d80@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A/x+HAwm8iPJzOJIlpa3WkrKe4xe30wN2kzVJZFY7hBoMtk1i5j
 vAVPexQaoboye3QMLDdAwAu3PMuqHllCd5s2jQVTg4ZGbQjWHKSoa5p7IHwAgIYUILQrhvL
 DAH1oJBzRG2tWxdFtimfOVzOrHVdYHYpScQHb8cFtFVtRud3GA1CUQyXYGSqqXHsi4sEudR
 GO0gYb/sZD7b6PfMCVMEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:34mPhSopQ6A=;KZZWxlSwouJIJJCbKHMBHxTuUDV
 rc1nJ3pe8SvuiVTTBI954WosS6MJt7boD3sF29Jkv11S0cq98jv6ZT5+weYKfk4MS9zG6VPeH
 EWazQjL8y6lorIitYhjheAh9WqTBFJ4H4hNeajN/47EjMMOVmIhohuhNfLcxu2dZqwFY+F5RQ
 4BcVEutEi8d3W4XFXEPqZIymct7od9J4lbIWqsWIxrm9ukrbnXQ7Zv27fKLBuc0HU2oHJrDkM
 P7y5ZCBB0QRF6LQLhgf+Q8sJxScnw8TeUOUEaLDsN8GpCki82MwMJQC8+1FPYj3OJWJIQk1O1
 5lRIqo9szOefwnbE7TYi2X0HWfapYseiFF42/sEmV25SmcdDZYTRA4TxZyGXUecs73rW3xgcC
 ZJg4EJaRFN5tWSANNGi92uVKN7Ouq0ePEzUy0Qu6VhIUbCIS3PhTRTpzEMR7+Pvz96aLQpsaf
 Ncqa3AVz3Y0t5bXbOmsiJ6cae7MNC3OVCRWslr73KXs7hu6wWSSftEYUTUqR+k0UvxiCWNZYm
 LsW3IwbHotFW7Oa/ZToHnR06yeZOl5xwIvHvATof7XpTI+s3Wo3Tyua0xVQDVV2OQnbPWFe67
 ivA02cT+Pqgo3QPYYlmn4cdk0E1KzxftbWc4wao/SUQ/7crsMw+3V2/h17i12NnfZ6w+ZnDyL
 SF9uTERgopYwFZzH8TIj6pH5hvmPjoOV9Ok7aU5ogGGfi/3UyU4iCjGwQW4zg0hVHiZkmxTxn
 RB+M4sUg3F6D1RU5qtlrHzsxFtDESevaGc2CwqmNTgNbr7utVFpf/rfE5s/B8835Rvr3KCXZR
 8qehCkEy4S2GWrFjvzZU8M6g==



=E5=9C=A8 2024/9/2 14:58, Gerhard Wiesinger =E5=86=99=E9=81=93:
> On 02.09.2024 00:13, Qu Wenruo wrote:
[...]
>> So it means 60 metadata csum mismatch is fixed, only 145 bad data
>> sectors.
>
> How to get rid of the 145 uncorrectables?

Those are all data, at least for my case.

It will not be repairable, just as you mentioned, data loss is expected.

>
>>
>> And after the above scrub, btrfs check reports no more error (at least
>> for metadata):
>>
>> Opening filesystem to check...
>> Checking filesystem on /dev/test/scratch1
>> UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space tree
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 3776757760 bytes used, no error found
>> total csum bytes: 1692008
>> total tree bytes: 82444288
>> total fs tree bytes: 71237632
>> total extent tree bytes: 6455296
>> btree space waste bytes: 43819992
>> file data blocks allocated: 29158084608
>> =C2=A0referenced 4905811968
>>
>>>
>>> Any ideas how to repair and what can be done to get it into a consiste=
nt
>>> state?
>>
>> Please give the original "btrfs check" output.
>>
>> I think your original fs is either using SINGLE metadata profile (then
>> very hard to do repair), AND you're using incorrect way to repair (scru=
b
>> first, then btrfs check to verify, never --init-extent-tree nor
>> --init-csum-tree unless you know what you're really doing).
>
> I originally did scrub first (forget to mention, but there were still
> uncorrectable errors as with my test script)

Aren't you expect data corruption?

The uncorrectable errors just means, btrfs knows there is some data with
checksum, but the on-disk data mismatch with the checksum.

Since it's SINGLE, there is not way to recover, exactly your "data loss"
case.
The only difference from other fses is, btrfs can detect the corruption
and report them as error.

>
> Original ones: DUP Metadata, so repair should work fine regarding
> metadata (I have also an original copy of the virtual disk image so I
> can play around).
>
> btrfs inspect-internal list-chunks /mnt
> Devid PNumber=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Type/profile=C2=A0=C2=A0 PSt=
art=C2=A0=C2=A0=C2=A0 Length=C2=A0=C2=A0=C2=A0=C2=A0 PEnd LNumber
> LStart Usage%
> ----- ------- ----------------- -------- --------- -------- -------
> -------- ------
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Data/single 12.00MiB=C2=A0=C2=A0 8.00MiB 20.00MiB=
 1 12.00MiB
> 99.76
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0 =
Metadata/DUP=C2=A0=C2=A0=C2=A0 36.00MiB=C2=A0=C2=A0 1.00GiB=C2=A0 1.04GiB =
2 28.00MiB
> 14.74
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3=C2=A0=C2=A0 =
Metadata/DUP=C2=A0=C2=A0=C2=A0=C2=A0 1.04GiB=C2=A0=C2=A0 1.00GiB=C2=A0 2.0=
4GiB 3 28.00MiB
> 14.74
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 2.04GiB=C2=A0=C2=A0 1.00GiB=C2=
=A0 3.04GiB 4=C2=A0 1.03GiB
> 93.51
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 3.04GiB=C2=A0=C2=A0 1.00GiB=C2=
=A0 4.04GiB 5=C2=A0 2.03GiB
> 49.37
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6=C2=A0=C2=A0=
=C2=A0=C2=A0 System/DUP=C2=A0=C2=A0=C2=A0=C2=A0 4.10GiB=C2=A0 32.00MiB=C2=
=A0 4.13GiB 15
> 15.18GiB=C2=A0=C2=A0 0.05
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7=C2=A0=C2=A0=
=C2=A0=C2=A0 System/DUP=C2=A0=C2=A0=C2=A0=C2=A0 4.13GiB=C2=A0 32.00MiB=C2=
=A0 4.16GiB 16
> 15.18GiB=C2=A0=C2=A0 0.05
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 4.60GiB=C2=A0=C2=A0 1.00GiB=C2=
=A0 5.60GiB 6=C2=A0 6.56GiB
> 37.75
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9=C2=A0=C2=A0 =
Metadata/DUP=C2=A0=C2=A0=C2=A0=C2=A0 5.60GiB 128.00MiB=C2=A0 5.72GiB 7 7.7=
1GiB
> 9.55
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10=C2=A0=C2=A0 Metad=
ata/DUP=C2=A0=C2=A0=C2=A0=C2=A0 5.72GiB 128.00MiB=C2=A0 5.85GiB 8 7.71GiB
> 9.55
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 5.85GiB=C2=A0=C2=A0 1.00GiB=C2=A0 6.8=
5GiB 9=C2=A0 8.12GiB
> 11.79
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 6.85GiB=C2=A0=C2=A0 1.00GiB=C2=A0 7.8=
5GiB 10 9.12GiB
> 16.43
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 7.85GiB=C2=A0=C2=A0 1.00GiB=C2=A0 8.8=
5GiB 11
> 10.12GiB=C2=A0 69.76
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 8.85GiB=C2=A0=C2=A0 1.00GiB=C2=A0 9.8=
5GiB 12
> 11.15GiB=C2=A0 80.00
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single=C2=A0 9.85GiB=C2=A0=C2=A0 1.00GiB 10.85GiB =
13
> 12.15GiB=C2=A0 45.58
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single 11.85GiB=C2=A0=C2=A0 1.00GiB 12.85GiB 14
> 14.18GiB=C2=A0 67.44
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Data/single 12.85GiB=C2=A0=C2=A0 1.00GiB 13.85GiB 17
> 15.21GiB=C2=A0 35.54
>
> (BTW: Any other way to find this out?)

`btrfs fi suage` is more than enough to find out the profiles.

>
>
>>
>> And your random corruption script is the best case scenario for btrfs,
>> it's pretty easy for btrfs just to use the good mirror to repair
>> metadata, without any need to extra repair inside metadata.
>
> # Syntethic test case:
>
> # Destroyed with script after btrfs scrub start /mnt
> [root@localhost ~]# btrfs scrub status /mnt
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 717cee50-d376-4c5a-941d-3dac986256fd
> Scrub started:=C2=A0=C2=A0=C2=A0 Mon Sep=C2=A0 2 07:11:30 2024
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00:25
> Total to scrub:=C2=A0=C2=A0 3.73GiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 152.74MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 verify=3D8 csum=3D182
>  =C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
>  =C2=A0 Uncorrectable:=C2=A0 178
>  =C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>
> # After finishing
> btrfs scrub status /mnt
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 717cee50-d376-4c5a-941d-3dac986256fd
> Scrub started:=C2=A0=C2=A0=C2=A0 Mon Sep=C2=A0 2 07:12:39 2024
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00:26
> Total to scrub:=C2=A0=C2=A0 3.73GiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 146.87MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 csum=3D178
>  =C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A0 Uncorrectable:=C2=A0 178
>  =C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>
> =3D> so there are still uncorrectables, why can't they be fixed with
> scrub? (Expectation: "Clean filesystem afterwards, maybe some data lost
> due to overwritten parts")

That's your "data lost", btrfs just detects those data loss and report the=
m.
Unlike other fses with data checksum, they can only accept whatever data
is on the disk, not knowing if it's good or bad.

>
> # Original disk (after running a lot of scrub/repair commands):
>
> btrfs check /dev/mapper/fedora--defect-root--defect
>
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> Missing extent item in extent tree for disk_bytenr 1402974208, num_bytes
> 1847296
> Missing extent item in extent tree for disk_bytenr 1423011840, num_bytes
> 598016
> Missing extent item in extent tree for disk_bytenr 1457127424, num_bytes
> 6164480
> Missing extent item in extent tree for disk_bytenr 1484931072, num_bytes
> 7127040
> Missing extent item in extent tree for disk_bytenr 2022019072, num_bytes
> 1773568
> Missing extent item in extent tree for disk_bytenr 2635603968, num_bytes
> 5255168
> Missing extent item in extent tree for disk_bytenr 2817658880, num_bytes
> 8073216
> Missing extent item in extent tree for disk_bytenr 2935803904, num_bytes
> 3244032
> Missing extent item in extent tree for disk_bytenr 2605039616, num_bytes
> 8355840
> Missing extent item in extent tree for disk_bytenr 2745331712, num_bytes
> 3706880
> Missing extent item in extent tree for disk_bytenr 3018563584, num_bytes
> 3121152
> Missing extent item in extent tree for disk_bytenr 2947518464, num_bytes
> 8302592
> Missing extent item in extent tree for disk_bytenr 3068272640, num_bytes
> 2781184
> Missing extent item in extent tree for disk_bytenr 2791301120, num_bytes
> 3547136
> Missing extent item in extent tree for disk_bytenr 7574302720, num_bytes
> 3350528
> Missing extent item in extent tree for disk_bytenr 3031347200, num_bytes
> 1216512
> root 5 inode 72933 errors 840, bad file extent, odd csum item
> root 5 inode 90368 errors 840, bad file extent, odd csum item
> root 5 inode 166783 errors 840, bad file extent, odd csum item
> root 5 inode 219687 errors 840, bad file extent, odd csum item
> root 5 inode 248131 errors 840, bad file extent, odd csum item
> root 5 inode 346844 errors 840, bad file extent, odd csum item
> root 5 inode 379257 errors 840, bad file extent, odd csum item
> root 5 inode 464039 errors 840, bad file extent, odd csum item
> root 5 inode 464044 errors 840, bad file extent, odd csum item
> root 5 inode 471393 errors 840, bad file extent, odd csum item
> root 5 inode 681858 errors 840, bad file extent, odd csum item
> root 5 inode 833692 errors 840, bad file extent, odd csum item
> root 5 inode 909657 errors 840, bad file extent, odd csum item
> root 5 inode 910009 errors 840, bad file extent, odd csum item
> root 5 inode 1032866 errors 840, bad file extent, odd csum item
>
> root 5 inode 1153395 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 53460 ind=
ex 0 namelen 75 name
> 7ae2e1b7acb59ea0b30163c03de1cf3884abdc3f-kernel-core-4.19.6-200.fc28-x86=
_64 filetype 2 errors 6, no dir index, no inode ref
> root 5 inode 1153401 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 53460 ind=
ex 0 namelen 70 name
> 2ed0519ee6bab67f5e5d5d6ce4650e541fbb359f-kernel-4.19.6-200.fc28-x86_64
> filetype 2 errors 6, no dir index, no inode ref
> root 5 inode 1153403 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 53460 ind=
ex 0 namelen 76 name
> f2caebbe5620078065d21c37e4a88e8f5957215b-kernel-devel-4.19.6-200.fc28-x8=
6_64 filetype 2 errors 6, no dir index, no inode ref
> root 5 inode 1153405 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 53460 ind=
ex 0 namelen 78 name
> 2ad09f77ebb3882396b40dfa44f2840cccf4cf9d-kernel-modules-4.19.6-200.fc28-=
x86_64 filetype 2 errors 6, no dir index, no inode ref
> root 5 inode 1159931 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 271 index=
 0 namelen 15 name fc29-update.log
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 1159933 errors 2001, no inode item, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 53026 ind=
ex 0 namelen 31 name
> fedora-modular-ce4dd907f26812da filetype 2 errors 6, no dir index, no
> inode ref
>
> <skipped a lot here>
>
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/fedora--defect-root--defect
> UUID: 7bb1e7be-c83c-4cbb-a396-14c38393977c
> found 5625135104 bytes used, error(s) found

Please provide the full output with both stderr and stdout combined.

It looks like there is one or more tree block fully corrupted (for both
mirrors), thus we got this many errors.

In that case, it's very hard to repair, but you can still try "btrfs
check --repair" to try your luck, just remember do not try those fancy
flags unless you know what you're doing.

Just remember even for DUP, the chance of a full recovery is still fully
depending on that at least one copy is still good for your metadata.

If your corruption is not really random, it's not that hard to corrupt
two mirrors in one go, and lead to the above very complex corruption
thus much harder to repair.

Thanks,
Qu

> total csum bytes: 4979288
> total tree bytes: 171147264
> total fs tree bytes: 154255360
> total extent tree bytes: 10895360
> btree space waste bytes: 36824455
> file data blocks allocated: 11575373824
>  =C2=A0referenced 5772767232
>
> Can test on the original disk in the evening.
>
> Thnx.
>
> Ciao,
>
> Gerhard
>

