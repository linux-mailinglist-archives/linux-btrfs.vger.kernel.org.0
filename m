Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5198037F0A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 02:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhEMAsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 20:48:43 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:60132 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhEMArJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 20:47:09 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 6719E6C008A1;
        Thu, 13 May 2021 03:45:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1620866756; bh=F3iWBIqZ1qxP32AoJBl/dtV9TiOlAGHMzUKgv1Im6Qk=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=BkpU9rwyvo9rp8JEsimQ84H+uPCkmxqh0GX0O1Pe1htoH4qp46XG36bsbaUB8dKHG
         OAmfJK6M8x4SmbQ+SbDHaj9/q7k+Zzefk5voqDwaXKcGm/GBR2QQo5NnENgDkYw9GW
         wXT/YCxQnLOUdtK2N3RpWhaJE/P0g4EmgvpEHBzQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 590816C00896;
        Thu, 13 May 2021 03:45:56 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id J1XVhm1-ufa4; Thu, 13 May 2021 03:45:56 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 12A926C00835;
        Thu, 13 May 2021 03:45:56 +0300 (EEST)
Received: from nas (unknown [211.106.132.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id C71F01BE0083;
        Thu, 13 May 2021 03:45:54 +0300 (EEST)
References: <20210511042501.900731-1-l@damenly.su>
 <20210512140135.GR7604@twin.jikos.cz>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not BUG_ON if btrfs_add_to_fsid
 succeeded to write superblock
Date:   Thu, 13 May 2021 08:37:29 +0800
Message-ID: <k0o3lb1d.fsf@damenly.su>
In-reply-to: <20210512140135.GR7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7+hSeE2piELYI3bcBAcpripPQuzm+fm40B9F/g/3MCiEf0oFUxGzm3AFM3H44X8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 12 May 2021 at 22:01, David Sterba <dsterba@suse.cz> wrote:

> On Tue, May 11, 2021 at 12:25:01PM +0800, Su Yue wrote:
>> Commit 8ef9313cf298 ("btrfs-progs: zoned: implement 
>> log-structured
>> superblock") changed to write BTRFS_SUPER_INFO_SIZE bytes to 
>> device.
>> The before num of bytes to be written is sectorsize.
>> It causes mkfs.btrfs failed on my 16k pagesize kvm:
>
> What architecture is that?
>
The host chip is Apple m1 so it's arm64 but only supporting 16k 
and 4k
pagesize. Since btrfs subpage work cares 64k pagesize for now, I 
usually
run xfstests with 16k pagesize and 16k sectorsize. So far, so 
good.

--
Su

>>
>>   $ /usr/bin/mkfs.btrfs -s 16k -f -mraid0 /dev/vdb2 /dev/vdb3
>>   btrfs-progs v5.12
>>   See http://btrfs.wiki.kernel.org for more information.
>>
>>   ERROR: superblock magic doesn't match
>>   ERROR: superblock magic doesn't match
>>   common/device-scan.c:195: btrfs_add_to_fsid: BUG_ON `ret != 
>>   sectorsize`
>>   triggered, value 1
>>   /usr/bin/mkfs.btrfs(btrfs_add_to_fsid+0x274)[0xaaab4fe8a5fc]
>>   /usr/bin/mkfs.btrfs(main+0x1188)[0xaaab4fe4dc8c]
>>   /usr/lib/libc.so.6(__libc_start_main+0xe8)[0xffff7223c538]
>>   /usr/bin/mkfs.btrfs(+0xc558)[0xaaab4fe4c558]
>>
>>   [1]    225842 abort (core dumped)  /usr/bin/mkfs.btrfs -s 16k 
>>   -f -mraid0
>>   /dev/vdb2 /dev/vdb3
>>
>> btrfs_add_to_fsid() now always calls sbwrite() to write
>> BTRFS_SUPER_INFO_SIZE bytes to device, so change condition of
>> the BUG_ON().
>> Also add comments for sbread() and sbwrite().
>>
>> Signed-off-by: Su Yue <l@damenly.su>
>
> Added to devel, thanks.

