Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC51D48581E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiAESYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 13:24:23 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:51732 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242861AbiAESYW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 13:24:22 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 13:24:22 EST
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-33.iol.local with ESMTPA
        id 5ApRntD6Q06Tn5ApRnL9W9; Wed, 05 Jan 2022 19:16:08 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1641406568; bh=FrFarJoQCnoTqgY2pSW39Gkxo8xGiSXtECsafHDXHS8=;
        h=From;
        b=aI/m4o6+QLcBLEANnl3iOl1Qzjq+PEKn0LISUkUt/lyNk8KaqMH6jSIGfsEg07Vh7
         t/llEKXCshKYRZ5rnwzIJ6vCV/40EpuTe0j/dNsmA3vEXxFKrO6MD06hp2LdkXx1Zp
         me4bRYST4KzbXUjpZMfs4PeJfkUzQTuhqroM1Ypfirha/HSCfOIjKUo8kJlTxKknX3
         +DR7DvN/NSQS8fhhioQM9RCkf22Cc3nlZGXwEPjI8IwZjsBLNqQxEfUVSWVSVB0BXr
         nk+h2uI0MUZt2lo8kl/s8fFFy/+nV/BDyBrZ9JtBRvNdYZGdW5BhejlO+icTKgAohH
         +P+ZgGNc5JoYw==
X-CNFS-Analysis: v=2.4 cv=YqbK+6UX c=1 sm=1 tr=0 ts=61d5e068 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=Jhuixi39F6q2sPx7b7AA:9 a=QEXdDO2ut3YA:10
Message-ID: <88a62f44-ae3f-f4b4-d2d7-6d82efd60933@inwind.it>
Date:   Wed, 5 Jan 2022 19:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>
References: <cover.1639766364.git.kreijack@inwind.it> <YdUGAg1TB8FCfqnr@zen>
 <7377b63d-23a7-5efd-4ae2-cffe70463d0b@libero.it>
 <YdXeepXbRpbADrJf@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <YdXeepXbRpbADrJf@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJE7ILT0eRSsa2W3TFGTy0OcZm91Tf1eH1FR6mx1zcKjLE+OELgf1E6n6smgm2N3Ghmcnb5R4GbgxM9n3ETv5hdExLUwabD0Ntq7y9+WEdfsfAaNC/eM
 2dZOIdEY9TFi50phPJ4/nSE8kyEehJ49S8THfH5MdHalVtmKxJ5HR6bPe9Fhu0S2c6t1qAPvECCIR9qN0HmQ3pXl0zPylKsTrsM4Xv3VHq90w76NTCmoRjHB
 F4eTY1WapRHUhXWm8HCKZBI+//ZWHHfuGc3+vu6Iz5ah4f7/s2TohTC8XZlVhE5XilAqZ7irKfUCiPxZJJIQYaqozqkGNtQ1OKoneZvCTaRi9+D5OXUK12pm
 N1kSnktMQouJC0gwXHNMDAxOMeylOA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/01/2022 19.07, Zygo Blaxell wrote:
> On Wed, Jan 05, 2022 at 10:16:08AM +0100, Goffredo Baroncelli wrote:
>> Hi Boris,
>>
>>
>>
>> On 1/5/22 03:44, Boris Burkov wrote:
>> [...]
>>>
>>> This is cool, thanks for building it!
>>>
>>> I'm playing with setting this up for a test I'm working on where I want
>>> to send data to a dm-zero device. To that end, I applied this patchset
>>> on top of misc-next and ran:
>>>
>>> $ mkfs.btrfs -f /dev/vg0/lv0 -dsingle -msingle
>>> $ mount /dev/vg0/lv0 /mnt/lol
>>
>> You should mount the filesystem with
>>
>> $ mount -o allocation_hint=1 /dev/vg0/lv0 /mnt/lol
>>
>> In the previous iteration I missed the patch #6, which activates this option. You can drop patch #6 and avoid to pass this option.
> 
> Can we drop the mount option from the series?  It isn't needed.
> 
> Or, if we must have it (and I am in no way conceding that we do),
> at least make it default to enabled.  Or turn the mount option into a
> disable flag under the 'rescue=' option to make it clear this option is
> not intended to be used in normal operation.

Frankly speaking it was a my mistake to add this patch. It was in the
queue, but in the last patches sets I dropped it. However in the last
one I forgot to drop it manually so it reappeared :-)

However I like your suggestion to add as 'rescue' option, where the
default is "enabled".

@Josef,
do you started to play with this patch ? If not can I send an update
where the main change is the renaming of the properties from

PREFERRED_<X> to <X>_PREFERRED

(e.g. PREFERRED_DATA to DATA_PREFERRED) which are more correct ?

