Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D84B0C24
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfILKCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 06:02:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbfILKCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 06:02:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C9x2lo149465;
        Thu, 12 Sep 2019 10:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=gOS/JzpofuPWWnz1j6wS+PSjm6MNZh5a4XhX3Ypy+ZY=;
 b=heWEJ4AWfHiC7ERcqVPusKcviC/iKyCxAdXvHoe9DL3ZCzZIcrBFddnweqhbZRxskK4V
 3wZUHvWyihY2zIwyiiIstxhEO4kGOIHPWC0w7nv5m3Mq5/YK6YFdVj7rj2MSQNL8h+fp
 gMwnoB5n30WssnmcwKYQkdpTF/02cjU9A+nlbFTycDRmei2nrebA3lItqUr8I1gGJawJ
 y4Cz6q7yh4c3UyGj3j/cixW5U4fYmp+eiCOAWKr+/NxpL0WnVupvw5s+2DSfZkrOFJdd
 IczNcVeY5UO9eROm0Vy2cGgZxx1wEp+0Z6LuX24Y1by79UQ8iv7QVp5xLf55Xg1RLQn2 oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uw1jkqd7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:02:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C9x4uT105042;
        Thu, 12 Sep 2019 10:00:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2uy33c1nhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:00:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8CA0QdN021870;
        Thu, 12 Sep 2019 10:00:26 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 03:00:26 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20190912095021.htmpvvowdprc2jhv@MacBook-Pro-91.local>
Date:   Thu, 12 Sep 2019 18:00:21 +0800
Cc:     Anand Jain <anand.jain@oracle.com>, Eli V <eliventer@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B10B8AC4-5BDB-40B0-B76C-44B22BBF3095@oracle.com>
References: <20190826090438.7044-1-anand.jain@oracle.com>
 <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
 <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
 <20190911191656.mrmfyhvy3latjwid@macbook-pro-91.dhcp.thefacebook.com>
 <2f10bebf-bc63-fe9e-d7d3-06b3113bc95c@oracle.com>
 <20190912095021.htmpvvowdprc2jhv@MacBook-Pro-91.local>
