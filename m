Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2C68FC13
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 01:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjBIAmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 19:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBIAmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 19:42:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0815557
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 16:42:43 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6sn7-1oWmW10kcJ-018Ik7; Thu, 09
 Feb 2023 01:42:39 +0100
Message-ID: <c2c63ed0-d987-1165-d1ff-e8a3020fbac7@gmx.com>
Date:   Thu, 9 Feb 2023 08:42:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:08TNyREiZHZEj9DZ8Rl5PMKA2XU9PsS+K/gCBPTOCMIaE/zmaCt
 oe1e8tJQlw2/hvm94HJdkX/wB54EtViRaRweAFoTaR/0Y7wR4HNMDn1XJX6F714pyU4DQpY
 1iPO2i3FOI/1gKEBularKF4lQtxenBo65Xk5jhqbOyPzrWUwMj9GIh0XbTSWPx7tT6wFklZ
 Rdb0q30ud4A044UdsjbzA==
UI-OutboundReport: notjunk:1;M01:P0:XXZRf4bBimw=;eOEueJp+cRDxEhZkxdvLOh2S864
 peBDCZUH+duI0jvX53gHJKbl9kZJ8RM/AEq97HjXhHFPmnW9mi7UqHrjeFPxS7K7+5tjqOWaG
 gfgAUjDkJAcaWBRWtUyf95Io9gSw1uyOx6Qso/5R9rJfwm1tKO4l2VE/yg1yaKoyce2z+wXj9
 s0Qk58snLfii4HP6pAr/2PbrXuDjcd2NXyhv47W91P96IxuJ5mLfYBLCO5rDWSFwyrOQAt06O
 yxwewqSCO5D9FDAMNlNOxVmkuC+XKOsNK7aSviwEEFr6nJ6c8Tq6BM9+jarwJuDreI5brNkeX
 4D6J3wK8Iokz1G0az0HoNjPZojfAiEZmdj8JvJW6X2GCJtlWUEpSMhQsVUEgGwaqHH1hFsOkz
 9wD1NXo/Fc8QhEEVp8nMXkkbC0C2coqx0D+2XkGI4OVVmaYRFxxy/3JzqN9F5Yqn+18+PRIy3
 tiXOU/j54LUQdx3u0CjfrgcgTrMqJyv9g1Xlqh8VZ/DwE7iw4wa9+ILV5PqnVt4dPTw3x15dc
 yXpcvGEXJL/QJ/kF+diSksWYBF8wuDL8DK4EtrqjFMw8kkIkNCL7lUW7Ye5TmdcXk8JcvN55N
 +2yrEk9bDlGQAM6v2WW4U7bHtPqINdXQ3otEHl3ReSAH+OvuCMXYpn24r2+oGVHH3jhhET2Om
 e7a/XUR7Jq7lpiXMJiRwTzfARgJ+xeUPlsufNi57DHPjGv8/iLvlv85F6HTzIiCbTsoO2IOzn
 zM/+I/BuNKs5yK+Y1ImY+szVpWQd8ml/JP65gmrsZZG84oCJU/hwwNkYnWk5pCdK2BDSYuRcW
 5/sx9O3Sm8rgie45NoZMnLP/Y+7HlJ2LrWTITdzaoQHh0VU2RrirED0oSeFB1KMOiYCtWNWq/
 FlKYdk9gossQXrAjMoJrizoheclvvEEKSUY3RS+VdIOPem8m1toHgDmtC7hN9/cJXoO5PayBz
 KZNUGPr/rHPl4Od4NllSa5mS7/U=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/8 18:57, Johannes Thumshirn wrote:
> Updates of the raid-stripe-tree are done at delayed-ref time to safe on
> bandwidth while for reading we do the stripe-tree lookup on bio mapping time,
> i.e. when the logical to physical translation happens for regular btrfs RAID
> as well.
> 
> The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
> it's contents are the respective physical device id and position.
> 
> For an example 1M write (split into 126K segments due to zone-append)
> rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)
> 
> The tree will look as follows:
> 
> rapido2:/home/johannes/src/fstests# btrfs inspect-internal dump-tree -t raid_stripe /dev/nullb0
> btrfs-progs v5.16.1
> raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> leaf 805847040 items 9 free space 15770 generation 9 owner RAID_STRIPE_TREE
> leaf 805847040 flags 0x1(WRITTEN) backref revision 1
> checksum stored 1b22e13800000000000000000000000000000000000000000000000000000000
> checksum calced 1b22e13800000000000000000000000000000000000000000000000000000000
> fs uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
> chunk uuid 6f2d8aaa-d348-4bf2-9b5e-141a37ba4c77
>          item 0 key (939524096 RAID_STRIPE_KEY 126976) itemoff 16251 itemsize 32
>                          stripe 0 devid 1 offset 939524096
>                          stripe 1 devid 2 offset 536870912

Considering we already have the length as the key offset, can we merge 
continuous entries?

I'm pretty sure if we go this path, the rst tree itself can be too 
large, and it's better we consider this before it's too problematic.

Thanks,
Qu

