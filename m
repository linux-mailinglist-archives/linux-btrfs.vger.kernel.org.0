Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978311BE751
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD2T06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 15:26:58 -0400
Received: from mailfilter03-out31.webhostingserver.nl ([141.138.168.202]:25339
        "EHLO mailfilter03-out31.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgD2T06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 15:26:58 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 15:26:53 EDT
X-Halon-ID: 232bd9e3-8a4d-11ea-b562-001a4a4cb9a5
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id 232bd9e3-8a4d-11ea-b562-001a4a4cb9a5;
        Wed, 29 Apr 2020 21:10:49 +0200 (CEST)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.6])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1jTs6b-00HMbA-Cz
        for linux-btrfs@vger.kernel.org; Wed, 29 Apr 2020 21:10:49 +0200
Subject: Input/output errors (unreadables files)
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
To:     linux-btrfs@vger.kernel.org
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <b178dd1e-7ef6-6808-5656-d9e22056cf1f@gmail.com>
Date:   Wed, 29 Apr 2020 21:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While upgrading Ubuntu the upgrade fails due to input/output errors on 4 
files. Journal shows the same block is causing the problem for all 4 files.

I would like to delete the files, but that appears impossible.

I fear to reboot before finishing the upgrade, so this is with the old 
kernel:

ferry@ferry-quad:~$ uname -a
Linux ferry-quad 5.3.0-51-generic #44-Ubuntu SMP Wed Apr 22 21:09:44 UTC 
2020 x86_64 x86_64 x86_64 GNU/Linux

ferry@ferry-quad:~$ journalctl -b -e
...
apr 29 20:51:39 ferry-quad kernel: BTRFS critical (device sda2): corrupt 
leaf: root=294 block=1027628027904 slot=1 ino=915987, invalid inode generat>
apr 29 20:51:39 ferry-quad kernel: BTRFS error (device sda2): 
block=1027628027904 read time tree block corruption detected
apr 29 20:51:55 ferry-quad kernel: BTRFS critical (device sda2): corrupt 
leaf: root=294 block=1027628027904 slot=1 ino=915987, invalid inode generat>
apr 29 20:51:55 ferry-quad kernel: BTRFS error (device sda2): 
block=1027628027904 read time tree block corruption detected

ferry@ferry-quad:~$ sudo btrfs ins dump-tree -b 1027628027904 /dev/sda2
btrfs-progs v5.3-rc1
leaf 1027628027904 items 36 free space 966 generation 4933124 owner 294
leaf 1027628027904 flags 0x1(WRITTEN) backref revision 1
fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
         item 0 key (915986 DIR_INDEX 2) itemoff 3957 itemsize 38
                 location key (915987 INODE_ITEM 0) type FILE
                 transid 7782235549259005952 data_len 0 name_len 8
                 name: smb.conf
         item 1 key (915987 INODE_ITEM 0) itemoff 3797 itemsize 160
                 generation 1 transid 18446744073709551492 size 12464 
