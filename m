Return-Path: <linux-btrfs+bounces-7943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BE974FBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 12:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B19BB25129
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F9155346;
	Wed, 11 Sep 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QeGBjiMp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331862F30
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050713; cv=none; b=Lc8WJOFZDx/aoUW3k62wXEA6TCY9kU3N05shaU/i1M8Lqr/hLWaIwIjwyc0r7QdxQXA3opm9UBFbSXx9KgAR+NMHDAmfqSGAKlKVmfh0jbHiF19RTR5Id2x13tP2UEUXpYZuBAmNEKuFJtItoigWc6GL2zBaUYhbGf8mYyQ+yxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050713; c=relaxed/simple;
	bh=lGQFpoLHJs4C2sKwCPNAi2iZ5EoPrQswot7IEgdXi7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBLHlgrZNwqDv2+yDIfAgEuVdXK4yo/b4kEp8RJu54Wkwcw9SXas4YqoOX1sRNezc4QafKjRMy6+cjnrSmclDGrN9J8DkMYVCYFAH3koMSc1NBFWOdAGc8t59bTiVkRhzuVnxdERsljt6BVJvDjB3jF+8cT79t//q433CoaYfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QeGBjiMp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726050708; x=1726655508; i=quwenruo.btrfs@gmx.com;
	bh=93/fNltuHvzRCW+CPDdhuBf4uRJWT3ao2Q4Qh2CJ+3s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QeGBjiMpfleiQFgac1lgw+1jZNFmZNFKP6PpwYEGhdoZFNHVVSrdJDMOtbb7UT6E
	 bIpffxC1jcEHzGqPQiFTtcHdN1Dxf5lcZlvguOnrBNhH0NqpVW7Fnex6IE87MtywR
	 Rn6DgLEK0owxT9k6stoO8u9mRna4hwv94ExUel50LWR6JtfVX+6ZF0379J71vX9da
	 GWnJmDuwfSDeCrjanRLC+6663kjYWjU15Lgg453eC1r8wRlUyXUJFoeWC9JBPsjJl
	 EqrtEyBl44LMsPRxN72Nuy6SqbNQ2W/69RLjcWEVERbhvCkvkyTJ2bTzbOLmYGoRt
	 HVwS8y6pr/jod17LDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1sgKIQ1bRF-006zQW; Wed, 11
 Sep 2024 12:31:48 +0200
