Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273EF589F38
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiHDQSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiHDQSH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 12:18:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECD933E2A
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 09:18:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5BDA6383E2;
        Thu,  4 Aug 2022 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659629885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAZgnIFKdPoPQW3LYWAOdAnfXKhWg0jpmmDktOgt5sM=;
        b=RbJrKMhawXxvtPT5tsr9pTx2JV+28OOtaj5hV978p3lDj9YoJtPmELm2QGbbBx93Ud6axc
        TVa0qii1t46F/lXCXAVd6h9Sdshr0DmfTW63bMFBlROB34ofs9IMZZMjn4mVyOu67KTwhI
        MU29cxsiI8T8EGXkSc/TPAlYOtVAa8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31EA013434;
        Thu,  4 Aug 2022 16:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y/9sCT3x62IqJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Aug 2022 16:18:05 +0000
Message-ID: <b43079d6-282e-ec00-a455-2a852806f9c1@suse.com>
Date:   Thu, 4 Aug 2022 19:18:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] btrfs: use btrfs_find_inode in btrfs_prune_dentries
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220721135006.3345302-1-nborisov@suse.com>
 <20220721135006.3345302-3-nborisov@suse.com>
 <20220804154141.GU13489@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220804154141.GU13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.08.22 г. 18:41 ч., David Sterba wrote:
> On Thu, Jul 21, 2022 at 04:50:05PM +0300, Nikolay Borisov wrote:
>> Now that we have a standalone function which encapsulates the logic of
>> searching the root's ino rb tree use that. It results in massive
>> simplification of the code.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>   fs/btrfs/inode.c | 47 +++++++++++++++++------------------------------
>>   1 file changed, 17 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index c11169ba28b2..06724925a3d3 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -4635,44 +4635,27 @@ struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
>>   static void btrfs_prune_dentries(struct btrfs_root *root)
>>   {
>>   	struct btrfs_fs_info *fs_info = root->fs_info;
>> -	struct rb_node *node;
>> -	struct rb_node *prev;
>> -	struct btrfs_inode *entry;
>> -	struct inode *inode;
>> +	struct rb_node *node = NULL;
>>   	u64 objectid = 0;
>>   
>>   	if (!BTRFS_FS_ERROR(fs_info))
>>   		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
>>   
>>   	spin_lock(&root->inode_lock);
>> -again:
>> -	node = root->inode_tree.rb_node;
>> -	prev = NULL;
>> -	while (node) {
>> -		prev = node;
>> -		entry = rb_entry(node, struct btrfs_inode, rb_node);
>> +	do {
>> +		struct btrfs_inode *entry;
>> +		struct inode *inode;
>>   
>> -		if (objectid < btrfs_ino(entry))
>> -			node = node->rb_left;
>> -		else if (objectid > btrfs_ino(entry))
>> -			node = node->rb_right;
>> -		else
>> -			break;
>> -	}
>> -	if (!node) {
>> -		while (prev) {
>> -			entry = rb_entry(prev, struct btrfs_inode, rb_node);
>> -			if (objectid <= btrfs_ino(entry)) {
>> -				node = prev;
>> +		if (!node) {
>> +			node = btrfs_find_inode(root, objectid);
>> +			if (!node)
>>   				break;
>> -			}
>> -			prev = rb_next(prev);
>>   		}
>> -	}
>> -	while (node) {
>> +
>>   		entry = rb_entry(node, struct btrfs_inode, rb_node);
>>   		objectid = btrfs_ino(entry) + 1;
>>   		inode = igrab(&entry->vfs_inode);
>> +
>>   		if (inode) {
>>   			spin_unlock(&root->inode_lock);
>>   			if (atomic_read(&inode->i_count) > 1)
>> @@ -4684,14 +4667,18 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
>>   			iput(inode);
>>   			cond_resched();
>>   			spin_lock(&root->inode_lock);
>> -			goto again;
>> +			node = NULL;
> 
> This sets node to NULL and continues, which sends it down to while
> (node), which makes it effectively a break and it's not equivalent to
> the original behaviour that jumps back to again: or "do {" , or I'm
> missing something.

You are right, this is buggy, I'll rework it.

> 
>> +			continue;
>>   		}
>>   
>> -		if (cond_resched_lock(&root->inode_lock))
>> -			goto again;
>> +		if (cond_resched_lock(&root->inode_lock)) {
>> +			node = NULL;
>> +			continue;
>> +		}
>>   
>>   		node = rb_next(node);
>> -	}
>> +	} while(node);
>> +
>>   	spin_unlock(&root->inode_lock);
>>   }
>>   
>> -- 
>> 2.25.1
