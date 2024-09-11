Return-Path: <linux-btrfs+bounces-7940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C07974F00
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E551F22ED8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C817B433;
	Wed, 11 Sep 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PQ2wD34y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C92EB10
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047991; cv=none; b=lbXjlCM6IvbowsLHDgY6tMtxgD0lP9TCZANZZ8wEAb4c1zk27XaBRt3jiYhlf6OsQoIR4sTyIuSnNEzNVcQ66tBwbAPNGS7RqExFg/qAMq462/Cr715onmKHpuICtSMecBpRRNnQ8JWZJGdfTHAaFWKRvDu/auH7ZKIVfAYZiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047991; c=relaxed/simple;
	bh=dJ/2IaQCjEzu+eUklCY6LAeWkptnWtlRut+3XqAJWcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9VKZBv1wUhNeukvBGIEBOJb39a3vSl7Jzl++A3EWaeOnKy9xiHJ78okjdngAXKN2otIvAXHXIqZ4FGUA/SCojV3glSJTmDOcDTbZz4lLbcRPuVFOyqomnrZXf8dHnkxwEstK8wkMYiCt6/ghEU0PcnBylfivr+dLCWurhDQLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PQ2wD34y; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726047986; x=1726652786; i=quwenruo.btrfs@gmx.com;
	bh=0AD1gK3s1ZNyWO95MLOtAl+Rol0WqmTm3phOye/mBWY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PQ2wD34yrw50ecH0dnjAhtp7G7Hpt+R4t2nxL0Ql8vecqoWozDJXw5s/RB/7EdTC
	 wrpOguoKK5tpZml2+VhsYy9qKvoKGIZdcu2Ke7MeBUiSTdTJnJFn5kIm5OFmXShWC
	 hdVhh0H4SH0uO4k77ZH47xVLi+fE0jsWvwdVXipd4L61KpZJYhrbXvUSgQSMIAT7A
	 seHtLQKGA+CB1M6scY+Dl+8TAGAQf5SNphNBwxe8AtBLsMc4/4OY5DIVLWk3CsRTM
	 kWtko0aq9x5579ZwyOss/ZjhtPfun8OcauGhZ7j3m4knMfLNsp5iol0dMJY2Mc18o
	 4XGSIQqn+I8RGvS4yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwQXH-1ryPhM0YDN-016cXn; Wed, 11
 Sep 2024 11:46:25 +0200
Message-ID: <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com>
Date: Wed, 11 Sep 2024 19:16:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
 <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
 <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
 <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
 <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
 <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
 <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
 <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
 <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com>
 <CAAYHqBbcQwLqn4SBnKbimgttUbNxMRnH0AhwYKXJTJu1G=C9ZQ@mail.gmail.com>
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
In-Reply-To: <CAAYHqBbcQwLqn4SBnKbimgttUbNxMRnH0AhwYKXJTJu1G=C9ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aU5HDAQkzcdC6RQRI4dt3ckwqFffTWodo/bFF3O44ch/H5RQpp4
 f1PvcTJJ90JEmZLX//pQ8Yvk76HMkg4zCCx08hpJjxEZ+Xxuw54qAyJKQxvPWcqqT+Ccl3m
 VBrjGFRUaDakW1N74GJaewp7XFz7AA99Qb0iRV1ML2J8v7MmiUz8l2UzYwHB6Gdlu2aCCXu
 YJ0hPNW5q5qjs/yWNHWcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l99HYC3r4I4=;/c+1izHSEvZKnFmmf3Xd/K4Izw6
 ENJNRS19LQQQyvKGCRcHWwDJBOA62a4Nr0ZsWxjJuTV1M9gO8lFuoA3hr+MufaIMZdNqw1252
 NK2vD3UK0GXfNVa7CHZGjGtZ8hGVsN30REXhUolzBUg7QkK0qhRCq/qem2JM7Qx6VzIDyXFfu
 8jt4rVB/+R4JG9B/kg8pdX2o5I1Oh9l5nyA5McumArZe61sfJQJkU0LOXydfao7HDJ4XHZBmE
 Mvy2xQ9l/QZOLj/xPZ2KINPq/r7x/c/2bwy328jvFJN+ZoyNWHAMs0nQQEFLmztOJk4ciZDxX
 Ey0NY1AeJ7UL5PBv8SPSvpANefhMrLPAWX5E/IEsFb0tYrO638BPbxBsrWSMOprfhvXS7AgV1
 DTxrJkJUuPmxnDu54nhwu0wKiXoIFauPm7QKWlrhEw/iC3Cb5d3xSzKavZ3oFaP59va3qMegD
 JwP0f3/QY4x3jr5dIZuaTTohHiPgQDB/dHrjgaKlRRuylOGVk8bwOZtdEJj0KftqEjWnHk91h
 MdqeTmKr6HG9MBPtOIHXMR8x0XmcHVJXB6o6kjhpycq2t/yamObZRjWEdJ78Bus38CqoP8y4m
 mTybIoW4FyW2l4CmNYp8o9ScTcMd2lhOpTDwMibVQyHP30mtjVGL0U817FGRGW4B16nX7z2d8
 kUSBkd+6nHN+pj3yX9TjwVn72RUO3UrK2/kSTj5JOzPW9PF5KnXPkhzFeqMR1Ix9OO8gUzaMj
 RoyaM/Nr5CIFW2EhMSgT6jYSh9hOb5CgmYi5awy2/zeVcLc/wuoLNpVG2B0V5Yl3OAP6qJBZT
 R6EC2DmKutQhdzVCrWBxIzoE6Nh6U78rf4kM9XZ0VgeHM=



