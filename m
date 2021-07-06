Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4D3BD431
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 14:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhGFMF0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 08:05:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39858 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbhGFMCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jul 2021 08:02:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D073C226C2;
        Tue,  6 Jul 2021 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625570484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L74OCUu5QCOpbhuIgVTkQP122e7zq/akVJMeTUm00fg=;
        b=FNNyPd3DWVXQ/59RLeryp4SFFT5ffjdNdIYfQ0pxoOawO+Ttctz2LlGqe8wxzIFZdqM70t
        +LaZWyUidFoRJF535VlK085c6XVAfa1ocsr25xRPERhr5WJb32Ew8aJhv7Pg1TJi63ioIX
        j0kBgehhklb4b4cLCGXz2E7JQCJrOlQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 937601372D;
        Tue,  6 Jul 2021 11:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EmVRILQ85GDddAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 06 Jul 2021 11:21:24 +0000
Subject: Re: [PATCH] btrfs: don't block if we can't acquire the reclaim lock
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <8fc77aa7ffbc61e7e55d57e8cfc7423642558b17.1625500974.git.johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d4665043-9d56-3616-1294-58a288936723@suse.com>
Date:   Tue, 6 Jul 2021 14:21:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8fc77aa7ffbc61e7e55d57e8cfc7423642558b17.1625500974.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.07.21 г. 19:32, Johannes Thumshirn wrote:
> If we can acquire the reclaim_bgs_lock in on block group reclaim, we block
nit: s/can/can't/ , also remove 'in' ?
> until it is free. This can potentially stall for a long time.
> 
> While reclaim of block groups is necessary for a good user experience on a
> zoned file system, there still is no need to block as it is best effort
> only, just like when we're deleting unused block groups.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c557327b4545..9e7d9d0c763d 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1498,7 +1498,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
>  		return;
>  
> -	mutex_lock(&fs_info->reclaim_bgs_lock);
> +	/*
> +	 * Long running balances can keep us blocked here for eternity, so
> +	 * simply skip reclaim if we're unable to get the mutex.
> +	 */
> +	if (!mutex_trylock(&fs_info->reclaim_bgs_lock)) {
> +		btrfs_exclop_finish(fs_info);
> +		return;
> +	}
> +
>  	spin_lock(&fs_info->unused_bgs_lock);
>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>  		u64 zone_unusable;
> 
