Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A399742A14A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhJLJnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 05:43:23 -0400
Received: from kchapman.de ([185.230.160.25]:34412 "EHLO kchapman.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235581AbhJLJnX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 05:43:23 -0400
Received: from [10.68.21.93] (unknown [141.70.80.5])
        by kchapman.de (Postfix) with ESMTPSA id 8D6A360056;
        Tue, 12 Oct 2021 11:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kchapman.de;
        s=20180107; t=1634031680;
        bh=ZIa1qu+Nsd8RH/Qz6eZe9UZRDdJMx3VAaCEdgut3Olk=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=DSDSXOhuVqRGaBe1FFc6i/k/ffpkIn2VUQ6qizE5/nf3/5rJg6fmO1Wpv3WiIIU0T
         0KLsTqHTEIBGb2rUVXdvuWTWEiRc2ySeNCyAehSlqUKR++eO31P6F/BfSMbMR4sQKm
         t3z5773OrKzGNNwDg0fAg1u1NhDfR6bUBvmwCC1c1/25j+kkzLgPMfmNo6UBeR4VCk
         wVohyD2WOZcAtLwX/7I0/BOFruqTtTrXEOfPRr46+ZR9IPfL9FRktMQFAktfMFXfiv
         yNTLVtLf6aihyl5UteWUw5PlRuxqU/eRUju3BOANvdWhqIN729TiouGqFtCNXi7zIW
         nS562LBcM2mMw==
Subject: Re: All Three Superblocks Damaged After Kernel Panic
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <fa22-61644680-fb-24052640@191566126>
 <91bf1af1-494b-ee3a-01c9-07a4ad836eb7@gmx.com>
From:   K Chapman <mailbox@kchapman.de>
Message-ID: <5d8526c2-425d-fef6-833f-2164c0bf754a@kchapman.de>
Date:   Tue, 12 Oct 2021 09:41:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <91bf1af1-494b-ee3a-01c9-07a4ad836eb7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-DK
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you so much for the help! I have images of my projects and dog 
which passed away among other things I would like to save. Make a backup 
is fine to say, but I am a student and have not had much luck earning to 
buy a new hdd in this foreign country.

Re:
Any idea on what part is causing the panic, or any log/screenshot of the
panic message?

This remains unclear. I did not photograph the kernel panic and I have 
no log of the error. The two actions which I performed at the time was 
the execution of the reboot command and unplugging the usb stick. I then 
looked at the screen and saw a panic message and then hit the power 
switch on the power supply and reset the machine.


Re:  Mind to dump the full super block with "btrfs ins dump-super -Ffa"?

sudo btrfs ins dump-super -Ffa /dev/mapper/home :

superblock: bytenr=65536, device=/dev/mapper/home
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0xc59083ff [DON'T MATCH]
bytenr            65536
flags            0x1
             ( WRITTEN )
magic            _BHRfS_M [match]
fsid            bd5872ad-8fee-4d90-b048-b81120ce3254
metadata_uuid        bd5872ad-8fee-4d90-b048-b81120ce3254
label
generation        161054
root            4028020703232
sys_array_size        129
chunk_root_generation    154912
root_level        1
chunk_root        22020096
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        4000787030016
bytes_used        3969357348864
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x161
             ( MIXED_BACKREF |
               BIG_METADATA |
               EXTENDED_IREF |
               SKINNY_METADATA )
cache_generation    161054
uuid_tree_generation    161054
dev_item.uuid        47593c4d-689d-4e1e-a310-dc7b8ab26c51
dev_item.fsid        bd5872ad-8fee-4d90-b048-b81120ce3254 [match]
dev_item.type        0
dev_item.total_bytes    4000787030016
dev_item.bytes_used    3997564731392
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
     item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
         length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
         io_align 65536 io_width 65536 sector_size 4096
         num_stripes 2 sub_stripes 1
             stripe 0 devid 1 offset 22020096
             dev_uuid 47593c4d-689d-4e1e-a310-dc7b8ab26c51
             stripe 1 devid 1 offset 30408704
             dev_uuid 47593c4d-689d-4e1e-a310-dc7b8ab26c51
backup_roots[4]:
     backup 0:
         backup_tree_root:    4028018622464    gen: 161053 level: 1
         backup_chunk_root:    22020096    gen: 154912    level: 1
         backup_extent_root:    4028018229248    gen: 161053 level: 2
         backup_fs_root:        4028019884032    gen: 161054 level: 3
         backup_dev_root:    4027637743616    gen: 161049    level: 1
         backup_csum_root:    4028020047872    gen: 161054 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969357348864
         backup_num_devices:    1

     backup 1:
         backup_tree_root:    4028020703232    gen: 161054 level: 1
         backup_chunk_root:    22020096    gen: 154912    level: 1
         backup_extent_root:    4028020277248    gen: 161054 level: 2
         backup_fs_root:        4028021620736    gen: 161054 level: 3
         backup_dev_root:    4027637743616    gen: 161049    level: 1
         backup_csum_root:    4028020326400    gen: 161054 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969357348864
         backup_num_devices:    1

     backup 2:
         backup_tree_root:    4027794194432    gen: 161051 level: 1
         backup_chunk_root:    22020096    gen: 154912    level: 1
         backup_extent_root:    4027793915904    gen: 161051 level: 2
         backup_fs_root:        4027794866176    gen: 161051 level: 3
         backup_dev_root:    4027637743616    gen: 161049    level: 1
         backup_csum_root:    4027793981440    gen: 161051 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969416499200
         backup_num_devices:    1

     backup 3:
         backup_tree_root:    4028014985216    gen: 161052 level: 1
         backup_chunk_root:    22020096    gen: 154912    level: 1
         backup_extent_root:    4027953004544    gen: 161052 level: 2
         backup_fs_root:        4027876769792    gen: 161052 level: 3
         backup_dev_root:    4027637743616    gen: 161049    level: 1
         backup_csum_root:    4027969748992    gen: 161052 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969357332480
         backup_num_devices:    1


superblock: bytenr=67108864, device=/dev/mapper/home
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x65f1ab31 [DON'T MATCH]
bytenr            14039944498490823899
flags            0xcdc898509422934d
             ( WRITTEN |
               unknown flag: 0xcdc898509422934c )
magic            _BHRfS_M [match]
fsid            4468b2e4-d249-639c-dc54-792caf170cc9
metadata_uuid        4468b2e4-d249-639c-dc54-792caf170cc9
label
generation        161054
root            4028020703232
sys_array_size        129
chunk_root_generation    154912
root_level        1
chunk_root        22020096
chunk_root_level    1
log_root        11922660382425005768
log_root_transid    14582268926853107316
log_root_level        0
total_bytes        10532150587539085458
bytes_used        8124524553913841719
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x161
             ( MIXED_BACKREF |
               BIG_METADATA |
               EXTENDED_IREF |
               SKINNY_METADATA )
cache_generation    161054
uuid_tree_generation    161054
dev_item.uuid        47593c4d-689d-4e1e-a310-dc7b8ab26c51
dev_item.fsid        bd5872ad-8fee-4d90-b048-b81120ce3254 [DON'T MATCH]
dev_item.type        0
dev_item.total_bytes    4000787030016
dev_item.bytes_used    3997564731392
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
     item 0 key (288472139764826295 UNKNOWN.227 16728631262381099805)
ERROR: unexpected item type 227 in sys_array at offset 17
backup_roots[4]:
     backup 0:
         backup_tree_root:    2937111841462972043    gen: 
6902395341942098838    level: 1
         backup_chunk_root:    17657898596786216606    gen: 
1348021672883110445    level: 1
         backup_extent_root:    11170562329367461854    gen: 
11756089894903112279    level: 2
         backup_fs_root:        10659646040436297474    gen: 
2903212909590398647    level: 3
         backup_dev_root:    14579526832388012464    gen: 
4376531062597251514    level: 1
         backup_csum_root:    4242763241112    gen: 161054 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969357348864
         backup_num_devices:    1

     backup 1:
         backup_tree_root:    4028020703232    gen: 161054 level: 198
         backup_chunk_root:    22020096    gen: 154912    level: 243
         backup_extent_root:    4028020277248    gen: 
16089197629711480094    level: 206
         backup_fs_root:        5604276798285345924    gen: 
10182153286217385848    level: 58
         backup_dev_root:    12659493148880815901    gen: 
9869374175363434348    level: 78
         backup_csum_root:    8949053250522901049    gen: 
5400723786290947185    level: 164
         backup_total_bytes:    15031814655203781796
         backup_bytes_used:    1855277020722950832
         backup_num_devices:    13548686937124434823

     backup 2:
         backup_tree_root:    4043263646859    gen: 161051 level: 1
         backup_chunk_root:    22020096    gen: 154912    level: 1
         backup_extent_root:    4027793915904    gen: 161051 level: 2
         backup_fs_root:        4027794866176    gen: 161051 level: 3
         backup_dev_root:    4027637743616    gen: 161049    level: 1
         backup_csum_root:    4027793981440    gen: 161051 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969416499200
         backup_num_devices:    1

     backup 3:
         backup_tree_root:    4028014985216    gen: 161052 level: 78
         backup_chunk_root:    22020096    gen: 154912    level: 70
         backup_extent_root:    4027953004544    gen: 161052 level: 16
         backup_fs_root:        4027876769792    gen: 161052 level: 11
         backup_dev_root:    4027637743616    gen: 161049    level: 125
         backup_csum_root:    4027969748992    gen: 
15626176790580589852    level: 222
         backup_total_bytes:    18338658601355635447
         backup_bytes_used:    12906905608640099773
         backup_num_devices:    11951688830094275180


superblock: bytenr=274877906944, device=/dev/mapper/home
---------------------------------------------------------
csum_type        62267 (INVALID)
csum_size        32
csum 0x9876fd0000000000000000000000000000000000000000000000000000000000 
[UNKNOWN CSUM TYPE OR SIZE]
bytenr            274877906944
flags            0x1
             ( WRITTEN )
magic            _BHRfS_M [match]
fsid            bd5872ad-8fee-4d90-b048-b81120ce3254
metadata_uuid        07eb556b-df56-afbd-12c1-32f496c9ae5e
label 
...^k...cA..[....ws.......!...&+..@...U.^..Fi.....^s....%.....G.....\..z.0..8N......l
generation        161054
root            4028020703232
sys_array_size        1346087890
chunk_root_generation    14973196025592430218
root_level        113
chunk_root        22020096
chunk_root_level    54
log_root        0
log_root_transid    0
log_root_level        77
total_bytes        4000787030016
bytes_used        3969357348864
sectorsize        544999736
nodesize        1626255393
leafsize (deprecated)    365786189
stripesize        1625894637
root_dir        4621774357935484814
num_devices        6281988177397337675
compat_flags        0x9c8dbbf37bf3e638
compat_ro_flags        0xe392e94b904707de
             ( FREE_SPACE_TREE_VALID |
               unknown flag: 0xe392e94b904707dc )
incompat_flags        0xe7c3113fe08815af
             ( MIXED_BACKREF |
               DEFAULT_SUBVOL |
               MIXED_GROUPS |
               COMPRESS_LZO |
               BIG_METADATA |
               RAID56 |
               SKINNY_METADATA |
               METADATA_UUID |
               ZONED |
               unknown flag: 0xe7c3113fe0880000 )
cache_generation    2740636164699663627
uuid_tree_generation    143387309824099247
dev_item.uuid        8ca1383a-3aaf-986e-30f3-1081cc4423b9
dev_item.fsid        d3b80203-160e-b664-1fa0-0121596e5fbf [DON'T MATCH]
dev_item.type        2243501307224589742
dev_item.total_bytes    17886909296177165879
dev_item.bytes_used    843442598421986990
dev_item.io_align    3037217492
dev_item.io_width    3952451380
dev_item.sector_size    2707671125
dev_item.devid        4105250638360812501
dev_item.dev_group    3766056873
dev_item.seek_speed    182
dev_item.bandwidth    229
dev_item.generation    9452573969509059034
sys_chunk_array[2048]:
ERROR: sys_array_size 1346087890 shouldn't exceed 2048 bytes
backup_roots[4]:
     backup 0:
         backup_tree_root:    4028018622464    gen: 161053 level: 243
         backup_chunk_root:    22020096    gen: 154912    level: 189
         backup_extent_root:    4028018229248    gen: 161053 level: 184
         backup_fs_root:        4028019884032    gen: 161054 level: 247
         backup_dev_root:    4027637743616    gen: 161049    level: 241
         backup_csum_root:    11051166811494301696    gen: 
11918979514504630695    level: 43
         backup_total_bytes:    6128247333213658072
         backup_bytes_used:    13316083672891396332
         backup_num_devices:    12986852272682621048

     backup 1:
         backup_tree_root:    11912830949670804138    gen: 
4162465539222756018    level: 1
         backup_chunk_root:    10938026073880195285    gen: 
8406240668729036675    level: 1
         backup_extent_root:    17210210806549355879    gen: 
455024150221    level: 2
         backup_fs_root:        4028021620736    gen: 161054 level: 3
         backup_dev_root:    4027637743616    gen: 161049    level: 1
         backup_csum_root:    4028020326400    gen: 161054 level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969357348864
         backup_num_devices:    1

     backup 2:
         backup_tree_root:    12811350786919235584    gen: 
3323034891246254263    level: 217
         backup_chunk_root:    17845957508331272086    gen: 
12071669715000553588    level: 235
         backup_extent_root:    2368736995830619850    gen: 
14589654675806411696    level: 163
         backup_fs_root:        7496041380651946087    gen: 
16394240941193014637    level: 29
         backup_dev_root:    11890518936409562630    gen: 
11935615530850632810    level: 174
         backup_csum_root:    4804084557218082292    gen: 
3037656397741716549    level: 57
         backup_total_bytes:    12628714618049392498
         backup_bytes_used:    4517632456508041139
         backup_num_devices:    11559351643267246189

     backup 3:
         backup_tree_root:    9502548224584054781    gen: 
3258916775715815651    level: 1
         backup_chunk_root:    2996837717780471142    gen: 
9778119635099568422    level: 1
         backup_extent_root:    2696351959151677890    gen: 
5061715638962835499    level: 2
         backup_fs_root:        16900363948952743119    gen: 
2413589847950453178    level: 3
         backup_dev_root:    18344731769370366813    gen: 
11720350780674912754    level: 1
         backup_csum_root:    6130366103217558429    gen: 
598304231798    level: 3
         backup_total_bytes:    4000787030016
         backup_bytes_used:    3969357332480
         backup_num_devices:    1


On 12.10.21 01:22, Qu Wenruo wrote:
>
>
> On 2021/10/11 22:13, Kyle James Chapman wrote:
>> Hello,
>>
>> I lost access to my home BTRFS filesystem on a 4TB SATA drive without 
>> partitioning today.
>>
>> I am a graduate student of translation studies at a foreign 
>> university. Programming is not my specialty but have ran Linux for 
>> over a decade because I support open source endeavors. I say this for 
>> background on my technical capabilities, I am also a radio amateur 
>> extra-class in the United States. I have some technical competence 
>> and run Arch Linux for general duty.
>>
>> The system boots and reads the kernel into memory from an optical ROM 
>> drive, reads keyfiles from a USB stick, decrypts the home and swap 
>> partitions on different devices, asks for a password for the root 
>> partition, and finishes booting. I was rebooting my system from 
>> userspace and observed a kernel panic after finishing some work 
>> repartitioning a small USB stick using gparted.
>
> Any idea on what part is causing the panic, or any log/screenshot of the
> panic message?
>
>> After rebooting, my home BTRFS system was not mountable. Some 
>> information seems present in some of the superblocks, but I do not 
>> understand everything. I was careful in my use of the disk tool, and 
>> it was clear that only the USB stick was being accessed, because of 
>> the simple work I was doing, resizing a partition on the obvious 
>> drive. I would like to recover the data. I finished writing my 
>> master's thesis and have already submitted it, so no real work was 
>> lost, but I would like to understand why this is happening and how 
>> the data can be recovered. A memory fault seems plausible, but the 
>> fact that I was accessing the partitions (through gparted) seems to 
>> indicate other possibilities. Please do not get sidetracked into 
>> thinking I wrote data on the drive through carelessness. I have made 
>> many many uses of disk tools throughout my life and the simple nature 
>> of the operations which did not involve the filesystem in question 
>> are completely understandable and I remember them clearly.
>>
>> Please advise.
>>
>> Relevant /dev/fstab entry which has worked for several months until I 
>> commented it out today:
>>
>> #/dev/mapper/home    /home        btrfs 
>> rw,compress,autodefrag,inode_cache    0   1
>
> Inode cache is already deprecated, but it won't do anything to the
> kernel, thus it shouldn't cause any problem.
>
>>
>> cat /proc/version:
>>
>> Linux version 5.15.0-rc3-1-git-00319-g7b66f4393ad4 
>> (linux-git@archlinux) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 
>> 2.36.1) #1 SMP PREEMPT Sun, 03 Oct 2021 17:24:26 +0000
>>
>>
>> sudo  smartctl -a /dev/sdd excerpt:
>>
>> === START OF INFORMATION SECTION ===
>> Model Family:     Seagate Barracuda 2.5 5400
>> Device Model:     ST4000LM024-2AN17V
>> Serial Number:    WCK03H8Y
>> LU WWN Device Id: 5 000c50 09e55827b
>> Firmware Version: 0001
>> User Capacity:    4,000,787,030,016 bytes [4.00 TB]
>> Sector Sizes:     512 bytes logical, 4096 bytes physical
>> Rotation Rate:    5526 rpm
>> Form Factor:      2.5 inches
>> Device is:        In smartctl database [for details use: -P show]
>> ATA Version is:   ACS-3 T13/2161-D revision 5
>> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
>> Local Time is:    Mon Oct 11 16:07:49 2021 CEST
>> SMART support is: Available - device has SMART capability.
>> SMART support is: Enabled
>>
>> === START OF READ SMART DATA SECTION ===
>> SMART overall-health self-assessment test result: PASSED
>>
>> btrfs --version:
>>
>> btrfs-progs v5.14.1
>>
>>
>> sudo btrfs inspect-internal dump-super -s 0 /dev/mapper/home :
>>
>> superblock: bytenr=65536, device=/dev/mapper/home
>
> The first copy in fact looks pretty good.
>
> If there is something wrong, then it would be in the backup roots or sys
> chunk map.
>
> Mind to dump the full super block with "btrfs ins dump-super -Ffa"?
>> ---------------------------------------------------------
>> csum_type        0 (crc32c)
>> csum_size        4
>> csum            0xc59083ff [DON'T MATCH]
>> bytenr            65536
>> flags            0x1
>>             ( WRITTEN )
>> magic            _BHRfS_M [match]
>> fsid            bd5872ad-8fee-4d90-b048-b81120ce3254
>> metadata_uuid        bd5872ad-8fee-4d90-b048-b81120ce3254
>> label
>> generation        161054
>> root            4028020703232
>> sys_array_size        129
>> chunk_root_generation    154912
>> root_level        1
>> chunk_root        22020096
>> chunk_root_level    1
>> log_root        0
>> log_root_transid    0
>> log_root_level        0
>> total_bytes        4000787030016
>> bytes_used        3969357348864
>> sectorsize        4096
>> nodesize        16384
>> leafsize (deprecated)    16384
>> stripesize        4096
>> root_dir        6
>> num_devices        1
>> compat_flags        0x0
>> compat_ro_flags        0x0
>> incompat_flags        0x161
>>             ( MIXED_BACKREF |
>>               BIG_METADATA |
>>               EXTENDED_IREF |
>>               SKINNY_METADATA )
>> cache_generation    161054
>> uuid_tree_generation    161054
>> dev_item.uuid        47593c4d-689d-4e1e-a310-dc7b8ab26c51
>> dev_item.fsid        bd5872ad-8fee-4d90-b048-b81120ce3254 [match]
>> dev_item.type        0
>> dev_item.total_bytes    4000787030016
>> dev_item.bytes_used    3997564731392
>> dev_item.io_align    4096
>> dev_item.io_width    4096
>> dev_item.sector_size    4096
>> dev_item.devid        1
>> dev_item.dev_group    0
>> dev_item.seek_speed    0
>> dev_item.bandwidth    0
>> dev_item.generation    0
>>
>> sudo btrfs inspect-internal dump-super -s 1 /dev/mapper/home :
>>
>> superblock: bytenr=67108864, device=/dev/mapper/home
>> ---------------------------------------------------------
>> csum_type        0 (crc32c)
>> csum_size        4
>> csum            0x65f1ab31 [DON'T MATCH]
>> bytenr            14039944498490823899
>> flags            0xcdc898509422934d
>>             ( WRITTEN |
>>               unknown flag: 0xcdc898509422934c )
>
> The 2nd one begins to have some garbage, but not yet full of garbage.
>
> This means there are some writes into the 2nd super block, and mostly
> the writes are just into part of the super block.
>
>> magic            _BHRfS_M [match]
>> fsid            4468b2e4-d249-639c-dc54-792caf170cc9
>> metadata_uuid        4468b2e4-d249-639c-dc54-792caf170cc9
>
> The UUID is damaged.
>
>> label
>> generation        161054
>> root            4028020703232 > sys_array_size        129
>> chunk_root_generation    154912
>> root_level        1
>> chunk_root        22020096
>> chunk_root_level    1
>
> But then some good data.
>
>> log_root        11922660382425005768
>> log_root_transid    14582268926853107316
>> log_root_level        0
>> total_bytes        10532150587539085458
>> bytes_used        8124524553913841719
>
> Some garbage again.
>
> I don't think it can be even caused by simple memory corruption, too
> many random part gets corrupted.
>
> It's really hard to say if btrfs itself is involved, until we see the
> calltrace.
>
>
> For the recovery, the superblock needs to be manually fixed to allow any
> further data salvage attempts.
>
> And that can only be done with the extra "btrfs ins dump-super -Ffa" 
> output.
>
> Thanks,
> Qu
>
>> sectorsize        4096
>> nodesize        16384
>> leafsize (deprecated)    16384
>> stripesize        4096
>> root_dir        6
>> num_devices        1
>> compat_flags        0x0
>> compat_ro_flags        0x0
>> incompat_flags        0x161
>>             ( MIXED_BACKREF |
>>               BIG_METADATA |
>>               EXTENDED_IREF |
>>               SKINNY_METADATA )
>> cache_generation    161054
>> uuid_tree_generation    161054
>> dev_item.uuid        47593c4d-689d-4e1e-a310-dc7b8ab26c51
>> dev_item.fsid        bd5872ad-8fee-4d90-b048-b81120ce3254 [DON'T MATCH]
>> dev_item.type        0
>> dev_item.total_bytes    4000787030016
>> dev_item.bytes_used    3997564731392
>> dev_item.io_align    4096
>> dev_item.io_width    4096
>> dev_item.sector_size    4096
>> dev_item.devid        1
>> dev_item.dev_group    0
>> dev_item.seek_speed    0
>> dev_item.bandwidth    0
>> dev_item.generation    0
>>
>> sudo btrfs inspect-internal dump-super -s 2 /dev/mapper/home:
>>
>> superblock: bytenr=274877906944, device=/dev/mapper/home
>> ---------------------------------------------------------
>> csum_type        62267 (INVALID)
>> csum_size        32
>> csum 
>> 0x9876fd0000000000000000000000000000000000000000000000000000000000 
>> [UNKNOWN CSUM TYPE OR SIZE]
>> bytenr            274877906944
>> flags            0x1
>>             ( WRITTEN )
>> magic            _BHRfS_M [match]
>> fsid            bd5872ad-8fee-4d90-b048-b81120ce3254
>> metadata_uuid        07eb556b-df56-afbd-12c1-32f496c9ae5e
>> label 
>> ...^k...cA..[....ws.......!...&+..@...U.^..Fi.....^s....%.....G.....\..z.0..8N......l
>> generation        161054
>> root            4028020703232
>> sys_array_size        1346087890
>> chunk_root_generation    14973196025592430218
>> root_level        113
>> chunk_root        22020096
>> chunk_root_level    54
>> log_root        0
>> log_root_transid    0
>> log_root_level        77
>> total_bytes        4000787030016
>> bytes_used        3969357348864
>> sectorsize        544999736
>> nodesize        1626255393
>> leafsize (deprecated)    365786189
>> stripesize        1625894637
>> root_dir        4621774357935484814
>> num_devices        6281988177397337675
>> compat_flags        0x9c8dbbf37bf3e638
>> compat_ro_flags        0xe392e94b904707de
>>             ( FREE_SPACE_TREE_VALID |
>>               unknown flag: 0xe392e94b904707dc )
>> incompat_flags        0xe7c3113fe08815af
>>             ( MIXED_BACKREF |
>>               DEFAULT_SUBVOL |
>>               MIXED_GROUPS |
>>               COMPRESS_LZO |
>>               BIG_METADATA |
>>               RAID56 |
>>               SKINNY_METADATA |
>>               METADATA_UUID |
>>               ZONED |
>>               unknown flag: 0xe7c3113fe0880000 )
>> cache_generation    2740636164699663627
>> uuid_tree_generation    143387309824099247
>> dev_item.uuid        8ca1383a-3aaf-986e-30f3-1081cc4423b9
>> dev_item.fsid        d3b80203-160e-b664-1fa0-0121596e5fbf [DON'T MATCH]
>> dev_item.type        2243501307224589742
>> dev_item.total_bytes    17886909296177165879
>> dev_item.bytes_used    843442598421986990
>> dev_item.io_align    3037217492
>> dev_item.io_width    3952451380
>> dev_item.sector_size    2707671125
>> dev_item.devid        4105250638360812501
>> dev_item.dev_group    3766056873
>> dev_item.seek_speed    182
>> dev_item.bandwidth    229
>> dev_item.generation    9452573969509059034
