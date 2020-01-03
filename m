Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645C712F762
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 12:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgACLh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 06:37:57 -0500
Received: from mail.synology.com ([211.23.38.101]:44962 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbgACLh5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 06:37:57 -0500
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id C282CDB18369;
        Fri,  3 Jan 2020 19:37:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1578051473; bh=GpluurZEiR2uUsQpkYDgIluNszjxTMv5VdHSRn/Luxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=n4D5YYGtEm0W9VeThoW2RIZwJEqeaeF2bMxPMOhFBdPlpZKPci8CrJqqoW0HWMS5n
         /nxQwylw2klKUmdmUf30CHzB2HUj2uWoxYuglZe5Lz6zWyDUw4zPgvh6jVs87lkgg8
         ak9rgwPxC6pXfSbexM1mK3gFd/EzDmKC4i8SWw7E=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 03 Jan 2020 19:37:53 +0800
From:   ethanwu <ethanwu@synology.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
In-Reply-To: <ff4f41f1-b0f0-a787-a9c4-73fbb5893fa4@gmx.com>
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
 <ff4f41f1-b0f0-a787-a9c4-73fbb5893fa4@gmx.com>
Message-ID: <af1fafa0b9e6617ab3bccbdfe908956d@synology.com>
X-Sender: ethanwu@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo 於 2020-01-03 18:15 寫到:
> On 2020/1/3 下午5:44, ethanwu wrote:
>> Btrfs has two types of data backref.
>> For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
>> exact block number. Therefore, we need to call resolve_indirect_refs
>> which uses btrfs_search_slot to locate the leaf block. After that,
>> we need to walk through the leafs to search for the EXTENT_DATA items
>> that have disk bytenr matching the extent item(add_all_parents).
>> 
>> The only conditions we'll stop searching are
>> 1. We find different object id or type is not EXTENT_DATA
>> 2. We've already got all the refs we want(total_refs)
>> 
>> Take the following EXTENT_ITEM as example:
>> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 
>> 95
>>     extent refs 24 gen 7302 flags DATA
>>     extent data backref root 257 objectid 260 offset 65536 count 5 
>> #backref entry 1
>>     extent data backref root 258 objectid 265 offset 0 count 9 
>> #backref entry 2
>>     shared data backref parent 394985472 count 10 #backref entry 3
>> 
>> If we want to search for backref entry 1, total_refs here would be 24 
>> rather
>> than its count 5.
>> 
>> The reason to use 24 is because some EXTENT_DATA in backref entry 3 
>> block
>> 394985472 also points to EXTENT_ITEM 40831553536, if this block also 
>> belongs to
>> root 257 and lies between these 5 items of backref entry 1,
>> and we use total_refs = 5, we'll end up missing some refs from backref
>> entry 1.
> 
> Indeed looks like a problem.
> 
>> 
>> But using total_refs=24 is not accurate. We'll never find extent data 
>> keys in
>> backref entry 2, since we searched root 257 not 258. We'll never reach 
>> block
>> 394985472 either if this block is not a leaf in root 257.
>> As a result, the loop keeps on going until we reach the end of that 
>> inode.
>> 
>> Since we're searching for parent block of this backref entry 1,
>> we're 100% sure we'll never find any EXTENT_DATA beyond (65536 + 
>> 4194304) that
>> matching this entry.
> 
> Backref offset is always a bug-prone member, thus I hope to double 
> check
> on this.
> 
> What if the backref offset already underflows?
> Like this:
>   item 10 key (13631488 EXTENT_ITEM 1048576) itemoff 15860 itemsize 111
>        refs 3 gen 6 flags DATA
>        extent data backref root FS_TREE objectid 259 offset
> 18446744073709547520 count 1 <<<
>        extent data backref root FS_TREE objectid 257 offset 0 count 1
>        extent data backref root FS_TREE objectid 258 offset 4096 count 
> 1
> 
> 
> Since backref offset is not file offset, but file_extent_item::offset -
> file_offset, it can be a super large number for reflinked extents.
> 
> 
> Current kernel handles this by a very ugly but working hack: resetting
> key_for_search.offset to 0 in add_prelim_ref() if it detects such case.
> 
> Then this would screw up your check, causing unexpected early exit.

Thanks for the reminder.
I think in this case the check won't fail. Even when we revert the 
working hack
in the future, it still works unless we use u64 to do the calculation.

(u64) 18446744073709547520 = (s64) -4096

Suppose this very large offset is equal to X
            The next line is the original file view.
            [                                 ]
            ^           ^                     ^     ......    ^
            0           (u64)X + num_bytes    EOF             X
       [----oooooooooooo]  Original range to check. - part is
       ^                   the very large offset where no file extents
       X in terms of s64   exist, so actually the range [0,X+num_bytes)
            [oooooooooooooooo]  range to check after hack X=>0
                             ^
                             0 + num_bytes

With my patch, applying this hack will only make my check condition 
looser.
Causing more range to be checked (represented by o) compared to no hack.

The only way I think this check would fail would be:
File at offset 2^64 - 4096 uses offset 0 of a 1MB data extent,
key_for_search->offset + num_bytes = 2^64 - 4096 + 1048576 = 1044480
Therefore, when iterating through the leafs, we'll break early at
offset 1044480, leave the EXTENT_DATA key @2^64 - 4096 behind.
But AFAIK, file of that size is not allowed in btrfs.

Thanks,
ethanwu
> 
> I guess we have to find a new method to solve the problem then.
> 
> Thanks,
> Qu
> 
>> If there's any EXTENT_DATA with offset beyond this range
>> using this extent item, its backref must be stored at different 
>> backref entry.
>> That EXTENT_DATA will be handled when we process that backref entry.
>> 
>> Fix this by breaking from loop if we reach offset + (size of 
>> EXTENT_ITEM).
>> 
>> btrfs send use backref to search for clone candidate.
>> Without this patch, performance drops when running following script.
>> This script creates a 10G file with all of its extent size 64K.
>> Then it generates shared backref for each data extent, and
>> those backrefs could not be found when doing 
>> btrfs_resolve_indirect_refs.
>> 
>> item 87 key (11843469312 EXTENT_ITEM 65536) itemoff 10475 itemsize 66
>>     refs 3 gen 74 flags DATA
>>     extent data backref root 256 objectid 260 offset 10289152 count 2
>>     # This shared backref couldn't be found when resolving
>>     # indirect ref from snapshot of sub 256
>>     shared data backref parent 2303049728 count 1
>> 
>> btrfs subvolume create /volume1/sub1
>> for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file 
>> bs=64K count=1 seek=$((i-1)) conv=notrunc oflag=direct 2>/dev/null; 
>> done
>> btrfs subvolume snapshot /volume1/sub1 /volume1/sub2
>> for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file 
>> bs=4K count=1 seek=$(((i-1)*16+10)) conv=notrunc oflag=direct 
>> 2>/dev/null; done
>> btrfs subvolume snapshot -r /volume1/sub1 /volume1/snap1
>> time btrfs send /volume1/snap1 | btrfs receive /volume2
>> 
>> without this patch
>> real 69m48.124s
>> user 0m50.199s
>> sys  70m15.600s
>> 
>> with this patch
>> real 1m31.498s
>> user 0m35.858s
>> sys  2m55.544s
>> 
>> Signed-off-by: ethanwu <ethanwu@synology.com>
>> ---
>>  fs/btrfs/backref.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>> 
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index e5d8531..ae64995 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -412,7 +412,7 @@ static int add_indirect_ref(const struct 
>> btrfs_fs_info *fs_info,
>>  static int add_all_parents(struct btrfs_root *root, struct btrfs_path 
>> *path,
>>  			   struct ulist *parents, struct prelim_ref *ref,
>>  			   int level, u64 time_seq, const u64 *extent_item_pos,
>> -			   u64 total_refs, bool ignore_offset)
>> +			   u64 total_refs, bool ignore_offset, u64 num_bytes)
>>  {
>>  	int ret = 0;
>>  	int slot;
>> @@ -458,6 +458,9 @@ static int add_all_parents(struct btrfs_root 
>> *root, struct btrfs_path *path,
>>  		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
>>  		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
>> 
>> +		if (key_for_search->type == BTRFS_EXTENT_DATA_KEY &&
>> +		    key.offset >= key_for_search->offset + num_bytes)
>> +		       break;
>>  		if (disk_byte == wanted_disk_byte) {
>>  			eie = NULL;
>>  			old = NULL;
>> @@ -504,7 +507,7 @@ static int resolve_indirect_ref(struct 
>> btrfs_fs_info *fs_info,
>>  				struct btrfs_path *path, u64 time_seq,
>>  				struct prelim_ref *ref, struct ulist *parents,
>>  				const u64 *extent_item_pos, u64 total_refs,
>> -				bool ignore_offset)
>> +				bool ignore_offset, u64 num_bytes)
>>  {
>>  	struct btrfs_root *root;
>>  	struct btrfs_key root_key;
>> @@ -575,7 +578,8 @@ static int resolve_indirect_ref(struct 
>> btrfs_fs_info *fs_info,
>>  	}
>> 
>>  	ret = add_all_parents(root, path, parents, ref, level, time_seq,
>> -			      extent_item_pos, total_refs, ignore_offset);
>> +			      extent_item_pos, total_refs, ignore_offset,
>> +			      num_bytes);
>>  out:
>>  	path->lowest_level = 0;
>>  	btrfs_release_path(path);
>> @@ -610,7 +614,8 @@ static int resolve_indirect_refs(struct 
>> btrfs_fs_info *fs_info,
>>  				 struct btrfs_path *path, u64 time_seq,
>>  				 struct preftrees *preftrees,
>>  				 const u64 *extent_item_pos, u64 total_refs,
>> -				 struct share_check *sc, bool ignore_offset)
>> +				 struct share_check *sc, bool ignore_offset,
>> +				 u64 num_bytes)
>>  {
>>  	int err;
>>  	int ret = 0;
>> @@ -655,7 +660,7 @@ static int resolve_indirect_refs(struct 
>> btrfs_fs_info *fs_info,
>>  		}
>>  		err = resolve_indirect_ref(fs_info, path, time_seq, ref,
>>  					   parents, extent_item_pos,
>> -					   total_refs, ignore_offset);
>> +					   total_refs, ignore_offset, num_bytes);
>>  		/*
>>  		 * we can only tolerate ENOENT,otherwise,we should catch error
>>  		 * and return directly.
>> @@ -1127,6 +1132,7 @@ static int find_parent_nodes(struct 
>> btrfs_trans_handle *trans,
>>  	struct extent_inode_elem *eie = NULL;
>>  	/* total of both direct AND indirect refs! */
>>  	u64 total_refs = 0;
>> +	u64 num_bytes = SZ_256M;
>>  	struct preftrees preftrees = {
>>  		.direct = PREFTREE_INIT,
>>  		.indirect = PREFTREE_INIT,
>> @@ -1194,6 +1200,7 @@ static int find_parent_nodes(struct 
>> btrfs_trans_handle *trans,
>>  				goto again;
>>  			}
>>  			spin_unlock(&delayed_refs->lock);
>> +			num_bytes = head->num_bytes;
>>  			ret = add_delayed_refs(fs_info, head, time_seq,
>>  					       &preftrees, &total_refs, sc);
>>  			mutex_unlock(&head->mutex);
>> @@ -1215,6 +1222,7 @@ static int find_parent_nodes(struct 
>> btrfs_trans_handle *trans,
>>  		if (key.objectid == bytenr &&
>>  		    (key.type == BTRFS_EXTENT_ITEM_KEY ||
>>  		     key.type == BTRFS_METADATA_ITEM_KEY)) {
>> +			num_bytes = key.offset;
>>  			ret = add_inline_refs(fs_info, path, bytenr,
>>  					      &info_level, &preftrees,
>>  					      &total_refs, sc);
>> @@ -1236,7 +1244,8 @@ static int find_parent_nodes(struct 
>> btrfs_trans_handle *trans,
>>  
>> 	WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_missing_keys.root.rb_root));
>> 
>>  	ret = resolve_indirect_refs(fs_info, path, time_seq, &preftrees,
>> -				    extent_item_pos, total_refs, sc, ignore_offset);
>> +				    extent_item_pos, total_refs, sc, ignore_offset,
>> +				    num_bytes);
>>  	if (ret)
>>  		goto out;
>> 
>> 

