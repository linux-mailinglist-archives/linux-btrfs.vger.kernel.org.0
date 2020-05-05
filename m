Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B829C1C4B94
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 03:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgEEBjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 21:39:24 -0400
Received: from mail.synology.com ([211.23.38.101]:37536 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbgEEBjY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 21:39:24 -0400
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id CBF9BCE7800D;
        Tue,  5 May 2020 09:39:21 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1588642761; bh=VwBa+0JWESTEADCpS3UDhX2NVHjc/Xg2qQe5Xwg/9xw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=P7+2OrzggzpTScqX3tZN1fQk2I7WkLqCLc4D4fY2Dg4Zz2ilSLNnXH9bUKBvH5tj0
         TlSM+/XnYXtwwHIRibm0qQoQQzKPjmkKqgevMwgAkKv6SQDPfug4UWHrUQ7mT13iXv
         m3+W79VGmMjEaWC6V8S0wMLpKggbQSG6d2WwdXrA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 05 May 2020 09:39:21 +0800
From:   robbieko <robbieko@synology.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     linux-btrfs-owner@vger.kernel.org
Subject: Re: [PATCH] Btrfs : improve the speed of compare orphan item and dead
 roots with tree root when mount
In-Reply-To: <31c590f2abee67d60ca8941f5e92e924@synology.com>
References: <20200427080411.13273-1-robbieko@synology.com>
 <20200427154628.GE18421@twin.jikos.cz>
 <31c590f2abee67d60ca8941f5e92e924@synology.com>
Message-ID: <b0f35dbab104cc8119327343f157a48a@synology.com>
X-Sender: robbieko@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

Does anyone have suggestions ?

Thanks.
Robbie Ko

robbieko 於 2020-04-28 11:12 寫到:
> David Sterba 於 2020-04-27 23:46 寫到:
>> On Mon, Apr 27, 2020 at 04:04:11PM +0800, robbieko wrote:
>>> From: Robbie Ko <robbieko@synology.com>
>>> 
>>> When mounting, we handle deleted subvol and orphan items.
>>> First, find add orphan roots, then add them to fs_root radix tree.
>>> Second, in tree-root, process each orphan item, skip if it is dead 
>>> root.
>>> 
>>> The original algorithm is based on the list of dead_roots,
>>> one by one to visit and check whether the objectid is consistent,
>>> the time complexity is O (n ^ 2).
>>> When processing 50000 deleted subvols, it takes about 120s.
>>> 
>>> We can quickly check whether the orphan item is dead root
>>> through the fs_roots radix tree.
>>> 
>>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>>> ---
>>>  fs/btrfs/inode.c | 20 +++++++++-----------
>>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>> 
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 320d1062068d..1becf5c63e5a 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -3000,18 +3000,16 @@ int btrfs_orphan_cleanup(struct btrfs_root 
>>> *root)
>>>  			 * orphan must not get deleted.
>>>  			 * find_dead_roots already ran before us, so if this
>>>  			 * is a snapshot deletion, we should find the root
>>> -			 * in the dead_roots list
>>> +			 * in the fs_roots radix tree.
>>>  			 */
>>> -			spin_lock(&fs_info->trans_lock);
>>> -			list_for_each_entry(dead_root, &fs_info->dead_roots,
>>> -					    root_list) {
>>> -				if (dead_root->root_key.objectid ==
>>> -				    found_key.objectid) {
>>> -					is_dead_root = 1;
>>> -					break;
>>> -				}
>>> -			}
>>> -			spin_unlock(&fs_info->trans_lock);
>>> +
>>> +			spin_lock(&fs_info->fs_roots_radix_lock);
>>> +			dead_root = radix_tree_lookup(&fs_info->fs_roots_radix,
>>> +							 (unsigned long)found_key.objectid);
>>> +			if (dead_root && btrfs_root_refs(&dead_root->root_item) == 0)
>>> +				is_dead_root = 1;
>>> +			spin_unlock(&fs_info->fs_roots_radix_lock);
>> 
>> The list uses fs_info::trans_lock and the radix uses
>> fs_roots_radix_lock. I'd like to know why you think it's safe.
>> 
>> The trans_lock is used for a lot of things, fs_roots_radix_lock is for
>> the radix tree insertion/deletion/update/lookup so it does not seem 
>> like
>> an equivalent change. It could be functionally equivalent due to some
>> other constraint, like that the number of references is 0 and the tree
>> won't be ever touched outside of the orphan cleanup process.
> 
> Because btrfs_find_orphan_roots has already ran before us,
> and added deleted subvol to fs_roots radix tree.
> 
> The fs root will only be removed from the fs_roots radix tree
> after the cleaner is processed, and the cleaner will only start
> execution after the mount is complete.
> 
> So we can directly find the root from the radix tree.
> 
>> 
>> btrfs_orphan_cleanup can be called during the whole filesystem mount
>> lifetime, so we can't rely on the mount time where nothing can 
>> iterfere.
> 
> Only "tree root" will be used in this section of code,
> and only mount time will be brought into tree root.