Message-ID: <30da9047-87a2-4d1f-b132-3153c74279d5@gmx.com>
Date: Wed, 11 Sep 2024 20:01:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
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
 <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com>
 <CAAYHqBaYW_6ooNnsmV4xa0_6oONdQw6rDswUk-jcEZipO1CNHg@mail.gmail.com>
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
In-Reply-To: <CAAYHqBaYW_6ooNnsmV4xa0_6oONdQw6rDswUk-jcEZipO1CNHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ndRMALeiLSCGEXEyH8iv1StqlUx/CNT9/DjVxH34oSHVfh/vBjf
 YUZ0cbuD97VGn6W3kPqloX4w2t+iDxj/jwVVHn4QtS/BT2pK8QFCckfVsYQiDI5LuZfl4AT
 TxH/dTIZy6LgOQCEI8hTkuHF/GToy7Qj5wGGhNYmYIy/5UZjX9fpGDfJ7ZATkCxoy7gltN0
 zJO2RNMfddV76BGExZe2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ou7Bqj0+SLg=;cEiPlnOxoM0DBJ/4v+bFg7D+N40
 DGtu4kI6GNg0N1lDJXgy9EhkINZ1nUWX5Ay4Uxde6nibfk+su14mNxnVuMMX9sdnlyEZR5lB2
 vQZDhksd+FNmSLrEhk2sn5cz2vEq7tlrUM/vEN0/nnmEWpBaJFYckJNBczOcstAiFReeULCMH
 Zfwrl+VZHbzLVKuK9j/mAIlUlTiL6ekhpP+4B9vslk/+5bgAr6TquR0cTBzdMXjDiNLSa6zfR
 ewEmo6FKJrmiu6Kdddmytw8MuzCRDbZKH/hhixkg7rWMRcqe8YV1gR7Mz6tHCvrmWH8O+kBH9
 jAxMaTjz8kWcu8nYFITkrsM4pom7i/N0ZyTmEkAwZtSlJkIqqqXB2DglI+4jvJma3+N/gEFfo
 oOTfW2e3qtTcN8zmtXOxoQlgm3j9pVUCf7D3DbUV6OWxDiV3J1ha5PDcjyq+6t9/7unBtFbWd
 i7+hgGiQ7pq5nsUZMz3H8dMV9uhokBaRpNS+6eUwEtb94iBDQEBzXAGrfiQWFNBjdcp8T7k/D
 anZMuiKiIjn60P5RJWyRRjJxUKX2KX69U9W4oCbJCRcJB80XRdeJ45Ub5kpMGT7agry3LN+UT
 NJZBGTfERfuBh19R5ptB/sYVYbxLJiycIoX7kLVBcNsH4X0rJmXcEfMzaYN3cAYhOE2+iYtWb
 HosW7CrqG723xxxU0H3fmAhBhDeScIA9ZFHp3Oowc+nMOb2xcOYVTTW09JYP9WeqxOF0yPAjk
 4c8wmBCEAUC8mObPBdIPYW9V0aW9NqN2Eo+HEbN8b+SM43vlycaApPZWq9DJIjTAAKl48Pqmk
 WitbK/1gCK64Ob3V+w5tQYig==



=E5=9C=A8 2024/9/11 19:37, Neil Parton =E5=86=99=E9=81=93:
> SMART looks ok on all 4 drives
>
> btrfs-map-logical -l 313163116052480 /dev/sdc
> parent transid verify failed on 332196885348352 wanted 12747065 found 12=
747069
> parent transid verify failed on 332196885348352 wanted 12747065 found 12=
747069
> parent transid verify failed on 332196885348352 wanted 12747065 found 12=
747069
> ERROR: failed to read block groups: Input/output error
> ERROR: open ctree failed
>
> /dev/sdc is the drive that originally started giving tree and leaf
> errors 2 days ago so definitely looking to replace that with the new
> drive tomorrow once the scrub has completed.
>
> However the above map command for sda returns nothing, but for sdb and s=
dd:
>
> btrfs-map-logical -l 313163116052480 /dev/sdb
> parent transid verify failed on 332196960649216 wanted 12747071 found 12=
747073
> parent transid verify failed on 332196960649216 wanted 12747071 found 12=
747073
> parent transid verify failed on 332196960649216 wanted 12747071 found 12=
747073
> ERROR: failed to read block groups: Input/output error
> ERROR: open ctree failed
>
> btrfs-map-logical -l 313163116052480 /dev/sdd
> parent transid verify failed on 332197012652032 wanted 12747073 found 12=
747075
> parent transid verify failed on 332197012652032 wanted 12747073 found 12=
747075
> parent transid verify failed on 332197012652032 wanted 12747073 found 12=
747075
> ERROR: failed to read block groups: Input/output error
> ERROR: open ctree failed
>
> I'm guessing this is due to raid1c3 on the metadata?

Is the fs mounted? Or it means the fs is fully corrupted.

I'm not aware of any way to do the same chunk mapping with a mounted fs.

But since you're sure the problem is from sdc, then it should be fine.

Thanks,
Qu

