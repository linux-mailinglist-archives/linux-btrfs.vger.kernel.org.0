Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38324256D37
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 12:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgH3KCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgH3KCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 06:02:16 -0400
X-Greylist: delayed 1565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Aug 2020 03:02:06 PDT
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12287C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Aug 2020 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aCUrYaBBh01b44jpiIlcsV7qyfxyDwSvP1wssHsoh/E=; b=YsiY0eRcUefwXgjxw0Q226EUog
        xZzhSyQEX6R2t85KLw471ZT5IeNQC7vxAMg47vDS91xPkH/rlWi78c3LdS6/ai23JPDlESd+NFjKd
        64ZY+4LzbfEvfeOLz1VgN3Az4w9/3f+JOsbbK9biXN+vQ7Lg7crK4JjKfWaLnt47XYwo=;
Received: from 2403-5800-3100-142-69a8-ba22-a240-3140.ip6.aussiebb.net ([2403:5800:3100:142:69a8:ba22:a240:3140])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kCJkm-0005J6-2f
        for linux-btrfs@vger.kernel.org; Sun, 30 Aug 2020 19:36:00 +1000
To:     linux-btrfs@vger.kernel.org
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Subject: new database files not compressed
Message-ID: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
Date:   Sun, 30 Aug 2020 19:35:59 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am trying to store Firebird database files compressed on btrfs. 
Although I have mounted the file system with -o compress-force, new 
files created by Firebird are not being compressed according to 
compsize. If I copy them, or use btrfs filesystem defrag, they compress 
well.

Other files seem to be compressed automatically OK. Why are the Firebird 
files different?


$ uname -a
Linux packer-debian-10-amd64 5.7.0-3-amd64 #1 SMP Debian 5.7.17-1 
(2020-08-23) x86_64 GNU/Linux

$ sudo mkfs.btrfs -m single -f /dev/sdb
btrfs-progs v4.20.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               949f7f3f-681b-40fb-97b9-522756d5d619
Node size:          16384
Sector size:        4096
Filesystem size:    29.98GiB
Block group profiles:
   Data:             single            8.00MiB
   Metadata:         single            8.00MiB
   System:           single            4.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
    ID        SIZE  PATH
     1    29.98GiB  /dev/sdb

$ sudo mount -o compress-force /dev/sdb /mnt/test
$ sudo mkdir /mnt/test/db
$ cd /mnt/test/db

Now I restore a backup to create a database:

$ zcat ~/*.zip | gbak -REP stdin test.fdb
$ sudo compsize test.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      182M         182M         175M
none       100%      182M         182M         175M
$ cat test.fdb > test2.fdb
$ sudo compsize test2.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       10%       18M         175M         175M
zlib        10%       18M         175M         175M


The same thing occurs if I create a brand new database:

$ isql-fb
Use CONNECT or CREATE DATABASE to specify a database
SQL> create database 'test3.fdb';
SQL> ^D$
$ sync
$ sudo compsize test3.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      784K         784K         784K
none       100%      784K         784K         784K
$ cp test3.fdb test4.fdb
$ sync
$ sudo compsize test4.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        7%       60K         784K         784K
zlib         7%       60K         784K         784K


If I create a database with SQLite it is compressed:


$ cat test.sql
create table test ( id integer primary key asc autoincrement, timestamp 
text default (datetime()), data text);
$ sqlite3 foo.db < test.sql
$ sudo compsize foo.db
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       33%      4.0K          12K          12K
zlib        33%      4.0K          12K          12K


I ran isql-fb in strace to see if there is something special in the 
open(2) flags;


$ strace -o trace isql-fb
Use CONNECT or CREATE DATABASE to specify a database
SQL> create database 'new.fdb';
SQL> ^D$
$ grep new.fdb trace
readlink("/mnt/test/db/new.fdb", 0x7ffd9cf70810, 4096) = -1 ENOENT (No 
such file or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf705b0) = -1 ENOENT (No such file 
or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf71480) = -1 ENOENT (No such file 
or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf70e40) = -1 ENOENT (No such file 
or directory)
openat(AT_FDCWD, "/mnt/test/db/new.fdb", O_RDWR) = -1 ENOENT (No such 
file or directory)
openat(AT_FDCWD, "/mnt/test/db/new.fdb", O_RDONLY) = -1 ENOENT (No such 
file or directory)
readlink("/mnt/test/db/new.fdb", 0x7ffd9cf70800, 4096) = -1 ENOENT (No 
such file or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf705a0) = -1 ENOENT (No such file 
or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf71470) = -1 ENOENT (No such file 
or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf70dc0) = -1 ENOENT (No such file 
or directory)
stat("/mnt/test/db/new.fdb", 0x7ffd9cf70eb0) = -1 ENOENT (No such file 
or directory)
openat(AT_FDCWD, "/mnt/test/db/new.fdb", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
readlink("/mnt/test/db/new.fdb", 0x7ffd9cf6ff00, 4096) = -1 EINVAL 
(Invalid argument)




thanks

Hamish

