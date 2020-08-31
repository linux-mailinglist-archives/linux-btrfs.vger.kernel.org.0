Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629C82575DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgHaIyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgHaIyB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 04:54:01 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631EC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lZWleLCpQDWMdacQ5+LAeMjUdtxtY/ONTDKHD6fjppw=; b=Z69YGFqiyfLOL6uVnEaxIgiYwX
        zftgQk896q+ZTNAqcoAYADRYlVYNwV9r1vDx3By4/5oLuWGM/k83wQX1EMzffWLtbNzhGotrphzc3
        ckhxDA/n7CXsdQSpM4ffZkor+TFbONcoc7gL/ryW/KjcuFMWRbDKbK3CdtNm2WCckciw=;
Received: from 2403-5800-3100-142-30c0-d0ff-28cd-e22a.ip6.aussiebb.net ([2403:5800:3100:142:30c0:d0ff:28cd:e22a])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kCfZb-0006Ul-J0; Mon, 31 Aug 2020 18:53:55 +1000
Subject: Re: new database files not compressed
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
Date:   Mon, 31 Aug 2020 18:53:54 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831034731.GX5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 1:47 pm, Zygo Blaxell wrote:
> On Sun, Aug 30, 2020 at 07:35:59PM +1000, Hamish Moffatt wrote:
>> I am trying to store Firebird database files compressed on btrfs. Although I
>> have mounted the file system with -o compress-force, new files created by
>> Firebird are not being compressed according to compsize. If I copy them, or
>> use btrfs filesystem defrag, they compress well.
>>
>> Other files seem to be compressed automatically OK. Why are the Firebird
>> files different?
> If it is writing single 4K blocks with fsync() between writes, or writing
> 4K blocks to discontiguous file offsets, then the extents will be 4K
> and there can be no compression.
>
> Allocation is in 4K blocks (with default mkfs options on popular CPUs).
> To save any space, compression must reduce the size of an extent by at
> least 4K.  A 4K extent can't be compressed because even a single bit of
> compressed output would round the extent size back up to 4K, resulting
> in no size reduction on disk.
>
> 8K extents can be compressed if the compression ratio is 50% or higher,
> 12K extents can be compressed if the ratio is at least 33%, 16K extents
> can be compressed if the ratio is at least 25%, and so on.  Larger writes
> are better for compression.
>
> Defrag and copies are able to compress because they write contiguously up
> to the maximum compressed extent size of 128K; however, after defrag,
> small random writes will not release the large contiguous extents
> and total space usage reported by compsize can reach over 100% of the
> original uncompressed file size.  With nodatacow (and no compression)
> the disk usage of the database remains stable at 100% of the file size.
>
> With defrag and compression the disk usage varies from the best compressed
> size to (size_of_compressed_database + uncompressed_file_size) over time.
> e.g. if you have a 50% compression ratio on a 1MB database then the disk
> usage varies from 512K immediately after defrag to a maximum of 1502K
> in the worst case (out of every 32 blocks, 31 are written in separate
> transactions, which leaves references in the file to all of the compressed
> extents, and adds 31 uncompressed 4K extents for each compressed extent).
> This means that if you want to keep a database compressed with a 4K
> database page size, you have to run defrag frequently.
>
> Another way to get compression is to increase the database page size.
> Sizes up to 128K are useful--128K is the maximum btrfs compressed extent
> size, and increasing the database page size higher will have no further
> compression benefit.  Most databases I've encountered max out at 64K
> pages, but even 64K gives some compression.

Understood. Thanks for this explanation.

Perhaps I'm missing something more fundamental, because I don't seem to 
get compression even if I create a file full of zeroes with dd;

$ sudo mount -O compress-force=zstd /dev/sdb /mnt/test
$ cd /mnt/test/db
$ dd if=/dev/zero of=zero bs=16k count=1024
1024+0 records in
1024+0 records out
16777216 bytes (17 MB, 16 MiB) copied, 0.0154404 s, 1.1 GB/s
$ sudo compsize zero
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       16M          16M          16M
none       100%       16M          16M          16M
$ sudo btrfs fi defrag -czstd zero
$ sudo compsize zero
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        3%      512K          16M          16M
zstd         3%      512K          16M          16M

I did trying my Firebird tests with a 16k database page size and didn't 
see any compression there either.


Hamish

