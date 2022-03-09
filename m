Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63E4D2F0A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiCIM2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 07:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCIM2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 07:28:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C10032ED2
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 04:27:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C6B81F380;
        Wed,  9 Mar 2022 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646828862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUO9E5Oz/J+Q0tejErIRIB4W8LzHQwfh4ptDT9UUlaQ=;
        b=RSTM0pm7UV5KXkY2XkdU8KpbaNzDko9bpwXBnypXW1E9HJpNxnx5+ShTiR4fSw6Y+J7oEc
        D7YJTL+gFCsgbnHF+RQZUXWdc37YOzwbU6NLc0QRIikq12OVgfLYSuxfoRGcMcKvMyoJU9
        0gmaIWqZySoNA0UwCnNnEnWo354M/sQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1F7E13D79;
        Wed,  9 Mar 2022 12:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b+aSLz2dKGKyAgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 12:27:41 +0000
Message-ID: <fb6aff15-b6cb-a143-e4c1-a50bfb21a12f@suse.com>
Date:   Wed, 9 Mar 2022 14:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 06/13] btrfs-progs:
 btrfs_item_size_nr/btrfs_item_offset_nr everywhere
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1645568701.git.josef@toxicpanda.com>
 <fc4887f36095607112c2a37946d253436ab31226.1645568701.git.josef@toxicpanda.com>
 <300c4868-46e3-9862-3355-cd0091f2ae3e@suse.com>
