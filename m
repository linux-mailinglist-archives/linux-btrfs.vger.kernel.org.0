Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F4B099F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfILHlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 03:41:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfILHlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 03:41:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C7ciHh183173;
        Thu, 12 Sep 2019 07:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=6IEalfwXxo7lg5kr+EW/UBKsRPXBoBVLub02m/fbAmY=;
 b=bvmCc4IuKrEPT3iALZomxre+dUT6T7PdLQsA4yYp65NIalhol6kpv7aERa6SHTE+PDu7
 3YisMUF50SJvtNB8coPaQazCJqR5Ejd9n6v5Ta6J/NQu1uk9UieqB7AD0NjAc7IbxLTw
 gvMya4M5arQuusqReF4K8Bmo8IAjwH7N7QG2sDv+5BFdRxoeUrFOJdY8K8zizzZlkHN9
 MZQZCJ2OKAOWrGPFE4HSAyM+5G/kFEnqnmpsz/AYdXYBlsV+kTsJHrhffjXev2RNvYC1
 KQlWmdpmLhZ2IExkVpP1RLvMVgVLnl/i8jLQ6H4aE3WxssbvSPjuAzlA1j9Li9i1Bb8R 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uw1jyem6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 07:41:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C7cPiW038708;
        Thu, 12 Sep 2019 07:41:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2uy8w9jda0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 07:41:47 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8C7fkUc031329;
        Thu, 12 Sep 2019 07:41:46 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 00:41:46 -0700
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
To:     Josef Bacik <josef@toxicpanda.com>, Eli V <eliventer@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190826090438.7044-1-anand.jain@oracle.com>
 <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
 <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
 <20190911191656.mrmfyhvy3latjwid@macbook-pro-91.dhcp.thefacebook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2f10bebf-bc63-fe9e-d7d3-06b3113bc95c@oracle.com>
Date:   Thu, 12 Sep 2019 15:41:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190911191656.mrmfyhvy3latjwid@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Thanks for the comments. More below.

