Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166E33F94DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbhH0HGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 03:06:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:52909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244353AbhH0HGU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 03:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630047924;
        bh=29b4dJ2WtrG8wDOtFNpG6N3X9xM8dtBMiRUbFYJmQRY=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=T69If2KUnIXVFI9EkUhy+TzYun8CArrOOyB4xXaj/ZfnGAe6RfjaHz53dWAWFjqQO
         SGdnzKJ+tx6pX72cPzG0tOqd9xkqrqyEF/iXvPWmFVFdcH0mbWbfs1vXOW3oDOZaBi
         X0hym7nF9wdo5GP7HwRnTvvF+a3x6ZhnXLiwgLYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeCtZ-1muUdg46VD-00bKB1; Fri, 27
 Aug 2021 09:05:24 +0200
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
 <20210816151026.GE5047@twin.jikos.cz>
 <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
 <20210826175314.GO3379@twin.jikos.cz>
 <14e03a46-6ba3-9b7f-30c0-0be0dee5b4c8@gmx.com>
 <fa092236-9bad-89a2-539f-bc332ac0a3f1@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
Message-ID: <8ea8ac80-3b13-77f5-f2c8-d4e0b044b20d@gmx.com>
Date:   Fri, 27 Aug 2021 15:05:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fa092236-9bad-89a2-539f-bc332ac0a3f1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ikZgZlmDppHVJQYOGJdEU+XG3L2CSkCc5+67ZKvUxV2nLOrnkrv
 6NSPYgl2YwVORG2AmFIG4CqCYYMiZK4nZSk98i8TsZRwLK6SAT90zSj/y0s8NhCTsNUlnr/
 8hjgy9BNVaHo69a2IB+rbQuC1+zcxQmE90ymR6JSZVwCk1JuABsWIwJBlTNmbSfO7aJ12oA
 QBwTaz32FllF8vFnWYtcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lbYj6fz5HVw=:s8opi4hmDlL0CkER2QFK0k
 S4v+y2rHgP11ea1lmUKTjWNgbhchNVBwv0Hct4N+GZdS4qtpLJopHZ9FfWIWuxj3szjU7v48A
 rbUAK+Jz34rweg9kdLJGY4T5OyIrzwgveAyL2kqapCRZWXpjRFpcVMEUImLBCCNvHNOlha73D
 m1JNKKeRquxQtavYHRitpWwtioGelonsLnaCwPoR9CjHB9hU65gAy2knhKqjE6j695AfYNlW+
 RR5MmOfhjc0pVQn8sU8uNTMV1yeqVa4hmSL0Uo8sRBF8gkXWPV4jRr6Ihx0GMIshOs2ZFJDBx
 QgqVL3nthrlxcB2bcVZe0OozrgqhvxHlfKpKlvu9hJgLCS6+Z9FNJna+NDtEPj4U3OaW+eQp3
 Gank6qAZHWcr6c67INUDN/4GnPYCqKx1O72SrgSplA1S0yay3E4PsXq2ovJccTgIKd2X6Vbok
 M3NWHT6e6E338TsE0nxJMabtGyzT75KxR3m1agD25uI6n4NM+VStdMMOoVLOWL41lwJT6qnIp
 dUPKWGmDzbKn2uCTuxfvdzp+oIHz+YCjsvo+ELUpZf3+Sjo6lSqhlI7FcN3prSb5GHtalolzj
 NfG2iA43/dgjCwL5iTe72/zavxm8UxVUF+L2+ecvkGl0SGoQpTGWm4XPhUK+I/U0XjQwruGIX
 pPW4z3StS+/6tSMKsSVQ5i2N+WTzdwoyqpKVoSbbSbAlqhhs56vmafXi4O2EiCRKEWDK87Ob2
 IK8QuPzeH/601oDAtko3xc27B3bPssLwOY/bUXq9C2quUv/NXZnj7wOy/YHwhG0c1OecsrenY
 7o9sXEel3si/k8vdxxkSjp2D7FsWsk29toDZxM11X54smqlO5ednFnsvvswKYga5ptoC/ykBI
 LK7OJFqaMOvUVCOFxLYiEt79XBdYR3+eHqvj29tHPRT39ck9aDPcdquZnaROZs6Z6ePDpJmnz
 cBsRuZHDCl7vSuSGBeG4kMmTYuPINRSizR4TEBAVB2iJVnjWW5arNJJetn6QZuHoZcMzHboYM
 R5YPgrmX8JBSACXhzprpAjAoFVfvf6QhLnhnryBh97/PaXc4Bsx4p0xEBJDclGZ+VEP8eNIhy
 fPbbwOSeGJSUFdYEI7DcpG/5svnD+dZHF+w6i/5W7/rOeejBUVXDPgsmQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/27 =E4=B8=8B=E5=8D=882:24, Anand Jain wrote:
