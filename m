Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF95718DF4A
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 10:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgCUJzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Mar 2020 05:55:36 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:35641 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgCUJzg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 05:55:36 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id Faqqjl9fQa1lLFaqqjvSh4; Sat, 21 Mar 2020 10:55:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1584784533; bh=NZrEUZeSaRjrrJ1IlBe9tVdeW6TPlHs6mZ96HHIf8Vo=;
        h=From;
        b=DSoD1rlNPpExvrxgTjoQOKpWXUinZMIlHSz7f5fN1uGc2rYTtwH96wM2OlnlmBGUk
         Qag5GRVdJQiZrYHsvngzy9N8aZpjkfEPNvjcBFC4W8rXFKwnA5arHdh0aPgS0uR99w
         zCoikCmX8GIvnyzu185OikOaaMqXBEiHnk7E++NwxTAh5dBH6/pIReAIRcjdWjGw9x
         yRembPHrz3/yfvQXSNEZP3YiMNgUYWyQeHmUDoVN6FQ7NPcAOLOxmwah6U1qabsx8M
         CPRZczxP9tPSwpYuav6SuOAM0Z2qX76FdBibc5bckts+F6kVzdlMtYg4M+Kk7nDOlm
         0rfXbp1Fx/CHg==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=OqPfFxAmV_08_sfKIXoA:9
 a=X9oSXzNQ2vYdOcsX:21 a=N1M2hUwrH-yEwSTB:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
Date:   Sat, 21 Mar 2020 10:55:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200321032911.GR13306@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOvdwxVKybRaIXREALtZd/eSCZOZZru9rV7bCLTDBUNmpLyt19URSfV2zkGHM0ywUT94HoMSGeHmVPixPdAG8FAWxN4QfCCXJwRNCQbxU2zFrk7fQZ0V
 U/KtL/A3wF0QTwr5eV3rzO83XIbJVAsjGbeXIP7q3qeU7lrpJmhh/2vAgMpzl44ysLs+rmpLvG95oviju6BtKoaF88rzmsMIMyJUfWsaXFxIZ9P0q2fwdje7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/21/20 4:29 AM, Zygo Blaxell wrote:
> On Fri, Mar 20, 2020 at 06:56:38PM +0100, Goffredo Baroncelli wrote:
>> Hi all,
>>
>> for a btrfs filesystem, how an user can understand which is the {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk which profile will have ?
> 
> It's the profile used by the highest-numbered block group for the
> allocation type (one for data, one for metadata/system).  There
> are two profiles to consider, one for data and one for metadata.
> 'btrfs fi df', 'btrfs fi us', or 'btrfs dev usage' will all indicate
> which profiles these are.
> 

What do you think as "highest-numbered block group", the value in the "offset" filed.
If so it doesn't make sense because it could be relocated easily.

Anyway what are you describing is not what I saw. In the test above I create a raid5 filesystem, filled 1 chunk at 100% and a second chunk for few MB. Then I convert the most empty chunk as single. Then I fill the last chunk (the single one) and force to create a new chunk. What I saw is that the new chunk is raid5 mode.

$ sudo mkfs.btrfs -draid5  /dev/loop[012]
$ dd if=/dev/zero of=t/file-2.128gb_5 bs=1M count=$((2024+128)) # fill two chunk raid 5
$ sudo btrfs fi du t/. # see what is the situation
[...]
Data,RAID5: Size:4.00GiB, Used:2.10GiB (52.57%)
    /dev/loop0	   2.00GiB
    /dev/loop1	   2.00GiB
    /dev/loop2	   2.00GiB
[...]
$ sudo btrfs balance start -dconvert=single,usage=50 t/. # convert the latest chunk to single
$ sudo btrfs fi us t/.	# see what is the situation
[...]
Data,single: Size:1.00GiB, Used:259.00MiB (25.29%)
    /dev/loop0	   1.00GiB

Data,RAID5: Size:2.00GiB, Used:1.85GiB (92.47%)
    /dev/loop0	   1.00GiB
    /dev/loop1	   1.00GiB
    /dev/loop2	   1.00GiB
[...]

# fill the latest chunk and created a new one
$ dd if=/dev/zero of=t/file-1.128gb_6 bs=1M count=$((1024+128))

$ sudo btrfs fi us t/. # see what is the situation
[...]
Data,single: Size:1.00GiB, Used:259.00MiB (25.29%)
    /dev/loop0	   1.00GiB

Data,RAID5: Size:4.00GiB, Used:1.85GiB (46.24%)
    /dev/loop0	   2.00GiB
    /dev/loop1	   2.00GiB
    /dev/loop2	   2.00GiB
[...]

Expected results: the "single" chunk should pass from 1GB to 2GB. What it is observed is that the raid5 (the oldest chunk) passed from 2GB to 4GB.

[...]
>> Looking at the code it seems to me that the logic is the following (from btrfs_reduce_alloc_profile())
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
>>          flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>
>> So in the case above the profile will be RAID6. And in the general if a RAID6 chunk is a filesystem, it wins !
> 
> This code is used to determine whether a conversion reduces the level of
> redundancy, e.g. you are going from raid6 (2 redundant disks) to raid5
> (1 redundant disk) or raid0 (0 redundant disks).  There are warnings and
> a force flag required when that happens.  It doesn't determine the raid
> profile of the next block group--that's just a straight copy of the raid
> profile of the last block group.

To me it seems that this function decides the allocation of the next chunk. The chain of call is the following:

btrfs_force_chunk_alloc
	btrfs_get_alloc_profile
		get_alloc_profile
			btrfs_reduce_alloc_profile
	btrfs_chunk_alloc
		btrfs_alloc_chunk
			__btrfs_alloc_chunk

or another one is

btrfs_alloc_data_chunk_ondemand
	btrfs_data_alloc_profile
		btrfs_get_alloc_profile
			get_alloc_profile
				btrfs_reduce_alloc_profile
	btrfs_chunk_alloc
		btrfs_alloc_chunk
			__btrfs_alloc_chunk


The btrfs_get_alloc_profile/get_alloc_profile/btrfs_reduce_alloc_profile chain decides which profile has to be allocated.
The current actives profiles are took and then filtered by the possible allowed on the basis of the number of disk. Which means that if a raid6 profile chunk exists (and there is a enough number of devices), the next chunk will be allocated as raid6.

So is how I read the code, and what suggest my tests...

My conclusion is: if you have multiple raid profile per disk, the next chunk allocation doesn't depend by the latest "balance", but but by the above logic.
The recipe is: when you made a balance, pay attention to not leave any chunk in old format

> 
>> But I am not sure.. Moreover I expected to see also reference to DUP and/or RAID1C[34] ...
> 
> If you get through that 'if' statement without hitting any of the
> branches, then you're equal to raid0 (0 redundant disks) but raid0
> is a special case because it requires 2 disks for allocation.  'dup'
> (0 redundant disks) and 'single' (which is the absence of any profile
> bits) also have 0 redundant disks and require only 1 disk for allocation,
> there is no need to treat them differently.
> 
> raid1c[34] probably should be there.  Patches welcome.
> 
>> Does someone have any suggestion ?
>>
>> BR
>> G.Baroncelli
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
