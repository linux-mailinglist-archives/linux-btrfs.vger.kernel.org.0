Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BF63603CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhDOIE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 04:04:28 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:47320 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOIE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 04:04:28 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 04:04:27 EDT
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id 171CC20F728; Thu, 15 Apr 2021 09:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1618472011;
        bh=QD0GkQV7OReGO7ovkns4ZP0Y6G7j/ZsYWDZCVniGniM=;
        h=To:Subject:Date:From:From;
        b=hqsFmwYW0mcBR63vfO6eid52LIbS533mWlzxDWUio/HvwKTls79gDGSb8rZt0No99
         thsu8iFcyApIrI/1HV4KBD2CsZF244CE7oXXY/DfSEIMkoFiL0fPyOGm2zBLFw0zEf
         0jnutsPxoHR9q5vroMi18N0s0qXQCJ+DLx+PRSDY=
To:     linux-btrfs@vger.kernel.org
Subject: Dead fs on 2 Fedora systems: block=57084067840 write time tree block  corruption detected
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Apr 2021 03:33:31 -0400
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Message-ID: <d97168fe4c9e7560fb6229fb4f971bfd@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
On March 13 my Fedora 34 laptop automatically remounted its btrfs rootfs 
readonly. I restarted the system and it didn't even manage to boot, nor 
even mount from a livecd. I tried btrfs check --repair but it didn't 
work, so I gave up and reinstalled the system. This is a screenshot of 
the error in dmesg: 
https://i.ibb.co/xGFRS1v/fedora-btrfs-laptop-dmesg.png

Fast forward to yesterday and I've got a similar error on my Fedora 33 
desktop:

