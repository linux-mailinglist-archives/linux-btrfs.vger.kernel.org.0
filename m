Return-Path: <linux-btrfs+bounces-8523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0698F88D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AB81C21C8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C32F1C242D;
	Thu,  3 Oct 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ljd3cH7j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F51C1ADE
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989559; cv=none; b=biJFybzvSxc+f747X6j6Tgd39W8CXKxIohbNmtIAHuf7mACR7v6lGGlvib8eG7aIQywPbsZv+mzU6GUbsCX/ejtISkobR0BMRN9sjXq2CAjjx0Gj80DQscXPPsAIgOhOSUUnwQCEZFV4ENEU1znsLZ/uJRMiwfl7GPJfkLhzS2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989559; c=relaxed/simple;
	bh=tk5er89+NIu0HFYEBfZZgj6UgJos+/RMsyuXz2E7pls=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jhDzndauErFh4DwtxzdYsJQKio0lji/n/7L5EHQNyzQeif2xWdpOtQGPqXfhULvWK7HfnxFSHeu78ipdAuDREoyYnlMoEn0L45XY9TymzMyN90YEgt3zRgOfbc0hG/1Chm7ppdsttKG97ehzqCO/ZDIbYyDWWlPXdGlmtr+8CYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ljd3cH7j; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727989553; x=1728594353; i=quwenruo.btrfs@gmx.com;
	bh=9vKB6W/qyqKpvFHb7bcElbWkUdluAl5Q8KmStBEFqJI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ljd3cH7jJj9VEMDCexuf6oxGMIsEB1ABSsUyLIFWDMiIw1m28yfjlbwSXKM47N5L
	 Fw94EHNq38m5dMrH54QnNWlmM42aVa4fPbjRkEcDStokfoxEPI7NCMDRnw8lvUDEF
	 UO94TIl89HcOSFznpX2JGNwvatZTgQVVYBW8apBTa472qS/USy17McDPxYq1ZLSZx
	 XIz9DDYKdfApSTc2qZYYWwl3xL4LAmotz6eMC5slZfERG3quiZYG/sh3ynI17EEyo
	 FuzbYewnh+RwuUYryj++WIFHZDTxUv//VaX4o+mUjmI8BNAWqCL3QkEiZFm5v66bO
	 5USiGRnqLRSoy4SmIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1sbMjd0z5Z-00OkRE; Thu, 03
 Oct 2024 23:05:52 +0200
Message-ID: <eec16f9c-b201-484b-bc28-109787b08217@gmx.com>
Date: Fri, 4 Oct 2024 06:35:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
To: "cwalou@gmail.com" <cwalou@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
 <e5612dd9-1c9d-4a77-9dfe-9e06716f718d@gmail.com>
 <b0a4945d-92a0-4ea2-a82e-969670526dda@suse.com>
 <43b709da-339d-4ed5-af7a-59d8916366be@gmail.com>
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
In-Reply-To: <43b709da-339d-4ed5-af7a-59d8916366be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1DUI9fC01UV3M01WsKoh67uSqfcnlRwOayBbSjPyITMY82fzUua
 +hlvcZe3OJtenA69fo5KvayiDYCsH8cZof70yJ580H/S22GNYAcdjimGImILWX/9iLYjTqX
 2nwDCIJcHyfPa+pNaw0DJVR9Q42T1wEyOryEOwvUjMmwrut6xl149Hh1eA1N0tJI1KwUiZv
 ZAAlHGyID+1dn+bfpbZww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0HvBslewfRY=;432rnah/aFiguRKI7XbCNt546rt
 bWh9k4SQTouwlcMIW0GGDBQwK0W778Yx3t4sHHnXXoZHqiSWfh+g267GNF1ud0OihX8BpldnY
 vcWu577vQqctcEaN7/6rrjlfcCHSNlFaOecoEkqn7VHeZru7/65Xw7kRziFPepDLn1xbUETuh
 NXluK52EWwC83dnTMs/bakHPKlIsyBwVcnnmNp8spd491uadIF8r2JJyEb+qQbO73nIFvFOsy
 tV9V/1FOR85wB851xXFyi+C2JKvFvtjxLwiojpKU/9BsPYre2lU663rNnBrac/po9DEEb5ZW4
 oC0RJ83W4b3PFbhS+PJFJokMRKKMWis18KMeLQ9c/KdxuG5RyyMX4+9NvobdTu3gHfbxHSfCJ
 R9XfY2PXpXkmqwDFFXuMP6fFVM4n3sLahSIL3porm2b1S12HO4lvnrRG6sjAXfqRct7j2sG7+
 sTyF4YH0SM8xFul3N+HcEfL90J3FuR0CL73YZje954hUFBTJq6EfbZBDjzy+iwelDGoXaYIcf
 gU1yJMJuO2cJJoOWNbkHTL47YqKDuqZP3s9HTdeiiyvZrR2oCy/k24x+xzQXbAIdGduRPyQVD
 66JWWVS0BX5XPbjD8r4wFmbPSdaqx3sBZp9Hfug5foSBKnoWAL/scgadiA8aBEBFI5N7TdMd4
 sx55+JteYXH3q/AqqAJjPn6mJ6O2uZkBauIbzB6DhLM/69mL8sK7wdwsvhJY/OArie0GsHJtb
 rlAKgLCeaJ9h6TH9olxMCo8E6zCLZLZSAwigHwnBcm8+SVPTw6tXwh1FGzABvARhfA6zL4ha5
 pMov87ThFcNbCrqGf4E+u5TA==



