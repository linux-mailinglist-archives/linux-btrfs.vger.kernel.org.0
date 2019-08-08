Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C2858CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 05:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfHHDxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 23:53:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50174 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfHHDxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 23:53:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x783pTYL028482;
        Thu, 8 Aug 2019 03:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JRQ6EalhL8s6aHZ1KxI6wI/4ZPbuPEdPM6SCmauY3eg=;
 b=GDYefvIIah6G7Y69iRMaMh4p1l+NrwCvbAsqOYLYeAiQnBur/XA+Bu6w4b/B0dGy4JkQ
 wSWlkkC7GWhEa2ATM3syRgXv7LSHDo4OdQQJHZL9PzC5CQxzK8MI1rqGUtJINWlQMegp
 +xiqtbwOTneZ33FMvlMBOBItE5EnX8U/9mNqwWYsjVkI1kOk1eaI9+NdTfIwjVX++L4r
 TtF1E0X/DtGuij7PAdQ/UsOtH389VehlD72LScN9KdvMYk5ifXOkiUDoQ5vzfk8Pj16x
 Kk2kN8qWhqWwgQe/yaetPTHMiBLjWj2PXXPM+PBiHJ37HXL334KN9yxBVXx82Z050COZ /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u527pyvbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 03:53:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x783rQit013191;
        Thu, 8 Aug 2019 03:53:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u763jn9ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 03:53:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x783raRh007311;
        Thu, 8 Aug 2019 03:53:36 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 20:53:36 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
Date:   Thu, 8 Aug 2019 11:53:32 +0800
Cc:     Anand Jain <anand.jain@oracle.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC126E7A-3564-4316-A075-19EDB2FE1B27@oracle.com>
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
 <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080040
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 7 Aug 2019, at 7:15 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/8/7 =E4=B8=8B=E5=8D=885:43, Anand Jain wrote:
>>=20
>>=20
>>> On 7 Aug 2019, at 4:55 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2019/8/7 =E4=B8=8B=E5=8D=884:44, Filipe Manana wrote:
>>>> On Wed, Aug 7, 2019 at 9:35 AM Anand Jain <anand.jain@oracle.com> =
wrote:
>>>>>=20
>>>>> Commit 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the =
whole
>>>>> filesystem) makes sure we always trim starting from the first =
block group.
>>>>> However it also removed the range.start validity check which is =
set in the
>>>>> context of the user, where its range is from 0 to maximum of =
filesystem
>>>>> totalbytes and so we have to check its validity in the kernel.
>>>>>=20
>>>>> Also as in the fstrim(8) [1] the kernel layers may modify the trim =
range.
>>>>>=20
>>>>> [1]
>>>>> Further, the kernel block layer reserves the right to adjust the =
discard
>>>>> ranges to fit raid stripe geometry, non-trim capable devices in a =
LVM
>>>>> setup, etc. These reductions would not be reflected in =
fstrim_range.len
>>>>> (the --length option).
>>>>>=20
>>>>> This patch undos the deleted range::start validity check.
>>>>>=20
>>>>> Fixes: 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the =
whole filesystem)
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>> With this patch fstests generic/260 is successful now.
>>>>>=20
>>>>> fs/btrfs/ioctl.c | 2 ++
>>>>> 1 file changed, 2 insertions(+)
>>>>>=20
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index b431f7877e88..9345fcdf80c7 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -521,6 +521,8 @@ static noinline int btrfs_ioctl_fitrim(struct =
file *file, void __user *arg)
>>>>>               return -EOPNOTSUPP;
>>>>>       if (copy_from_user(&range, arg, sizeof(range)))
>>>>>               return -EFAULT;
>>>>> +       if (range.start > =
btrfs_super_total_bytes(fs_info->super_copy))
>>>>> +               return -EINVAL;
>>>>=20
>>>> This makes it impossible to trim block groups that start at an =
offset
>>>> greater then the super_total_bytes values.
>>>=20
>>=20
>> what did I miss? As there is no limit on the range::length
>> so we can still trim beyond super_total_bytes. So I don=E2=80=99t
>> understand why not? More below.
>>=20
>>=20
>>> Exactly.
>>>=20
>>>> In fact, in extreme cases
>>>> it's possible all block groups start at offsets larger then
>>>> super_total_bytes.
>>>> Have you considered that, or am I missing something?
>>>=20
>>> And, I have already mentioned exactly the same reason in that commit
>>> message.
>>>=20
>>> To address it once again, the bytenr is btrfs logical address space, =
has
>>> nothing to do with any device.
>>> Thus it can be [0, U64MAX].
>>>=20
>>=20
>> Fundamentally, logical address space has no relevance in the user =
context,
>> so also I don=E2=80=99t understand your view on how anyone shall use =
the range::start
>> even if there is no check?
>=20
> range::start =3D=3D bg_bytenr, range::len =3D bg_len to trim only a =
bg.
>=20

 Thanks for the efforts in explaining.

 My point is- it should not be one single bg but it should rather be all =
