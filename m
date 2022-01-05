Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5105484FDD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 10:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiAEJQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 04:16:15 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:45504 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238792AbiAEJQO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 04:16:14 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-36.iol.local with ESMTPA
        id 52OunThxneQ4z52OunDbrD; Wed, 05 Jan 2022 10:16:11 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1641374171; bh=t7/fNe/lzmtklFyMh8SHhN75Baj1Hh4Sgv2wWag6EXs=;
        h=From;
        b=kTKsWi/qNqGXcQ26FdiEyopmQHOkPsQHHPBjyY1Dl86dNIcqXgUr2o0yP6S8wHt7m
         LbUdYPP4qoQBdMHJa/zN5IrLvm09wMuG9uFNU/kPZJlVhkkSuTDniZO+CKc3KtjTp6
         T5SENMhAIiCLvWmJ0XCSgXqcWDjwjQIrau2nc2b4RZ4q623on9tjNiW7sTcChgzewq
         g8MohpvwRTsg6M45TEA3XLn1e0XljeXdp9a3N/tB2BFzWqaBWn2pJtULUy//pHfDGs
         of5s6XL/OYghbsOxbuVaFn6Rf5oWXr9qhqSinXOd0HqvFBzw5EX4MsYteta8Z42El/
         KrdABTwkGr6dw==
X-CNFS-Analysis: v=2.4 cv=WK+64lgR c=1 sm=1 tr=0 ts=61d561db cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=ugnqW_ybRu3nDPTLqKQA:9 a=QEXdDO2ut3YA:10
Message-ID: <7377b63d-23a7-5efd-4ae2-cffe70463d0b@libero.it>
Date:   Wed, 5 Jan 2022 10:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it> <YdUGAg1TB8FCfqnr@zen>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YdUGAg1TB8FCfqnr@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBaeLuXquwRk/mJ9R5K5WrcZGfFh2UISrsUN9o/LwGYsd9z0icHFyV5wWX+hAo6mlhfKvKqbBbAwkYcMGexK1BoJwIVnCnbQ1qh2colSHNn82M1oQ0ac
 geSYFPNNe4NyCYPVF02VOaLqJBfNpq53Yl820ceun/WFdPbinkZIgPwR/WEKUJMkOmexVd+BYjgk2cn5F+YpFO558+vW0C194SEz8Y9qLdWm/VwsuhO/bhK2
 XhiUzW1F2AMlI1kL0Sm3D0j6shhX1xuKhDoNjkccjFjpp8IufItLlNL8zMfbeUEZIg2W7XA5qMpIqzfFQVnLY2PbteqgojGDSckAJrZBb5CWJ/bKRHV42qz+
 M4+z1RisjtMnnSXpgmkfO1NWy0HKbAZa+NX6Ct8xOsbNMYItD5/AZkaHAgou+aLvTmgpl2i0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Boris,



On 1/5/22 03:44, Boris Burkov wrote:
[...]
> 
> This is cool, thanks for building it!
> 
> I'm playing with setting this up for a test I'm working on where I want
> to send data to a dm-zero device. To that end, I applied this patchset
> on top of misc-next and ran:
> 
> $ mkfs.btrfs -f /dev/vg0/lv0 -dsingle -msingle
> $ mount /dev/vg0/lv0 /mnt/lol

You should mount the filesystem with

$ mount -o allocation_hint=1 /dev/vg0/lv0 /mnt/lol


In the previous iteration I missed the patch #6, which activates this option. You can drop patch #6 and avoid to pass this option.

Please give me a feedback if this resolve.

BR
G.Baroncelli

