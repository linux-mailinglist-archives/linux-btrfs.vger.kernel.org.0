Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44970445354
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 13:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhKDMyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 08:54:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDMyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 08:54:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A885D218B2;
        Thu,  4 Nov 2021 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636030332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tym3t4d4To8xvGTfSyg5l6WxlRY4KfWpSMrmMu/yBQI=;
        b=Mwoax24UGboe1npJ7lyIa6ohsNGOvU50x9j5w7fGtl9gPypfTNFty+/ygK4OZn9EIrfKyS
        SLZOrxeQA9ShnX0fJweLZj6yoX3/XhQuFEI3AY1V2znJ7pkDwb1xg6E4yceQ4eG04jgZRV
        u5Y7VNfF1tRWO/DZ4+48UBDcddZfgEY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B46813BD4;
        Thu,  4 Nov 2021 12:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /+5dE3zXg2ENGQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 12:52:12 +0000
Subject: Re: [PATCH 1/4] btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global
 rsv stealing code
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1635450288.git.josef@toxicpanda.com>
 <81163a975df807763a5526e2aaa7bf8248e8d981.1635450288.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <93813df7-19b5-c11b-9050-06cfcaccd947@suse.com>
Date:   Thu, 4 Nov 2021 14:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <81163a975df807763a5526e2aaa7bf8248e8d981.1635450288.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.21 г. 22:50, Josef Bacik wrote:
> I forgot to convert this over when I introduced the global reserve
> stealing code to the space flushing code.  Evict was simply trying to
> make its reservation and then if it failed it would steal from the
> global rsv, which is racey because it's outside of the normal ticketing
> code.
> 
> Fix this by setting ticket->steal if we are BTRFS_RESERVE_FLUSH_EVICT,
> and then make the priority flushing path do the steal for us.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/inode.c      | 15 ++++++---------
>  fs/btrfs/space-info.c | 24 +++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 10 deletions(-)
> 

<snip>

> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 48d77f360a24..c548d34aed28 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1380,6 +1380,22 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  
>  	spin_lock(&space_info->lock);
>  	ret = ticket->error;
> +
> +	/*
> +	 * If we can steal from the block rsv and we don't have an error and we
> +	 * didn't make our reservation then go ahead and try to steal our
> +	 * reservation.
> +	 */
> +	if (ticket->steal && !ret && ticket->bytes) {
> +		/*
> +		 * If we succeed we need to run btrfs_try_granting_tickets() for
> +		 * the same reason as described below.
> +		 */
> +		if (steal_from_global_rsv(fs_info, space_info, ticket))
> +			btrfs_try_granting_tickets(fs_info, space_info);
> +	}

Instead of having this code here, wouldn't it be better if it's moved in
priority_reclaim_metadata_space since this behavior is really part of
the flushing behavior, similarly to how maybe_fail_all_tickets is called
from the ordinary reclaim path? Actually reading the comment about
calling btrfs_try_granting_tickets makes me think that the !list_empty()
condition should also be moved in priority_reclaim_metadata_space as
those behaviors only pertain to priority tickets, since ordinary ticket
will either have been satisfied or failed due to maybe_fail_all_tickets
always removing ordinary tickets from the ticket list hence the
list_empty() will always be true for them.


If I have to be even more nit-picky the priority flushing path is
priority_reclaim_metadata_space and not handle_reserve_ticket itself. So
the code is slightly contradicting the last sentence in the changelog :)


> +
> +
>  	if (ticket->bytes || ticket->error) {
>  		/*
>  		 * We were a priority ticket, so we need to delete ourselves
> @@ -1438,6 +1454,12 @@ static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
>  		space_info->clamp = min(space_info->clamp + 1, 8);
>  }
>  
> +static inline bool is_steal_flush_state(enum btrfs_reserve_flush_enum flush)

nint: A better name is should_stable or can_steal

> +{
> +	return (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
> +		flush == BTRFS_RESERVE_FLUSH_EVICT);
> +}

<snip>
