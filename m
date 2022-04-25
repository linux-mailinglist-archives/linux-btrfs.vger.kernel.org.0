Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2450DCB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiDYJdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiDYJcI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:32:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A64124BCF
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:29:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47F60210EC;
        Mon, 25 Apr 2022 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650878940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAP0ewczifJ2wlImxpRT4hQoENqDfP7MSQ5F6er66Jc=;
        b=vIUyXctw1s8We0HklEeoe09jNEy8yVDa/KBWZhD5GXk3pRP+P4t7fbGrPOa/WvC9uVEjUR
        U3PxazTgT8ZLhomqVjfaVFqw0AlW9qum6U34GLVTbZahk6zVVxV664IMtxSGbKKSwiVb69
        ZghjX9ng6DYg7b2bpzZUH1QxmuN1N5s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2045A13AE1;
        Mon, 25 Apr 2022 09:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IuQlBtxpZmKRGQAAMHmgww
        (envelope-from <gniebler@suse.com>); Mon, 25 Apr 2022 09:29:00 +0000
Message-ID: <70c5e257-55d7-ff0a-8b6b-1051734aa1d5@suse.com>
Date:   Mon, 25 Apr 2022 11:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220419155721.6702-1-gniebler@suse.com>
 <9a8d4a62-8ca9-9ee3-2d94-8094428dd182@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <9a8d4a62-8ca9-9ee3-2d94-8094428dd182@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I looked at this again, to see how this obvious problem could have 
slipped by me, and found something interesting...

Am 20.04.22 um 09:09 schrieb Nikolay Borisov:
> On 19.04.22 г. 18:57 ч., Gabriel Niebler wrote:
>> … in the btrfs_root struct and adjust all usages of this object to use 
>> the
>> XArray API, because it is notionally easier to use and unserstand, as it
>> provides array semantics, and also takes care of locking for us, further
>> simplifying the code.
>>
>> Also use the opportunity to do some light refactoring.
>>
>> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
>> ---
>>
> 
> <snip>
> 
>> @@ -1870,29 +1863,33 @@ void btrfs_kill_delayed_inode_items(struct 
>> btrfs_inode *inode)
>>   void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>>   {
>> -    u64 inode_id = 0;
>> +    unsigned long index = 0;
>> +    struct btrfs_delayed_node *delayed_node;
>>       struct btrfs_delayed_node *delayed_nodes[8];
> 
> Actually in order for the new code to be correct this array needs to be 
> zero-initialized upon every iteration of the while() loop. That's 
> because as it stands ATM delayed_nodes would retain the value from the 
> previous iteration.

That is correct.

> What this could lead to is on the last iteration we 
> potentially have 8 nodes in delayed_nodes which have been freed, so if 
> in the last iteration of the xa_for_each_start we copy only 3 nodes the 
> array would still have 8 nodes in total - 3 from the  last iteration and 
> 5 stale from the previous since they haven't been cleared out.

Still correct and a similar situation could occur when there are fewer 
than 8 delayed nodes in the array to begin with. Then the uninitialised 
entries in the array would contain garbage...

> So the 
> final for() loop which does the freeing would incur a double free on the 
> 5 already-freed entries.

Except that it never gets there, because it only goes up to 'n' and n 
will have the value of the highest *actual* entry in _this_ iteration of 
the enclosing while-loop.

<snip>

>>       int i, n;
>>       while (1) {
>>           spin_lock(&root->inode_lock);
>> -        n = radix_tree_gang_lookup(&root->delayed_nodes_tree,
>> -                       (void **)delayed_nodes, inode_id,
>> -                       ARRAY_SIZE(delayed_nodes));
>> -        if (!n) {
>> +        if (xa_empty(&root->delayed_nodes)) {
>>               spin_unlock(&root->inode_lock);
>> -            break;
>> +            return;
>>           }
>> -        inode_id = delayed_nodes[n - 1]->inode_id + 1;
>> -        for (i = 0; i < n; i++) {
>> +        n = 0;
>> +        xa_for_each_start(&root->delayed_nodes, index,
>> +                  delayed_node, index) {
>>               /*
>>                * Don't increase refs in case the node is dead and
>>                * about to be removed from the tree in the loop below
>>                */
>> -            if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
>> -                delayed_nodes[i] = NULL;
>> +            if (refcount_inc_not_zero(&delayed_node->refs)) {
>> +                delayed_nodes[n] = delayed_node;
>> +                n++;
>> +                        }
>> +            if (n >= ARRAY_SIZE(delayed_nodes))
>> +                break;
>>           }
>> +        index++;
>>           spin_unlock(&root->inode_lock);
>>           for (i = 0; i < n; i++) {

There it is. This loop will never encounter old (already freed) or 
uninitialised entries, AFAICS.

I'd say that there actually isn't a problem with this code.

Now the question is whether the change should still be done. Declaring 
and initialising the array for each iteration incurs a little overhead, 
though, so I don't really see why it should be.

And if not, should I then resubmit purely for the whitespace changes?
