Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD08254DE76
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiFPJvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFPJvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 05:51:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA67C4EF75
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 02:51:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B11821C70;
        Thu, 16 Jun 2022 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655373111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wwldwYwee2IJgpfeozkivcDS6f7gJyiYBfEXoMmyhHI=;
        b=XL24cY4NwG3zw3HAuxowsA7mQ16CVv5il/gkWJQimxNa3Il9McUkBiXcuk/KqaAa7MRqOH
        IDCmrjduJbhbsbJ2dF1QdNCG95UnbxLhF/mZbXk0dPH2TWVJFThsdPIu6oJRH7oLPfauVa
        PO7bys/hYzHFKWFcAXIDdYl5TocDo+g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B26B13A70;
        Thu, 16 Jun 2022 09:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xjksBzf9qmL1UAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 16 Jun 2022 09:51:51 +0000
Message-ID: <a76b424b-86f5-3af7-73b0-fd22f5dc4854@suse.com>
Date:   Thu, 16 Jun 2022 12:51:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 9/9] btrfs: unify tree search helper returning prev and
 next nodes
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
 <62221b54b299b54442187a9675e9a9532b6e4cbd.1654706034.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <62221b54b299b54442187a9675e9a9532b6e4cbd.1654706034.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.06.22 г. 19:43 ч., David Sterba wrote:
> Simplify helper to return only next and prev pointers, we don't need all
> the node/parent/prev/next pointers of __etree_search as there are now
> other specialized helpers. Rename parameters so they follow the naming.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 113 ++++++++++++++++++++++---------------------
>   1 file changed, 57 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ae27b7a5e56c..48c5432a7c8f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -374,9 +374,7 @@ void free_extent_state(struct extent_state *state)
>    *
>    * @tree:       the tree to search
>    * @offset:     offset that should fall within an entry in @tree
> - * @next_ret:   pointer to the first entry whose range ends after @offset
> - * @prev_ret:   pointer to the first entry whose range begins before @offset
> - * @p_ret:      pointer where new node should be anchored (used when inserting an
> + * @node_ret:   pointer where new node should be anchored (used when inserting an
>    *	        entry in the tree)
>    * @parent_ret: points to entry which would have been the parent of the entry,
>    *               containing @offset
> @@ -386,69 +384,76 @@ void free_extent_state(struct extent_state *state)
>    * pointer arguments to the function are filled, otherwise the found entry is
>    * returned and other pointers are left untouched.
>    */

The comment should be changed as it's no longer valid. Currently it states:

If no such entry exists, then NULL is returned and the other
pointer arguments to the function are filled, otherwise the found entry 
is returned and other pointers are left untouched.

When no such entry exists, the other pointer arguments to the function 
are indeed filled, however the function now returns the first entry that 
ends _before_ the offset i.e this function can never return NULL.

So it return either the entry which contains 'offset' or the last entry 
before offset.

<snip>
