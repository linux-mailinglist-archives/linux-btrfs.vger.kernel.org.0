Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC37BCA36
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441270AbfIXO2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:28:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37662 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393649AbfIXO2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:28:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OESbBw115623;
        Tue, 24 Sep 2019 14:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=nVBkN54ZkcDP5U0rx4/TS0YVbhgI+t+q0NzrX+Xlhps=;
 b=jkZYaBPZxegQ98kefnqNlyv5W47/mscJIHbarT6PrBuk4NVQBilk3mdPjf1g3VwtzMF9
 ZQHhrHQFBVIpPPeT2OKAg4r1oz9dSE2OLYX3RLaYRcOvkpk0gpdObjAyfXBK2Fe0PS6P
 q8mgYm5dl/U4v0/e29BwJ+164jNcO9qR9s64QGo4f7671uDEf7V9dMsqIX0AY1r+u8TA
 yR+Jvwr30z57Gt6IuOB2M7VU+csn1b4UGKUBOJ+YuUZ3EJDyEXaFdT0LXrrA/JxyNV0W
 Igpe1VD+2/gjGEYVBMkNZFcneoRch0vM8Zi2+WAeUcE18GfYHmBoLik+udu0v7arVFBp Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v5b9tpgb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 14:28:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OESFN5073976;
        Tue, 24 Sep 2019 14:28:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2v6yvqaa9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 14:28:28 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8OERnrm006196;
        Tue, 24 Sep 2019 14:27:50 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 07:27:49 -0700
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
From:   Anand Jain <anand.jain@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Eli V <eliventer@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190826090438.7044-1-anand.jain@oracle.com>
 <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
 <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
 <20190911191656.mrmfyhvy3latjwid@macbook-pro-91.dhcp.thefacebook.com>
 <2f10bebf-bc63-fe9e-d7d3-06b3113bc95c@oracle.com>
 <20190912095021.htmpvvowdprc2jhv@MacBook-Pro-91.local>
 <B10B8AC4-5BDB-40B0-B76C-44B22BBF3095@oracle.com>
 <20190912100313.kjdatocumj6bbe7x@MacBook-Pro-91.local>
 <7ECB777E-BA58-46A0-925F-2B0AB9030288@oracle.com>
 <20190912101339.z2ckg7ug5smya343@MacBook-Pro-91.local>
 <e84756ec-8351-559b-bbd5-c7f532795a6d@oracle.com>
