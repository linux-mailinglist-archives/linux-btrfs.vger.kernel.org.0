Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6A511B3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiD0Ojm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 10:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiD0Oje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 10:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509C231DCD
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:36:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E82ED21123;
        Wed, 27 Apr 2022 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651070178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVybj2vkgs8RrravetIMjUlAYFKBrmNlNZkw4hwoEpc=;
        b=Ifnm6c05d//lETl++CH4Q5F8wXb0GBUZ1UCLaJ9wpvk9R03zaaaaEcF61nbPOByRcWyGKO
        41+guz5ziEbcjCvLXN98kjWDWtYD2wkiDev01v3xf5m2U7oVy8W+hhTp7JkOi0DGbzSFt4
        ZXeVaSTK1X1/jqwylu08vWGtwx5lA2o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCEF213A39;
        Wed, 27 Apr 2022 14:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b/JcLOJUaWKzegAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 27 Apr 2022 14:36:18 +0000
Message-ID: <58aa36f6-6f86-19b1-2eff-50d172b97a6d@suse.com>
Date:   Wed, 27 Apr 2022 16:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: Turn name_cache radix tree into XArray in
 send_ctx
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220426095101.8516-1-gniebler@suse.com>
 <d5c1e631-a380-dc08-05b0-c4520318cadd@suse.com>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <d5c1e631-a380-dc08-05b0-c4520318cadd@suse.com>
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

Am 27.04.22 um 13:46 schrieb Nikolay Borisov:
> On 26.04.22 г. 12:51 ч., Gabriel Niebler wrote:
>> … and adjust all usages of this object to use the XArray API for the sake
>> of consistency.
>>
>> XArray API provides array semantics, so it is notionally easier to use 
>> and
>> understand, and it also takes care of locking for us.
>>
>> None of this makes a real difference in this particular patch, but it 
>> does
>> in other places where similar replacements are or have been made and we
>> want to be consistent in our usage of data structures in btrfs.
>>
>> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
>> ---
>>
>> Changes from v1:
>>   - Let commit message begin with "btrfs: "
>>
>> ---
>>   fs/btrfs/send.c | 40 +++++++++++++++++++---------------------
>>   1 file changed, 19 insertions(+), 21 deletions(-)
>>
> 
> LGTM, one minor nit below though.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> <snip>
> 
>> @@ -262,14 +261,14 @@ struct orphan_dir_info {
>>   struct name_cache_entry {
>>       struct list_head list;
>>       /*
>> -     * radix_tree has only 32bit entries but we need to handle 64bit 
>> inums.
>> -     * We use the lower 32bit of the 64bit inum to store it in the 
>> tree. If
>> -     * more then one inum would fall into the same entry, we use 
>> radix_list
>> -     * to store the additional entries. radix_list is also used to store
>> -     * entries where two entries have the same inum but different
>> +     * On 32bit kernels, XArray has only 32bit indices, but we need to
>> +     * handle 64bit inums. We use the lower 32bit of the 64bit inum 
>> to store
>> +     * it in the tree. If more than one inum would fall into the same 
>> entry,
>> +     * we use inum_aliases to store the additional entries. 
>> inum_aliases is
>> +     * also used to store entries with the same inum but different
>>        * generations.
>>        */
>> -    struct list_head radix_list;
>> +    struct list_head inum_aliases;
>>       u64 ino;
>>       u64 gen;
>>       u64 parent_ino;
>> @@ -2019,9 +2018,9 @@ static int did_overwrite_first_ref(struct 
>> send_ctx *sctx, u64 ino, u64 gen)
>>   }
>>   /*
>> - * Insert a name cache entry. On 32bit kernels the radix tree index 
>> is 32bit,
>> + * Insert a name cache entry. On 32bit kernels the XArray index is 
>> 32bit,
>>    * so we need to do some special handling in case we have clashes. 
>> This function
>> - * takes care of this with the help of name_cache_entry::radix_list.
>> + * takes care of this with the help of name_cache_entry::inum_aliases.
>>    * In case of error, nce is kfreed.
>>    */
>>   static int name_cache_insert(struct send_ctx *sctx,
>> @@ -2030,8 +2029,7 @@ static int name_cache_insert(struct send_ctx *sctx,
>>       int ret = 0;
>>       struct list_head *nce_head;
>> -    nce_head = radix_tree_lookup(&sctx->name_cache,
>> -            (unsigned long)nce->ino);
>> +    nce_head = xa_load(&sctx->name_cache, (unsigned long)nce->ino);
> 
> The casting is redundant since the function's argument is already 
> declared as unsigned long so truncation happens anyway. The only 
> rationale to keep is for documentation purposes but even this is 
> somewhat dubious. But since there is already something said about that 
> above the definition of inum_aliases I'd say lets do away with the casts.

I see your point and I agree with you, but I'd like to point out that I 
didn't add this cast - it was already there  (and I think there may be 
others, too).

I thought about removing it (as we had discussed and I've done in 
another patch), but then I decided to leave it, thinking that maybe 
there was a reason for it. Like communicating something explicitely to 
anyone reading the code.

It's true, though, that the comment actually explains it.

>>       if (!nce_head) {
>>           nce_head = kmalloc(sizeof(*nce_head), GFP_KERNEL);
>>           if (!nce_head) {
>> @@ -2040,14 +2038,15 @@ static int name_cache_insert(struct send_ctx 
>> *sctx,
>>           }
>>           INIT_LIST_HEAD(nce_head);
>> -        ret = radix_tree_insert(&sctx->name_cache, nce->ino, nce_head);
>> +        ret = xa_insert(&sctx->name_cache, nce->ino, nce_head,
> 
> Here nce->ino is not cast, yet the parameter is still unsigned long 
> meaning truncation occurs (as is expected). At the very least this makes 
> the code style inconsistent.

Yeah, true. Again, it was inconsistent before I got there, but I'll 
admit that I didn't notice this one.

For the sake of consistency, I'm willing to remove the cast (and perhaps 
others, would have to check) and resend.

I'll leave that up to the maintainer to decide.