In-Reply-To: <300c4868-46e3-9862-3355-cd0091f2ae3e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.03.22 г. 13:45 ч., Nikolay Borisov wrote:
> 
> 
> On 23.02.22 г. 0:26 ч., Josef Bacik wrote:
>> We have this pattern in a lot of places
>>
>>     item = btrfs_item_nr(slot);
>>     btrfs_item_size(leaf, item);
>>     btrfs_item_offset(leaf, item);
>>
>> when we could simply use
>>
>>     btrfs_item_size_nr(leaf, slot);
>>     btrfs_item_offset_nr(leaf, slot);
>>
>> Fix all callers of btrfs_item_size() and btrfs_item_offset() to use the
>> _nr variation of the helpers.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   check/main.c               |  8 ++++----
>>   image/main.c               |  2 +-
>>   kernel-shared/backref.c    |  4 +---
>>   kernel-shared/ctree.c      | 24 ++++++++++++------------
>>   kernel-shared/dir-item.c   |  6 ++----
>>   kernel-shared/inode-item.c |  4 +---
>>   kernel-shared/print-tree.c |  6 +++---
>>   7 files changed, 24 insertions(+), 30 deletions(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index e9ac94cc..76eb8d54 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -4222,10 +4222,10 @@ static int swap_values(struct btrfs_root 
>> *root, struct btrfs_path *path,
>>           item2 = btrfs_item_nr(slot + 1);
>>           btrfs_item_key_to_cpu(buf, &k1, slot);
>>           btrfs_item_key_to_cpu(buf, &k2, slot + 1);
>> -        item1_offset = btrfs_item_offset(buf, item1);
>> -        item2_offset = btrfs_item_offset(buf, item2);
>> -        item1_size = btrfs_item_size(buf, item1);
>> -        item2_size = btrfs_item_size(buf, item2);
>> +        item1_offset = btrfs_item_offset_nr(buf, slot);
>> +        item2_offset = btrfs_item_offset_nr(buf, slot + 1);
>> +        item1_size = btrfs_item_size_nr(buf, slot);
>> +        item2_size = btrfs_item_size_nr(buf, slot + 1);
>>           item1_data = malloc(item1_size);
>>           if (!item1_data)
>> diff --git a/image/main.c b/image/main.c
>> index 3125163d..e953d981 100644
>> --- a/image/main.c
>> +++ b/image/main.c
>> @@ -1239,7 +1239,7 @@ static void truncate_item(struct extent_buffer 
>> *eb, int slot, u32 new_size)
>>       for (i = slot; i < nritems; i++) {
>>           u32 ioff;
>>           item = btrfs_item_nr(i);
>> -        ioff = btrfs_item_offset(eb, item);
>> +        ioff = btrfs_item_offset_nr(eb, i);
>>           btrfs_set_item_offset(eb, item, ioff + size_diff);
>>       }
>> diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
>> index f1a638ed..327599b7 100644
>> --- a/kernel-shared/backref.c
>> +++ b/kernel-shared/backref.c
>> @@ -1417,7 +1417,6 @@ static int iterate_inode_refs(u64 inum, struct 
>> btrfs_root *fs_root,
>>       u64 parent = 0;
>>       int found = 0;
>>       struct extent_buffer *eb;
>> -    struct btrfs_item *item;
>>       struct btrfs_inode_ref *iref;
>>       struct btrfs_key found_key;
>> @@ -1442,10 +1441,9 @@ static int iterate_inode_refs(u64 inum, struct 
>> btrfs_root *fs_root,
>>           extent_buffer_get(eb);
>>           btrfs_release_path(path);
>> -        item = btrfs_item_nr(slot);
>>           iref = btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
>> -        for (cur = 0; cur < btrfs_item_size(eb, item); cur += len) {
>> +        for (cur = 0; cur < btrfs_item_size_nr(eb, slot); cur += len) {
>>               name_len = btrfs_inode_ref_name_len(eb, iref);
>>               /* path must be released before calling iterate()! */
>>               pr_debug("following ref at offset %u for inode %llu in "
>> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
>> index 10b22b2c..fc661aeb 100644
>> --- a/kernel-shared/ctree.c
>> +++ b/kernel-shared/ctree.c
>> @@ -2041,7 +2041,7 @@ static int push_leaf_right(struct 
>> btrfs_trans_handle *trans, struct btrfs_root
>>           if (path->slots[0] == i)
>>               push_space += data_size + sizeof(*item);
> 
> item is no longer used in this while so the assignment done above this 
> if can also be removed. Heck, I'd even go as far as moving the variable 
> declaration inside the for() loop further down and convert all the 
> sizeof(*item) calls to either sizeof(struct btrfs_item) or make a const 
> size_t item_size = sizeof(struct btrfs_item) atop the function and use 
> that.
>> -        this_item_size = btrfs_item_size(left, item);
>> +        this_item_size = btrfs_item_size_nr(left, i);
>>           if (this_item_size + sizeof(*item) + push_space > free_space)
>>               break;
>>           push_items++;
>> @@ -2092,7 +2092,7 @@ static int push_leaf_right(struct 
>> btrfs_trans_handle *trans, struct btrfs_root
>>       push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
>>       for (i = 0; i < right_nritems; i++) {
>>           item = btrfs_item_nr(i);
> 
> Then this line could be turned into:
> struct btrfs_item item = btrfs_item_nr(i);
> 
>> -        push_space -= btrfs_item_size(right, item);
>> +        push_space -= btrfs_item_size_nr(right, i);
>>           btrfs_set_item_offset(right, item, push_space);
> 
> And item would be confined to the single site here.
> 
>>       }
>> @@ -2187,7 +2187,7 @@ static int push_leaf_left(struct 
>> btrfs_trans_handle *trans, struct btrfs_root
>>           if (path->slots[0] == i)
>>               push_space += data_size + sizeof(*item);
>> -        this_item_size = btrfs_item_size(right, item);
>> +        this_item_size = btrfs_item_size_nr(right, i);
>>           if (this_item_size + sizeof(*item) + push_space > free_space)
>>               break;
>> @@ -2224,7 +2224,7 @@ static int push_leaf_left(struct 
>> btrfs_trans_handle *trans, struct btrfs_root
>>           u32 ioff;
>>           item = btrfs_item_nr(i);
>> -        ioff = btrfs_item_offset(left, item);
>> +        ioff = btrfs_item_offset_nr(left, i);
>>           btrfs_set_item_offset(left, item,
>>                 ioff - (BTRFS_LEAF_DATA_SIZE(root->fs_info) -
>>                     old_left_item_size));
>> @@ -2256,7 +2256,7 @@ static int push_leaf_left(struct 
>> btrfs_trans_handle *trans, struct btrfs_root
>>       push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
>>       for (i = 0; i < right_nritems; i++) {
>>           item = btrfs_item_nr(i);
>> -        push_space = push_space - btrfs_item_size(right, item);
>> +        push_space = push_space - btrfs_item_size_nr(right, i);
>>           btrfs_set_item_offset(right, item, push_space);
>>       }
> 
> nit: Same strategy can be applied to push_leaf_left as the one in 
> pusth_leaf_right
> 
> <snip>
> 
>> @@ -3029,7 +3029,7 @@ int btrfs_del_items(struct btrfs_trans_handle 
>> *trans, struct btrfs_root *root,
>>               u32 ioff;
>>               item = btrfs_item_nr(i);
> 
> nit: btrfs_item is used only in this loop so why not move it to reduce 
> the variable's scope.
> 
>> -            ioff = btrfs_item_offset(leaf, item);
>> +            ioff = btrfs_item_offset_nr(leaf, i);
>>               btrfs_set_item_offset(leaf, item, ioff + dsize);
>>           }
> 
> <snip>
> 

Oh right that's effectively implemented by the following patch so 
disregard this one ;)
