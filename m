Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308FF402175
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhIFX1g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 19:27:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:40485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhIFX1g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 19:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630970789;
        bh=ifpZh0KMuuxKCy9Nt04+7AduIMlzUO9T2Kgj3CUYv90=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CE20vILchXY/L5DdDZJhmv3O/w7QtwhbG2vl2UVy6s3vOr3BVepLQvxp2C5eH2IC9
         tRAn+8ibGx58PoDNramrtPC0Ho+i6LavJ9LIoy7EDKl2Q8z1H+3Uxw7YtzLJ+sEn+D
         DfiVW9ePU5vyvKjHOLQbseyDTS5SHkvdSqDFeqcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1mi8MS17yO-00ni5M; Tue, 07
 Sep 2021 01:26:28 +0200
Subject: Re: Next steps in recovery?
To:     Robert Wyrick <rob@wyrick.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
 <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
 <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com>
Date:   Tue, 7 Sep 2021 07:26:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UpnVKV3l7T2H4nCy3Qw8MNFG6A0O6GB8/pEhZ05i79XGZnT/7XH
 Qxlvc3w3JpkXyp9KXSjB34lMAc8oiiQNnm9xHTy2FPHWxbcbCjeEi5qPsSP/DLNItdKm4MA
 7wx5jzMFNwpcDLEwSZULJsLU9Kve0Eli6nXurQj7HPdv2fBzgxpNN4EsGUyKjPnLPT3WoZP
 YiyFs2BdOxeEHkdS46KPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:egUu4VsEzFw=:BR9ZCTymixzzXSyGEq6loa
 iq/+yBqDBRKf9plbxkiqM7OiHbDl6yt+RX+6po2YLKwNEVngNXpTW8n283RDBo74nLOEjSpeB
 9XXROJBwYSLCm7DL/G/EIllxVT3zWBFkfc06CRp+wyvv702G5oRGw4UBSECjt6UwTMtTjcAs0
 chgsGE3y9nEi/93UE2OFBN2Tf9HUsiRE7JfULAwyZqiMv8Qc413eFD59G8I2UGEoro2cbvCl2
 OqrrdFQpJetLe1hwT1qlgFP9bvBmdwxf3vmpNX+EgpqpewW8MWJPvtIp7kpmX4Y1RxYOqvxe9
 LE3Um2yj1QvpZtKwqwtpTFDd/3nKil8SwG6y5kCaCm3aKpEEU/M5Zoq3spz9VcxgaWHxjMW5P
 Kxw2rwOscIEIpR9REU0xAhdaCV7jrSQaYENiZXLB3IscG1CQ+ksSYEj/+QXyfLmlOt9wILouZ
 NwZ2Z3UvB+xsM3m7tr1oPvNcpfEliQ8izQaJ75DmLXv6j9mb5KzEiu5jtsCenADipFADkOzJM
 Qv4sh83B4kA/TdK7E07PIxRi4u+RfXMovvMp55m69hmDB97ZK6n4YwjajT8KsWu45orWSOmmT
 FbeVt8686ksHzXIYoQPKoSJpnrlEQpyyBRj8YLcOsoK+S6SjRGKd67M80L9KJAGsGytqKzTbz
 j1qoxVhwvSpT6tc6TFiTAu3COUMZmw0edI5YDMYM3114+2U0anoc6IA2LcGAyRVKwRFl3sl1d
 DTaLbl71eoWJeGeBfLCiW+QNJjN1bBgCWREZ2W18UNaDHfRJK6YwN3uPUP7cR+6uI8vZmaWpO
 QdKAAwgejjCng2SEh0Tkv4BfMrAgDWLpvDmmp1B1JZabIu0927f9/aC48/xXBr3hZj/bZObsC
 sKSggVaaM7qKzasPAeQplS7TkaDUcTvgtz7HHU7+xYyU7tANbAwdqr+niQgG2itHwLeJBhfsX
 7cHUPrcF8tRYdsZuyJEQNyTd9zSsvTfLKOAPdJ/yS0JCuvYyrvxyAL54e9IQ7kq4Un+2rw2Z2
 a7ZXRRNlszD4ZjPf8V507nzYf+WnoQco3xANNrMjr7/KmabDnhRpiBkfZvbEW0ZgU83+EtJaP
 JzSO7dcCwxGBoicZVjMy/99O8vKDeiDzCAPgf9phxgPEJ+Oy5PcyXr8Tg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8B=E5=8D=8810:42, Robert Wyrick wrote:
> 42+ hours of memtest86+, no errors detected.  4 passes complete.
> Is that good enough?

