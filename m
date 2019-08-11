Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1298928C
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2019 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKQYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Aug 2019 12:24:17 -0400
Received: from know-smtprelay-omd-7.server.virginmedia.net ([81.104.62.39]:56726
        "EHLO know-smtprelay-omd-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfHKQYR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Aug 2019 12:24:17 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id wqdghJRTJwGUPwqdhhb8yl; Sun, 11 Aug 2019 17:24:13 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=Xl5wXq0ltJ_S91-WjtYA:9 a=QEXdDO2ut3YA:10
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
 <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <0bc24d6e-2f3f-c0b8-dc0b-59b162653d3a@petezilla.co.uk>
Date:   Sun, 11 Aug 2019 17:23:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKdkpf27BaDYCL053Z6iWQ9SfG5wyBEGKQKcdCA8uO41Gh0YZkpsHfMFYqDzGJgz8G/Bxodtqd+adlq4eRgn6hdGrbH7hnjHCf7PJoYpw6ALoHvsKyIU
 GvQA2hTJsk10QvmqC+tlNMBlAsy9vo5cHNLB/rHTtJYs0KfG8eBGx6MwN7TlFG0nCuo9RfZfDz0mLd4C8LB8hgoOh4YmhfFLgBw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/19 1:13 AM, Qu Wenruo wrote:

Qu, thank you.

>>
>> [   55.139154] BTRFS: device fsid 5128caf4-b518-4b65-ae46-b5505281e500
>> devid 1 transid 66785 /dev/sda4
>> [   55.139623] BTRFS info (device sda4): disk space caching is enabled
>> [   55.813959] BTRFS critical (device sda4): corrupt leaf: root=5
>> block=38884884480 slot=1 ino=45745394, invalid inode generation: has
>> 18446744073709551492 expect [0, 66786]
> 
> Please provide the following output:
> 
> # btrfs ins dump-tree -b 38884884480 /dev/sda4

OK, it is long.  Took a bit of a while as I thought it best to build an
uptodate version of brtfs-progs.

btrfs-progs v5.2.1
leaf 38884884480 items 24 free space 1441 generation 62836 owner FS_TREE
leaf 38884884480 flags 0x1(WRITTEN) backref revision 1
fs uuid 5128caf4-b518-4b65-ae46-b5505281e500
chunk uuid 8d513d0d-28d5-44d5-9bf7-f3e9f65e68c4
	item 0 key (45745393 DIR_INDEX 2) itemoff 3957 itemsize 38
		location key (45745394 INODE_ITEM 0) type FILE
		transid 3486964995150852608 data_len 0 name_len 8
		name: F6259d01
	item 1 key (45745394 INODE_ITEM 0) itemoff 3797 itemsize 160
		generation 1 transid 18446744073709551492 size 56218 nbytes 57344
		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
		sequence 0 flags 0x0(none)
		atime 1395590849.0 (2014-03-23 16:07:29)
		ctime 1395436187.0 (2014-03-21 21:09:47)
		mtime 1395436187.0 (2014-03-21 21:09:47)
		otime 0.0 (1970-01-01 01:00:00)
	item 2 key (45745394 INODE_REF 45745393) itemoff 3779 itemsize 18
		index 2 namelen 8 name: F6259d01
	item 3 key (45745394 EXTENT_DATA 0) itemoff 3726 itemsize 53
		generation 3 type 1 (regular)
		extent data disk byte 747660742656 nr 57344
		extent data offset 0 nr 57344 ram 57344
		extent compression 0 (none)
	item 4 key (45745395 INODE_ITEM 0) itemoff 3566 itemsize 160
		generation 1 transid 18446744073709551492 size 16 nbytes 0
		block group 0 mode 40700 links 1 uid 1002 gid 100 rdev 0
		sequence 0 flags 0x0(none)
		atime 1395590846.0 (2014-03-23 16:07:26)
		ctime 1395436187.0 (2014-03-21 21:09:47)
		mtime 1395436187.0 (2014-03-21 21:09:47)
		otime 0.0 (1970-01-01 01:00:00)
	item 5 key (45745395 INODE_REF 45615123) itemoff 3554 itemsize 12
		index 40 namelen 2 name: E5
	item 6 key (45745395 DIR_ITEM 3983833095) itemoff 3516 itemsize 38
		location key (45745396 INODE_ITEM 0) type FILE
		transid 53756160 data_len 0 name_len 8
		name: 7EA03d01
	item 7 key (45745395 DIR_INDEX 2) itemoff 3478 itemsize 38
		location key (45745396 INODE_ITEM 0) type FILE
		transid 53756160 data_len 0 name_len 8
		name: 7EA03d01
	item 8 key (45745396 INODE_ITEM 0) itemoff 3318 itemsize 160
		generation 1 transid 18446744073709551492 size 16538 nbytes 20480
		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
		sequence 0 flags 0x0(none)
		atime 1395590851.0 (2014-03-23 16:07:31)
		ctime 1395436188.0 (2014-03-21 21:09:48)
		mtime 1395436188.0 (2014-03-21 21:09:48)
		otime 0.0 (1970-01-01 01:00:00)
	item 9 key (45745396 INODE_REF 45745395) itemoff 3300 itemsize 18
		index 2 namelen 8 name: 7EA03d01
	item 10 key (45745396 EXTENT_DATA 0) itemoff 3247 itemsize 53
		generation 3 type 1 (regular)
		extent data disk byte 749606772736 nr 20480
		extent data offset 0 nr 20480 ram 20480
		extent compression 0 (none)
	item 11 key (45745397 INODE_ITEM 0) itemoff 3087 itemsize 160
		generation 1 transid 18446744073709551492 size 56776 nbytes 57344
		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
		sequence 0 flags 0x0(none)
		atime 1395590846.0 (2014-03-23 16:07:26)
		ctime 1395436188.0 (2014-03-21 21:09:48)
		mtime 1395436188.0 (2014-03-21 21:09:48)
		otime 0.0 (1970-01-01 01:00:00)
	item 12 key (45745397 INODE_REF 45744991) itemoff 3069 itemsize 18
		index 3 namelen 8 name: 20800d01
	item 13 key (45745397 EXTENT_DATA 0) itemoff 3016 itemsize 53
		generation 3 type 1 (regular)
		extent data disk byte 746701180928 nr 57344
		extent data offset 0 nr 57344 ram 57344
		extent compression 0 (none)
	item 14 key (45745398 INODE_ITEM 0) itemoff 2856 itemsize 160
		generation 1 transid 18446744073709551492 size 16 nbytes 0
		block group 0 mode 40700 links 1 uid 1002 gid 100 rdev 0
		sequence 0 flags 0x0(none)
		atime 1395590844.0 (2014-03-23 16:07:24)
		ctime 1395436188.0 (2014-03-21 21:09:48)
		mtime 1395436188.0 (2014-03-21 21:09:48)
		otime 0.0 (1970-01-01 01:00:00)
	item 15 key (45745398 INODE_REF 45615119) itemoff 2844 itemsize 12
		index 34 namelen 2 name: A4
	item 16 key (45745398 DIR_ITEM 3267253918) itemoff 2806 itemsize 38
		location key (45745399 INODE_ITEM 0) type FILE
		transid 0 data_len 0 name_len 8
		name: 21893d01
	item 17 key (45745398 DIR_INDEX 2) itemoff 2768 itemsize 38
		location key (45745399 INODE_ITEM 0) type FILE
		transid 0 data_len 0 name_len 8
		name: 21893d01
	item 18 key (45745399 INODE_ITEM 0) itemoff 2608 itemsize 160
		generation 1 transid 18446744073709551492 size 91218 nbytes 94208
		block group 0 mode 100600 links 1 uid 1002 gid 100 rdev 0
		sequence 0 flags 0x0(none)
		atime 1395590849.0 (2014-03-23 16:07:29)
		ctime 1395436189.0 (2014-03-21 21:09:49)
		mtime 1395436189.0 (2014-03-21 21:09:49)
		otime 0.0 (1970-01-01 01:00:00)
	item 19 key (45745399 INODE_REF 45745398) itemoff 2590 itemsize 18
		index 2 namelen 8 name: 21893d01
	item 20 key (45745399 EXTENT_DATA 0) itemoff 2537 itemsize 53
		generation 3 type 1 (regular)
		extent data disk byte 1797652480 nr 94208
		extent data offset 0 nr 94208 ram 94208
		extent compression 0 (none)
	item 21 key (45745400 INODE_ITEM 0) itemoff 2377 itemsize 160
		generation 20 transid 62836 size 297 nbytes 297
		block group 0 mode 100755 links 1 uid 0 gid 0 rdev 0
		sequence 11 flags 0x0(none)
		atime 1558793952.717852250 (2019-05-25 15:19:12)
		ctime 1395594875.621986903 (2014-03-23 17:14:35)
		mtime 1395594875.621986903 (2014-03-23 17:14:35)
		otime 0.0 (1970-01-01 01:00:00)
	item 22 key (45745400 INODE_REF 256) itemoff 2359 itemsize 18
		index 15 namelen 8 name: snapshot
	item 23 key (45745400 EXTENT_DATA 0) itemoff 2041 itemsize 318
		generation 85 type 0 (inline)
		inline extent data size 297 ram_bytes 297 compression 0 (none)


