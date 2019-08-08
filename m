Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4385CF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHHIfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 04:35:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHIfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Aug 2019 04:35:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x788Y05n055860;
        Thu, 8 Aug 2019 08:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xKP2xwJa6JrYCXkvoihsfn+mHMUySLdEg7itiTIiusI=;
 b=eGU6nYZSLQ29CiGRuT2RUit1pU7ROC3pADp7C4dglbkHuOAdZDsaTVMyHvYsUQce5t0E
 kt/wgYR67lhijsuC8ikjsAPNzFdoDRgON+YQm8lcKMxSf/vmbRhjRymlHfWiZA2OHKZp
 jIgYPwycs35+X3YrSLdmC41NJACWYgCEm5pgsD4Zv4svUcSp+nCEbTEAeaThyGtfCH/M
 /HIwSRivY7JoJfY4GlWfi+GZUrGuSU+CKqLa+xib06/Zmspq/STpz/Nqxj3Odq1CSiDQ
 IP6Gx8tTuBmVbK5CwZRTb2jn9xLV5qFXUc1FNa5s+4A/GDWwSF/RiC5ipNAV25Y4ZGXs EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u527q12r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 08:35:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x788WmvM104120;
        Thu, 8 Aug 2019 08:35:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u763jycmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 08:35:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x788Z5tN012228;
        Thu, 8 Aug 2019 08:35:05 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 01:35:05 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8f289892-1977-6f52-3585-8d7dcbd4d54a@gmx.com>
Date:   Thu, 8 Aug 2019 16:34:59 +0800
Cc:     Anand Jain <anand.jain@oracle.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6A06BCB-D2A7-4B9F-A6F4-04498572AEF5@oracle.com>
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
 <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
 <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>
 <8f289892-1977-6f52-3585-8d7dcbd4d54a@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 8 Aug 2019, at 1:55 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
> [...]
>>>>=20
>>>> Fundamentally, logical address space has no relevance in the user =
context,
>>>> so also I don=E2=80=99t understand your view on how anyone shall =
use the range::start
>>>> even if there is no check?
>>>=20
>>> range::start =3D=3D bg_bytenr, range::len =3D bg_len to trim only a =
bg.
>>>=20
>>=20
>> Thanks for the efforts in explaining.
>>=20
>> My point is- it should not be one single bg but it should rather be =
all bg(s) in the specified range [start, length] so the %range.start=3D0 =
and %range.length=3D<U64MAX/total_bytes> should trim all the bg(s).
>=20
> That's the common usage, but it doesn't mean it's the only usage.

 Oh you are right. man page doesn=E2=80=99t restrict range.start to be =
within super_total_bytes. It's only generic/260 that it is trying to =
enforce.

> Above bg range trim is also a valid use case.
>=20
>> May be your next question is- as we relocate the chunks how would the =
user ever know correct range.start to use? for which I don=E2=80=99t =
have an answer and the same question again applies to your proposal =
range.start=3D[0 to U64MAX] as well.
>>=20
>> So I am asking you again, even if you allow range.start=3D[0 to =
U64MAX] how will the user use it? Can you please explain?
>=20
> There are a lot of tools to show the bg bytenr and usage of each bg.
> It isn't a problem at all.
>=20

External tools sounds better than some logic within kernel to perform =
such a transformations. Now I get your idea. My bad.

I am withdrawing this patch.

Thanks, Anand