[    0.000000] Linux version 5.11.12-200.fc33.x86_64 
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 10.2.1 20201125 
(Red Hat 10.2.1-9), GNU ld version 2.35-18.fc33) #1 SMP Thu Apr 8 
02:34:17 UTC 2021
[~1300 lines omitted]
[30177.298027] BTRFS critical (device nvme0n1p8): corrupt leaf: root=791 
block=57084067840 slot=64 ino=1537855, name hash mismatch with key, have 
0x00000000a461adfd expect 0x00000000a461adf5
[30177.298038] BTRFS info (device nvme0n1p8): leaf 57084067840 gen 
972457 total ptrs 65 free space 5317 owner 791
[30177.298041] 	item 0 key (1537843 1 0) itemoff 16123 itemsize 160
[30177.298043] 		inode generation 913551 size 86 mode 40775
[30177.298045] 	item 1 key (1537843 12 1537733) itemoff 16096 itemsize 
27
[30177.298047] 	item 2 key (1537843 24 3817753667) itemoff 16013 
itemsize 83
[30177.298048] 	item 3 key (1537843 84 2362892221) itemoff 15973 
itemsize 40
[30177.298050] 		dir oid 1544341 type 1
[30177.298052] 	item 4 key (1537843 84 2757864957) itemoff 15935 
itemsize 38
[30177.298054] 		dir oid 1540610 type 1
[30177.298055] 	item 5 key (1537843 84 2879654400) itemoff 15893 
itemsize 42
[30177.298056] 		dir oid 1543098 type 1
[30177.298057] 	item 6 key (1537843 84 4164517193) itemoff 15850 
itemsize 43
[30177.298058] 		dir oid 1537844 type 1
[30177.298059] 	item 7 key (1537843 96 2) itemoff 15807 itemsize 43
[30177.298061] 	item 8 key (1537843 96 3) itemoff 15769 itemsize 38
[30177.298062] 	item 9 key (1537843 96 4) itemoff 15727 itemsize 42
[30177.298063] 	item 10 key (1537843 96 5) itemoff 15687 itemsize 40
[30177.298065] 	item 11 key (1537844 1 0) itemoff 15527 itemsize 160
[30177.298066] 		inode generation 913551 size 1383 mode 100644
[30177.298067] 	item 12 key (1537844 12 1537843) itemoff 15504 itemsize 
23
[30177.298069] 	item 13 key (1537844 24 3817753667) itemoff 15421 
itemsize 83
[30177.298070] 	item 14 key (1537844 108 0) itemoff 14017 itemsize 1404
[30177.298072] 		inline extent data size 1383
[30177.298072] 	item 15 key (1537846 1 0) itemoff 13857 itemsize 160
[30177.298074] 		inode generation 913551 size 86 mode 40775
[30177.298087] 	item 16 key (1537846 12 1537733) itemoff 13829 itemsize 
28
[30177.298089] 	item 17 key (1537846 24 3817753667) itemoff 13746 
itemsize 83
[30177.298090] 	item 18 key (1537846 84 2362892221) itemoff 13706 
itemsize 40
[30177.298091] 		dir oid 1544343 type 1
[30177.298092] 	item 19 key (1537846 84 2757864957) itemoff 13668 
itemsize 38
[30177.298094] 		dir oid 1540611 type 1
[30177.298095] 	item 20 key (1537846 84 2879654400) itemoff 13626 
itemsize 42
[30177.298096] 		dir oid 1543099 type 1
[30177.298097] 	item 21 key (1537846 84 4164517193) itemoff 13583 
itemsize 43
[30177.298098] 		dir oid 1537847 type 1
[30177.298099] 	item 22 key (1537846 96 2) itemoff 13540 itemsize 43
[30177.298101] 	item 23 key (1537846 96 3) itemoff 13502 itemsize 38
[30177.298102] 	item 24 key (1537846 96 4) itemoff 13460 itemsize 42
[30177.298103] 	item 25 key (1537846 96 5) itemoff 13420 itemsize 40
[30177.298105] 	item 26 key (1537847 1 0) itemoff 13260 itemsize 160
[30177.298106] 		inode generation 913551 size 1383 mode 100644
[30177.298107] 	item 27 key (1537847 12 1537846) itemoff 13237 itemsize 
23
[30177.298109] 	item 28 key (1537847 24 3817753667) itemoff 13154 
itemsize 83
[30177.298110] 	item 29 key (1537847 108 0) itemoff 11750 itemsize 1404
[30177.298111] 		inline extent data size 1383
[30177.298112] 	item 30 key (1537849 1 0) itemoff 11590 itemsize 160
[30177.298113] 		inode generation 913551 size 86 mode 40775
[30177.298114] 	item 31 key (1537849 12 1537733) itemoff 11561 itemsize 
29
[30177.298116] 	item 32 key (1537849 24 3817753667) itemoff 11478 
itemsize 83
[30177.298117] 	item 33 key (1537849 84 2362892221) itemoff 11438 
itemsize 40
[30177.298118] 		dir oid 1544347 type 1
[30177.298119] 	item 34 key (1537849 84 2757864957) itemoff 11400 
itemsize 38
[30177.298121] 		dir oid 1540612 type 1
[30177.298121] 	item 35 key (1537849 84 2879654400) itemoff 11358 
itemsize 42
[30177.298123] 		dir oid 1543100 type 1
[30177.298124] 	item 36 key (1537849 84 4164517193) itemoff 11315 
itemsize 43
[30177.298125] 		dir oid 1537850 type 1
[30177.298126] 	item 37 key (1537849 96 2) itemoff 11272 itemsize 43
[30177.298127] 	item 38 key (1537849 96 3) itemoff 11234 itemsize 38
[30177.298128] 	item 39 key (1537849 96 4) itemoff 11192 itemsize 42
[30177.298129] 	item 40 key (1537849 96 5) itemoff 11152 itemsize 40
[30177.298131] 	item 41 key (1537850 1 0) itemoff 10992 itemsize 160
[30177.298132] 		inode generation 913551 size 1342 mode 100644
[30177.298133] 	item 42 key (1537850 12 1537849) itemoff 10969 itemsize 
23
[30177.298135] 	item 43 key (1537850 24 3817753667) itemoff 10886 
itemsize 83
[30177.298136] 	item 44 key (1537850 108 0) itemoff 9523 itemsize 1363
[30177.298138] 		inline extent data size 1342
[30177.298139] 	item 45 key (1537852 1 0) itemoff 9363 itemsize 160
[30177.298141] 		inode generation 913551 size 86 mode 40775
[30177.298142] 	item 46 key (1537852 12 1537733) itemoff 9332 itemsize 
31
[30177.298143] 	item 47 key (1537852 24 3817753667) itemoff 9249 
itemsize 83
[30177.298144] 	item 48 key (1537852 84 2362892221) itemoff 9209 
itemsize 40
[30177.298146] 		dir oid 1544350 type 1
[30177.298147] 	item 49 key (1537852 84 2757864957) itemoff 9171 
itemsize 38
[30177.298148] 		dir oid 1540613 type 1
[30177.298149] 	item 50 key (1537852 84 2879654400) itemoff 9129 
itemsize 42
[30177.298150] 		dir oid 1543101 type 1
[30177.298151] 	item 51 key (1537852 84 4164517193) itemoff 9086 
itemsize 43
[30177.298152] 		dir oid 1537853 type 1
[30177.298153] 	item 52 key (1537852 96 2) itemoff 9043 itemsize 43
[30177.298154] 	item 53 key (1537852 96 3) itemoff 9005 itemsize 38
[30177.298156] 	item 54 key (1537852 96 4) itemoff 8963 itemsize 42
[30177.298157] 	item 55 key (1537852 96 5) itemoff 8923 itemsize 40
[30177.298159] 	item 56 key (1537853 1 0) itemoff 8763 itemsize 160
[30177.298160] 		inode generation 913551 size 1342 mode 100644
[30177.298161] 	item 57 key (1537853 12 1537852) itemoff 8740 itemsize 
23
[30177.298162] 	item 58 key (1537853 24 3817753667) itemoff 8657 
itemsize 83
[30177.298164] 	item 59 key (1537853 108 0) itemoff 7294 itemsize 1363
[30177.298165] 		inline extent data size 1342
[30177.298166] 	item 60 key (1537855 1 0) itemoff 7134 itemsize 160
[30177.298167] 		inode generation 913551 size 86 mode 40775
[30177.298168] 	item 61 key (1537855 12 1537733) itemoff 7103 itemsize 
31
[30177.298169] 	item 62 key (1537855 24 3817753667) itemoff 7020 
itemsize 83
[30177.298171] 	item 63 key (1537855 84 2362892221) itemoff 6980 
itemsize 40
[30177.298172] 		dir oid 1544351 type 1
[30177.298173] 	item 64 key (1537855 84 2757864949) itemoff 6942 
itemsize 38
[30177.298174] 		dir oid 1540614 type 1
[30177.298175] BTRFS error (device nvme0n1p8): block=57084067840 write 
time tree block corruption detected
[30177.326752] BTRFS: error (device nvme0n1p8) in 
btrfs_commit_transaction:2329: errno=-5 IO failure (Error while writing 
out transaction)
[30177.326759] BTRFS info (device nvme0n1p8): forced readonly
[30177.326765] BTRFS warning (device nvme0n1p8): Skipping commit of 
aborted transaction.
[30177.326767] BTRFS: error (device nvme0n1p8) in 
cleanup_transaction:1939: errno=-5 IO failure


