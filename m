Return-Path: <linux-btrfs+bounces-7933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5628974E31
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A001F284F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12517BB0D;
	Wed, 11 Sep 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wk0BJIaq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E817A922
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045847; cv=none; b=L04jYzVUYX8b5X6wOQG/c3b4XEx5D53UkaiFGDu6XEPH7On+N/eF+7qPTEfMrGkkzm0sEmlm0S4QH47R9CijL1K3ed5KIorgh8sMxLJW+rxIRbSLbnMyZdeyM4rYDqy4EIiq6S04PNN2WxT7oWeaiUHcm2nd3T2hdHx+onUfEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045847; c=relaxed/simple;
	bh=uRLAAZdrivpaqvdIRXsvDXVAU7HAbHPbDkXy1eS6fI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcfZEDhvC9rjxxHH8br+VyChBexRRTWLDM5r2XXs6mEff4VY7EFRa0rqrCgL/wUa8yI0/bFOwX21lGWg7fS6/wrU69GCUhONxCP5B7E6SXAQik5NVYjPh/3GqZiiQOEG0E4AZEvSVc2jhg0B3tGmNOIqQL0wdh9pEC7pbshMpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wk0BJIaq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726045841; x=1726650641; i=quwenruo.btrfs@gmx.com;
	bh=ln+5aXSwB+9Me00ZdEJ197QiqkUVgo+sivyS7VvfV9U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wk0BJIaqzpSZT9HiQoqw59XCvmKO9CiCvnb+5HR5+XYVz4ta9VgbxmtisKfGwKyQ
	 G4vuySg+KTA8yiQZce3ddnYRmojCu5RE0MWMklMY10QsVim+KhxSaHFtGOMA+tcJu
	 6lKmFa5DzlmwqkehUu0y76FAT7unDc4nOu1hIc5O0Q/Q3F5dUfh2yc7OQY6zAKH9y
	 xz6C6lx+buQfn8RqhsrU6teVWes52Zym5GUjuV2t2gml+2K1spaq8m7RVVcZz1oVc
	 34n/OngzjqwKA+scsa5WGeli1cI32hdlu1jdhQBg4iDlONV77Bl3pdW9hqa6UsBEK
	 Xs1iTsxX6WPgL2sK6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1sDshI04uT-00dbtD; Wed, 11
 Sep 2024 11:10:41 +0200
Message-ID: <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
Date: Wed, 11 Sep 2024 18:40:38 +0930
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
In-Reply-To: <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T41Er0P3iWJVFKJMAIt6CbQ+dGrLS+ESL1X6d/4etOZGVZu9tdm
 lUt2WaQ8mjtqCAbyyXAWLUEB9JsmQRJq9g1ZgKW6ZjG2FOUwDf3iowzSFqcRDt0yW5dPz0a
 QkZJfNFcMI5YyLdliCL4EboMUP9wR4UTauXWbYtnfTUM0IrKnXa0Ws0Obyz2rimBF3kiHxC
 NiUKCpR6VPvDloqKfpCjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G31Ipvm42CM=;MjmalVjUmIIBwQ0mc0oglHB9NOU
 UE/S1fJola61o380xQkteSKMVTq2tNTa7KPpMqt1H/rakygv2KoMixut4qPrWSq1hcsGvQETj
 jmwDPg9do4LsjZWXHB84kwHGgRW78VhBM8HvhANdjqaF1L/8/tahj8OScWyBs1dtvDmPObofJ
 LgdzEXLX7sdXAU2ae4Cp2yM4WjN4c/yX7hHDfPcCTUCwTSO7zWvndw64/6a+hENTWBAXRbgSb
 jZWyl1EKGJ7VyMBIF0flNalE+OTsuwY6wyDC2ZBZoHc9gZyLtwQnM6hkIjrKgJcPMAIovUMfT
 g9aMDd0qEo+sPDkY8oDAzZ+WtS1Dxc1LA1Uni7XqgY0PA53Azzwl3YqZV6asKP/Oy6+E4wta5
 rGwdHYgX2K9gF6/hxaOUzx0+AteORKtK9nGdwHLKSplB9jY2MdS8pEU+ZbmO/0p9Ukr30wppV
 wTd+oqis2WV/g0CSZFDNJ5QdJH6/c/h48/CUC+u7N6ea8N07iyBAZJLgwzBF51Q0hZW6RGkDt
 68sNThFx+cSzVxEW8LJOEUvEVGIsGc0sCmTKJUWehroeTKLxcEe7jW9F/5HmZ0g12ZL7r9sxU
 hjDbs7u4KWD6kT6Kn9Kk0vcR3A1roPCh0w7wqwvA3Y2zSq4kVsjMhXuZXTsbu83n/qkB4x0mX
 YUyei0DJKNf71WAiZx40GF2RkKD5NXFKBFb/qHCUWMhslf/EKC0pkIc4od9Ijzi/T2vczCbuY
 AYd0r2gKSQ4xy2v+pq1KZ6Yu/zepTQrn/3xXvLv7VxDiXyWmFluIo1bgH5K41ZgZirauZ/9Uv
 /0aZ8gfqYOxoqSuhoJ8WQ89w==