>>=20
>>=20
>>> And that bg_bytenr is at 128T, since the fs has gone through several
>>> balance.
>>> But there is only one device, and its size is only 1T.
>>>=20
>>> Please tell me how to trim that block group only?
>>>=20
>>=20
>> Block groups are something internal the users don=E2=80=99t have to =
worry about it. The range is [0 to totalbytes] for start and [0 to =
U64MAX] for len is fair.
>=20
> Nope, users sometimes care. Especially for the usage of each bg.
>=20
> Furthermore, we have vusage/vrange filter for balance, so user is not
> blocked from the whole bg thing.
>=20
>>=20
>>>>=20
>>>> As in the man page it's ok to adjust the range internally, and as =
length
>>>> can be up to U64MAX we can still trim beyond super_total_bytes?
>>>=20
>>> As I said already, super_total_bytes makes no sense in logical =
address
>>> space.
>>=20
>> But super_total_bytes makes sense in the user land though, on the =
other hand logical address space which you are trying to expose to the =
user land does not make sense to me.
>=20
> Nope, super_total_bytes in fact makes no sense under most cases.
> It doesn't even shows the up limit of usable space. (E.g. For all =
RADI1
> profiles, it's only half the space at most. Even for all SINGLE
> profiles, it doesn't account the 1M reserved space).
>=20
> It's a good thing to detect device list corruption, but despite that, =
it
> really doesn't make much sense.
>=20
> For logical address space, as explains, we have tools (not in
> btrfs-progs though) and interface (balance vrange filter) to take use =
of
> them.
>=20
>>=20
>>> As super_total_bytes is just the sum of all devices, it's a device =
layer
>>> thing, nothing to do with logical address space.
>>>=20
>>> You're mixing logical bytenr with something not even a device =
physical
>>> offset, how can it be correct?
>>>=20
>>> Let me make it more clear, btrfs has its own logical address space
>>> unrelated to whatever the devices mapping are.
>>> It's always [0, U64_MAX], no matter how many devices there are.
>>>=20
>>> If btrfs is implemented using dm, it should be more clear.
>>>=20
>>> (single device btrfs)
>>>         |
>>> (dm linear, 0 ~ U64_MAX, virtual devices)<- that's logical address =
space
>>> |   |   |    |
>>> |   |   |    \- (dm raid1, 1T ~ 1T + 128M, devid1 XXX, devid2 XXX)
>>> |   |   \------ (dm raid0, 2T ~ 2T + 1G, devid1 XXX, devid2 XXX)
>>> |   \---------- (dm raid1, 128G ~ 128G + 128M, devi1 XXX, devid xxx)
>>> \-------------- (dm raid0, 1M ~ 1M + 1G, devid1 xxx, devid2 xxx).
>>>=20
>>> If we're trim such fs layout, you tell me which offset you should =
use.
>>>=20
>>=20
>> There is no perfect solution, the nearest solution I can think - map =
range.start and range.len to the physical disk range and search and =
discard free spaces in that range.
>=20
> Nope, that's way worse than current behavior.
> See the above example, how did you pass devid? Above case is using =
RAID0
> and RAID1 on two devices, how do you handle that?
> Furthermore, btrfs can have different devices sizes for RAID profiles,
> how to handle that them? Using super total bytes would easily exceed
> every devices boundary.
>=20
> Yes, the current behavior is not the perfect solution either, but =
you're
> attacking from the wrong direction.
> In fact, for allocated bgs, the current behavior is the best solution,
> you can choose to trim any range and you have the tool like Hans'
> python-btrfs.
>=20
> The not-so-perfect part is about the unallocated range.
> IIRC things like thin-provision LVM choose not to trim the unallocated
> part, while btrfs choose to trim all the unallocated part.
>=20
> If you're arguing how btrfs handles unallocated space, I have no word =
to
> defend at all. But for the logical address part? I can't have more =
words
> to spare.
>=20
> Thanks,
> Qu
>=20
>> This idea may be ok for raids/linear profiles, but again as btrfs can =
relocate the chunks its not perfect.
>>=20
>> Thanks, Anand
>>=20
>>=20
>>> Thanks,
>>> Qu
>>>=20
>>>>=20
>>>> Thanks, Anand
>>>>=20
>>>>=20
>>>>> Thanks,
>>>>> Qu
>>>>>=20
>>>>>>=20
>>>>>> The change log is also vague to me, doesn't explain why you are
>>>>>> re-adding that check.
>>>>>>=20
>>>>>> Thanks.
>>>>>>=20
>>>>>>>=20
>>>>>>>      /*
>>>>>>>       * NOTE: Don't truncate the range using super->total_bytes. =
 Bytenr of
>>>>>>> --
>>>>>>> 2.21.0 (Apple Git-120)

