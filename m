Return-Path: <linux-btrfs+bounces-1381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E382A44A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 23:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B091E1F253E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2E4F8B4;
	Wed, 10 Jan 2024 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HJNhggxR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A64EB55
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704927168; x=1705531968; i=quwenruo.btrfs@gmx.com;
	bh=BoVtBbiwxcUILKM2/gEsESeJdBNWXtsCe/1cziicWqU=;
	h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
	b=HJNhggxRgWEe/9hhnr9xNQTJUkqEp7nBI+uPLYA1DX7R2HKeEFynMbkyqZpxrAtG
	 qhbj1VE2PuRFWeNcKoAxdD4vgFEF8W+E4vt8Ny24YBPe6jTpx1qSlWAOgYvrBoSQx
	 n7+vgMpXUEYJAIKy2V90ISEiJux3t6BJ583V+pZfURsMhg7JwKRiWm3JdIy5nvH5g
	 PJl+A3swfYChvOjazI7n+9XzcSmAUgtS5rN5bNQHBwUO63/Iw/OsSVxNaR0jflpB/
	 nqDrv/dC57VqFvh6QO4Q6t1r9Rv25aq93pzGDtfhNgD2q1HeNGJbKfJM6m215i8aZ
	 ZGGmmLn/kwFRSMxn5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.113.22]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWigq-1rhZl13nJo-00X55P; Wed, 10
 Jan 2024 23:52:48 +0100
Message-ID: <1b4f45c0-da2b-4817-8cdf-a07fd405ce9c@gmx.com>
Date: Thu, 11 Jan 2024 09:22:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
To: Zhang Rongrong <Rongronggg9@outlook.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
 <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
 <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
Content-Language: en-US
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
In-Reply-To: <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/I0o1CCOnkuMczGZMASwPL1cgvCYNVILqBRXZGVo++1qHTayNkH
 uaSg7AQq/UNxcT1zlYnoAl4OkKugZlUzTwZ3804jTGLIKQmtf9b1fEMhMS5hRPxrpy0HVEl
 Ume6gIxyNR5ozarGMJIFq1wzvywd3tjfYhw7/TO+6+AVg4IVw52+fq+AsHn8W0DzxBpqPhx
 /pyNVvvk39mrf5EvN6OAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UUT1/Tf2KvM=;8HKnyHvCWjmtJtYJpv3mU+a9pKD
 8aiu2p4Xzm1Oq/jOlXunpqgkURuRsbmaEaZiW3D0Cg/8plk4XMltuOnLU1w5tGDL4ZdU5JKHO
 XtbsIyWzF1eFD5RJoGcSTtFyy3MB5OLIcYhq6UVn9cZiElCd/5hZOcDdvkd87KjxiBSowGBiA
 wvhNsvAjX4XeHyzd2jeGNQtS/5TOihkVEa0IzEvS8sVNK5oauORP2JHB3hK6Fkf6gIhZv6PbK
 G8lqKVmXtxCbzYF7m+xo6g/6w/TCoiQwbdxnqzo9n1AyL2dCYrPB2x6d8QshCqF2vAq4zcW3l
 5G5s8iKTaMVKNeVUwwwGo/rwLIdHl/7z6hQQ83tAu124E/ovpKrfJWqA5Jo2VWfSZ7zkh1SaJ
 /oRFgBSNOe8pUGGeSRRHMTjzndIbHGtSAeI1eR2Sj7IDvgO9kzq/2CjCnQQ8LfGiHuNSNI4uN
 RO1EnK61w/96eovtQRsKSjQuRhZTtZAfj6FEc1tx+dtS/lFZQzwK33ylgnWl9ThvmgjmHWQBi
 BqvfM3vKF1Z/DowaAmuBarOeHRUZr5zPI83hbl/zOWqmTQEzMVWpe4yFZ69U3QSECo5S0ZdI2
 1WmuPhXMhIzEnF1LXspI4boVutH1ycXL66nwTCxfzVRA+G1ZDVeLTwirxs9dsRxTmYUDi4O6s
 OwIO0SGI6criZi/Tda7SMnkpF/NlkA+eWq22qUGHa3hTYNpyKMEIit4heSLxGXNCh5P8xwDBM
 k050crvuEYbhHbJHkFecsKIofAtT6xsPb1vmvwlZ95qRjJjJsqYEIKYaCTh5wXVgMVVn6hs4m
 5PIzmmEQvsCqKM1lOM4s5O9q+EXYgUOFE9QGqRE9ZgI0leH9rXKsjfnHaZ9jUWQ0J3jWv1Bl/
 AgBJCb6/8gwIeAh6bMjnkuSziCX7q0XR03OmIB7vLXSy+yX1jX6v4T9NHVaHvZmd5p1hxi8xG
 GRvyEqvbDExFIqNJAnoVlEyY7Mk=



