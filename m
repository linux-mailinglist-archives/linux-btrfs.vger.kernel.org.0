Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A654B778B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 21:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiBOSu0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 13:50:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiBOSuZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 13:50:25 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 10:50:13 PST
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8FE74850
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 10:50:13 -0800 (PST)
Received: from [192.168.1.27] ([78.12.10.146])
        by smtp-31.iol.local with ESMTPA
        id K2stnA5Blo7JOK2stnhVgQ; Tue, 15 Feb 2022 19:49:10 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1644950950; bh=ijr5FaaBNEVMkYlb4oyAmf7H0toAZOacEsvX4HC4rjA=;
        h=From;
        b=mHgEDcdU6I9UVZXD+c4YR9NH5IEamOwEJS7xpdr8n+w9+SEDKcBX21FBZ0kYexWdS
         s4f3jpwDIIVS/VoGQX0FbW38yfnJmuimv1wHvFjH+5Ld1lzEY0u7squdSJl8b5geNJ
         Dc2HbfbtSp1VGhV6YccWbTLQesohtekgK57+qX2cm0jm2aZJRXxyIL/1wQV8ib+FeH
         rTMR1rwijLxxjyD0NC5Lob1V8zOvDg4S7ZG6NAo/G9p+Qeu7FF32vEMyn8pX7ibf8g
         nbcyGWsBi3fNEnurXHdgMNuyDs0gE7h87bTS3IP429zOtWrUY8GjaWmjRMDSzr+917
         Cl4UhlHkGrRPQ==
X-CNFS-Analysis: v=2.4 cv=O+T8ADxW c=1 sm=1 tr=0 ts=620bf5a6 cx=a_exe
 a=2C5VI3o5eQqsNyEplIs8Sg==:117 a=2C5VI3o5eQqsNyEplIs8Sg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=kT-NTsFwAAAA:8
 a=jAT4BqFDZ1dKBA5hYBsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=TLwuWKmryFjkTYsgBL5T:22
Message-ID: <7e5e75ed-86b4-a629-09c9-29202f93b4b6@inwind.it>
Date:   Tue, 15 Feb 2022 19:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org
References: <cover.1643228177.git.kreijack@inwind.it>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDHsoPaYHbB9kPzqkls63ifn0+/TdCzU+9b+Qt66PoxOHfUOr9DcllMuMuvYrhWEXESAjqrDQ6jIAuVsAn87ibSP/wDE6oNsABoJ2KvMNRA3k02mwvqb
 Uyl/B6FwXZ1fDqfTweUX9rTTjjICZ10DZF8MeHSZJgZCwxh+7afu6baR8nWd+/IS6cHgDqiNE4f/+myxC0/IpjvccTtZarTsFc0+q8+04LGzX13WGJczaysp
 6JISHcNZkKMAck4IgmIm2/Et7rVnlaqQ25/KQyE9cEzvsX2PKGsr2VBP5Q0NL+cCzgBOB5E9V3+CAkMxeNxGGtttcFlMMWDQdjRbcmdJKnzNMJ0xonoszgLn
 W+90qKsUOTByLQgPObLTTzcynAoS5g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

gentle ping...

few months ago you showed some interest in this patches set. Few of the cc-ed person use this patch set.

I know that David showed some interest in the Anand approach (i.e. no knobs, but an automatic behavior looking at the speed of the devices).

At the time when I tried this approach in the first attempts, I got the complain that the kernel may not know the performance differences of the disk (HDD vs SSD vs NVME vs ZONED disk...).

Comments ?

BR
Goffredo


