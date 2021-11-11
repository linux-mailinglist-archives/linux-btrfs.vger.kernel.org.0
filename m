Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFE44D70B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhKKNRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 08:17:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33510 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKNRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 08:17:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE13221B38;
        Thu, 11 Nov 2021 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636636461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1aZrs78i90hAEl3tu0m+jLSdxwXFteHISd54HfG/KEo=;
        b=tN1RaKBJTZLas5ythHqCY41A+9enWAqTRmV1mcoS/KpPtTaRSob6krS6N2SD++7kalcJgh
        wDsuUNFsf4OeCuvoQtLvymTtG7iaC5/ca+VxVinWKXtmhkUUewTa4U7aIAjorTEkGLTltf
        2vwIA6Ww2Ob+QExubow5FtAzeLxavck=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C33413DB4;
        Thu, 11 Nov 2021 13:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tE9AFy0XjWHSGwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 11 Nov 2021 13:14:21 +0000
Subject: Re: [PATCH v3 2/7] btrfs: check for priority ticket granting before
 flushing
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
 <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f0f97d68-cf01-515b-f787-3ccb924ff9ad@suse.com>
Date:   Thu, 11 Nov 2021 15:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.21 г. 17:12, Josef Bacik wrote:
> Since we're dropping locks before we enter the priority flushing loops
> we could have had our ticket granted before we got the space_info->lock.
> So add this check to avoid doing some extra flushing in the priority
> flushing cases.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> --->  fs/btrfs/space-info.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 9d6048f54097..9a362f3a6df4 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1264,7 +1264,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
>  
>  	spin_lock(&space_info->lock);
>  	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
> -	if (!to_reclaim) {
> +	if (!to_reclaim || ticket->bytes == 0) {

nit: This is purely an optimization, handling the case where a prio
ticket N is being added to the list, but at the same time we might have
had ticket N-1 just satisfied (or failed) and having called
try_granting_ticket might have satisfied concurrently added ticket N,
right? And this is a completely independent change of the other cleanups
being done here?

>  		spin_unlock(&space_info->lock);
>  		return;
>  	}
> @@ -1297,6 +1297,13 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
>  					struct reserve_ticket *ticket)
>  {
>  	spin_lock(&space_info->lock);
> +
> +	/* We could have been granted before we got here. */
> +	if (ticket->bytes == 0) {
> +		spin_unlock(&space_info->lock);
> +		return;
> +	}
> +
>  	while (!space_info->full) {
>  		spin_unlock(&space_info->lock);
>  		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
> 