Message-ID: <159bfdff-35e6-3b32-3270-e56138ca01fe@oracle.com>
Date:   Tue, 24 Sep 2019 22:27:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e84756ec-8351-559b-bbd5-c7f532795a6d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240143
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/16/19 4:19 PM, Anand Jain wrote:
> On 12/9/19 6:13 PM, Josef Bacik wrote:
>> On Thu, Sep 12, 2019 at 06:10:08PM +0800, Anand Jain wrote:
>>>
>>>
>>>> On 12 Sep 2019, at 6:03 PM, Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On Thu, Sep 12, 2019 at 06:00:21PM +0800, Anand Jain wrote:
>>>>>
>>>>>
>>>>>> On 12 Sep 2019, at 5:50 PM, Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On Thu, Sep 12, 2019 at 03:41:42PM +0800, Anand Jain wrote:
>>>>>>>
>>>>>>>
>>>>>>> Thanks for the comments. More below.
>>>>>>>
>>>>>>> On 12/9/19 3:16 AM, Josef Bacik wrote:
>>>>>>>> On Wed, Sep 11, 2019 at 03:13:21PM -0400, Eli V wrote:
>>>>>>>>> On Wed, Sep 11, 2019 at 2:46 PM Josef Bacik 
>>>>>>>>> <josef@toxicpanda.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
>>>>>>>>>>> Function call chain  __btrfs_map_block()->find_live_mirror() 
>>>>>>>>>>> uses
>>>>>>>>>>> thread pid to determine the %mirror_num when the mirror_num=0.
>>>>>>>>>>>
>>>>>>>>>>> This patch introduces a framework so that we can add policies 
>>>>>>>>>>> to determine
>>>>>>>>>>> the %mirror_num. And also adds the devid as the readmirror 
>>>>>>>>>>> policy.
>>>>>>>>>>>
>>>>>>>>>>> The new property is stored as an item in the device tree as 
>>>>>>>>>>> show below.
>>>>>>>>>>>     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, 
>>>>>>>>>>> devid)
>>>>>>>>>>>
>>>>>>>>>>> To be able to set and get this new property also introduces 
>>>>>>>>>>> new ioctls
>>>>>>>>>>> BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The 
>>>>>>>>>>> ioctl argument
>>>>>>>>>>> is defined as
>>>>>>>>>>>         struct btrfs_ioctl_readmirror_args {
>>>>>>>>>>>                 __u64 type; /* RW */
>>>>>>>>>>>                 __u64 device_bitmap; /* RW */
>>>>>>>>>>>         }
>>>>>>>>>>>
>>>>>>>>>>> An usage example as follows:
>>>>>>>>>>>         btrfs property set /btrfs readmirror devid:1,3
>>>>>>>>>>>         btrfs property get /btrfs readmirror
>>>>>>>>>>>           readmirror devid:1 3
>>>>>>>>>>>         btrfs property set /btrfs readmirror ""
>>>>>>>>>>>         btrfs property get /btrfs readmirror
>>>>>>>>>>>           readmirror default
>>>>>>>>>>>
>>>>>>>>>>> This patchset has been tested completely, however marked as 
>>>>>>>>>>> RFC for the
>>>>>>>>>>> following reasons and comments on them (or any other) are 
>>>>>>>>>>> appreciated as
>>>>>>>>>>> usual.
>>>>>>>>>>> . The new objectid is defined as
>>>>>>>>>>>       #define BTRFS_READMIRROR_OBJECTID -1ULL
>>>>>>>>>>>    Need consent we are fine to use this value, and with this 
>>>>>>>>>>> value it
>>>>>>>>>>>    shall be placed just before the DEV_STATS_OBJECTID item 
>>>>>>>>>>> which is more
>>>>>>>>>>>    frequently used only during the device errors.
>>>>>>>>>>>
>>>>>>>>>>> .  I am using a u64 bitmap to represent the devices id, so 
>>>>>>>>>>> the max device
>>>>>>>>>>>    id that we could represent is 63, its a kind of limitation 
>>>>>>>>>>> which should
>>>>>>>>>>>    be addressed before integration, I wonder if there is any 
>>>>>>>>>>> suggestion?
>>>>>>>>>>>    Kindly note that, multiple ioctls with each time 
>>>>>>>>>>> representing a set of
>>>>>>>>>>>    device(s) is not a choice because we need to make sure the 
>>>>>>>>>>> readmirror
>>>>>>>>>>>    changes happens in a commit transaction.
>>>>>>>>>>>
>>>>>>>>>>> v1->RFC v2:
>>>>>>>>>>>   . Property is stored as a dev-tree item instead of root 
>>>>>>>>>>> inode extended
>>>>>>>>>>>     attribute.
>>>>>>>>>>>   . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to 
>>>>>>>>>>> BTRFS_DEV_STATE_READ_PREFERRED.
>>>>>>>>>>>   . Changed format specifier from devid1,2,3.. to devid:1,2,3..
>>>>>>>>>>>
>>>>>>>>>>> RFC->v1:
>>>>>>>>>>>   Drops pid as one of the readmirror policy choices and as 
>>>>>>>>>>> usual remains
>>>>>>>>>>>   as default. And when the devid is reset the readmirror 
>>>>>>>>>>> policy falls back
>>>>>>>>>>>   to pid.
>>>>>>>>>>>   Drops the mount -o readmirror idea, it can be added at a 
>>>>>>>>>>> later point of
>>>>>>>>>>>   time.
>>>>>>>>>>>   Property now accepts more than 1 devid as readmirror 
>>>>>>>>>>> device. As shown
>>>>>>>>>>>   in the example above.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is a lot of infrastructure
>>>>>>>
>>>>>>> Ok. Any idea on a better implementation?
>>>>>>> How about extended attribute approach? v1 patches proposed
>>>>>>> it, but it abused the extended attribute as commented here [1]
>>>>>>> and v2 got changed to an item-key.
>>>>>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/linux-btrfs/be68e6ea-00bc-b750-25e1-9c584b99308f@gmx.com/ 
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> That's a NAK on the prop interface.  This is a fs wide policy, not a
>>>>>> directory/inode policy.
>>>>>>
>>>>>>>
>>>>>>>>>> to just change which mirror we read to based on
>>>>>>>>>> some arbitrary user policy.  I assume this is to solve the 
>>>>>>>>>> case where you have
>>>>>>>>>> slow and fast disks, so you can always read from the fast 
>>>>>>>>>> disk?  And then it's
>>>>>>>>>> only used in RAID1, so the very narrow usecase of having a 
>>>>>>>>>> RAID1 setup with a
>>>>>>>>>> SSD and a normal disk?  I'm not seeing a point to this much 
>>>>>>>>>> code for one
>>>>>>>>>> particular obscure setup.  Thanks,
>>>>>>>>>>
>>>>>>>>>> Josef
>>>>>>>>>
>>>>>>>>> Not commenting on the code itself, but as a user I see this SSD 
>>>>>>>>> RAID1
>>>>>>>>> acceleration as a future much have feature. It's only obscure 
>>>>>>>>> at the
>>>>>>>>> moment because we don't have code to take advantage of it. But on
>>>>>>>>> large btrfs filesystems with hundreds of GB of metadata, like I 
>>>>>>>>> have
>>>>>>>>> for backups, the usability of the filesystem is dramatically 
>>>>>>>>> improved
>>>>>>>>> having the metadata on an SSD( though currently only half of 
>>>>>>>>> the time
>>>>>>>>> due to the even/odd pid distribution.)
>>>>>>>>
>>>>>>>> But that's different from a mirror.  100% it would be nice to 
>>>>>>>> say "put my
>>>>>>>> metadata on the ssd, data elsewhere".  That's not what this 
>>>>>>>> patch is about, this
>>>>>>>> patch is specifically about changing which drive we choose in a 
>>>>>>>> mirrored setup,
>>>>>>>> which is super unlikely to mirror a SSD with a slow drive, cause 
>>>>>>>> it's just going
>>>>>>>> to be slow no matter what.  Sure we could make it so reads 
>>>>>>>> always go to the SSD,
>>>>>>>> but we can accomplish that by just adding a check for 
>>>>>>>> nonrotational in the code,
>>>>>>>> and then we don't have to encode all this nonsense in the file 
>>>>>>>> system.  Thanks,
>>>>>>>
>>>>>>> I wrote about the readmirror policy framework here[2],
>>>>>>> I forgot to link it here, sorry about that, my mistake.
>>>>>>>
>>>>>>> [2]
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-btrfs/1552989624-29577-1-git-send-email-anand.jain@oracle.com/ 
>>>>>>>
>>>>>>>
>>>>>>> Readmirror policy is for raid1, raid10 and future N way mirror.
>>>>>>> Yes for now its only for raid1.
>>>>>>>
>>>>>>> Here the idea is to create a framework so that readmirror policy
>>>>>>> can be configured as needed. And nonrotational can be one such 
>>>>>>> policy.
>>>>>>>
>>>>>>> The example of hard-coded nonrotational policy does not work in case
>>>>>>> of ssd and a remote iscsi ssd, OR in case of local ssd and a NVME 
>>>>>>> block
>>>>>>> device, as all these are still nonrotational devices. So hard-coded
>>>>>>> policy is not a good idea. If we have to hardcode then there is 
>>>>>>> Q-depth
>>>>>>> based readmirror routing is better (patch in the ML), but that is
>>>>>>> not good enough, because some configs wants it based on the disk-LBA
>>>>>>> so that SAN storage target cache is balanced and not duplicated.
>>>>>>> So in short it must be a configurable policy.
>>>>>>>
>>>>>>
>>>>>> Again, if you are mixing disk types you likely always want 
>>>>>> non-rotational, but
>>>>>> still mixing different speed devices in a mirror setup is just 
>>>>>> asking for weird
>>>>>> latency problems.  I don't think solving this use case is 
>>>>>> necessary.  If you mix
>>>>>> ssd + network device in a serious production setup then you 
>>>>>> probably should be
>>>>>> fired cause you don't know what you are doing.  Having the generic
>>>>>> "nonrotational gets priority" is going to cover 99% of the actual 
>>>>>> use cases that
>>>>>> make sense.
>>>>>>
>>>>>> The SAN usecase I can sort of see, but again I don't feel like 
>>>>>> it's a problem we
>>>>>> need to solve with on-disk format.  Add a priority to sysfs so you 
>>>>>> can change it
>>>>>> with udev or something on the fly.  Thanks,
>>>>>>
>>>>>
>>>>> Ok.
>>>>> Sysfs is fine however we need configuration to be persistent across 
>>>>> reboots.
>>>>> Any idea?
>>>>>
>>>>
>>>> Udev rules.  Thanks,
>>>>
>>>
>>>   Josef, configs moving along with the luns in san seems to be more
>>>   easy to manage, otherwise when the host fails, each potential new
>>>   server has to be pre-configured with the udev rules.
>>>
>>
>> It's 2019, if people haven't figured out how to do persistent 
>> configuration by
>> now then all hope is lost.  Facebook persistently configures millions of
>> machines, I'm sure people can figure out how to make sure a udev rule 
>> ends up on
>> the right host connected to a SAN that doesn't move.  Thanks,
>>
>> Josef
>>
> 
> yeah. sysfs interface should be fine for now, and based on the
> usage feedback we could consider persistent storage for the readmirror.
> 
> Typical to WORM (Write Once Read Many times) setups they mainly need
> good read performance as data is imported once from somewhere else.
> Just out of curiosity ran read performance checks using the readmirror 
> property on ssd and nvme device.
> 
> $ btrfs fi show
> Label: none  uuid: e24bd8b5-a9e9-41d4-b28e-e95c0c545466
>      Total devices 2 FS bytes used 391.64MiB
>      devid    1 size 447.13GiB used 2.01GiB path /dev/sdf
>      devid    2 size 5.82TiB used 2.01GiB path /dev/nvme0n1
> 
> $ cat /sys/block/sdf/queue/rotational
> 0
> $ cat /sys/block/nvme0n1/queue/rotational
> 0
> 
> $ dropcache; sleep 3; btrfs prop set /btrfs readmirror devid:2 && time 
> md5sum /btrfs/fOH2
> 6129ccf74f7a761e0c3e096e051ba7a2  /btrfs/fOH2
> 
> real    0m0.725s
> user    0m0.604s
> sys    0m0.113s
> 
> $ dropcache; sleep 3; btrfs prop set /btrfs readmirror devid:1 && time 
> md5sum /btrfs/fOH2
> 6129ccf74f7a761e0c3e096e051ba7a2  /btrfs/fOH2
> 
> real    0m1.125s
> user    0m0.643s
> sys    0m0.087s
> 
> nvme provides ~40% improvement for 400mb read io, however there are no
> other IOs. The question will be what kind of read io load balancer will
> be required at the full throttle of the preferred readmirror
> device IO Q depth [1]. Which means a heuristic is required to juggle
> around the policies and will be another readmirror policy to be part
> of the same framework when required.
> 
> [1]
> $ cat /sys/block/nvme0n1/queue/nr_requests
> 1023
> $ cat /sys/block/sdf/queue/nr_requests
> 64
> 
> Thanks, Anand


Josef,

  Here I infer as follows .. I wonder if it makes sense.

  - Potential readmirror policies are: pid, devid/manual, lba/cache,
    Q-depth(patches are in the ml from facebook) each one of them has
    their own advantage so a framework is essential.

  - As the block device performance keeps evolving so its common to have
    heterogeneous block devices on the host. readmirror policy helps
    to configure for the best possible performance.

  - sysfs is a good interface for readmirror policy as in ioctl we can't
    pass all possible devices in the ioctl argument.

  - ondisk storage is essential for the readmirror, and key-item pair
    is the only way for its storage. (On the 2nd thought storage cannot
    be implemented at a later point as sysfs interface must be consistent
    in each version. So implementing together sysfs and ondisk key-item
    pair makes sense to me.)

Thanks, Anand