bg(s) in the specified range [start, length] so the %range.start=3D0 and =
%range.length=3D<U64MAX/total_bytes> should trim all the bg(s). May be =
your next question is- as we relocate the chunks how would the user ever =
know correct range.start to use? for which I don=E2=80=99t have an =
answer and the same question again applies to your proposal =
range.start=3D[0 to U64MAX] as well.

 So I am asking you again, even if you allow range.start=3D[0 to U64MAX] =
how will the user use it? Can you please explain?


> And that bg_bytenr is at 128T, since the fs has gone through several
> balance.
> But there is only one device, and its size is only 1T.
>=20
> Please tell me how to trim that block group only?
>=20

 Block groups are something internal the users don=E2=80=99t have to =
worry about it. The range is [0 to totalbytes] for start and [0 to =
U64MAX] for len is fair.

>>=20
>> As in the man page it's ok to adjust the range internally, and as =
length
>> can be up to U64MAX we can still trim beyond super_total_bytes?
>=20
> As I said already, super_total_bytes makes no sense in logical address
> space.

 But super_total_bytes makes sense in the user land though, on the other =
hand logical address space which you are trying to expose to the user =
land does not make sense to me.

> As super_total_bytes is just the sum of all devices, it's a device =
layer
> thing, nothing to do with logical address space.
>=20
> You're mixing logical bytenr with something not even a device physical
> offset, how can it be correct?
>=20
> Let me make it more clear, btrfs has its own logical address space
> unrelated to whatever the devices mapping are.
> It's always [0, U64_MAX], no matter how many devices there are.
>=20
> If btrfs is implemented using dm, it should be more clear.
>=20
> (single device btrfs)
>          |
> (dm linear, 0 ~ U64_MAX, virtual devices)<- that's logical address =
space
>  |   |   |    |
>  |   |   |    \- (dm raid1, 1T ~ 1T + 128M, devid1 XXX, devid2 XXX)
>  |   |   \------ (dm raid0, 2T ~ 2T + 1G, devid1 XXX, devid2 XXX)
>  |   \---------- (dm raid1, 128G ~ 128G + 128M, devi1 XXX, devid xxx)
>  \-------------- (dm raid0, 1M ~ 1M + 1G, devid1 xxx, devid2 xxx).
>=20
> If we're trim such fs layout, you tell me which offset you should use.
>=20

 There is no perfect solution, the nearest solution I can think - map =
range.start and range.len to the physical disk range and search and =
discard free spaces in that range. This idea may be ok for raids/linear =
profiles, but again as btrfs can relocate the chunks its not perfect.

Thanks, Anand


> Thanks,
> Qu
>=20
>>=20
>> Thanks, Anand
>>=20
>>=20
>>> Thanks,
>>> Qu
>>>=20
>>>>=20
>>>> The change log is also vague to me, doesn't explain why you are
>>>> re-adding that check.
>>>>=20
>>>> Thanks.
>>>>=20
>>>>>=20
>>>>>       /*
>>>>>        * NOTE: Don't truncate the range using super->total_bytes.  =
Bytenr of
>>>>> --
>>>>> 2.21.0 (Apple Git-120)

