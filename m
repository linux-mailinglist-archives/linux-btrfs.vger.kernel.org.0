Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C682E1075
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 00:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLVXDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 18:03:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:37003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgLVXDt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 18:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608678135;
        bh=u7vqqoP80uIANq0UxpJ6Xbkaz+LSEPnHQ17BxzglKGQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jKyvGo/oyLakLne/9WidJIjEaEwRLXU9jCEoRaXSpDXCnisp0tAHKaqHvj7fKHFX/
         Aa8JIR2Eqi7PsQrRK7IL5X1mJdSj/+jiODfi10kxSaxisC+DW2U1LrtOUH4CaQjZA8
         VRf57ZSTueptTpn8vyJwMueYzxC2piMBrBu/3Y1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQ5rO-1keYyM1aJk-00M6Eb; Wed, 23
 Dec 2020 00:02:14 +0100
Subject: Re: Fwd: "BTRFS critical: ... corrupt leaf" due to defective RAM
To:     "Nik." <btrfs@avgustinov.eu>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6f36a628-21f9-ca21-bae3-2a4150245ec2@avgustinov.eu>
 <0e4cb41f-c1bf-539a-dc19-8df234e0d0e7@avgustinov.eu>
 <296aa513-1ac8-2242-b7fa-1aa082a6e554@gmx.com>
 <67ee3588-b18b-c9aa-5f33-ae7bbde10e7c@avgustinov.eu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <eb2b2f6b-2747-6635-b437-7e089505b59e@gmx.com>
Date:   Wed, 23 Dec 2020 07:02:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <67ee3588-b18b-c9aa-5f33-ae7bbde10e7c@avgustinov.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FZYbfWaNOGUMshsfKcjhdy35ACberrkTGtCjcCMA155wNZSKOmV
 EqTvvvC7wc2l4ekd8qcQgPveRs6owqTjK8EoPxkCWBUoT3pS2+9lUii0wQm1RWu8M8qmQip
 G3adj+1F7P/QbbO0rsREdh924tf6vdHBGK8qoe0MYb6z72S72hHrxFbuqO7Yr52oEMh2/BL
 /CEV4PUxq8FhqkIMDP+Jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xyqAeRrd/iQ=:B0qzTme0t/adhGCAvrpcUJ
 qv+lbOzScS3HDZQkDo4huA4VT304wjtTQf5V8srWWVJ6nNh9mPgKKgAENbpYZ5atTuEQTxgjU
 iFVJOWtwl7g54pT6lLa8Rwbz3kWUDnrJshB1e1XWOPFx9ft6l2pZbAXp3hL1ec65PnEWsUjE1
 vgUpG3MZzgeR704tVrpouu81QF7vnUtZDFLLdXJgrHLsP+am7erodApJjGZnVdgQ+k+ZBQMF7
 x2taJfUQwJOYbPsODPb8hCf6AbJFYfKDiJgbqjO5Cn0coo7mRPdEGOt7/WOVRBXrecaLzmwWH
 A/B5R4+W8BAKhUXpDRXrcUyEsW3O5+DimXTqkI32Jinve7wNZ1jCS58YumUAJv1urahyEgGDX
 pWepmthnYf4Hw5t9akM4rG3rjiiACYlINwIN8amZklkEP2VcpwzBiUR3Se75oyT2XBkNUM2/0
 Kj9/X2HyIE3QDaU/+Q7E1/z8+hbSexUqo6nfIitp3UYJsYnPjbff//VsTw0n8xGXZZb0MzYEW
 tJ4e76FrADGkoPe8kZwzhFNkRLpFUXTFrfkEPjpoK1HiQOuEDRxgZpZNk+DmuFuf3+ybRdBGK
 +WQV7SXweDFkqIcN9gVlng3ajTpNz9LX11SFwp2eyCD4bPWFEQvd0S4Bs806JPIMNQEwrd4KB
 kb/ce13OhxHD4Gb0ZXTPDLbz1GJyg1kVWCUC9QTkSnwzsG2hJ4UhIXSLG0WnQgK/WDpV2cw69
 ophaG2eNN2wTs1CWJXrFJOiSHSfvv8Xp2IAzJnWUvGzQ7VzbJ4L47u527nbBMNXO6KW25dQpY
 2kwugndBvGFmLUg1autE58ew5jpVDdaPEZ16XaIbT7RbjjER+kYqH1Om+BsRwjQJJvc0SDEZJ
 OK/zYE1YcZ5qvGqTAUBQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/22 =E4=B8=8B=E5=8D=8811:59, Nik. wrote:
> Hi,
>
> Thank you very much for the quick reply.
> Ok, I am going to use the backups (as you suggested).
>
> Just a quick question for understanding the background better:
>  =C2=A0 -given a btrfs with many intact subvolumes and
>  =C2=A0 -say, one defective sector within the subvolume "@" (Ubuntu spec=
ific),
>  =C2=A0=C2=A0 which couses this subvolume to be (automatically) remounte=
d as RO
>  =C2=A0 -am I getting it right that none of the other subvolumes can be
> mounted properly (i.e., RW)?

Unfortunately, it's not subvolume tree itself get corrupted, but the
extent tree.

Extent tree is shared through the whole fs, thus you may still be unable
to mount other subvolumes as long as it involves reading the extent tree.

> Woildn't it be interesting to have an
> option, allowing this to work?

We have new rescue=3D mount options, IIRC we have rescue=3Dall, which will
try to ignore any non-critical trees.