>
> On Wed, 11 Sept 2024 at 10:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/11 19:08, Neil Parton =E5=86=99=E9=81=93:
>>> OK I have a new drive on the way which I was going to use to copy data
>>> on to, but will now replace /dev/sdc to be on the safe side.  SMART
>>> looks ok but don't want to go through this again!
>>>
>>> Maybe it was a bit flip?
>>
>> Nope, bitflip should not lead to a single mirror corruption, but all
>> mirrors corrupted.
>>
>> This looks more like that specific disk (mirror 2 of that logical
>> bytenr) is not fully following the FLUSH command.
>>
>> Thus some writes doesn't really reach disk but it still reports the
>> FLUSH is finished.
>>
>> Furthermore only two tree blocks are affected, which may just mean the
>> disk is only dropping part of the writes.
>> Or you should have at least 4 tree blocks (root, subvolume(s), extent,
>> free space trees) affected.
>>
>> This behavior will eventually leads to transid mismatch on a power loss=
.
>> It's the other mirror(s) saving the day.
>>
>> And before replacing the disk, please really making sure that
>> "btrfs-map-logical" is really reporting the mirror 2 is sdc, or you can
>> still keep a bad disk in the array.
>>
>>
>> Just keep running RAID1* for metadata, that's really a good practice.
>>
>> Thanks,
>> Qu
>>>
>>> On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/9/11 18:59, Neil Parton =E5=86=99=E9=81=93:
>>>>> dmesg | grep BTRFS
>>>>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b3522=
86
>>>>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
>>>>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b3522=
86
>>>>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
>>>>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b3522=
86
>>>>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
>>>>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b3522=
86
>>>>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
>>>>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
>>>>> 75c9efec-6867-4c02-be5c-8d106b352286
>>>>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
>>>>> checksum algorithm
>>>>> [    6.064064] BTRFS info (device sdc): use zstd compression, level =
3
>>>>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
>>>>> [    6.064092] BTRFS info (device sdc): using free space tree
>>>>> [   76.647420] BTRFS error (device sdc): level verify failed on
>>>>> logical 313163105075200 mirror 2 wanted 0 found 1
>>>>> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163105075200 (dev /dev/sdc sector 1145047360)
>>>>> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163105079296 (dev /dev/sdc sector 1145047368)
>>>>> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163105083392 (dev /dev/sdc sector 1145047376)
>>>>> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163105087488 (dev /dev/sdc sector 1145047384)
>>>>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
>>>>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
>>>>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
>>>>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
>>>>> [  260.968635] BTRFS error (device sdc): parent transid verify faile=
d
>>>>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
>>>>> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163116052480 (dev /dev/sdc sector 1145068800)
>>>>> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163116056576 (dev /dev/sdc sector 1145068808)
>>>>> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163116060672 (dev /dev/sdc sector 1145068816)
>>>>> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
>>>>> off 313163116064768 (dev /dev/sdc sector 1145068824)
>>>>
>>>> All happen on mirror 2.
>>>>
>>>> You can locate the device by:
>>>>
>>>> # btrfs-map-logical -l 313163116052480 /dev/sdc
>>>>
>>>> Which gives the device path.
>>>>
>>>> I would recommend to check the device's smart log and cables just in =
case.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
>>>>>>> Many thanks Qu, I appear to be back up and running but I also had =
to
>>>>>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
>>>>>>> super-recover said the superblock was fine.
>>>>>>
>>>>>> This is not expected. I believe btrfs-rescue should check log trees
>>>>>> before doing the operation.
>>>>>>
>>>>>>>
>>>>>>> On reboot and remount (as normal) I have a couple of residual tran=
sid
>>>>>>> errors and I'm currently running a full scrub to try and clean thi=
ngs
>>>>>>> up.
>>>>>>
>>>>>> Transid is also not expected, if the transid error persists, it's a=
 huge
>>>>>> problem.
>>>>>>
>>>>>> Does the transid only shows on certain mirrors?
>>>>>>
>>>>>> Anyway a full dmesg from the first transid mismsatch will help a lo=
t to
>>>>>> find out what's really going wrong.
>>>>>>
>>>>>> I hope it's really just the bad log trees.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> Hopefully though I'm back up and running, this is the longest the =
FS
>>>>>>> has been mounted in 48 hours without it reverting to ro!
>>>>>>>
>>>>>>> Can't thank you enough for your help. I hope I'm not premature in
>>>>>>> thanking you / will report back with any more errors.
>>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Neil
>>>>>>>
>>>>>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
>>>>>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives=
 in
