Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3C257670
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHaJZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 05:25:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgHaJZf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 05:25:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D20B7AEF5;
        Mon, 31 Aug 2020 09:26:06 +0000 (UTC)
Subject: Re: new database files not compressed
To:     Hamish Moffatt <hamish-btrfs@moffatt.email>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1ba6d793-30c5-39fc-3b6f-46fee70e5dd8@suse.com>
Date:   Mon, 31 Aug 2020 12:25:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.08.20 г. 11:53 ч., Hamish Moffatt wrote:
> On 31/8/20 1:47 pm, Zygo Blaxell wrote:
>> On Sun, Aug 30, 2020 at 07:35:59PM +1000, Hamish Moffatt wrote:
>>> I am trying to store Firebird database files compressed on btrfs.
>>> Although I
>>> have mounted the file system with -o compress-force, new files
>>> created by
>>> Firebird are not being compressed according to compsize. If I copy
>>> them, or
>>> use btrfs filesystem defrag, they compress well.
>>>
>>> Other files seem to be compressed automatically OK. Why are the Firebird
>>> files different?
>> If it is writing single 4K blocks with fsync() between writes, or writing
>> 4K blocks to discontiguous file offsets, then the extents will be 4K
>> and there can be no compression.
>>
>> Allocation is in 4K blocks (with default mkfs options on popular CPUs).
>> To save any space, compression must reduce the size of an extent by at
>> least 4K.  A 4K extent can't be compressed because even a single bit of
>> compressed output would round the extent size back up to 4K, resulting
>> in no size reduction on disk.
>>
>> 8K extents can be compressed if the compression ratio is 50% or higher,
>> 12K extents can be compressed if the ratio is at least 33%, 16K extents
>> can be compressed if the ratio is at least 25%, and so on.  Larger writes
>> are better for compression.
>>
>> Defrag and copies are able to compress because they write contiguously up
>> to the maximum compressed extent size of 128K; however, after defrag,
>> small random writes will not release the large contiguous extents
>> and total space usage reported by compsize can reach over 100% of the
>> original uncompressed file size.  With nodatacow (and no compression)
>> the disk usage of the database remains stable at 100% of the file size.
>>
>> With defrag and compression the disk usage varies from the best
>> compressed
>> size to (size_of_compressed_database + uncompressed_file_size) over time.
>> e.g. if you have a 50% compression ratio on a 1MB database then the disk
>> usage varies from 512K immediately after defrag to a maximum of 1502K
>> in the worst case (out of every 32 blocks, 31 are written in separate
>> transactions, which leaves references in the file to all of the
>> compressed
>> extents, and adds 31 uncompressed 4K extents for each compressed extent).
>> This means that if you want to keep a database compressed with a 4K
>> database page size, you have to run defrag frequently.
>>
>> Another way to get compression is to increase the database page size.
>> Sizes up to 128K are useful--128K is the maximum btrfs compressed extent
>> size, and increasing the database page size higher will have no further
>> compression benefit.  Most databases I've encountered max out at 64K
>> pages, but even 64K gives some compression.
> 
> Understood. Thanks for this explanation.
> 
> Perhaps I'm missing something more fundamental, because I don't seem to
> get compression even if I create a file full of zeroes with dd;
> 
> $ sudo mount -O compress-force=zstd /dev/sdb /mnt/test
> $ cd /mnt/test/db
> $ dd if=/dev/zero of=zero bs=16k count=1024
> 1024+0 records in
> 1024+0 records out
> 16777216 bytes (17 MB, 16 MiB) copied, 0.0154404 s, 1.1 GB/s
> $ sudo compsize zero
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       16M          16M          16M
> none       100%       16M          16M          16M
> $ sudo btrfs fi defrag -czstd zero
> $ sudo compsize zero
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL        3%      512K          16M          16M
> zstd         3%      512K          16M          16M
> 
> I did trying my Firebird tests with a 16k database page size and didn't
> see any compression there either.


Doing the following test :

root@ubuntu18:~# mount -O compress-force=zstd /dev/vdc /media/scratch/
root@ubuntu18:~# rm -rf /media/scratch/zero
root@ubuntu18:~# dd if=/dev/zero of=/media/scratch/zero bs=16k count=1024
sync
btrfs inspect-internal dump-tree -t5 /dev/vdc

results in:


item 6 key (259 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 12 type 1 (regular)
		extent data disk byte 315621376 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 3 (zstd)
	item 7 key (259 EXTENT_DATA 131072) itemoff 15763 itemsize 53
		generation 12 type 1 (regular)
		extent data disk byte 315625472 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 3 (zstd)
	item 8 key (259 EXTENT_DATA 262144) itemoff 15710 itemsize 53
		generation 12 type 1 (regular)
		extent data disk byte 315629568 nr 4096
		extent data offset 0 nr 131072 ram 131072
		extent compression 3 (zstd)



I.e a bunch of 128k extents, which in fact take only 4k on disk each.

Whereas if I write the same file but without the compress-force mount
option I get:

item 138 key (260 EXTENT_DATA 0) itemoff 8787 itemsize 53
		generation 14 type 1 (regular)
		extent data disk byte 298844160 nr 16777216
		extent data offset 0 nr 16777216 ram 16777216
		extent compression 0 (none)


I.e a single extent, 16m in size. So instead of using this compsize
utility or whatever it is can you dump the state of the filesystem as
per the btrfs inspect-internal command shown above?
> 
> 
> Hamish
> 
