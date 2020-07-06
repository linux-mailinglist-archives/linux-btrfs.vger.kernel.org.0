Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946FC2153B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgGFIGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 04:06:00 -0400
Received: from mail.synology.com ([211.23.38.101]:33380 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbgGFIF7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 04:05:59 -0400
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594022757; bh=spPLDKDa9NQxEHvwm8dvkvyJZplCHnrEw5Gk77HqCmQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=MvrHEfx/0odZeQm7LVOz5XQjuBiMdjh2k5P91LhOX3V8NA2NQekc965ILwPLRjH+z
         xVbyZmAXPSdqUhekuU6xlqUhRlrmF3SANQPNEyyUuIYSCYy4aL4MhTzanlwx5lNjX1
         VcMFVKlgFbE7etoAzc6rRCIQCyyTI9+06W+Imohc=
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
References: <20200701092957.20870-1-robbieko@synology.com>
 <aeb651c8-0739-100b-90ad-9f36ecdc26e6@synology.com>
 <7da55a96-131c-b987-edfb-97375a940cd2@gmx.com>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <375407fc-3c3c-6628-3e80-a5300a897e4e@synology.com>
Date:   Mon, 6 Jul 2020 16:05:56 +0800
MIME-Version: 1.0
In-Reply-To: <7da55a96-131c-b987-edfb-97375a940cd2@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I've known btrfs_read_block_groups for a long time,

we can use BG_TREE freature to speed up btrfs_read_block_groups.

https://lwn.net/Articles/801990/


But reading the chunk tree also takes some time,

we can speed up the chunk tree by using the readahead mechanism.

Why we not just use regular forward readahead?
- Because the regular forward readahead ,
   reads only the logical address adjacent to the 64k,
   but the logical address of the next leaf may not be in 64k.

I have a test environment as follows:

200TB btrfs volume: used 192TB

Data, single: total=192.00TiB, used=192.00TiB
System, DUP: total=40.00MiB, used=19.91MiB
Metadata, DUP: total=63.00GiB, used=46.46GiB
GlobalReserve, single: total=2.00GiB, used=0.00B

chunk tree level : 2
chunk tree tree:
   nodes: 4
   leaves: 1270
   total: 1274
chunk tree size: 19.9 MB
SYSTEM chunks count : 2 (8MB, 32MB)

btrfs_read_chunk_tree spends the following time :

before: 1.89s

patch: 0.27s

Speed increase of about 85%.

Between the chunk tree leaves, there will be a different SYSTEM chunk,

when the The more frequent the chunk allocate/remove, the larger the gap 
between the leaves.

e.g. chunk tree node :
     key (FIRST_CHUNK_TREE CHUNK_ITEM 85020014280704) block 
79866020003840 (4874635010) gen 12963
     key (FIRST_CHUNK_TREE CHUNK_ITEM 85185370521600) block 28999680 
(1770) gen 12964
     key (FIRST_CHUNK_TREE CHUNK_ITEM 85351800504320) block 
79866020347904 (4874635031) gen 12964
     key (FIRST_CHUNK_TREE CHUNK_ITEM 85518230487040) block 
79866020102144 (4874635016) gen 12964
     key (FIRST_CHUNK_TREE CHUNK_ITEM 85684660469760) block 
79866020118528 (4874635017) gen 12964
     key (FIRST_CHUNK_TREE CHUNK_ITEM 85851090452480) block 
79866020134912 (4874635018) gen 12964
     key (FIRST_CHUNK_TREE CHUNK_ITEM 86017520435200) block 29261824 
(1786) gen 12964
     key (FIRST_CHUNK_TREE CHUNK_ITEM 86183950417920) block 
79866020397056 (4874635034) gen 12965
     key (FIRST_CHUNK_TREE CHUNK_ITEM 86350380400640) block 
79866020151296 (4874635019) gen 12965
     key (FIRST_CHUNK_TREE CHUNK_ITEM 86516810383360) block 
79866020167680 (4874635020) gen 12965
     key (FIRST_CHUNK_TREE CHUNK_ITEM 86683240366080) block 
79866020184064 (4874635021) gen 12965
     key (FIRST_CHUNK_TREE CHUNK_ITEM 86849670348800) block 
79866020200448 (4874635022) gen 12965
     key (FIRST_CHUNK_TREE CHUNK_ITEM 87016100331520) block 29065216 
(1774) gen 12966
     key (FIRST_CHUNK_TREE CHUNK_ITEM 87182530314240) block 
79866020315136 (4874635029) gen 12966
     key (FIRST_CHUNK_TREE CHUNK_ITEM 87348960296960) block 
79866020331520 (4874635030) gen 12966
     key (FIRST_CHUNK_TREE CHUNK_ITEM 87515390279680) block 
79866020413440 (4874635035) gen 12966
     key (FIRST_CHUNK_TREE CHUNK_ITEM 87681820262400) block 
79866020429824 (4874635036) gen 12966
     key (FIRST_CHUNK_TREE CHUNK_ITEM 87848250245120) block 29294592 
(1788) gen 12968
     key (FIRST_CHUNK_TREE CHUNK_ITEM 88014680227840) block 
79866020544512 (4874635043) gen 12968


With 1PB of btrfs volume, we will have more SYSTEM CHUNK,

and each chunk tree leaf will be more fragmented,

and the time difference will be larger.


Qu Wenruo 於 2020/7/6 下午2:16 寫道:
>
> On 2020/7/6 下午2:13, Robbie Ko wrote:
>> Does anyone have any suggestions?
> I believe David's suggestion on using regular readahead is already good
> enough for chunk tree.
>
> Especially since chunk tree is not really the main cause for slow mount.
>
> Thanks,
> Qu
>
>> robbieko 於 2020/7/1 下午5:29 寫道:
>>> From: Robbie Ko <robbieko@synology.com>
>>>
>>> When mounting, we always need to read the whole chunk tree,
>>> when there are too many chunk items, most of the time is
>>> spent on btrfs_read_chunk_tree, because we only read one
>>> leaf at a time.
>>>
>>> We fix this by adding a new readahead mode READA_FORWARD_FORCE,
>>> which reads all the leaves after the key in the node when
>>> reading a level 1 node.
>>>
>>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>>> ---
>>>    fs/btrfs/ctree.c   | 7 +++++--
>>>    fs/btrfs/ctree.h   | 2 +-
>>>    fs/btrfs/volumes.c | 1 +
>>>    3 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index 3a7648bff42c..abb9108e2d7d 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -2194,7 +2194,7 @@ static void reada_for_search(struct
>>> btrfs_fs_info *fs_info,
>>>                if (nr == 0)
>>>                    break;
>>>                nr--;
>>> -        } else if (path->reada == READA_FORWARD) {
>>> +        } else if (path->reada == READA_FORWARD || path->reada ==
>>> READA_FORWARD_FORCE) {
>>>                nr++;
>>>                if (nr >= nritems)
>>>                    break;
>>> @@ -2205,12 +2205,15 @@ static void reada_for_search(struct
>>> btrfs_fs_info *fs_info,
>>>                    break;
>>>            }
>>>            search = btrfs_node_blockptr(node, nr);
>>> -        if ((search <= target && target - search <= 65536) ||
>>> +        if ((path->reada == READA_FORWARD_FORCE) ||
>>> +            (search <= target && target - search <= 65536) ||
>>>                (search > target && search - target <= 65536)) {
>>>                readahead_tree_block(fs_info, search);
>>>                nread += blocksize;
>>>            }
>>>            nscan++;
>>> +        if (path->reada == READA_FORWARD_FORCE)
>>> +            continue;
>>>            if ((nread > 65536 || nscan > 32))
>>>                break;
>>>        }
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index d404cce8ae40..808bcbdc9530 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -353,7 +353,7 @@ struct btrfs_node {
>>>     * The slots array records the index of the item or block pointer
>>>     * used while walking the tree.
>>>     */
>>> -enum { READA_NONE, READA_BACK, READA_FORWARD };
>>> +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
>>>    struct btrfs_path {
>>>        struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
>>>        int slots[BTRFS_MAX_LEVEL];
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 0d6e785bcb98..78fd65abff69 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>>> *fs_info)
>>>        path = btrfs_alloc_path();
>>>        if (!path)
>>>            return -ENOMEM;
>>> +    path->reada = READA_FORWARD_FORCE;
>>>          /*
>>>         * uuid_mutex is needed only if we are mounting a sprout FS