At this point I rushed to backup whatever I could, I booted into a 
Fedora 34 live usb and I made a copy of the partition with dd. It still 
mounts, but btrfs check --readonly finds tons of errors:

[1/7] checking root items
[2/7] checking extents
parent transid verify failed on 57083985920 wanted 972457 found 971340
parent transid verify failed on 57083985920 wanted 972457 found 971340
Ignoring transid failure
leaf parent key incorrect 57083985920
bad block 57083985920
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
parent transid verify failed on 57083985920 wanted 972457 found 971340
Ignoring transid failure
parent transid verify failed on 57083985920 wanted 972457 found 971340
Ignoring transid failure
Wrong key of child node/leaf, wanted: (1537781, 108, 0), have: (624, 1, 
0)
Wrong generation of child node/leaf, wanted: 971340, have: 972457
root 791 inode 1537781 errors 500, file extent discount, nbytes wrong
Found file extent holes:
	start: 0, len: 4096
root 791 inode 1537783 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 18 namelen 11 name compareDesc 
filetype 2 errors 4, no inode ref
root 791 inode 1537786 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 19 namelen 9 name constants filetype 2 
errors 4, no inode ref
root 791 inode 1537789 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 20 namelen 24 name 
differenceInBusinessDays filetype 2 errors 4, no inode ref
root 791 inode 1537792 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 21 namelen 24 name 
differenceInCalendarDays filetype 2 errors 4, no inode ref
root 791 inode 1537795 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 22 namelen 28 name 
differenceInCalendarISOWeeks filetype 2 errors 4, no inode ref
root 791 inode 1537798 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 23 namelen 32 name 
differenceInCalendarISOWeekYears filetype 2 errors 4, no inode ref
root 791 inode 1537801 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 24 namelen 26 name 
differenceInCalendarMonths filetype 2 errors 4, no inode ref
root 791 inode 1537804 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 25 namelen 28 name 
differenceInCalendarQuarters filetype 2 errors 4, no inode ref
root 791 inode 1537807 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 26 namelen 25 name 
differenceInCalendarWeeks filetype 2 errors 4, no inode ref
root 791 inode 1537810 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 27 namelen 25 name 
differenceInCalendarYears filetype 2 errors 4, no inode ref
root 791 inode 1537813 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 28 namelen 16 name differenceInDays 
filetype 2 errors 4, no inode ref
root 791 inode 1537816 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 29 namelen 17 name differenceInHours 
filetype 2 errors 4, no inode ref
root 791 inode 1537819 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 30 namelen 24 name 
differenceInISOWeekYears filetype 2 errors 4, no inode ref
root 791 inode 1537822 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 31 namelen 24 name 
differenceInMilliseconds filetype 2 errors 4, no inode ref
root 791 inode 1537825 errors 2001, no inode item, link count wrong
	unresolved ref dir 1537733 index 32 namelen 19 name differenceInMinutes 
