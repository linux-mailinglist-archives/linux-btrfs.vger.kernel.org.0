Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBA3D71CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhG0JSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 05:18:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52270 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhG0JSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 05:18:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E58B1FEF9;
        Tue, 27 Jul 2021 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627377527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hctfnB4M93UJAJenWtSG7hzfL8itWVgscS2sVNkdsmE=;
        b=sqVhhT2AshTVisjJ6uzLlP7MnoD7edXv8wjLZAzPqzx4Vf8qx08XQ5faM4zVvQwz3tJMg9
        4aXo/CazB7fZZznvhxALx1sM3KaqS2KPNpkNgIJnYjK9z1paF9Oziy58q5yUtD1WDzYkKd
        F0dsPmgAmGvwlJqr7IUjzQmyWFOqoOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627377527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hctfnB4M93UJAJenWtSG7hzfL8itWVgscS2sVNkdsmE=;
        b=JQfJUJ/sKvh1sChhF2MGr4pE5MqDRS2YAWQm7NgyM5eWXr385lnalOdXe3Y6laqqMWtBIE
        DZf/FDj1wvoQFvCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 47D91A3B81;
        Tue, 27 Jul 2021 09:18:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E828DDA8CC; Tue, 27 Jul 2021 11:16:02 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:16:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: file-item: Remove unneeded variable
Message-ID: <20210727091602.GN5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210726185107.6842-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726185107.6842-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 03:51:07PM -0300, Marcos Paulo de Souza wrote:
> We can return from btrfs_search_slot directly.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/file-item.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index df6631eefc65..99ca5724ac6f 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -233,7 +233,6 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>  			     struct btrfs_path *path, u64 objectid,
>  			     u64 offset, int mod)
>  {
> -	int ret;
>  	struct btrfs_key file_key;
>  	int ins_len = mod < 0 ? -1 : 0;
>  	int cow = mod != 0;
> @@ -241,8 +240,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>  	file_key.objectid = objectid;
>  	file_key.offset = offset;
>  	file_key.type = BTRFS_EXTENT_DATA_KEY;
> -	ret = btrfs_search_slot(trans, root, &file_key, path, ins_len, cow);
> -	return ret;
> +	return btrfs_search_slot(trans, root, &file_key, path, ins_len, cow);

Here it makes sense to do the return as it means the return value
convention of btrfs_search_slot also applies. I've updated changelog and
subject to reflect this. Added to misc-next, thanks.
