Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7275009B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiDNJ25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbiDNJ2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 05:28:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AC6EB30
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 02:26:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 820F41F746;
        Thu, 14 Apr 2022 09:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649928390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkZrsHdrcwD1u+oY3K47DoeSD3JGAHnTFY2R2jPv64Q=;
        b=eURgW0iQIMIR/fdQ2dY+Yq5c6KhMx/2O5mCacmxOjiREAn/w8/bAwNTy+9Pi0qLJ2QY+21
        H6dWHJ4/wUKlYUCirP0FNuR6xx96bJ95EDE8e6d5Ej/rFtU6VhV3RHiP5EAYKR21UTB1dO
        xLIf9KAM/XkYJcQLM+GdOTvUlWI27/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3531C132C0;
        Thu, 14 Apr 2022 09:26:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lJWlCsboV2K9YgAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 14 Apr 2022 09:26:30 +0000
Message-ID: <3a4a506f-e604-9847-2844-810b53223ef1@suse.com>
Date:   Thu, 14 Apr 2022 11:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220412123546.30478-1-gniebler@suse.com>
 <c3347f72-0737-38bc-0fd7-70fa7bb272b2@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <c3347f72-0737-38bc-0fd7-70fa7bb272b2@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 13.04.22 um 15:34 schrieb Nikolay Borisov:
> On 12.04.22 г. 15:35 ч., Gabriel Niebler wrote:
>> […]
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index 748bf6b0d860..89e1c39c2aef 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -78,7 +78,7 @@ static struct btrfs_delayed_node 
>> *btrfs_get_delayed_node(
>>       }
>>       spin_lock(&root->inode_lock);
>> -    node = radix_tree_lookup(&root->delayed_nodes_tree, ino);
>> +    node = xa_load(&root->delayed_nodes, (unsigned long)ino);
> 
> Isn't this problematic, because  you'd be truncating the ino in case we 
> have a number which is larger than unsigned long. For architectures 
> which use long as a 64 bit type this cast is a noop since u64 is defined 
> as unsigned long (via typedef unsigned long __u64; typedef __u64 u64). 
> But on arches which use long long for their 64bit type then this would 
> truncate the ino number, so I think this cast is redundant. In any case 
> the code is broken for u64 for arches which use long long and as the 
> author of xarray put it just now:
> 
> <willy> yup.  It's not a great data structure for storing u64s in
> 
> However, looking at the existing radix_tree_insert the index is also an 
> unsigned long. TLDR is remove the cast.

Right. This is something I wasn't too sure of myself and I lacked the 
deeper understanding to make a better informed decision here, so thank 
you for your insight. I will remove the cast.

In particular, the fact that radix trees already have this problem was 
something I missed (even though it's kind of clear that they must, as 
it's the same data structure under the hood, but I didn't look too 
closely at the functions and the fact they take an unsigned long in the 
same places as the XArray equivalents).

This will also play a role in upcoming patches where I often did the 
same cast, but now I know that I don't need it. If it worked before, it 
will work after.

>> @@ -1870,29 +1863,32 @@ void btrfs_kill_delayed_inode_items(struct 
>> btrfs_inode *inode)
>>   void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>>   {
>> -    u64 inode_id = 0;
>> +    unsigned long index;
>> +    struct btrfs_delayed_node *delayed_node;
>>       struct btrfs_delayed_node *delayed_nodes[8];
>>       int i, n;
>>       while (1) {
>>           spin_lock(&root->inode_lock);
>> -        n = radix_tree_gang_lookup(&root->delayed_nodes_tree,
>> -                       (void **)delayed_nodes, inode_id,
>> -                       ARRAY_SIZE(delayed_nodes));
>> -        if (!n) {
>> +        if (xa_empty(&root->delayed_nodes)) {
>>               spin_unlock(&root->inode_lock);
>>               break;
>>           }
>> -        inode_id = delayed_nodes[n - 1]->inode_id + 1;
>> -        for (i = 0; i < n; i++) {
>> +        n = 0;
>> +        xa_for_each_start(&root->delayed_nodes, index,
>> +                  delayed_node, index) {
> 
> Here index is used not only as the index of the current entry but also 
> as the "start from this index". But you are not actually initializing it 
> so index has garbage on the first iteration. If you want to start from 
> the 0th index then you should initialize it when defining it.

Whoops, what an oversight. Good catch! Thanks for pointing this out! 
Will fix.

>>               /*
>>                * Don't increase refs in case the node is dead and
>>                * about to be removed from the tree in the loop below
>>                */
>> -            if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
>> -                delayed_nodes[i] = NULL;
>> +            if (!refcount_inc_not_zero(&delayed_node->refs))
>> +                delayed_nodes[n] = NULL;
> 
> This is broken. What the original code did was query up to 8 delayed 
> nodes at a time and and then for every node which got written into the 
> delayed_nodes array it incremented the refcount so that later the nodes 
> can be destroyed outside of spin_unlock. In your code you don't write 
> the node into the local delayed_nodes array, meaning the for() loop 
> never frees anything.

You're right, of course. All that's missing is a
             delayed_nodes[n] = delayed_node;
before the `if`, but without that it doesn't work. I don't know how I 
missed that one. Again, thanks for noticing! Will fix.

