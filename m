Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07010454B93
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhKQRH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 12:07:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51364 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhKQRHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 12:07:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F977212C1;
        Wed, 17 Nov 2021 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637168666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKWvuO4shXMF+kICQ2dUc/prrvy4U/KUCqbg/6xqHJ8=;
        b=cfMB8qprxGc4ow75m86FbV2vn80L08O6vcYfHMiteRHADXpLG8ulqXvoxKKsu98RIJt6kc
        SHrGDG7DWCGZnbePXQBaIhVBFP9n9Oj4ZjWN0DQcOoLs/BSJeyrJDhN7HowXFWvGvwxqgr
        33D10yuQdsYEgQ7njWfR2b/aA1oS3sc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6ACB13AB7;
        Wed, 17 Nov 2021 17:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jKcoNRk2lWEbNwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 17 Nov 2021 17:04:25 +0000
Subject: Re: [PATCH v3 2/7] btrfs: check for priority ticket granting before
 flushing
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, David Sterba <dsterba@suse.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
 <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6d27ae92-b7a7-4882-e121-10e524da346a@suse.com>
Date:   Wed, 17 Nov 2021 19:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
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
> ---
>  fs/btrfs/space-info.c | 9 ++++++++-
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
David,

After speaking with josef it would seem the !to_reclaim condition is
gratuitous so can be removed, care to squash this in the patch?

<snip>