That's strange, such obvious bitflip should be easily detected.

Is the fs only mounted on that computer?

Anyway, you can continue try to repair with *latest* btrfs-progs.

Thanks,
Qu
>
> On Sun, Sep 5, 2021 at 4:03 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/9/6 =E4=B8=8A=E5=8D=8812:00, Robert Wyrick wrote:
>>> Running memtest86+ now....  20 hours in.  No errors yet.
>>> Thanks for the analysis.  I'll let this run for another day or so.
>>
>> Just to mention, since 5.11 btrfs kernel module has the ability to
>> detect most high bitflip before writing tree blocks to disks.
>>
>> Thus even with less reliable RAM, it's still more reliable than nothing=
.
>>
>> But still, with the existing errors, the RAM test is still an essential
>> one before doing anything.
>>
>> Thanks,
>> Qu
>>>
>>>
>>> On Fri, Sep 3, 2021 at 12:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2021/9/3 =E4=B8=8B=E5=8D=882:48, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/9/3 =E4=B8=8A=E5=8D=8810:43, Robert Wyrick wrote:
>>>>>> I cannot mount my btrfs filesystem.
>>>>>> $ uname -a
>>>>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
>>>>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>> $ btrfs version
>>>>>> btrfs-progs v5.4.1
>>>>>
>>>>> The tool is a little too old, thus if you're going to repair, you'd
>>>>> better to update the progs.
>>>>>>
>>>>>> I'm seeing the following from check:
>>>>>> $ btrfs check -p /dev/sda
>>>>>> Opening filesystem to check...
>>>>>> Checking filesystem on /dev/sda
>>>>>> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
>>>>>> [1/7] checking root items                      (0:00:59 elapsed,
>>>>>> 2649102 items checked)
>>>>>> ERROR: invalid generation for extent 38179182174208, have
>>>>>> 140737491486755 expect (0, 4057084]
>>>>>
>>>>> This is a repairable problem.
>>>>>
>>>>> We have test case for exactly the same case in tests/fsck-test/044 f=
or it.
>>>>
>>>> Oh, this invalid extent generation is already a more direct indicatio=
n
>>>> of memory bitflip.
>>>>
>>>> 140737491486755 =3D 0x8000002fc823
>>>>
>>>> Without the high 0x8 bit, the remaining part is completely valid
>>>> generation, 0x2fc823, which is inside the expectation.
>>>>
>>>> So, a memtest is a must before doing any repair.
>>>> You won't want another bitflip to ruin your perfectly repairable fs.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>>
>>>>>> [2/7] checking extents                         (0:02:17 elapsed,
>>>>>> 1116143 items checked)
>>>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>>>> cache and super generation don't match, space cache will be invalid=
ated
>>>>>> [3/7] checking free space cache                (0:00:00 elapsed)
>>>>>> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
>>>>>> filetype 2 errors 2, no dir index
>>>>>
>>>>> No dir index can also be repaired.
>>>>>
>>>>> The dir index will be added back.
>>>>>
>>>>>> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype =
2
>>>>>> errors 5, no dir item, no inode ref
>>>>>
>>>>> No dir item nor inode ref can also be repaired, but with dir item an=
d
>>>>> inode ref removed.
>>>>>
>>>>> But the problem here looks very strange.
>>>>>
>>>>> It's the same dir and the same index, but different name.
>>>>> posters vs poSters.
>>>>>
>>>>> 'S' is 0x53 and 's' is 0x73, I'm wondering if your system had a bad
>>>>> memory which caused a bitflip and the problem.
>>>>>
>>>>> Thus I prefer to do a full memtest before running btrfs check --repa=
ir.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>> [4/7] checking fs roots                        (0:00:42 elapsed,
>>>>>> 108894 items checked)
>>>>>> ERROR: errors found in fs roots
>>>>>> found 15729059057664 bytes used, error(s) found
>>>>>> total csum bytes: 15313288548
>>>>>> total tree bytes: 18286739456
>>>>>> total fs tree bytes: 1791819776
>>>>>> total extent tree bytes: 229130240
>>>>>> btree space waste bytes: 1018844959
>>>>>> file data blocks allocated: 51587230502912
>>>>>>     referenced 15627926712320
>>>>>>
>>>>>> I've tried everything I've found on the internet, but haven't
>>>>>> attempted to repair based on the warnings...
>>>>>>
>>>>>> What more info do you need to help me diagnose/fix this?
>>>>>>
>>>>>> Thanks!
>>>>>> -Rob
>>>>>>
>
