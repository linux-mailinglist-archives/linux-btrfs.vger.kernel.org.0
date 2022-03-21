Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575674E31D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 21:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353367AbiCUUcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbiCUUb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 16:31:57 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 13:30:29 PDT
Received: from libero.it (smtp-32-i6.italiaonline.it [213.209.14.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CE82D1A
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 13:30:29 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-32.iol.local with ESMTPA
        id WOebngnlOptnyWOebnZQLz; Mon, 21 Mar 2022 21:29:25 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1647894566; bh=0b9wT2vLNDfkVs7Nm19l93qEUP4dpVGq79k5OXGR7vQ=;
        h=From;
        b=Y+k82BGvPvCOD68vTT1mSU08Wsyx86eGWVbpv+DPnT4yjdu+oPtWr1aQ0Z8GxHzoa
         ZlTgiuraFO3YER+M6N3sdXIf0lKa5xrwCjc+l2Oc+ZZnld8/dIH2OkNi47kxikRbpd
         A4AsKZdthNYvYNRdmg8FiIjTxApkQ6PjM4CSTN9xbQGUNiyUkNkr6xdNuEq4DUlxFJ
         SmIrM09pb6jpWT53EemaC6owQzBmn9y4zyerh845zPdKwPcoaZFHJXSQA4V73pASxI
         /rqnO5/NLN+XNkJ2JXCiFW6Xg7L7NBQijRINymQEr62FHDzMO0L+X68IjQn006+h/Z
         EMWmwY81FI3yg==
X-CNFS-Analysis: v=2.4 cv=fIX8YbWe c=1 sm=1 tr=0 ts=6238e025 cx=a_exe
 p=kT-NTsFwAAAA:8 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Nzt9PIjX-G4oH9b5Kc4A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=TLwuWKmryFjkTYsgBL5T:22
Message-ID: <7644137c-b6ac-6503-f533-c1ad6821d81d@libero.it>
Date:   Mon, 21 Mar 2022 21:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/5][V12] btrfs: allocation_hint
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1646589622.git.kreijack@inwind.it>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <cover.1646589622.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO0jb1GE7HQQy2oZYtL26rSa2CbNM9vg7Uqj79oN3nCkzhOjy+egdcXC1OuJvv+K+4k8q/Uivx7Wg+0EKRzFfahJS6ZTdh72qMSkoarU/wX3VewgJAyC
 8Tl4MZ3Plqgeq95A9k+mMACJzFey3O4hUfYYiS1sM1mLzlsRP8USdPVowfxBDnyP7fjWx0MIkTgsRbzk7mnj7jgjBSUa28PHofuMIC76/TWfs1JFyhJtUGm4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping
On 06/03/2022 19.14, Goffredo Baroncelli wrote:
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
> the plan is to use this in btrfs-progs to go from the block device to the
> filesystem.
> First client will be "btrfs prop get/set allocation_hint", but I see others
> possible clients.
> Finally I made some cleanup, and remove the mount option 'allocation_hint'
> 
> In V12 I removed some features introduced in V11 (like major_minor sysfs
> filed and the 'feature' file) and changed the values to write in the
> sysfs files: until V12 the values are numericals ones. Now are strings ones:
> - METADATA_ONLY
> - METADATA_PREFERRED
> - DATA_PREFERRED
> - DATA_ONLY
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
> Furher works:
> - the tool which show the space available should consider the tagging (eg
>    the disks tagged by _METADATA_ONLY should be excluded from the data
>    availability)
> - allow btrfs-prog to change the allocation_hint even when the filesystem
>    is not mountead.
> 
> In following emails, there will be the btrfs-progs patches set and the xfstest
> suite patches set.
> 
> Comments are welcome
> BR
> G.Baroncelli
> 
> Revision:
> V12:
> - removed the property /sys/fs/btrfs/features/allocation_hint
> - changed the value to write in <devid>/allocation hint from numericals one
>    to string one (METADATA_PREFERRED, DATA_ONLY....)
> - removed major_minor sysfs field (added in v11)
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
> Goffredo Baroncelli (5):
>    btrfs: add flags to give an hint to the chunk allocator
>    btrfs: export the device allocation_hint property in sysfs
>    btrfs: change the device allocation_hint property via sysfs
>    btrfs: add allocation_hint mode
>    btrfs: rename dev_item->type to dev_item->flags
> 
>   fs/btrfs/ctree.h                |   4 +-
>   fs/btrfs/disk-io.c              |   2 +-
>   fs/btrfs/sysfs.c                | 106 ++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c              | 121 ++++++++++++++++++++++++++++++--
>   fs/btrfs/volumes.h              |   7 +-
>   include/uapi/linux/btrfs_tree.h |  20 +++++-
>   6 files changed, 246 insertions(+), 14 deletions(-)
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
