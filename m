Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A60469416
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhLFKsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 05:48:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39570 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhLFKsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 05:48:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC1E6122C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 10:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53132C341C2;
        Mon,  6 Dec 2021 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638787493;
        bh=8JlqtK8I7E7Ez3sVfjSwLeR2OhvR7ZnFGuHjgeRYzRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cv212q6gIUjJfCmzwekB8G3SOwbejjkKyLXtOu8FuPYmGZoTsMpCGZqgCrBVZ0DCP
         wmuGFJVMLyyZ2sFodZPyN7sIqm3rUMsLK5g62XtF5FOEVcwdrLri+x0er7Hn+QkTYQ
         grKhDnojHS9lkPFb6gkuzj8XdGFU+I+Vofkcbcglgb+cIsYrKneJtx+96YHxTXD0sV
         EF/N6q+s5mXUI0V22gUTtsOugMER8eCsdLwNh5W0/jHFAqe7PLS4gTf4Ruou61zNII
         cq83l+VQcvxQ6xXHOmVlLeIYRJoLQOfR0bN3sEAf5bJFqS/6Lfn/EC7TS3pXAhR5od
         4FL1ljTQOKpmw==
Date:   Mon, 6 Dec 2021 10:44:51 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: reserve extra space for the free space tree
Message-ID: <Ya3po87VEgtlwdwD@debian9.Home>
References: <cover.1638477127.git.josef@toxicpanda.com>
 <18b2ae0948a035aa809ba38641439e2d4167ca29.1638477127.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b2ae0948a035aa809ba38641439e2d4167ca29.1638477127.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 03:34:32PM -0500, Josef Bacik wrote:
> Filipe reported a problem where sometimes he'd get an ENOSPC abort when
> running delayed refs with generic/619 and the free space tree enabled.
> This is partly because we do not reserve space for modifying the free
> space tree, nor do we have a block rsv associated with that tree.
> 
> The delayed_refs_rsv tracks the amount of space required to run delayed
> refs.  This means 1 modification means 1 change to the extent root.
> With the free space tree this turns into 2 changes, because modifying 1
> extent means updating the extent tree and potentially updating the free
> space tree to either remove that entry or add the free space.  Thus if
> we have the FST enabled, simply double the reservation size for our
> modification.
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

Don't we need to bump the minimum (limit variable) number of bytes at
btrfs_delayed_refs_rsv_refill() as well?

I don't see why not.

Thanks.

> +
>  	spin_lock(&delayed_rsv->lock);
>  	delayed_rsv->size += num_bytes;
>  	delayed_rsv->full = 0;
> -- 
> 2.26.3
> 
