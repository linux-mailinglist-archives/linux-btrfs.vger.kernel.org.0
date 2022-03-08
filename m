Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C04D1AAE
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 15:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbiCHOiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347610AbiCHOiI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 09:38:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367724BBB1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 06:37:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E334A210F4;
        Tue,  8 Mar 2022 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646750229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJAUFaRi7krgO5l2rF5/EJgG5wPy/nhcuQhzSvpY7Go=;
        b=lZlDuQoQh9H0OmesWJP4U7m0kI4bLzgczGhUWlPYKpjvaWKk9IZJHjRr/62RfumEaHIKbT
        Ga7uY3uu7cdhuFtMHJQvKuI+/MGD42+vftk2NRaausMUPynlwgnrazAkmmMb1a5OinR/8H
        +AuPDovdUwtazutkcutkZrw67B//CB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646750229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJAUFaRi7krgO5l2rF5/EJgG5wPy/nhcuQhzSvpY7Go=;
        b=WeDl/TMv6YfN3K1Q+S766gdNxXx5DbD8PKhTLTqxJB2sf1ev1rPd/QnerEZe7L2BF7014F
        1JV59qGxdDTOcOBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DC6B5A3B84;
        Tue,  8 Mar 2022 14:37:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC7BFDA823; Tue,  8 Mar 2022 15:33:14 +0100 (CET)
Date:   Tue, 8 Mar 2022 15:33:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v3 03/14] btrfs: Use btrfs_for_each_slot in
 mark_block_group_to_copy
Message-ID: <20220308143314.GM12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20220302164829.17524-1-gniebler@suse.com>
 <20220302164829.17524-4-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302164829.17524-4-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 05:48:18PM +0100, Gabriel Niebler wrote:
> This function can be simplified by refactoring to use the new iterator macro.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>  fs/btrfs/dev-replace.c | 41 ++++++++---------------------------------
>  1 file changed, 8 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 62b9651ea662..3357739f427f 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -470,6 +470,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
>  	struct btrfs_dev_extent *dev_extent = NULL;
>  	struct btrfs_block_group *cache;
>  	struct btrfs_trans_handle *trans;
> +	int iter_ret = 0;
>  	int ret = 0;
>  	u64 chunk_offset;
>  
> @@ -520,29 +521,8 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
>  	key.type = BTRFS_DEV_EXTENT_KEY;
>  	key.offset = 0;
>  
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto free_path;
> -	if (ret > 0) {
> -		if (path->slots[0] >=
> -		    btrfs_header_nritems(path->nodes[0])) {
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret < 0)
> -				goto free_path;
> -			if (ret > 0) {
> -				ret = 0;
> -				goto free_path;
> -			}
> -		} else {
> -			ret = 0;
> -		}
> -	}
> -
> -	while (1) {
> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
>  		struct extent_buffer *leaf = path->nodes[0];
> -		int slot = path->slots[0];
> -
> -		btrfs_item_key_to_cpu(leaf, &found_key, slot);
>  
>  		if (found_key.objectid != src_dev->devid)
>  			break;
> @@ -553,30 +533,25 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
>  		if (found_key.offset < key.offset)
>  			break;
>  
> -		dev_extent = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
> +		dev_extent = btrfs_item_ptr(leaf, path->slots[0],
> +					    struct btrfs_dev_extent);
>  
>  		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dev_extent);
>  
>  		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
>  		if (!cache)
> -			goto skip;
> +			continue;
>  
>  		spin_lock(&cache->lock);
>  		cache->to_copy = 1;
>  		spin_unlock(&cache->lock);
>  
>  		btrfs_put_block_group(cache);
> -
> -skip:
> -		ret = btrfs_next_item(root, path);
> -		if (ret != 0) {
> -			if (ret > 0)
> -				ret = 0;
> -			break;
> -		}
> +	}
> +	if (iter_ret < 0) {
> +		ret = iter_ret;
>  	}

No { } around single statement conditions 'if'
