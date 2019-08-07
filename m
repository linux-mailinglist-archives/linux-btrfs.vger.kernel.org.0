Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96983848C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfHGJnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 05:43:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56510 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfHGJnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 05:43:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x779ceBg136443;
        Wed, 7 Aug 2019 09:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=vtj+dTD2sARw9VDLKllCsoBOkj5uVKT+Xf2UZv75XJk=;
 b=STWZNTskwfRwh40WoBD7l6EdAMiEde4J7i7l3uI/2n1QsSKlor1Wp2gKgboPHDD67epu
 Iw3+mtBBil91+Fq2sIrk7yR8VY6ZpiKtqgnpGL9A9JFNl8pGjAC27CUJ7sKd/pGb4H+H
 yUzqBsh36nSiWSCTqCVniBsyN/mLlLV9cC3G1xzuXfMN2LU2ssJYoWbbmtGw3XDB+Rbd
 hM3wdgY73S11C6PNWv+HZGHeXfHY+WeArIzeGkXcHOwVRcJ45r75tow5rKu/bTn51/Pw
 cdR/+J7dwyAHXD38A8NoH2xksbniL1uQvOiJeBG6uqQyJabnwGhyQyb5k+aSsvMd0FEi aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u527pu7a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 09:43:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x779grsF092185;
        Wed, 7 Aug 2019 09:43:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2u7667ejt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 09:43:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x779hJoD016521;
        Wed, 7 Aug 2019 09:43:19 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 02:43:19 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
Date:   Wed, 7 Aug 2019 17:43:07 +0800
Cc:     Anand Jain <anand.jain@oracle.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070105
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 7 Aug 2019, at 4:55 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/8/7 =E4=B8=8B=E5=8D=884:44, Filipe Manana wrote:
>> On Wed, Aug 7, 2019 at 9:35 AM Anand Jain <anand.jain@oracle.com> =
wrote:
>>>=20
>>> Commit 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole
>>> filesystem) makes sure we always trim starting from the first block =
group.
>>> However it also removed the range.start validity check which is set =
in the
>>> context of the user, where its range is from 0 to maximum of =
filesystem
>>> totalbytes and so we have to check its validity in the kernel.
>>>=20
>>> Also as in the fstrim(8) [1] the kernel layers may modify the trim =
range.
>>>=20
>>> [1]
>>> Further, the kernel block layer reserves the right to adjust the =
discard
>>> ranges to fit raid stripe geometry, non-trim capable devices in a =
LVM
>>> setup, etc. These reductions would not be reflected in =
fstrim_range.len
>>> (the --length option).
>>>=20
>>> This patch undos the deleted range::start validity check.
>>>=20
>>> Fixes: 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole =
filesystem)
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>  With this patch fstests generic/260 is successful now.
>>>=20
>>> fs/btrfs/ioctl.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index b431f7877e88..9345fcdf80c7 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -521,6 +521,8 @@ static noinline int btrfs_ioctl_fitrim(struct =
file *file, void __user *arg)
>>>                return -EOPNOTSUPP;
>>>        if (copy_from_user(&range, arg, sizeof(range)))
>>>                return -EFAULT;
>>> +       if (range.start > =
btrfs_super_total_bytes(fs_info->super_copy))
>>> +               return -EINVAL;
>>=20
>> This makes it impossible to trim block groups that start at an offset
>> greater then the super_total_bytes values.
>=20

 what did I miss? As there is no limit on the range::length
 so we can still trim beyond super_total_bytes. So I don=E2=80=99t
 understand why not? More below.


> Exactly.
>=20
>> In fact, in extreme cases
>> it's possible all block groups start at offsets larger then
>> super_total_bytes.
>> Have you considered that, or am I missing something?
>=20
> And, I have already mentioned exactly the same reason in that commit
> message.
>=20
> To address it once again, the bytenr is btrfs logical address space, =
has
> nothing to do with any device.
> Thus it can be [0, U64MAX].
>=20

 Fundamentally, logical address space has no relevance in the user =
context,
 so also I don=E2=80=99t understand your view on how anyone shall use =
the range::start
 even if there is no check?

 As in the man page it's ok to adjust the range internally, and as =
length
 can be up to U64MAX we can still trim beyond super_total_bytes?

Thanks, Anand


> Thanks,
> Qu
>=20
>>=20
>> The change log is also vague to me, doesn't explain why you are
>> re-adding that check.
>>=20
>> Thanks.
>>=20
>>>=20
>>>        /*
>>>         * NOTE: Don't truncate the range using super->total_bytes.  =
Bytenr of
>>> --
>>> 2.21.0 (Apple Git-120)
>>>=20
>>=20
>>=20
>=20

