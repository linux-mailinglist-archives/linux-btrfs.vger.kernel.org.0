Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F562CDA70
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgLCPz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 10:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgLCPz5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 10:55:57 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757A6C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 07:55:17 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so2515758qkb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 07:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TbmgfTIVh9ny1ICJfK3l8nTNdhUXR8+VRUqtU+l3OG8=;
        b=oNxf2UQl0odTQ/YjkY3ynLypxuy77xb9+ZmJ+a8m57Ta3NzPg6QkiNTwuwDU3OXJPJ
         Sx8X11Is39YtlzzjDzVpgKrBdzBQ4xOuB9HqrlYeKngZiZ08qGG1Hoxbw/LbHkkATNEM
         roUSMKAFUw6YakP2VEFo+PfAXBeoDA74xNQwHhiglcCePgWdNGP45VeWPZbux0WZG9X9
         JKNr0SuEccQZ2ayzXU/OzgyoKy3lOu3QsQmcMyi/qK5V0Jprbwq0ZZUNm8sNtXNNtTFB
         1Gdq4B4wo1G/HeIxgeTSIaq0I5TePIuwcEHifMCXf4SPKaTKw3OepKSM5eIydw4V2PRE
         lSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbmgfTIVh9ny1ICJfK3l8nTNdhUXR8+VRUqtU+l3OG8=;
        b=PXMS66uzY4uULf/qg/vN+J+Dm310SGZj4K2pSKsS0d36rl4evxE/Ux6GYjh/MsPMZk
         lRVYmFnC1cuiISyUR7umb2thxW2R/MO+EJPhXn3J8uPNnxhPt8NaI5QugxZPIFGp0BPR
         50bjDnhWUIymi3+Hmw0lKCQVcwRCg6e1YEHy+QAp7Di3XHJDCP1ulUnEUvJIXMQs0uj/
         lBiv/bxK+XV2CxW/Mfxy0W23A+JNyWQBY8l2cslFWzf9Vyf4kBm5MkMCn28ZwOeVp+wA
         Ck17spDHwx+TGKZOCOLVeLU4F0fS3QXMpzJ7SzG/d5c1piWVX3O9BG5uEcxE99sGKqFO
         9p9Q==
X-Gm-Message-State: AOAM5328eULghg6j9JhD4+2qNo5taxtFCO/786y5MaO2AMPrC+ZC0HN1
        S99D4tjH+weJjSdYAu7LNOU4Chb4KNcj4toQ
X-Google-Smtp-Source: ABdhPJxNOWId/S14Ix4nEBAFsr/TT1J2vnFhNfRshLE90wXzH0ngooVVHIYFvuoL+3P86yW2egAdFw==
X-Received: by 2002:a05:620a:2202:: with SMTP id m2mr3446587qkh.251.1607010916412;
        Thu, 03 Dec 2020 07:55:16 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g143sm1597157qke.102.2020.12.03.07.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 07:55:15 -0800 (PST)
Subject: Re: [PATCH v3 04/54] btrfs: keep track of the root owner for
 relocation reads
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6d95a4747f99af7b1ce4cdd249998c821de2515a.1606938211.git.josef@toxicpanda.com>
 <487bcc51-3d99-2592-4168-8b8bbf7d5017@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4fec4b49-2fa8-f208-75e6-93c13a29c226@toxicpanda.com>