On 12/9/19 3:16 AM, Josef Bacik wrote:
> On Wed, Sep 11, 2019 at 03:13:21PM -0400, Eli V wrote:
>> On Wed, Sep 11, 2019 at 2:46 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>
>>> On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
>>>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>>>> thread pid to determine the %mirror_num when the mirror_num=0.
>>>>
>>>> This patch introduces a framework so that we can add policies to determine
>>>> the %mirror_num. And also adds the devid as the readmirror policy.
>>>>
>>>> The new property is stored as an item in the device tree as show below.
>>>>      (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
>>>>
>>>> To be able to set and get this new property also introduces new ioctls
>>>> BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
>>>> is defined as
>>>>          struct btrfs_ioctl_readmirror_args {
>>>>                  __u64 type; /* RW */
>>>>                  __u64 device_bitmap; /* RW */
>>>>          }
>>>>
>>>> An usage example as follows:
>>>>          btrfs property set /btrfs readmirror devid:1,3
>>>>          btrfs property get /btrfs readmirror
>>>>            readmirror devid:1 3
>>>>          btrfs property set /btrfs readmirror ""
>>>>          btrfs property get /btrfs readmirror
>>>>            readmirror default
>>>>
>>>> This patchset has been tested completely, however marked as RFC for the
>>>> following reasons and comments on them (or any other) are appreciated as
>>>> usual.
>>>>   . The new objectid is defined as
>>>>        #define BTRFS_READMIRROR_OBJECTID -1ULL
>>>>     Need consent we are fine to use this value, and with this value it
>>>>     shall be placed just before the DEV_STATS_OBJECTID item which is more
>>>>     frequently used only during the device errors.
>>>>
>>>> .  I am using a u64 bitmap to represent the devices id, so the max device
>>>>     id that we could represent is 63, its a kind of limitation which should
>>>>     be addressed before integration, I wonder if there is any suggestion?
>>>>     Kindly note that, multiple ioctls with each time representing a set of
>>>>     device(s) is not a choice because we need to make sure the readmirror
>>>>     changes happens in a commit transaction.
>>>>
>>>> v1->RFC v2:
>>>>    . Property is stored as a dev-tree item instead of root inode extended
>>>>      attribute.
>>>>    . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.
>>>>    . Changed format specifier from devid1,2,3.. to devid:1,2,3..
>>>>
>>>> RFC->v1:
>>>>    Drops pid as one of the readmirror policy choices and as usual remains
>>>>    as default. And when the devid is reset the readmirror policy falls back
>>>>    to pid.
>>>>    Drops the mount -o readmirror idea, it can be added at a later point of
>>>>    time.
>>>>    Property now accepts more than 1 devid as readmirror device. As shown
>>>>    in the example above.
>>>>
>>>
>>> This is a lot of infrastructure

   Ok. Any idea on a better implementation?
   How about extended attribute approach? v1 patches proposed
   it, but it abused the extended attribute as commented here [1]
   and v2 got changed to an item-key.

[1]
https://lore.kernel.org/linux-btrfs/be68e6ea-00bc-b750-25e1-9c584b99308f@gmx.com/


>>> to just change which mirror we read to based on
>>> some arbitrary user policy.  I assume this is to solve the case where you have
>>> slow and fast disks, so you can always read from the fast disk?  And then it's
>>> only used in RAID1, so the very narrow usecase of having a RAID1 setup with a
>>> SSD and a normal disk?  I'm not seeing a point to this much code for one
>>> particular obscure setup.  Thanks,
>>>
>>> Josef
>>
>> Not commenting on the code itself, but as a user I see this SSD RAID1
>> acceleration as a future much have feature. It's only obscure at the
>> moment because we don't have code to take advantage of it. But on
>> large btrfs filesystems with hundreds of GB of metadata, like I have
>> for backups, the usability of the filesystem is dramatically improved
>> having the metadata on an SSD( though currently only half of the time
>> due to the even/odd pid distribution.)
> 
> But that's different from a mirror.  100% it would be nice to say "put my
> metadata on the ssd, data elsewhere".  That's not what this patch is about, this
> patch is specifically about changing which drive we choose in a mirrored setup,
> which is super unlikely to mirror a SSD with a slow drive, cause it's just going
> to be slow no matter what.  Sure we could make it so reads always go to the SSD,
> but we can accomplish that by just adding a check for nonrotational in the code,
> and then we don't have to encode all this nonsense in the file system.  Thanks,

  I wrote about the readmirror policy framework here[2],
  I forgot to link it here, sorry about that, my mistake.

  [2]
 
https://lore.kernel.org/linux-btrfs/1552989624-29577-1-git-send-email-anand.jain@oracle.com/

  Readmirror policy is for raid1, raid10 and future N way mirror.
  Yes for now its only for raid1.

  Here the idea is to create a framework so that readmirror policy
  can be configured as needed. And nonrotational can be one such policy.

  The example of hard-coded nonrotational policy does not work in case
  of ssd and a remote iscsi ssd, OR in case of local ssd and a NVME block
  device, as all these are still nonrotational devices. So hard-coded
  policy is not a good idea. If we have to hardcode then there is Q-depth
  based readmirror routing is better (patch in the ML), but that is
  not good enough, because some configs wants it based on the disk-LBA
  so that SAN storage target cache is balanced and not duplicated.
  So in short it must be a configurable policy.

  devid policy is the first policy which is for the advance users when
  they know what they are doing, which is sure to support any types
  of HW configurations/combinations (except for the cache balance).

  So in total potential configurable policies are:

  - pid     - original. dropped as a policy because of the comments
              received [3].
  - Q-depth - patches are in the ML this can be the default policy.
  - LBA     - to avoid duplicating the cache on the storage target
              in SAN
  - devid   - as discussed above.
  - nonrotational - as discussed above.

  So there are 5 ways to configure as needed, so a framework
  infrastructure is worth?

[3]
https://lore.kernel.org/linux-btrfs/20190409154840.GM29086@twin.jikos.cz/

Thanks, Anand

> Josef
> 

