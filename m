Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29C61E95D7
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 May 2020 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgEaF7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 May 2020 01:59:01 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:57658 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgEaF7B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 May 2020 01:59:01 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id fGzpj76IptrlwfGzqjYznj; Sun, 31 May 2020 07:58:58 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590904738; bh=tDkMPEgUTTVeUhMvLAPuROBnpwamynyLgQgkQWpiZnU=;
        h=From;
        b=pivykRpenVhMZcSnsz1p7B+rwUWe/bMS72G1X/xBdzBo5nWTjVid9AUYldgxDBAuN
         CRbTi9ll70zaUNb9lHRh2Oj/NrSCgeNPq9JfdHQgc8GxxTd3TkVI9BIUYer5KYcgjq
         /STyrhE4lKi2XclUVhSDVgRxm39o9X3KMR9xfDx14UZqG+oxbt4qKHjstaSke9jTqW
         WrcvZ4J2yEElbTCBf/8bEcK1ogp/m6whjy4N2APBtZWk6VPzkp4Ewlr+SQPY3YhdYY
         raouJTHyREK71DRrFh9Zl6DBhqtjONulb9R7rz6F5CVUiP3pc+aIC8cxVAJulX/wF0
         a0fMqaCEubOCA==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=uXg4I6zrJaTsmWq3GB0A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: [BUG][PATCH] btrfs: a mixed profile DUP and RAID1C3/RAID1C4
 prevent to alloc a new chunk
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
References: <20200530185321.8373-1-kreijack@libero.it>
 <fc8f88a4-3812-a0dc-99ab-929b27d7530a@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <747b37b9-52a2-6b8e-f7bb-8ea5ca13f74e@libero.it>
Date:   Sun, 31 May 2020 07:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <fc8f88a4-3812-a0dc-99ab-929b27d7530a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHJlef4JTh7iiZqzRleOeMdHPBTd547qKWB1673N4Z+OAfpgK3BlptVVWEaxaxTXjq46ezPxMLt0Wjs4tqRWPy7vNUrmg9f24a+l00xCNeJJfXSNaiEj
 fkRflVH+Or/ZGFSwvvx/qmTl7QMu0r33ptMQB20v8l6nl2/K9u0ZU0P5gMOQmN2SlPlrbAK3V5qEEYXQx2nnlobFY/jzVJCfDCWAJAmyjyetXBfehexQc4XY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/31/20 2:51 AM, Qu Wenruo wrote:
> 
> 
> On 2020/5/31 上午2:53, Goffredo Baroncelli wrote:
>>
>> Hi All,
>>
>> after the thread "Question: how understand the raid profile of a btrfs
>> filesystem" [*] I was working to cleanup the function
>> btrfs_reduce_alloc_profile(), when I figured that it was incompatible with
>> a mixed profile of DUP and RAID1C3/RAID1C4.
>>
>> This is a very uncommon situation; to be honest it very unlikely that it will
>> happen at all.
>>
>> However if the filesystem has a mixed profiles of DUP and RAID1C3/RAID1C4 (of
>> the same type of chunk of course, i.e. if you have metadata RAID1C3 and data
>> DUP there is no problem because the type of chunks are different), the function
>> btrfs_reduce_alloc_profile() returns both the profiles and subsequent calls
>> to alloc_profile_is_valid() return invalid.
>>
>> The problem is how the function btrfs_reduce_alloc_profile "reduces" the
>> profiles.
>>
>> [...]
>> static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>> [...]
>>          allowed &= flags;
>>
>>          if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID6;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID5;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID10;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID1;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID0;
>>
>> 	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>
>> [...]
>>
>> "allowed" are all the possibles profiles allowed by the disks.
>> "flags" contains the existing profiles.
>>
>> If "flags" contains both DUP, RAID1C3 no reduction is performed and both
>> the profiles are returned.
>>
>> If full conversion from DUP to RAID1C3 is performed, there is no problem.
>> But a partial conversion from DUP to RAID1C3 is performed, then there is no
>> possibility to allocate a new chunk.
>>
>> On my tests the filesystem was never corrupted, but only force to RO.
>> However I was unable to exit from this state without my patch.
> 
> This in facts exposed the long existing bug that btrfs has no on-disk
> indicator for the target chunk time, thus we need to be "creative" to
> handle chunk profiles.

Fully agree; this patch is... a patch to correct a bug. Changing to having
a persistent field is a lot more complicated.

> 
> I'm wondering if we could add new persistent item in chunk tree or super
> block to solve the problem

I suggest to add a new object in the trees. I think that the superblock should
be reserved for info which allow to detect / identify the filesystem (i.e.
FDID - Disk UUID, Label basic data for the boot) and nothing more.

Moreover having an object stored in the tree, it would be possible to
think to and extendible structure (an object has a size)
to allow future expansion.

> 
> Any idea on this, David?
> 
> Thanks,
> Qu
> 
>>
>> [*] https://lore.kernel.org/linux-btrfs/517dac49-5f57-2754-2134-92d716e50064@alice.it/
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
