Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8AB3D3490
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 08:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhGWFjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 01:39:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhGWFje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 01:39:34 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CBEF1FF54;
        Fri, 23 Jul 2021 06:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627021208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWDYSgAGDWELRmdRjEftbc+QlXGViGgBmdplMXvhHx4=;
        b=JgoI11yUfM8e/GzKHUUDkhS1ljndJijrzHfM6SWfPfUEZzB/pbtkW2thjGKzrNDAcAiXtA
        BrSsok6oRAVBGxbyTqAstoZdG4rRnPkKTZkpUz9ZMc4/MwJHDVYwjShdfyFp5BBbcwg5Uo
        XA5yKs9/ULcGXdlUm0DJ0XObd88l4e4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DAAA3136DD;
        Fri, 23 Jul 2021 06:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cifsMpdf+mCNMAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 23 Jul 2021 06:20:07 +0000
Subject: Re: [PATCH 3/4] btrfs: remove unnecessary list head initialization
 when syncing log
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1626791500.git.fdmanana@suse.com>
 <589f5a66b472b93df01e5e798acd5123b5582769.1626791500.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a3595186-bab3-73d9-003e-cc1d58ce38d5@suse.com>
Date:   Fri, 23 Jul 2021 09:20:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <589f5a66b472b93df01e5e798acd5123b5582769.1626791500.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.07.21 г. 18:03, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> One of the last steps of syncing the log is to remove all log contextes
> from the root's list of contextes, done at btrfs_remove_all_log_ctxs().
> There we iterate over all the contextes in the list and delete each one
> from the list, and after that we call INIT_LIST_HEAD() on the list. That
> is unnecessary since at that point the list is empty.
> 
> So just remove the INIT_LIST_HEAD() call. It's not needed, increases code
nit: I assume you mean decreases code size
> size (bloat-o-meter reported a delta of -122 for btrfs_sync_log() after
> this change) and increases two critical sections delimited by log mutexes.

nit: Here you also mean decreases two critsecs

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 90fb5a2fc60b..63f48715135c 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3039,8 +3039,6 @@ static inline void btrfs_remove_all_log_ctxs(struct btrfs_root *root,
>  		list_del_init(&ctx->list);
>  		ctx->log_ret = error;
>  	}
> -
> -	INIT_LIST_HEAD(&root->log_ctxs[index]);
>  }
>  
>  /*
> 
