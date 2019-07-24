Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD037249E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 04:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGXC22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 22:28:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfGXC21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 22:28:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2NfdL130355;
        Wed, 24 Jul 2019 02:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=2YChVp8VJj5S726KNuC6RkuVhOG3dSk5iSzbbBkc5uI=;
 b=18JwGB38Ds9ifB4CJLwmktjaUs1oVn+7NcRLJLvh28BLB7zPr56xjK+uNcmkKnZ9D1pE
 s+ZHqL3DLFUPsHC2pO5V/WoSiFrg6R6X+ZySOMvIktd6veJ7ouJB1/lFbpy0goMN/LPw
 gh9yvHACpv0VQQqlTUJ+YJUBfR0hm/J4IzEJ9HpCVMLFSHfwXtCi/iVPrJef7fJg3+ck
 KgXQyotlXnaiLR5oO+InN5S7la8hWdwerf62M9LeKbpUjHqkkd0q9LLdJBQ64AhVQt29
 RbybC6jfTuP+AUI+C8WwpYOTSScxNNzedDH1OcVG/Wd+xfD0jXfuyPfztFNIdlHC0ro4 /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tx61bt8an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:28:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2MeZc078933;
        Wed, 24 Jul 2019 02:26:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tx60wya3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:26:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6O2QLAH014446;
        Wed, 24 Jul 2019 02:26:21 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:26:21 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3 RESEND Rebased] readmirror feature
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dfd817fd-f832-6c27-8bcd-e1df9141e110@gmx.com>
Date:   Wed, 24 Jul 2019 10:26:17 +0800
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <209E99E4-8859-47CD-8826-2493FBEA0407@oracle.com>
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <dfd817fd-f832-6c27-8bcd-e1df9141e110@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240025
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 24 Jul 2019, at 8:20 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/6/26 =E4=B8=8B=E5=8D=884:33, Anand Jain wrote:
>> These patches are tested to be working fine.
>>=20
>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>> thread pid to determine the %mirror_num when the mirror_num=3D0.
>>=20
>> This patch introduces a framework so that we can add policies to =
determine
>> the %mirror_num. And adds the devid as the readmirror policy.
>>=20
>> The property is stored as an extented attributes of root inode
>> (BTRFS_FS_TREE_OBJECTID).
>=20
> This doesn't look right to me.
>=20
> As readmirror should work at chunk layer, putting it into root tree
> doesn't follow the layer separation of btrfs.
>=20
> And furthermore, this breaks the XATTR schema. Normally we only have
> XATTR item after an INODE item, not a ROOT_ITEM.
>=20
> Is the on-disk format already accepted or still under design stage?
>=20

 I mentioned about the storage for this new property in the RFC patch, =
as I knew there will be some surprises.

 The advantage of using the XATTR on the ROOT_ITEM is there is no =
on-disk format update nor there is any new KEY, albeit it deviates from =
the traditional way of using the xattr. Also, this approach don=E2=80=99t =
need an ioctl, as things work using the existing get/set xattr =
interface.

 The other way I had in mind was to introduce a new Key in the dev-tree =
such as

    (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)

 Again the interface can be ioctl or the get/set xattr. If we have to =
use the xattr then irrespective which inode is used we would anyway =
store it in the dev-tree using the above key.

 This is still open for changes, the idea is to get a long lasting =
flexible design, so comments are welcome.

Thanks, Anand


> Thanks,
> Qu
>=20
>> User provided devid list is validated against the =
fs_devices::dev_list.
>>=20
>> For example:
>>   Usage:
>>     btrfs property set <mnt> readmirror devid<n>[,<m>...]
>>     btrfs property set <mnt> readmirror ""
>>=20
>>   mkfs.btrfs -fq -draid1 -mraid1 /dev/sd[b-d] && mount /dev/sdb =
/btrfs
>>   btrfs prop set /btrfs readmirror devid1,2
>>   btrfs prop get /btrfs readmirror
>>    readmirror=3Ddevid1,2
>>   getfattr -n btrfs.readmirror --absolute-names /btrfs
>>    btrfs.readmirror=3D"devid1,2"
>>   btrfs prop set /btrfs readmirror ""
>>   getfattr -n btrfs.readmirror --absolute-names /btrfs
>>    /btrfs: btrfs.readmirror: No such attribute
>>   btrfs prop get /btrfs readmirror
>>=20
>> RFC->v1:
>>  Drops pid as one of the readmirror policy choices and as usual =
remains
>>  as default. And when the devid is reset the readmirror policy falls =
back
>>  to pid.
>>  Drops the mount -o readmirror idea, it can be added at a later point =
of
>>  time.
>>  Property now accepts more than 1 devid as readmirror device. As =
shown
>>  in the example above.
>>=20
>> Anand Jain (3):
>>  btrfs: add inode pointer to prop_handler::validate()
>>  btrfs: add readmirror property framework
>>  btrfs: add readmirror devid property
>>=20
>> fs/btrfs/props.c   | 120 =
+++++++++++++++++++++++++++++++++++++++++++--
>> fs/btrfs/props.h   |   4 +-
>> fs/btrfs/volumes.c |  25 +++++++++-
>> fs/btrfs/volumes.h |   8 +++
>> fs/btrfs/xattr.c   |   2 +-
>> 5 files changed, 150 insertions(+), 9 deletions(-)
>>=20
>=20