=E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
> Many thanks Qu, I appear to be back up and running but I also had to
> run 'btrfs rescue zero-log' to get rid of a superblock error.
> super-recover said the superblock was fine.

This is not expected. I believe btrfs-rescue should check log trees
before doing the operation.

>
> On reboot and remount (as normal) I have a couple of residual transid
> errors and I'm currently running a full scrub to try and clean things
> up.

Transid is also not expected, if the transid error persists, it's a huge
problem.

Does the transid only shows on certain mirrors?

Anyway a full dmesg from the first transid mismsatch will help a lot to
find out what's really going wrong.

I hope it's really just the bad log trees.

Thanks,
Qu
>
> Hopefully though I'm back up and running, this is the longest the FS
> has been mounted in 48 hours without it reverting to ro!
>
> Can't thank you enough for your help. I hope I'm not premature in
> thanking you / will report back with any more errors.
>
> Regards
>
> Neil
>
> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
>>> the array?
>>
>> Run it on any device of the fs.
>>
>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>>
>> And you must run the command with the fs unmounted.
>>
>>>   Reason I ask is when this first occurred it was one
>>> particular drive reporting errors and now after switching out cables
>>> and to a different hard drive controller it's a different drive
>>> reporting errors.
>>>
>>> It's also worth noting that this array was originally created on a
>>> Debian system some 6-8 years ago and I've gradually upgraded the
>>> drives over time to increase capacity, I'm up to drive ID 16 now to
>>> give you an idea.  Does that mean there are other gremlins potentially
>>> lurking behind the scenes?
>>
>> Nope, this is really limited to that inode_cache mount option.
>> I guess you mounted it once with inode_cache, but kernel never cleans
>> that up, and until that feature is fully deprecated, and newer
>> tree-checker consider it invalid, and trigger the problem.
>>
>> Thanks,
>> Qu
>>
>>>
>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
>>>>> btrfs check --readonly /dev/sda gives the following, I will run a
>>>>> lowmem command next and report back once finished (takes a while)
>>>>>
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/sda
>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space tree
>>>>> [4/7] checking fs roots
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>> found 24251238731776 bytes used, no error found
>>>>> total csum bytes: 23630850888
>>>>> total tree bytes: 25387204608
>>>>> total fs tree bytes: 586088448
>>>>> total extent tree bytes: 446742528
>>>>> btree space waste bytes: 751229234
>>>>> file data blocks allocated: 132265579855872
>>>>>     referenced 23958365622272
>>>>>
>>>>> When the error first occurred I didn't manage to capture what was in
>>>>> dmesg, but far more info seemed to be printed to the screen when I
>>>>> check on subsequent tries, I have some photos of these messages but =
no
>>>>> text output, but can try again with some mount commands after the
>>>>> check has completed.
>>>>>
>>>>> dump as requested:
>>>>>
>>>> [...]
>>>>>                    refs 1 gen 12567531 flags DATA
>>>>>                    (178 0x674d52ffce820576) extent data backref root=
 2543
>>>>> objectid 18446744073709551604 offset 0 count 1
>>>>
>>>> This is the cause of the tree-checker.
>>>>
>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache=
.
>>>>
>>>> Unfortunately that feature is no longer supported, thus being rejecte=
d.
>>>>
>>>> I'm very surprised that someone has even used that feature.
>>>>
>>>> For now, it can be cleared by the following command:
>>>>
>>>>     # btrfs rescue clear-ino-cache /dev/sda
>>>>
>>>> Then kernel will no longer rejects it anymore.
>>>>
>>>> Thanks,
>>>> Qu
>>>

