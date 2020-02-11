Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71A158918
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 05:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBKEDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 23:03:22 -0500
Received: from mail.synology.com ([211.23.38.101]:56964 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727928AbgBKEDW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 23:03:22 -0500
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id 1A7C4DB184C0;
        Tue, 11 Feb 2020 12:03:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581393800; bh=c6GbZnWvJunC8PxMcdqcJPd6hJeCJXbwKIy3wqn8BQI=;
        h=Date:From:To:Subject:In-Reply-To:References;
        b=rXyPVZ1HkNwl9FdNgJV/BVlYKC+Xbp9o27/nFh4zaXPu2W/t9Ktp6nZl/SowxfgJQ
         FUzTtT1vOYm2eJCnqNeIPGkB6Xwzsex5+uSGbYQ9I6mR2sYj1RWG9DuQUZe7wbe3Zd
         1/3F5bwEpC+83HWZENW21zX3W33xOMtqfORmeQpc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 11 Feb 2020 12:03:20 +0800
From:   ethanwu <ethanwu@synology.com>
To:     dsterba@suse.cz, ethanwu <ethanwu@synology.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
In-Reply-To: <20200210162927.GK2654@twin.jikos.cz>
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
Message-ID: <5901b2be7358137e691b319cbad43111@synology.com>
X-Sender: ethanwu@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba 於 2020-02-11 00:29 寫到:
> On Mon, Feb 10, 2020 at 05:12:48PM +0800, ethanwu wrote:
>> Josef Bacik 於 2020-02-08 00:26 寫到:
>> > On 2/7/20 4:38 AM, ethanwu wrote:
>> >> When resolving one backref of type EXTENT_DATA_REF, we collect all
>> >> references that simply references the EXTENT_ITEM even though
>> >> their (file_pos- file_extent_item::offset) are not the same as the
>> >> btrfs_extent_data_ref::offset we are searching.
>> >>
>> >> This patch add additional check so that we only collect references
>> >> whose
>> >> (file_pos- file_extent_item::offset) == btrfs_extent_data_ref::offset.
>> >>
>> >> Signed-off-by: ethanwu <ethanwu@synology.com>
>> >
>> > I just want to make sure that btrfs/097 passes still right?  That's
>> > what the key_for_search thing was about, so I want to make sure we're
>> > not regressing.  I assume you've run xfstests but I just want to make
>> > doubly sure we're good here. If you did then you can add
>> >
>> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> >
>> > Thanks,
>> >
>> > Josef
>> 
>> Thanks for reviewing.
>> 
>> I've run the btrfs part of xfstests, 097 passed.
>> Failed at following tests:
>> 074 (failed 2 out of 5 runs),
>> 139, 153, 154,
>> 197, 198(Patches related to these 2 tests seem to be not merged yet?)
>> 201, 202
>> 
>> My kernel environment is 5.5-rc5, and this branch doesn't contain
>> fixes for tests 201 and 202.
>> All these failing tests also failed at the same version without my
>> patch.
> 
> I tested the patchset in my environment and besides the above known
> and unrelated failures, there's one that seems to be new and possibly
> related to the patches:
> 
> btrfs/125               [18:18:14][ 5937.333021] run fstests btrfs/125
> at 2020-02-07 18:18:14
> [ 5937.737705] BTRFS info (device vda): disk space caching is enabled
> [ 5937.741359] BTRFS info (device vda): has skinny extents
> [ 5938.318881] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5
> devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (21913)
> [ 5938.323180] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5
> devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (21913)
> [ 5938.327229] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5
> devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (21913)
> [ 5938.344608] BTRFS info (device vdb): disk space caching is enabled
> [ 5938.347892] BTRFS info (device vdb): has skinny extents
> [ 5938.350941] BTRFS info (device vdb): flagging fs with big metadata 
> feature
> [ 5938.360083] BTRFS info (device vdb): checking UUID tree
> [ 5938.470343] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5
> devid 2 transid 7 /dev/vdc scanned by mount (21955)
> [ 5938.476444] BTRFS: device fsid e34ea734-aeef-484b-8a5b-d061e3bad8c5
> devid 1 transid 7 /dev/vdb scanned by mount (21955)
> [ 5938.480289] BTRFS info (device vdb): allowing degraded mounts
> [ 5938.483738] BTRFS info (device vdb): disk space caching is enabled
> [ 5938.487557] BTRFS info (device vdb): has skinny extents
> [ 5938.491416] BTRFS warning (device vdb): devid 3 uuid
> f86704f4-689c-4677-b5f2-5380cf6be2d3 is missing
> [ 5938.493879] BTRFS warning (device vdb): devid 3 uuid
> f86704f4-689c-4677-b5f2-5380cf6be2d3 is missing
> [ 5939.233288] BTRFS: device fsid 265be525-bf76-447b-8db6-d69b0d3885d1
> devid 1 transid 250 /dev/vda scanned by btrfs (21983)
> [ 5939.250044] BTRFS info (device vdb): disk space caching is enabled
> [ 5939.253525] BTRFS info (device vdb): has skinny extents
> [ 5949.283384] BTRFS info (device vdb): balance: start -d -m -s
> [ 5949.288563] BTRFS info (device vdb): relocating block group
> 217710592 flags data|raid5
> [ 5949.322231] BTRFS error (device vdb): bad tree block start, want
> 39862272 have 30949376
> [ 5949.328136] repair_io_failure: 22 callbacks suppressed
> [ 5949.328139] BTRFS info (device vdb): read error corrected: ino 0
> off 39862272 (dev /dev/vdd sector 19488)
> [ 5949.333447] BTRFS info (device vdb): read error corrected: ino 0
> off 39866368 (dev /dev/vdd sector 19496)
> [ 5949.336875] BTRFS info (device vdb): read error corrected: ino 0
> off 39870464 (dev /dev/vdd sector 19504)
> [ 5949.340325] BTRFS info (device vdb): read error corrected: ino 0
> off 39874560 (dev /dev/vdd sector 19512)
> [ 5949.409934] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2228224 csum
> 0x5f6faf4265e0e04dc797f32ab085653d60954cfd976b257c83e7cd825ae7c98e
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.414764] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2555904 csum
> 0xde6a48c4c66a765d0142c27fee1ec429055152fe3f10d70e4ef59a9d7a071bdc
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.414774] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2621440 csum
> 0x47800732ac4471f4aced9c4fe35cb6046c401792a99daa02ccbc35e0b4632496
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.414946] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2637824 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.415061] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2641920 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.415136] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2646016 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.415214] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2650112 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.415260] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2654208 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.415304] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2658304 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.415348] BTRFS warning (device vdb): csum failed root -9 ino 257
> off 2662400 csum
> 0x769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78
> expected csum
> 0xad7facb2586fc6e966c004d7d1d16b024f5805ff7cb47c7a85dabd8b48892ca7
> mirror 1
> [ 5949.419530] BTRFS info (device vdb): read error corrected: ino 257
> off 2621440 (dev /dev/vdd sector 195712)
> [ 5949.420414] BTRFS info (device vdb): read error corrected: ino 257
> off 2641920 (dev /dev/vdd sector 195752)
> [ 5949.420528] BTRFS info (device vdb): read error corrected: ino 257
> off 2637824 (dev /dev/vdd sector 195744)
> [ 5949.420651] BTRFS info (device vdb): read error corrected: ino 257
> off 2650112 (dev /dev/vdd sector 195768)
> [ 5949.420771] BTRFS info (device vdb): read error corrected: ino 257
> off 2654208 (dev /dev/vdd sector 195776)
> [ 5949.420886] BTRFS info (device vdb): read error corrected: ino 257
> off 2662400 (dev /dev/vdd sector 195792)
> [ 5949.527064] BTRFS error (device vdb): bad tree block start, want
> 39059456 have 30539776
> [ 5949.527461] BTRFS error (device vdb): bad tree block start, want
> 39075840 have 30556160
> [ 5949.527646] BTRFS error (device vdb): bad tree block start, want
> 39092224 have 0
> [ 5949.527664] BTRFS error (device vdb): bad tree block start, want
> 39108608 have 30588928
> [ 5949.546199] BTRFS error (device vdb): bad tree block start, want
> 39075840 have 30556160
> [ 5949.579222] BTRFS error (device vdb): bad tree block start, want
> 39092224 have 0
> [ 5949.589051] BTRFS error (device vdb): bad tree block start, want
> 39108608 have 30588928
> [ 5949.828796] BTRFS error (device vdb): bad tree block start, want
> 39387136 have 30670848
> [ 5949.828804] BTRFS error (device vdb): bad tree block start, want
> 39403520 have 0
> [ 5950.430515] BTRFS info (device vdb): balance: ended with status: -5
> [ 5950.450348] btrfs (22010) used greatest stack depth: 10304 bytes 
> left
> [failed, exit status 1][ 5950.461088] BTRFS info (device vdb):
> clearing incompat feature flag for RAID56 (0x80)
>  [18:18:27]- output mismatch (see 
> /tmp/fstests/results//btrfs/125.out.bad)
>     --- tests/btrfs/125.out     2018-04-12 16:57:00.616225550 +0000
>     +++ /tmp/fstests/results//btrfs/125.out.bad 2020-02-07
> 18:18:27.496000000 +0000
>     @@ -3,5 +3,5 @@
>      Write data with degraded mount
> 
>      Mount normal and balance
>     -
>     -Mount degraded but with other dev
>     +failed: '/sbin/btrfs balance start /tmp/scratch'
>     +(see /tmp/fstests/results//btrfs/125.full for details)
>     ...
>     (Run 'diff -u /tmp/fstests/tests/btrfs/125.out
> /tmp/fstests/results//btrfs/125.out.bad'  to see the entire diff)

Hi,
I've rebased my kernel environment to the latest for-next branch,
xfstests is updated to latest as well.
Test 125 still passes many times without even one failure.

here's my local.config

export TEST_DEV=/dev/sdc
export TEST_DIR=/mnt/test
export SCRATCH_MNT=/mnt/scratch
export FSTYP=btrfs
export SCRATCH_DEV_POOL="/dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh"

each device has 80GB capacity.

Besides, LOGWRITES_DEV is not set and CONFIG_FAULT_INJECTION_DEBUG_FS
is turned off, but both seems to be unrelated to 125.

thanks,
ethanwu




