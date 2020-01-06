Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C808130CA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 04:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgAFDp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 22:45:58 -0500
Received: from mail.synology.com ([211.23.38.101]:47052 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbgAFDp5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 22:45:57 -0500
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id 402FADB180CF;
        Mon,  6 Jan 2020 11:45:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1578282355; bh=3Zf0/knWuC0ahRrFXMfgMozwCs/b1Z/ZKLHbadNbupQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=GDvhppMDsgQuxM9P4h23a5dMbkxlFzaXxQYJ108N3khnC99G9iTGB6eM6KDDsQGav
         zQvm/CteyZ4hmQWIy0gTvbCSCvBfJCHT13hyMSNLER972tZQohLI/4at+Yl8UlVIBn
         DfaiTLkar3oTLEvOolMGzveDhogqH1XN8d8sEnZ0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 06 Jan 2020 11:45:55 +0800
From:   ethanwu <ethanwu@synology.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
In-Reply-To: <017fb679-ca13-f38e-e67b-6f1d42c1fbbd@toxicpanda.com>
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
 <017fb679-ca13-f38e-e67b-6f1d42c1fbbd@toxicpanda.com>
Message-ID: <8937126609d3cca7239a9dcf3b2e78fc@synology.com>
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

Josef Bacik 於 2020-01-04 00:31 寫到:
> On 1/3/20 4:44 AM, ethanwu wrote:
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
>>      extent refs 24 gen 7302 flags DATA
>>      extent data backref root 257 objectid 260 offset 65536 count 5 
>> #backref entry 1
>>      extent data backref root 258 objectid 265 offset 0 count 9 
>> #backref entry 2
>>      shared data backref parent 394985472 count 10 #backref entry 3
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
>> 
> 
> This seems like the crux of the problem here.  The backref stuff is
> just blindly looking for counts, without keeping track of which counts
> matter.  So for full refs we should only be looking down paths where
> generation > the snapshot generation.  And then for the shared refs it
> should be anything that comes from that shared block.  That would be
> the proper way to fix the problem, not put some arbitrary limit on how
> far into the inode we can search.
> 

I am not sure if generation could be used to skip blocks for 
full(indirect) backref.

For exmple:
create a data extent in subvol id 257 at generation 10
At generation 11, take snapshot(suppose the snapshot id is 258) from 
subvol 257.

When we send snapshot 258, all the tree blocks it searches comes from 
subvol 257,
since snapshot only copy root node from its source,
none of tree blocks in subvol 257 has generation(all <= 10) > snapshot 
generation(11)

Or do I miss something?

> That's not to say what you are doing here is wrong, we really won't
> have anything past the given extent size so we can definitely break
> out earlier.  But what I worry about is say 394985472 _was_ in between
> the leaves while searching down for backref entry #1, we'd end up with
> duplicate entries and not catch some of the other entries.  This feels

This patch doesn't adjust the total_refs. Is there any example that
this patch will ruin the backref walking?

> like we need to fix the backref logic to know if it's looking for
> direct refs, and thus only go down paths with generation > snapshot
> generation, or shared refs and thus only count things that directly
> point to the parent block.  Thanks,
> 

Ok, I agree, my patch doesn't solve the original problem:
When resolving indirect refs, we could take entries that don't
belong to the backref entry we are searching for right now.

If this need to be fixed, I think it could be done by the following way

item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize
         extent refs 24 gen 7302 flags DATA
         shared data backref parent 394985472 count 10 #backref entry 1
         extent data backref root 257 objectid 260 offset 1048576 count 3 
#backref entry 2
         extent data backref root 256 objectid 260 offset 65536 count 6 
#backref entry 3
         extent data backref root 257 objectid 260 offset 65536 count 5 
#backref entry 4

When searching for entry 4, the EXTENT_DATA entries that match the 
EXTENT_ITEM bytenr
will be in one of the following situations:

1. shared block that just happens to be part of root 257. For every leaf 
we run into,
    check its bytenr to see if it is a shared data backref entry, if so 
skip it.
    We may need an extra list or rb tree to store this information.
2. same subvol, inode but different offset. Right now in 
add_all_parents, we only
    check if bytenr matches. Adding extra check to see if backref offset 
is the same
    (here backref entry 1: 65536 != entry 3: 1048576)
3. This might happen if subvol 257 is a snapshot from subvol 256, check 
leaf owner, if
    not 257 skip it.
4. None of the above, it's type 4 backref entry, this is what we want, 
add it!

In this way, we only count entries that matter, and total_refs could be
changed from total refs of that extent item to number of each entry.
Then, we could break from loop as soon as possible.

Will this look better?

thanks,
ethanwu

> Josef

