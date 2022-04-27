Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B05116F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiD0LuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiD0LuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 07:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E1986AD6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 04:47:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B99FA1F746;
        Wed, 27 Apr 2022 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651060020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDc0eWgxWw3EIYY7Z/Q3GzTqyl+tBRzX55qNvSpXoy0=;
        b=I+gbRm48ducokvoHWYtH3zJYqpniAKBs5CW5RMU+AmGnxxnt7Ii1zauWF4vMFLhRgD1KJz
        DgCOFawkM5H5KlFjsh0von4BJnaIL0fzL7/L9XoacVQqWIFGFtfJzkxTy5XhnqXEotnyHk
        etUypQTcXwTir6daKonuHwRZLZwAgOw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80B1613A39;
        Wed, 27 Apr 2022 11:47:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yG1hGzQtaWKbJwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 27 Apr 2022 11:47:00 +0000
Message-ID: <d5c1e631-a380-dc08-05b0-c4520318cadd@suse.com>
Date:   Wed, 27 Apr 2022 14:46:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: Turn name_cache radix tree into XArray in
 send_ctx
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220426095101.8516-1-gniebler@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220426095101.8516-1-gniebler@suse.com>
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



On 26.04.22 г. 12:51 ч., Gabriel Niebler wrote:
> … and adjust all usages of this object to use the XArray API for the sake
> of consistency.
> 
> XArray API provides array semantics, so it is notionally easier to use and
> understand, and it also takes care of locking for us.
> 
> None of this makes a real difference in this particular patch, but it does
> in other places where similar replacements are or have been made and we
> want to be consistent in our usage of data structures in btrfs.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
> 
> Changes from v1:
>   - Let commit message begin with "btrfs: "
> 
> ---
>   fs/btrfs/send.c | 40 +++++++++++++++++++---------------------
>   1 file changed, 19 insertions(+), 21 deletions(-)
> 

LGTM, one minor nit below though.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

<snip>

> @@ -262,14 +261,14 @@ struct orphan_dir_info {
>   struct name_cache_entry {
>   	struct list_head list;
>   	/*
> -	 * radix_tree has only 32bit entries but we need to handle 64bit inums.
> -	 * We use the lower 32bit of the 64bit inum to store it in the tree. If
> -	 * more then one inum would fall into the same entry, we use radix_list
> -	 * to store the additional entries. radix_list is also used to store
> -	 * entries where two entries have the same inum but different
> +	 * On 32bit kernels, XArray has only 32bit indices, but we need to
> +	 * handle 64bit inums. We use the lower 32bit of the 64bit inum to store
> +	 * it in the tree. If more than one inum would fall into the same entry,
> +	 * we use inum_aliases to store the additional entries. inum_aliases is
> +	 * also used to store entries with the same inum but different
>   	 * generations.
>   	 */
> -	struct list_head radix_list;
> +	struct list_head inum_aliases;
>   	u64 ino;
>   	u64 gen;
>   	u64 parent_ino;
> @@ -2019,9 +2018,9 @@ static int did_overwrite_first_ref(struct send_ctx *sctx, u64 ino, u64 gen)
>   }
>   
>   /*
> - * Insert a name cache entry. On 32bit kernels the radix tree index is 32bit,
> + * Insert a name cache entry. On 32bit kernels the XArray index is 32bit,
>    * so we need to do some special handling in case we have clashes. This function
> - * takes care of this with the help of name_cache_entry::radix_list.
> + * takes care of this with the help of name_cache_entry::inum_aliases.
>    * In case of error, nce is kfreed.
>    */
>   static int name_cache_insert(struct send_ctx *sctx,
> @@ -2030,8 +2029,7 @@ static int name_cache_insert(struct send_ctx *sctx,
>   	int ret = 0;
>   	struct list_head *nce_head;
>   
> -	nce_head = radix_tree_lookup(&sctx->name_cache,
> -			(unsigned long)nce->ino);
> +	nce_head = xa_load(&sctx->name_cache, (unsigned long)nce->ino);

The casting is redundant since the function's argument is already 
declared as unsigned long so truncation happens anyway. The only 
rationale to keep is for documentation purposes but even this is 
somewhat dubious. But since there is already something said about that 
above the definition of inum_aliases I'd say lets do away with the casts.

>   	if (!nce_head) {
>   		nce_head = kmalloc(sizeof(*nce_head), GFP_KERNEL);
>   		if (!nce_head) {
> @@ -2040,14 +2038,15 @@ static int name_cache_insert(struct send_ctx *sctx,
>   		}
>   		INIT_LIST_HEAD(nce_head);
>   
> -		ret = radix_tree_insert(&sctx->name_cache, nce->ino, nce_head);
> +		ret = xa_insert(&sctx->name_cache, nce->ino, nce_head,

Here nce->ino is not cast, yet the parameter is still unsigned long 
meaning truncation occurs (as is expected). At the very least this makes 
the code style inconsistent.

> +				GFP_KERNEL);
>   		if (ret < 0) {
>   			kfree(nce_head);
>   			kfree(nce);
>   			return ret;
>   		}
>   	}
> -	list_add_tail(&nce->radix_list, nce_head);
> +	list_add_tail(&nce->inum_aliases, nce_head);
>   	list_add_tail(&nce->list, &sctx->name_cache_list);
>   	sctx->name_cache_size++;
>   

<snip>
