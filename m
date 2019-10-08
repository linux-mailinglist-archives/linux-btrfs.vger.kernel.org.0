Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB1CF274
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfJHGLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 02:11:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49810 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfJHGLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Oct 2019 02:11:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9868sAt058913;
        Tue, 8 Oct 2019 06:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=f3xas2fOBK7VialV2aOQYPJzD/IGqwBtELNqWJML4OQ=;
 b=cFvorfdxPhlS12bxWvP0RNkhik6RPxJCJPSqSnRhW0w8k6kgLwFGwiFilGW90M6Xv0Eu
 BCFq5jRU9MpIwK3dGmflL7F0f5WHb/tLCshmbE+vkbLs+tuiDTkBXG4uqaOjNViSs+64
 naoagE0oR1j0xTeKMu91rbKUEWezQD2Q6PWBnc0aph/H1Dq9wl64M6b3fvWtNNlfR9NB
 s7e12WRDzC6k8sVZP7HSIiLeHJeSdg/0yDNk+nkjZY3LSINeL4lK6cJcCT3UxggxwR3x
 Yi5OzffoGsnpBlQZZB/yZ3zxQR8CA/yr4VyV2JAzhaSgO4Jgu8bCGkdn4FFjD/guKveK Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vejkub6hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 06:11:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9868oWg179156;
        Tue, 8 Oct 2019 06:11:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vgefa0ve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 06:11:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x986BbJO021195;
        Tue, 8 Oct 2019 06:11:38 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 23:11:37 -0700
Subject: Re: [PATCH v3 0/5] btrfs: fix issues due to alien device
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007173635.GJ2751@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <50b951e0-3578-d43f-a588-7bb7916dc5c4@oracle.com>
Date:   Tue, 8 Oct 2019 14:11:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007173635.GJ2751@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 1:36 AM, David Sterba wrote:
> On Mon, Oct 07, 2019 at 05:45:10PM +0800, Anand Jain wrote:
>> v3: Fix alien device is due to wipefs in Patch4.
>>      Fix a nit in Patch3.
>>      Patches are reordered.
>>
>> Alien device is a device in fs_devices list having a different fsid than
>> the expected fsid or no btrfs_magic. This patch set fixes issues found due
>> to the same.
> 
> The definition of alien device should be in some of the patches, I see
> it only in the cover letter.

  Ok will include.

> So the sequence of actions
> 
> 	mkfs A
> 	mount A
> 	mkfs B C
> 	add B to A
> 	mount C

  Right (fixed in patch 3/5). B contains alien btrfs superblock.

  Another scenario (fixed in Patch 4/5) as below.

  	mkfs A B
  	wipe A OR mkfs.ext4 A
  	mount B

  'A' contains alien or no superblock.

> leaves the scanned devices in a state that does not match the reality.
> At the time when B is scanned again, the ownership in the in-memory
> structures should be transferred to A (ie. removing B from BC). So far I
> understand the problem.

> The fix I'd expect is to fix up the devices at the first occasion, like
> when the device is scanned or attempted for mount.

  Right. btrfs_free_stale_devices() does it. Checks for duplicate entries
  for a device, and deletes it as its new structure has already been
  created. But we didn't call this in the context of device add, now
  fixed in patch 5/5.

>> Patch1: is a cleanup patch, not related.
>> Patch2: fixes failing to mount a degraded RAIDs (RAID1/5/6/10), by
>> 	hardening the function btrfs_free_extra_devids().
>> Patch3: fixes the missing device (due to alien btrfs-device) not missing in
>> 	the userland, by hardening the function btrfs_open_one_device().
>> Patch4: fixes the missing device (due to alien device) not missing in
>> 	the userland, by returning EUCLEAN in btrfs_read_dev_one_super().
>> Patch5: eliminates the source of the alien device in the fs_devices.
> 
> I'm a bit lost in the way it's being fixed.

  We weren't checking if there is any stale device structure when a
  device comes into btrfs through btrfs device add. This patch fixes
  it. Similar to what we do during scan. These are the only two ways
  device can entry into the btrfs kernel.

> The userspace part is IMO
> irrelevant, the change must happen on the kernel side using the
> information provided (scan, mount).
> 
> The error conditions should be propagated in a more fine grained way,
> similar to what you propose with EUCLEAN, but not with EUCLEAN. That has
> a very specific meaning, as has been pointed out.
> 
> The distinctions should be like:
> 
>   < 0 - error
>     0 - all ok, take the device
>   > 0 - device ok, but not ours

  When device is scanned its SB is already been read and updated in
  fs_devices.
  Now when we try to mount the SB is found to be corrupted or wiped or
  alienated. IMO it should be < 0. Its not about device its about the
  SB (on-disk struct) in the device, so I wonder which one is better
  -EUCLEAN ? Or -ESTALE ? or any suggestion?

> And the callers will decide what to do (remove or ignore).
> 
>> PS: Fundamentally its wrong approach that btrfs-progs deduces the device
>> missing state in the userland instead of obtaining it from the kernel.
>> I remember objecting on the btrfs-progs patch which did that, but still
>> it got merged, bugs in p3 and p4 are its side effects. I wrote
>> patches to read device_state from the kernel using ioctl, procfs and
>> sysfs but it didn't get the due attention till a merger.
> 
> The state has to be ultimately decided by kernel, userspace can read the
> information from anything but at the time this gets processed,

  Right.

> it might
> be stale again.

  That's ok. The user will run the command again.

> It's been probably very long ago when the above was
> discussed and I don't recall the details, 

> it may be a good idea to
> revisit if there are still things to address.

  Ok thanks. The correct thread to respond on this is the readmirror
  thread. As we need to read the btrfs_device::dev_state from
  the kernel to support readmirror.

Thanks, Anand


