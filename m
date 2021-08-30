Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9883FB6B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhH3NG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:06:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40204 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhH3NGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:06:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7C5D20098;
        Mon, 30 Aug 2021 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630328729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RIt1yNLshfiRTur67cb7n8U2Tcc4DwogVJ9kzxqZjCY=;
        b=W29pBmKZj5fKP8F0ctdFL3ukP+7rrOzW1EdX2/PbKhhRm9afQWekfHfvvtsrqRBPtvkJYR
        utZ2hk8+sZ8qMgNnvZ0ZCJWtUUTEsT85hvz+hN7zG7MLNNWW/SnwLY/S/67FNEelRmmEXv
        rcechNjsufzYgwnuS0GDT8DslM4DQ+w=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 684BF13964;
        Mon, 30 Aug 2021 13:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +xGbFpnXLGEJbwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 13:05:29 +0000
Subject: Re: [PATCH 5/8] btrfs: inode: use btrfs_for_each_slot in
 btrfs_read_readdir
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
 <20210826164054.14993-6-mpdesouza@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f9647be1-25a9-e29b-4524-9b5ebf752567@suse.com>
Date:   Mon, 30 Aug 2021 16:05:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826164054.14993-6-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.21 г. 19:40, Marcos Paulo de Souza wrote:
> The function can be simplified by using the macro.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/inode.c | 46 +++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2aa9646bce56..12bee0107015 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6109,8 +6109,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
>  	struct list_head ins_list;
>  	struct list_head del_list;
>  	int ret;
> -	struct extent_buffer *leaf;
> -	int slot;
> +	int iter_ret;
>  	char *name_ptr;
>  	int name_len;
>  	int entries = 0;
> @@ -6137,35 +6136,19 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
>  	key.offset = ctx->pos;
>  	key.objectid = btrfs_ino(BTRFS_I(inode));
>  
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto err;
> -
> -	while (1) {
> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {

I don't think it's necessary to use iter_ret, instead you can use ret
directly. Because if either btrfs_search_slot return an error or
btrfs_valid_slot then ret would be set to the respective return value
and the body of the loop won't be executed at all, no?

>  		struct dir_entry *entry;
> +		struct extent_buffer *leaf = path->nodes[0];
>  
> -		leaf = path->nodes[0];
> -		slot = path->slots[0];
> -		if (slot >= btrfs_header_nritems(leaf)) {
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret < 0)
> -				goto err;
> -			else if (ret > 0)
> -				break;
> -			continue;
> -		}
> +		if (found_key.objectid != key.objectid ||
> +		    found_key.type != BTRFS_DIR_INDEX_KEY)
> +			break;
>  
> -		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		if (found_key.offset < ctx->pos ||
> +		    btrfs_should_delete_dir_index(&del_list, found_key.offset))
> +			continue;
>  
> -		if (found_key.objectid != key.objectid)
> -			break;
> -		if (found_key.type != BTRFS_DIR_INDEX_KEY)
> -			break;
> -		if (found_key.offset < ctx->pos)
> -			goto next;
> -		if (btrfs_should_delete_dir_index(&del_list, found_key.offset))
> -			goto next;
> -		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
> +		di = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
>  		name_len = btrfs_dir_name_len(leaf, di);
>  		if ((total_len + sizeof(struct dir_entry) + name_len) >=
>  		    PAGE_SIZE) {
> @@ -6192,9 +6175,14 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
>  		entries++;
>  		addr += sizeof(struct dir_entry) + name_len;
>  		total_len += sizeof(struct dir_entry) + name_len;
> -next:
> -		path->slots[0]++;
>  	}
> +
> +	/* Error found while searching. */
> +	if (iter_ret < 0) {
> +		ret = iter_ret;
> +		goto err;
> +	}
> +
>  	btrfs_release_path(path);
>  
>  	ret = btrfs_filldir(private->filldir_buf, entries, ctx);
> 