nbytes 16384
                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
                 sequence 0 flags 0x0(none)
                 atime 1350489744.0 (2012-10-17 18:02:24)
                 ctime 1353328654.0 (2012-11-19 13:37:34)
                 mtime 1350489744.0 (2012-10-17 18:02:24)
                 otime 0.0 (1970-01-01 01:00:00)
         item 2 key (915987 INODE_REF 915986) itemoff 3779 itemsize 18
                 index 2 namelen 8 name: smb.conf
         item 3 key (915987 EXTENT_DATA 0) itemoff 3726 itemsize 53
                 generation 18 type 1 (regular)
                 extent data disk byte 1110664871936 nr 16384
                 extent data offset 0 nr 16384 ram 16384
                 extent compression 0 (none)
         item 4 key (915989 INODE_ITEM 0) itemoff 3566 itemsize 160
                 generation 1 transid 4933124 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 144 flags 0x0(none)
                 atime 1571487761.716511096 (2019-10-19 14:22:41)
                 ctime 1571414492.451090452 (2019-10-18 18:01:32)
                 mtime 1571414492.451090452 (2019-10-18 18:01:32)
                 otime 0.0 (1970-01-01 01:00:00)
         item 5 key (915989 INODE_REF 659081) itemoff 3546 itemsize 20
                 index 1101 namelen 10 name: libassuan0
         item 6 key (915989 DIR_ITEM 653215628) itemoff 3497 itemsize 49
                 location key (61471579 INODE_ITEM 0) type FILE
                 transid 4900555 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 7 key (915989 DIR_ITEM 1600214284) itemoff 3458 itemsize 39
                 location key (61471580 INODE_ITEM 0) type FILE
                 transid 4900555 data_len 0 name_len 9
                 name: copyright
         item 8 key (915989 DIR_INDEX 56) itemoff 3409 itemsize 49
                 location key (61471579 INODE_ITEM 0) type FILE
                 transid 4900555 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 9 key (915989 DIR_INDEX 57) itemoff 3370 itemsize 39
                 location key (61471580 INODE_ITEM 0) type FILE
                 transid 4900555 data_len 0 name_len 9
                 name: copyright
         item 10 key (915990 INODE_ITEM 0) itemoff 3210 itemsize 160
                 generation 1 transid 4933124 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 96 flags 0x0(none)
                 atime 1571487761.720511096 (2019-10-19 14:22:41)
                 ctime 1477470910.249847328 (2016-10-26 10:35:10)
                 mtime 1477470910.249847328 (2016-10-26 10:35:10)
                 otime 0.0 (1970-01-01 01:00:00)
         item 11 key (915990 INODE_REF 659081) itemoff 3189 itemsize 21
                 index 1343 namelen 11 name: libasyncns0
         item 12 key (915990 DIR_ITEM 653215628) itemoff 3140 itemsize 49
                 location key (25762857 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 13 key (915990 DIR_ITEM 1600214284) itemoff 3101 itemsize 39
                 location key (25762858 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 9
                 name: copyright
         item 14 key (915990 DIR_INDEX 38) itemoff 3052 itemsize 49
                 location key (25762857 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 15 key (915990 DIR_INDEX 39) itemoff 3013 itemsize 39
                 location key (25762858 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 9
                 name: copyright
         item 16 key (915991 INODE_ITEM 0) itemoff 2853 itemsize 160
                 generation 1 transid 4933124 size 68 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 48 flags 0x0(none)
                 atime 1571487761.720511096 (2019-10-19 14:22:41)
                 ctime 1540813807.330187853 (2018-10-29 12:50:07)
                 mtime 1540813807.330187853 (2018-10-29 12:50:07)
                 otime 0.0 (1970-01-01 01:00:00)
         item 17 key (915991 INODE_REF 659081) itemoff 2831 itemsize 22
                 index 1545 namelen 12 name: libatasmart4
         item 18 key (915991 DIR_ITEM 653215628) itemoff 2782 itemsize 49
                 location key (52273681 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 19 key (915991 DIR_ITEM 1600214284) itemoff 2743 itemsize 39
                 location key (52273682 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 9
                 name: copyright
         item 20 key (915991 DIR_ITEM 3650993379) itemoff 2707 itemsize 36
                 location key (52273680 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 6
                 name: README
         item 21 key (915991 DIR_INDEX 20) itemoff 2671 itemsize 36
                 location key (52273680 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 6
                 name: README
         item 22 key (915991 DIR_INDEX 21) itemoff 2622 itemsize 49
                 location key (52273681 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 23 key (915991 DIR_INDEX 22) itemoff 2583 itemsize 39
                 location key (52273682 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 9
                 name: copyright
         item 24 key (915992 INODE_ITEM 0) itemoff 2423 itemsize 160
                 generation 1 transid 4933124 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 595 flags 0x0(none)
                 atime 1571487761.728511097 (2019-10-19 14:22:41)
                 ctime 1571414569.458782758 (2019-10-18 18:02:49)
                 mtime 1571414569.458782758 (2019-10-18 18:02:49)
                 otime 0.0 (1970-01-01 01:00:00)
         item 25 key (915992 INODE_REF 659081) itemoff 2402 itemsize 21
                 index 2141 namelen 11 name: libatk1.0-0
         item 26 key (915992 DIR_ITEM 653215628) itemoff 2353 itemsize 49
                 location key (61511250 INODE_ITEM 0) type FILE
                 transid 4902445 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 27 key (915992 DIR_ITEM 1600214284) itemoff 2314 itemsize 39
                 location key (61511251 INODE_ITEM 0) type FILE
                 transid 4902445 data_len 0 name_len 9
                 name: copyright
         item 28 key (915992 DIR_INDEX 227) itemoff 2265 itemsize 49
                 location key (61511250 INODE_ITEM 0) type FILE
                 transid 4902445 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 29 key (915992 DIR_INDEX 228) itemoff 2226 itemsize 39
                 location key (61511251 INODE_ITEM 0) type FILE
                 transid 4902445 data_len 0 name_len 9
                 name: copyright
         item 30 key (915993 INODE_ITEM 0) itemoff 2066 itemsize 160
                 generation 1 transid 4933124 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 299 flags 0x0(none)
                 atime 1571487761.720511096 (2019-10-19 14:22:41)
                 ctime 1571414569.158783954 (2019-10-18 18:02:49)
                 mtime 1571414569.158783954 (2019-10-18 18:02:49)
                 otime 0.0 (1970-01-01 01:00:00)
         item 31 key (915993 INODE_REF 659081) itemoff 2042 itemsize 24
                 index 1639 namelen 14 name: libatk1.0-data
         item 32 key (915993 DIR_ITEM 653215628) itemoff 1993 itemsize 49
                 location key (61511215 INODE_ITEM 0) type FILE
                 transid 4902428 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 33 key (915993 DIR_ITEM 1600214284) itemoff 1954 itemsize 39
                 location key (61511216 INODE_ITEM 0) type FILE
                 transid 4902428 data_len 0 name_len 9
                 name: copyright
         item 34 key (915993 DIR_INDEX 116) itemoff 1905 itemsize 49
                 location key (61511215 INODE_ITEM 0) type FILE
                 transid 4902428 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 35 key (915993 DIR_INDEX 117) itemoff 1866 itemsize 39
                 location key (61511216 INODE_ITEM 0) type FILE
                 transid 4902428 data_len 0 name_len 9
                 name: copyright

