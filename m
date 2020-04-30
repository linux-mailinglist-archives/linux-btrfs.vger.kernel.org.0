Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E41BF55E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgD3K2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 06:28:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgD3K2o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 06:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4AE1AC5B;
        Thu, 30 Apr 2020 10:28:41 +0000 (UTC)
Subject: Re: [PATCH v3 REBASED 0/3] btrfs: fix issues due to alien device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <55a5fd3a-dddb-df52-7f22-01e3407c0325@suse.com>
 <36da56d2-2384-87fb-8003-814e9c72ddbb@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <547c4cc1-fe6b-8bcd-ff98-c45293ec7ce9@suse.com>
Date:   Thu, 30 Apr 2020 13:28:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <36da56d2-2384-87fb-8003-814e9c72ddbb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.04.20 г. 20:54 ч., Anand Jain wrote:
> 
> 
> On 30/4/20 2:05 pm, Nikolay Borisov wrote:
>>
>>
>> On 28.04.20 г. 18:22 ч., Anand Jain wrote:
>>> v3 REBASED: Based on the latest misc-next. for for-5.8.
>>>     Dropped the following patches as there were concerns about the usage
>>>     of error code -EUCLEAN
>>>     btrfs: remove identified alien device in open_fs_devices
>>>     btrfs: remove identified alien btrfs device in open_fs_devices
>>>
>>>     Rmaining 3 patches here have obtained reviewed-by. With this pathset
>>>     the pertaining fstests btrfs/197 and btrfs/198 (which tests 3 bugs)
>>>     would pass as the patch 2/3 fixed a bug and 3/3 fixed the trigger
>>>     of 2 other bugs (patch 1/3 is just a cleanup). Further at the moment
>>>     I am not sure if there is any other trigger where it could again
>>> leave
>>>     an alien device in the fs_devices leading to the same/similar bugs.
>>>
>>> ==== original email ====
>>> v3: Fix alien device is due to wipefs in Patch4.
>>>      Fix a nit in Patch3.
>>>      Patches are reordered.
>>>
>>> Alien device is a device in fs_devices list having a different fsid than
>>> the expected fsid or no btrfs_magic. This patch set fixes issues
>>> found due
>>> to the same.
>>>
>>> Patch1: is a cleanup patch, not related.
>>> Patch2: fixes failing to mount a degraded RAIDs (RAID1/5/6/10), by
>>>     hardening the function btrfs_free_extra_devids().
>>> Patch3: fixes the missing device (due to alien btrfs-device) not
>>> missing in
>>>     the userland, by hardening the function btrfs_open_one_device().
>>> Patch4: fixes the missing device (due to alien device) not missing in
>>>     the userland, by returning EUCLEAN in btrfs_read_dev_one_super().
>>> Patch5: eliminates the source of the alien device in the fs_devices.
>>>
>>> PS: Fundamentally its wrong approach that btrfs-progs deduces the device
>>> missing state in the userland instead of obtaining it from the kernel.
>>> I remember objecting on the btrfs-progs patch which did that, but still
>>> it got merged, bugs in p3 and p4 are its side effects. I wrote
>>> patches to read device_state from the kernel using ioctl, procfs and
>>> sysfs but it didn't get the due attention till a merger.
>>>
>>> Anand Jain (3):
>>>    btrfs: drop useless goto in open_fs_devices
>>>    btrfs: include non-missing as a qualifier for the latest_bdev
>>>    btrfs: free alien device due to device add
>>>
>>>   fs/btrfs/volumes.c | 30 ++++++++++++++++++++++--------
>>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>>
>>
>>
>> One thing I'm not clear is how can we get into a situation of an alien
>> device. I.e devices should be in fs_devices iff they are part of the>
>> filesystem, no ?
>>
> 
> I think you are missing the point that, when the devices (of a
> raid1/raid5/raid6) are unmounted, we don't free any of their
> fs_devices::device. So in this situation if one of those devices is
> added to any another fsid (using btrfs device add) or wiped using wipefs
> -a, we still don't free the device's former fs_devices::device entry in
> the kernel and it acts as an alien device among its former partners when
> it is mounting.

So it could happen only due to a deliberate action by the user
and not during normal operation. In this case is it not the user's
responsibility to remove/forget the device from that file system?

