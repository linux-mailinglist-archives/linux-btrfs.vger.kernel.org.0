Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA401BF496
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD3JzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 05:55:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgD3JzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 05:55:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U9qo9u028141;
        Thu, 30 Apr 2020 09:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wH6ALiy8u6iiI8ELaRtVSXppoF1FxjI7Vu3Rtapevcw=;
 b=tl/x4/hVHLETtMsRLEKaCfSavH8m9+0hDUArU+3zIzBZd+ioTwWXC8J2BeGMV/QGG8zt
 4JQEsTVuKYV0t2JWgPYJILbOLSVI1DwFW+fJTLF+fdiVPaUE86HwqISBg9GyTDM7VUXw
 Bdej2gx19FJiUBxoWBS+NNZHFNZdDdxeUAqw4jylkoHv+KJOUPlkgaONy7jvSesWXrWI
 GL32fSUj1IosM6kOVxy/61v+OFjIJHch2ec3+39Fjw12vaCShkiE4kQtF15plqsscGvP
 Kvz9mA7g50OKt+n/XZdmeKxbap29BJ0FwUa0OXxWOG/urrmSQlzSb5wm45VeA0LLZC/p Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30nucgag9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 09:54:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U9qSJ9061824;
        Thu, 30 Apr 2020 09:54:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30qtkvxsa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 09:54:59 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03U9sw0G008287;
        Thu, 30 Apr 2020 09:54:58 GMT
Received: from [192.168.1.102] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Apr 2020 02:54:58 -0700
Subject: Re: [PATCH v3 REBASED 0/3] btrfs: fix issues due to alien device
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <55a5fd3a-dddb-df52-7f22-01e3407c0325@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <36da56d2-2384-87fb-8003-814e9c72ddbb@oracle.com>
Date:   Fri, 1 May 2020 01:54:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <55a5fd3a-dddb-df52-7f22-01e3407c0325@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=2 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300080
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/4/20 2:05 pm, Nikolay Borisov wrote:
> 
> 
> On 28.04.20 г. 18:22 ч., Anand Jain wrote:
>> v3 REBASED: Based on the latest misc-next. for for-5.8.
>>     Dropped the following patches as there were concerns about the usage
>>     of error code -EUCLEAN
>> 	btrfs: remove identified alien device in open_fs_devices
>> 	btrfs: remove identified alien btrfs device in open_fs_devices
>>
>>     Rmaining 3 patches here have obtained reviewed-by. With this pathset
>>     the pertaining fstests btrfs/197 and btrfs/198 (which tests 3 bugs)
>>     would pass as the patch 2/3 fixed a bug and 3/3 fixed the trigger
>>     of 2 other bugs (patch 1/3 is just a cleanup). Further at the moment
>>     I am not sure if there is any other trigger where it could again leave
>>     an alien device in the fs_devices leading to the same/similar bugs.
>>
>> ==== original email ====
>> v3: Fix alien device is due to wipefs in Patch4.
>>      Fix a nit in Patch3.
>>      Patches are reordered.
>>
>> Alien device is a device in fs_devices list having a different fsid than
>> the expected fsid or no btrfs_magic. This patch set fixes issues found due
>> to the same.
>>
>> Patch1: is a cleanup patch, not related.
>> Patch2: fixes failing to mount a degraded RAIDs (RAID1/5/6/10), by
>> 	hardening the function btrfs_free_extra_devids().
>> Patch3: fixes the missing device (due to alien btrfs-device) not missing in
>> 	the userland, by hardening the function btrfs_open_one_device().
>> Patch4: fixes the missing device (due to alien device) not missing in
>> 	the userland, by returning EUCLEAN in btrfs_read_dev_one_super().
>> Patch5: eliminates the source of the alien device in the fs_devices.
>>
>> PS: Fundamentally its wrong approach that btrfs-progs deduces the device
>> missing state in the userland instead of obtaining it from the kernel.
>> I remember objecting on the btrfs-progs patch which did that, but still
>> it got merged, bugs in p3 and p4 are its side effects. I wrote
>> patches to read device_state from the kernel using ioctl, procfs and
>> sysfs but it didn't get the due attention till a merger.
>>
>> Anand Jain (3):
>>    btrfs: drop useless goto in open_fs_devices
>>    btrfs: include non-missing as a qualifier for the latest_bdev
>>    btrfs: free alien device due to device add
>>
>>   fs/btrfs/volumes.c | 30 ++++++++++++++++++++++--------
>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>
> 
> 
> One thing I'm not clear is how can we get into a situation of an alien
> device. I.e devices should be in fs_devices iff they are part of the> filesystem, no ?
> 

I think you are missing the point that, when the devices (of a
raid1/raid5/raid6) are unmounted, we don't free any of their
fs_devices::device. So in this situation if one of those devices is
added to any another fsid (using btrfs device add) or wiped using wipefs
-a, we still don't free the device's former fs_devices::device entry in
the kernel and it acts as an alien device among its former partners when
it is mounting.
Now when this former partner(s) is(are) trying to mount in degraded, the
mount thread reads this device's SB (which is now an alien) and gets new
fsid+devid. The function btrfs_open_one_device() sees the non-matching
fsid+devid and it just ignores and still does not free the
fs_devices::device. If it had done, then the add_missing_dev() could
have allocated a fresh fs_devices::device using the data in the
chunk-tree instead of just setting the device state as missing in the
function read_one_dev().

Please look at fstests btrfs/197 and btrfs/198 they tests these
scenarios.

There are three bugs.
  1. raid1 mount -o degraded failed (patch 2/3 fixes it) (this bug is
     not related to the alien device issue, but we need this patch
     to continue testing).
  2. btrfs fi show -m does not show the missing device after mount of
     the degraded raid1.
    a. Bug triggered by btrfs device add. Fixed by the dropped patch
       [patch] btrfs: remove identified alien btrfs device in 
open_fs_devices
       root cause is btrfs_open_one_device() did not free the known
       alien device which contains the btrfs_magic but does not contain
       the required fsid+devid.
    b. Bug triggered by wipefs -a. Fixed by the dropped patch
       [patch] btrfs: remove identified alien device in open_fs_devices
       root cause is mount thread does not free the identified alien
       (not even contains the btrfs_magic) device.
3. Device add ioctl trigger. (patch 3/3 fixes it).

We still need those two dropped patches. They are stuck with the
-EUCLEAN usage. It can be discussed and sent as separate patches.
