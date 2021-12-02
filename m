Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF54664F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbhLBOSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 09:18:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39566 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhLBOSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 09:18:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02B54212BA;
        Thu,  2 Dec 2021 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638454492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=580Etm9XWbPi0GmJJf/HEedPtXytgZyCXptiyqMPJa0=;
        b=pW5PONQwtX2z/jl1rlyY9BD/hjVJztGMZSQYyNtXRbgR5k4CLLV1unUy8HZyFnhhkwb9aa
        1pL4LQpA0olTqS9rTQ3vz3AP/czcAGy0h/yYvpOf+W067gc6BzWxsWmqFNQBEjldTnIqxH
        m8cxwkfFr/ZKwxEbmqs+/8ADIUGK33k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B26DC13BB2;
        Thu,  2 Dec 2021 14:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GM9GJ9vUqGGoXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 02 Dec 2021 14:14:51 +0000
Subject: Re: [PATCH 2/2] btrfs: reserve extra space for the free space tree
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1638377089.git.josef@toxicpanda.com>
 <aab24f138d49b8d331a359b66029bb61f12fd44c.1638377089.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <5ae9a490-e439-9e2d-bf6e-47ee7d5bceed@suse.com>
Date:   Thu, 2 Dec 2021 16:14:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <aab24f138d49b8d331a359b66029bb61f12fd44c.1638377089.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.12.21 г. 18:45, Josef Bacik wrote:
> Filipe reported a problem where sometimes he'd get an ENOSPC abort when
> running delayed refs with generic/619 and the free space tree enabled.
> This is partly because we do not reserve space for modifying the free
> space tree, nor do we have a block rsv associated with that tree.  Fix
> this by making sure any free space tree defaults to using the
> delayed_refs_rsv, and make sure we reserve the space for those
> allocations.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-rsv.c   |  1 +
>  fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index b3086f252ad0..b3ee49b0b1e8 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -426,6 +426,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
>  	switch (root->root_key.objectid) {
>  	case BTRFS_CSUM_TREE_OBJECTID:
>  	case BTRFS_EXTENT_TREE_OBJECTID:
> +	case BTRFS_FREE_SPACE_TREE_OBJECTID:
>  		root->block_rsv = &fs_info->delayed_refs_rsv;
>  		break;
>  	case BTRFS_ROOT_TREE_OBJECTID:
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index da9d20813147..533521be8fdf 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -84,6 +84,17 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
>  	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
>  	u64 released = 0;
>  
> +	/*
> +	 * We have to check the mount option here because we could be enabling
> +	 * the free space tree for the first time and don't have the compat_ro
> +	 * option set yet.
> +	 *
> +	 * We need extra reservations if we have the free space tree because
> +	 * we'll have to modify that tree as well.
> +	 */
> +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
> +		num_bytes <<= 1;
> +
>  	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
>  	if (released)
>  		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
> @@ -108,6 +119,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
>  
>  	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
>  						    trans->delayed_ref_updates);
> +	/*
> +	 * We have to check the mount option here because we could be enabling
> +	 * the free space tree for the first time and don't have the compat_ro
> +	 * option set yet.
> +	 *
> +	 * We need extra reservations if we have the free space tree because
> +	 * we'll have to modify that tree as well.
> +	 */
> +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
> +		num_bytes <<= 1;

That num_bytes * 2 is heuristically derived, right? If so I'd like this
to be mentioned explicitly in the changelog.

> +
>  	spin_lock(&delayed_rsv->lock);
>  	delayed_rsv->size += num_bytes;
>  	delayed_rsv->full = 0;
> 
