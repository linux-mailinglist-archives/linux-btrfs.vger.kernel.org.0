Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A12155CD
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 12:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgGFKrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 06:47:42 -0400
Received: from poltsi.fi ([173.249.44.251]:45088 "EHLO poltsi.fi"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbgGFKrl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 06:47:41 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 06:47:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by poltsi.fi (Postfix) with ESMTP id 2F6066E05F2
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 13:41:14 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poltsi.fi 2F6066E05F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=poltsi.fi; s=default;
        t=1594032074; bh=Di2LAaAxpKCN0+OFTWdvhjQbl5cvjSftTavuRSfjOqk=;
        h=Date:From:To:Subject:From;
        b=PtPi9qQTf1MJ06aQUQuLRHaGAcmAJa4ndDenmd4OhWQn5EAkBzSsbNjYBGoqj0SOy
         d2oOte6NlrY/l1gsI4VETaVA3ZsEQZrgpq4byByUT0tr8EAmwptfSEZTw1b3iH0Muq
         Wk++9v+Iu4wIWdIj6MryF4Vexanc3gop/WvcjtK8=
X-Virus-Scanned: amavisd-new at poltsi.fi
Received: from poltsi.fi ([127.0.0.1])
        by localhost (poltsi.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hUYEqK5dYS9R for <linux-btrfs@vger.kernel.org>;
        Mon,  6 Jul 2020 13:41:12 +0300 (EEST)
Received: from webmail.poltsi.fi (localhost.localdomain [127.0.0.1])
        by poltsi.fi (Postfix) with ESMTP id 1EFD26E0584
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 13:41:12 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poltsi.fi 1EFD26E0584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=poltsi.fi; s=default;
        t=1594032072; bh=Di2LAaAxpKCN0+OFTWdvhjQbl5cvjSftTavuRSfjOqk=;
        h=Date:From:To:Subject:From;
        b=CfrgpgTyWoW9Zzg6HtoGMF6Vhq+45mX/P3DZ/VFA5jFZh5c3rzXDN01Vn505/TJXN
         cmQANoDW/HIdZH9ZXHuHR4jEbzEpGh1LFJOaltRyhsAOh6NcAF4akZU9xCBupUBakh
         gZ+6Vfzk5lASJdv5GBue7fAJQj/a76YPnnoLS06Q=
MIME-Version: 1.0
Date:   Mon, 06 Jul 2020 13:41:12 +0300
From:   =?UTF-8?Q?Paul-Erik_T=C3=B6rr=C3=B6nen?= <poltsi@poltsi.fi>
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS-errors on a 20TB filesystem
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
X-Sender: poltsi@poltsi.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OS: CentOS8 with updated kernel and btrfs-tools
Kernel: 5.4.17-2011.3.2.1.el8uek.x86_64
btrfs version: 5.6.1

Some background. The file server had been running for quite some time 
before I reinstalled it with CentOS 8, at which point I noticed (after 
having installed the Oracle UEK kernel which still supports btrfs) the 
errors when mounting the partition. I updated the btrfs-tools to latest 
and ran the  'btrfs check --repair /dev/sdc1', but despite this, still 
have errors when accessing certain files on the FS. Dmesg shows them as 
following:

[1681476.647521] BTRFS error (device sdc1): block=3154170920960 read 
time tree block corruption detected
[1681476.694520] BTRFS critical (device sdc1): corrupt leaf: root=5 
block=3154170920960 slot=9 ino=13286681 file_offset=204800, extent end 
overflow, have file offset 204800 extent num bytes 18446744073709481984

There does not appear to be any HW-related errors in the logs.

With the help of darkling on Freenode IRC #btrfs collected the following 
information:

btrfs inspect dump-tree -b 3154170920960 /dev/sdc1 ->

btrfs-progs v5.6.1
leaf 3154170920960 items 97 free space 6102 generation 1326633 owner 
FS_TREE
leaf 3154170920960 flags 0x1(WRITTEN) backref revision 1
fs uuid 519a6725-10d4-4d82-bc4a-32de7dfb923f
chunk uuid 4d1fe695-d2cb-43bc-bac6-d3101dc0725b
         item 0 key (13286391 INODE_REF 2479498) itemoff 16245 itemsize 
38
                 index 8927 namelen 28 name: file_28-2
         item 1 key (13286391 EXTENT_DATA 0) itemoff 15384 itemsize 861
                 generation 152266 type 0 (inline)
                 inline extent data size 840 ram_bytes 840 compression 0 
(none)
         item 2 key (13286679 INODE_ITEM 0) itemoff 15224 itemsize 160
                 generation 148004 transid 1326604 size 0 nbytes 0
                 block group 0 mode 40700 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 5 flags 0x0(none)
                 atime 1592086804.669979287 (2020-06-14 01:20:04)
                 ctime 1488735439.699720907 (2017-03-05 19:37:19)
                 mtime 1488735439.699720907 (2017-03-05 19:37:19)
                 otime 1488735439.699720907 (2017-03-05 19:37:19)
         item 3 key (13286679 INODE_REF 900409) itemoff 15200 itemsize 24
                 index 156 namelen 14 name: file_14
         item 4 key (13286681 INODE_ITEM 0) itemoff 15040 itemsize 160
                 generation 148002 transid 1102464 size 203197 nbytes 
204800
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 43 flags 0x10(PREALLOC)
                 atime 1550596828.990479215 (2019-02-19 19:20:28)
                 ctime 1488735117.417279715 (2017-03-05 19:31:57)
                 mtime 1488735117.417279715 (2017-03-05 19:31:57)
                 otime 2562566064006200577.1311248627 (-399890746-03-05 
07:02:57)
         item 5 key (13286681 INODE_REF 2479479) itemoff 15005 itemsize 
35
                 index 10704 namelen 25 name: file_25-1
         item 6 key (13286681 EXTENT_DATA 0) itemoff 14952 itemsize 53
                 generation 148002 type 1 (regular)
                 extent data disk byte 2584805376 nr 204800
                 extent data offset 0 nr 90112 ram 204800
                 extent compression 0 (none)
         item 7 key (13286681 EXTENT_DATA 90112) itemoff 14899 itemsize 
53
                 generation 148002 type 2 (prealloc)
                 prealloc data disk byte 2584805376 nr 204800
                 prealloc data offset 90112 nr 45056
         item 8 key (13286681 EXTENT_DATA 135168) itemoff 14846 itemsize 
53
                 generation 148002 type 2 (prealloc)
                 prealloc data disk byte 2584805376 nr 204800
                 prealloc data offset 135168 nr 69632
         item 9 key (13286681 EXTENT_DATA 204800) itemoff 14793 itemsize 
53
                 generation 148002 type 1 (regular)
                 extent data disk byte 0 nr 0
                 extent data offset 0 nr 18446744073709481984 ram 
18446744073709481984
                 extent compression 0 (none)
         item 10 key (13286688 INODE_ITEM 0) itemoff 14633 itemsize 160
                 generation 148004 transid 1102464 size 260920 nbytes 
262144
                 block group 0 mode 100600 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 16 flags 0x0(none)
                 atime 1550596832.43520915 (2019-02-19 19:20:32)
                 ctime 1488735464.584054948 (2017-03-05 19:37:44)
                 mtime 1488735464.582054920 (2017-03-05 19:37:44)
                 otime 1488735448.969845407 (2017-03-05 19:37:28)
         item 11 key (13286688 INODE_REF 2479498) itemoff 14595 itemsize 
38
                 index 8938 namelen 28 name: file_28-3
         item 12 key (13286688 EXTENT_DATA 0) itemoff 14542 itemsize 53
                 generation 148004 type 1 (regular)
                 extent data disk byte 9637261312 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 13 key (13286688 EXTENT_DATA 4096) itemoff 14489 itemsize 
53
                 generation 148004 type 1 (regular)
                 extent data disk byte 9657868288 nr 262144
                 extent data offset 4096 nr 258048 ram 262144
                 extent compression 0 (none)
         item 14 key (13286689 INODE_ITEM 0) itemoff 14329 itemsize 160
                 generation 148004 transid 1102464 size 260920 nbytes 
262144
                 block group 0 mode 100600 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 20 flags 0x0(none)
                 atime 1550596832.58521110 (2019-02-19 19:20:32)
                 ctime 1488738351.833534788 (2017-03-05 20:25:51)
                 mtime 1488738351.820533449 (2017-03-05 20:25:51)
                 otime 1488735464.569054738 (2017-03-05 19:37:44)
         item 15 key (13286689 INODE_REF 2479498) itemoff 14291 itemsize 
38
                 index 8943 namelen 28 name: file_28-4
         item 16 key (13286689 EXTENT_DATA 0) itemoff 14238 itemsize 53
                 generation 148006 type 1 (regular)
                 extent data disk byte 11572387840 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 17 key (13286689 EXTENT_DATA 4096) itemoff 14185 itemsize 
53
                 generation 148004 type 1 (regular)
                 extent data disk byte 11674513408 nr 262144
                 extent data offset 4096 nr 258048 ram 262144
                 extent compression 0 (none)
         item 18 key (13286690 INODE_ITEM 0) itemoff 14025 itemsize 160
                 generation 148006 transid 1326604 size 32 nbytes 0
                 block group 0 mode 40700 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 3 flags 0x0(none)
                 atime 1592086804.800980991 (2020-06-14 01:20:04)
                 ctime 1488738347.123047782 (2017-03-05 20:25:47)
                 mtime 1488738347.123047782 (2017-03-05 20:25:47)
                 otime 1488738346.417975047 (2017-03-05 20:25:46)
         item 19 key (13286690 INODE_REF 900409) itemoff 14001 itemsize 
24
                 index 157 namelen 14 name: file_14-3
         item 20 key (13286690 DIR_ITEM 2066004016) itemoff 13964 
itemsize 37
                 location key (13286691 INODE_ITEM 0) type SOCK
                 transid 148006 data_len 0 name_len 7
                 name: control
         item 21 key (13286690 DIR_ITEM 2665264527) itemoff 13928 
itemsize 36
                 location key (13286697 INODE_ITEM 0) type SOCK
                 transid 148006 data_len 0 name_len 6
                 name: pkcs11
         item 22 key (13286690 DIR_ITEM 3872833404) itemoff 13895 
itemsize 33
                 location key (13286695 INODE_ITEM 0) type SOCK
                 transid 148006 data_len 0 name_len 3
                 name: ssh
         item 23 key (13286690 DIR_INDEX 2) itemoff 13858 itemsize 37
                 location key (13286691 INODE_ITEM 0) type SOCK
                 transid 148006 data_len 0 name_len 7
                 name: control
         item 24 key (13286690 DIR_INDEX 3) itemoff 13825 itemsize 33
                 location key (13286695 INODE_ITEM 0) type SOCK
                 transid 148006 data_len 0 name_len 3
                 name: ssh
         item 25 key (13286690 DIR_INDEX 4) itemoff 13789 itemsize 36
                 location key (13286697 INODE_ITEM 0) type SOCK
                 transid 148006 data_len 0 name_len 6
                 name: pkcs11
         item 26 key (13286691 INODE_ITEM 0) itemoff 13629 itemsize 160
                 generation 148006 transid 148006 size 0 nbytes 0
                 block group 0 mode 140755 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 0 flags 0x0(none)
                 atime 1488738346.419975253 (2017-03-05 20:25:46)
                 ctime 1488738346.419975253 (2017-03-05 20:25:46)
                 mtime 1488738346.419975253 (2017-03-05 20:25:46)
                 otime 1488738346.419975253 (2017-03-05 20:25:46)
         item 27 key (13286691 INODE_REF 13286690) itemoff 13612 itemsize 
17
                 index 2 namelen 7 name: file_7
         item 28 key (13286695 INODE_ITEM 0) itemoff 13452 itemsize 160
                 generation 148006 transid 148006 size 0 nbytes 0
                 block group 0 mode 140755 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 0 flags 0x0(none)
                 atime 1488738347.96044974 (2017-03-05 20:25:47)
                 ctime 1488738347.96044974 (2017-03-05 20:25:47)
                 mtime 1488738347.96044974 (2017-03-05 20:25:47)
                 otime 1488738347.96044974 (2017-03-05 20:25:47)
         item 29 key (13286695 INODE_REF 13286690) itemoff 13439 itemsize 
13
                 index 3 namelen 3 name: file_3
         item 30 key (13286697 INODE_ITEM 0) itemoff 13279 itemsize 160
                 generation 148006 transid 148006 size 0 nbytes 0
                 block group 0 mode 140755 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 0 flags 0x0(none)
                 atime 1488738347.123047782 (2017-03-05 20:25:47)
                 ctime 1488738347.123047782 (2017-03-05 20:25:47)
                 mtime 1488738347.123047782 (2017-03-05 20:25:47)
                 otime 1488738347.123047782 (2017-03-05 20:25:47)
         item 31 key (13286697 INODE_REF 13286690) itemoff 13263 itemsize 
16
                 index 4 namelen 6 name: file_6
         item 32 key (13286702 INODE_ITEM 0) itemoff 13103 itemsize 160
                 generation 148006 transid 1102464 size 260920 nbytes 
262144
                 block group 0 mode 100600 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 35 flags 0x0(none)
                 atime 1550596832.69521253 (2019-02-19 19:20:32)
                 ctime 1488738366.693069142 (2017-03-05 20:26:06)
                 mtime 1488738366.691068936 (2017-03-05 20:26:06)
                 otime 1488738351.808532213 (2017-03-05 20:25:51)
         item 33 key (13286702 INODE_REF 2479498) itemoff 13065 itemsize 
38
                 index 8954 namelen 28 name: file_28-5
         item 34 key (13286702 EXTENT_DATA 0) itemoff 13012 itemsize 53
                 generation 148006 type 1 (regular)
                 extent data disk byte 11247833088 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 35 key (13286702 EXTENT_DATA 4096) itemoff 12959 itemsize 
53
                 generation 148006 type 1 (regular)
                 extent data disk byte 11297587200 nr 262144
                 extent data offset 4096 nr 258048 ram 262144
                 extent compression 0 (none)
         item 36 key (13286703 INODE_ITEM 0) itemoff 12799 itemsize 160
                 generation 148006 transid 1102464 size 260920 nbytes 
262144
                 block group 0 mode 100600 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 20 flags 0x0(none)
                 atime 1550596832.79521383 (2019-02-19 19:20:32)
                 ctime 1488886782.768250242 (2017-03-07 13:39:42)
                 mtime 1488886782.754250046 (2017-03-07 13:39:42)
                 otime 1488738366.683068112 (2017-03-05 20:26:06)
         item 37 key (13286703 INODE_REF 2479498) itemoff 12761 itemsize 
38
                 index 8959 namelen 28 name: file_28-6
         item 38 key (13286703 EXTENT_DATA 0) itemoff 12708 itemsize 53
                 generation 148129 type 1 (regular)
                 extent data disk byte 11437883392 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 39 key (13286703 EXTENT_DATA 4096) itemoff 12655 itemsize 
53
                 generation 148006 type 1 (regular)
                 extent data disk byte 11438669824 nr 262144
                 extent data offset 4096 nr 258048 ram 262144
                 extent compression 0 (none)
         item 40 key (13297612 INODE_ITEM 0) itemoff 12495 itemsize 160
                 generation 148121 transid 1325358 size 1061600571 nbytes 
1061601280
                 block group 0 mode 100644 links 1 uid 1008 gid 100 rdev 
0
                 sequence 2126 flags 0x0(none)
                 atime 1590315849.886896471 (2020-05-24 13:24:09)
                 ctime 1584291921.928542285 (2020-03-15 19:05:21)
                 mtime 1488831483.0 (2017-03-06 22:18:03)
                 otime 1488881824.206510455 (2017-03-07 12:17:04)
         item 41 key (13297612 INODE_REF 1135595) itemoff 12442 itemsize 
53
                 index 426 namelen 43 name: 
big_file_with_43_chars_in_name
         item 42 key (13297612 EXTENT_DATA 0) itemoff 12389 itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15798103609344 nr 132284416
                 extent data offset 0 nr 132284416 ram 132284416
                 extent compression 0 (none)
         item 43 key (13297612 EXTENT_DATA 132284416) itemoff 12336 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15798235893760 nr 120033280
                 extent data offset 0 nr 120033280 ram 120033280
                 extent compression 0 (none)
         item 44 key (13297612 EXTENT_DATA 252317696) itemoff 12283 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15798355927040 nr 6811648
                 extent data offset 0 nr 6811648 ram 6811648
                 extent compression 0 (none)
         item 45 key (13297612 EXTENT_DATA 259129344) itemoff 12230 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15798362738688 nr 88006656
                 extent data offset 0 nr 88006656 ram 88006656
                 extent compression 0 (none)
         item 46 key (13297612 EXTENT_DATA 347136000) itemoff 12177 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15798450745344 nr 29892608
                 extent data offset 0 nr 29892608 ram 29892608
                 extent compression 0 (none)
         item 47 key (13297612 EXTENT_DATA 377028608) itemoff 12124 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815371431936 nr 66527232
                 extent data offset 0 nr 66527232 ram 66527232
                 extent compression 0 (none)
         item 48 key (13297612 EXTENT_DATA 443555840) itemoff 12071 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815437959168 nr 5242880
                 extent data offset 0 nr 5242880 ram 5242880
                 extent compression 0 (none)
         item 49 key (13297612 EXTENT_DATA 448798720) itemoff 12018 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815443202048 nr 134217728
                 extent data offset 0 nr 134217728 ram 134217728
                 extent compression 0 (none)
         item 50 key (13297612 EXTENT_DATA 583016448) itemoff 11965 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815577419776 nr 4714496
                 extent data offset 0 nr 4714496 ram 4714496
                 extent compression 0 (none)
         item 51 key (13297612 EXTENT_DATA 587730944) itemoff 11912 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815582134272 nr 1048576
                 extent data offset 0 nr 1048576 ram 1048576
                 extent compression 0 (none)
         item 52 key (13297612 EXTENT_DATA 588779520) itemoff 11859 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815583182848 nr 99094528
                 extent data offset 0 nr 99094528 ram 99094528
                 extent compression 0 (none)
         item 53 key (13297612 EXTENT_DATA 687874048) itemoff 11806 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815709556736 nr 13107200
                 extent data offset 0 nr 13107200 ram 13107200
                 extent compression 0 (none)
         item 54 key (13297612 EXTENT_DATA 700981248) itemoff 11753 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815722663936 nr 60813312
                 extent data offset 0 nr 60813312 ram 60813312
                 extent compression 0 (none)
         item 55 key (13297612 EXTENT_DATA 761794560) itemoff 11700 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15815783477248 nr 9437184
                 extent data offset 0 nr 9437184 ram 9437184
                 extent compression 0 (none)
         item 56 key (13297612 EXTENT_DATA 771231744) itemoff 11647 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15823350005760 nr 74448896
                 extent data offset 0 nr 74448896 ram 74448896
                 extent compression 0 (none)
         item 57 key (13297612 EXTENT_DATA 845680640) itemoff 11594 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15823424454656 nr 17825792
                 extent data offset 0 nr 17825792 ram 17825792
                 extent compression 0 (none)
         item 58 key (13297612 EXTENT_DATA 863506432) itemoff 11541 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15823442280448 nr 90701824
                 extent data offset 0 nr 90701824 ram 90701824
                 extent compression 0 (none)
         item 59 key (13297612 EXTENT_DATA 954208256) itemoff 11488 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15823532982272 nr 10485760
                 extent data offset 0 nr 10485760 ram 10485760
                 extent compression 0 (none)
         item 60 key (13297612 EXTENT_DATA 964694016) itemoff 11435 
itemsize 53
                 generation 148121 type 1 (regular)
                 extent data disk byte 15823543468032 nr 96907264
                 extent data offset 0 nr 96907264 ram 96907264
                 extent compression 0 (none)
         item 61 key (13302605 INODE_ITEM 0) itemoff 11275 itemsize 160
                 generation 148129 transid 1326604 size 0 nbytes 0
                 block group 0 mode 40700 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 10 flags 0x0(none)
                 atime 1592086805.267986802 (2020-06-14 01:20:05)
                 ctime 1488900070.442871595 (2017-03-07 17:21:10)
                 mtime 1488900070.442871595 (2017-03-07 17:21:10)
                 otime 1488886774.862145705 (2017-03-07 13:39:34)
         item 62 key (13302605 INODE_REF 900409) itemoff 11251 itemsize 
24
                 index 158 namelen 14 name: small_file_14
         item 63 key (13307302 INODE_ITEM 0) itemoff 11091 itemsize 160
                 generation 148460 transid 1102480 size 495704 nbytes 
499712
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 48 flags 0x0(none)
                 atime 1550597373.931849749 (2019-02-19 19:29:33)
                 ctime 1488896313.806827176 (2017-03-07 16:18:33)
                 mtime 1488896313.806827176 (2017-03-07 16:18:33)
                 otime 1488896313.801827111 (2017-03-07 16:18:33)
         item 64 key (13307302 INODE_REF 11122229) itemoff 11043 itemsize 
48
                 index 279 namelen 38 name: another_small_file
         item 65 key (13307302 EXTENT_DATA 0) itemoff 10990 itemsize 53
                 generation 148460 type 1 (regular)
                 extent data disk byte 20033806336 nr 499712
                 extent data offset 0 nr 499712 ram 499712
                 extent compression 0 (none)
         item 66 key (13307389 INODE_ITEM 0) itemoff 10830 itemsize 160
                 generation 148467 transid 1102480 size 496950 nbytes 
499712
                 block group 0 mode 100744 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 286 flags 0x0(none)
                 atime 1550597373.942849903 (2019-02-19 19:29:33)
                 ctime 1489576077.166776499 (2017-03-15 13:07:57)
                 mtime 1489576077.167453345 (2017-03-15 13:07:57)
                 otime 1488896569.897196052 (2017-03-07 16:22:49)
         item 67 key (13307389 INODE_REF 11122229) itemoff 10782 itemsize 
48
                 index 281 namelen 38 name: file_38
         item 68 key (13307389 EXTENT_DATA 0) itemoff 10729 itemsize 53
                 generation 153548 type 1 (regular)
                 extent data disk byte 11712847872 nr 499712
                 extent data offset 0 nr 499712 ram 499712
                 extent compression 0 (none)
         item 69 key (13307744 INODE_ITEM 0) itemoff 10569 itemsize 160
                 generation 148490 transid 1102480 size 493827 nbytes 
495616
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 40 flags 0x0(none)
                 atime 1550597373.961850170 (2019-02-19 19:29:33)
                 ctime 1488897262.317312575 (2017-03-07 16:34:22)
                 mtime 1488897262.317312575 (2017-03-07 16:34:22)
                 otime 1488897262.311312497 (2017-03-07 16:34:22)
         item 70 key (13307744 INODE_REF 11122229) itemoff 10527 itemsize 
42
                 index 284 namelen 32 name: file_32
         item 71 key (13307744 EXTENT_DATA 0) itemoff 10474 itemsize 53
                 generation 148490 type 1 (regular)
                 extent data disk byte 28656959488 nr 401408
                 extent data offset 0 nr 401408 ram 401408
                 extent compression 0 (none)
         item 72 key (13307744 EXTENT_DATA 401408) itemoff 10421 itemsize 
53
                 generation 148490 type 1 (regular)
                 extent data disk byte 2681602048 nr 36864
                 extent data offset 0 nr 36864 ram 36864
                 extent compression 0 (none)
         item 73 key (13307744 EXTENT_DATA 438272) itemoff 10368 itemsize 
53
                 generation 148490 type 1 (regular)
                 extent data disk byte 28621971456 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 74 key (13307744 EXTENT_DATA 442368) itemoff 10315 itemsize 
53
                 generation 148490 type 1 (regular)
                 extent data disk byte 28625227776 nr 53248
                 extent data offset 0 nr 53248 ram 53248
                 extent compression 0 (none)
         item 75 key (13307984 INODE_ITEM 0) itemoff 10155 itemsize 160
                 generation 148503 transid 1102480 size 494844 nbytes 
495616
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 1223 flags 0x0(none)
                 atime 1550597373.987850533 (2019-02-19 19:29:33)
                 ctime 1488897648.827438547 (2017-03-07 16:40:48)
                 mtime 1488897648.827438547 (2017-03-07 16:40:48)
                 otime 1488897648.821438463 (2017-03-07 16:40:48)
         item 76 key (13307984 INODE_REF 11122229) itemoff 10110 itemsize 
45
                 index 287 namelen 35 name: file_35
         item 77 key (13307984 EXTENT_DATA 0) itemoff 10057 itemsize 53
                 generation 148503 type 1 (regular)
                 extent data disk byte 3762892800 nr 229376
                 extent data offset 0 nr 229376 ram 229376
                 extent compression 0 (none)
         item 78 key (13307984 EXTENT_DATA 229376) itemoff 10004 itemsize 
53
                 generation 148503 type 1 (regular)
                 extent data disk byte 3718172672 nr 40960
                 extent data offset 0 nr 40960 ram 40960
                 extent compression 0 (none)
         item 79 key (13307984 EXTENT_DATA 270336) itemoff 9951 itemsize 
53
                 generation 148503 type 1 (regular)
                 extent data disk byte 3713675264 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)
         item 80 key (13307984 EXTENT_DATA 274432) itemoff 9898 itemsize 
53
                 generation 148503 type 1 (regular)
                 extent data disk byte 3749720064 nr 221184
                 extent data offset 0 nr 221184 ram 221184
                 extent compression 0 (none)
         item 81 key (13307996 INODE_ITEM 0) itemoff 9738 itemsize 160
                 generation 148503 transid 1102480 size 258156 nbytes 
262144
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 974 flags 0x0(none)
                 atime 1550597374.3850758 (2019-02-19 19:29:34)
                 ctime 1488897654.521514738 (2017-03-07 16:40:54)
                 mtime 1488897654.521514738 (2017-03-07 16:40:54)
                 otime 1488897654.517514685 (2017-03-07 16:40:54)
         item 82 key (13307996 INODE_REF 11122229) itemoff 9693 itemsize 
45
                 index 289 namelen 35 name: file_35-1
         item 83 key (13307996 EXTENT_DATA 0) itemoff 9640 itemsize 53
                 generation 148503 type 1 (regular)
                 extent data disk byte 3413708800 nr 192512
                 extent data offset 0 nr 192512 ram 192512
                 extent compression 0 (none)
         item 84 key (13307996 EXTENT_DATA 192512) itemoff 9587 itemsize 
53
                 generation 148503 type 1 (regular)
                 extent data disk byte 3391303680 nr 69632
                 extent data offset 0 nr 69632 ram 69632
                 extent compression 0 (none)
         item 85 key (13308140 INODE_ITEM 0) itemoff 9427 itemsize 160
                 generation 148514 transid 1311589 size 18465 nbytes 
20480
                 block group 0 mode 100664 links 1 uid 1008 gid 100 rdev 
0
                 sequence 6 flags 0x0(none)
                 atime 1586773733.553360907 (2020-04-13 13:28:53)
                 ctime 1509809347.470411410 (2017-11-04 17:29:07)
                 mtime 1488898004.109194922 (2017-03-07 16:46:44)
                 otime 1488898004.54194207 (2017-03-07 16:46:44)
         item 86 key (13308140 INODE_REF 919572) itemoff 9389 itemsize 38
                 index 324 namelen 28 name: file_28
         item 87 key (13308140 EXTENT_DATA 0) itemoff 9336 itemsize 53
                 generation 148514 type 1 (regular)
                 extent data disk byte 2637307904 nr 20480
                 extent data offset 0 nr 20480 ram 20480
                 extent compression 0 (none)
         item 88 key (13308665 INODE_ITEM 0) itemoff 9176 itemsize 160
                 generation 148535 transid 1102480 size 503083 nbytes 
503808
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 20 flags 0x0(none)
                 atime 1550597353.479573444 (2019-02-19 19:29:13)
                 ctime 1488899523.16541683 (2017-03-07 17:12:03)
                 mtime 1488899523.16541683 (2017-03-07 17:12:03)
                 otime 1488898633.34617131 (2017-03-07 16:57:13)
         item 89 key (13308665 INODE_REF 904993) itemoff 9144 itemsize 32
                 index 2476 namelen 22 name: file_22
         item 90 key (13308665 EXTENT_DATA 0) itemoff 9091 itemsize 53
                 generation 148563 type 1 (regular)
                 extent data disk byte 36053782528 nr 503808
                 extent data offset 0 nr 503808 ram 503808
                 extent compression 0 (none)
         item 91 key (13309142 INODE_ITEM 0) itemoff 8931 itemsize 160
                 generation 148563 transid 1102480 size 258827 nbytes 
262144
                 block group 0 mode 100644 links 1 uid 941400003 gid 513 
rdev 0
                 sequence 25 flags 0x0(none)
                 atime 1550597353.493573639 (2019-02-19 19:29:13)
                 ctime 1488899528.464614493 (2017-03-07 17:12:08)
                 mtime 1488899528.464614493 (2017-03-07 17:12:08)
                 otime 1488899528.460614441 (2017-03-07 17:12:08)
         item 92 key (13309142 INODE_REF 904993) itemoff 8899 itemsize 32
                 index 2479 namelen 22 name: file_22-1
         item 93 key (13309142 EXTENT_DATA 0) itemoff 8846 itemsize 53
                 generation 148563 type 1 (regular)
                 extent data disk byte 11277266944 nr 262144
                 extent data offset 0 nr 262144 ram 262144
                 extent compression 0 (none)
         item 94 key (13309570 INODE_ITEM 0) itemoff 8686 itemsize 160
                 generation 148586 transid 1218524 size 88 nbytes 88
                 block group 0 mode 100644 links 1 uid 1008 gid 100 rdev 
0
                 sequence 161 flags 0x0(none)
                 atime 1569660109.297597210 (2019-09-28 11:41:49)
                 ctime 1509809344.497370791 (2017-11-04 17:29:04)
                 mtime 1488921844.229452654 (2017-03-07 23:24:04)
                 otime 1488901959.581903054 (2017-03-07 17:52:39)
         item 95 key (13309570 INODE_REF 933100) itemoff 8636 itemsize 
50a
                 index 533 namelen 40 name: file_40
         item 96 key (13309570 EXTENT_DATA 0) itemoff 8527 itemsize 109
                 generation 148681 type 0 (inline)
                 inline extent data size 88 ram_bytes 88 compression 0 
(none)

The dmesg log lists the following unique blocks:
2627479830528  slot=10  extent data offset 0 nr 18446744073709457408 ram 
18446744073709457408
2627928588288  slot=10  No extent data line - (seems to be a file with 
stat data)
28710276399104 slot=79  extent data offset 0 nr 18446744073709420544 ram 
18446744073709420544
28710639370240 slot=79  extent data offset 0 nr 18446744073709420544 ram 
18446744073709420544
30933479342080 slot=27  extent data offset 0 nr 18446744073709395968 ram 
18446744073709395968
3154170920960  slot=9   extent data offset 0 nr 18446744073709481984 ram 
18446744073709481984
3154170970112  slot=59  extent data offset 0 nr 18446744073709527040 ram 
18446744073709527040
3154171035648  slot=27  extent data offset 0 nr 18446744073709514752 ram 
18446744073709514752
3154217795584  slot=102 102 item does not exist
3154257952768  slot=59  59      -"-
3154259034112  slot=27  No extent data line
3154291228672  slot=9        -"-

The curious part are the two which list non-existing slots. These errors 
have been present in the dmesg-log ever since booting the server and 
while I mounted, as per instructions from the btrfs-Wiki, as readonly, 
so I don't think it is a case of changed files.

All the data on the partition is copied elsewhere, so there is no issue 
of losing files and recreating the FS on the partition is the most 
probable outcome of this. Thought nonetheless that investigating this 
may be something of interest to the btrfs-developers as I can keep the 
current FS around for couple of days.

Poltsi
