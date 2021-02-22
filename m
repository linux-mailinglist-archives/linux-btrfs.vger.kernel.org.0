Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00055322147
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBVVXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:23:20 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:59508 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230057AbhBVVXR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:23:17 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-35.iol.local with ESMTPA
        id EIf1ly7bbpK9wEIf1loJjD; Mon, 22 Feb 2021 22:22:32 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614028952; bh=IjsAWmaMmQfb3NwLRf5ZjDmX5u3u7FIJ/b/OVY/bhJA=;
        h=From;
        b=Bdtx46T4n0RW8do6XHuJv1BSICToSm8UKkTpuDYF3E4kkjbrYTjBrqv3NOOryLdTH
         z6E8QJlZ86N4gOgiM8usq4K2O+PBMVHahadE4QJ/Kz4vJS9mHgoSWUS+S0VZ99UkmB
         uI7uzNvyiZd4JnXAN0PWWNDZSOHQ37pfkQbPJYdSgDagbNTplRPxaxt123XolGfUFB
         BSTnH/pfQtRDjtl7dmj0B8jQxEkib7gJbZYt4gEtw42VHm5R6S1/Ab7EcKBOKhNlMy
         tHhtewhUVvs/iU6i+jiEbCG7ap0V1Kxv93YMmP02nALLdDuX8YP1+tyrPKeU+jltmC
         wume6e1v/DvFA==
X-CNFS-Analysis: v=2.4 cv=A9ipg4aG c=1 sm=1 tr=0 ts=60342098 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=IkcTkHD0fZMA:10 a=dfLDlhdaAAAA:20 a=VwQbUJbxAAAA:8 a=kT-NTsFwAAAA:8
 a=q9z72tNrxGaIw0isQp8A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=TLwuWKmryFjkTYsgBL5T:22
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V7][PATCH 0/4] btrfs: allocation_hint mode
To:     Goffredo Baroncelli <kreijack@inwind.it>,
        linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <cover.1613678288.git.kreijack@inwind.it>
 <cover.1613678288.git.kreijack@inwind.it>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <98f4121c-3306-3f8f-4759-7b78f55f83f8@libero.it>
Date:   Mon, 22 Feb 2021 22:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cover.1613678288.git.kreijack@inwind.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEBTsmRqSeSkULZLvYx6Sidv7Qf8rUk4BZcrB1cyRaHopbIKCsuj355o/3w/26Vu63/wLzL7RzE6DDvBNfYfvJ9zzj4vYBlWDueHoJU4qEhI8g5lUC3a
 ioOBmI+khLorVbWqHhrPBNwAV/aQjRa3FcAfeJspo5zLxjelPT0+g2G8pgr+9hSyuS3Jlgr9llMGAa4yA8a0MzVQ1z+T95UyuSwUxa85qLhY+/am9imhm1sb
 rg9MPGrsiMTE71+4Cm7Shwu1WAhl3+VecvAyUdqyjGFRwt+udxF9cnorGsoEDQYE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry, the subject is wrong, it should be [RFC][PATCH V7][PATCH 0/4] btrfs: allocation_hint mode (seven instead six)