On 2024/1/11 00:21, Zhang Rongrong wrote:
> On Wed, 2024-01-10 at 20:10 +1030, Qu Wenruo wrote:
>>
>> On 2024/1/10 19:42, Rongrong wrote:
>>> On Wed, 2024-01-10 at 07:49 +1030, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2024/1/10 04:36, Rongrong wrote:
>>>>> I guess the root cause of the issue is that one of the DUP metadata
>>>>> copies was somehow corrupted. Am I right?
>>>>
>>>> I don't think so, I think there may be some false alerts, either from
>>>> kernel scrub interface, or btrfs-progs.
>>>
>>> OK then. But I just wonder, if this is the case:
>>> Why `btrfs inspect-internal logical-resolve [LoC]` returned a file
>>> instead of ENOENT?
>>
>> Then we're having very conflicting results.
>>
>> "btrfs check --check-data-csum" is really the equivalent of scrub (just
>> offline), which will ensure EVERY copy is verified.
>>
>> If "btrfs check --check-data-csum" shows no error, I can only came up
>> with one possibility.
>>
>> - There is something missing csum and btrfs check doesn't report
>>     the problem in the first place
>>
>> This doesn't looks that correct to me though, as we have test cases to
>> ensure btrfs check can detect extents without csum.
>>
>> Can you provide the full dmesg/logical-resolve/btrfs-check result
>> without hiding the bytenrs?
>> That would help us to really clue all the problems.
>>
>> Especially for dmesg, the full one (from boot to crash/report) is
>> appreciated.
>
> dmesg:
> Please check the attachment. Some log were rate limited. I may disable
> the rate limit and retry if you need.
>
> logical-resolve:
> It either reported ENOENT or /path/to/file. Did you mean you want the
> address in command? I guess the full dmesg should help in that case.

Both would help.

If "logical-resolve" leads to -ENOENT, and extra dmesg output caused by
it, please attach the extra dmesg and the logical bytenr.

If "logical-resolve" leads to some file, and the filename is not
sensitive, please provide the filename and the logical bytenr.

>
> btrfs-check:
> # btrfs check -p --check-data-csum /dev/vdb
> Opening filesystem to check...
> Checking filesystem on /dev/vdb
> UUID: 1e4fb969-7384-48fb-9377-6fb8817279ee
> [1/7] checking root items                      (0:00:04 elapsed, 5675044=
 items checked)
> [2/7] checking extents                         (0:00:16 elapsed, 156729 =
items checked)
> [3/7] checking free space tree                 (0:00:01 elapsed, 1193 it=
ems checked)
> [4/7] checking fs roots                        (0:01:38 elapsed, 49161 i=
tems checked)
> [5/7] checking csums against data              (0:36:47 elapsed, 474124 =
items checked)

Yeah, this really means the whole fs is good.

[...]
>
> Hmmm, I might make a mistake. Actually it should be virtio-blk?
>
> [    1.185335] virtio_blk virtio2: [vda] 83886080 512-byte logical block=
s (42.9 GB/40.0 GiB)
> [    1.216577] virtio_blk virtio6: [vdb] 3907035136 512-byte logical blo=
cks (2.00 TB/1.82 TiB)
> # cat /sys/block/vdb/queue/scheduler
> [none] mq-deadline

We can rule out IO scheduler and virtio-scsi now.

>
>> Finally, since you're using USB-SATA convertor, have you tried to
>> connect the SATA disk to a native SATA connector on a desktop motherboa=
rd?
>> (I guess it may not be possible)
>
> As said above, I've tried test on "Intel CPU (i7-7567U), host,
> intel_iommu=3Doff, SATA HDD". The test was done with the disk connected
> to the native SATA connector, though it is not quite "desktop" (Intel
> NUC7i7BNH). Should it be enough?

Yes, with a known good SATA controller, it should be more than good enough=
.

And according to the attached dmesg, the most interesting thing is the
unable to find chunk map error.
I believe this is the biggest clue.

Another thing is, for regular non-zoned device scrubbing, the new btrfs
scrub code would always read a full 64K stripe in one go.
But in your case, the range we're mapping is not 64K aligned:

2214744064 % 65536 =3D 20480
2214748160 % 65536 =3D 20480
...

I'm not 100% sure if this is related, but for any newer btrfs, we should
have all chunks start at a bytenr aligned to 64K.

Since you have a disk dump of it already, mind to full balance the fs,
then retry to see if there is any difference?

Thanks,
Qu