To:     Josef Bacik <josef@toxicpanda.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120105
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 12 Sep 2019, at 5:50 PM, Josef Bacik <josef@toxicpanda.com> wrote:
>=20
> On Thu, Sep 12, 2019 at 03:41:42PM +0800, Anand Jain wrote:
>>=20
>>=20
>> Thanks for the comments. More below.
>>=20
>> On 12/9/19 3:16 AM, Josef Bacik wrote:
>>> On Wed, Sep 11, 2019 at 03:13:21PM -0400, Eli V wrote:
>>>> On Wed, Sep 11, 2019 at 2:46 PM Josef Bacik <josef@toxicpanda.com> =
wrote:
>>>>>=20
>>>>> On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
>>>>>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>>>>>> thread pid to determine the %mirror_num when the mirror_num=3D0.
>>>>>>=20
>>>>>> This patch introduces a framework so that we can add policies to =
determine
>>>>>> the %mirror_num. And also adds the devid as the readmirror =
policy.
>>>>>>=20
>>>>>> The new property is stored as an item in the device tree as show =
below.
>>>>>>     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
>>>>>>=20
>>>>>> To be able to set and get this new property also introduces new =
ioctls
>>>>>> BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl =
argument
>>>>>> is defined as
>>>>>>         struct btrfs_ioctl_readmirror_args {
>>>>>>                 __u64 type; /* RW */
>>>>>>                 __u64 device_bitmap; /* RW */
>>>>>>         }
>>>>>>=20
>>>>>> An usage example as follows:
>>>>>>         btrfs property set /btrfs readmirror devid:1,3
>>>>>>         btrfs property get /btrfs readmirror
>>>>>>           readmirror devid:1 3
>>>>>>         btrfs property set /btrfs readmirror ""
>>>>>>         btrfs property get /btrfs readmirror
>>>>>>           readmirror default
>>>>>>=20
>>>>>> This patchset has been tested completely, however marked as RFC =
for the
>>>>>> following reasons and comments on them (or any other) are =
appreciated as
>>>>>> usual.
>>>>>>  . The new objectid is defined as
>>>>>>       #define BTRFS_READMIRROR_OBJECTID -1ULL
>>>>>>    Need consent we are fine to use this value, and with this =
value it
>>>>>>    shall be placed just before the DEV_STATS_OBJECTID item which =
is more
>>>>>>    frequently used only during the device errors.
>>>>>>=20
>>>>>> .  I am using a u64 bitmap to represent the devices id, so the =
max device
>>>>>>    id that we could represent is 63, its a kind of limitation =
which should
>>>>>>    be addressed before integration, I wonder if there is any =
suggestion?
>>>>>>    Kindly note that, multiple ioctls with each time representing =
a set of
>>>>>>    device(s) is not a choice because we need to make sure the =
readmirror
>>>>>>    changes happens in a commit transaction.
>>>>>>=20
>>>>>> v1->RFC v2:
>>>>>>   . Property is stored as a dev-tree item instead of root inode =
extended
>>>>>>     attribute.
>>>>>>   . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to =
BTRFS_DEV_STATE_READ_PREFERRED.
>>>>>>   . Changed format specifier from devid1,2,3.. to devid:1,2,3..
>>>>>>=20
>>>>>> RFC->v1:
>>>>>>   Drops pid as one of the readmirror policy choices and as usual =
remains
>>>>>>   as default. And when the devid is reset the readmirror policy =
falls back
>>>>>>   to pid.
>>>>>>   Drops the mount -o readmirror idea, it can be added at a later =
point of
>>>>>>   time.
>>>>>>   Property now accepts more than 1 devid as readmirror device. As =
shown
>>>>>>   in the example above.
>>>>>>=20
>>>>>=20
>>>>> This is a lot of infrastructure
>>=20
>>  Ok. Any idea on a better implementation?
>>  How about extended attribute approach? v1 patches proposed
>>  it, but it abused the extended attribute as commented here [1]
>>  and v2 got changed to an item-key.
>>=20
>> [1]
>> =
https://lore.kernel.org/linux-btrfs/be68e6ea-00bc-b750-25e1-9c584b99308f@g=
mx.com/
>>=20
>=20
> That's a NAK on the prop interface.  This is a fs wide policy, not a
> directory/inode policy.
>=20
>>=20
>>>>> to just change which mirror we read to based on
>>>>> some arbitrary user policy.  I assume this is to solve the case =
where you have
>>>>> slow and fast disks, so you can always read from the fast disk?  =
And then it's
>>>>> only used in RAID1, so the very narrow usecase of having a RAID1 =
setup with a
>>>>> SSD and a normal disk?  I'm not seeing a point to this much code =
for one
>>>>> particular obscure setup.  Thanks,
>>>>>=20
>>>>> Josef
>>>>=20
>>>> Not commenting on the code itself, but as a user I see this SSD =
RAID1
>>>> acceleration as a future much have feature. It's only obscure at =
the
>>>> moment because we don't have code to take advantage of it. But on
>>>> large btrfs filesystems with hundreds of GB of metadata, like I =
have
>>>> for backups, the usability of the filesystem is dramatically =
improved
>>>> having the metadata on an SSD( though currently only half of the =
time
>>>> due to the even/odd pid distribution.)
>>>=20
>>> But that's different from a mirror.  100% it would be nice to say =
"put my
>>> metadata on the ssd, data elsewhere".  That's not what this patch is =
about, this
>>> patch is specifically about changing which drive we choose in a =
mirrored setup,
>>> which is super unlikely to mirror a SSD with a slow drive, cause =
it's just going
>>> to be slow no matter what.  Sure we could make it so reads always go =
to the SSD,
>>> but we can accomplish that by just adding a check for nonrotational =
in the code,
>>> and then we don't have to encode all this nonsense in the file =
system.  Thanks,
>>=20
>> I wrote about the readmirror policy framework here[2],
>> I forgot to link it here, sorry about that, my mistake.
>>=20
>> [2]
>>=20
>> =
https://lore.kernel.org/linux-btrfs/1552989624-29577-1-git-send-email-anan=
d.jain@oracle.com/
>>=20
>> Readmirror policy is for raid1, raid10 and future N way mirror.
>> Yes for now its only for raid1.
>>=20
>> Here the idea is to create a framework so that readmirror policy
>> can be configured as needed. And nonrotational can be one such =
policy.
>>=20
>> The example of hard-coded nonrotational policy does not work in case
>> of ssd and a remote iscsi ssd, OR in case of local ssd and a NVME =
block
>> device, as all these are still nonrotational devices. So hard-coded
>> policy is not a good idea. If we have to hardcode then there is =
Q-depth
>> based readmirror routing is better (patch in the ML), but that is
>> not good enough, because some configs wants it based on the disk-LBA
>> so that SAN storage target cache is balanced and not duplicated.
>> So in short it must be a configurable policy.
>>=20
>=20
> Again, if you are mixing disk types you likely always want =
non-rotational, but
> still mixing different speed devices in a mirror setup is just asking =
for weird
> latency problems.  I don't think solving this use case is necessary.  =
If you mix
> ssd + network device in a serious production setup then you probably =
should be
> fired cause you don't know what you are doing.  Having the generic
> "nonrotational gets priority" is going to cover 99% of the actual use =
cases that
> make sense.
>=20
> The SAN usecase I can sort of see, but again I don't feel like it's a =
problem we
> need to solve with on-disk format.  Add a priority to sysfs so you can =
change it
> with udev or something on the fly.  Thanks,
>=20
=20
 Ok.
 Sysfs is fine however we need configuration to be persistent across =
reboots.
 Any idea?

Thanks, Anand

> Josef