=E5=9C=A8 2024/10/3 20:02, cwalou@gmail.com =E5=86=99=E9=81=93:
> Le 03/10/2024 =C3=A0 12:12, Qu Wenruo a =C3=A9crit=C2=A0:
>>
>>
>> =E5=9C=A8 2024/10/3 18:50, cwalou@gmail.com =E5=86=99=E9=81=93:
>>> Le 03/10/2024 =C3=A0 10:08, Qu Wenruo a =C3=A9crit=C2=A0:
>>>>
>>>>
>>>> =E5=9C=A8 2024/10/3 17:02, cwalou@gmail.com =E5=86=99=E9=81=93:
>>>>> Hello.
>>>>>
>>>>> A 4TB drive taken out of a synology NAS. When I try to mount it, it
>>>>> won't. This is what I did :
>>>>
>>>> Synology has out-of-tree features that upstream kernel doesn't suppor=
t.
>>>>
>>>> Please ask the vendor for their support.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> Thank you for your answer.
>>>
>>> Just for my general knowledge, can you explain me what "out-of-tree
>>> features" means ?
>>
>> Out-of-tree means it's not merged into the upstream Linux kernel.
>>
>> Furthermore, they do not even bother to put a special compat-ro/
>> incompact flags into the super block.
>>
>> So upstream kernel will not even know the fs has unsupported features,
>> until the tree-checker checks the inode flags.
>>
>> Thanks,
>> Qu
>>
>
> Before I start a quest at Synology.
> Is there any way to get around the "can't read superblock on /dev/
> mapper/vg1000-lv." problem?
>
> I mean, is there an option I can pass to 'mount' to skip superblock
> check? Or is there a way to tell him a superblock is available at
> "65536" ("67108864" or "274877906944" which "btrfs rescue super-recover
> -v" tells me are good, see below) ?

The problem is not superblock, but the extra inode flags introduced:

Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS critical
(device dm-0: state C): corrupt leaf: root=3D257 block=3D2691220668416
slot=3D0 ino=3D6039235, unknown incompat flags detected: 0x40000000
Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS error
(device dm-0: state C): read time tree block corruption detected on
logical 2691220668416 mirror 1

So far there is no way to disable tree-checker (the sanity checks), as
it brings so many benefits that we can not ignore.

>
> My apologies if my questions seem naive. But file systems and storage
> media are not really my specialty. I'm just trying to help an
> acquaintance who has been diligently backing up his data but is now
> stuck restoring his data.
>
> I think if we solve this problem on this public list, it may help more
> people. That's why even I need to ask synology for help, I'll give
> feedback here.

Unfortunately, to the fs those unknown flags can also be an indicator of
bitflip, thus tree-checker rejects anything that it can not understand.

Considering how frequently those hardware memory bitflips are reported,
we do not provide a way to disable such comprehensive checks.

So this means any new feature introduced by non-upstream contributor
will be rejected, even if most of the fs can still be understood by
upstream kernel.

Thanks,
Qu
>
> Nevertheless, thank you for the answers you already gave me, for taking
> the time to answer me.
>
>>>
>>> I'll ask synology what's happening. Once I'll find a solution (if one
>>> day I find one) I'll let know here.
>>>
>>> Kind regards,
>>>
>>> Walou.
>>>
>>>
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# fdisk -l /dev/sda
>>>>> Disk /dev/sda: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
>>>>> Disk model: 001-2MA101
>>>>> Units: sectors of 1 * 512 =3D 512 bytes
>>>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>>>> Disklabel type: gpt
>>>>> Disk identifier: B7B80A4B-0294-44FD-A368-74B0455D6AF2
>>>>>
>>>>> Device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Start=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 End=C2=A0=C2=A0=C2=A0 Sectors=
=C2=A0=C2=A0 Size Type
>>>>> /dev/sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8192=C2=A0=C2=A0=
 16785407=C2=A0=C2=A0 16777216=C2=A0=C2=A0=C2=A0=C2=A0 8G Linux RAID
