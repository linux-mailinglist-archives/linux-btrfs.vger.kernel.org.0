Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D844D73A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhKKNbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 08:31:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43878 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhKKNbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 08:31:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8232B1FD4D;
        Thu, 11 Nov 2021 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636637333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCmsrcyzD/3aVrKl6voMC+opedhx46WuKHEjmmDaKFY=;
        b=fjEs15rBilQlUXSVaTzuNa06LSXq9Mvk/zlIkFxZqpRzyYC9cNcEK97XvTt3KInU2BuC5b
        RExEIVbut23Oa8Er70TMP7ei5A/0Sg9rkFSbnVuDGerQ+7yTUzmBa2bOm3AC5yTLvg/qUe
        XIDkhSSqVscrvAbM1B/Sdwi+qapr8VQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43B9F13DB4;
        Thu, 11 Nov 2021 13:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m0kNDpUajWHTJwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 11 Nov 2021 13:28:53 +0000
Subject: Re: [PATCH v3 3/7] btrfs: check ticket->steal in
 steal_from_global_block_rsv
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
 <ac8ed2e738287a01338f8c0d502bfb46c18cc888.1636470628.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <382653b1-b38e-0eef-4bd1-0f5753e02031@suse.com>
Date:   Thu, 11 Nov 2021 15:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ac8ed2e738287a01338f8c0d502bfb46c18cc888.1636470628.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.21 г. 17:12, Josef Bacik wrote:
> We're going to use this helper in the priority flushing loop, move this
> check into the helper to simplify the logic.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/space-info.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 9a362f3a6df4..6498e79d4c9b 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -844,6 +844,9 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
>  	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
>  	u64 min_bytes;
>  
> +	if (!ticket->steal)
> +		return false;
> +
>  	if (global_rsv->space_info != space_info)
>  		return false;
>  
> @@ -899,8 +902,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
>  		ticket = list_first_entry(&space_info->tickets,
>  					  struct reserve_ticket, list);
>  
> -		if (!aborted && ticket->steal &&
> -		    steal_from_global_rsv(fs_info, space_info, ticket))
> +		if (!aborted && steal_from_global_rsv(fs_info, space_info,
> +						      ticket))
>  			return true;
>  
>  		if (!aborted && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> 