On 2/22/21 10:19 PM, Goffredo Baroncelli wrote:
> Hi all,
> 
> This patches set was born after some discussion between me, Zygo and Josef.
> Some details can be found in https://github.com/btrfs/btrfs-todo/issues/19.
> 
> Some further information about a real use case can be found in
> https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/
> 
> The idea behind this patches set, is to dedicate some disks (the fastest one)
> to the metadata chunk. My initial idea was a "soft" hint. However Zygo
> asked an option for a "strong" hint (== mandatory). The result is that
> each disk can be "tagged" by one of the following flags:
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> 
> When the chunk allocator search a disks to allocate a chunk, scans the disks
> in an order decided by these tags. For metadata, the order is:
> *_METADATA_ONLY
> *_PREFERRED_METADATA
> *_PREFERRED_DATA
> 
> The *_DATA_ONLY are not eligible from metadata chunk allocation.
> 
> For the data chunk, the order is reversed, and the *_METADATA_ONLY are
> excluded.
> 
> The exact sort logic is to sort first for the "tag", and then for the space
> available. If there is no space available, the next "tag" disks set are
> selected.
> 
> To set these tags, a new property called "allocation_hint" was created.
> There is a dedicated btrfs-prog patches set [[PATCH V5] btrfs-progs:
> allocation_hint disk property].
> 
> $ sudo mount /dev/loop0 /mnt/test-btrfs/
> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
> devid=1, path=/dev/loop0: allocation_hint=PREFERRED_METADATA
> devid=2, path=/dev/loop1: allocation_hint=PREFERRED_METADATA
> devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA
> devid=4, path=/dev/loop3: allocation_hint=PREFERRED_DATA
> devid=5, path=/dev/loop4: allocation_hint=PREFERRED_DATA
> devid=6, path=/dev/loop5: allocation_hint=DATA_ONLY
> devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
> devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY
> 
> $ sudo ./btrfs fi us /mnt/test-btrfs/
> Overall:
>      Device size:		   2.75GiB
>      Device allocated:		   1.34GiB
>      Device unallocated:		   1.41GiB
>      Device missing:		     0.00B
>      Used:			 400.89MiB
>      Free (estimated):		   1.04GiB	(min: 1.04GiB)
>      Data ratio:			      2.00
>      Metadata ratio:		      1.00
>      Global reserve:		   3.25MiB	(used: 0.00B)
>      Multiple profiles:		        no
> 
> Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
>     /dev/loop0	 288.00MiB
>     /dev/loop1	 288.00MiB
>     /dev/loop2	 127.00MiB
>     /dev/loop3	 127.00MiB
>     /dev/loop4	 127.00MiB
>     /dev/loop5	 127.00MiB
> 
> Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
>     /dev/loop1	 256.00MiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/loop0	  32.00MiB
> 
> Unallocated:
>     /dev/loop0	 704.00MiB
>     /dev/loop1	 480.00MiB
>     /dev/loop2	   1.00MiB
>     /dev/loop3	   1.00MiB
>     /dev/loop4	   1.00MiB
>     /dev/loop5	   1.00MiB
>     /dev/loop6	 128.00MiB
>     /dev/loop7	 128.00MiB
> 
> # change the tag of some disks
> 
> $ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY
> $ sudo ./btrfs prop set /dev/loop1 allocation_hint DATA_ONLY
> $ sudo ./btrfs prop set /dev/loop5 allocation_hint METADATA_ONLY
> 
> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
> devid=1, path=/dev/loop0: allocation_hint=DATA_ONLY
> devid=2, path=/dev/loop1: allocation_hint=DATA_ONLY
> devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA
> devid=4, path=/dev/loop3: allocation_hint=PREFERRED_DATA
> devid=5, path=/dev/loop4: allocation_hint=PREFERRED_DATA
> devid=6, path=/dev/loop5: allocation_hint=METADATA_ONLY
> devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
> devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY
> 
> $ sudo btrfs bal start --full-balance /mnt/test-btrfs/
> $ sudo ./btrfs fi us /mnt/test-btrfs/
> Overall:
>      Device size:		   2.75GiB
>      Device allocated:		 735.00MiB
>      Device unallocated:		   2.03GiB
>      Device missing:		     0.00B
>      Used:			 400.72MiB
>      Free (estimated):		   1.10GiB	(min: 1.10GiB)
>      Data ratio:			      2.00
>      Metadata ratio:		      1.00
>      Global reserve:		   3.25MiB	(used: 0.00B)
>      Multiple profiles:		        no
> 
> Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
>     /dev/loop0	 288.00MiB
>     /dev/loop1	 288.00MiB
> 
> Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
>     /dev/loop5	 127.00MiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/loop7	  32.00MiB
> 
> Unallocated:
>     /dev/loop0	 736.00MiB
>     /dev/loop1	 736.00MiB
>     /dev/loop2	 128.00MiB
>     /dev/loop3	 128.00MiB
>     /dev/loop4	 128.00MiB
>     /dev/loop5	   1.00MiB
>     /dev/loop6	 128.00MiB
>     /dev/loop7	  96.00MiB
> 
> 
> #As you can see all the metadata were placed on the disk loop5/loop7 even if
> #the most empty one are loop0 and loop1.
> 
> 
> 
> TODO:
> - more tests
> - the tool which show the space available should consider the tagging (
>    the disks tagged by _METADATA_ONLY should be excluded from the data
>    availability)
> 
> 
> Comments are welcome
> BR
> G.Baroncelli
> 
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
> Revision:
> V7:
> - make more room in the struct btrfs_ioctl_dev_properties up to 1K
> - leave in btrfs_tree.h only the costants
> - removed the mount option (sic)
> - correct an 'use before check' in the while loop (signaled
>    by Zygo)
> - add a 2nd sort to be sure that the device_info array is in the
>    expected order
> 
> V6:
> - add further values to the hints: add the possibility to
>    exclude a disk for a chunk type
> 
>    btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
>    btrfs: add flags to give an hint to the chunk allocator
>    btrfs: export dev_item.type in
>      /sys/fs/btrfs/<uuid>/devinfo/<devid>/type
>    btrfs: add allocator_hint mode
> 
>   fs/btrfs/ioctl.c                | 68 ++++++++++++++++++++++++++
>   fs/btrfs/sysfs.c                | 11 +++++
>   fs/btrfs/volumes.c              | 86 ++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.h              |  3 ++
>   include/uapi/linux/btrfs.h      | 39 +++++++++++++++
>   include/uapi/linux/btrfs_tree.h | 14 ++++++
>   6 files changed, 219 insertions(+), 2 deletions(-)
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