>>>>> /dev/sda2=C2=A0=C2=A0=C2=A0 16785408=C2=A0=C2=A0 20979711=C2=A0=C2=
=A0=C2=A0 4194304=C2=A0=C2=A0=C2=A0=C2=A0 2G Linux RAID
>>>>> /dev/sda5=C2=A0=C2=A0=C2=A0 21257952 1965122911 1943864960 926.9G Li=
nux RAID
>>>>> /dev/sda6=C2=A0 1965139008 7813827135 5848688128=C2=A0=C2=A0 2.7T Li=
nux RAID
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# lsblk
>>>>> NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 MAJ:MIN RM=C2=A0=C2=A0 SIZE RO TYPE=C2=A0 MOUNTPOINTS
>>>>> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 3.6T=C2=A0 0 dis=
k
>>>>> |-sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 8G=C2=A0 0 part
>>>>> |-sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 2G=C2=A0 0 part
>>>>> |-sda5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0 926.9G=C2=A0 0 part
>>>>> | `-md2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
9:2=C2=A0=C2=A0=C2=A0 0 926.9G=C2=A0 0 raid1
>>>>> |=C2=A0=C2=A0 `-vg1000-lv 252:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 3.6T=
=C2=A0 0 lvm
>>>>> `-sda6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8:6=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 2.7T=C2=A0 0 part
>>>>> =C2=A0=C2=A0 `-md3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 9:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 2.7T=C2=A0 0 raid1
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 `-vg1000-lv 252:0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0 3.6T=C2=A0 0 lvm
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# cat /proc/mdstat
>>>>> Personalities : [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
>>>>> md3 : active (auto-read-only) raid1 sda6[1]
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2924343040 blocks super 1.2 [2/=
1] [_U]
>>>>>
>>>>> md2 : active raid1 sda5[3]
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 971931456 blocks super 1.2 [2/1=
] [U_]
>>>>>
>>>>> unused devices: <none>
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# lvm pvscan
>>>>> =C2=A0=C2=A0 WARNING: PV /dev/md2 in VG vg1000 is using an old PV he=
ader, modify
>>>>> the VG to update.
>>>>> =C2=A0=C2=A0 WARNING: PV /dev/md3 in VG vg1000 is using an old PV he=
ader, modify
>>>>> the VG to update.
>>>>> =C2=A0=C2=A0 PV /dev/md2=C2=A0=C2=A0 VG vg1000=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lvm2 [926.90 GiB / 0=C2=A0=C2=A0=C2=A0 f=
ree]
>>>>> =C2=A0=C2=A0 PV /dev/md3=C2=A0=C2=A0 VG vg1000=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lvm2 [2.72 TiB / 0=C2=A0=C2=A0=C2=A0 fre=
e]
>>>>> =C2=A0=C2=A0 Total: 2 [<3.63 TiB] / in use: 2 [<3.63 TiB] / in no VG=
: 0 [0=C2=A0=C2=A0 ]
>>>>>
>>>>> root@user-NUC10i7FNH:~# lvm vgscan
>>>>> =C2=A0=C2=A0 WARNING: PV /dev/md2 in VG vg1000 is using an old PV he=
ader, modify
>>>>> the VG to update.
>>>>> =C2=A0=C2=A0 WARNING: PV /dev/md3 in VG vg1000 is using an old PV he=
ader, modify
>>>>> the VG to update.
>>>>> =C2=A0=C2=A0 Found volume group "vg1000" using metadata type lvm2
>>>>>
>>>>> root@user-NUC10i7FNH:~# lvm lvscan
>>>>> =C2=A0=C2=A0 WARNING: PV /dev/md2 in VG vg1000 is using an old PV he=
ader, modify
>>>>> the VG to update.
>>>>> =C2=A0=C2=A0 WARNING: PV /dev/md3 in VG vg1000 is using an old PV he=
ader, modify
>>>>> the VG to update.
>>>>> =C2=A0=C2=A0 ACTIVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 '/dev/vg1000/lv' [<3.63 TiB] inherit
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# mount -t btrfs -o rescue=3Dall,ro /dev/
>>>>> vg1000/lv /
>>>>> mnt/test/
>>>>> mount: /mnt/test: can't read superblock on /dev/mapper/vg1000-lv.
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# ll /dev/vg1000/lv /dev/mapper/vg1000-lv
>>>>> lrwxrwxrwx 1 root root 7 oct.=C2=A0=C2=A0 2 17:34 /dev/mapper/vg1000=
-lv -
>>>>> > ../dm-0
>>>>> lrwxrwxrwx 1 root root 7 oct.=C2=A0=C2=A0 2 17:34 /dev/vg1000/lv -> =
../dm-0
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# tail log/kern.log
>>>>> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.255079] BTRFS: d=
evice
>>>>> label 2017.12.01-16:57:32 v15217 devid 1 transid 15800483 /dev/mappe=
r/
>>>>> vg1000-lv scanned by mount (2939)
>>>>> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257012] BTRFS in=
fo
>>>>> (device dm-0): first mount of filesystem
>>>>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>>> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257061] BTRFS in=
fo
>>>>> (device dm-0): using crc32c (crc32c-intel) checksum algorithm
>>>>> Oct=C2=A0 2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257079] BTRFS in=
fo
>>>>> (device dm-0): disk space caching is enabled
>>>>> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS cr=
itical
>>>>> (device dm-0: state C): corrupt leaf: root=3D257 block=3D26912206684=
16
>>>>> slot=3D0 ino=3D6039235, unknown incompat flags detected: 0x40000000
>>>>> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS er=
ror
>>>>> (device dm-0: state C): read time tree block corruption detected on
>>>>> logical 2691220668416 mirror 1
>>>>> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654160] BTRFS cr=
itical
>>>>> (device dm-0: state C): corrupt leaf: root=3D257 block=3D26912206684=
16
>>>>> slot=3D0 ino=3D6039235, unknown incompat flags detected: 0x40000000
>>>>> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654189] BTRFS er=
ror
>>>>> (device dm-0: state C): read time tree block corruption detected on
>>>>> logical 2691220668416 mirror 2
>>>>> Oct=C2=A0 2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654337] BTRFS in=
fo
>>>>> (device dm-0: state C): last unmount of filesystem
>>>>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# btrfs rescue super-recover -v /dev/vg1000/lv
>>>>> All Devices:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device: id =3D 1, n=
ame =3D /dev/vg1000/lv
>>>>>
>>>>> Before Recovering:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [All good supers]:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device name =3D /dev/vg1000/lv
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 superblock bytenr =3D 65536
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device name =3D /dev/vg1000/lv
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 superblock bytenr =3D 67108864
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device name =3D /dev/vg1000/lv
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 superblock bytenr =3D 274877906944
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [All bad supers]:
>>>>>
>>>>> All supers are valid, no need to recover
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# btrfs rescue zero-log /dev/vg1000/lv
>>>>> Clearing log on /dev/vg1000/lv, previous log_root 0, level 0
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# btrfs check /dev/vg1000/lv
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/vg1000/lv
>>>>> UUID: 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>>> ignoring invalid key
>>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>>> [...line repeated many times
>>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>>> ignoring invalid key
>>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>>> ignoring invalid key
>>>>> [3/7] checking free space cache
>>>>> [4/7] checking fs roots
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>> found 2726275964928 bytes used, no error found
>>>>> total csum bytes: 839025944
>>>>> total tree bytes: 3015049216
>>>>> total fs tree bytes: 1991966720
>>>>> total extent tree bytes: 95895552
>>>>> btree space waste bytes: 555710555
>>>>> file data blocks allocated: 3567579688960
>>>>> =C2=A0=C2=A0referenced 2977409900544
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# btrfs property get /dev/mapper/vg1000-lv
>>>>> label=3D2017.12.01-16:57:32 v15217
>>>>>
>>>>>
>>>>> root@user-NUC10i7FNH:~# btrfs version
>>>>> btrfs-progs v5.16.2
>>>>>
>>>>>
>>>>> The most surprising is that on a Windows 10, "DiskInternals Linux
>>>>> Reader" (a paid software) shows me the content of this disk (and
>>>>> asks me
>>>>> to pay for copying the data).
>>>>>
>>>>>
>>>>> Any idea ?
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>