>>>>>>>>> the array?
>>>>>>>>
>>>>>>>> Run it on any device of the fs.
>>>>>>>>
>>>>>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>>>>>>>>
>>>>>>>> And you must run the command with the fs unmounted.
>>>>>>>>
>>>>>>>>>      Reason I ask is when this first occurred it was one
>>>>>>>>> particular drive reporting errors and now after switching out ca=
bles
>>>>>>>>> and to a different hard drive controller it's a different drive
>>>>>>>>> reporting errors.
>>>>>>>>>
>>>>>>>>> It's also worth noting that this array was originally created on=
 a
>>>>>>>>> Debian system some 6-8 years ago and I've gradually upgraded the
>>>>>>>>> drives over time to increase capacity, I'm up to drive ID 16 now=
 to
>>>>>>>>> give you an idea.  Does that mean there are other gremlins poten=
tially
>>>>>>>>> lurking behind the scenes?
>>>>>>>>
>>>>>>>> Nope, this is really limited to that inode_cache mount option.
>>>>>>>> I guess you mounted it once with inode_cache, but kernel never cl=
eans
>>>>>>>> that up, and until that feature is fully deprecated, and newer
>>>>>>>> tree-checker consider it invalid, and trigger the problem.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
>>>>>>>>>>> btrfs check --readonly /dev/sda gives the following, I will ru=
n a
>>>>>>>>>>> lowmem command next and report back once finished (takes a whi=
le)
>>>>>>>>>>>
>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>> Checking filesystem on /dev/sda
>>>>>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>>>>>>>>>> [1/7] checking root items
>>>>>>>>>>> [2/7] checking extents
>>>>>>>>>>> [3/7] checking free space tree
>>>>>>>>>>> [4/7] checking fs roots
>>>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>>>> [6/7] checking root refs
>>>>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>>>>> found 24251238731776 bytes used, no error found
>>>>>>>>>>> total csum bytes: 23630850888
>>>>>>>>>>> total tree bytes: 25387204608
>>>>>>>>>>> total fs tree bytes: 586088448
>>>>>>>>>>> total extent tree bytes: 446742528
>>>>>>>>>>> btree space waste bytes: 751229234
>>>>>>>>>>> file data blocks allocated: 132265579855872
>>>>>>>>>>>        referenced 23958365622272
>>>>>>>>>>>
>>>>>>>>>>> When the error first occurred I didn't manage to capture what =
was in
>>>>>>>>>>> dmesg, but far more info seemed to be printed to the screen wh=
en I
>>>>>>>>>>> check on subsequent tries, I have some photos of these message=
s but no
>>>>>>>>>>> text output, but can try again with some mount commands after =
the
>>>>>>>>>>> check has completed.
>>>>>>>>>>>
>>>>>>>>>>> dump as requested:
>>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>>>                       refs 1 gen 12567531 flags DATA
>>>>>>>>>>>                       (178 0x674d52ffce820576) extent data bac=
kref root 2543
>>>>>>>>>>> objectid 18446744073709551604 offset 0 count 1
>>>>>>>>>>
>>>>>>>>>> This is the cause of the tree-checker.
>>>>>>>>>>
>>>>>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode=
 cache.
>>>>>>>>>>
>>>>>>>>>> Unfortunately that feature is no longer supported, thus being r=
ejected.
>>>>>>>>>>
>>>>>>>>>> I'm very surprised that someone has even used that feature.
>>>>>>>>>>
>>>>>>>>>> For now, it can be cleared by the following command:
>>>>>>>>>>
>>>>>>>>>>        # btrfs rescue clear-ino-cache /dev/sda
>>>>>>>>>>
>>>>>>>>>> Then kernel will no longer rejects it anymore.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>
>>>
>