>
>
> On 27/08/2021 08:38, Qu Wenruo wrote:
>>
>>
>> On 2021/8/27 =E4=B8=8A=E5=8D=881:53, David Sterba wrote:
>>> On Tue, Aug 24, 2021 at 01:54:21PM +0800, Anand Jain wrote:
>>>> On 16/08/2021 23:10, David Sterba wrote:
>>>>> On Tue, Aug 10, 2021 at 11:23:44PM +0800, Anand Jain wrote:
>>>>>> The mount option max_inline ranges from 0 to the sectorsize (which =
is
>>>>>> equal to pagesize). But we parse the mount options too early and
>>>>>> before
>>>>>> the sectorsize is a cache from the superblock. So the upper limit o=
f
>>>>>> max_inline is unaware of the actual sectorsize. And is limited by t=
he
>>>>>> temporary sectorsize 4096 (as below), even on a system where the
>>>>>> default
>>>>>> sectorsize is 64K.
>>>>>
>>>>
>>>>> So the question is what's a sensible value for >4K sectors, which
>>>>> is 64K
>>>>> in this case.
>>>>>
>>>>> Generally we allow setting values that may make sense only for some
>>>>> limited usecase and leave it up to the user to decide.
>>>>>
>>>>> The inline files reduce the slack space and on 64K sectors it could =
be
>>>>> more noticeable than on 4K sectors. It's a trade off as the inline
>>>>> data
>>>>> are stored in metadata blocks that are considered more precious.
>>>>>
>>>>> Do you have any analysis of file size distribution on 64K systems fo=
r
>>>>> some normal use case like roo partition?
>>>>>
>>>>> I think this is worth fixing so to be in line with constraints we ha=
ve
>>>>> for 4K sectors but some numbers would be good too.
>>>>
>>>> Default max_inline for sectorsize=3D64K is an interesting topic and
>>>> probably long. If time permits, I will look into it.
>>>> Furthermore, we need test cases and a repo that can hold it (and
>>>> also add=C2=A0 read_policy test cases there).
>>>>
>>>> IMO there is no need to hold this patch in search of optimum default
>>>> max_inline for 64K systems.
>>>
>>> Yeah, I'm more interested in some reasonable value, now the default is
>>> 2048 but probably it should be sectorsize/2 in general.
>>
>> Half of sectorsize is pretty solid to me.
>>
>> But I'm afraid this is a little too late, especially considering we're
>> moving to 4K sectorsize as default for all page sizes.
>
> I am writing a patch to autotune it to sectorsize/2 by default.

That would be pretty good.

>
> To test this, we need to have a filesystem with file sizes of various
> sizes (so that we have both inline and regular extents) and run rw. It
> looks like no regular workload (fio/sysbench) can do that and, I am
> stuck on that. Any inputs?

Is that a performance benchmark or just function tests?

For the former one, I guess you can specific the file sizes for
fio/sysbench.

For the latter part, it's pretty simple, just write a bunch of files
with different sizes, and use fiemap to check their block range.

Inline extents should report block range the same as their file offset.

Thanks,
Qu

>
>>>>> Please fix/reformat/improve any comments that are in moved code.
>>>>
>>>> =C2=A0=C2=A0 I think you are pointing to s/f/F and 80 chars long? Wil=
l fix.
>>>
>>> Yes, already fixed in the committed version in misc-next, thanks.
>
>  =C2=A0Thanks.
>
> - Anand
