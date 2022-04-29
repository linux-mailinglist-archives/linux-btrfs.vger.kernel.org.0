Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F2514C87
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbiD2ORh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiD2ORg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:17:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537F456C2D
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:14:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D921F21878;
        Fri, 29 Apr 2022 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651241656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8V3PWEBC3Naul0/t1GMbLIIv5kmS4bWb6ga8t/jJ7A=;
        b=RYjDoZLc8AXFaDuGOP6o6dsAoOGhARBTbyhke8vjAp0oWDb5anXf+qdlS80Nj4Eup26Pbp
        JpkkyNXlRZVFlrYtPLSxntVSWZ26nNJZAEELxTAWMeD4TiFOxmrHQxmAf2O2vVAfL3W9sg
        m8HcymC1SpmlC7iyan0L6V4J5FSg32Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D07D13AE0;
        Fri, 29 Apr 2022 14:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hfACI7jya2KnEAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 29 Apr 2022 14:14:16 +0000
Message-ID: <8fa5a2af-7335-108b-9ce3-a45270331b4a@suse.com>
Date:   Fri, 29 Apr 2022 17:14:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] btrfs: Turn fs_info member buffer_radix into XArray
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220421154538.413-1-gniebler@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220421154538.413-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.04.22 г. 18:45 ч., Gabriel Niebler wrote:
> … named 'extent_buffers'. Also adjust all usages of this object to use the
> XArray API, which greatly simplifies the code as it takes care of locking
> and is generally easier to use and understand, providing notionally
> simpler array semantics.
> 
> Also perform some light refactoring.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
> 
> Changes from v1:
>   - Fixed first line of commit message
> 

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

One minor suggestion below though.

<snip>

> @@ -6313,10 +6306,8 @@ static int release_extent_buffer(struct extent_buffer *eb)
>   
>   			spin_unlock(&eb->refs_lock);
>   
> -			spin_lock(&fs_info->buffer_lock);
> -			radix_tree_delete(&fs_info->buffer_radix,
> -					  eb->start >> fs_info->sectorsize_bits);
> -			spin_unlock(&fs_info->buffer_lock);
> +			xa_erase(&fs_info->extent_buffers,
> +				 eb->start >> fs_info->sectorsize_bits);
>   		} else {
>   			spin_unlock(&eb->refs_lock);
>   		}
> @@ -7249,41 +7240,28 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
>   	}
>   }
>   
> -#define GANG_LOOKUP_SIZE	16
>   static struct extent_buffer *get_next_extent_buffer(
>   		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
>   {
> -	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> +	struct extent_buffer *eb;
>   	struct extent_buffer *found = NULL;
> +	unsigned long index;
>   	u64 page_start = page_offset(page);
> -	u64 cur = page_start;
>   
>   	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
>   	lockdep_assert_held(&fs_info->buffer_lock);
>   
> -	while (cur < page_start + PAGE_SIZE) {
> -		int ret;
> -		int i;
> -
> -		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> -				(void **)gang, cur >> fs_info->sectorsize_bits,
> -				min_t(unsigned int, GANG_LOOKUP_SIZE,
> -				      PAGE_SIZE / fs_info->nodesize));
> -		if (ret == 0)
> -			goto out;
> -		for (i = 0; i < ret; i++) {
> -			/* Already beyond page end */
> -			if (gang[i]->start >= page_start + PAGE_SIZE)
> -				goto out;
> +	xa_for_each_start(&fs_info->extent_buffers, index, eb,
> +			  page_start >> fs_info->sectorsize_bits) {
> +		if (eb->start >= page_start + PAGE_SIZE)
> +		        /* Already beyond page end */
> +			break;
> +		if (eb->start >= bytenr) {
>   			/* Found one */
> -			if (gang[i]->start >= bytenr) {
> -				found = gang[i];
> -				goto out;
> -			}
> +			found = eb;
> +			break; >   		}
> -		cur = gang[ret - 1]->start + gang[ret - 1]->len;
>   	}

nit: The body of the loop can be turned into:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da3d9dc186cd..7c1d5fec59dd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -7318,16 +7318,13 @@ static struct extent_buffer *get_next_extent_buffer(

         xa_for_each_start(&fs_info->extent_buffers, index, eb,
                           page_start >> fs_info->sectorsize_bits) {
-               if (eb->start >= page_start + PAGE_SIZE)
+               if (in_range(eb->start, page_start, PAGE_SIZE))
+                       return eb;
+               else if (eb->start >= page_start + PAGE_SIZE)
                         /* Already beyond page end */
-                       break;
-               if (eb->start >= bytenr) {
-                       /* Found one */
-                       found = eb;
-                       break;
-               }
+                       return NULL;
         }
-       return found;
+       return NULL;
  }


That is use the in_range macro to detect when we have an eb between 
page_start and page_start + PAGE_SIZE in which case we can directly 
return it, and the in_range is self-documenting. And directly return 
NULL in case of eb->start going beyond the current page and in case we 
didn't find anything.  David, what do you think?

> -out:
>   	return found;
>   }
>   

<snip>