BR
G.Baroncelli
> 
>> Please give me a feedback if this resolve.
>>
>> BR
>> G.Baroncelli
>>
>>> $ btrfs device add /dev/mapper/zero-data /mnt/lol
>>> $ btrfs fi usage /mnt/lol
>>> Overall:
>>>       Device size:                  50.01TiB
>>>       Device allocated:             20.00MiB
>>>       Device unallocated:           50.01TiB
>>>       Device missing:                  0.00B
>>>       Used:                        128.00KiB
>>>       Free (estimated):             50.01TiB      (min: 50.01TiB)
>>>       Free (statfs, df):            50.01TiB
>>>       Data ratio:                       1.00
>>>       Metadata ratio:                   1.00
>>>       Global reserve:                3.25MiB      (used: 0.00B)
>>>       Multiple profiles:                  no
>>>
>>> Data,single: Size:8.00MiB, Used:0.00B (0.00%)
>>>      /dev/mapper/vg0-lv0     8.00MiB
>>>
>>> Metadata,single: Size:8.00MiB, Used:112.00KiB (1.37%)
>>>      /dev/mapper/vg0-lv0     8.00MiB
>>>
>>> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>>>      /dev/mapper/vg0-lv0     4.00MiB
>>>
>>> Unallocated:
>>>      /dev/mapper/vg0-lv0     9.98GiB
>>>      /dev/mapper/zero-data          50.00TiB
>>>
>>> $ ./btrfs property set -t device /dev/mapper/zero-data allocation_hint DATA_ONLY
>>> $ ./btrfs property set -t device /dev/vg0/lv0 allocation_hint METADATA_ONLY
>>>
>>> $ btrfs balance start --full-balance /mnt/lol
>>> Done, had to relocate 3 out of 3 chunks
>>>
>>> $ btrfs fi usage /mnt/lol
>>> Overall:
>>>       Device size:                  50.01TiB
>>>       Device allocated:              2.03GiB
>>>       Device unallocated:           50.01TiB
>>>       Device missing:                  0.00B
>>>       Used:                        640.00KiB
>>>       Free (estimated):             50.01TiB      (min: 50.01TiB)
>>>       Free (statfs, df):            50.01TiB
>>>       Data ratio:                       1.00
>>>       Metadata ratio:                   1.00
>>>       Global reserve:                3.25MiB      (used: 0.00B)
>>>       Multiple profiles:                  no
>>>
>>> Data,single: Size:1.00GiB, Used:512.00KiB (0.05%)
>>>      /dev/mapper/zero-data           1.00GiB
>>>
>>> Metadata,single: Size:1.00GiB, Used:112.00KiB (0.01%)
>>>      /dev/mapper/zero-data           1.00GiB
>>>
>>> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>>>      /dev/mapper/zero-data          32.00MiB
>>>
>>> Unallocated:
>>>      /dev/mapper/vg0-lv0    10.00GiB
>>>      /dev/mapper/zero-data          50.00TiB
>>>
>>>
>>> I expected that I would have data on /dev/mapper/zero-data and metadata
>>> on /dev/mapper/vg0-lv0, but it seems both of them were written to the zero
>>> device. Attempting to actually use the file system eventually fails, since
>>> the metadata is black-holed :)
>>>
>>> Did I make some mistake in how I used it, or is this a bug?
>>>
>>> Thanks,
>>> Boris
>>>
>>>> BR
>>>> G.Baroncelli
>>>>
>>>> Revision:
>>>> V9:
>>>> - rename dev_item->type to dev_item->flags
>>>> - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
>>>>
>>>> V8:
>>>> - drop the ioctl API, instead use a sysfs one
>>>>
>>>> V7:
>>>> - make more room in the struct btrfs_ioctl_dev_properties up to 1K
>>>> - leave in btrfs_tree.h only the costants
>>>> - removed the mount option (sic)
>>>> - correct an 'use before check' in the while loop (signaled
>>>>     by Zygo)
>>>> - add a 2nd sort to be sure that the device_info array is in the
>>>>     expected order
>>>>
>>>> V6:
>>>> - add further values to the hints: add the possibility to
>>>>     exclude a disk for a chunk type
>>>>
>>>>
>>>> Goffredo Baroncelli (6):
>>>>     btrfs: add flags to give an hint to the chunk allocator
>>>>     btrfs: export the device allocation_hint property in sysfs
>>>>     btrfs: change the device allocation_hint property via sysfs
>>>>     btrfs: add allocation_hint mode
>>>>     btrfs: rename dev_item->type to dev_item->flags
>>>>     btrfs: add allocation_hint option.
>>>>
>>>>    fs/btrfs/ctree.h                |  18 +++++-
>>>>    fs/btrfs/disk-io.c              |   4 +-
>>>>    fs/btrfs/super.c                |  17 ++++++
>>>>    fs/btrfs/sysfs.c                |  73 ++++++++++++++++++++++
>>>>    fs/btrfs/volumes.c              | 105 ++++++++++++++++++++++++++++++--
>>>>    fs/btrfs/volumes.h              |   7 ++-
>>>>    include/uapi/linux/btrfs_tree.h |  20 +++++-
>>>>    7 files changed, 232 insertions(+), 12 deletions(-)
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>
>>
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