On 26/01/2022 21.32, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Hi all,
> 
> This patches set was born after some discussion between me, Zygo and Josef.
> Some details can be found in https://github.com/btrfs/btrfs-todo/issues/19.
> 
> Some further information about a real use case can be found in
> https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/
> 
> Recently Shafeeq told me that he is interested too, due to the performance gain.
> 
> In V8, revision I switched away from an ioctl API in favor of a sysfs API (
> see patch #2 and #3).
> 
> In V9, I renamed the sysfs interface from devinfo/type to devinfo/allocation_hint.
> Moreover I renamed dev_info->type to dev_info->flags.
> 
> In V10, I renamed the tag 'PREFERRED' from PREFERRED_X to X_PREFERRED; I added
> another devinfo property, called major_minor. For now it is unused;
> the plan is to use this in btrfs-progs to go from the block device to the filesystem.
> First client will be "btrfs prop get/set allocation_hint", but I see others possible
> clients.
> Finally I made some cleanup, and remove the mount option 'allocation_hint'
> 
> In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
> to help the detection of the allocation_hint feature.
> 
> The idea behind this patches set, is to dedicate some disks (the fastest one)
> to the metadata chunk. My initial idea was a "soft" hint. However Zygo
> asked an option for a "strong" hint (== mandatory). The result is that
> each disk can be "tagged" by one of the following flags:
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> 
> When the chunk allocator search a disks to allocate a chunk, scans the disks
> in an order decided by these tags. For metadata, the order is:
> *_METADATA_ONLY
> *_METADATA_PREFERRED
> *_DATA_PREFERRED
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
> There is a dedicated btrfs-prog patches set [[PATCH V11] btrfs-progs:
> allocation_hint disk property].
> 
> $ sudo mount /dev/loop0 /mnt/test-btrfs/
> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
> devid=1, path=/dev/loop0: allocation_hint=METADATA_PREFERRED
> devid=2, path=/dev/loop1: allocation_hint=METADATA_PREFERRED
> devid=3, path=/dev/loop2: allocation_hint=DATA_PREFERRED
> devid=4, path=/dev/loop3: allocation_hint=DATA_PREFERRED
> devid=5, path=/dev/loop4: allocation_hint=DATA_PREFERRED
> devid=6, path=/dev/loop5: allocation_hint=DATA_ONLY
> devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
> devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY
> 
> $ sudo ./btrfs fi us /mnt/test-btrfs/
> Overall:
>      Device size:           2.75GiB
>      Device allocated:           1.34GiB
>      Device unallocated:           1.41GiB
>      Device missing:             0.00B
>      Used:             400.89MiB
>      Free (estimated):           1.04GiB    (min: 1.04GiB)
>      Data ratio:                  2.00
>      Metadata ratio:              1.00
>      Global reserve:           3.25MiB    (used: 0.00B)
>      Multiple profiles:                no
> 
> Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
>     /dev/loop0     288.00MiB
>     /dev/loop1     288.00MiB
>     /dev/loop2     127.00MiB
>     /dev/loop3     127.00MiB
>     /dev/loop4     127.00MiB
>     /dev/loop5     127.00MiB
> 
> Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
>     /dev/loop1     256.00MiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/loop0      32.00MiB
> 
> Unallocated:
>     /dev/loop0     704.00MiB
>     /dev/loop1     480.00MiB
>     /dev/loop2       1.00MiB
>     /dev/loop3       1.00MiB
>     /dev/loop4       1.00MiB
>     /dev/loop5       1.00MiB
>     /dev/loop6     128.00MiB
>     /dev/loop7     128.00MiB
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
> devid=3, path=/dev/loop2: allocation_hint=DATA_PREFERRED
> devid=4, path=/dev/loop3: allocation_hint=DATA_PREFERRED
> devid=5, path=/dev/loop4: allocation_hint=DATA_PREFERRED
> devid=6, path=/dev/loop5: allocation_hint=METADATA_ONLY
> devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
> devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY
> 
> $ sudo btrfs bal start --full-balance /mnt/test-btrfs/
> $ sudo ./btrfs fi us /mnt/test-btrfs/
> Overall:
>      Device size:           2.75GiB
>      Device allocated:         735.00MiB
>      Device unallocated:           2.03GiB
>      Device missing:             0.00B
>      Used:             400.72MiB
>      Free (estimated):           1.10GiB    (min: 1.10GiB)
>      Data ratio:                  2.00
>      Metadata ratio:              1.00
>      Global reserve:           3.25MiB    (used: 0.00B)
>      Multiple profiles:                no
> 
> Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
>     /dev/loop0     288.00MiB
>     /dev/loop1     288.00MiB
> 
> Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
>     /dev/loop5     127.00MiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/loop7      32.00MiB
> 
> Unallocated:
>     /dev/loop0     736.00MiB
>     /dev/loop1     736.00MiB
>     /dev/loop2     128.00MiB
>     /dev/loop3     128.00MiB
>     /dev/loop4     128.00MiB
>     /dev/loop5       1.00MiB
>     /dev/loop6     128.00MiB
>     /dev/loop7      96.00MiB
> 
> 
> #As you can see all the metadata were placed on the disk loop5/loop7 even if
> #the most empty one are loop0 and loop1.
> 
> 
> 
> Furher works:
> - the tool which show the space available should consider the tagging (eg
>    the disks tagged by _METADATA_ONLY should be excluded from the data
>    availability)
> - allow btrfs-prog to change the allocation_hint even when the filesystem
>    is not mounted.
> 
> In following emails, there will be the btrfs-progs patches set and the xfstest
> suite patches set.
> 
> 
> Comments are welcome
> BR
> G.Baroncelli
> 
> Revision:
> V11:
> - added the property /sys/fs/btrfs/features/allocation_hint
> 
> V10:
> - renamed two disk tags/constants:
>          - *_METADATA_PREFERRED -> *_METADATA_PREFERRED
>          - *_DATA_PREFERRED -> *_DATA_EFERRED
> - add /sys/fs/btrfs/$UUID/devinfo/$DEVID/major_minor
> - revise some commit description
> - refactored the code of gather_device_info(): one portion of this code
>    is moved in a separate function called sort_and_reduce_device_info()
>    for clarity.
> - removed the 'allocation_hint' mount option
> 
> V9:
> - rename dev_item->type to dev_item->flags
> - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
> 
> V8:
> - drop the ioctl API, instead use a sysfs one
> 
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
> 
> 
> Goffredo Baroncelli (7):
>    btrfs: add flags to give an hint to the chunk allocator
>    btrfs: export the device allocation_hint property in sysfs
>    btrfs: change the device allocation_hint property via sysfs
>    btrfs: add allocation_hint mode
>    btrfs: rename dev_item->type to dev_item->flags
>    btrfs: add major and minor to sysfs
>    Add /sys/fs/btrfs/features/allocation_hint
> 
>   fs/btrfs/ctree.h                |   4 +-
>   fs/btrfs/disk-io.c              |   2 +-
>   fs/btrfs/sysfs.c                | 105 +++++++++++++++++++++++++++
>   fs/btrfs/volumes.c              | 121 ++++++++++++++++++++++++++++++--
>   fs/btrfs/volumes.h              |   7 +-
>   include/uapi/linux/btrfs_tree.h |  20 +++++-
>   6 files changed, 245 insertions(+), 14 deletions(-)
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
