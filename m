Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7581C11A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgEALrx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 07:47:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54620 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgEALrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 07:47:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041BdAZU123563;
        Fri, 1 May 2020 11:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oa0rQ9GQca1mZwn9rP/dbvOifjMvKKMtSjBKGCiZTPM=;
 b=XgMmOaXwWI3MDDItGA4LAFMvPfpfgxNkNyc+UbhCSz/m5A8eIOde6qN2/Bnwu+NBsDuS
 vfnh/cvCPgyrQg0J6f0b/D4Pqi/hnCAWq1vDDOLgr1yVdG+eb/sunqKpz+Y7zlt0bGQE
 6y+PsYmfitoH5VLbfW53iZWkovulN9Pv7YOSVvaMZ4lSQuwrU0CQ3vEAld8VzyhICU5A
 O1tleAqPEEJe/vEST7aY5D/YpXbIEfEy4yddkUrnto18/HTTEMB043aa9H2+3TmqnE7u
 S7CTWxTf+NPlioW4KLHi0gkFjLTWQiFJhrvoGkYDznBujJk/ZgipAGsSIT25A/B7UOQd 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30r7f3hvns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 11:47:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041BbChT110073;
        Fri, 1 May 2020 11:45:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30r7faak2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 11:45:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041BjiNx016062;
        Fri, 1 May 2020 11:45:45 GMT
Received: from [192.168.1.102] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 04:45:43 -0700
Subject: Re: [PATCH v3 REBASED 0/3] btrfs: fix issues due to alien device
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <55a5fd3a-dddb-df52-7f22-01e3407c0325@suse.com>
 <36da56d2-2384-87fb-8003-814e9c72ddbb@oracle.com>
 <547c4cc1-fe6b-8bcd-ff98-c45293ec7ce9@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c8a27fb4-7e9e-c261-82f3-f359f4655712@oracle.com>
Date:   Sat, 2 May 2020 03:45:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <547c4cc1-fe6b-8bcd-ff98-c45293ec7ce9@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=2
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010091
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/4/20 6:28 pm, Nikolay Borisov wrote:
> 
> 
> On 30.04.20 г. 20:54 ч., Anand Jain wrote:
>>
>>
>> On 30/4/20 2:05 pm, Nikolay Borisov wrote:
>>>
>>>
>>> On 28.04.20 г. 18:22 ч., Anand Jain wrote:
>>>> v3 REBASED: Based on the latest misc-next. for for-5.8.
>>>>      Dropped the following patches as there were concerns about the usage
>>>>      of error code -EUCLEAN
>>>>      btrfs: remove identified alien device in open_fs_devices
>>>>      btrfs: remove identified alien btrfs device in open_fs_devices
>>>>
>>>>      Rmaining 3 patches here have obtained reviewed-by. With this pathset
>>>>      the pertaining fstests btrfs/197 and btrfs/198 (which tests 3 bugs)
>>>>      would pass as the patch 2/3 fixed a bug and 3/3 fixed the trigger
>>>>      of 2 other bugs (patch 1/3 is just a cleanup). Further at the moment
>>>>      I am not sure if there is any other trigger where it could again
>>>> leave
>>>>      an alien device in the fs_devices leading to the same/similar bugs.
>>>>
>>>> ==== original email ====
>>>> v3: Fix alien device is due to wipefs in Patch4.
>>>>       Fix a nit in Patch3.
>>>>       Patches are reordered.
>>>>
>>>> Alien device is a device in fs_devices list having a different fsid than
>>>> the expected fsid or no btrfs_magic. This patch set fixes issues
>>>> found due
>>>> to the same.
>>>>
>>>> Patch1: is a cleanup patch, not related.
>>>> Patch2: fixes failing to mount a degraded RAIDs (RAID1/5/6/10), by
>>>>      hardening the function btrfs_free_extra_devids().
>>>> Patch3: fixes the missing device (due to alien btrfs-device) not
>>>> missing in
>>>>      the userland, by hardening the function btrfs_open_one_device().
>>>> Patch4: fixes the missing device (due to alien device) not missing in
>>>>      the userland, by returning EUCLEAN in btrfs_read_dev_one_super().
>>>> Patch5: eliminates the source of the alien device in the fs_devices.
>>>>
>>>> PS: Fundamentally its wrong approach that btrfs-progs deduces the device
>>>> missing state in the userland instead of obtaining it from the kernel.
>>>> I remember objecting on the btrfs-progs patch which did that, but still
>>>> it got merged, bugs in p3 and p4 are its side effects. I wrote
>>>> patches to read device_state from the kernel using ioctl, procfs and
>>>> sysfs but it didn't get the due attention till a merger.
>>>>
>>>> Anand Jain (3):
>>>>     btrfs: drop useless goto in open_fs_devices
>>>>     btrfs: include non-missing as a qualifier for the latest_bdev
>>>>     btrfs: free alien device due to device add
>>>>
>>>>    fs/btrfs/volumes.c | 30 ++++++++++++++++++++++--------
>>>>    1 file changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>
>>>
>>> One thing I'm not clear is how can we get into a situation of an alien
>>> device. I.e devices should be in fs_devices iff they are part of the>
>>> filesystem, no ?
>>>
>>
>> I think you are missing the point that, when the devices (of a
>> raid1/raid5/raid6) are unmounted, we don't free any of their
>> fs_devices::device. So in this situation if one of those devices is
>> added to any another fsid (using btrfs device add) or wiped using wipefs
>> -a, we still don't free the device's former fs_devices::device entry in
>> the kernel and it acts as an alien device among its former partners when
>> it is mounting.
> 
> So it could happen only due to a deliberate action by the user
> and not during normal operation. In this case is it not the user's
> responsibility to remove/forget the device from that file system?
> 

Anyone can run into it. I did. Instead of confusing them with showing
that a device belongs to two FSID its better to fix. A device can't
belong to two fsid.