Date:   Thu, 3 Dec 2020 10:55:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <487bcc51-3d99-2592-4168-8b8bbf7d5017@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/2/20 9:04 PM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:50, Josef Bacik wrote:
>> While testing the error paths in relocation, I hit the following lockdep
>> splat
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.10.0-rc3+ #206 Not tainted
>> ------------------------------------------------------
>> btrfs-balance/1571 is trying to acquire lock:
>> ffff8cdbcc8f77d0 (&head_ref->mutex){+.+.}-{3:3}, at: btrfs_lookup_extent_info+0x156/0x3b0
>>
>> but task is already holding lock:
>> ffff8cdbc54adbf8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x27/0x100
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (btrfs-tree-00){++++}-{3:3}:
>>         down_write_nested+0x43/0x80
>>         __btrfs_tree_lock+0x27/0x100
>>         btrfs_search_slot+0x248/0x890
>>         relocate_tree_blocks+0x490/0x650
>>         relocate_block_group+0x1ba/0x5d0
>>         kretprobe_trampoline+0x0/0x50
>>
>> -> #1 (btrfs-csum-01){++++}-{3:3}:
>>         down_read_nested+0x43/0x130
>>         __btrfs_tree_read_lock+0x27/0x100
>>         btrfs_read_lock_root_node+0x31/0x40
>>         btrfs_search_slot+0x5ab/0x890
>>         btrfs_del_csums+0x10b/0x3c0
>>         __btrfs_free_extent+0x49d/0x8e0
>>         __btrfs_run_delayed_refs+0x283/0x11f0
>>         btrfs_run_delayed_refs+0x86/0x220
>>         btrfs_start_dirty_block_groups+0x2ba/0x520
>>         kretprobe_trampoline+0x0/0x50
>>
>> -> #0 (&head_ref->mutex){+.+.}-{3:3}:
>>         __lock_acquire+0x1167/0x2150
>>         lock_acquire+0x116/0x3e0
>>         __mutex_lock+0x7e/0x7b0
>>         btrfs_lookup_extent_info+0x156/0x3b0
>>         walk_down_proc+0x1c3/0x280
>>         walk_down_tree+0x64/0xe0
>>         btrfs_drop_subtree+0x182/0x260
>>         do_relocation+0x52e/0x660
>>         relocate_tree_blocks+0x2ae/0x650
>>         relocate_block_group+0x1ba/0x5d0
>>         kretprobe_trampoline+0x0/0x50
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>    &head_ref->mutex --> btrfs-csum-01 --> btrfs-tree-00
>>
>>   Possible unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(btrfs-tree-00);
>>                                 lock(btrfs-csum-01);
>>                                 lock(btrfs-tree-00);
> 
> I found it a little confusing that, subv trees got the name "tree".
> 
> Maybe another patch to rename it to something like "fs" or "subv" would
> be better?
> 
> [...]
>>
>> As you can see this is bogus, we never take another tree's lock under
>> the csum lock.  This happens because sometimes we have to read tree
>> blocks from disk without knowing which root they belong to during
>> relocation.  We defaulted to an owner of 0, which translates to an fs
>> tree.  This is fine as all fs trees have the same class, but obviously
>> isn't fine if the block belongs to a cow only tree.
>>
>> Thankfully cow only trees only have their owners root as a reference to
>> them, and since we already look up the extent information during
>> relocation, go ahead and check and see if this block might belong to a
>> cow only tree, and if so save the owner in the struct tree_block.  This
>> allows us to read_tree_block with the proper owner, which gets rid of
>> this lockdep splat.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> The fix is OK, although some extra comment inlined below.
>> ---
>>   fs/btrfs/relocation.c | 47 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 19b7db8b2117..2b30e39e922a 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -98,6 +98,7 @@ struct tree_block {
>>   		u64 bytenr;
>>   	}; /* Use rb_simple_node for search/insert */
>>   	struct btrfs_key key;
>> +	u64 owner;
>>   	unsigned int level:8;
>>   	unsigned int key_ready:1;
>>   };
>> @@ -2393,8 +2394,8 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
>>   {
>>   	struct extent_buffer *eb;
>>   
>> -	eb = read_tree_block(fs_info, block->bytenr, 0, block->key.offset,
>> -			     block->level, NULL);
>> +	eb = read_tree_block(fs_info, block->bytenr, block->owner,
>> +			     block->key.offset, block->level, NULL);
>>   	if (IS_ERR(eb)) {
>>   		return PTR_ERR(eb);
>>   	} else if (!extent_buffer_uptodate(eb)) {
>> @@ -2493,7 +2494,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
>>   	/* Kick in readahead for tree blocks with missing keys */
>>   	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
>>   		if (!block->key_ready)
>> -			btrfs_readahead_tree_block(fs_info, block->bytenr, 0, 0,
>> +			btrfs_readahead_tree_block(fs_info, block->bytenr,
>> +						   block->owner, 0,
>>   						   block->level);
>>   	}
>>   
>> @@ -2801,21 +2803,59 @@ static int add_tree_block(struct reloc_control *rc,
>>   	u32 item_size;
>>   	int level = -1;
>>   	u64 generation;
>> +	u64 owner = 0;
>>   
>>   	eb =  path->nodes[0];
>>   	item_size = btrfs_item_size_nr(eb, path->slots[0]);
>>   
>>   	if (extent_key->type == BTRFS_METADATA_ITEM_KEY ||
>>   	    item_size >= sizeof(*ei) + sizeof(*bi)) {
>> +		unsigned long ptr = 0, end;
> 
> Do we really need that end to iterate through the extent item?
> 
> For cow-only trees, we only cow them to do the balance, which means
> metadata/extent item for them should only contain one inline item and no
> way to have keyed item.
> 
> If the metadata/extent item has more than one inline ref, it must not be
> for COW trees.
> 
> Can't we use extent item size as a quick check?

If you look further down you'll see that I only check the first inline ref, I 
don't loop through all of them.  I also don't bother to check if num_refs > 1, 
or if FULL_BACKREF is set.  The only time we actually check is if there is only 
one inline ref.  Thanks,

Josef