In that case, you may be able to mount the subvolume RO, as long as
there are no bitflips in that subvolume.

Thanks,
Qu

> There will be, of course, a processing
> overhead, but probably not so expensive as by RAID 1?
>
> Thank you in advance and I wish you all to be happy and healthy!
>
> Nik.
> --
> 21.12.2020 12:44, Qu Wenruo:
>>
>>
>> On 2020/12/21 =E4=B8=8B=E5=8D=886:08, Nik. wrote:
>>> Dear all,
>>>
>>> the forwarded mail below came back yesterday with the error
>>> "Diagnostic-Code: X-Postfix; TLS is required, but was not offered by
>>> host vger.kernel.org[23.128.96.18]".
>>>
>>> Is it really intended that your mail server does not offer TLS?
>>
>> Can't help on that, not a vger manager nor know anything. (Most if not
>> all kernel mail lists are hosted by vger, each mail list can't do much)
>>
>> But I can definitely answer some of your btrfs problem.
>>>
>>> Kind regards,
>>>
>>> Nik.
>>>
>>> --
>>>
>>> 15.12.2020 18:40, Nik.:
>>>> Dear all,
>>>>
>>>> after almost a year without problems I need again your advice about
>>>> the same computer, but this time it is (hopefully only) the root FS
>>>> that failed. I have backups of everything except a couple of files in
>>>> /etc, so nothing critical, but probably it would be interesting for
>>>> somebody to see how behaved btrfs in such a situation.
>>>>
>>>> The story in short:
>>>>
>>>> - the FS switched to ro mode. Initially I thought that it is due to
>>>> insufficient free space (have already had similar situations) and
>>>> deleted some old snapshots. Within half a day it happened 3 more
>>>> times, though.
>>
>> Any detailed report on that RO?
>> We should have it addressed upstream, if you still hit that, I guess we
>> need more investigation (if it's not caused by memory corruption)
>>
>>>>
>>>> - so I booted in memtest86 and it gave me a lot of errors! This NAS i=
s
>>>> 9 years old and I was already looking for replacement, but it is not
>>>> easy to find 8-bay NAS for 2,5" drives...
>>>>
>>>> - took the drive out from the failed system and tried to mount it on
>>>> another (healthy?) PC. I am getting:
>>>>
>>>> root@ubrun:~# mount -t btrfs -o subvol=3D@ /dev/sdb1 /mnt/sd
>>>> mount: /mnt/sd: wrong fs type, bad option, bad superblock on
>>>> /dev/sdb1, missing codepage or helper program, or other error.
>>>> root@ubrun:~# dmesg |tail
>>>> [=C2=A0=C2=A0 50.672561] Policy zone: Normal
>>>> [=C2=A0 185.190764] BTRFS info (device sdb1): disk space caching is e=
nabled
>>>> [=C2=A0 185.190767] BTRFS info (device sdb1): has skinny extents
>>>> [=C2=A0 185.199331] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr=
 0, rd
>>>> 0, flush 0, corrupt 65, gen 0
>>>> [=C2=A0 185.246051] BTRFS critical (device sdb1): corrupt leaf:
>>>> block=3D50850988032 slot=3D79 extent bytenr=3D50496929792 len=3D16384=
 unknown
>>>> inline ref type: 54
>>
>> This is indeed some memory bitflip, and your initial kernel is not newe=
r
>> enough to detect it at write time.
>>
>> If using newer enough kernel, such corrupted metadata shouldn't even
>> reach disk. (Although it still means you will get the fs RO)
>>
>> There are only 4 valid types for extent refs:
>>
>> TREE_BLOCK_REF=C2=A0=C2=A0=C2=A0=C2=A0 176(0xb0)
>> EXTENT_DATA_REF=C2=A0 178(0xb2)
>> SHARED_BLOCK_REF 182(0xb6)
>> SHARED_DATA_REF=C2=A0 184(0xb8)
>>
>> The invalid type is:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 54(0x36)
>>
>> The diff is 0x80 to SHARED_BLOCK_REF, indeed one bit flipped.
>>
>>>> [=C2=A0 185.246055] BTRFS error (device sdb1): block=3D50850988032 re=
ad time
>>>> tree block corruption detected
>>>> [=C2=A0 185.247070] BTRFS critical (device sdb1): corrupt leaf:
>>>> block=3D50850988032 slot=3D79 extent bytenr=3D50496929792 len=3D16384=
 unknown
>>>> inline ref type: 54
>>>> [=C2=A0 185.247073] BTRFS error (device sdb1): block=3D50850988032 re=
ad time
>>>> tree block corruption detected
>>>> [=C2=A0 185.247093] BTRFS error (device sdb1): failed to read block
>>>> groups: -5
>>>> [=C2=A0 185.281382] BTRFS error (device sdb1): open_ctree failed
>>>> root@ubrun:~#
>>>>
>>>> How should one proceed?
>>
>> Since it's caused by bitflip and you mentioned the system has tons of
>> memory error, I believe there will be tons of similar problems
>> scattering around your fs.
>>
>> For repair, I don't really believe btrfs-check can or will be able to
>> fix any bitflip, not to mention so many possible more bitflips.
>>
>> It's better just to use your backup.
>>
>> BTW, for detection for extent tree bitflip is introduced in v5.4.
>> Next time at least you can catch the faulty hardware before it screws u=
p
>> your data.
>>
>> Thanks,
>> Qu
>>
>>>>
>>>> Kind regards
>>>>
>>>> Nik.
>>>>
