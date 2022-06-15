Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDE54CB08
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiFOORS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 10:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiFOORR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 10:17:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF136312
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 07:17:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 876921F461;
        Wed, 15 Jun 2022 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655302634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy7quK+tBYD/iQegBP/KirF7vtFo/LjMZhrmGJBFnEE=;
        b=RyWYmzSTAEsj8eF9uioshYiRAhFoGCKnOILfPajPzw0ORbLPXVXJlOsIlUNVBcO5V6JYS8
        rjrRleaW/eWADTdRyP+sfjiBJ1x2iWOCT63L1fTG/BlmpOiuLKQxYJQsWQiFbd5+scwRI9
        W/sOYWuJ6DAg8WzvtKWqIDEcvug1QRE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EB14139F3;
        Wed, 15 Jun 2022 14:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9HhVFOrpqWLyOQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Jun 2022 14:17:14 +0000
Message-ID: <3cb455cd-cf0f-1fc5-7e9f-cf60ba245989@suse.com>
Date:   Wed, 15 Jun 2022 17:17:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/9] btrfs: lift start and end parameters to callers of
 insert_state
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
 <1be84acd258f46425c4162fe3b34173be2512c20.1654706034.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <1be84acd258f46425c4162fe3b34173be2512c20.1654706034.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.06.22 г. 19:43 ч., David Sterba wrote:
> Let callers of insert_state to set up the extent state to allow further
> simplifications of the parameters.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 429096fc8899..1411286e5ef2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -524,21 +524,14 @@ static void set_state_bits(struct extent_io_tree *tree,
>    * probably isn't what you want to call (see set/clear_extent_bit).
>    */
>   static int insert_state(struct extent_io_tree *tree,
> -			struct extent_state *state, u64 start, u64 end,
> +			struct extent_state *state,
>   			struct rb_node ***node_in,
>   			struct rb_node **parent_in,
>   			u32 *bits, struct extent_changeset *changeset)
>   {
>   	struct rb_node **node;
>   	struct rb_node *parent;
> -
> -	if (end < start) {
> -		btrfs_err(tree->fs_info,
> -			"insert state: end < start %llu %llu", end, start);
> -		WARN_ON(1);
> -	}
> -	state->start = start;
> -	state->end = end;
> +	const u64 end = state->end;

Why do you need an explicit end when it's only used in the while loop 
and any possible changes actually come afterwards in case it's merged?

<snip>
