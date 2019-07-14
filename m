Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5320567E6E
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 12:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfGNKDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 06:03:40 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:47637 "EHLO
        3.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfGNKDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 06:03:40 -0400
X-Greylist: delayed 2287 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 06:03:36 EDT
Received: from player756.ha.ovh.net (unknown [10.109.146.1])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6ECF87050A
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2019 11:25:27 +0200 (CEST)
Received: from awhome.eu (p4FF91F5A.dip0.t-ipconnect.de [79.249.31.90])
        (Authenticated sender: postmaster@awhome.eu)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id C92677165FB3;
        Sun, 14 Jul 2019 09:25:24 +0000 (UTC)
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
From:   Alexander Wetzel <alexander.wetzel@web.de>
Message-ID: <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
Date:   Sun, 14 Jul 2019 11:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17656080866748286190
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheehgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>
>> filtering for btrfs and removing duplicate lines just shows three uniq
>> error messages:
>>   BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528
>> slot=4 ino=259223, invalid inode generation: has 139737289170944 expect
>> [0, 1425224]
>>   BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528
>> slot=4 ino=259223, invalid inode generation: has 139737289170944 expect
>> [0, 1425225]
>>   BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528
>> slot=4 ino=259223, invalid inode generation: has 139737289170944 expect
>> [0, 1425227]
> 
> The generation number is 0x7f171f7ba000, I see no reason why it would
> make any sense.
> 
> I see no problem rejecting obviously corrupted item.
> 
> The problem is:
> - Is that corrupted item?
>    At least to me, it looks corrupted just from the dmesg.
> 
> - How and when this happens
>    Obviously happened on some older kernel.
>    V5.2 will report such problem before writing corrupted data back to
>    disk, at least prevent such problem from happening.

It's probably useless information at that point, but the FS was created 
with a boot image from Debian 8 around Dec 1st 2016 by migrating an also 
freshly created ext4 filesystem to btrfs.
I'm pretty sure the migration failed with the newer gentoo kernel 
intended for operation - which was sys-kernel/hardened-sources-4.7.10 - 
and a used the Debian boot image for that. (I can piece together all 
kernel versions used from wtmp, but the Debian boot kernel would be 
"guess only".)

The time stamps like "2016-12-01 21:51:27" in the dump below are 
matching very well to the time I was setting up the system based on the 
few remaining log evidence I have.

> Please provide the following dump:
>   # btrfs ins dump-tree -b 8645398528 /dev/vda3
> 

