Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99433F18AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 13:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbhHSL7b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 07:59:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:36857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239115AbhHSL73 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 07:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629374330;
        bh=3Kt8tx3B1EI2M60hu45yPbqMnfGYtU/lant6rRQEtHw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UklmF3yga13Q4HiM1p3dax46KNHI2W17EOaZvJRn8nhCfvl2EVT1pN6C8d/w9O8pN
         kFBsJVan5+rRmI0ePU6fDZPXZqxnaTuhMjqS9awrW6HHLTyqEewdYxA24y6+2G975g
         Mxg4R81NvKCky8x8+uUIr0IQf9hocVImSsfKnNYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1fn0-1nECBu0eLo-0120Ck; Thu, 19
 Aug 2021 13:58:50 +0200
Subject: Re: [RFC PATCH] btrfs: prevent falloc to mix inline and regular
 extents
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210811054505.186828-1-wqu@suse.com>
 <20210819111709.GC5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0334e430-6634-5360-4ac2-004c12d40f93@gmx.com>
Date:   Thu, 19 Aug 2021 19:58:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819111709.GC5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7tXKg378tC3TFmRn2pUgVZtBxTtXpYluKrbEtXvZuctq9d0Psy
 loIBr768hI4HPRx2OdbWQ0WB/wlgyEFz++4/WfpRj/S7kuOaMG5IDhcJhArFqjMBaqGu4id
 zOlF9O+icLTRCxAcqtjjZBYFFpRwvR/Tk7jRBjUVVATWDb73ZF1egw1y1Ycc1W+KlV3Z+4U
 SC+RRLSbwksbbHIQgzfng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSSkx7dwx6k=:2EJovPIcg0ClWu7Mmu5ItQ
 myU2+c4ahnx1zu/khVx4maZOHlMY9XzGyuzMiybATKc71zB1zUY9y2CPk3ge6S/G34StUjL6g
 B3h3dGuGGhX5lwL7hAbSt0mcRzTqivDlBWmPCsq9fFFHpCQrzf/yoPdj6NiFqdb4BG2GjPU/+
 KOmCtC9xSs8XT9Gg284NTlUvgueh9pyJABxGsL3csWPUbCfEw/980nEitl2xWZhGXeW7GdAHe
 iUJ4yQRy8V8tTGx76K5UGxKuNBBQLdxp/1b1a1FNUs1tIYFqU9ufeSdPvwwkmKbdBRJDy3CU6
 qrH9UlGHNM0U3kSj7G2wi8amfoulWiLkZKrZmY6zKjh79BnHyYcL4eMdvSOEVoHF3TSWNwlnR
 4sixBJoauFg6eWHjup6JcpdQ7vmzg0DBuzC3tcFO7yD24U+RRJ9KtNYU9PzGZwMEepYYG+4O1
 wm4/6WBRkBB+Wrr7CptH5RgZ8iE77yWhfdfNTYHxzj4ZXpfv0Q0iQYrA9hXCHPunPmPw/8Fe1
 5i3klT1Iix0xBmhmzrbngVFf1KueRGMCC9jRj54Ob3F1rmjX5P12FGN4cc0A+xGDDzdRpvqO5
 5l5N/mQlG2i6XgNhdf6+TuQEfXlYw4khb94NI4A2zOWIEFITWFjXnqWDoBAXNMH8ddzWT1/f5
 KjiIudEmfhUOMZx35l+XdIM4v2k1po8PovMTcGKaixSW1OmCxearOLsOtpSXsp/rtfA4MqVQC
 lwqR7g0IwkribwL7qiWWRnwurEzQOPMFO7f+D6t82Niklhdw2oZVOzQ2jtuRkYduTgQO/gSZd
 MEFv3W+FG/8bkr8wFBYEeYp4AJWggGKaBQYbdHSWEGFPehx1GvcPoy6xwc3o4p0oOjxK1tAz8
 M5TsnYxHZZtpNY/V0ibJpWr15A01O5LAWIIXnvAAJZBYPlMausnHx6W7mtwE0VrR8bzDlQc7I
 rsbXIECC4o6hFgwbSKVTwhk0Cw7Jzjnt9fPuDCEvGq6s7RImpqF0499yjFlX40fzJOCfIZE2T
 jirhxNokjk5m4ByuHFV5U8yqWTwyqtaZjCu1b4tLOVzq1dIJJ1+st+tzyl843bnjq9GQJ0NmS
 42vaahimRjqOLpjABJx8N3lcreZPRDsH7jRbVtgcEdZ2RVAsjwccyrKjg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8B=E5=8D=887:17, David Sterba wrote:
