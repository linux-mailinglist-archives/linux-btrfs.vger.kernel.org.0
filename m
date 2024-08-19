Return-Path: <linux-btrfs+bounces-7312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CEB95632F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 07:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C91B2203B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 05:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FBB14B945;
	Mon, 19 Aug 2024 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gMJicTi3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A9DDDC
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045380; cv=none; b=bmU/wZFgNjnx3kJ6qwyQANM2We+8VYy5FSoWWTG8npr3YQEvV2IPgkLgJXif3xQ9EZBkFegRisHp+Rse9AmJCsYsdj9TXvL/0rPZUN9UbVYJHJJc0T78tlloQ8Qbxvu3wHuXM4Z2WrcwN5k7K2QdLhFVBzK88VApQY9tOPcW5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045380; c=relaxed/simple;
	bh=C6fGt6qXKj2+J7zOxLVRpC5QrJXVOnNRbm8uc2LmgYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f8qvOCsP4m3JUGuEN+BVdgL2WFmSftBA0X1bkFEk9ezyBtZ8KZw+uEEKzVxSYx68dLR2IReO1nlrtlzPXTNJI4rG553X4rv0dPLwsFQk8sBdJIi6VNCaubHW611Sk2BY9GxVhbJ+nCWR5vMu+kf0NBIxcbgayoqNRbyaTxDzRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gMJicTi3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724045375; x=1724650175; i=quwenruo.btrfs@gmx.com;
	bh=9CAi96o64pn+uXOWoqBn30hxy8zIKC3rZU/ECYUYZUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gMJicTi3ZVnusFioCVZU41nLZjmqHZwEsToE9s9mwLV8s6g9LUsSC2vDPtMzQUka
	 MG7LbnmGf2Jtb3EJpd4k4PDA+o9AyRsaaqBYUHS9/PGjaZQQ86qzrHkWASToY0dgH
	 kmp1egE+MXnQ9rARAzYebLg6QEP2ymwQz84VngvYnxuzBIpAJ28bH5irVte9QVDJr
	 ShI1xckU3wG9/0963Zwj24E7WCBm8jI7YGPEGqwWfOgh6/NZjh/C4u28A7mbryRc5
	 6fw3yAHDAtDX2z3c++xoGUPupEGYxaaGYa2qXUMDtATcegI0WxQfVsCXX8VZjuyWN
	 nxAR3lqr0P93R8Q7Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VHG-1s3m7g2Y26-011mIr; Mon, 19
 Aug 2024 07:29:35 +0200
Message-ID: <33f0ecec-585d-4a02-a8a5-319759401e5f@gmx.com>
Date: Mon, 19 Aug 2024 14:59:31 +0930
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
 <1e96ef22-b51d-488a-ab90-84fd85c981ea@gmx.com>
 <ad8a9333-8732-4d78-a86b-22dea00aabbe@horse64.org>
 <716c3de3-63be-420e-b11e-cfd3eab9aea9@gmx.com>
 <78b10401-1366-4551-9e5f-4c480baa0727@horse64.org>
 <bf24d64d-9bf7-48ad-9a36-7ae7d262a6b8@horse64.org>
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
In-Reply-To: <bf24d64d-9bf7-48ad-9a36-7ae7d262a6b8@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KiLEfPjFCDeGgMGhCu+jb32IBc0xywvK0lr5OepSfZNKMeM2TkZ
 dgo2klhVZipL18WfLF3i7rzrmEOqJEVvdqY7CMfFJnwzfiOqwmrdmsvun1vbmtr/4F1hmtR
 PgHz3uqgpS+eXa2k6+STQnENZazvtmJSJ4SWMG4G4619NAyi0+nC6aBiY/2u8t7u7Mb/uJY
 uTBx3BYDQgVfObIWpe/eQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A2d5Kf/8mxk=;andLC0fqgq3mQ74liG7a9pQ/+Kl
 qIdErm4/N7zzNFcUnXMFPkvR8Y6MHoG3yehQgSY7yNwho3LYCXuKJu/llmWirD6tvDXYtbUr6
 xdjj0M0I7ths+jEbI5bjmcTSSonzom30yhUT9Yv3x0XQ1gWz+kuEqy8IxTYBCAtl+21BZSWkG
 4irEqaLc8bSLzrwRWN/3yS7cZKRXyqQTHpQM1WwCyjSvMMQgZh06yCbrHmVvds7tyYj8rXaX5
 KsTg69OjJdZiGrkTfzbTdkSXflqISjKPcl62zHd2cltQ+PzjdUbGuOC67xMq36+H1yrbN0nJp
 nFF4N37kPil+2HHSn7Yu5pGIv2PquCbW/fP7RSu4UqnPVWyytKoHpxLsaM2H5BniDJtRECf/H
 fbAB3JZUq4NxIv/p6JC+WxjF/63UMLsGfxdHTgH4EVPy3EPtbvDDytB7eUpkvsCz4to8QevF6
 aDNUW8yjI8V1daXVo9HXdhjJo78ts60EfTWOCH12q4fBWFfGhi3GjlPRgRk8e5IPgI3d9EVqc
 G1M5rwOs5K1Ku7X7vx1zz7aeNW5FqkZAEagKX/8c4BwMIDvZU2+zMma2cUBSkiFCi0aa14xzq
 3sijBAkxQlZ0yKIZ5oF1tpd3r7bAHrl8bLzwjEtoTakFyYkqzuX3OsbCZ6F+Dv0h/RRfe2MLa
 zVGFRXcS+IXvD8Dg7uN0SrA+SawjOU/CbXTWr0rbEtkhmoOSMiY24IYCFHDd4UHGXI1XdUJ7U
 H1Hr/WQW9u3r3x8OO8QoIGxxTKdzZtrjjLMl6rlWe7NQVXtZU9YrHSwkZ2iz3aWKU9Z3mnpcI
 AbyfCYykoKAb6vDzgwQ4XWnA==



