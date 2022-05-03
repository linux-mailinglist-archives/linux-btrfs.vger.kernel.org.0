Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A443D517F50
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiECIFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiECIFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:05:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE9624E
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:01:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 359C1210E0;
        Tue,  3 May 2022 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651564899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYRZxrIlhiNeibo3sS0ETi0LtJUukCYyXL+e2ryQAeY=;
        b=c+Z7Km3hhe4M8nhNUTvu8kB70hV2uE4iCLTS47ISCqBnRhVAcq+JGwzIs5Ds2wyDdBeqEZ
        gMVFgIi1KysI7zRa5Nk10ubH/sNKxurgYz7xZuvOseD3+Gk+GpapswLUG8M7X9v2Fdngsp
        srdeuYABrjHmlBmr2dsJoXVxfW9TSkY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10C9E13ABE;
        Tue,  3 May 2022 08:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z405AmPhcGJ2LAAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 03 May 2022 08:01:39 +0000
Message-ID: <5faa24ee-5a02-b045-3d58-3d94cb4ca45f@suse.com>
Date:   Tue, 3 May 2022 10:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Content-Language: en-US
From:   Gabriel Niebler <gniebler@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220426214525.14192-1-gniebler@suse.com>
 <a2b7e2c4-440c-318c-ea1f-273be04591f0@suse.com>
 <e4ced932-1f39-86fb-c0a4-018c47cf10fa@suse.com>
In-Reply-To: <e4ced932-1f39-86fb-c0a4-018c47cf10fa@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had another look at this and have to correct myself:

Am 02.05.22 um 10:59 schrieb Gabriel Niebler:
> Am 28.04.22 um 13:59 schrieb Nikolay Borisov:
>> On 27.04.22 г. 0:45 ч., Gabriel Niebler wrote:
>>> … rename it to simply fs_roots and adjust all usages of this object 
>>> to use
>>> the XArray API, because it is notionally easier to use and 
>>> unserstand, as
>>> it provides array semantics, and also takes care of locking for us,
>>> further simplifying the code.
>>>
>>> Also do some refactoring, esp. where the API change requires largely
>>> rewriting some functions, anyway.
>>>
>>> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
>>> ---
>>>   fs/btrfs/ctree.h       |   5 +-
>>>   fs/btrfs/disk-io.c     | 176 ++++++++++++++++++++---------------------
>>>   fs/btrfs/inode.c       |  13 +--
>>>   fs/btrfs/transaction.c |  67 +++++++---------
>>>   4 files changed, 126 insertions(+), 135 deletions(-)

<snip>

 >>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
 >>> index 126f244cdf88..a8577f659f66 100644
 >>> --- a/fs/btrfs/disk-io.c
 >>> +++ b/fs/btrfs/disk-io.c

<snip>

>>> @@ -4512,50 +4501,54 @@ void btrfs_drop_and_free_fs_root(struct 
>>> btrfs_fs_info *fs_info,
>>>   int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>>>   {
>>> -    u64 root_objectid = 0;
>>> -    struct btrfs_root *gang[8];
>>> -    int i = 0;
>>> +    struct btrfs_root *roots[8];
>>> +    unsigned long index = 0;
>>> +    int i;
>> nit: This can be defined into the 2 loops that use the variable.
> 
> Sure, why not.

I was wrong here, actually. The second for-loop that uses 'i' does not 
initialise it to zero, but deliberately starts with i at the last value 
it had when the first for-loop that uses it was last exited, because 
that one may have been broken out of, due to some cleanup error, and 
thus there may be unreleased roots still in the array.

This is how the code used to work before and I just kept that logic.

But then it's obviously important to declare 'i' outside of both loops 
so it can keep the value between them.

>>>       int err = 0;
>>> -    unsigned int ret = 0;
>>> +    int grabbed;
>>>       while (1) {
>>> -        spin_lock(&fs_info->fs_roots_radix_lock);
>>> -        ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>>> -                         (void **)gang, root_objectid,
>>> -                         ARRAY_SIZE(gang));
>>> -        if (!ret) {
>>> -            spin_unlock(&fs_info->fs_roots_radix_lock);
>>> +        struct btrfs_root *root;
>>> +
>>> +        spin_lock(&fs_info->fs_roots_lock);
>>> +        if (!xa_find(&fs_info->fs_roots, &index,
>>> +                 ULONG_MAX, XA_PRESENT)) {
>>> +            spin_unlock(&fs_info->fs_roots_lock);
>>>               break;
>>>           }
>>> -        root_objectid = gang[ret - 1]->root_key.objectid + 1;
>>> -        for (i = 0; i < ret; i++) {
>>> -            /* Avoid to grab roots in dead_roots */
>>> -            if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>>> -                gang[i] = NULL;
>>> -                continue;
>>> +        grabbed = 0;
>>> +        xa_for_each_start(&fs_info->fs_roots, index, root,
>>> +                  index) {
>>> +            /* Avoid grabbing roots in dead_roots */
>>> +            if (btrfs_root_refs(&root->root_item) == 0) {
>>> +                roots[grabbed] = NULL;
>>> +            } else {
>>> +                /* Grab all the search results for later use */
>>> +                roots[grabbed] = btrfs_grab_root(root);
>>>               }
>>> -            /* grab all the search result for later use */
>>> -            gang[i] = btrfs_grab_root(gang[i]);
>>> +            grabbed++;
>>> +            if (grabbed >= ARRAY_SIZE(roots))
>>> +                break;
>>>           }
>>> -        spin_unlock(&fs_info->fs_roots_radix_lock);
>>> +        spin_unlock(&fs_info->fs_roots_lock);
>>> -        for (i = 0; i < ret; i++) {
>>> -            if (!gang[i])
>>> +        for (i = 0; i < grabbed; i++) {
>>> +            if (!roots[i])
>>>                   continue;
>>> -            root_objectid = gang[i]->root_key.objectid;
>>> -            err = btrfs_orphan_cleanup(gang[i]);
>>> +            index = roots[i]->root_key.objectid;
>>> +            err = btrfs_orphan_cleanup(roots[i]);
>>>               if (err)
>>>                   break;
>>> -            btrfs_put_root(gang[i]);
>>> +            btrfs_put_root(roots[i]);
>>>           }
>>> -        root_objectid++;
>>> +        index++;
>>>       }
>>> -    /* release the uncleaned roots due to error */
>>> -    for (; i < ret; i++) {
>>> -        if (gang[i])
>>> -            btrfs_put_root(gang[i]);
>>> +    /* Release the roots that remain uncleaned due to error */
>>> +    for (; i < grabbed; i++) {
>>> +        if (roots[i])
>>> +            btrfs_put_root(roots[i]);
>>>       }
>>>       return err;
>>>   }

<snip>

I will do all the other changes we discussed and resend, but I'll leave 
this one alone.
