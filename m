Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B43D0EE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhGUL43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 07:56:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhGUL42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 07:56:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60912222D0;
        Wed, 21 Jul 2021 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626871024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpCeaVUGRfWMwq3uGuiSn210HFr4CJs2jLZVwWklonM=;
        b=TnqRTDt7C0RdxTVOLsCe3vj1RD1OBuB9YVYTheuBwzXIlH4WwzMm836w7tNC5RygquT6tt
        6jIYPpeiViuB/yJE8kESHTly3H2yJVXmoLOmkQ7Rh5yPaXjL/uIEjBTvpNi7dorft3duwm
        sj0UOV4rqShPYU9mx4cr6L3LZU7rYHc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2CA2E13BE8;
        Wed, 21 Jul 2021 12:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mDDvB/AU+GDiewAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 21 Jul 2021 12:37:04 +0000
Subject: Re: [PATCH] btrfs: Use NULL in btrfs_search_slot as trans if we only
 want to search
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20210720180247.16802-1-mpdesouza@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <974764fb-d786-448c-4930-01bf52367db1@suse.com>
Date:   Wed, 21 Jul 2021 15:37:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720180247.16802-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.07.21 г. 21:02, Marcos Paulo de Souza wrote:
> Using a transaction in btrfs_search_slot is only useful when if are
> searching to add or modify the tree. When the function is only used for
> searching, insert length and mod arguments are 0, there is no need to
> use a transaction.
> 
> No functional changes, changing for consistency.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Basically when cow is 0 and ins_len is also 0 then no paths which
utilize a transaction are called so this patch is fine.


Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/backref.c     | 2 +-
>  fs/btrfs/extent-tree.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 7a8a2fc19533..0602c1cc7b62 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1211,7 +1211,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
>  again:
>  	head = NULL;
>  
> -	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
> +	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
>  	if (ret < 0)
>  		goto out;
>  	BUG_ON(ret == 0);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d296483d148f..d8d5fb9fb77a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -153,7 +153,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>  	else
>  		key.type = BTRFS_EXTENT_ITEM_KEY;
>  
> -	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
> +	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
>  	if (ret < 0)
>  		goto out_free;
>  
> 