=E5=9C=A8 2024/8/19 13:28, ellie =E5=86=99=E9=81=93:
> Is there something else I could provide to help track this down? I
> assume just because the file contents happen to be fine, doesn't mean
> there wasn't corruption, like for example in the metadata. My apologies
> for taking up your time.

This means, by somehow the data checksum is incorrect.

This doesn't sound sane to me, so I can only come up two possible reasons:

1. The checksum algorithm on the platform is insane
    IIRC the SOC is pretty mature (although it also means old), this
    doesn't sound possible to me.

2. Memory hardware is incorrect
    Thus causing bitflip for data csum.

Other than above two reasons, I can not come up with other reasons
unfortunately.

Thanks,
Qu

>
> Regards,
>
> Ellie
>
> On 8/8/24 13:31, ellie wrote:
>> On 8/6/24 23:55, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2024/8/7 01:32, ellie =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> On 8/5/24 08:34, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2024/8/5 15:50, ellie =E5=86=99=E9=81=93:
>>>>>>
>>>>>>
>>>>>> On 8/5/24 08:10, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> =E5=9C=A8 2024/8/5 15:25, ellie =E5=86=99=E9=81=93:
>>>>>>>> On 8/5/24 07:39, ellie wrote:
>>>>>>>>> Dear kernel list,
>>>>>>>>>
>>>>>>>>> I'm hoping this is the right place to sent this. But there seems
>>>>>>>>> to be
>>>>>>>>> a btrfs corruption issue on the Pine64 PinePhone:
>>>>>>>>>
>>>>>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>>>>>>>>
>>>>>>>>> The kernel is 6.9.10, I wouldn't know what exact additional
>>>>>>>>> patches
>>>>>>>>> may be used by postmarketOS (which is based on Alpine). The
>>>>>>>>> device is
>>>>>>>>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wik=
i/
>>>>>>>>> PinePhone#Hardware_revisions sadly there doesn't seem to be a
>>>>>>>>> way to
>>>>>>>>> check in software if it's 1.2a or 1.2b, and I don't remember whi=
ch
>>>>>>>>> it is.
>>>>>>>>>
>>>>>>>>> This is on an SD Card, so an inherently rather unreliable storag=
e
>>>>>>>>> medium. However, I tried two cards from what I believe to be two
>>>>>>>>> different vendors, Lexar and SanDisk, and I'm seeing this with
>>>>>>>>> both.
>>>>>>>>>
>>>>>>>>> The PinePhone had various chipset instability issues before, lik=
e
>>>>>>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I
>>>>>>>>> believe
>>>>>>>>> has however been fixed since. I have no idea if that's
>>>>>>>>> relevant, I'm
>>>>>>>>> just pointing it out. I also don't know if other filesystems, li=
ke
>>>>>>>>> ext4 that I used before, might have also had corruption and just
>>>>>>>>> didn't detect it. Not that I ever noticed anything, but I'm not
>>>>>>>>> sure I
>>>>>>>>> necessarily ever would have.
>>>>>>>
>>>>>>> In the detailed report in pmOS issue, you mentioned it's a video
>>>>>>> file.
>>>>>>>
>>>>>>> I'm wondering if all the corruptions you see are from video files,
>>>>>>> especially if the video files are all recorded on the file.
>>>>>>>
>>>>>>> If that's the case, it may be related to the IO pattern,
>>>>>>> especially if
>>>>>>> the recording tool is using direct IO and didn't have proper
>>>>>>> writeback
>>>>>>> wait for those direct IO.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>
>>>>>> Thanks so much for the quick input!
>>>>>>
>>>>>> All the files I mentioned in bug reports were written by
>>>>>> syncthing, so
>>>>>> there wasn't any on-device video recording involved. I once saw
>>>>>> Nheko's
>>>>>> database file corrupt however, so it's apparently not limited to
>>>>>> syncthing. I'm guessing video files are affected so often simply
>>>>>> due to
>>>>>> their large size.
>>>>>
>>>>> I did a quick clone and search of syncthing.
>>>>>
>>>>> There is no usage of O_DIRECT directly, so I guess it's not the know=
n
>>>>> csum mismatch caused by bad sync of direct IO writeback.
>>>>>
>>>>> In that case, since the corrupted file is syncthing synchronized, ca=
n
>>>>> you do a diff of the binary data?
>>>>>
>>>>> To avoid the EIO from btrfs, you can use "-o rescue=3Dall,ro" to
>>>>> mount the
>>>>> sdcard on another system, then compare the binary.
>>>>> (e.g. "xxd file.good > good.xxd; xxd file.bad > bad.xxd; diff *.xxd"=
)
>>>>>
>>>>> At this stage, we need to find out what's really causing the problem=
,
>>>>> the btrfs itself or some thing lower level.
>>>>> (I strongly hope it's not btrfs, but either way it's not going to
>>>>> end up
>>>>> well)
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>> Thanks for your detailed instructions! I was about to do as you said
>>>> and
>>>> ran the sync for a few hours, stopped it, and planned to run btrfs
>>>> scrub
>>>> this evening. However, I then ran into a hard shutdown due to what
>>>> might
>>>> be an upower bug (won't lie, was very annoyed at that point):
>>>>
>>>> https://gitlab.com/postmarketOS/pmaports/-/issues/3073
>>>>
>>>> Should I still attach a diff for an affected file I find now? Or are
>>>> the
>>>> results going to be worthless if there was a hard shutdown in between=
,
>>>> and I need to first fix the filesystem, repeat the sync test, and
>>>> repeat
>>>> finding a new corruption error to diff?
>>>
>>> As long as you didn't touch those files, and scrub still reports error=
s
>>> on that file, the diff is still very helpful to provide some clue.
>>>
>>
>> I finally had a new corrupted file pop up, this was actually after any
>> unintended sudden shutdown so there shouldn't be any interference from
>> that:
>>
>> [128958.860335] BTRFS error (device dm-0): unable to fixup (regular)
>> error at logical 133906497536 on dev /dev/mapper/root physical
>> 135089684480
>> [128958.862548] BTRFS warning (device dm-0): checksum error at logical
>> 133906497536 on dev /dev/mapper/root, physical 135089684480, root 257,
>> inode 331715, offset 102400, length 4096, links 1 (path: ellie/Music/
>> Baldur's Gate (2) II Shadows of Amn (2000)/06 City Gates.mp3)
>>
>> However, when manually mounting the file on the computer where it
>> originates from and where the undamaged original file is:
>>
>> /mnt # mount -t btrfs -o rescue=3Dall,ro,subvol=3D/@home,defaults /dev/
>> mapper/blamap p64
>> /mnt # ls p64/
>> ellie
>> /mnt # cp p64/ellie/Music/Baldur\'s\ Gate\ \(2\)\ II\ Shadows\ of\
>> Amn\ \(2000\)/06\ City\ Gates.mp3 ./
>> /mnt # diff 06\ City\ Gates.mp3 /home/ellie/Music/Baldur\'s\ Gate\
>> \(2\)\ II\ Shadows\ of\ Amn\ \(2000\)/06\ City\ Gates.mp3
>> /mnt # diff 06\ City\ Gates.mp3 /home/ellie/Music/Baldur\'s\ Gate\
>> \(2\)\ II\ Shadows\ of\ Amn\ \(2000\)/06\ City\ Gates.mp3
>> /mnt #
>>
>> It seems like file is exactly the same, which I assume isn't meant to
>> happen.
>>
>> I'm not sure what that implies, but I hope it's helpful info!
>>
>> Regards,
>>
>> Ellie
>>
>

