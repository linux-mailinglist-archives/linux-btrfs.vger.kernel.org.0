Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF50B257264
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 05:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHaDre convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 30 Aug 2020 23:47:34 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46194 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHaDrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 23:47:33 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3046D7DC50C; Sun, 30 Aug 2020 23:47:31 -0400 (EDT)
Date:   Sun, 30 Aug 2020 23:47:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hamish Moffatt <hamish-btrfs@moffatt.email>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: new database files not compressed
Message-ID: <20200831034731.GX5890@hungrycats.org>
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 30, 2020 at 07:35:59PM +1000, Hamish Moffatt wrote:
> I am trying to store Firebird database files compressed on btrfs. Although I
> have mounted the file system with -o compress-force, new files created by
> Firebird are not being compressed according to compsize. If I copy them, or
> use btrfs filesystem defrag, they compress well.
> 
> Other files seem to be compressed automatically OK. Why are the Firebird
> files different?

If it is writing single 4K blocks with fsync() between writes, or writing
4K blocks to discontiguous file offsets, then the extents will be 4K
and there can be no compression.

Allocation is in 4K blocks (with default mkfs options on popular CPUs).
To save any space, compression must reduce the size of an extent by at
least 4K.  A 4K extent can't be compressed because even a single bit of
compressed output would round the extent size back up to 4K, resulting
in no size reduction on disk.

8K extents can be compressed if the compression ratio is 50% or higher,
12K extents can be compressed if the ratio is at least 33%, 16K extents
can be compressed if the ratio is at least 25%, and so on.  Larger writes
are better for compression.

Defrag and copies are able to compress because they write contiguously up
to the maximum compressed extent size of 128K; however, after defrag,
small random writes will not release the large contiguous extents
and total space usage reported by compsize can reach over 100% of the
original uncompressed file size.  With nodatacow (and no compression)
the disk usage of the database remains stable at 100% of the file size.

With defrag and compression the disk usage varies from the best compressed
size to (size_of_compressed_database + uncompressed_file_size) over time.
e.g. if you have a 50% compression ratio on a 1MB database then the disk
usage varies from 512K immediately after defrag to a maximum of 1502K
in the worst case (out of every 32 blocks, 31 are written in separate
transactions, which leaves references in the file to all of the compressed
extents, and adds 31 uncompressed 4K extents for each compressed extent).
This means that if you want to keep a database compressed with a 4K
database page size, you have to run defrag frequently.

Another way to get compression is to increase the database page size.
Sizes up to 128K are useful--128K is the maximum btrfs compressed extent
size, and increasing the database page size higher will have no further
compression benefit.  Most databases I've encountered max out at 64K
pages, but even 64K gives some compression.

> $ uname -a
> Linux packer-debian-10-amd64 5.7.0-3-amd64 #1 SMP Debian 5.7.17-1
> (2020-08-23) x86_64 GNU/Linux
> 
> $ sudo mkfs.btrfs -m single -f /dev/sdb
> btrfs-progs v4.20.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               949f7f3f-681b-40fb-97b9-522756d5d619
> Node size:          16384
> Sector size:        4096
> Filesystem size:    29.98GiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         single            8.00MiB
>   System:           single            4.00MiB
> SSD detected:       no
> Incompat features:  extref, skinny-metadata
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    29.98GiB  /dev/sdb
> 
> $ sudo mount -o compress-force /dev/sdb /mnt/test
> $ sudo mkdir /mnt/test/db
> $ cd /mnt/test/db
> 
> Now I restore a backup to create a database:
> 
> $ zcat ~/*.zip | gbak -REP stdin test.fdb
> $ sudo compsize test.fdb
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      182M         182M         175M
> none       100%      182M         182M         175M
> $ cat test.fdb > test2.fdb
> $ sudo compsize test2.fdb
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       10%       18M         175M         175M
> zlib        10%       18M         175M         175M
> 
> 
> The same thing occurs if I create a brand new database:
> 
> $ isql-fb
> Use CONNECT or CREATE DATABASE to specify a database
> SQL> create database 'test3.fdb';
> SQL> ^D$
> $ sync
> $ sudo compsize test3.fdb
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      784K         784K         784K
> none       100%      784K         784K         784K
> $ cp test3.fdb test4.fdb
> $ sync
> $ sudo compsize test4.fdb
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL        7%       60K         784K         784K
> zlib         7%       60K         784K         784K
> 
> 
> If I create a database with SQLite it is compressed:
> 
> 
> $ cat test.sql
> create table test ( id integer primary key asc autoincrement, timestamp text
> default (datetime()), data text);
> $ sqlite3 foo.db < test.sql
> $ sudo compsize foo.db
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       33%      4.0K          12K          12K
> zlib        33%      4.0K          12K          12K
> 
> 
> I ran isql-fb in strace to see if there is something special in the open(2)
> flags;
> 
> 
> $ strace -o trace isql-fb
> Use CONNECT or CREATE DATABASE to specify a database
> SQL> create database 'new.fdb';
> SQL> ^D$
> $ grep new.fdb trace
> readlink("/mnt/test/db/new.fdb", 0x7ffd9cf70810, 4096) = -1 ENOENT (No such
> file or directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf705b0) = -1 ENOENT (No such file or
> directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf71480) = -1 ENOENT (No such file or
> directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf70e40) = -1 ENOENT (No such file or
> directory)
> openat(AT_FDCWD, "/mnt/test/db/new.fdb", O_RDWR) = -1 ENOENT (No such file
> or directory)
> openat(AT_FDCWD, "/mnt/test/db/new.fdb", O_RDONLY) = -1 ENOENT (No such file
> or directory)
> readlink("/mnt/test/db/new.fdb", 0x7ffd9cf70800, 4096) = -1 ENOENT (No such
> file or directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf705a0) = -1 ENOENT (No such file or
> directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf71470) = -1 ENOENT (No such file or
> directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf70dc0) = -1 ENOENT (No such file or
> directory)
> stat("/mnt/test/db/new.fdb", 0x7ffd9cf70eb0) = -1 ENOENT (No such file or
> directory)
> openat(AT_FDCWD, "/mnt/test/db/new.fdb", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
> readlink("/mnt/test/db/new.fdb", 0x7ffd9cf6ff00, 4096) = -1 EINVAL (Invalid
> argument)
> 
> 
> 
> 
> thanks
> 
> Hamish
> 
