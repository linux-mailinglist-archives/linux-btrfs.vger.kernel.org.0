Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3E463D7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbhK3SSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 13:18:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245272AbhK3SRy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 13:17:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7EAD8212C6;
        Tue, 30 Nov 2021 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638296074;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EBusNqomOoBV134/OLjoeGLAEEG6t4aXmoIT1vJRl3I=;
        b=PTuxMKpQxL94gorunMrMHwTu8ml3U1sbJo04o1SsN/m4s+J3M+ApsmgBIeMTSKJBbsdXEm
        UAbEdrNvu0LOkIelwL5F/uN7+0ombwCQmpjxYsq6TwGsDOCah/qezNxC8XFRGfh9H9E17r
        mZ+v58oYVHu0mBSdf6VlrTKKcilL0/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638296074;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EBusNqomOoBV134/OLjoeGLAEEG6t4aXmoIT1vJRl3I=;
        b=rr/WOc+3gncHvBBG+JCEK/KPnLDYe6hnL5F5RN/7tyIFaysIKBYuTF5g3xou25BeGdQeMu
        5vLPbzvVXZmFWWCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7634BA3B88;
        Tue, 30 Nov 2021 18:14:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52CC6DA799; Tue, 30 Nov 2021 19:14:23 +0100 (CET)
Date:   Tue, 30 Nov 2021 19:14:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 04/22] btrfs-progs: add support for loading the block
 group root
Message-ID: <20211130181423.GL28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636144275.git.josef@toxicpanda.com>
 <2c32382719d5e8771b2db03cdf8c75d06ad1e3f8.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c32382719d5e8771b2db03cdf8c75d06ad1e3f8.1636144275.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 04:40:30PM -0400, Josef Bacik wrote:
> This adds the ability to load the block group root, as well as make sure
> the various backup super block and super block updates are made
> appropriately.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  kernel-shared/ctree.h       |   1 +
>  kernel-shared/disk-io.c     | 156 +++++++++++++++++++++++++++---------
>  kernel-shared/disk-io.h     |  10 ++-
>  kernel-shared/extent-tree.c |   8 +-
>  kernel-shared/transaction.c |   2 +
>  5 files changed, 135 insertions(+), 42 deletions(-)
> 
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index e54e03c4..27e31e03 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1195,6 +1195,7 @@ struct btrfs_fs_info {
>  	struct btrfs_root *dev_root;
>  	struct btrfs_root *quota_root;
>  	struct btrfs_root *uuid_root;
> +	struct btrfs_root *block_group_root;
>  
>  	struct rb_root global_roots_tree;
>  	struct rb_root fs_root_tree;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index bea42556..38741819 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -838,6 +838,9 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
>  		root = btrfs_global_root(fs_info, location);
>  		return root ? root : ERR_PTR(-ENOENT);
>  	}
> +	if (location->objectid == BTRFS_BLOCK_GROUP_TREE_OBJECTID)
> +		return fs_info->block_group_root ? fs_info->block_group_root :
> +						ERR_PTR(-ENOENT);
>  
>  	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
>  
> @@ -876,6 +879,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  	free(fs_info->chunk_root);
>  	free(fs_info->dev_root);
>  	free(fs_info->uuid_root);
> +	free(fs_info->block_group_root);
>  	free(fs_info->super_copy);
>  	free(fs_info->log_root_tree);
>  	free(fs_info);
> @@ -894,10 +898,12 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
>  	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
>  	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
>  	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
> +	fs_info->block_group_root = calloc(1, sizeof(struct btrfs_root));
>  	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
>  
>  	if (!fs_info->tree_root || !fs_info->chunk_root || !fs_info->dev_root ||
> -	    !fs_info->quota_root || !fs_info->uuid_root || !fs_info->super_copy)
> +	    !fs_info->quota_root || !fs_info->uuid_root ||
> +	    !fs_info->block_group_root || !fs_info->super_copy)
>  		goto free_all;
>  
>  	extent_io_tree_init(&fs_info->extent_cache);
> @@ -1016,7 +1022,7 @@ static int read_root_or_create_block(struct btrfs_fs_info *fs_info,
>  static inline bool maybe_load_block_groups(struct btrfs_fs_info *fs_info,
>  					   u64 flags)
>  {
> -	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
> +	struct btrfs_root *root = btrfs_block_group_root(fs_info);
>  
>  	if (flags & OPEN_CTREE_NO_BLOCK_GROUPS)
>  		return false;
> @@ -1027,7 +1033,6 @@ static inline bool maybe_load_block_groups(struct btrfs_fs_info *fs_info,
>  	return false;
>  }
>  
> -
>  static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
>  				      struct btrfs_path *path, u64 objectid,
>  				      unsigned flags, char *str)
> @@ -1125,39 +1130,94 @@ out:
>  	return ret;
>  }
>  
> -int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
> -			  unsigned flags)
> +static int load_important_roots(struct btrfs_fs_info *fs_info,
> +				u64 root_tree_bytenr, unsigned flags)
>  {
>  	struct btrfs_super_block *sb = fs_info->super_copy;
> +	struct btrfs_root_backup *backup = NULL;
>  	struct btrfs_root *root;
> -	struct btrfs_key key;
> -	u64 generation;
> +	u64 bytenr, gen;
> +	int index = -1;
>  	int ret;
>  
> -	root = fs_info->tree_root;
> -	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
> -	generation = btrfs_super_generation(sb);

I've got a conflict when applying this, there's a level for the root
also read and passed to read_root_node, while this patch does not expect
it. I think I haven't missed any patch that would drop the parameter,
all the preparatory v2 patches are in devel. Can you please refresh 4-22
and resend? Thanks.