filetype 2 errors 4, no inode ref
[~40K lines omitted]
root 791 inode 1821997 errors 2001, no inode item, link count wrong
	unresolved ref dir 1078897 index 933 namelen 14 name the-real-index 
filetype 1 errors 4, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on 
/run/media/liveuser/af2edb18-6dc9-4b0b-95e9-2d15dac982a2/nvme0n1p8_rw.img
UUID: b6016af6-f31f-4f04-b6b0-a8bd26726e1d
found 63358636066 bytes used, error(s) found
total csum bytes: 54943948
total tree bytes: 990560256
total fs tree bytes: 779583488
total extent tree bytes: 135659520
btree space waste bytes: 162881656
file data blocks allocated: 42790731776
  referenced 53778624512


I tried btrfs check --repair but it segfaulted:

enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on 
/run/media/liveuser/af2edb18-6dc9-4b0b-95e9-2d15dac982a2/nvme0n1p8_rw.img
UUID: b6016af6-f31f-4f04-b6b0-a8bd26726e1d
repair mode will force to clear out log tree, are you sure? [y/N]: y
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
parent transid verify failed on 57083985920 wanted 972457 found 971340
parent transid verify failed on 57083985920 wanted 972457 found 971340
Ignoring transid failure
leaf parent key incorrect 57083985920
bad block 57083985920
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
parent transid verify failed on 57083985920 wanted 972457 found 971340
Ignoring transid failure
parent transid verify failed on 57083985920 wanted 972457 found 971340
Ignoring transid failure
Wrong key of child node/leaf, wanted: (1537781, 108, 0), have: (624, 1, 
0)
Wrong generation of child node/leaf, wanted: 971340, have: 972457
Deleting bad dir index [1537733,96,18] root 791
Deleting bad dir index [1537733,96,19] root 791
Deleting bad dir index [1537733,96,20] root 791
Deleting bad dir index [1537733,96,21] root 791
Deleting bad dir index [1537733,96,22] root 791
Deleting bad dir index [1537733,96,23] root 791
Deleting bad dir index [1537733,96,24] root 791
[~1600 lines omitted]
Deleting bad dir index [1518523,96,1724] root 791
Segmentation fault


[ 2870.684890] show_signal_msg: 2 callbacks suppressed
[ 2870.684892] btrfs[3163]: segfault at 60 ip 000055d6d93e5786 sp 
00007ffd3f27a600 error 4 in btrfs[55d6d9382000+96000]
[ 2870.684899] Code: 00 00 00 00 00 4c 89 ff e8 57 a1 ff ff 8b 4c 24 68 
4c 89 fe 85 c0 0f 44 44 24 30 45 31 c0 89 44 24 30 48 8b 84 24 a0 00 00 
00 <8b> 40 60 49 29 87 d0 00 00 00 6a 00 55 48 8b 94 24 90 00 00 00 48


Full dmesg: https://pastebin.com/pNBhAPS5
I use zstd compression in both of my systems, both of them use SSDs.
Please not that all of my btrfs fs are regularly scrubbed and I've never 
found any scrub error.
My laptop had been memtested few weeks before the data loss and my 
desktop a couple of months ago.
I have snapper hourly snapshots and pre-post transactional snapshots in 
all of them.

I have another laptop with Arch Linux and btrfs, should I be worried 
about it? Maybe it's a Fedora thing?

Bests,
Niccolo' Belli