=E5=9C=A8 2024/9/11 19:08, Neil Parton =E5=86=99=E9=81=93:
> OK I have a new drive on the way which I was going to use to copy data
> on to, but will now replace /dev/sdc to be on the safe side.  SMART
> looks ok but don't want to go through this again!
>
> Maybe it was a bit flip?

Nope, bitflip should not lead to a single mirror corruption, but all
mirrors corrupted.

This looks more like that specific disk (mirror 2 of that logical
bytenr) is not fully following the FLUSH command.

Thus some writes doesn't really reach disk but it still reports the
FLUSH is finished.

Furthermore only two tree blocks are affected, which may just mean the
disk is only dropping part of the writes.
Or you should have at least 4 tree blocks (root, subvolume(s), extent,
free space trees) affected.

This behavior will eventually leads to transid mismatch on a power loss.
It's the other mirror(s) saving the day.

And before replacing the disk, please really making sure that
"btrfs-map-logical" is really reporting the mirror 2 is sdc, or you can
still keep a bad disk in the array.


Just keep running RAID1* for metadata, that's really a good practice.

Thanks,
Qu
>
> On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/11 18:59, Neil Parton =E5=86=99=E9=81=93:
>>> dmesg | grep BTRFS
>>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
>>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
>>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
>>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
>>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
>>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
>>> 75c9efec-6867-4c02-be5c-8d106b352286
>>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
>>> checksum algorithm
>>> [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
>>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
>>> [    6.064092] BTRFS info (device sdc): using free space tree
>>> [   76.647420] BTRFS error (device sdc): level verify failed on
>>> logical 313163105075200 mirror 2 wanted 0 found 1
>>> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105075200 (dev /dev/sdc sector 1145047360)
>>> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105079296 (dev /dev/sdc sector 1145047368)
>>> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105083392 (dev /dev/sdc sector 1145047376)
>>> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163105087488 (dev /dev/sdc sector 1145047384)
>>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
>>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
>>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
>>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
>>> [  260.968635] BTRFS error (device sdc): parent transid verify failed
>>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
>>> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116052480 (dev /dev/sdc sector 1145068800)
>>> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116056576 (dev /dev/sdc sector 1145068808)
>>> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116060672 (dev /dev/sdc sector 1145068816)
>>> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
>>> off 313163116064768 (dev /dev/sdc sector 1145068824)
>>
>> All happen on mirror 2.
>>
>> You can locate the device by:
>>
>> # btrfs-map-logical -l 313163116052480 /dev/sdc
>>
>> Which gives the device path.
>>
>> I would recommend to check the device's smart log and cables just in ca=
se.
>>
>> Thanks,
>> Qu
>>>
>>> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
>>>>> Many thanks Qu, I appear to be back up and running but I also had to
>>>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
>>>>> super-recover said the superblock was fine.
>>>>
>>>> This is not expected. I believe btrfs-rescue should check log trees
>>>> before doing the operation.
>>>>
>>>>>
>>>>> On reboot and remount (as normal) I have a couple of residual transi=
d
>>>>> errors and I'm currently running a full scrub to try and clean thing=
s
>>>>> up.
>>>>
>>>> Transid is also not expected, if the transid error persists, it's a h=
uge
>>>> problem.
>>>>
>>>> Does the transid only shows on certain mirrors?
>>>>
>>>> Anyway a full dmesg from the first transid mismsatch will help a lot =
to
>>>> find out what's really going wrong.
>>>>
>>>> I hope it's really just the bad log trees.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Hopefully though I'm back up and running, this is the longest the FS
>>>>> has been mounted in 48 hours without it reverting to ro!
>>>>>
>>>>> Can't thank you enough for your help. I hope I'm not premature in
>>>>> thanking you / will report back with any more errors.
>>>>>
>>>>> Regards
>>>>>
>>>>> Neil
>>>>>
>>>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
>>>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives i=
n
>>>>>>> the array?
>>>>>>
>>>>>> Run it on any device of the fs.
>>>>>>
>>>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>>>>>>
>>>>>> And you must run the command with the fs unmounted.
>>>>>>
>>>>>>>     Reason I ask is when this first occurred it was one
>>>>>>> particular drive reporting errors and now after switching out cabl=
es
>>>>>>> and to a different hard drive controller it's a different drive
>>>>>>> reporting errors.
>>>>>>>
>>>>>>> It's also worth noting that this array was originally created on a
>>>>>>> Debian system some 6-8 years ago and I've gradually upgraded the
>>>>>>> drives over time to increase capacity, I'm up to drive ID 16 now t=
o
>>>>>>> give you an idea.  Does that mean there are other gremlins potenti=
ally
>>>>>>> lurking behind the scenes?
>>>>>>
>>>>>> Nope, this is really limited to that inode_cache mount option.
>>>>>> I guess you mounted it once with inode_cache, but kernel never clea=
ns
>>>>>> that up, and until that feature is fully deprecated, and newer
>>>>>> tree-checker consider it invalid, and trigger the problem.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
>>>>>>>>> btrfs check --readonly /dev/sda gives the following, I will run =
a
>>>>>>>>> lowmem command next and report back once finished (takes a while=
)
>>>>>>>>>
>>>>>>>>> Opening filesystem to check...
>>>>>>>>> Checking filesystem on /dev/sda
>>>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>> [1/7] checking root items
>>>>>>>>> [2/7] checking extents
>>>>>>>>> [3/7] checking free space tree
>>>>>>>>> [4/7] checking fs roots
>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>> [6/7] checking root refs
>>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>>> found 24251238731776 bytes used, no error found
>>>>>>>>> total csum bytes: 23630850888
>>>>>>>>> total tree bytes: 25387204608
>>>>>>>>> total fs tree bytes: 586088448
>>>>>>>>> total extent tree bytes: 446742528
>>>>>>>>> btree space waste bytes: 751229234
>>>>>>>>> file data blocks allocated: 132265579855872
>>>>>>>>>       referenced 23958365622272
>>>>>>>>>
>>>>>>>>> When the error first occurred I didn't manage to capture what wa=
s in
>>>>>>>>> dmesg, but far more info seemed to be printed to the screen when=
 I
>>>>>>>>> check on subsequent tries, I have some photos of these messages =
but no
>>>>>>>>> text output, but can try again with some mount commands after th=
e
>>>>>>>>> check has completed.
>>>>>>>>>
>>>>>>>>> dump as requested:
>>>>>>>>>
>>>>>>>> [...]
>>>>>>>>>                      refs 1 gen 12567531 flags DATA
>>>>>>>>>                      (178 0x674d52ffce820576) extent data backre=
f root 2543
>>>>>>>>> objectid 18446744073709551604 offset 0 count 1
>>>>>>>>
>>>>>>>> This is the cause of the tree-checker.
>>>>>>>>
>>>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode c=
ache.
>>>>>>>>
>>>>>>>> Unfortunately that feature is no longer supported, thus being rej=
ected.
>>>>>>>>
>>>>>>>> I'm very surprised that someone has even used that feature.
>>>>>>>>
>>>>>>>> For now, it can be cleared by the following command:
>>>>>>>>
>>>>>>>>       # btrfs rescue clear-ino-cache /dev/sda
>>>>>>>>
>>>>>>>> Then kernel will no longer rejects it anymore.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>
>

