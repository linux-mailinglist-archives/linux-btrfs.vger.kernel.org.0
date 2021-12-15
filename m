Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8347613B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbhLOSz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 13:55:56 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:44058 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344090AbhLOSzy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 13:55:54 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xZRPmodg3OKKIxZRQm7vsB; Wed, 15 Dec 2021 19:55:52 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639594552; bh=vLXcBmck+Hm5yBQhLGnrzcIMUTKXqB8qgUzyNEhe8ko=;
        h=From;
        b=hQTJLoZ/Oh07vBdDtHYIFgdOdvOPSIzicoRVHV98/JJ13CNZL+vpEAgaRjDpKGh/s
         0PuoYnOd6Mxf4ZC5mznmfDTRP6dfc5+RgdYrMqM6Qd9WPCm48lhIKAsjAX0+cdWqRk
         zCJxkcdUABEomQEzZbgQ0RFUENKqsHmGenjiJhGGV+W04jq7r5P+sByF86Llzm2IL5
         l/qI39bTTVEP1lfx4bou1vn6BkwFLrcXUYUxlgTzBItj+Z+4StgyB09THV4eC+N4d7
         caDEpxdQl5ylodhWALsbs1Fa/6I+H9ENAx0f/1E64yc4tLNBnl5aUi2H07QlDToBmz
         YZ/AGMfZ0n8rA==
X-CNFS-Analysis: v=2.4 cv=QuabYX+d c=1 sm=1 tr=0 ts=61ba3a38 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=bQj5x6bgdn_wVhPAZkIA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
Message-ID: <b08f828e-6336-fc09-521a-d4cf439e45d8@libero.it>
Date:   Wed, 15 Dec 2021 19:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: Create sysfs entries only for non-stale devices
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211215144639.876776-1-nborisov@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20211215144639.876776-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKAXds/y5nyMMfsrFJMpt9o3b7aUGqsetc5SRiZzwZwU+/mn50otX0byv2BdASCnAxX2eDDWGTVFfgiiO4b8h3UA6u5qbt0rIhInPYQebn2Q02Xg3voY
 sQROIORcJvRPTqjpk8izFW1TZXi0/c6Ak4bepS03VXUmI4JA2f3k0LWC3cvdVU9WYLh8qcpXE/P0w1bk1qhU5wNHjN8YBpBPaVBTZ8MNZH0CK/U7bi+P/gUh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

On 12/15/21 15:46, Nikolay Borisov wrote:
> Currently /sys/fs/btrfs/<uuid>/devinfo/<devid> entry is always created
> for a device present in btrfs_fs_devices on the other hand
> /sys/fs/btrfs/<uuid>/devices/<devname> sysfs link is created only when
> the given btrfs_device::bdisk member is populated. This can lead to
> cases where a filesystem consisting of 2 device, one of which is stale
> ends up having 2 entries under /sys/fs/btrfs/<uuid>/devinfo/<devid>
> but only one under /sys/fs/btrfs/<uuid>/devices/<devname>.

What happened in case of a degraded mode ? Is correct to not show a missing devices ?


> Another case that occurs is if a filesystem initially occupied 2
> devices, then got unmounted, and a new filesystem is created, which
> occupies a single device but with the same UUID as the one occupying 2
> devices. In this case /sys/fs/btrfs/<uuid>/devices/<devname> will
> correctly have 1 entry but /sys/fs/btrfs/<uuid>/devices/<devname> will
> incorrectly has 2. This behavior is demonstrated by the following
> script:
> 
>      UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f2374
>      rm /tmp/d1
>      rm /tmp/d2
>      truncate -s 1G /tmp/d1
>      truncate -s 1G /tmp/d2
>      sudo losetup /dev/loop1 /tmp/d1
>      sudo losetup /dev/loop2 /tmp/d2
>      sudo mkfs.btrfs -U $UUID /dev/loop1 /dev/loop2
>      sudo mount /dev/loop1 /mnt/btrfs1
>      sudo umount /dev/loop1
>      sudo losetup -d /dev/loop2
>      sudo losetup -d /dev/loop1
> 
>      # create a new filesystem with only ONE loop-device; mount it
>      rm /tmp/d1
>      truncate -s 1G /tmp/d1
>      sudo losetup /dev/loop1 /tmp/d1
>      sudo mkfs.btrfs -U $UUID /dev/loop1
>      sudo mount /dev/loop1 /mnt/btrfs1
> 
> Fix this by ensuring that device sysfs attributes are only added for
> devices which are actually present at the time of mount.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/sysfs.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index beb7f72d50b8..e2e110d7798a 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -12,6 +12,7 @@
>   #include <crypto/hash.h>
>   
>   #include "ctree.h"
> +#include "rcu-string.h"
>   #include "discard.h"
>   #include "disk-io.h"
>   #include "send.h"
> @@ -1611,9 +1612,13 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
>   {
>   	int ret;
>   	unsigned int nofs_flag;
> +	struct kobject *disk_kobj;
>   	struct kobject *devices_kobj;
>   	struct kobject *devinfo_kobj;
>   
> +	if (!device->bdev)
> +		return 0;
> +
>   	/*
>   	 * Make sure we use the fs_info::fs_devices to fetch the kobjects even
>   	 * for the seed fs_devices
> @@ -1625,16 +1630,14 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
>   
>   	nofs_flag = memalloc_nofs_save();
>   
> -	if (device->bdev) {
> -		struct kobject *disk_kobj = bdev_kobj(device->bdev);
> +	disk_kobj = bdev_kobj(device->bdev);
>   
> -		ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
> -		if (ret) {
> -			btrfs_warn(device->fs_info,
> -				"creating sysfs device link for devid %llu failed: %d",
> -				device->devid, ret);
> -			goto out;
> -		}
> +	ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
> +	if (ret) {
> +		btrfs_warn(device->fs_info,
> +			   "creating sysfs device link for devid %llu failed: %d",
> +			   device->devid, ret);
> +		goto out;
>   	}
>   
>   	init_completion(&device->kobj_unregister);


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