xar /home/alex # btrfs ins dump-tree -b 8645398528 /dev/vda3
btrfs-progs v4.19
leaf 8645398528 items 48 free space 509 generation 1425074 owner 300
leaf 8645398528 flags 0x1(WRITTEN) backref revision 1
fs uuid 668c885e-50b9-41d0-a3ce-b653a4d3f87a
chunk uuid 54c6809b-e261-423f-b4a1-362304e887bd
         item 0 key (259222 DIR_ITEM 2504220146) itemoff 3960 itemsize 35
                 location key (259223 INODE_ITEM 0) type FILE
                 transid 8119256875011 data_len 0 name_len 5
                 name: .keep
         item 1 key (259222 DIR_INDEX 2) itemoff 3925 itemsize 35
                 location key (259223 INODE_ITEM 0) type FILE
                 transid 8119256875011 data_len 0 name_len 5
                 name: .keep
         item 2 key (259222 DIR_INDEX 3) itemoff 3888 itemsize 37
                 location key (258830 INODE_ITEM 0) type DIR
                 transid 2673440063491 data_len 0 name_len 7
                 name: portage
         item 3 key (259222 DIR_INDEX 4) itemoff 3851 itemsize 37
                 location key (3632036 INODE_ITEM 0) type DIR
                 transid 169620 data_len 0 name_len 7
                 name: binpkgs
         item 4 key (259223 INODE_ITEM 0) itemoff 3691 itemsize 160
                 generation 1 transid 139737289170944 size 0 nbytes 0
                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
                 sequence 139737289225400 flags 0x0(none)
                 atime 1480625487.0 (2016-12-01 21:51:27)
                 ctime 1480625487.0 (2016-12-01 21:51:27)
                 mtime 1480015482.0 (2016-11-24 20:24:42)
                 otime 0.0 (1970-01-01 01:00:00)
         item 5 key (259223 INODE_REF 259222) itemoff 3676 itemsize 15
                 index 2 namelen 5 name: .keep
         item 6 key (259224 INODE_ITEM 0) itemoff 3516 itemsize 160
                 generation 1 transid 1733 size 4 nbytes 5
                 block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
                 sequence 139737289225401 flags 0x0(none)
                 atime 1480626250.0 (2016-12-01 22:04:10)
                 ctime 1480688366.120000000 (2016-12-02 15:19:26)
                 mtime 1480015482.0 (2016-11-24 20:24:42)
                 otime 0.0 (1970-01-01 01:00:00)
         item 7 key (259224 INODE_REF 259207) itemoff 3503 itemsize 13
                 index 7 namelen 3 name: run
         item 8 key (259224 XATTR_ITEM 3817753667) itemoff 3429 itemsize 74
                 location key (0 UNKNOWN.0 0) type XATTR
                 transid 1733 data_len 28 name_len 16
                 name: security.selinux
                 data system_u:object_r:var_run_t
         item 9 key (259224 EXTENT_DATA 0) itemoff 3403 itemsize 26
                 generation 22 type 0 (inline)
                 inline extent data size 5 ram_bytes 5 compression 0 (none)
         item 10 key (259225 INODE_ITEM 0) itemoff 3243 itemsize 160
                 generation 1 transid 591302 size 186 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 139737289227437 flags 0x0(none)
                 atime 1484937932.634171139 (2017-01-20 19:45:32)
                 ctime 1524992223.179247581 (2018-04-29 10:57:03)
                 mtime 1524992223.179247581 (2018-04-29 10:57:03)
                 otime 0.0 (1970-01-01 01:00:00)
         item 11 key (259225 INODE_REF 259207) itemoff 3230 itemsize 13
                 index 8 namelen 3 name: lib
         item 12 key (259225 XATTR_ITEM 3817753667) itemoff 3156 itemsize 74
                 location key (0 UNKNOWN.0 0) type XATTR
                 transid 1733 data_len 28 name_len 16
                 name: security.selinux
                 data system_u:object_r:var_lib_t
         item 13 key (259225 DIR_ITEM 73688767) itemoff 3122 itemsize 34
                 location key (341157 INODE_ITEM 0) type DIR
                 transid 128778240 data_len 0 name_len 4
                 name: misc
         item 14 key (259225 DIR_ITEM 300800368) itemoff 3085 itemsize 37
                 location key (785370 INODE_ITEM 0) type DIR
                 transid 1489 data_len 0 name_len 7
                 name: selinux
         item 15 key (259225 DIR_ITEM 1107045563) itemoff 3047 itemsize 38
                 location key (789129 INODE_ITEM 0) type DIR
                 transid 1494 data_len 0 name_len 8
                 name: sepolgen
         item 16 key (259225 DIR_ITEM 1111485758) itemoff 3008 itemsize 39
                 location key (1042909 INODE_ITEM 0) type DIR
                 transid 1860 data_len 0 name_len 9
                 name: syslog-ng
         item 17 key (259225 DIR_ITEM 1612599130) itemoff 2972 itemsize 36
                 location key (259233 INODE_ITEM 0) type DIR
                 transid 8439610736640 data_len 0 name_len 6
                 name: gentoo
         item 18 key (259225 DIR_ITEM 2116554129) itemoff 2934 itemsize 38
                 location key (1836819 INODE_ITEM 0) type DIR
                 transid 28448 data_len 0 name_len 8
                 name: openntpd
         item 19 key (259225 DIR_ITEM 2320516785) itemoff 2897 itemsize 37
                 location key (259226 INODE_ITEM 0) type DIR
                 transid 2160540348579840 data_len 0 name_len 7
                 name: portage
         item 20 key (259225 DIR_ITEM 2449158508) itemoff 2858 itemsize 39
                 location key (259239 INODE_ITEM 0) type DIR
                 transid 0 data_len 0 name_len 9
                 name: ip6tables
         item 21 key (259225 DIR_ITEM 2504220146) itemoff 2823 itemsize 35
                 location key (259238 INODE_ITEM 0) type FILE
                 transid 0 data_len 0 name_len 5
                 name: .keep
         item 22 key (259225 DIR_ITEM 2635879490) itemoff 2786 itemsize 37
                 location key (6762622 INODE_ITEM 0) type DIR
                 transid 591302 data_len 0 name_len 7
                 name: postfix
         item 23 key (259225 DIR_ITEM 2734009058) itemoff 2751 itemsize 35
                 location key (1838131 INODE_ITEM 0) type DIR
                 transid 28461 data_len 0 name_len 5
                 name: btrfs
         item 24 key (259225 DIR_ITEM 3421666276) itemoff 2717 itemsize 34
                 location key (259230 INODE_ITEM 0) type DIR
                 transid 504403158265495552 data_len 0 name_len 4
                 name: arpd
         item 25 key (259225 DIR_ITEM 3481791328) itemoff 2681 itemsize 36
                 location key (3820659 INODE_ITEM 0) type DIR
                 transid 211025 data_len 0 name_len 6
                 name: layman
         item 26 key (259225 DIR_ITEM 3968635316) itemoff 2643 itemsize 38
                 location key (259231 INODE_ITEM 0) type DIR
                 transid 68186368 data_len 0 name_len 8
                 name: iptables
         item 27 key (259225 DIR_INDEX 2) itemoff 2606 itemsize 37
                 location key (259226 INODE_ITEM 0) type DIR
                 transid 266353 data_len 0 name_len 7
                 name: portage
         item 28 key (259225 DIR_INDEX 3) itemoff 2572 itemsize 34
                 location key (259230 INODE_ITEM 0) type DIR
                 transid 2 data_len 0 name_len 4
                 name: arpd
         item 29 key (259225 DIR_INDEX 4) itemoff 2534 itemsize 38
                 location key (259231 INODE_ITEM 0) type DIR
                 transid 10359104371 data_len 0 name_len 8
                 name: iptables
         item 30 key (259225 DIR_INDEX 5) itemoff 2498 itemsize 36
                 location key (259233 INODE_ITEM 0) type DIR
                 transid 158067 data_len 0 name_len 6
                 name: gentoo
         item 31 key (259225 DIR_INDEX 6) itemoff 2463 itemsize 35
                 location key (259238 INODE_ITEM 0) type FILE
                 transid 617 data_len 0 name_len 5
                 name: .keep
         item 32 key (259225 DIR_INDEX 7) itemoff 2424 itemsize 39
                 location key (259239 INODE_ITEM 0) type DIR
                 transid 2651930718976 data_len 0 name_len 9
                 name: ip6tables
         item 33 key (259225 DIR_INDEX 8) itemoff 2390 itemsize 34
                 location key (341157 INODE_ITEM 0) type DIR
                 transid 2 data_len 0 name_len 4
                 name: misc
         item 34 key (259225 DIR_INDEX 9) itemoff 2353 itemsize 37
                 location key (785370 INODE_ITEM 0) type DIR
                 transid 1489 data_len 0 name_len 7
                 name: selinux
         item 35 key (259225 DIR_INDEX 10) itemoff 2315 itemsize 38
                 location key (789129 INODE_ITEM 0) type DIR
                 transid 1494 data_len 0 name_len 8
                 name: sepolgen
         item 36 key (259225 DIR_INDEX 11) itemoff 2276 itemsize 39
                 location key (1042909 INODE_ITEM 0) type DIR
                 transid 1860 data_len 0 name_len 9
                 name: syslog-ng
         item 37 key (259225 DIR_INDEX 154) itemoff 2238 itemsize 38
                 location key (1836819 INODE_ITEM 0) type DIR
                 transid 28448 data_len 0 name_len 8
                 name: openntpd
         item 38 key (259225 DIR_INDEX 155) itemoff 2203 itemsize 35
                 location key (1838131 INODE_ITEM 0) type DIR
                 transid 28461 data_len 0 name_len 5
                 name: btrfs
         item 39 key (259225 DIR_INDEX 590) itemoff 2167 itemsize 36
                 location key (3820659 INODE_ITEM 0) type DIR
                 transid 211025 data_len 0 name_len 6
                 name: layman
         item 40 key (259225 DIR_INDEX 591) itemoff 2130 itemsize 37
                 location key (6762622 INODE_ITEM 0) type DIR
                 transid 591302 data_len 0 name_len 7
                 name: postfix
         item 41 key (259226 INODE_ITEM 0) itemoff 1970 itemsize 160
                 generation 1 transid 1425074 size 88 nbytes 0
                 block group 0 mode 42755 links 1 uid 0 gid 250 rdev 0
                 sequence 139737289231301 flags 0x0(none)
                 atime 1484937932.634171139 (2017-01-20 19:45:32)
                 ctime 1563016286.555238083 (2019-07-13 13:11:26)
                 mtime 1563016286.555238083 (2019-07-13 13:11:26)
                 otime 0.0 (1970-01-01 01:00:00)
         item 42 key (259226 INODE_REF 259225) itemoff 1953 itemsize 17
                 index 2 namelen 7 name: portage
         item 43 key (259226 XATTR_ITEM 3817753667) itemoff 1873 itemsize 80
                 location key (0 UNKNOWN.0 0) type XATTR
                 transid 1733 data_len 34 name_len 16
                 name: security.selinux
                 data system_u:object_r:portage_cache_t
         item 44 key (259226 DIR_ITEM 310146024) itemoff 1820 itemsize 53
                 location key (11501213 INODE_ITEM 0) type FILE
                 transid 1328324 data_len 0 name_len 23
                 name: preserved_libs_registry
         item 45 key (259226 DIR_ITEM 2128402847) itemoff 1780 itemsize 40
                 location key (10719048 INODE_ITEM 0) type FILE
                 transid 1265971 data_len 0 name_len 10
                 name: world_sets
         item 46 key (259226 DIR_ITEM 3145042590) itemoff 1744 itemsize 36
                 location key (11426212 INODE_ITEM 0) type FILE
                 transid 1328203 data_len 0 name_len 6
                 name: config
         item 47 key (259226 DIR_ITEM 4131655965) itemoff 1709 itemsize 35
                 location key (12072460 INODE_ITEM 0) type FILE
                 transid 1401504 data_len 0 name_len 5
                 name: world
>>
>> Now I guess I could have some corruption only detected/triggered with
>> the patch and btrfs check may fix it... shall I try that next?
> 
> Sorry, AFAIK btrfs doesn't check as strict as kernel tree-checker, as
> corrupted data in kernel space could lead to system crash while in user
> space it would only cause btrfs check to crash.
> 
> Thus I made tree-checker way picky about irregular data, it's literally
> checking every member and even unused member.
> The dump mentioned above should help us to determine whether btrfs check
> can detect and fix it.
> (I believe it shouldn't be that hard to fix in btrfs-progs)
> 
> Thanks,
> Qu

Thank you for your support!

Alexander