>          item 1 key (939651072 RAID_STRIPE_KEY 126976) itemoff 16219 itemsize 32
>                          stripe 0 devid 1 offset 939651072
>                          stripe 1 devid 2 offset 536997888
>          item 2 key (939778048 RAID_STRIPE_KEY 126976) itemoff 16187 itemsize 32
>                          stripe 0 devid 1 offset 939778048
>                          stripe 1 devid 2 offset 537124864
>          item 3 key (939905024 RAID_STRIPE_KEY 126976) itemoff 16155 itemsize 32
>                          stripe 0 devid 1 offset 939905024
>                          stripe 1 devid 2 offset 537251840
>          item 4 key (940032000 RAID_STRIPE_KEY 126976) itemoff 16123 itemsize 32
>                          stripe 0 devid 1 offset 940032000
>                          stripe 1 devid 2 offset 537378816
>          item 5 key (940158976 RAID_STRIPE_KEY 126976) itemoff 16091 itemsize 32
>                          stripe 0 devid 1 offset 940158976
>                          stripe 1 devid 2 offset 537505792
>          item 6 key (940285952 RAID_STRIPE_KEY 126976) itemoff 16059 itemsize 32
>                          stripe 0 devid 1 offset 940285952
>                          stripe 1 devid 2 offset 537632768
>          item 7 key (940412928 RAID_STRIPE_KEY 126976) itemoff 16027 itemsize 32
>                          stripe 0 devid 1 offset 940412928
>                          stripe 1 devid 2 offset 537759744
>          item 8 key (940539904 RAID_STRIPE_KEY 32768) itemoff 15995 itemsize 32
>                          stripe 0 devid 1 offset 940539904
>                          stripe 1 devid 2 offset 537886720
> total bytes 26843545600
> bytes used 1245184
> uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
> 
> A design document can be found here:
> https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true
> 
> 
> Changes to v4:
> - Added patch to check for RST feature in sysfs
> - Added RST lookups for scrubbing
> - Fixed the error handling bug Josef pointed out
> - Only check if we need to write out a RST once per delayed_ref head
> - Added support for zoned data DUP with RST
> 
> Changes to v3:
> - Rebased onto 20221120124734.18634-1-hch@lst.de
> - Incorporated Josef's review
> - Merged related patches
> 
> v3 of the patchset can be found here:
> https://lore/kernel.org/linux-btrfs/cover.1666007330.git.johannes.thumshirn@wdc.com
> 
> Changes to v2:
> - Bug fixes
> - Rebased onto 20220901074216.1849941-1-hch@lst.de
> - Added tracepoints
> - Added leak checker
> - Added RAID0 and RAID10
> 
> v2 of the patchset can be found here:
> https://lore.kernel.org/linux-btrfs/cover.1656513330.git.johannes.thumshirn@wdc.com
> 
> Changes to v1:
> - Write the stripe-tree at delayed-ref time (Qu)
> - Add a different write path for preallocation
> 
> v1 of the patchset can be found here:
> https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/
> 
> Johannes Thumshirn (13):
>    btrfs: re-add trans parameter to insert_delayed_ref
>    btrfs: add raid stripe tree definitions
>    btrfs: read raid-stripe-tree from disk
>    btrfs: add support for inserting raid stripe extents
>    btrfs: delete stripe extent on extent deletion
>    btrfs: lookup physical address from stripe extent
>    btrfs: add raid stripe tree pretty printer
>    btrfs: zoned: allow zoned RAID
>    btrfs: check for leaks of ordered stripes on umount
>    btrfs: add tracepoints for ordered stripes
>    btrfs: announce presence of raid-stripe-tree in sysfs
>    btrfs: consult raid-stripe-tree when scrubbing
>    btrfs: add raid-stripe-tree to features enabled with debug
> 
>   fs/btrfs/Makefile               |   2 +-
>   fs/btrfs/accessors.h            |  29 +++
>   fs/btrfs/bio.c                  |  29 +++
>   fs/btrfs/bio.h                  |   2 +
>   fs/btrfs/block-rsv.c            |   1 +
>   fs/btrfs/delayed-ref.c          |  13 +-
>   fs/btrfs/delayed-ref.h          |   2 +
>   fs/btrfs/disk-io.c              |  30 ++-
>   fs/btrfs/disk-io.h              |   5 +
>   fs/btrfs/extent-tree.c          |  68 ++++++
>   fs/btrfs/fs.h                   |   8 +-
>   fs/btrfs/inode.c                |  15 +-
>   fs/btrfs/print-tree.c           |  21 ++
>   fs/btrfs/raid-stripe-tree.c     | 415 ++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h     |  87 +++++++
>   fs/btrfs/scrub.c                |  33 ++-
>   fs/btrfs/super.c                |   1 +
>   fs/btrfs/sysfs.c                |   3 +
>   fs/btrfs/volumes.c              |  39 ++-
>   fs/btrfs/volumes.h              |  12 +-
>   fs/btrfs/zoned.c                |  49 +++-
>   include/trace/events/btrfs.h    |  50 ++++
>   include/uapi/linux/btrfs.h      |   1 +
>   include/uapi/linux/btrfs_tree.h |  20 +-
>   24 files changed, 905 insertions(+), 30 deletions(-)
>   create mode 100644 fs/btrfs/raid-stripe-tree.c
>   create mode 100644 fs/btrfs/raid-stripe-tree.h
> 
