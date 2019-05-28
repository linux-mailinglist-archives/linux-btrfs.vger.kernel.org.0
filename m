Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF292C831
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfE1N5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 09:57:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfE1N5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 09:57:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SDnBO9009071;
        Tue, 28 May 2019 13:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=JM3NBQcbGFus4IotcqvL441g620370K5w+omZQXrAuc=;
 b=FchzNKJALPkjDDXcJPXJ0mI9uJMl5lWOWdrzs2pDTyQT9AIlWttTwFUqvo8vnjD9rkcV
 wxfNfEdSPQdVdzlejr1fuZYOoGWuhWBw07YRlMPnhNT1NJMGnbZywflSAdFFlBWmnqaP
 hkuljRKeWWXP8orerHufJ6pA1w3w8r+tEUwPulTj1WOGR7OXIZgzMu6LkIqSixADcQdT
 QmMH8Xv1dyfkyj4lcKq/Zs9hvJ6f/L8HtqP76dm4GVoEpowDHSQiYdQzi/5Sec7ZtaTE
 sNvLTTnuvjxqm4CFQOIWysIbyXWiwsmQdWDjO1kHhpAtxI8KAZSBxohT9vVdHSBMspyh Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4tbapa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 13:57:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SDtnFQ064677;
        Tue, 28 May 2019 13:57:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2srbdwt3d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 13:57:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SDuuJT024430;
        Tue, 28 May 2019 13:56:57 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 06:56:56 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] readmirror feature
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2c4001e0-e264-3f02-cfb3-41befe189207@steev.me.uk>
Date:   Tue, 28 May 2019 21:56:51 +0800
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C50D052C-C9F8-41B9-A510-F711DE679E43@oracle.com>
References: <20190425115946.2550-1-anand.jain@oracle.com>
 <2c4001e0-e264-3f02-cfb3-41befe189207@steev.me.uk>
To:     Steven Davies <btrfs-list@steev.me.uk>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 11 May 2019, at 11:24 PM, Steven Davies <btrfs-list@steev.me.uk> =
wrote:
>=20
> Tested-by: Steven Davies <btrfs-list@steev.me.uk>
>=20
> Series (inc. btrfs-progs changes) tested working as expected against =
current btrfs-devel and btrfs-progs/devel.
>=20
> Am I correct in thinking that if more than one devid is assigned as a =
readmirror, the lowest available devid will be preferred?
>=20

As of now, it's just don=E2=80=99t do that kind of approach and it picks =
stripe 0 as read mirror device. And a disk is stripe 0 if it has largest =
disk free space as the time of chunk allocation. So it's kind of hard to =
predict which disk gets picked.

I have plans to write a patch to maintain the consistent allocation =
order.

> Also I think it would be nice to be able to set this property at mkfs =
time.
>=20

Yeah. It certainly makes sense in case of mixed device types such as ssd =
and hdd or hdd/ssd and iscsi.

Thanks, Anand

> I'd love to see this feature make it upstream.
>=20
> --=20
> Steven Davies
>=20
> On 25/04/2019 12:59, Anand Jain wrote:
>> These patches are tested to be working fine.
>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>> thread pid to determine the %mirror_num when the mirror_num=3D0.
>> This patch introduces a framework so that we can add policies to =
determine
>> the %mirror_num. And adds the devid as the readmirror policy.
>> The property is stored as an extented attributes of root inode
>> (BTRFS_FS_TREE_OBJECTID).
>> User provided devid list is validated against the =
fs_devices::dev_list.
>> For example:
>>   Usage:
>>     btrfs property set <mnt> readmirror devid<n>[,<m>...]
>>     btrfs property set <mnt> readmirror ""
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
>> Anand Jain (3):
>>  btrfs: add inode pointer to prop_handler::validate()
>>  btrfs: add readmirror property framework
>>  btrfs: add readmirror devid property
>> fs/btrfs/props.c   | 120 =
+++++++++++++++++++++++++++++++++++++++++++--
>> fs/btrfs/props.h   |   4 +-
>> fs/btrfs/volumes.c |  25 +++++++++-
>> fs/btrfs/volumes.h |   8 +++
>> fs/btrfs/xattr.c   |   2 +-
>> 5 files changed, 150 insertions(+), 9 deletions(-)
>> Anand Jain (2):
>>  btrfs-progs: add helper to create xattr name
>>  btrfs-progs: add readmirror policy
>> props.c | 75 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>> 1 file changed, 68 insertions(+), 7 deletions(-)