> On Wed, Aug 11, 2021 at 01:45:05PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> The following script can create a fs with mixed inline and regular
>> extents:
>>
>>   mkfs.btrfs -f -s 4k $dev
>>   mount $dev $mnt -o nospace_cache
>>
>>   xfs_io -f -c "pwrite 0 1k" -c "sync" \
>> 	-c "falloc 0 4k" -c "pwrite 4k 4k" $mnt/file
>>   umount $mnt
>>
>> It will result the following file extents layout:
>>
>>          item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
>>                  index 2 namelen 4 name: file
>>          item 6 key (257 EXTENT_DATA 0) itemoff 14824 itemsize 1045
>>                  generation 8 type 0 (inline)
>>                  inline extent data size 1024 ram_bytes 1024 compressio=
n 0 (none)
>>          item 7 key (257 EXTENT_DATA 4096) itemoff 14771 itemsize 53
>>                  generation 8 type 1 (regular)
>>                  extent data disk byte 13631488 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>                  extent compression 0 (none)
>>
>> Which mixes inline and regular extents.
>>
>> Without above falloc operation, we would get proper regular extent only
>> layout.
>>
>> [CAUSE]
>> Normally we rely on btrfs_truncate_block() to convert the inline extent
>> to regular extent.
>>
>> For example, if without falloc(), at the 2nd pwrite, we will call
>> btrfs_truncate_block() to zero the tailing part of the inline extent,
>> then at writeback time, we find the isize is larger than inline
>> threshold and will not create inline extent, but write back the first
>> sector as regular extent.
>>
>> While in falloc, although we also call btrfs_truncate_block(), it's
>> called before we enlarge the inode size.
>>
>> And we start writeback of the range immediately, with inode size
>> unchanged.
>>
>> This means, we just re-create an inline extent inside btrfs_fallocate()=
.
>>
>> [FIX]
>> Only call btrfs_truncate_block() after we have updated inode size insid=
e
>> btrfs_fallocate().
>>
>> By this later writeback will properly writeback the first sector as
>> regular extent.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> There is a long existing discussion on whether we should allow mixing
>> inline and regular extents.
>>
>> I totally understand the idea that mixing such extents won't cause
>> anything wrong, the existing kernel can handle them pretty well, and no
>> data corruption or whatever.
>>
>> But since it's really not that simple to create such mixed extents
>> (except the method mentioned above), I really don't believe that's the
>> expected behavior.
>>
>> Thus even it's not a big deal, I still want to prevent such mixed
>> extents.
>
> I agree, it's rather obscure and I don't think it was intentional. That
> it works is fine and we'll have to keep it like that but not creating
> the mixed extents should be the default.
>

BTW, the (at least current) root cause is the delayed isize update in
falloc.

Unlike regular write/truncate, for falloc we don't fill the falloc range
with holes, nor enlarge isize.

Thus it's super easy to cause the mentioned problem, in falloc.

But if we enlarge the inode first, then all later falloc will need to
drop the hole extent first, then insert the preallocated extent.

I'm not sure how the new way will slow down falloc, but if a little
slower falloc is the cost to prevent mixed extents, I'm going to take
the cost.

Thanks,
Qu