> $ btrfs device add /dev/mapper/zero-data /mnt/lol
> $ btrfs fi usage /mnt/lol
> Overall:
>      Device size:                  50.01TiB
>      Device allocated:             20.00MiB
>      Device unallocated:           50.01TiB
>      Device missing:                  0.00B
>      Used:                        128.00KiB
>      Free (estimated):             50.01TiB      (min: 50.01TiB)
>      Free (statfs, df):            50.01TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:                3.25MiB      (used: 0.00B)
>      Multiple profiles:                  no
> 
> Data,single: Size:8.00MiB, Used:0.00B (0.00%)
>     /dev/mapper/vg0-lv0     8.00MiB
> 
> Metadata,single: Size:8.00MiB, Used:112.00KiB (1.37%)
>     /dev/mapper/vg0-lv0     8.00MiB
> 
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>     /dev/mapper/vg0-lv0     4.00MiB
> 
> Unallocated:
>     /dev/mapper/vg0-lv0     9.98GiB
>     /dev/mapper/zero-data          50.00TiB
> 
> $ ./btrfs property set -t device /dev/mapper/zero-data allocation_hint DATA_ONLY
> $ ./btrfs property set -t device /dev/vg0/lv0 allocation_hint METADATA_ONLY
> 
> $ btrfs balance start --full-balance /mnt/lol
> Done, had to relocate 3 out of 3 chunks
> 
> $ btrfs fi usage /mnt/lol
> Overall:
>      Device size:                  50.01TiB
>      Device allocated:              2.03GiB
>      Device unallocated:           50.01TiB
>      Device missing:                  0.00B
>      Used:                        640.00KiB
>      Free (estimated):             50.01TiB      (min: 50.01TiB)
>      Free (statfs, df):            50.01TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:                3.25MiB      (used: 0.00B)
>      Multiple profiles:                  no
> 
> Data,single: Size:1.00GiB, Used:512.00KiB (0.05%)
>     /dev/mapper/zero-data           1.00GiB
> 
> Metadata,single: Size:1.00GiB, Used:112.00KiB (0.01%)
>     /dev/mapper/zero-data           1.00GiB
> 
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>     /dev/mapper/zero-data          32.00MiB
> 
> Unallocated:
>     /dev/mapper/vg0-lv0    10.00GiB
>     /dev/mapper/zero-data          50.00TiB
> 
> 
> I expected that I would have data on /dev/mapper/zero-data and metadata
> on /dev/mapper/vg0-lv0, but it seems both of them were written to the zero
> device. Attempting to actually use the file system eventually fails, since
> the metadata is black-holed :)
> 
> Did I make some mistake in how I used it, or is this a bug?
> 
> Thanks,
> Boris
> 
>> BR
>> G.Baroncelli
>>
>> Revision:
>> V9:
>> - rename dev_item->type to dev_item->flags
>> - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
>>
>> V8:
>> - drop the ioctl API, instead use a sysfs one
>>
>> V7:
>> - make more room in the struct btrfs_ioctl_dev_properties up to 1K
>> - leave in btrfs_tree.h only the costants
>> - removed the mount option (sic)
>> - correct an 'use before check' in the while loop (signaled
>>    by Zygo)
>> - add a 2nd sort to be sure that the device_info array is in the
>>    expected order
>>
>> V6:
>> - add further values to the hints: add the possibility to
>>    exclude a disk for a chunk type
>>
>>
>> Goffredo Baroncelli (6):
>>    btrfs: add flags to give an hint to the chunk allocator
>>    btrfs: export the device allocation_hint property in sysfs
>>    btrfs: change the device allocation_hint property via sysfs
>>    btrfs: add allocation_hint mode
>>    btrfs: rename dev_item->type to dev_item->flags
>>    btrfs: add allocation_hint option.
>>
>>   fs/btrfs/ctree.h                |  18 +++++-
>>   fs/btrfs/disk-io.c              |   4 +-
>>   fs/btrfs/super.c                |  17 ++++++
>>   fs/btrfs/sysfs.c                |  73 ++++++++++++++++++++++
>>   fs/btrfs/volumes.c              | 105 ++++++++++++++++++++++++++++++--
>>   fs/btrfs/volumes.h              |   7 ++-
>>   include/uapi/linux/btrfs_tree.h |  20 +++++-
>>   7 files changed, 232 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.34.1
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
