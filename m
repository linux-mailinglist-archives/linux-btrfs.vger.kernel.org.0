Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A001934C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 00:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYX4e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 19:56:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54626 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCYX4e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 19:56:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PNdMvP102634;
        Wed, 25 Mar 2020 23:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iGkYo9IBFctn6VG7fi+MJOzt0bIz6/isA6Vq+Yz0+rM=;
 b=WvZ/bSblBFlOPmDJKKkkIiuQzOGRh5GwOnO/yFfw/+XPK2ZcEPgTFjg/v+c2fRI11XrC
 KUWL0hW/4tBiai2v1dClcMWZYZeUtynQZ4DBPQin0sb056hIr+enOYnWsM0YILda2xGf
 FFDQVVSv2OHqE41dUsjkw3qKn7vJXeNVkcDV5InZ+m2WsJZeWuZcoYDohb9c6YvikFAW
 sMjYwLEEnHYSW3/YWbV9/Nw/HyfZHc2qL3TU5cr0TguuzEjf0G4GwCKXSRYMUAuseYEk
 sgeRHJnYBaOERQeJI/ShhJlKyoTzVpwOxwB72A45vbzVEoen4E2w+c1ll3LXP+Cic3ON uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ywabrcs83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 23:56:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PNoadw117033;
        Wed, 25 Mar 2020 23:56:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yxw4sfg3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 23:56:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PNuKVx004275;
        Wed, 25 Mar 2020 23:56:20 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 16:56:20 -0700
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
To:     Marc MERLIN <marc@merlins.org>,
        Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
Date:   Thu, 26 Mar 2020 07:56:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200325201455.GO29461@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250180
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi Marc,


On 26/3/20 4:14 AM, Marc MERLIN wrote:
> Thanks for the suggestion Nikolay
> 
> Dear Anand, David,
> 
> I see that
> https://gitlab.freedesktop.org/seanpaul/dpu-staging/commit/228a73abde5c04428678e917b271f8526cfd90ed
> may have helped, but is this really something a user should know/do?
> 
> Why does a device that disappeared from the bus, need to be manually
> unregistered?

> Are users really supposed to know this?
> Why does btrfs device scan not invalidate the cache of devices and keep
> remembering a device that's gone (not visible in new scan)?

  btrfs device scan --forget is only useful to cleanup the unmounted
  devices, per the logs below the device was mounted when it disappeared.
  More below.


> Thanks,
> Marc
> 
> 
> On Sat, Mar 21, 2020 at 11:25:04PM +0200, Nikolay Borisov wrote:
>>
>>
>> On 21.03.20 г. 22:23 ч., Marc MERLIN wrote:
>>> /dev/sde blipped off the bus (hardware issue?) and came
>>> back as /dev/sdq.
>>> Except btrfs won't let me scan or mount it.
>>>
>>> I was able to btrfs check it though and that came back clean.
>>>
>>> gargamel:~# ls -l /dev/sde
>>> ls: cannot access '/dev/sde': No such file or directory
>>>
>>>
>>> gargamel:~# mount /dev/sdq1 /mnt/mnt
>>> mount: /mnt/mnt: mount(2) system call failed: File exists.
>>> gargamel:~# dmesg |tail -1
>>> [2560371.195249] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1

   This indicates the device was mounted when it disappeared. So it
   re-appears with the new path, but as its fsid+uuid+devid matches
   with the old still mounted device we rightly consider it as an
   alien device and fail the mount.

   To avoid assigning new path to the reappearing device we need to
   close/pause the device path when it disappears. I need to figure
   out if there is any KPI from the block layer to help doing that.

   Anyone- any idea if there is anything in the block layer which can
   do the callback into the filesystem if the device disappears?

Thanks, Anand

>>>
>>> gargamel:~# btrfs device scan
>>> Scanning for Btrfs filesystems
>>> ERROR: device scan failed on '/dev/sdq1': File exists
>>> ERROR: there are 1 errors while registering devices
>>> gargamel:~# dmesg |tail -1
>>> [2560416.434529] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1
>>>
>>> gargamel:~# grep sde /proc/mounts
>>> cgroup2 /sys/fs/cgroup/unified cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
>>> gargamel:~#
>>>
>>> gargamel:~# lsblk -f |grep 727c7ba3-f6f9-462a-8472-453dd7d46d8a
>>> └─sdq1                            btrfs             btrfs_space                 727c7ba3-f6f9-462a-8472-453dd7d46d8a
>>> gargamel:~#
>>>
>>> So, that FS isn't a duplicate anymore and I see to have no way out except reboot
>>> which I'll do now.
>>>
>>> Was there another way around it? Obviously this is not desirable
>>> behaviour, in the past, I was able to remount the device when it came
>>> back.
>>>
>>
>> Presumably you could have used the device forget functionality that got
>> introduced in 5.1, i.e the BTRFS_IOC_FORGET_DEV ioctl. For more info
>> check out: 228a73abde5c04428678e917b271f8526cfd90ed
>>
>>> Thanks,
>>> Marc
>>>
>>
> 
