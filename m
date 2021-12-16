Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90F0477BF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 19:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhLPSwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 13:52:09 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:47914 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236342AbhLPSwI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 13:52:08 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xvrJmvzkaOKKIxvrJmCtBq; Thu, 16 Dec 2021 19:52:06 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639680726; bh=NN47qTfgd5agStcSiATy6wKcyq4HlCJGku6CBknxxpQ=;
        h=From;
        b=Uq6G01WLJg2k5ecgX7zaf9KZrGnAG0Ol83sm+kT5DRFiO7mHBf+bSgct/TGLsLR6r
         fD+yKpgYRavrajb5H8ymox5kiuDrjqzMT+ulVaTGZ6KD7+HiaCfSlXjrEql/lmsuXX
         eq5r5Fz3rLseFk+eD2tWBgSjBX7VXkBhPRNBOztLfirHJ7GmWFzeF3CZiFEJ2kPFVn
         EWvYy4wngQl9hIEXKjuvHZ5T02bMV9NLqCqeSRAf/RBbRPK9dml5YG5SJd7jGDEVRW
         HDa3/TdvMpzdRtr9MiWGUIfMvvbE7oWzyOGGcaDbiCHPZL6IE2fgf5JQsDPqSaqqqX
         aiti2woYLhgYg==
X-CNFS-Analysis: v=2.4 cv=QuabYX+d c=1 sm=1 tr=0 ts=61bb8ad6 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=1DWNq_REXNAiyZ3G7W8A:9 a=QEXdDO2ut3YA:10
Message-ID: <4c0d1459-b44f-f25b-035f-0e75d6cec07e@libero.it>
Date:   Thu, 16 Dec 2021 19:52:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: Create sysfs entries only for non-stale devices
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
References: <20211215144639.876776-1-nborisov@suse.com>
 <b08f828e-6336-fc09-521a-d4cf439e45d8@libero.it>
 <86e0c499-da7a-2e3a-1782-502d9b1ef944@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <86e0c499-da7a-2e3a-1782-502d9b1ef944@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfA8DEgeM7dKs1WXPRCKBHf7yHqHI5FG9uzUZAny4z8f8rJ6goktpvaD9Mewy2GLftJPxdjJaauSYdZg06ZUDRul07v6fKMDPlRDlP7oK5/NyEe4nWjjj
 yRIdx9PjLgbE/3bcwZT7RS4WlArTCXO4669uGffdFEr98D3tRwH6OiHTUAOrIQmqtxttij1ND8bVacAgTAxbYSGafzvkWOZ6aaujF8lbCZDVUj3hII4SlyHO
 +s8Pn1P4lTx54sugcHx7Wyqn5+a7PALkoE6QCWJJi+lafb2wQM6pmf4E4ISGB3t2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/15/21 23:02, Nikolay Borisov wrote:
> 
> 
> On 15.12.21 г. 20:55, Goffredo Baroncelli wrote:
>> Hi Nikolay,
>>
>> On 12/15/21 15:46, Nikolay Borisov wrote:
>>> Currently /sys/fs/btrfs/<uuid>/devinfo/<devid> entry is always created
>>> for a device present in btrfs_fs_devices on the other hand
>>> /sys/fs/btrfs/<uuid>/devices/<devname> sysfs link is created only when
>>> the given btrfs_device::bdisk member is populated. This can lead to
>>> cases where a filesystem consisting of 2 device, one of which is stale
>>> ends up having 2 entries under /sys/fs/btrfs/<uuid>/devinfo/<devid>
>>> but only one under /sys/fs/btrfs/<uuid>/devices/<devname>.
>>
>> What happened in case of a degraded mode ? Is correct to not show a
>> missing devices ?
> 
> Good question, now I'm thinking if 'devices' show the currently
> available devices to the filesystem, whilst 'devinfo' is supposed to
> show what devices the fs knows about. So in the case of degraded mount
> it should really have 2 devices under devinfo and only 1 under device.
> But this also means the case you reported shouldn't be handled by the
> devinfo sysfs code but rather the admin should do 'btrfs device scan -u'
> to remove the stale device.
> 
> 
> I'd say this is all pretty open to interpretation so I'd like to also
> see David's and Josef's opinions on this.

After some thinking, I reach the conclusion that devices/ shows the correct
values by mistake :-)

My understanding of a btrfs filesystem bootstrap is the following:

- each time a new block device appears, if this is a valid BTRFS device,
it is registered in a list
- at mount time, BTRFS groups all the devices with the same FS-UUID
- during the mount, it is assumed that if a device has a valid FS-UUID it
is a valid block devices for the filesystem

BTRFS has the following information to detect "foreign" block devices:
1) the UUID of each block devices should match the ones stored in DEV_ITEM (in the metadata)
2) the generation number should match
3) the "num_devices" field of superblock should match the total number of devices

In this case I see two problems:

a) the device was registered but it was unavailable at the time of mounting.
I don't think that it should be considered valid at all and it should be
removed from the list of the available devices when the first access for
check 1) and 2) is tried.
I know that a device can disappear after, but this case is different: if we
can perform 1) and 2) we can classify the device as valid/invalid
If we cannot do (as this case) we can consider it an artifact and discard enterly

b) in any case the check 3) ( 1) and 1) cannot be performed without the device)
should prevent the filesystem to be mounted if num_devices < number of the
listed devices (which is different from the available device). Looking at the
code it seems that only the case of a missing devices is handled










> 
>>
>>
> <snip>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
