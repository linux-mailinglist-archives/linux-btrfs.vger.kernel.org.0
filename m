Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6390F3EE8AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhHQIjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 04:39:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42612 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhHQIjs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 04:39:48 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA6FE2000D;
        Tue, 17 Aug 2021 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629189554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4+BXvcJwhNJGyHLeoqq9a3o7Vbp3Zi/1k1ewNwlJLg=;
        b=qV/OORdC4AuhNwQFSgNpYcYaSnHiqz6GFZO5L17GBzucVfw9P8ObSOy0bihQb0+bKHd8M7
        d1M4Bx/UalupXKLTw1Fz/gpvb8aXg9GZhwfa/PQoWMgbrL66nLoWLlnbprdd4UoVC7hNGa
        4iNSApytrUvXe8RFK792e3SnJxBaJfQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7368413277;
        Tue, 17 Aug 2021 08:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0EECGbJ1G2EiewAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 17 Aug 2021 08:39:14 +0000
Subject: Re: [PATCH 2/2] btrfs: do not do preemptive flushing if the majority
 is global rsv
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1628706812.git.josef@toxicpanda.com>
 <faca8afcd0564108b1f2fd60c4a24dacc4aa6107.1628706812.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8ee398b7-42b1-fa65-b4e5-a0cdfb115580@suse.com>
Date:   Tue, 17 Aug 2021 11:39:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <faca8afcd0564108b1f2fd60c4a24dacc4aa6107.1628706812.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.08.21 г. 21:37, Josef Bacik wrote:
> A common characteristic of the bug report where preemptive flushing was
> going full tilt was the fact that the vast majority of the free metadata
> space was used up by the global reserve.  The hard 90% threshold would
> cover the majority of these cases, but to be even smarter we should take
> into account how much of the outstanding reservations are covered by the
> global block reserve.  If the global block reserve accounts for the vast
> majority of outstanding reservations, skip preemptive flushing, as it
> will likely just cause churn and pain.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212185
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index ddb4878e94df..2fce15d58b55 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -741,6 +741,20 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>  	     global_rsv_size) >= thresh)
>  		return false;
>  
> +	used = space_info->bytes_may_use + space_info->bytes_pinned;

But global_rsv_size is accounted entirely in bytes_may_use (per
btrfs_update_global_block_rsv logic), so why add bytes_pinned?

> +
> +	/* The total reservation belongs to the global rsv, don't flush. */
> +	if (global_rsv_size >= used)
> +		return false;
> +
> +	/*
> +	 * 128m is 1/4 of the maximum global rsv size.  If we have less than
> +	 * that devoted to other reservations then there's no sense in flushing,
> +	 * we don't have a lot of things that need flushing.
> +	 */
> +	if ((used - global_rsv_size) <= SZ_128M)
> +		return false;
> +
>  	/*
>  	 * We have tickets queued, bail so we don't compete with the async
>  	 * flushers.
> 
